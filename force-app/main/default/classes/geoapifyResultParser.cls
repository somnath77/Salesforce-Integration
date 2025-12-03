public class geoapifyResultParser{
    public list<features> features{get;set;}
    public query query{get;set;}
    public String type{get;set;}
	public class timezone{
		public String offset_DST{get;set;}
		public Integer offset_STD_seconds{get;set;}
		public Integer offset_DST_seconds{get;set;}
		public String offset_STD{get;set;}
		public String abbreviation_STD{get;set;}
		public String name{get;set;}
		public String abbreviation_DST{get;set;}
	}
	public class rank{
		public String match_type{get;set;}
		public Decimal confidence{get;set;}
		public Decimal popularity{get;set;}
	}
	public class query{
		public String text{get;set;}
		public parsed parsed{get;set;}
	}
	public class properties{
		public String address_line2{get;set;}
		public String result_type{get;set;}
		public String formatted{get;set;}
		public Decimal lat{get;set;}
		public String address_line1{get;set;}
		public Decimal lon{get;set;}
		public timezone timezone{get;set;}
		public String state_code{get;set;}
		public String plus_code{get;set;}
		public String state{get;set;}
		public String iso3166_2{get;set;}
		public datasource datasource{get;set;}
		public rank rank{get;set;}
		public String country{get;set;}
		public String name{get;set;}
		public String place_id{get;set;}
		public String country_code{get;set;}
	}
	public class parsed{
		public String postcode{get;set;}
		public String state{get;set;}
		public String country{get;set;}
		public String city{get;set;}
		public String expected_type{get;set;}
		public String street{get;set;}
	}
	public class geometry{
		public list<String> coordinates{get;set;}
		public String type{get;set;}
	}
	public class features{
		public properties properties{get;set;}
		public geometry geometry{get;set;}
		public list<String> bbox{get;set;}
		public String type{get;set;}
	}
	public class datasource{
		public String url{get;set;}
		public String attribution{get;set;}
		public String license{get;set;}
		public String sourcename{get;set;}
	}
}