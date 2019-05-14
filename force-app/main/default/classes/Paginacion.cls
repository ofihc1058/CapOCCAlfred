global class Paginacion {
	public Integer pageNumber { get; set; }
	public Integer pageSize { get; set; }
	public Integer totalPageNumber { get; set; }
	public Integer elementosListado { get; set; }
	public Integer counter  { get; set; }
	public Integer min  { get; set; }
	public Integer max  { get; set; }
	
	public Paginacion(){
		pageNumber = 0;
		totalPageNumber = 0;
		elementosListado=0;
		pageSize = 10;
	}
	public Paginacion(Integer elementosEnLista){
		system.debug('elementosEnLista:' + elementosEnLista);
		pageNumber = 0;
		totalPageNumber = 0;
		elementosListado=elementosEnLista;
		pageSize = 20;
		system.debug('getTotalPageNumber antes:' + totalPageNumber);
		getTotalPageNumber();
		system.debug('getTotalPageNumber despues:' + totalPageNumber);
	}
	public Boolean getPreviousButtonEnabled()
	{
		return !(pageNumber > 1);
	}
	public Boolean getNextButtonDisabled()
	{
		if (elementosListado < 1) return true;
	else
		return ((pageNumber * pageSize) >= elementosListado);
	}
	public Integer getTotalPageNumber()
	{
		if (totalPageNumber == 0 && elementosListado > 0)
		{	
			system.debug('getTotalPageNumber dentro:' + totalPageNumber);
			totalPageNumber = elementosListado / pageSize;
			Integer mod = elementosListado - (totalPageNumber * pageSize);
			if (mod > 0) 
				totalPageNumber++;
		}
		system.debug('getTotalPageNumber antes salir:' + totalPageNumber);
		return totalPageNumber;
		
	}
	public void ActualizaMinMax(Integer newPageIndex){
		if (newPageIndex > pageNumber)
		{
			min = pageNumber * pageSize;
			max = newPageIndex * pageSize;
		}
		else
		{
			max = newPageIndex * pageSize;			
			min = max - pageSize;
		}
	}
	/**************** Metodos de prueba ***********************/
	
	static testMethod void TestGetContractedPackages() {
		Paginacion paginas= new Paginacion();
		paginas= new Paginacion(10);
		Boolean previaPag= paginas.getPreviousButtonEnabled();
		Boolean siguientPag = paginas.getNextButtonDisabled();
		Integer paginasTotales=paginas.getTotalPageNumber();
		paginas.ActualizaMinMax(1);
		Integer pagiNo=	paginas.pageNumber + 2;
		paginas.ActualizaMinMax(pagiNo);
		paginas.pageNumber=1;
		pagiNo=	paginas.pageNumber + 2;
		paginas.ActualizaMinMax(pagiNo);
	}	
}