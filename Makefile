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

update:
	@docker run -it --rm -v $$(pwd):/root/terraform minamijoyo/tfupdate terraform -r /root/terraform
	@docker run -it --rm -v $$(pwd):/root/terraform minamijoyo/tfupdate provider aws -r /root/terraform
