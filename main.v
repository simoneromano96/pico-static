import picoev
import picohttpparser
import os
import mimedb

const (
	public_path = getenv("PUBLIC_PATH")
	server_port = getenv("SERVER_PORT")
	file_extension_mime_type_map = map{
		"html": "text/html"
		"htm": "text/html"
		"js": "application/javascript"
		"css": "text/css"
	}
)

fn file_path_to_file_extension(file_path string) ?string {
	println(file_path)
	index := file_path.last_index(".") or {
		println("Could not find a `.` symbol")
		return none
	}
	println(index)
	return file_path.substr(index + 1, file_path.len)
}

fn file_extension_to_mime_type(file_extension string) string {
	println(file_extension)
	mime_type := file_extension_mime_type_map[file_extension] or { 
		println("Could not find the mime type")
		"application/octet-stream"
	}
	println(mime_type)
	return mime_type
}

fn handler(req picohttpparser.Request, mut res picohttpparser.Response) {
	if picohttpparser.cmpn(req.method, 'GET ', 4) {
		mut file_path := public_path
		if req.path == "" || req.path == "/" || req.path == "/index" {
			file_path += "/index.html"
		} else {
			file_path += req.path
		}
		println(file_path)

    data := os.read_file(file_path) or {
      println("Cannot find file $file_path")
			res.http_404()
      return
    }

		println(data)

		file_extension := file_path_to_file_extension(file_path) or { "" }
		println(file_extension)
		mime_type := file_extension_to_mime_type(file_extension)
		println(mime_type)

		res.http_ok()
		res.header_server()
		res.header_date()
		res.content_type(mime_type)
		res.body(data)
	} else {
		res.http_405()
	}
}

fn main() {
	println(mimedb.db)
	port := server_port.int()
	println('Starting webserver on http://127.0.0.1:$port/ ...')
	picoev.new(port, &handler).serve()
}
