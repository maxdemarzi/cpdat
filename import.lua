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
    NodeAdd("Function", fud.functional_use_id)
    RelationshipAdd("USES_CHEMICAL", "Function", fud.functional_use_id, "Chemical", fud.chemical_id)
    has_function[fud.report_funcuse] = fud.oecd_function
    has_use[fud.functional_use_id] = fud.report_funcuse
end

for report_funcuse, oecd_function in pairs(has_function) do
    NodeAdd("Function_Category", oecd_function)
    NodeAdd("Function_Use", report_funcuse)
    RelationshipAdd("HAS_USE", "Function_Category", oecd_function, "Function_Use", report_funcuse)
end

for functional_use_id, report_funcuse in pairs(has_use) do
    RelationshipAdd("HAS_FUNCTION", "Function_Use", report_funcuse, "Function", functional_use_id)
end

for i, rel in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/functional_use_data_20201216.csv", ",") do
  RelationshipAdd("REPORTED_FUNCTION", "Document", rel.document_id, "Function", rel.functional_use_id)
end


for i, rel in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/HHE_data_20201216.csv", ",") do
  RelationshipAdd("REPORTED_CHEMICAL", "Document", rel.document_id, "Chemical", rel.chemical_id)
end

local unique_reported = Roar.new()
local unique_present = Roar.new()
for i, lpd in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/list_presence_data_20201216.csv", ",") do
    if (lpd.list_presence_id ~= "NA") then
      local lpi = tonumber(lpd.list_presence_id)
      unique_reported:add( (tonumber(lpd.document_id) * 1000) + lpi)
      if (lpd.chemical_id ~= "NA") then
         unique_present:add( (tonumber(lpd.chemical_id) * 1000) + lpi)
      end
    end
end

for _, id in ipairs(unique_reported:getIds()) do
    local lpi =  id % 1000
    local doc_id = (id - lpi) / 1000
     RelationshipAdd("REPORTED_REASON", "Document", tostring(doc_id), "Reason_Listed", tostring(lpi) )
end

for _, id in ipairs(unique_present:getIds()) do
    local lpi =  id % 1000
    local chem_id = (id - lpi) / 1000
     RelationshipAdd("IS_PRESENT", "Chemical", tostring(chem_id), "Reason_Listed", tostring(lpi) )
end

local unique_brand = {}
local current_product = 0
for i, pcd in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/product_composition_data_20201216.csv", ",") do
    id = tostring(pcd.product_id)
    if (current_product ~= pcd.product_id) then
        local properties = "{\"title\":".."\""..pcd.prod_title.."\""
        if (pcd.raw_min_comp ~= "NA") then
           properties = properties..",\"raw_min_comp\":".."\""..pcd.raw_min_comp.."\""
        end
        if (pcd.raw_central_comp ~= "NA") then
           properties = properties..",\"raw_central_comp\":".."\""..pcd.raw_central_comp.."\""
        end
        if (pcd.raw_max_comp ~= "NA") then
           properties = properties..",\"raw_max_comp\":".."\""..pcd.raw_max_comp.."\""
        end
        if (pcd.clean_min_wf ~= "NA") then
           properties = properties..",\"clean_min_wf\":"..pcd.clean_min_wf
        end
        if (pcd.clean_central_wf ~= "NA") then
           properties = properties..",\"clean_central_wf\":"..pcd.clean_central_wf
        end
        if (pcd.clean_max_wf ~= "NA") then
            properties = properties..",\"clean_max_wf\":"..pcd.clean_max_wf
        end
        properties = properties.."}"
        NodeAdd("Product", id, properties)
        current_product = pcd.product_id

        -- Connect Product to Brand
        if (pcd.brand_name ~= "NA") then
           if (unique_brand[pcd.brand_name] ~= nil) then
               RelationshipAdd("HAS_BRAND", "Product", id, "Brand", pcd.brand_name)
           else
               unique_brand[pcd.brand_name] = true
               NodeAdd("Brand", pcd.brand_name)
               RelationshipAdd("HAS_BRAND", "Product", id, "Brand", pcd.brand_name)
           end
        end

        -- Connect Product to PUC_Type
        RelationshipAdd("IS_TYPE", "Product", id, "PUC_Type", tostring(pcd.puc_id))
    end

    if (functional_use_id ~= "NA") then
        RelationshipAdd("FUNCTIONS_AS", "Product", id, "Function", tostring(pcd.functional_use_id))
    end
    RelationshipAdd("HAS_CHEMICAL", "Product", id, "Chemical", tostring(pcd.chemical_id))
end

local chemicals = {}
for i, chemical in pairs(AllNodes("Chemical", 0, AllNodesCount("Chemical"))) do
    chemicals[chemical:getProperty("DTXSID")] = chemical:getKey()
end

local unique_qsur = {}
for i, qsur in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/QSUR_data_20201216.csv", ",") do
    local chemical_id = chemicals[qsur.DTXSID]
    if (chemical_id ~= nil) then
        if (unique_qsur[qsur.harmonized_function] == nil) then
            NodeAdd("QSUR_Category", qsur.harmonized_function)
            unique_qsur[qsur.harmonized_function] = true
        end

        RelationshipAdd("PROBABLE_USE", "Chemical", chemical_id, "QSUR_Category", qsur.harmonized_function,
            "{\"probability\":"..qsur.probability.."}")
    end
end

local nodes_count = AllNodesCounts()
local rels_count= AllRelationshipsCounts()
nodes_count, rels_count