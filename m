Return-Path: <linux-acpi+bounces-4344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F398E87C6CD
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 01:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC481F21E19
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783B10F4;
	Fri, 15 Mar 2024 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xpUtXrLD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13364A
	for <linux-acpi@vger.kernel.org>; Fri, 15 Mar 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463155; cv=none; b=qF0PdqAI0Tl0agYziEbXR/FEh6D4h697JkW2tQmOs1T2ryJ8CFm3JDvD/OCzRwhNOlWb56TJINKTODqRGuRl/Rj2ouOsBgna+Hw4ymKBdqBZ8X1m1sN9VhLrncj7C/y9eRM4DqGSkju065oAyof0ZzC3qLRvaym6pIt70wdUzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463155; c=relaxed/simple;
	bh=OYLR286lMK0RbbvfSuwnlIVOsJXDh/dUIXhqnNyYNj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qg5r+t0SkVFzeX37fzVqi1SlPBJfQC/7YMcYvYvMEjyXfHN9ek2wOqavlW8t9aYSOJL6ffO9Sji7bICBbqTEGxMGNGizoiN9ku/s4nJP7Rr+0GWFpES04lY3603GM36DtDh3sBRbeKEPPo8M+8EwqUqbQdsAMciRh1YJ9vXq3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xpUtXrLD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42C512C05FB;
	Fri, 15 Mar 2024 13:39:04 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710463144;
	bh=OYLR286lMK0RbbvfSuwnlIVOsJXDh/dUIXhqnNyYNj0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=xpUtXrLDtaT0iyAjJW8U39i7OkgZ/nn2Ou+k92+woJ4uwznRtw4+rzCTQ37VYaVvU
	 vKOUiBXH/5msM4PhrE0z88GZLeUep4MdMizcuef6lrvqlyNxldshZ9ssFlHEIAG9QU
	 GOINJ2WpIZcTNp5WXi2KgjuPQKzRLq5KjPfItHeRu54QHG2bbvLTHthZSKWq4ulciz
	 1LeVOhHe0jzMqNQm9BQDepPWFq2BiXcXfTjl1KPLs4yleUZZd0cYI6uSaWOouyYtwD
	 pmhKoFotAOEBSgFkjS6zjCXQhq69Z/pA0rbLmnqY9m6LMVL7KyimO7ilwyWKCjoGwQ
	 L8VFrwSHFoeoA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f398a80001>; Fri, 15 Mar 2024 13:39:04 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 13:39:04 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Fri, 15 Mar 2024 13:39:03 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 15 Mar 2024 13:39:03 +1300
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Thread-Topic: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Thread-Index: AQHadPL2e5DSb6pETUy7jtZsYbUE97E0rVeAgAABiACAAOb0gIAAym2AgAC+R4A=
Date: Fri, 15 Mar 2024 00:39:03 +0000
Message-ID: <a0c6898f94d5ca3132a132fc47e8d8e23c36eb4e.camel@alliedtelesis.co.nz>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
	 <ZfGMNWtFrgsuUdLz@smile.fi.intel.com> <ZfGNfucm2-izJBfd@smile.fi.intel.com>
	 <f6833616b81e4e35f561dc0ea4dae8dcd0ac026b.camel@alliedtelesis.co.nz>
	 <ZfL5CYMLY03i8q6u@smile.fi.intel.com>
