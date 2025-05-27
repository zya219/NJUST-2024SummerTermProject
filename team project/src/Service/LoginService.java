package Service;

import Dao.VisitorDAO;
import Dao.ManagerDAO;
import bean.Visitor;
import bean.Manager;

public class LoginService {
    static VisitorDAO visitorDAO = new VisitorDAO();
    public int checkvLogin(Visitor visitor) {
        return visitorDAO.checkLogin(visitor);
    }
    static ManagerDAO managerDAO = new ManagerDAO();
    public int checkmLogin(Manager manager) {
        return managerDAO.checkLogin(manager);
    }

}
