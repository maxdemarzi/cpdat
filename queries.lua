-- Queries:
    -- Replicate Existing Product: Given a product, tell me what substances it is made from and "why" (uses) so I can replicate it.
    -- Reformulate Existing Product: Given a product, find "similar" products then tell me what substances they are made from individually and in some aggregate fashion, so I can replicate it.

local node = NodeGet("Product", "52143")

-- Get Products with the same Brand
local brand = NodeGetNeighbors(node, "HAS_BRAND")[1]
local same_brand_products = {}
if (brand ~= null) then
    same_brand_products = NodeGetNeighbors(brand, Direction.IN, "HAS_BRAND")
end

-- Get Products with the same Type
local type = NodeGetNeighbors(node, "IS_TYPE")[1]
local same_type_products = {}
if (type ~= null) then
    same_type_products = NodeGetNeighbors(type, Direction.IN, "IS_TYPE")
end

-- Get Products with the same Function
local func = NodeGetNeighbors(node, "FUNCTIONS_AS")[1]
local same_func_products = {}
if (func ~= null) then
    same_func_products = NodeGetNeighbors(func, Direction.IN, "FUNCTIONS_AS")
end

-- Get Products with the same Substances
local chems = NodeGetNeighbors(node, Direction.OUT, "HAS_CHEMICAL")
local substances = {}
local same_substance_products = {}
if (chems ~= null) then
    substances = NodesGetNeighborIds(chems, Direction.OUT, "IS_SUBSTANCE")
    for chem_id, sub_ids in pairs(substances) do
        if next(sub_ids) ~= nil then
            local other_chemicals = NodeGetNeighborIds(sub_ids[1], Direction.IN, "IS_SUBSTANCE")
            if (next(other_chemicals)) then
                local other_products = NodeIdsGetNeighborIds(other_chemicals, Direction.IN, "HAS_CHEMICAL")
                for other_chem_id, products in pairs(other_products) do
                    for i, product in pairs(products) do
                        if (same_substance_products[product] ~= nil) then
                            same_substance_products[product] = 1 + same_substance_products[product]
                        else
                             same_substance_products[product] = 1
                        end
                    end
                end
            end
        end
    end
end
-- brand, same_brand_products
-- type, same_type_products
-- func, same_func_products

-- Remove starting product from same substance products
same_substance_products[node:getId()] = nil

-- Sort same substance products by their count in descending order
function byvaldesc(a,b)
    return same_substance_products[a] > same_substance_products[b]
end
list = {}
for product,value in pairs(same_substance_products) do
    list[#list+1] = product
end
table.sort(list,byvaldesc)

-- Get up to the top 20 products
local smaller = table.move(list, 1, 20, 1, {})
node, smaller