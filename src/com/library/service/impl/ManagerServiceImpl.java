package com.library.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.util.DigestUtils;

import com.library.criteria.PaginationQueryCriteria;
import com.library.criteria.QueryCriteria;
import com.library.dao.ManagerDao;
import com.library.domain.Manager;
import com.library.service.ManagerService;
import com.library.util.LogUtil;
import com.library.vo.Pagination;

@Service("managerService")
public class ManagerServiceImpl implements ManagerService<Manager> {
	
	@Resource
	private ManagerDao<Manager> managerDao;

	@Resource
	TransactionTemplate transactionTemplate;
	@Override
	public Integer insert(Manager manager) {
		return managerDao.insert(manager);
	}

	@Override
	public Integer delete(Manager manager) {
		return managerDao.delete(manager);
	}

	@Override
	public Manager query(Manager manager) {
		return managerDao.query(manager);
	}

	@Override
	public Integer update(Manager manager) {
		return managerDao.update(manager);
	}

	@Override
	public List<Manager> queryList(QueryCriteria<Manager> bean) {
		return managerDao.queryList(bean);
	}

    @Override
    public void batchDelete(String[] ids)
    {
        managerDao.batchDelete(ids);
    }

   
    @Override
    public void checkTransaction()
    {
        /**
         * 编程式事务
         */
//        transactionTemplate.execute(new TransactionCallback<Manager>()
//        {
//
//            @Override
//            public Manager doInTransaction(TransactionStatus arg0)
//            {
//                Manager user=new Manager();
//                user.setManagerID("test02");
//                user.setPassword("yshin1992");
////                user = session.selectOne(statement, user);
////                ManagerDao managerDao=session.getMapper(ManagerDao.class);
////                user=(Manager) managerDao.query(user);
//          
//                managerDao.delete(user);
//                user.setManagerID("test02");
//                managerDao.insert(user);
//                System.out.println(user+"-------------->");
//                return user;
//            }
//        });
        /**
         * 声明式事务
         */
        Manager user=new Manager();
        user.setManagerID("test02");
        user.setPassword("yshin1992");
  
        managerDao.delete(user);
        user.setManagerID("test02");
        managerDao.insert(user);
        System.out.println(user+"-------------->");
    }

    @Override
    public void updatePhoto(Manager manager)
    {
        managerDao.updatePhoto(manager);
    }

    @Override
    public Manager getPhoto(String managerID)
    {
        // TODO Auto-generated method stub
        return managerDao.getPhoto(managerID);
    }

    @Override
    public Pagination<Manager> queryByPage(PaginationQueryCriteria<Manager> criteria)
    {
        Pagination<Manager> pagination=new Pagination<>();
        pagination.setFullListSize(managerDao.queryRecordCount(criteria));//
        pagination.setSortCriterion(criteria.getSort());
        pagination.setSortDirection(criteria.getDir());
        List<Manager> resList=managerDao.queryList(criteria);
        pagination.setList(resList);
        pagination.setPageNumber(criteria.getPage());
        pagination.setObjectsPerPage(criteria.getPageSize());
        return pagination;
    }

	@Override
	public boolean updatePswd(Manager manager,String oldPswd, String newPswd) {
		// TODO Auto-generated method stub
		if(validatePswd(manager,oldPswd)){
			try{
				manager.setPassword(DigestUtils.md5DigestAsHex(newPswd.getBytes()));
				managerDao.updatePswd(manager);
				return true;
			}catch(Exception e){
				LogUtil.getLogger(this).warn("更新密码失败", e);
			}
		}
		return false;
	}
	
	private boolean validatePswd(Manager manager,String pswd){
		//对密码进行加密
		//改进：用Spring AOP实现
		if(!"admin".equals(manager.getManagerID())){
			pswd=DigestUtils.md5DigestAsHex(pswd.getBytes());
		}
		manager.setPassword(pswd);
		manager = this.query(manager);
		return manager==null?false:true;
	}
}
