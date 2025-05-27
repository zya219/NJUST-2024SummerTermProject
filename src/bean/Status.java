package bean;

public class Status{
    private int rid;
    private String status;
    private String time;

    public Status(){}
    public Status(int rid,String status,String time ){
        this.setRid(rid);
        this.setStatus(status);
        this.setTime(time);
    }
    public void setRid(int rid){
        this.rid = rid;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public void setTime(String time){
        this.time = time;
    }
    public int getRid(){
        return rid;
    }
    public String getStatus(){return status;}
    public String getTime(){return time;}
}

