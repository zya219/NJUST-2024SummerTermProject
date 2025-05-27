package bean;

public class Manager {
    private int id;
    private String name;
    private String pw;
    private String type;


    public Manager(){}
    public Manager(int id,String name,String pw ,String type){
        this.setId(id);
        this.setName(name);
        this.setPw(pw);
        this.setType(type);
    }
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getPw() {return pw;}
    public String getType() {
        return type;
    }

    public void setId(int id) {
        this.id = id;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setPw(String pw){
        this.pw = pw;
    }
    public void setType(String type){
        this.type = type;
    }
}