In-Reply-To: <ZfL5CYMLY03i8q6u@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <146FC29BA448FE4487140143F10DBB50@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=65f398a8 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=fzn4atkRgMAA:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=QyXUC8HyAAAA:8 a=6qSdqfhXhhJZOklO0PgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDE1OjE4ICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20NCndyb3RlOg0KPiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCAwMToxMzozMUFN
ICswMDAwLCBIYW1pc2ggTWFydGluIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wMy0xMyBhdCAx
MzoyNiArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+IFJl
bW92aW5nIHRoZSBzZXR0aW5nIG9mIHRoZSBoYW5kbGUgdG8gaW52YWxpZCBtYXkgYmUgdGhlIHJp
Z2h0IGZpeA0KPiA+IGJ1dA0KPiA+IEkgZG9uJ3QgZmVlbCBJIGtub3cgdGhlIGNvZGUgd2VsbCBl
bm91Z2ggdG8gbWFrZSBhIGRlY2lzaW9uIG9uDQo+ID4gdGhhdC4gSXQNCj4gPiBjZXJ0YWlubHkg
ZG9lc24ndCByZXNvbHZlIHRoaW5ncyBpbW1lZGlhdGVseSAtIEkgc2F3IHJlZiBjb3VudGluZw0K
PiA+IHdhcm5pbmdzIG91dHB1dC4NCj4gDQo+IE5vdCByZW1vdmluZywgYnV0IG1vdmluZyB0byB0
aGUgYmV0dGVyIHBsYWNlPw0KPiBDYW4geW91IHNoYXJlIHdhcm5pbmdzLCB0aG91Z2g/DQo+IA0K
Rm9yIGNvbnRleHQgaGVyZSBpcyB0aGUgY3VycmVudCBjYWxsIGNoYWluIHRoYXQgbGVhZHMgdG8N
CmFjcGlfZ3Bpb2NoaXBfcmVtb3ZlKCk6DQoNCiBhY3BpX2dwaW9jaGlwX3JlbW92ZSsweDMyLzB4
MWEwDQogZ3Bpb2NoaXBfcmVtb3ZlKzB4MzkvMHgxNDANCiBkZXZyZXNfcmVsZWFzZV9ncm91cCsw
eGU2LzB4MTYwDQogaTJjX2RldmljZV9yZW1vdmUrMHgyZC8weDgwDQogZGV2aWNlX3JlbGVhc2Vf
ZHJpdmVyX2ludGVybmFsKzB4MTlhLzB4MjAwDQogYnVzX3JlbW92ZV9kZXZpY2UrMHhiZi8weDEw
MA0KIGRldmljZV9kZWwrMHgxNTcvMHg0OTANCiA/IF9fcGZ4X2RldmljZV9tYXRjaF9md25vZGUr
MHgxMC8weDEwDQogPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KIGRldmljZV91bnJlZ2lz
dGVyKzB4ZC8weDMwDQogaTJjX2FjcGlfbm90aWZ5KzB4MTBlLzB4MTYwDQogbm90aWZpZXJfY2Fs
bF9jaGFpbisweDU4LzB4ZDANCiBibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKzB4M2EvMHg2
MA0KIGFjcGlfZGV2aWNlX2RlbF93b3JrX2ZuKzB4ODUvMHgxZDANCiBwcm9jZXNzX29uZV93b3Jr
KzB4MTM0LzB4MmYwDQogd29ya2VyX3RocmVhZCsweDJmMC8weDQxMA0KID8gX19wZnhfd29ya2Vy
X3RocmVhZCsweDEwLzB4MTANCiBrdGhyZWFkKzB4ZTMvMHgxMTANCiA/IF9fcGZ4X2t0aHJlYWQr
MHgxMC8weDEwDQogcmV0X2Zyb21fZm9yaysweDJmLzB4NTANCiA/IF9fcGZ4X2t0aHJlYWQrMHgx
MC8weDEwDQogcmV0X2Zyb21fZm9ya19hc20rMHgxYi8weDMwDQoNCkkgcmVtb3ZlZCB0aGUgc2V0
dGluZyBvZiBhZGV2LT5oYW5kbGUgPSBJTlZBTElEX0FDUElfSEFORExFIGZyb20NCmFjcGlfc2Nh
bl9kcm9wX2RldmljZSgpIGFuZCBzaGlmdGVkIGl0IHRvIGp1c3QgYWZ0ZXIgdGhlIGNhbGwgdG8N
CmJsb2NraW5nX25vdGlmaWVyX2NhbGxfY2hhaW4oKSBpbiBhY3BpX2RldmljZV9kZWxfd29ya19m
bigpLg0KV2l0aCB0aGF0IGl0IHNlZW1zIHRoaW5ncyBwcm9ncmVzcyBmdXJ0aGVyIHdpdGggdGhl
IGNhbGwgdG8NCmFjcGlfZ2V0X2RhdGEoKSBpbiBhY3BpX2dwaW9jaGlwX3JlbW92ZSgpIHN1Y2Nl
ZWRpbmcgbm93LiBIb3dldmVyLA0KbGF0ZXIgaW4gYWNwaV9ncGlvY2hpcF9mcmVlX3JlZ2lvbnMo
KSB3ZSBoaXQgdGhpcyBlcnJvcjoNCg0KcGNhOTUzeCBpMmMtUFJQMDAwMTowMzogRmFpbGVkIHRv
IHJlbW92ZSBHUElPIE9wUmVnaW9uIGhhbmRsZXINCg0KV2UgYWxzbyBnZXQgdGhlc2UgZXJyb3Jz
Og0KQUNQSSBXYXJuaW5nOiBPYmogMDAwMDAwMDBiYTZhOTYwMCwgUmVmZXJlbmNlIENvdW50IGlz
IGFscmVhZHkgemVybywNCmNhbm5vdCBkZWNyZW1lbnQNCiAoMjAyMzA2MjgvdXRkZWxldGUtNDIy
KQ0KDQo+IFAuUy4NCj4gSSdtIG5vdCBhbiBleHBlcnQgaW4gQUNQSUNBIGFuZCBsb3cgbGV2ZXIg
b2YgQUNQSSBnbHVlIGxheWVyIGluIHRoZQ0KPiBMaW51eA0KPiBrZXJuZWwsIHBlcmhhcHMgUmFm
YWVsIGNhbiBzdWdnZXN0IHNvbWV0aGluZyBiZXR0ZXIuDQo+IA0KT0ssIHRoYW5rcyBmb3IgeW91
ciBoZWxwLiBIb3BlZnVsbHkgUmFmYWVsIGNhbiBhZGQgc29tZXRoaW5nIHRvIHRoZQ0KZGlzY3Nz
aW9uLg0KDQpUaGFua3MsDQpIYW1pc2ggTQ0K

