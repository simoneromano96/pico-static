import picoev
import picohttpparser
import os

fn callback(req picohttpparser.Request, mut res picohttpparser.Response) {
	if picohttpparser.cmpn(req.method, 'GET ', 4) {
		path := "/workspaces/pico-static/public" + req.path
		println(path)

    data := os.read_file(path) or {
      println("Cannot find file $path")
			res.http_404()
      return
    }

		println(data)
	
		res.http_ok()
		res.header_server()
		res.header_date()
		res.html()
		res.body(data)
	} else {
		res.http_405()
	}
}

fn main() {
	println('Starting webserver on http://127.0.0.1:8088/ ...')
	picoev.new(8088, &callback).serve()
}
