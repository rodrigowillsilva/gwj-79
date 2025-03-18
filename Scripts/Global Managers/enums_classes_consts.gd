extends Node

enum KingdomResourceTypes {
	Acorn,
	Population,
	Loyalty,
	TreeHeight
}

enum RequestPool {
	Early,
	Late,
	All
}

enum EntityTypes {
	King,
	Requester
}

const ENTITY_TYPE_NAMES = {
	EntityTypes.King: "King",
	EntityTypes.Requester: "Requester"
}
