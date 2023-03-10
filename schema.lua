NodeTypeInsert("Chemical")
NodePropertyTypeAdd("Chemical", "name", "string")
NodePropertyTypeAdd("Chemical", "casrn", "string")
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

NodeTypeInsert("Brand")
NodeTypeInsert("Product")
NodePropertyTypeAdd("Product", "title", "string")
NodePropertyTypeAdd("Product", "raw_min_comp", "string")
NodePropertyTypeAdd("Product", "raw_central_comp", "string")
NodePropertyTypeAdd("Product", "raw_max_comp", "string")
NodePropertyTypeAdd("Product", "clean_min_wf", "double")
NodePropertyTypeAdd("Product", "clean_central_wf", "double")
NodePropertyTypeAdd("Product", "clean_max_wf", "double")

NodeTypeInsert("QSUR_Category")

NodeTypeInsert("Substance")
NodePropertyTypeAdd("Substance", "preferred_name", "string")
NodePropertyTypeAdd("Substance", "preferred_casrn", "string")

RelationshipTypeInsert("FUNCTIONS_AS")
RelationshipTypeInsert("HAS_BRAND")
RelationshipTypeInsert("HAS_CHEMICAL")
RelationshipTypeInsert("HAS_FAMILY")
RelationshipTypeInsert("HAS_FUNCTION")
RelationshipTypeInsert("HAS_TYPE")
RelationshipTypeInsert("HAS_USE")
RelationshipTypeInsert("IS_PRESENT")
RelationshipTypeInsert("IS_SUBSTANCE")
RelationshipTypeInsert("PROBABLE_USE")
RelationshipPropertyTypeAdd("PROBABLE_USE", "probability", "double")
RelationshipTypeInsert("REPORTED_CHEMICAL")
RelationshipTypeInsert("REPORTED_REASON")
RelationshipTypeInsert("REPORTED_FUNCTION")
RelationshipTypeInsert("USES_CHEMICAL")

NodeTypesGet(), RelationshipTypesGet()