
package com.library.dao;

import com.library.criteria.QueryCriteria;

public interface BaseDao<T>
{
    public Integer insert(T t);

    public Integer delete(T t);

    public T query(T t);

    public Integer update(T t);

    public Integer queryRecordCount(QueryCriteria<T> bean);
}
