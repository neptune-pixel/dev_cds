@AbapCatalog.sqlViewName: 'ZAFK_000_CDS_DDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds test'
define view zafk_000_cds_test as select from ekko
    left outer join ekpo on ekpo.ebeln = ekko.ebeln
    left outer join mara on mara.matnr = ekpo.matnr
    left outer join makt on makt.matnr = mara.matnr
                        and makt.spras = $session.system_language
    left outer join lfa1 on lfa1.lifnr = ekko.lifnr
{
    key ekpo.ebeln,
    key ekpo.ebelp,
    ekpo.matnr,
    makt.maktx,
    ekpo.werks,
    ekpo.lgort,
    ekpo.meins,
    lfa1.lifnr,
    cast( concat( lfa1.stras, lfa1.mcod3 ) as abap.char( 60 ) ) as ad1 
}
