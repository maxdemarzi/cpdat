NodeTypeInsert("Document")
NodePropertyTypeAdd("Document", "title", "string")
NodePropertyTypeAdd("Document", "subtitle", "string")
NodePropertyTypeAdd("Document", "date", "string")

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

NodeTypesGet(), RelationshipTypesGet()