for i, chem in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/chemical_dictionary_20201216.csv", ",") do
    local properties = "{\"name\":".."\""..chem.raw_chem_name.."\""
    if (chem.raw_casrn ~= "NA") then
       properties = properties..",\"subtitle\":".."\""..chem.raw_casrn.."\""
    end
    if (chem.preferred_name ~= "NA") then
       properties = properties..",\"preferred_name\":".."\""..chem.preferred_name.."\""
    end
    if (chem.preferred_casrn ~= "NA") then
        properties = properties..",\"preferred_casrn\":".."\""..chem.preferred_casrn.."\""
    end
    if (chem.DTXSID ~= "NA") then
        properties = properties..",\"DTXSID\":".."\""..chem.DTXSID.."\""
    end
    if (chem.curation_level ~= "") then
       properties = properties..",\"curation_level\":".."\""..chem.curation_level.."\""
    end
       properties = properties.."}"
       NodeAdd("Chemical", chem.chemical_id, properties)
end


for i, doc in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/document_dictionary_20201216.csv", ",") do
    local properties = "{\"title\":".."\""..doc.title.."\""
    if (doc.subtitle ~= "NA") then
       properties = properties..",\"subtitle\":".."\""..doc.subtitle.."\""
    end
    if (doc.date ~= "NA") then
       properties = properties..",\"date\":".."\""..doc.doc_date.."\""
    end
       properties = properties.."}"
       NodeAdd("Document", doc.document_id, properties)
end

for i, reason in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/list_presence_dictionary_20201216.csv", ",") do
   NodeAdd("Reason_Listed", reason.list_presence_id,
    "{\"name\":".."\""..reason.name.."\","..
     "\"description\":".."\""..reason.definition.."\","..
     "\"kind\":".."\""..reason.kind.."\"}")
end

local has_family = {}
local has_type = {}
for i, puc in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/PUC_dictionary_20201216.csv", ",") do
   NodeAdd("PUC_Type", puc.puc_id,
    "{\"name\":".."\""..puc.prod_type.."\","..
      "\"description\":".."\""..puc.description.."\","..
      "\"code\":".."\""..puc.puc_code.."\","..
      "\"kind\":".."\""..puc.kind.."\"}")
    has_family[puc.prod_fam] = puc.gen_cat
    has_type[puc.puc_id] = puc.prod_fam
end

for fam, cat in pairs(has_family) do
    NodeAdd("PUC_Category", cat)
    NodeAdd("PUC_Family", fam)
    RelationshipAdd("HAS_FAMILY", "PUC_Category", cat, "PUC_Family", fam)
end

for type, fam in pairs(has_type) do
    RelationshipAdd("HAS_TYPE", "PUC_Family", fam, "PUC_Type", type)
end

local has_function = {}
local has_use = {}
for i, fud in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/functional_use_dictionary_20201216.csv", ",") do
    NodeAdd("Function_Use", fud.functional_use_id)
    RelationshipAdd("USES_CHEMICAL", "Function_Use", fud.functional_use_id, "Chemical", fud.chemical_id)
    has_function[fud.report_funcuse] = fud.oecd_function
    has_use[fud.functional_use_id] = fud.report_funcuse
end

for report_funcuse, oecd_function in pairs(has_function) do
    NodeAdd("Function_Category", oecd_function)
    NodeAdd("Function", report_funcuse)
    RelationshipAdd("HAS_FUNCTION", "Function_Category", oecd_function, "Function", report_funcuse)
end

for functional_use_id, report_funcuse in pairs(has_use) do
    RelationshipAdd("HAS_USE", "Function", report_funcuse, "Function_Use", functional_use_id)
end

for i, rel in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/functional_use_data_20201216.csv", ",") do
  RelationshipAdd("REPORTED_USE", "Document", rel.document_id, "Function_Use", rel.functional_use_id)
end


for i, rel in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/HHE_data_20201216.csv", ",") do
  RelationshipAdd("HAS_CHEMICAL", "Document", rel.document_id, "Chemical", rel.chemical_id)
end

local nodes_count = AllNodesCounts()
local rels_count= AllRelationshipsCounts()
nodes_count, rels_count