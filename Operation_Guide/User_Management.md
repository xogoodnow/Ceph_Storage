## For creating a user on RGW
```bash
radosgw-admin user create --uid="userid" --display-name="User Name"
```

## Setting quota for the user 
> **Note**
> This is for limiting the storage usage and number of objects
> 
```bash
radosgw-admin quota set --quota-scope=user --uid=userid --max-objects=1000 --max-size=20G
```

## User permissions on buckets
```bash
radosgw-admin policy create --uid="userid" --permission=read,write --bucket="bucketname"
```


## Checking user usage on RGW

```bash
radosgw-admin user stats --uid="userid"

```

## Delete a user on RGW
```bash
radosgw-admin user rm --uid="userid"

```

## To See the credentials of already existing user
```bash
radosgw-admin user info --uid=userid
```





