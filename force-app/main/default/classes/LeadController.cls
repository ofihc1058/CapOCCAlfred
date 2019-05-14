@RestResource(urlMapping='/lead/*')
global with sharing class LeadController  {

    @HttpGet
    global static OCCMClasesV2.LeadDto show() {
        RestResponse res = Restcontext.response;
        res.statusCode = 200;
        String id = RestContext.request.params.get('id');
        LeadService service = new LeadService();
        System.debug(id);
        System.debug(service);
        OCCMClasesV2.LeadDto leadDto = service.getLead(id);
        if(leadDto == null) res.statusCode = 404;
        return leadDto;
    }

    @HttpPost
    global static OCCMClasesV2.ResponseLead create() {
        RestResponse res = Restcontext.response;
        OCCMClasesV2.ResponseLead objResponse = new OCCMClasesV2.ResponseLead();
        OCCMClasesV2.LeadDto lead = (OCCMClasesV2.LeadDto)JSON.deserialize(
          RestContext.request.requestBody.toString(),
          OCCMClasesV2.LeadDto.class
        );
        System.debug(lead);
        LeadService service = new LeadService();
        Map<String, Object> response = service.createLead(lead);
        if(response.get('Status') == 'Error') {
            res.statusCode = 409;
            objResponse.Message = response.get('Message').toString();
            res.responseBody = Blob.valueof(response.get('Message').toString());
            System.debug('Message: ' + response.get('Message').toString());
            return objResponse;
        }
        res.statusCode = 201;
        objResponse.Message = 'Created';
        objResponse.Lead = (OCCMClasesV2.LeadDto) response.get('Message');
        return objResponse;

    }

    @HttpPatch
    global static OCCMClasesV2.ResponseLead updateObject() {
        System.debug('Prueba de Patch');
        RestResponse res = Restcontext.response;
        String id = RestContext.request.params.get('id');
        System.debug('Id: ' + id);
        OCCMClasesV2.ResponseLead objResponse = new OCCMClasesV2.ResponseLead();
        Map<String, Object> lead = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        LeadService service = new LeadService();
        Map<String, Object> response = service.patchLeadService(id, lead);
        if(response.get('Status') == 'Error') {
            res.statusCode = 400;
            objResponse.Message = response.get('Message').toString();
            res.responseBody = Blob.valueof(response.get('Message').toString());
            System.debug('Message: ' + response.get('Message').toString());
            return objResponse;
        }
        if(response.get('Status') == 'NOT_FOUND') {
            res.statusCode = 404;
            objResponse.Message = response.get('Message').toString();
            res.responseBody = Blob.valueof(response.get('Message').toString());
            System.debug('Message: ' + response.get('Message').toString());
            return objResponse;
        }
        res.statusCode = 200;
        objResponse.Message = 'Updated';
        objResponse.Lead = (OCCMClasesV2.LeadDto) response.get('Message');
        System.debug(lead);
        return objResponse;

    }

}