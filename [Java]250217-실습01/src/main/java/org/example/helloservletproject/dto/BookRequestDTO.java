package org.example.helloservletproject.dto;

public class BookRequestDTO {
    private String keyword;
    private int priceLimit;

    public BookRequestDTO() {}
    public BookRequestDTO(String keyword, int priceLimit) {
        this.keyword = keyword;
        this.priceLimit = priceLimit;
    }

    public String getKeyword() {
        return keyword;
    }

    public int getPriceLimit() {
        return priceLimit;
    }

    @Override
    public String toString() {
        return "BookRequestDTO{" +
                "keyword='" + keyword + '\'' +
                ", priceLimit=" + priceLimit +
                '}';
    }
}
