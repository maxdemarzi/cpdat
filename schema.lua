NodeTypeInsert("Chemical")
NodePropertyTypeAdd("Chemical", "name", "string")
NodePropertyTypeAdd("Chemical", "casrn", "string")
NodePropertyTypeAdd("Chemical", "preferred_name", "string")
NodePropertyTypeAdd("Chemical", "preferred_casrn", "string")
NodePropertyTypeAdd("Chemical", "DTXSID", "string")
NodePropertyTypeAdd("Chemical", "curation_level", "string")

NodeTypeInsert("Document")
NodePropertyTypeAdd("Document", "title", "string")
NodePropertyTypeAdd("Document", "subtitle", "string")
NodePropertyTypeAdd("Document", "date", "string")

NodeTypeInsert("Function_Category")
NodeTypeInsert("Function")
NodeTypeInsert("Function_Use")

NodeTypeInsert("Reason_Listed")
NodePropertyTypeAdd("Reason_Listed", "name", "string")
NodePropertyTypeAdd("Reason_Listed", "definition", "string")
NodePropertyTypeAdd("Reason_Listed", "kind", "string")

NodeTypeInsert("PUC_Category")
NodeTypeInsert("PUC_Family")
NodeTypeInsert("PUC_Type")
NodePropertyTypeAdd("PUC_Type", "id", "integer")
NodePropertyTypeAdd("PUC_Type", "description", "string")
NodePropertyTypeAdd("PUC_Type", "code", "string")
NodePropertyTypeAdd("PUC_Type", "kind", "string")

RelationshipTypeInsert("HAS_FAMILY")
RelationshipTypeInsert("HAS_TYPE")
RelationshipTypeInsert("HAS_CHEMICAL")
RelationshipTypeInsert("HAS_FUNCTION")
RelationshipTypeInsert("HAS_USE")
RelationshipTypeInsert("USES_CHEMICAL")
RelationshipTypeInsert("REPORTED_USE")

NodeTypesGet(), RelationshipTypesGet()