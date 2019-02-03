For **prod**, simply run `setup-all-prod`

`setup-all-prod` internally invokes:
* `setup-prod-service` 
* `setup-letsencrypt` (optional; will prompt) 
* `setup-crontabs` 
* besides other commands required for setting up auto backups and letsencrypt renewal

For NHSRC, also run `nhsrc-extra`

---
`setup-qa-service` is the QA equivalent of `setup-prod-service`

---

*Scripts work smoothly on Ubuntu; 
might need tweaks for RH/CentOS*
