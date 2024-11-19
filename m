Return-Path: <linux-acpi+bounces-9658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C569D264A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060192819A7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04D1CC154;
	Tue, 19 Nov 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tBFXghsO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411F26AD3;
	Tue, 19 Nov 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021308; cv=none; b=QNGNTxa1LFuRhTbMa3uIlq+2Svxh9pocYpCs1ilHXhNFgfPiCnGOk5TyUmLq48NjLlXGkJG6yMu2tbrwGHj6gglU83QsD73R4wh82w7ZEd73ZZhqid0BDYZB/NmuEWk4zsG47MQ60JT9K3df1Kenp0thy6Dta0+Rj7JEDRaisMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021308; c=relaxed/simple;
	bh=vs7geAAh3IgaGjhfidahLn31KbuXOzFaEbksLVAseC8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NSOD7YyeNGG6YzLChSw77dHGWpdgJnIZZBRUWDU6F8yUuHacS02kSX6x042FDPB6rSXnSlQIDPCLi7nrQofvsPOIEsVevasTM7AhcUiVmZdt0J+n1uCea0GiQwaDxrOBkL1m2V3F9V3aSPT7T+/JHNlamswNYjL4133pY17fSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tBFXghsO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732021218; x=1732626018; i=w_armin@gmx.de;
	bh=vs7geAAh3IgaGjhfidahLn31KbuXOzFaEbksLVAseC8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tBFXghsOBKwr3FO3Zu1hZuqEWldBDCqBplyfIlhlt2zQVimNoiDeWccqwW/UM7aw
	 K8dwzG/J/htFoGHdsRQWb/itcZwVg9u7JIYWU+QADRBWBnBLlC+ZC07JmBrtM+ZT7
	 HYVP5qNMi3SurMJOSmGW7VVgxxwhsFLKJHSL0PlEXmBrMy9Im9UnO2F6ogiuIEQA7
	 NFEXq6tUJHs6VxR++j4KZDx3ZUjp9KSyBAECRbuUJ6CeGkV+Yb3k7tVC6mPtJaqvY
	 8EKrHrOKlN0Mipy+Jo/gaImYl23FLRE/bNxP7lreFw0H6QDZGbjws8Q/q6r/bJC4F
	 KlyoYAgjM1vWAEHymA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.87.225] ([141.76.181.126]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1t2xRI1buE-005Vzl; Tue, 19
 Nov 2024 14:00:18 +0100
Message-ID: <3331c9f8-0590-4d3d-b9ae-7bdc22473d7a@gmx.de>
Date: Tue, 19 Nov 2024 14:00:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/22] ACPI: platform_profile: Check all profile
 handler to calculate next
From: Armin Wolf <W_Armin@gmx.de>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-19-mario.limonciello@amd.com>
 <5c961eaa-9a3b-48cb-a0dc-f704dbb267ab@gmx.de>
Content-Language: en-US
In-Reply-To: <5c961eaa-9a3b-48cb-a0dc-f704dbb267ab@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:fbsBGDLc0FOzSPdO6OnojaVkO5MvsDr6/JGhGldEg58Q1FGNhrl
 Ivjj6VXPSxYctIIcsCylv0F+GErICXCyan9vFfXhr8XX44ksRH9BRpRt7zOfLJXqLGzhKNY
 LF+CVsxqxvU8C7s5k+YsB+2ssaoJiuj2knEt98oSRLSKHwWWwijz30L3nh+reSMHLR4m/AW
 BST+4JNHg+yLXkyTfWicQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xbzu5487ub4=;NnEQSykyd391YdQIpT4MPSJ5ILv
 edgyN5lGm5TX+ak1DoKWR7WHpEhvFEKI++osqvCxFClgCPLBQI/3uRiTQzy6iqKXBZJfjsLCQ
 YnfXDbq1OpqFCZApKSfT/dDsK9gEt6wyw/EJt3wxWa/k2TEQ7CIzK5Ac3YJJVl4jOAlv00grC
 GILtkiti4mndp40K1Amnm6Wy5sqnnsGtnxrq5RBYzanokLRUONJLBgPCtJ2/YPQnPHuMyrzM3
 2MYy61JGx0o1yP2q3Peogr6g4dm0abntL7Cuh7fJEtVQu0FMihQ+4M6rEk/6kVx/ki4t+yT5k
 RnH/p1xcY82SSCeK+JZD1HlxsJEOHRzDBsoY97UVahaN/yivPhHeJNY3m6Xl0aUkFWYq3bLhL
 wSrZ50sdB44tFha1URLwoxBL4cm9+DjGXZR/9Au0dUq6iGIWw3QnOadzUlybnIPSqLMVyyqDA
 eT1l36462UQK6xj8/RJex7ulXLdIV/9gnQ4YdGx0+4yNgHTU085DzAYRM6pcmYTNbbI96SWsJ
 36dSk+wRS4rZI7/yGjPIRVnM8AmuH37mCuNUFT6LaqlZbqRRKfjRpCYH+e15RQgUMC7b4Aksu
 MoG8FnB6AqCKTrT1nBhj5Umfqv6tzfqqVXInpvy9YmDk+rc9iCkih+Ydy06WlDmA4hBt6xoG2
 nlZFIIiTf386b5ktEN4+0uCzYmdb1UJZNeIENIUh/Pngq9IgfHsObt1GsuOlLU4RBm/YSUsvg
 2ewY7QkDQSfMSryJ9NIYVjBpVwnuUrwTZO+sSuW4sOJYYrHr4M3uppJ6/w5L1VK5xh1FYvFPh
 A55gyUmSKPN+YMeNOf92AzeeB+vn3QqmeY9arrR2rqvEA8HXTk9Grw/uHNOCAFaaHZIaA8jmV
 9EeWaoeOuko1fZMY+gDuOGMcEwreV5AyKTYcwdQbCcjGPfHjUtk7ozajB

