package paw.util.mail.conf;

public class URMailConfiguration extends ConfiguracionCorreo {

  public String getHost() {
    return "smtp.unirioja.es";
  }

  public String getPort() {
    return "587";
  }

  public String getEnableStartTLS() {
    return "true";
  }

  public String getUser() {
    return "joortif";
  }

  public String getPassword() {
    return "";
  }

  public String getAuth() {
    return "true";// Si en la UR se pone a true da error
  }
}
