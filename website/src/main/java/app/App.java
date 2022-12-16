package app;

import com.fizzed.rocker.runtime.RockerRuntime;
import io.jooby.*;
import io.jooby.rocker.RockerModule;
import io.jooby.whoops.WhoopsModule;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;

public class App extends Jooby {

  {

    // Debug friendly error messages
    install(new WhoopsModule());

    // Server Options
    setServerOptions(new ServerOptions()
            .setCompressionLevel(6)           // GZIP compression level
            //.setPort(80)                    // Port for HTTP - requires sudo
            .setDefaultHeaders(false)         // Do not send Date, Content-Type and Server
            //.setSecurePort(433)             // Port for HTTPS - requires sudo
            .setSsl(SslOptions.selfSigned())  // Fine for Proof of concept, replace in production
            .setHttpsOnly(false)              // Set to true in production
            .setHttp2(true)                   // For modern browsers
    );


    //Template Engine
    install(new RockerModule());
    RockerRuntime.getInstance().setReloading(true);

    // Static Assets
    Path assets = Paths.get("assets");
    AssetSource www = AssetSource.create(assets);
    assets("/assets/?*", new AssetHandler(www)
            .setMaxAge(Duration.ofDays(30)));  // Cache static assets for about month

    // Handle Errors
    error((ctx, cause, statusCode) -> {
      Router router = ctx.getRouter();
      router.getLog().error("found `{}` error", statusCode.value(), cause);

      String code = String.valueOf(statusCode.value());
      code = code.replaceAll("0", "&#x1f635;");

      ctx.render(views.error.template(code, cause.getMessage()));
    });

    mvc(new Controller());
  }

  public static void main(final String[] args) {
    runApp(args, App::new);
  }

}
