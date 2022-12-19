# cpdat
Chemical and Products Database as a Graph

Data Sources:

- [CPDat](https://gaftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/CPDat/CPDat2020-12-16/)

Schema:

File: chemical_dictionary_20201216.csv

    Chemical(chemical_id)
        name:string
        casrn:string
        preferred_name:string
        preferred_casrn:string
        DTXSID:string
        curation_level:string

File: document_dictionary_20201216.csv

    Document(document_id)
        title:string
        subtitle:string
        date:string // Not date because formatting is not standard, would have to clean up before proper import as date
                    // "06.20.2016", "13-May-2015", "13/08/2014"

File: functional_use_data_20201216.csv

    REPORTED_FUNCTION(Document, document_id, Function, functional_use_id)

File: functional_use_dictionary_20201216.csv

    Function_Category(oecd_function)
    Function_Use(report_funcuse)
    Function(functional_use_id)

    HAS_USE(Function_Category, oecd_function, Function_Use, report_funcuse)
    HAS_FUNCTION(Function_Use, report_funcuse, Function, functional_use_id)
    USES_CHEMICAL(Function, functional_use_id, Chemical, chemical_id)

File: HHE_data_20201216.csv

    REPORTED_CHEMICAL(Document, document_id, Chemical, chemical_id)

File: list_presence_data_20201216.csv

    REPORTED_REASON(Document, document_id, Reason_Listed, list_presence_id)
    IS_PRESENT(Chemical, chemical_id, Reason_Listed, list_presence_id)

File: list_presence_dictionary_20201216.csv

    Reason_Listed(list_presence_id)
        name:string
        definition:string
        kind:string

File: product_composition_data_20201216.csv

    Brand(brand_name)
    Product(prod_title)
    HAS_BRAND(Product, prod_title, Brand, brand_name)
    IS_TYPE(Product, prod_title, PUC_Type, puc_id)
    FUNCTIONS_AS(Product, prod_title, Function, functional_use_id)
    HAS_CHEMICAL(Product, prod_title, Chemical, chemical_id)

File: PUC_dictionary_20201216.csv

    PUC_Category(gen_cat)
    PUC_Family(prod_fam)
    PUC_Type(puc_id)
        name:String
        description:string
        code:String
        kind:String

    HAS_FAMILY(PUC_Category, gen_cat, PUC_Family, prod_fam)
    HAS_TYPE(PUC_Family, prod_fam, PUC_Type, puc_id)