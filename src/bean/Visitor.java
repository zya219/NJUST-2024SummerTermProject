package bean;

public class Visitor{
    private String visitorname;
    private String id;

    public Visitor(){}
    public Visitor(String visitorname, String id ){
        this.setVisitorname(visitorname);
        this.setId(id);
    }
    public void setVisitorname(String visitorname){
        this.visitorname= visitorname;
    }
    public void setId(String id){
        this.id = id;
    }

    public String getVisitorname(){
        return visitorname;
    }
    public String getId(){
        return id;
    }
}

