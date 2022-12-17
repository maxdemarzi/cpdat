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
   NodeAdd("PUC_Category", puc.gen_cat)
   NodeAdd("PUC_Family", puc.prod_fam)
   NodeAdd("PUC_Type", puc.puc_id,
    "{\"name\":".."\""..puc.prod_type.."\","..
      "\"description\":".."\""..puc.description.."\","..
      "\"code\":".."\""..puc.puc_code.."\","..
      "\"kind\":".."\""..puc.kind.."\"}")
    has_family[puc.gen_cat] = puc.prod_fam
    has_type[puc.prod_fam] = puc.puc_id
end

for cat, fam in pairs(has_family) do
    RelationshipAdd("HAS_FAMILY", "PUC_Category", cat, "PUC_Family", fam)
end

for fam, type in pairs(has_type) do
    RelationshipAdd("HAS_TYPE", "PUC_Family", fam, "PUC_Type", type)
end

local nodes_count = AllNodesCounts()
local rels_count= AllRelationshipsCounts()
nodes_count, rels_count