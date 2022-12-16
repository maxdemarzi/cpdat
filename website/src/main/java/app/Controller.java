package app;

import io.jooby.annotations.*;

@Path("/")
public class Controller {

  @GET
  public Object index() {
    return views.index.template();
  }
}
