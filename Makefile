init:
	@terraform init

plan:
	@terraform plan

apply:
	@terraform apply

destroy:
	@terraform destroy

val:
	@terraform validate

fmt:
	@terraform fmt -recursive

c:
	@terraform console
