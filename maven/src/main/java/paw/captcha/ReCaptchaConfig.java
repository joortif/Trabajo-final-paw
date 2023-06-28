package paw.captcha;

public class ReCaptchaConfig {

    private String siteKey;
    private String secret;

    public ReCaptchaConfig() {
    }

    public ReCaptchaConfig(String siteKey, String secret) {
        this.siteKey = siteKey;
        this.secret = secret;
    }

    public String getSiteKey() {
        return siteKey;
    }

    public String getSecret() {
        return secret;
    }

}
