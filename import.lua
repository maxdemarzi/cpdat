for i, reason in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/list_presence_dictionary_20201216.csv", ",") do
   NodeAdd("Reason_Listed", reason.list_presence_id,
    "{\"name\":".."\""..reason.name.."\","..
     "\"description\":".."\""..reason.definition.."\","..
     "\"kind\":".."\""..reason.kind.."\"}")
end

for i, puc in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/PUC_dictionary_20201216.csv", ",") do
   NodeAdd("PUC_Category", puc.gen_cat)
end

for i, puc in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/PUC_dictionary_20201216.csv", ",") do
   NodeAdd("PUC_Family", puc.prod_fam)
end

for i, puc in ftcsv.parseLine("/home/max/IdeaProjects/cpdat/Release20201216/PUC_dictionary_20201216.csv", ",") do
   NodeAdd("PUC_Type", puc.puc_id,
    "{\"name\":".."\""..puc.prod_type.."\","..
      "\"description\":".."\""..puc.description.."\","..
      "\"code\":".."\""..puc.puc_code.."\","..
      "\"kind\":".."\""..puc.kind.."\"}")
end

local nodes_count = AllNodesCounts()
local rels_count= AllRelationshipsCounts()
nodes_count, rels_count