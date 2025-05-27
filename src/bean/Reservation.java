package bean;

public class Reservation {
    private int rid;
    private String reason;
    private String vid;
    private String tel;
    private String date;
    private String status;

    public Reservation() {}

    public Reservation(int rid, String reason, String vid, String tel, String date, String status) {
        this.setRid(rid);
        this.setReason(reason);
        this.setVid(vid);
        this.setTel(tel);
        this.setDate(date);
        this.setStatus(status);
    }

    public int getRid() {
        return rid;
    }

    public String getReason() {
        return reason;
    }

    public String getVid() {
        return vid;
    }

    public String getTel() {
        return tel;
    }

    public String getDate() {
        return date;
    }

    public String getStatus() {
        return status;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
