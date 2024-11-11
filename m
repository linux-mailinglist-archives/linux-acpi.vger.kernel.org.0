Return-Path: <linux-acpi+bounces-9493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E169C430A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464EB1F2557D
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D21A264A;
	Mon, 11 Nov 2024 16:54:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F9197A7F;
	Mon, 11 Nov 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344095; cv=none; b=KYogncUxHS6JQjaiZN4a5/fke/yvkpwZAXu1aVTVM5Lgdo2d5Td9++4NyEhCd3X6xuau7op3mAQC/cXzk17XRuCohnDk7vDfvfpnolSFUzhwFkphzLjuj3ExesU1s1Wvm7xHgqwPIh4d/Fdo8Tv51BnhCagfk+DV00e+X3VotCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344095; c=relaxed/simple;
	bh=cSQCszO5/G7tRrwOeg9ITNK/lngAw/k+fQxuUf5nu6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEjOxnnJVFBBqGFnpkGhUH3a7lGfYUvsXrko8jAZDEY0GK6ft3OxVpYPUH8eQgjG9uUij8pjiQYkKsWOLfWzJa/7zhehvxc+tacSdzi4VQqZhDxJ9sipZtIJ/Fjzy/P8Y1VgHh/nn3/4MYDiEfxK/rDRhoaPJyM6pxTw7dDWSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XnFyR34SVz6LDJc;
	Tue, 12 Nov 2024 00:54:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 91E1D140A08;
	Tue, 12 Nov 2024 00:54:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 17:54:49 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 11 Nov 2024 17:54:49 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Index: AQHbLD8AfemaRx1ca0GejEwzrXB007KmmMAAgABaU4CACv1JgIAAQsYA
Date: Mon, 11 Nov 2024 16:54:48 +0000
Message-ID: <7fd81b442ba3477787f5342e69adbb96@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
 <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