QW0gMTguMTEuMjQgdW0gMjA6NTMgc2NocmllYiBBcm1pbiBXb2xmOg0KDQo+IEFtIDA5LjExLjI0
IHVtIDA1OjQxIHNjaHJpZWIgTWFyaW8gTGltb25jaWVsbG86DQo+DQo+PiBBcyBtdWx0aXBsZSBw
bGF0Zm9ybSBwcm9maWxlIGhhbmRsZXJzIG1pZ2h0IG5vdCBhbGwgc3VwcG9ydCB0aGUgc2FtZQ0K
Pj4gcHJvZmlsZSwgY3ljbGluZyB0byB0aGUgbmV4dCBwcm9maWxlIGNvdWxkIGhhdmUgYSBkaWZm
ZXJlbnQgcmVzdWx0DQo+PiBkZXBlbmRpbmcgb24gd2hhdCBoYW5kbGVyIGFyZSByZWdpc3RlcmVk
Lg0KPj4NCj4+IENoZWNrIHdoYXQgaXMgYWN0aXZlIGFuZCBzdXBwb3J0ZWQgYnkgYWxsIGhhbmRs
ZXJzIHRvIGRlY2lkZSB3aGF0DQo+PiB0byBkby4NCj4NCj4gUmV2aWV3ZWQtYnk6IEFybWluIFdv
bGYgPFdfQXJtaW5AZ214LmRlPg0KPg0KPj4gVGVzdGVkLWJ5OiBNYXJrIFBlYXJzb24gPG1wZWFy
c29uLWxlbm92b0BzcXVlYmIuY2E+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxs
byA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gdjY6DQo+PiDCoCAqIEhh
bmRsZSBjYXNlcyBvZiBpbmNvbnNpc3RlbnQgcHJvZmlsZXMgb3IgYWxsIHByb2ZpbGUgaGFuZGxl
cnMNCj4+IMKgwqDCoCBzdXBwb3J0aW5nIGN1c3RvbS4NCj4+IHY1Og0KPj4gwqAgKiBBZGp1c3Qg
bXV0ZXggdXNlDQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvYWNwaS9wbGF0Zm9ybV9wcm9maWxlLmMg
fCAzMCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2FjcGkvcGxhdGZvcm1fcHJvZmlsZS5jIA0KPj4gYi9kcml2ZXJzL2FjcGkvcGxhdGZv
cm1fcHJvZmlsZS5jDQo+PiBpbmRleCAyNjc2ZjRhMTM2ODllLi5jNTc0NDgzYmU0ZmQxIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYw0KPj4gKysrIGIvZHJp
dmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYw0KPj4gQEAgLTQyMywyOCArNDIzLDQwIEBAIEVY
UE9SVF9TWU1CT0xfR1BMKHBsYXRmb3JtX3Byb2ZpbGVfbm90aWZ5KTsNCj4+DQo+PiDCoCBpbnQg
cGxhdGZvcm1fcHJvZmlsZV9jeWNsZSh2b2lkKQ0KPj4gwqAgew0KPj4gLcKgwqDCoCBlbnVtIHBs
YXRmb3JtX3Byb2ZpbGVfb3B0aW9uIHByb2ZpbGU7DQo+PiAtwqDCoMKgIGVudW0gcGxhdGZvcm1f
cHJvZmlsZV9vcHRpb24gbmV4dDsNCj4+ICvCoMKgwqAgZW51bSBwbGF0Zm9ybV9wcm9maWxlX29w
dGlvbiBuZXh0ID0gUExBVEZPUk1fUFJPRklMRV9MQVNUOw0KPj4gK8KgwqDCoCBlbnVtIHBsYXRm
b3JtX3Byb2ZpbGVfb3B0aW9uIHByb2ZpbGUgPSBQTEFURk9STV9QUk9GSUxFX0xBU1Q7DQo+PiAr
wqDCoMKgIHVuc2lnbmVkIGxvbmcgY2hvaWNlc1tCSVRTX1RPX0xPTkdTKFBMQVRGT1JNX1BST0ZJ
TEVfTEFTVCldOw0KPj4gwqDCoMKgwqDCoCBpbnQgZXJyOw0KPj4NCj4+IMKgwqDCoMKgwqAgaWYg
KCFjbGFzc19pc19yZWdpc3RlcmVkKCZwbGF0Zm9ybV9wcm9maWxlX2NsYXNzKSkNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4+DQo+PiArwqDCoMKgIHNldF9iaXQoUExB
VEZPUk1fUFJPRklMRV9MQVNULCBjaG9pY2VzKTsNCj4+IMKgwqDCoMKgwqAgc2NvcGVkX2NvbmRf
Z3VhcmQobXV0ZXhfaW50ciwgcmV0dXJuIC1FUkVTVEFSVFNZUywgDQo+PiAmcHJvZmlsZV9sb2Nr
KSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFjdXJfcHJvZmlsZSkNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PREVWOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IGNs
YXNzX2Zvcl9lYWNoX2RldmljZSgmcGxhdGZvcm1fcHJvZmlsZV9jbGFzcywgTlVMTCwNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwcm9maWxlLCBf
YWdncmVnYXRlX3Byb2ZpbGVzKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCj4+DQo+PiAtwqDCoMKgwqDCoMKgwqAg
ZXJyID0gY3VyX3Byb2ZpbGUtPnByb2ZpbGVfZ2V0KGN1cl9wcm9maWxlLCAmcHJvZmlsZSk7DQo+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHByb2ZpbGUgPT0gUExBVEZPUk1fUFJPRklMRV9DVVNUT00g
fHwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByb2ZpbGUgPT0gUExBVEZPUk1fUFJPRklM
RV9MQVNUKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiAr
DQo+PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gY2xhc3NfZm9yX2VhY2hfZGV2aWNlKCZwbGF0Zm9y
bV9wcm9maWxlX2NsYXNzLCBOVUxMLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY2hvaWNlcywgX2FnZ3JlZ2F0ZV9jaG9pY2VzKTsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGVycjsNCj4+DQo+PiAtwqDCoMKgwqDCoMKgwqAgbmV4dCA9IGZpbmRfbmV4dF9iaXRfd3Jh
cChjdXJfcHJvZmlsZS0+Y2hvaWNlcywgDQo+PiBQTEFURk9STV9QUk9GSUxFX0xBU1QsDQo+PiAr
wqDCoMKgwqDCoMKgwqAgLyogbmV2ZXIgaXRlcmF0ZSBpbnRvIGEgY3VzdG9tIGlmIGFsbCBkcml2
ZXJzIHN1cHBvcnRlZCBpdCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgIGNsZWFyX2JpdChQTEFURk9S
TV9QUk9GSUxFX0NVU1RPTSwgY2hvaWNlcyk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgbmV4
dCA9IGZpbmRfbmV4dF9iaXRfd3JhcChjaG9pY2VzLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQTEFURk9STV9QUk9GSUxFX0xBU1QsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByb2ZpbGUgKyAxKTsNCj4+
DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT04obmV4dCA9PSBQTEFURk9STV9QUk9GSUxF
X0xBU1QpKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgZXJyID0gY2xhc3NfZm9yX2VhY2hfZGV2aWNlKCZwbGF0Zm9ybV9wcm9m
aWxlX2NsYXNzLCBOVUxMLCANCj4+ICZuZXh0LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX3N0b3JlX2NsYXNzX3Byb2ZpbGUpOw0KDQpJIGp1c3Qg
bm90aWNlZCB0aGF0IHRoZSBjbGFzcyBkZXZpY2UgaXMgbm90IG5vdGlmaWVkIGhlcmUuIFBsZWFz
ZSB1c2UgX3N0b3JlX2FuZF9ub3RpZnkoKSBpbnN0ZWQgb2YgX3N0b3JlX2NsYXNzX3Byb2ZpbGUo
KQ0KaGVyZS4NCg0KVGhhbmtzLA0KQXJtaW4gV29sZg0KDQo+Pg0KPj4gLcKgwqDCoMKgwqDCoMKg
IGVyciA9IGN1cl9wcm9maWxlLT5wcm9maWxlX3NldChjdXJfcHJvZmlsZSwgbmV4dCk7DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBlcnI7DQo+PiDCoMKgwqDCoMKgIH0NCj4NCg==

