package paw.captcha;

public class CaptchaValidationRequest {

    public final String reCaptchaParameter;
    public final String remoteAddress;

    public CaptchaValidationRequest(String reCaptchaParameter, String remoteAddress) {
        this.reCaptchaParameter = reCaptchaParameter;
        this.remoteAddress = remoteAddress;
    }

    public String getReCaptchaParameter() {
        return reCaptchaParameter;
    }

    public String getRemoteAddress() {
        return remoteAddress;
    }

}