In-Reply-To: <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBh
bGllbjguZGU+DQo+U2VudDogMTEgTm92ZW1iZXIgMjAyNCAxMToyOA0KPlRvOiBTaGlqdSBKb3Nl
IDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPnRv
bnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGRhdmVAc3Rnb2xh
YnMubmV0OyBKb25hdGhhbg0KPkNhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47
IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnN1ZGVlcC5ob2xsYUBhcm0uY29tOyBqYXNz
aXNpbmdoYnJhckBnbWFpbC5jb207IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPmFsaXNvbi5zY2hv
ZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRl
bC5jb207DQo+ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxlby5k
dXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmllbnRqZXNAZ29vZ2xlLmNv
bTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsNCj5Kb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5tb3JzZUBh
cm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBlLmNvbTsg
ZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2VuQGdvb2ds
ZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNv
bTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBodWF3
ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8N
Cj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBmdXR1cmV3
ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBMaW51eGFy
bQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE1IDExLzE1
XSBFREFDOiBBZGQgbWVtb3J5IHJlcGFpciBjb250cm9sIGZlYXR1cmUNCj4NCj5PbiBNb24sIE5v
diAwNCwgMjAyNCBhdCAwMTowNTozMVBNICswMDAwLCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gTW9y
ZSBkZXRhaWxlZCBleHBsYW5hdGlvbiBvZiBQUFIgYW5kIG1lbW9yeSBzcGFyaW5nIGFuZCB1c2Ug
Y2FzZXMgd2FzDQo+PiBhZGRlZCBpbiBEb2N1bWVudGF0aW9uL2VkYWMvbWVtb3J5X3JlcGFpci5y
c3QsIHdoaWNoIGlzIHBhcnQgb2YgdGhlDQo+PiBsYXN0IGNvbW1vbiBwYXRjaCAoIkVEQUM6IEFk
ZCBkb2N1bWVudGF0aW9uIGZvciBSQVMgZmVhdHVyZSBjb250cm9sIikNCj4+IGFkZGVkIGZvciBk
b2N1bWVudGF0aW9uIG9mIHZhcmlvdXMgUkFTIGZlYXR1cmVzIHN1cHBvcnRlZCBpbiB0aGlzDQo+
PiBzZXJpZXMuIFdhcyBub3Qgc3VyZSB0aGUgZmlsZSB0byBiZSBwYXJ0IG9mIHRoaXMgcGF0Y2gg
b3Igbm90Lg0KPg0KPklmIHRoZSBjb21taXQgbWVzc2FnZSBkb2Vzbid0IGNvbnRhaW4gYSBqdXN0
aWZpY2F0aW9uIGZvciBhIHBhdGNoJ3MgZXhpc3RlbmNlLA0KPndoeSBkbyB5b3UgZXZlbiBib3Ro
ZXIgc2VuZGluZyBpdD8NClN1cmUuIEkgdXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBl
eGFtcGxlIENYTCB1c2UgY2FzZXMuDQoNCj4NCj5JT1csIG5vIHJlZGlyZWN0aW9ucyBwbHMgLSBq
dXN0IHN0YXRlIGhlcmUgd2hhdCB0aGUgdXNlIGNhc2UgaXMgaW4gc2hvcnQuIFlvdSBjYW4NCj5h
bHdheXMgZ28gbnV0cyBpbnRvIGRldGFpbHMgaW4gdGhlIGRvY3MuDQo+DQo+PiBwZXJzaXN0X21v
ZGUgdXNlZCB0byByZWFkYmFjayB0aGUgdmFsdWUgb2YgcGVyc2lzdF9tb2RlIHByZXNlbnRseSBz
ZXQuDQo+PiBGb3IgZWcuICAxIC0gc29mdCBtZW1vcnkgc3BhcmluZyBmb3IgYSBzcGFyaW5nIGlu
c3RhbmNlLCB0aG91Z2ggdGhlDQo+PiBDWEwgbWVtb3J5IGRldmljZSBzdXBwb3J0cyBib3RoIHNv
ZnQgYW5kIGhhcmQgc3BhcmluZywgd2hpY2ggaXMgY29uZmlndXJhYmxlLg0KPj4gcGVyc2lzdF9t
b2RlX2F2YWlsIHVzZWQgdG8gcmV0dXJuIHRoZSB0ZW1wb3JhcnkgYW5kIHBlcm1hbmVudCByZXBh
aXINCj4+IGNhcGFiaWxpdHkgb2YgdGhlIGRldmljZS4NCj4NCj5XYWl0LCBzeXNmcyBkb2VzIGEg
b25lIHZhbHVlIHBlciBmaWxlIHRoaW5nLiBXaGF0IGRvZXMgcGVyc2lzdF9tb2RlX2F2YWlsIGdp
dmU/DQoNClByZXNlbnRseSwgMCAoc29mdCBtZW1vcnkgcmVwYWlyKSBhbmQgMSAoaGFyZCBtZW1v
cnkgcmVwYWlyKSwgIGRlcGVuZHMgb24NCndoaWNoIG1vZGUvcyBhIG1lbW9yeSBkZXZpY2UgaXMg
c3VwcG9ydGVkLiAgDQo+DQo+U3VyZWx5IHlvdSBjYW4ndCBkdW1wIGEgbGlzdCBvZiBhbGwgYXZh
aWxhYmxlIG1vZGVzLi4uDQo+DQo+RnJvbSB0aGF0IGRvYzoNCj4NCj5yb290QGxvY2FsaG9zdDp+
IyBjYXQNCj4vc3lzL2J1cy9lZGFjL2RldmljZXMvY3hsX21lbTAvbWVtX3JlcGFpcjAvcGVyc2lz
dF9tb2RlX2F2YWlsDQo+MA0KPg0KPkRvZXMgdGhhdCBtZWFuIG9ubHkgc1BQUiBpcyBhdmFpbGFi
bGU/DQpUaGlzIGV4YW1wbGUgd2FzIGZyb20gdGhlIENYTCBzb2Z0IFBQUiBmZWF0dXJlIGZvciB3
aGljaCBwZXJzaXN0ZW50IG1vZGUgaXMgbm9uLWNvbmZpZ3VyYWJsZSwgYXMgc29mdCByZXBhaXIu
DQpGb3IgQ1hMIGhhcmQgUFBSIGZlYXR1cmUgYWxzbyBwZXJzaXN0ZW50IG1vZGUgaXMgbm9uLWNv
bmZpZ3VyYWJsZSwgYXMgaGFyZCByZXBhaXIuDQpUaHVzIHByZXNlbnRseSBmb3IgQ1hMIFBQUiBm
ZWF0dXJlcywgcGVyc2lzdF9tb2RlX2F2YWlsIGlzIG5vdCByZXF1aXJlZC4NCkJ1dCB0aGVyZSBt
YXkgYmUgc29tZSBub24tQ1hMIG1lbW9yeSBkZXZpY2VzIHdpdGggcnVudGltZSBjb25maWd1cmFi
bGUgcGVyc2lzdGVudCBtb2RlDQpmb3IgUFBSIGZlYXR1cmUuIA0KSG93ZXZlciBmb3IgQ1hMIG1l
bW9yeSBzcGFyaW5nIGZlYXR1cmUsIHRoZSBwZXJzaXN0ZW50IG1vZGUgaXMgY29uZmlndXJhYmxl
IGF0IHJ1bnRpbWUNCmZvciBhIG1lbW9yeSBzcGFyaW5nIGluc3RhbmNlLCB0aHVzIGJvdGggc29m
dCBhbmQgaGFyZCBzcGFyaW5nIGFyZSBzdXBwb3J0ZWQuDQpFeGFtcGxlIGdpdmVuIGZvciBDWEwg
bWVtb3J5IHNwYXJpbmcgZmVhdHVyZSBpbiBEb2N1bWVudGF0aW9uL2VkYWMvbWVtb3J5X3JlcGFp
ci5yc3QsDQpyb290QGxvY2FsaG9zdDp+IyBjYXQgL3N5cy9idXMvZWRhYy9kZXZpY2VzL2N4bF9t
ZW0wL21lbV9yZXBhaXIxL3BlcnNpc3RfbW9kZV9hdmFpbA0KMCwxDQoNCktlcm5lbCBzeXNmcyBk
b2MgbWVudGlvbmVkIGFib3V0IGFycmF5IG9mIHZhbHVlcyBhcyBmb2xsb3dzLCB0aG91Z2ggbm90
IHNlZW4gbXVjaCBleGFtcGxlcy4gDQpodHRwczovL2RvY3Mua2VybmVsLm9yZy9maWxlc3lzdGVt
cy9zeXNmcy5odG1sDQoiQXR0cmlidXRlcyBzaG91bGQgYmUgQVNDSUkgdGV4dCBmaWxlcywgcHJl
ZmVyYWJseSB3aXRoIG9ubHkgb25lIHZhbHVlIHBlciBmaWxlLiBJdCBpcyBub3RlZCB0aGF0DQpp
dCBtYXkgbm90IGJlIGVmZmljaWVudCB0byBjb250YWluIG9ubHkgb25lIHZhbHVlIHBlciBmaWxl
LCBzbyBpdCBpcyBzb2NpYWxseSBhY2NlcHRhYmxlIHRvIGV4cHJlc3MNCmFuIGFycmF5IG9mIHZh
bHVlcyBvZiB0aGUgc2FtZSB0eXBlLiINCj4NCj5JZiBvbmx5IG9uZSBtb2RlIGlzIGF2YWlsYWJs
ZSwgd2h5IGFtIEkgZXZlbiBxdWVyeWluZyB0aGluZ3M/IFRoZXJlJ3Mgbm8gb3RoZXINCj5vcHRp
b24uDQoNCj4NCj5DYXRjaCBteSBkcmlmdD8NCj4NCj4+IEFsc28gSSB3aWxsIHVwZGF0ZSBoZXJl
IHdpdGggbW9yZSBkZXRhaWxzIHdoaWNoIHdhcyBnaXZlbiBpbiB0aGUgbGFzdA0KPj4gcGFydCBv
ZiB0aGlzIGRvY3VtZW50IGFib3V0IERQQS4gIFNvbWUgbWVtb3J5IGRldmljZXMgKEZvciBlZy4g
YSBDWEwNCj4+IG1lbW9yeQ0KPj4gZGV2aWNlKSBtYXkgZXhwZWN0IHRoZSBEZXZpY2UgUGh5c2lj
YWwgQWRkcmVzcyhEUEEpIGZvciBhIHJlcGFpcg0KPj4gb3BlcmF0aW9uIGluc3RlYWQgb2YgSG9z
dCBQaHlzaWNhbCBBZGRyZXNzKEhQQSksIGJlY2F1c2UgaXQgbWF5IG5vdA0KPj4gaGF2ZSBhbiBh
Y3RpdmUgbWFwcGluZyBpbiB0aGUgbWFpbiBob3N0IGFkZHJlc3MgcGh5c2ljYWwgYWRkcmVzcyBt
YXAuDQo+J2RwYV9zdXBwb3J0Jw0KPj4gYXR0cmlidXRlIHVzZWQgdG8gcmV0dXJuIHRoaXMgaW5m
byB0byB0aGUgdXNlci4NCj4NCj5BbGwgdGhpcyBzdHVmZiBuZWVkcyB0byBiZSBkb2N1bWVudGVk
IHByb3Blcmx5IGFuZCBlc3BlY2lhbGx5IGhvdyBvbmUgaXMNCj5zdXBwb3NlZCB0byB1c2UgdGhp
cyBpbnRlcmZhY2UuIE5vdCBoYXZlIHBlb3BsZSBnbyByZWFkIENYTCBzcGVjcyBqdXN0IHRvIGJl
IGFibGUNCj50byBldmVuIHRyeSB0byB1c2UgdGhpcy4gSSdkIGxpa2UgdG8gc2VlIGNsZWFyIHN0
ZXBzIGluIHRoZSBkb2NzIHdoYXQgdG8gZG8gYW5kIHdoYXQNCj50aGV5IG1lYW4uDQoNClN1cmUu
DQoNCj4NCj4+IFRoZSBuaWJibGUgbWFzayBhY3R1YWxseSBmb3IgQ1hMIG1lbW9yeSBQUFIgYW5k
IG1lbW9yeSBzcGFyaW5nDQo+PiBvcGVyYXRpb25zLCB3aGljaCBpcyByZXBvcnRlZCBieSB0aGUg
ZGV2aWNlIGluIERSQU0gRXZlbnQgUmVjb3JkIGFuZA0KPj4gdG8gdGhlIHVzZXJzcGFjZSBpbiB0
aGUgQ1hMIERSQU0gdHJhY2UgZXZlbnQuDQo+PiBQbGVhc2Ugc2VlIHRoZSBkZXRhaWxzIGZyb20g
dGhlIHNwZWMuDQo+DQo+VGhpcyBpcyAqZXhhY3RseSogd2hhdCBJIG1lYW4hDQo+DQo+SWYgSSBo
YXZlIHRvIHNlZSB0aGUgc3BlYyBpbiBvcmRlciB0byB1c2UgYW4gaW50ZXJmYWNlLCB0aGFuIHRo
YXQncyBhIG1ham9yIGZhaWwuDQo+DQo+PiBJIHdhcyBub3Qgc3VyZSBhZGQgb3Igbm90IHRoZXNl
IENYTCBzcGVjaWZpYyBkZXRhaWxzIGluIHRoaXMgRURBQyBkb2N1bWVudC4NCj4NCj5TbyB0aGF0
IGRvY3VtZW50IHNob3VsZCBjb250YWluIGVub3VnaCBpbmZvIG9uIGhvdyB0byB1c2UgdGhlIGlu
dGVyZmFjZS4gWW91DQo+Y2FuIGFsd2F5cyBwdXQgbGlua3MgdG8gdGhlIHNwZWMgZ2l2aW5nIHBl
b3BsZSBmdXJ0aGVyIHJlYWRpbmcgYnV0IHNvbWUgaW5pdGlhbA0KPmhvdy1kby1JLXVzZS10aGlz
LWRhbW4tdGhpbmcgZXhhbXBsZSBzaG91bGQgYmUgdGhlcmUgc28gdGhhdCBwZW9wbGUgY2FuIGZp
bmQNCj50aGVpciB3YXkgYXJvdW5kIHRoaXMuDQo+DQo+PiBUaGUgdmlzaWJpbGl0eSBvZiB0aGVz
ZSBjb250cm9sIGF0dHJpYnV0ZXMgdG8gdGhlIHVzZXIgIGluIHN5c2ZzIGlzDQo+PiBkZWNpZGVk
IGJ5IHRoZSBpc192aXNpYmxlKCkgY2FsbGJhY2sgaW4gdGhlIEVEQUMsIHdoaWNoIGluIHR1cm4N
Cj4+IGRlcGVuZHMgb24gYSBtZW1vcnkgZGV2aWNlIHN1cHBvcnQgb3Igbm90IHRoZSBjb250cm9s
IG9mIGEgcmVwYWlyIGF0dHJpYnV0ZS4NCj4NCj5UaGF0IHN0aWxsIGRvZXNuJ3QgYW5zd2VyIG15
IHF1ZXN0aW9uOiB3aGF0IGFyZSB2YWxpZCB2YWx1ZXMgSSBjYW4gcHV0IGluIGFsbA0KPnRob3Nl
Pw0KDQpUaGUgdmFsdWVzIG9mIHRoZXNlIGF0dHJpYnV0ZXMgYXJlIHNwZWNpZmljIHRvIGRldmlj
ZSBhbmQgcG9ydGlvbiBvZiB0aGUgbWVtb3J5IHRvIHJlcGFpci4gDQpGb3IgZXhhbXBsZSwgSW4g
Q1hMIHJlcGFpciBmZWF0dXJlcywNCkNYTCBtZW1vcnkgZGV2aWNlIGlkZW50aWZpZXMgYSBmYWls
dXJlIG9uIGEgbWVtb3J5IGNvbXBvbmVudCwgZGV2aWNlIHByb3ZpZGVzIHRoZSBjb3JyZXNwb25k
aW5nDQp2YWx1ZXMgb2YgdGhlIGF0dHJpYnV0ZXMgKERQQSwgY2hhbm5lbCwgcmFuaywgbmliYmxl
IG1hc2ssIGJhbmsgZ3JvdXAsIGJhbmssIHJvdywgY29sdW1uIG9yIHN1Yi1jaGFubmVsIGV0YykN
CmluIGFuIGV2ZW50IHJlY29yZCB0byB0aGUgaG9zdCBhbmQgdG8gdGhlIHVzZXJzcGFjZSBpbiB0
aGUgY29ycmVzcG9uZGluZyB0cmFjZSBldmVudC4gIA0KVXNlcnNwYWNlIHNoYWxsIHVzZSB0aGVz
ZSB2YWx1ZXMgZm9yIHRoZSBxdWVyeSByZXNvdXJjZSBhdmFpbGFiaWxpdHkgYW5kIHJlcGFpciBv
cGVyYXRpb25zLg0KDQo+DQo+VHJ5IGFzIG1hbnkgYXMgSSBjYW4gdW50aWwgb25lIHN0aWNrcz8N
Cj4NCj5UaGlzIGlzIG5vdCBhIGdvb2QgaW50ZXJmYWNlLg0KPg0KPkFuZCBzaW5jZSBzeXNmcyBk
b2VzIG9uZS12YWx1ZS1wZXItZmlsZSwgZHVtcGluZyByYW5nZXMgaGVyZSBpcyBraW5kYSB3cm9u
Zy4NCj4NCj4+IFRoaXMgYXR0cmlidXRlIHVzZWQgcmVxdWVzdCB0byBkZXRlcm1pbmUgYXZhaWxh
YmlsaXR5IG9mIHJlc291cmNlcyBmb3INCj4+IGEgcmVwYWlyIG9wZXJhdGlvbiAoRm9yIGVnLiBt
ZW1vcnkgUFBSIGFuZCBzcGFyaW5nIG9wZXJhdGlvbikgZm9yIGEgZ2l2ZW4NCj5hZGRyZXNzIGFu
ZCBtZW1vcnkgYXR0cmlidXRlcyBzZXQuDQo+PiBUaGUgZGV2aWNlIG1heSByZXR1cm4gcmVzdWx0
IGZvciB0aGlzIHJlcXVlc3QgaW4gZGlmZmVyZW50IHdheXMuDQo+PiBGb3IgZXhhbXBsZSwgaW4g
Q1hMIGRldmljZSByZXF1ZXN0IHF1ZXJ5IHJlc291cmNlIGNvbW1hbmQgZm9yIGEsIDEuDQo+PiBQ
UFIgb3BlcmF0aW9uIHJldHVybnMgcmVzb3VyY2UgYXZhaWxhYmlsaXR5IGFzIGEgcmV0dXJuIGNv
ZGUgb2YgdGhlIGNvbW1hbmQuDQo+PiAyLiBtZW1vcnkgc3BhcmluZyBvcGVyYXRpb24sIHRoZSBk
ZXZpY2Ugd2lsbCByZXBvcnQgdGhlIHJlc291cmNlDQo+PiBhdmFpbGFiaWxpdHkgYnkgcHJvZHVj
aW5nIGEgTWVtb3J5IFNwYXJpbmcgRXZlbnQgUmVjb3JkIGFuZCAgbWVtb3J5DQo+c3BhcmluZyB0
cmFjZSBldmVudCB0byB0aGUgdXNlcnNwYWNlLg0KPj4NCj4+IE1heSBiZSAnZHJ5LXJ1bicgYmV0
dGVyIG5hbWUgaW5zdGVhZCBvZiBxdWVyeT8NCj4NCj5NYXliZSB0aGlzIHNob3VsZCBub3QgZXhp
c3QgYXQgYWxsOiBteSBzaW1wbGUgdGhpbmtpbmcgd291bGQgc2F5IHRoYXQNCj5kZXRlcm1pbmlu
ZyB3aGV0aGVyIHJlc291cmNlcyBhcmUgYXZhaWxhYmxlIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBh
Y3R1YWwgcmVwYWlyDQo+b3BlcmF0aW9uLiBJZiBub25lIGFyZSB0aGVyZSwgaXQgc2hvdWxkIHJl
dHVybiAibm8gcmVzb3VyY2VzIGF2YWlsYWJsZSIuIElmIHRoZXJlDQo+YXJlLCBpdCBzaG91bGQg
c2ltcGx5IHVzZSB0aGVtIGFuZCBkbyB0aGUgcmVwYWlyLg0KDQpUaGlzIHdpbGwgd29yayBmb3Ig
dGhlIENYTCBQUFIgZmVhdHVyZSB3aGVyZSB0aGUgcmVzdWx0IG9mIHRoZSBxdWVyeSBvcGVyYXRp
b24gZm9yIHJlc291cmNlcyAgYXZhaWxhYmlsaXR5DQpyZXR1cm4gdG8gdGhlIGNvbW1hbmQsIGhv
d2V2ZXIgZm9yIHRoZSBDWEwgbWVtb3J5IHNwYXJpbmcgZmVhdHVyZXMsICB0aGUgcmVzdWx0IG9m
IHRoZSBxdWVyeSByZXNvdXJjZXMgDQphdmFpbGFiaWxpdHkgY29tbWFuZCByZXR1cm5lZCBsYXRl
ciBpbiBhIE1lbW9yeSBTcGFyaW5nIEV2ZW50IFJlY29yZCBmcm9tIHRoZSBkZXZpY2UuIA0KVXNl
cnNwYWNlIHNoYWxsIGlzc3VlIHJlcGFpciBvcGVyYXRpb24gd2l0aCB0aGUgYXR0cmlidXRlcyB2
YWx1ZXMgcmVjZWl2ZWQgb24gdGhlIE1lbW9yeSBTcGFyaW5nIHRyYWNlIGV2ZW50Lg0KVGh1cyBm
b3IgdGhlIENYTCBtZW1vcnkgc3BhcmluZyBmZWF0dXJlLCBxdWVyeSBmb3IgcmVzb3VyY2VzIGF2
YWlsYWJpbGl0eSBhbmQgcmVwYWlyIG9wZXJhdGlvbiANCmNhbm5vdCBiZSBjb21iaW5lZC4NCg0K
Pg0KPkV4cG9zaW5nIHRoaXMgYXMgYW4gZXhwbGljaXQgc3RlcCBzb3VuZHMgc2lsbHkuDQo+PiA+
WWVoLCB0aGlzIG5lZWRzIHRvIGJlIHBhcnQgb2YgdGhlIGludGVyZmFjZSBhbmQgbm90IGhpZGRl
biBpbiBzb21lIG9ic2N1cmUNCj5kb2MuDQo+PiBBZGRpbmcgdGhpcyBpbmZvIGluIERvY3VtZW50
YXRpb24vZWRhYy9tZW1vcnlfcmVwYWlyLnJzdCBpcyBzdWZmaWNpZW50Pw0KPg0KPllhcCwgZm9y
IGV4YW1wbGUuIFlvdSBjYW4gYWx3YXlzIGNvbmNlbnRyYXRlIHRoZSB3aG9sZSBkb2N1bWVudGF0
aW9uIHRoZXJlDQo+YW5kIHBvaW50IHRvIGl0IGZyb20gZXZlcnl3aGVyZSBlbHNlLg0KDQpJIG1l
cmdlZCB0aGUgY29ycmVzcG9uZGluZyBkb2N1bWVudGF0aW9ucyBpbnRvIGluZGl2aWR1YWwgcGF0
Y2hlcyBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5IGFuZA0KdG8gYXZvaWQgY29uZnVzaW9uLg0KDQo+
DQo+PiBUaGUgZGV0YWlscyBvZiB0aGUgcmVwYWlyaW5nIGNvbnRyb2wgd2FzIGFkZGVkIGluDQo+
PiBEb2N1bWVudGF0aW9uL2VkYWMvbWVtb3J5X3JlcGFpci5yc3QsIHdoaWNoIGlzIHBhcnQgb2Yg
dGhlIGNvbW1vbg0KPj4gcGF0Y2ggKCJFREFDOiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgUkFTIGZl
YXR1cmUgY29udHJvbCIpLg0KPg0KPk9rLCBwb2ludCB0byBpdCBwbHMgaW4gdGhpcyBkb2Mgc28g
dGhhdCBwZW9wbGUgY2FuIGZpbmQgaXQuDQo+DQo+VGh4Lg0KPg0KPi0tDQo+UmVnYXJkcy9HcnVz
cywNCj4gICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVz
LWFib3V0LW5ldGlxdWV0dGUNCg0KVGhhbmtzLA0KU2hpanUNCg==

