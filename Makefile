.PHONY: up down restart logs reset shell

up:
	docker-compose up -d

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f

reset:
	docker-compose down -v
	docker-compose up -d

shell:
	docker-compose exec db psql -U inventory_admin -d church_inventory
