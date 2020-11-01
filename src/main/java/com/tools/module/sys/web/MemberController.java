package com.tools.module.sys.web;

import com.tools.common.config.AbstractController;
import com.tools.common.model.Result;
import com.tools.common.util.MD5Utils;
import com.tools.common.util.ShiroUtils;
import com.tools.module.sys.entity.SysUser;
import com.tools.module.sys.service.SysUserService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 个人设置
 * 爪哇笔记：https://blog.52itstyle.vip
 * @author 小柒2012
 */
@Api(tags ="用户管理")
@RestController
@RequestMapping("/member")
public class MemberController extends AbstractController {

    @Autowired
    private SysUserService sysUserService;

    /**
     * 修改密码
     */
    @PostMapping("/updatePwd")
    public Result updatePwd(@RequestBody SysUser user){
        SysUser entity = ShiroUtils.getUserEntity();
        String password = MD5Utils.encrypt(entity.getUsername(),user.getOldPassword());
        if(entity.getPassword().equals(password)){
            entity.setPassword(user.getPassword());
            return sysUserService.updatePwd(entity);
        }else{
            return Result.error("原密码不正确");
        }
    }

    /**
     * 获取当前用户信息
     */
    @PostMapping("/info")
    public Result info(){
        return sysUserService.get(ShiroUtils.getUserId());
    }

    /**
     * 更新用户信息
     */
    @PostMapping("/update")
    public Result update(@RequestBody SysUser user){
        return sysUserService.update(user);
    }
}
