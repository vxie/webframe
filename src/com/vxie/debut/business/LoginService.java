package com.vxie.debut.business;

import com.vxie.debut.model.AdminUser;
import com.vxie.debut.utils.MD5Encoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginService extends BaseService {
	
	private AdminUser findUser(String loginName){
		List<AdminUser> res = dao.find(AdminUser.class, "from AdminUser c where c.number=?", loginName);
        return (res.size() == 0 || res.size() > 1) ? null : res.get(0);
    }
	
	
	public Object checkUser(String loginName, String pwd) {
        AdminUser user = findUser(loginName);
        if (user != null) {
            if (user.getPassword().equals(MD5Encoder.encode(pwd))) {
                return user;
            } else {
                return "密码错误";
            }
        }
        return "帐号不存在";
    }

}
