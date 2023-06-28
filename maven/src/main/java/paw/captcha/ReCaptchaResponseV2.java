package paw.captcha;

import com.google.gson.annotations.SerializedName;
import java.util.List;

/**
 * Respuesta de la verificacion de recaptcha
 *
 * TODO: completar con la documentacion de Google:challenge_ts, error-codes, etc. Por simplicidad no es necesario implementarlo
 */
public class ReCaptchaResponseV2 {

    private boolean success;
    private String hostname;

    @SerializedName("error-codes")
    private List<String> errorCodes;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getHostname() {
        return hostname;
    }

    public void setHostname(String hostname) {
        this.hostname = hostname;
    }

    public List<String> getErrorCodes() {
        return errorCodes;
    }

    public void setErrorCodes(List<String> errorCodes) {
        this.errorCodes = errorCodes;
    }

}
