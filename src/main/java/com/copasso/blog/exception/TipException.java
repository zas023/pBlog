package com.copasso.blog.exception;

/**
 * 自定义通用异常
 */
public class TipException extends RuntimeException {

    public TipException() {
    }

    public TipException(String message) {
        super(message);
    }

    public TipException(String message, Throwable cause) {
        super(message, cause);
    }

    public TipException(Throwable cause) {
        super(cause);
    }

}
