package com.daou.boardproject.member.vo;

import java.time.LocalDateTime;

public class MemberVO {
    int member_id;
    String username;
    String nickname;
    String password;
    String email;
    LocalDateTime created_at;
    LocalDateTime updated_at;

    public MemberVO() {}

    public MemberVO(int member_id, String username, String nickname, String password, String email, LocalDateTime created_at, LocalDateTime updated_at) {
        this.member_id = member_id;
        this.username = username;
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }

    @Override
    public String toString() {
        return "MemberVO{" +
                "member_id=" + member_id +
                ", username='" + username + '\'' +
                ", nickname='" + nickname + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", created_at=" + created_at +
                ", updated_at=" + updated_at +
                '}';
    }
}
