@AbapCatalog.sqlViewName: 'ZAFK_CDS_2_2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds test 2_2'
define view zafk_000_cds_2_2
  as select from zafk_000_cds_2_1 as cds1
{
  cds1.vbeln,
  sum( cds1.conversion_netwr )    as toplam_net_deger,
  cds1.kunnrAd                    as musteri_ad_soyad,
  count( distinct cds1.vbeln )    as toplam_fatura_adedi,
  division( cast(sum( cds1.conversion_netwr ) as abap.dec(10,3) ) , cast(count( distinct cds1.vbeln ) as abap.int4 ) , 3) as ortalama_miktar,
  substring( cds1.fkdat, 1, 4 )   as faturalama_yili,
  substring( cds1.fkdat, 5, 2 )   as faturalama_ayi,
  substring( cds1.fkdat, 6, 2 )   as faturalama_gunu,
  substring( cds1.inco2_l, 1, 4 ) as incoterm_yeri

}
group by
  cds1.vbeln,
  cds1.kunnrAd,
  cds1.fkdat,
  cds1.inco2_l
