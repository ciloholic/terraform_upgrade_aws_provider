# 変更前後バージョン

| tool          | before version | after version |
| ---           | ---            | ---           |
| Terraform     | 1.1.2          | -             |
| hashicorp/aws | 3.22           | 3.70.0        |

# Terraform と hashicorp/aws の更新

```
$ rm -f .terraform.lock.hcl
$ make update
$ make init
```

# 空のリソースを作成

```
resource "aws_cloudfront_key_group" "example_key_group" {
}
```

# 既存リソースをインポート

```
$ terraform import aws_cloudfront_key_group.example_key_group [id]
```

# 差分が無くなるまでリソースを修正

```
resource "aws_cloudfront_key_group" "example_key_group" {
  comment = "example key group"
  name    = "example-key-group"
  items   = [aws_cloudfront_public_key.example.id]
}
```
