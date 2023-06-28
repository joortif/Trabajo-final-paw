package paw.captcha;

import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import paw.util.ReCaptchaException;

public class ReCaptchaValidatorV2 implements CaptchaValidator {

    public static final String SCRIPT_URL = "//www.google.com/recaptcha/api.js";
    public static final String VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";
    private ReCaptchaConfig config;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public ReCaptchaValidatorV2(ReCaptchaConfig config) {
        if (config == null) {
            throw new IllegalArgumentException("Invalid config");
        }
        this.config = config;

        String siteKey = config.getSiteKey();
        String secret = config.getSecret();

        if (siteKey == null || siteKey.isEmpty()) {
            throw new IllegalArgumentException("Invalid siteKey");
        }
        if (secret == null || secret.isEmpty()) {
            throw new IllegalArgumentException("Invalid secret");
        }
    }

    /**
     * Verify the validity of the fulfilled captcha. If the captcha is valid,
     * the method returns true. If the captcha does not validate, then an
     * exception ReCaptchaException is thrown with information about the
     * validation error.
     *
     * @param request HttpServletRequest corresponding to the form submition
     * where the captcha is included
     * @return true if captcha validates
     * @throws ReCaptchaException if the captcha does not validate
     */
    @Override
    public boolean checkUserResponse(HttpServletRequest request) throws ReCaptchaException {
        String reCaptchaParameter = request.getParameter("g-recaptcha-response");
        String remoteAddress = request.getRemoteAddr();
        return checkUserResponse(new CaptchaValidationRequest(reCaptchaParameter, remoteAddress));
    }

    @Override
    public boolean checkUserResponse(CaptchaValidationRequest request) throws ReCaptchaException {
        logger.info("RecaptchaResponse: {}", request.reCaptchaParameter);

        String response = verifyRecaptchaResponse(request.reCaptchaParameter, request.remoteAddress);
        if (response == null || response.isEmpty()) {
            throw new ReCaptchaException("response-null-or-empty");
        }

        ReCaptchaResponseV2 captchaResponse = buildRecaptchaResponse(response);
        logger.info("Success? {}", captchaResponse.isSuccess());

        if (!captchaResponse.isSuccess()) {
            logger.warn("ReCaptchaResponse check fail");
            if (captchaResponse.getErrorCodes() == null || captchaResponse.getErrorCodes().isEmpty()) {
                logger.info("ErrorCodes null or empty");
                throw new ReCaptchaException("verify-error");
            }
            logger.info("ErrorCodes: {} items", captchaResponse.getErrorCodes().size());
            if (captchaResponse.getErrorCodes().size() == 1) {
                throw new ReCaptchaException(captchaResponse.getErrorCodes().get(0));
            }
            throw new ReCaptchaException(String.join(",", captchaResponse.getErrorCodes()));
        }

        return true;
    }

    private String verifyRecaptchaResponse(String reCaptchaParameter, String remoteAddress) throws ReCaptchaException {
        if (reCaptchaParameter == null || reCaptchaParameter.isEmpty()) {
            throw new ReCaptchaException("missing-input-response");
        }

        String queryString = String.format("secret=%s&response=%s&remoteip=%s", config.getSecret(), reCaptchaParameter, remoteAddress);
        URL url;
        try {
            url = new URL(VERIFY_URL + "?" + queryString);
        } catch (MalformedURLException ex) {
            logger.error("Cannot build URL", ex);
            throw new ReCaptchaException(ex.getMessage());
        }

        String line, response = "";
        BufferedReader reader;
        try {
            reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            while ((line = reader.readLine()) != null) {
                response += line;
            }
        } catch (IOException ex) {
            logger.error("Error connecting to {}", url);
            throw new ReCaptchaException(ex.getMessage());
        }

        logger.info("Server response: {}", response);
        return response;
    }

    private ReCaptchaResponseV2 buildRecaptchaResponse(String response) throws ReCaptchaException {
        Gson gson = new Gson();
        ReCaptchaResponseV2 captchaResponse = gson.fromJson(response.toString(), ReCaptchaResponseV2.class);
        if (captchaResponse == null) {
            logger.warn("ReCaptchaResponse is null");
            throw new ReCaptchaException("response-parsing-error");
        }
        logger.info("ReCaptchaResponse is not null");
        return captchaResponse;
    }

}
