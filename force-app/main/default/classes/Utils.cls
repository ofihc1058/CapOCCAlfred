public with sharing class Utils {
    
public static Map<string,string> ESTADOS = new Map<string,string>{
'Aguascalientes'=>'AGS','Baja California Norte'=>'BC','Baja California Sur'=>'BCS',
'Campeche'=>'CAM','Chiapas'=>'CHS','Chihuahua'=>'CHI','Coahuila'=>'COA','Colima'=>'COL',
'Distrito Federal'=>'DF','Durango'=>'DUR','Estado de México'=>'MEX','Guanajuato'=>'GTO',
'Guerrero'=>'GRO','Hidalgo'=>'HID','Jalisco'=>'JAL','Michoacán'=>'MCH','Morelos'=>'MOR',
'Nayarit'=>'NAY','Nuevo León'=>'NL','Oaxaca'=>'OAX','Puebla'=>'PUE','Querétaro'=>'QUE',
'Quintana Roo'=>'QR','San Luis Potosí'=>'SLP','Sinaloa'=>'SIN','Sonora'=>'SON',
'Tabasco'=>'TAB','Tamaulipas'=>'TAM','Tlaxcala'=>'TLA','Veracruz'=>'VER','Yucatán'=>'YUC',
'Zacatecas'=>'ZAC','Estado de Mexico'=>'EM','Ciudad de Mexico'=>'MCD','Ciudad de México'=>'CDM'
};

public static Map<string,string> TERRITORIOS = new Map<string,string>{
'Nacional'=>'1'  ,
'Aguascalientes'=>'124','Baja California Norte'=>'3','Baja California Sur'=>'4',
'Campeche'=>'5','Chiapas'=>'6','Chihuahua'=>'7','Coahuila'=>'8','Colima'=>'9',
'Durango'=>'10','Guanajuato'=>'11','Guerrero'=>'12','Distrito Federal'=>'13',
'Estado de México'=>'14','Hidalgo'=>'15','Jalisco'=>'16','Michoacán'=>'17','Morelos'=>'18',
'Nayarit'=>'19','Nuevo León'=>'20','Oaxaca'=>'21','Puebla'=>'22','Querétaro'=>'23',
'Quintana Roo'=>'24','San Luis Potosí'=>'25','Sinaloa'=>'26','Sonora'=>'27',
'Tabasco'=>'28','Tamaulipas'=>'29','Tlaxcala'=>'30','Veracruz'=>'31','Yucatán'=>'32',
'Zacatecas'=>'33', 'Ciudad de México'=>'126', 'DF'=>'2'
};

public static Map<string,string> PAISES = new Map<string,string>{
'Afghanistan'=>'AF','Åland Islands'=>'AX','Albania'=>'AL','Algeria'=>'DZ',
'American Virg.Islnd'=>'VI','Andorra'=>'AD','Angola'=>'AO','Anguilla'=>'AI',
'Antartica'=>'AQ','Antigua y Barbuda'=>'AG','Argentina'=>'AR','Armenia'=>'AM',
'Aruba'=>'AW','Australia'=>'AU','Austria'=>'AT','Azerbayan'=>'AZ','Bahamas'=>'BS',
'Bahrein'=>'BH','Bangladesh'=>'BD','Barbados'=>'BB','Belarus'=>'BY','Belgica'=>'BE',
'Belice'=>'BZ','Benin'=>'BJ','Bermuda'=>'BM','Bhutan'=>'BT','Bolivia'=>'BO',
'Bosnia-Herzegovina'=>'BA','Botswana'=>'BW','Bouvet Island'=>'BV','Brasil'=>'BR',
'Brit.Ind.Oc.Ter'=>'IO','British Virg. Islnd'=>'VG','Brunei Dar-es-S'=>'BN',
'Bulgaria'=>'BG','Burkina Faso'=>'BF','Burundi'=>'BI','Camboya'=>'KH',
'Camerun'=>'CM','Canada'=>'CA','Cabo Verde'=>'CV','Islais Caiman'=>'KY',
'Rep. Centroafricana'=>'CF','Chad'=>'TD','Chile'=>'CL','China'=>'CN',
'Christmas Island'=>'CX','Islas Coconut'=>'CC','Colombia'=>'CO',
'Comoras'=>'KM','Congo'=>'CG','Congo, R. D.'=>'CD','Cook Islands'=>'CK',
'Costa Rica'=>'CR','Croacia'=>'HR','Cuba'=>'CU','Cyprus'=>'CY',
'Rep. Chec'=>'CZ','Dinamarca'=>'DK','Djibouti'=>'DJ','Dominica'=>'DM',
'Rep. Dominicana'=>'DO','Dutch Antilles'=>'AN','Timor Oriental'=>'TL',
'Ecuador'=>'EC','Egipto'=>'EG','El Salvador'=>'SV','Guinea Ecuatorial'=>'GQ',
'Eritrea'=>'ER','Estonia'=>'EE','Etiopia'=>'ET','Falkland Islands'=>'FK',
'Faroe Islands'=>'FO','Fiji'=>'FJ','Finlandia'=>'FI','Francia'=>'FR',
'Guyana Francesa'=>'GF','Polinesia Francesa'=>'PF','French S.Territ'=>'TF',
'Gabon'=>'GA','Gambia'=>'GM','Georgia'=>'GE','Alemania'=>'DE','Ghana'=>'GH',
'Gibraltar'=>'GI','Grecia'=>'EL','Groenlandia'=>'GL','Granada'=>'GD',
'Guadalupe'=>'GP','Guam'=>'GU','Guatemala'=>'GT','Guernsey'=>'GG',
'Guinea'=>'GN','Guinea-Bissau'=>'GW','Guyana'=>'GY','Haiti'=>'HT',
'Heard/McDnld Islnds'=>'HM','Honduras'=>'HN','Hong Kong'=>'HK',
'Hungria'=>'HU','Islandia'=>'IS','India'=>'IN','Indonesia'=>'ID',
'Iran'=>'IR','Iraq'=>'IQ','Irlanda'=>'IE','Isle of Man'=>'IM',
'Israel'=>'IL','Italia'=>'IT','Ivory Coast'=>'CI','Jamaica'=>'JM',
'Japon'=>'JP','Jersey'=>'JE','Jordan'=>'JO','Kazakhstan'=>'KZ',
'Kenya'=>'KE','Kiribati'=>'KI','Kuwait'=>'KW','Kyrgyzstan'=>'KG',
'Laos'=>'LA','Latvia'=>'LV','Lebanon'=>'LB','Lesotho'=>'LS',
'Liberia'=>'LR','Libya'=>'LY','Liechtenstein'=>'LI','Lituania'=>'LT',
'Luxemburgo'=>'LU','Macau'=>'MO','Madagascar'=>'MG','Malawi'=>'MW',
'Malaysia'=>'MY','Maldivas'=>'MV','Mali'=>'ML','Malta'=>'MT',
'Marshall'=>'MH','Martinica'=>'MQ','Mauritania'=>'MR','Mauritius'=>'MU',
'Mayotte'=>'YT','México'=>'MX','Micronesia'=>'FM','Minor Outl.Ins.'=>'UM',
'Moldova'=>'MD','Monaco'=>'MC','Mongolia'=>'MN','Montenegro'=>'ME',
'Montserrat'=>'MS','Morocco'=>'MA','Mozambique'=>'MZ','Myanmar'=>'MM',
'N.Mariana Island'=>'MP','Namibia'=>'NA','Nauru'=>'NR','Nepal'=>'NP',
'Holanda'=>'NL','New Caledonia'=>'NC','Nueva Zelandia'=>'NZ',
'Nicaragua'=>'NI','Niger'=>'NE','Nigeria'=>'NG','Niue Islands'=>'NU',
'Norfolk Island'=>'NF','Corea del Norte'=>'KP','Noruega'=>'NO',
'Oman'=>'OM','Pakistan'=>'PK','Palau'=>'PW','Palestinian Territory'=>'PS',
'Panama'=>'PA','Papua-Nueva Guinea'=>'PG','Paraguay'=>'PY',
'Peru'=>'PE','Filipinas'=>'PH','Pitcairn Islands'=>'PN',
'Polonia'=>'PL','Portugal'=>'PT','Puerto Rico'=>'PR','Qatar'=>'QA',
'Macedonia'=>'MK','Reunion'=>'RE','Rumania'=>'RO','Ruanda'=>'RW',
'Rusia'=>'RU','S. Sandwich Ins'=>'GS','S.Tome,Principe'=>'ST',
'Saint Barthelemy'=>'BL','Saint Martin'=>'MF','Samoa, American'=>'AS',
'San Marino'=>'SM','Arabia Saudita'=>'SA','Schweiz'=>'CH','Senegal'=>'SN',
'Serbia'=>'RS','Seychelles'=>'SC','Sierra Leonea'=>'SL','Singapur'=>'SG',
'Eslovaquia'=>'SK','Eslovenia'=>'SI','Islas Salomon'=>'SB',
'Somalia'=>'SO','Sudafrica'=>'ZA','Corea del Sur'=>'KR',
'España'=>'ES','Sri Lanka'=>'LK','St Kitts & Nevis'=>'KN',
'Santa Helena'=>'SH','Santa Lucia'=>'LC','San Vicente'=>'VC',
'St.Pier,Miquel.'=>'PM','Sudan'=>'SD','Suriname'=>'SR',
'Svalbard'=>'SJ','Swazilandia'=>'SZ','Suecia'=>'SE',
'Syria'=>'SY','Taiwan'=>'TW','Tayikistan'=>'TJ','Tanzania'=>'TZ',
'Tailandia'=>'TH','Togo'=>'TG','Tokelau Islands'=>'TK','Tonga'=>'TO',
'Trinidad y Tabago'=>'TT','Tunez'=>'TN','Turquia'=>'TR',
'Turkmenistan'=>'TM','Turksh Caicosin'=>'TC','Tuvalu'=>'TV',
'Uganda'=>'UG','Ucrania'=>'UA','Emiratos Arabes Unidos'=>'AE',
'Reino Unido'=>'GB','Uruguay'=>'UY','USA'=>'US','Uzbekistan'=>'UZ',
'Vanuatu'=>'VU','Santa Sede (Vaticano)'=>'VA','Venezuela'=>'VE',
'Vietnam'=>'VN','Wallis,Futuna'=>'WF','West Sahara'=>'EH',
'Western Samoa'=>'WS','Yemen'=>'YE','Zambia'=>'ZM','Zimbabwe'=>'ZW'
};

public static Map<string,string> TipoFacturacion = new Map<string,string>{
'Credito'=>'1',
'Credito Programa Preferente'=>'2',
'Credito - TheNetwork'=>'3',
'No Credito'=>'4',
'No Credito (factura previa)'=>'5'
};

public static Map<string,string> EstatusFactura = new Map<string,string>{
'Cobrada'=>'1',
'En transito'=>'2',
'Cancelada'=>'3',
'Sustituida'=>'4',
'Aprobada' => '5' 
};

public static Map<string,string> ClasificacionFactura = new Map<string,string>{
'Facturación'=>'1',
'Sustitución'=>'2',
'Cancelación'=>'3'
};
public static Map<string,string> MetodoPagoSAT = new Map<string,string>{
'NA'=>'NA',
'Efectivo'=>'01',
'Cheque nominativo'=>'02',
'Transferencia electrónica de fondos'=>'03',
'Tarjeta de Crédito'=>'04',
'Monedero Electrónico'=>'05',
'Dinero Electrónico'=>'06',
'Vales de despensa'=>'08',
'Tarjeta de Débito'=>'28',
'Tarjeta de Servicio'=>'29',
'Otros'=>'99'
};

public static String getCountryCode(String country){
    String toReturn ='';
    
    toReturn =  PAISES.get(country);
    if(toReturn==null){
        toReturn ='ND';
    
    }
    return toReturn;
}
public static String getInvoiceType(String invoiceType){
    String toReturn ='';
    
    toReturn =  TipoFacturacion.get(invoiceType);
    if(toReturn==null){
        toReturn ='ND';
    }
    return toReturn;
}
public static String getInvoiceStatus(String invoiceStatus){
    String toReturn ='';
    
    toReturn =  EstatusFactura.get(invoiceStatus);
    if(toReturn==null){
        toReturn ='ND';
    }
    return toReturn;
}
public static String getInvoiceClassification(String invoiceClassification){
    String toReturn ='';
    
    toReturn =  ClasificacionFactura.get(invoiceClassification);
    if(toReturn==null){
        toReturn ='ND';
    }
    return toReturn;
}
public static ResponseWS parseResponse (String xml){
        ResponseWS responseWS = null;
        XMLDom xmlDOM = new XMLDom(xml);
        String codigoString = '';
        String messageString = '';
        XMLDom.Element  codigo = null;
        XMLDom.Element mensaje = null;
        codigo = xmlDOM.getElementByTagName('Codigo');
        
        if(codigo!=null){
            responseWS = new ResponseWS();      
            codigoString = codigo.getAttribute('RetVal');
            responseWS.setStatus(codigoString);
            mensaje = xmlDOM.getElementByTagName('Mensaje');
            if(mensaje!=null){
                    messageString = mensaje.getAttribute('Descripcion');
            }
            responseWS.setMessage(messageString);           
        }   
        codigo = xmlDOM.getElementByTagName('Subcode');
        if(codigo!=null){
            responseWS = new ResponseWS();
            codigo = codigo.getElementByTagName('Value');
            if(codigo!=null){
                codigoString = codigo.textContent();
            }
            responseWS.setStatus(codigoString);
            mensaje = xmlDOM.getElementByTagName('Text');
            if(mensaje!=null){
                messageString = mensaje.textContent();
            }
            responseWS.setMessage(messageString);
        }   
        if(responseWS==null){
            responseWS = new ResponseWS();
            codigo = xmlDOM.getElementByTagName('RetKey');
            if( codigo!=null ){
                responseWS.setMessage(codigo.textContent());
                responseWS.setStatus('0');
            }   
            codigo = xmlDOM.getElementByTagName('Factura');
            if( codigo!=null ){
                responseWS.setMessage('Factura enviada a SAP correctamente');
                responseWS.setStatus('0');
                responseWS.setFactura(codigo.textContent());
                codigo = xmlDOM.getElementByTagName('Pago');
                if( codigo!=null ){
                    responseWS.setPago(codigo.textContent());
                }       
                
            }else {
                codigo = xmlDOM.getElementByTagName('Pago');
                if( codigo!=null ){
                    responseWS.setPago(codigo.textContent());
                    responseWS.setMessage('Factura Cobrada correctamente');
                    responseWS.setStatus('0');              
                }
                //responseWS.setMessage('Factura Cobrada correctamente');
                //responseWS.setStatus('0');                
                else
                {
                    responseWS.setStatus('Com-00001');
                    responseWS.setMessage('Ocurrió un error en la comunicación o procesamiento dentro de SAP');
                }
                
            }       
        }
        return responseWS;
    }

    public static String assembleXMLError(String error){
        return '<?xml version="1.0" encoding="utf-8"?><SAPBO>  <Codigo RetVal="SF-1343" />  <Mensaje Descripcion="'+error+'" /></SAPBO>';
    }
    public static String formatDate(DateTime fecha){
        String toReturn ='';
        
        if(fecha!=null){
            toReturn = fecha.addDays(1).format('yyyyMMdd');
        }
        
        return toReturn;
    }
    
    public static String formatHour(DateTime fecha){
        String toReturn ='';
        
        if(fecha!=null){
            toReturn = fecha.format('hh:mma');
        }
        
        return toReturn;
    }
    
    public static String obtainFacturaType(String tipo){
        if(tipo==null){
            return '1';
        }
        if(tipo.indexOf('No Credito')!=-1){
            return '0';
        }else{
            return '1';
        }
    }
    public static String obtainFacturaStatus(String status){
        if(status==null){
            return '1';
        }
        if(status.indexOf('Cobrada')!=-1){
            return '0';
        }else{
            return '1';
        }
    }
    public static String IDVENTA ='idventa: ';
    public static String parseIdVentaPago(String message){
        Integer index = message.indexOf(IDVENTA);
        if(index!=-1){
            return message.substring(IDVENTA.length());
        }else{
            return '';
        }
    }
    
    public static String getCurrency(String currencyOpp){
        String toReturn=currencyOpp;
        if(currencyOpp=='MXN'){
            toReturn='$';
        }
        return toReturn;
    }
    
    public static String fixExchange(String ex){
        String toReturn = ex;
        if(ex==null||''==ex||'null'==ex){
            return '1';
        }
        
        return toReturn;
    }
    
    public static String getMetodoPagoSAT(String MetodoPago){
        String toReturn ='';
        toReturn =  MetodoPagoSAT.get(MetodoPago);
        if(toReturn==null){
            toReturn ='99';
        }
        return toReturn;
    }

    static testMethod void TestUtils() {
        //Map<string,string> estados= Utils.ESTADOS;
        //Map<string,string> territorios= Utils.TERRITORIOS;
        //Map<string,string> paises =  utils.PAISES;
        String countrycode= Utils.getCountryCode('Mexico');
               countrycode= Utils.getCountryCode(null);
               countrycode= Utils.getCountryCode('LaMexExist');
        ResponseWS responseParse= Utils.parseResponse('<Codigo><Mensaje>Mensaje</Mensaje> <Descripcion>Descripcion</Descripcion> <Subcode>SubCode</Subcode> </Codigo>');
        ResponseWS responseParseb= Utils.parseResponse('<Codigo><Mensaje value="Mensaje">Mensaje</Mensaje> <Descripcion value="Descipcion">Descripcion</Descripcion> <Subcode value="SuboCode">SubCode</Subcode> </Codigo>');
        ResponseWS responseParseb1= Utils.parseResponse('<Codigo><Mensaje>Mensaje</Mensaje> <Descripcion>Descripcion</Descripcion> <Subcode part="SuboCode">SubCode</Subcode> </Codigo>');
        ResponseWS responseParse1= Utils.parseResponse('<?xml version="1.0" encoding="ISO-8859-1"?><Codigo><Mensaje>Mensaje</Mensaje><Descripcion>Descripcion</Descripcion><Subcode>SubCode</Subcode></Codigo>'); 
        ResponseWS responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="ISO-8859-1"?><CodigoMay><Mensaje>Mensaje</Mensaje><Descripcion>Descripcion</Descripcion><Subcode>SubCode</Subcode></CodigoMay>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope"><env:Body><env:Fault><env:Code><env:Value>env:Receiver</env:Value><env:Subcode><env:Value>WS_ReceiverJSON</env:Value></env:Subcode></env:Code><env:Reason><env:Text xml:lang="en">La Oportunidad 0000949487 ya fue registrada con el número de factura 129797</env:Text></env:Reason></env:Fault></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS"><Factura>129807</Factura></dis:RetKeys></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS"><Factura>129807</Factura><Pago>129807</Pago></dis:RetKeys></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS"><Pago>129807</Pago></dis:RetKeys></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS"><OtraCosa>Esta es otra cosa para validar metodo de prueba</OtraCosa></dis:RetKeys></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS"><RetKeys>RetKeys</RetKeys></dis:RetKeys></env:Body></env:Envelope>');
                   responseParse2= Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body></env:Envelope>');
        String assemblixmlerrpot= Utils.assembleXMLError('simulacion de error');
        String fecha= Utils.formatDate(Date.today());
        String hora= Utils.formatHour(Date.today());
        String tipoFactura=Utils.obtainFacturaType(null);
                tipoFactura=Utils.obtainFacturaType('No Credito');
                tipoFactura=Utils.obtainFacturaType('Credito');
        String facturaStatus= Utils.obtainFacturaStatus(null);
               facturaStatus= Utils.obtainFacturaStatus('Cobrada');
               facturaStatus= Utils.obtainFacturaStatus('Pagada');
        String currencyGet= utils.getCurrency('MXN');
        String fixExchange=Utils.fixExchange(null);
        fixExchange=Utils.fixExchange('MXN');
        String invoiceType= Utils.getInvoiceType(null);
               invoiceType= Utils.getInvoiceType('Credito'); 
        String invoiceStatus= Utils.getInvoiceStatus(null);
                invoiceStatus= Utils.getInvoiceStatus('Cobrada');
        String getInvoiceClassification=Utils.getInvoiceClassification(null);
               getInvoiceClassification=Utils.getInvoiceClassification('Facturación');
        String parseidventa=Utils.parseIdVentaPago('');
               parseidventa=Utils.parseIdVentaPago('idventa: ');
               parseidventa=Utils.parseIdVentaPago('idventa: 11111');
              
        String getMetodoPagoSAT=Utils.getMetodoPagoSAT('NA');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Efectivo');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Cheque nominativo');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Transferencia electrónica de fondos');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Tarjeta de Crédito');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Monedero Electrónico');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Dinero Electrónico');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Vales de despensa');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Tarjeta de Débito');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Tarjeta de Servicio');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('Otros');
                getMetodoPagoSAT=Utils.getMetodoPagoSAT('NoValido');
    }
}