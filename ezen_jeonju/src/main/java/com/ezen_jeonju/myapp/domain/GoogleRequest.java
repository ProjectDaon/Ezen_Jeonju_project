package com.ezen_jeonju.myapp.domain;

public class GoogleRequest {
	private String clientId;
	private String clientSecret;
	private String responseType;
	private String code;
	private String grantType;
	private String redirectUri;
	
	public String getClientId() {
		return clientId;
	}
	public String getClientSecret() {
		return clientSecret;
	}
	public String getResponseType() {
		return responseType;
	}
	public String getCode() {
		return code;
	}
	public String getGrantType() {
		return grantType;
	}
	
	public GoogleRequest(String clientId, String clientSecret, String responseType, String code, String grantType, String redirectUri) {
		this.clientId = clientId;
		this.clientSecret = clientSecret;
		this.responseType = responseType;
		this.code = code;
		this.grantType = grantType;
		this.redirectUri = redirectUri;
	}
	
	public String getRedirectUri() {
		return redirectUri;
	}

	public static class Builder {
		private String clientId;
		private String clientSecret;
		private String responseType;
		private String code;
		private String grantType;
		private String redirectUri;
		
		public Builder clientId(String clientId) {
			this.clientId = clientId;
			return this;
		}
		public Builder clientSecret(String clientSecret) {
			this.clientSecret = clientSecret;
			return this;
		}
		public Builder responseType(String responseType) {
			this.responseType = responseType;
			return this;
		}
		public Builder code(String code) {
			this.code = code;
			return this;
		}
		public Builder grantType(String grantType) {
			this.grantType = grantType;
			return this;
		}
		public Builder redirectUri(String redirectUri) {
			this.redirectUri = redirectUri;
			return this;
		}
		

		public GoogleRequest build() {
			return new GoogleRequest(clientId, clientSecret, responseType, code, grantType, redirectUri);
		}
	}
}
