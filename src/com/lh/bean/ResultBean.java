package com.lh.bean;

public class ResultBean {
    private Integer success;
    private String error;

    @Override
    public String toString() {
        return "ResultBean{" +
                "success=" + success +
                ", error='" + error + '\'' +
                '}';
    }

    public Integer getSuccess() {
        return success;
    }

    public void setSuccess(Integer success) {
        this.success = success;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
