package fpt.hieunm.application.models.pojo;

public class CustomExceptions {

    public static class EmailAlreadyExistsException extends RuntimeException {
        public EmailAlreadyExistsException(String message) {
            super(message);
        }

        public EmailAlreadyExistsException(String message, Throwable cause) {
            super(message, cause);
        }
    }

    public static class UsernameAlreadyExistsException extends RuntimeException {
        public UsernameAlreadyExistsException(String message) {
            super(message);
        }

        public UsernameAlreadyExistsException(String message, Throwable cause) {
            super(message, cause);
        }
    }

    // Các ngoại lệ khác có thể được thêm vào đây
}
