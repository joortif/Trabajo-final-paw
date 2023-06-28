package paw.captcha;

import javax.servlet.http.HttpServletRequest;
import paw.util.ReCaptchaException;

public interface CaptchaValidator {

    public boolean checkUserResponse(HttpServletRequest request) throws ReCaptchaException;

    public boolean checkUserResponse(CaptchaValidationRequest request) throws ReCaptchaException;

}
