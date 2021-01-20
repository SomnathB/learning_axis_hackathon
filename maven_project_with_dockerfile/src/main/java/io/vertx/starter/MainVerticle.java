package io.vertx.starter;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.http.HttpHeaders;

import java.text.MessageFormat;
import java.util.Map;

/**
 * Sample verticle to dump environment variables with the Hello text.
 */
public class MainVerticle extends AbstractVerticle {

    @Override
    public void start() {
        Map<String, String> environmentVars = System.getenv();
        int port = 8080;
        if (System.getenv("PORT") != null)
            port = Integer.parseInt(System.getenv("PORT"));
        final int finalPort = port;
        vertx.createHttpServer()
                .requestHandler(req -> {
					req.response()
                            .setChunked(true)
                            .putHeader(HttpHeaders.CONTENT_TYPE, "text/html")
                            .write("<html><head><style>body {font-family: Helvetica;}</style></head><body><center><h1 style='color: blue'>Hello - Learning Axis Hackathon !!</h1></center><br/>");
                    req.response()
                            .write("<h2>Environment Variables</h2><p>");
					environmentVars.entrySet().forEach(entry -> {
						req.response()
                                .write(MessageFormat.format("<b>{0}</b>={1}<br/>",entry.getKey(), entry.getValue()));
					});
                    req.response().end("</p></body></html>");
                })
                .listen(finalPort, handler -> {
                    if(handler.succeeded()) {
                        System.out.println("Server started on port: " + finalPort);
                    } else {
                        System.err.println("Server failed to start on port: " + finalPort);
                        handler.cause().printStackTrace();
                    }
                });
    }
}
