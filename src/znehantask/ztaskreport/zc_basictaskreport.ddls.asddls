@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cons. Basic Task Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_BASICTASKREPORT
  as select from ZI_BASICTASKREPORT
{
      @EndUserText.label: 'id'
  key Taskid,
      @EndUserText.label: 'Title'
      Title,
      Description
}
