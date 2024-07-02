Return-Path: <linux-acpi+bounces-6748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11D924BF5
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 01:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BB41F22B62
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1E157478;
	Tue,  2 Jul 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v5uX0YvS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A71DA32F;
	Tue,  2 Jul 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961292; cv=none; b=lwEX3CeJRP8nBFlqcYX+mXPKvkfACaL4h+UMotuIp6AFYHaH/VsBlcD9CYsSDd3+1ehp2s8rTyrewXaHcl+PdAxXfZSRzD6XxpJwUOYE8T9M5jIP8WOIJWTPVKHz5eCsL6T3JscVmOkn0ZCEwYEyqkhjJ4WQpnVepX+gES29GBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961292; c=relaxed/simple;
	bh=/xIsCGaWYuL05CFPlNI0z3Yps/jzrOlHsAPUzvYZlRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnrZSfS55mgBhfFm7fe/aWgdJ2XuK7XayfrERTcwrbw3WZVeM0IrB3AW22kgq4CfDLw6vk4t8zK6IZRKN5qXZMJ0ciGIKSNVooeqBHnUGEM0l5A6R/YZsuR8VbE26nGxKn8totpMRORh8ecWwe+bPWIxJjoGuLsD48W+5c4Awo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v5uX0YvS; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719961291; x=1751497291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/xIsCGaWYuL05CFPlNI0z3Yps/jzrOlHsAPUzvYZlRA=;
  b=v5uX0YvS0PUhl/141PY6ZuquZSLnngyl3UUqiW73DS3huStc2zWvao5/
   mC63HzyGyLACw/gkUGnL93Me3X3/KFEmc125sqOQqTBSRkFkldV+O4hiF
   UCQs53hHi7qVorWcZMDTVuD53HUXeJS+0TPUT1SwCeRs9mUY10HYExEfp
   M=;
X-IronPort-AV: E=Sophos;i="6.09,180,1716249600"; 
   d="scan'208";a="407355235"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:01:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:33344]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.170:2525] with esmtp (Farcaster)
 id 6c055d69-8e6c-4862-b846-0bf145a6b1aa; Tue, 2 Jul 2024 23:01:29 +0000 (UTC)
X-Farcaster-Flow-ID: 6c055d69-8e6c-4862-b846-0bf145a6b1aa
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 2 Jul 2024 23:01:28 +0000
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 2 Jul 2024 23:01:28 +0000
Received: from EX19D030UWB002.ant.amazon.com ([fe80::8cbd:fcae:56ad:4dfa]) by
 EX19D030UWB002.ant.amazon.com ([fe80::8cbd:fcae:56ad:4dfa%6]) with mapi id
 15.02.1258.034; Tue, 2 Jul 2024 23:01:28 +0000
From: "Jitindar Singh, Suraj" <surajjs@amazon.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "okaya@kernel.org" <okaya@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "robert.moore@intel.com"
	<robert.moore@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi: Support CONFIG_ACPI without CONFIG_PCI
Thread-Topic: [PATCH] acpi: Support CONFIG_ACPI without CONFIG_PCI
Thread-Index: AQHazNPFj3r3z6HpXUeozo3Zl0ZSAg==
Date: Tue, 2 Jul 2024 23:01:28 +0000
Message-ID: <703fd8504ca9541898ec920e15c05d673233218f.camel@amazon.com>
References: <20240613211011.413120-1-surajjs@amazon.com>
	 <CAJZ5v0iLtYOWc0w202kq8Tb-n=8ToQj2xHQ2_socwqqTyXufSw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLtYOWc0w202kq8Tb-n=8ToQj2xHQ2_socwqqTyXufSw@mail.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E79D440817DB4D4F94AB54CADA5015A4@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEzOjA4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMTE6MTDigK9QTSBTdXJhaiBKaXRpbmRhciBT
aW5naA0KPiA8c3VyYWpqc0BhbWF6b24uY29tPiB3cm90ZToNCj4gPiANCj4gPiBNYWtlIGlzIHBv
c3NpYmxlIHRvIHVzZSBBQ1BJIHdpdGhvdXQgaGF2aW5nIENPTkZJR19QQ0kgc2V0Lg0KPiA+IA0K
PiA+IFdoZW4gaW5pdGlhbGlzaW5nIEFDUEkgdGhlIGZvbGxvd2luZyBjYWxsIGNoYWluIG9jY3Vy
czoNCj4gPiANCj4gPiDCoCBhY3BpX2luaXQoKSAtPg0KPiA+IMKgwqDCoCBhY3BpX2J1c19pbml0
KCkgLT4NCj4gPiDCoMKgwqDCoMKgIGFjcGlfbG9hZF90YWJsZXMoKSAtPg0KPiA+IMKgwqDCoMKg
wqDCoMKgIGFjcGlfZXZfaW5zdGFsbF9yZWdpb25faGFuZGxlcnMoKSAtPg0KPiA+IA0KPiA+IGFj
cGlfZXZfaW5zdGFsbF9yZWdpb25faGFuZGxlcnMoKSBjYWxscw0KPiA+IGFjcGlfZXZfaW5zdGFs
bF9zcGFjZV9oYW5kbGVyKCkgb24NCj4gPiBlYWNoIG9mIHRoZSBkZWZhdWx0IGFkZHJlc3Mgc3Bh
Y2VzIGRlZmluZWQgYXM6DQo+ID4gDQo+ID4gwqAgdTggYWNwaV9nYmxfZGVmYXVsdF9hZGRyZXNz
X3NwYWNlc1tBQ1BJX05VTV9ERUZBVUxUX1NQQUNFU10gPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgIEFDUElfQURSX1NQQUNFX1NZU1RFTV9NRU1PUlksDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
IEFDUElfQURSX1NQQUNFX1NZU1RFTV9JTywNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgQUNQSV9B
RFJfU1BBQ0VfUENJX0NPTkZJRywNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgQUNQSV9BRFJfU1BB
Q0VfREFUQV9UQUJMRQ0KPiA+IMKgIH07DQo+ID4gDQo+ID4gSG93ZXZlciBpbiBhY3BpX2V2X2lu
c3RhbGxfc3BhY2VfaGFuZGxlcigpIHRoZSBjYXNlIHN0YXRlbWVudCBmb3INCj4gPiBBQ1BJX0FE
Ul9TUEFDRV9QQ0lfQ09ORklHIGlzIGlmZGVmJ2QgYXM6DQo+ID4gDQo+ID4gwqAgI2lmZGVmIEFD
UElfUENJX0NPTkZJR1VSRUQNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNhc2UgQUNQSV9BRFJfU1BBQ0VfUENJX0NPTkZJRzoNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoYW5kbGVyID0NCj4gPiBhY3Bp
X2V4X3BjaV9jb25maWdfc3BhY2VfaGFuZGxlcjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXR1cCA9IGFjcGlfZXZfcGNpX2NvbmZpZ19y
ZWdpb25fc2V0dXA7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gwqAgI2VuZGlmDQo+ID4gDQo+ID4gQUNQSV9QQ0lfQ09O
RklHVVJFRCBpcyBub3QgZGVmaW5lZCBpZiBDT05GSUdfUENJIGlzIG5vdCBlbmFibGVkLA0KPiA+
IHRodXMgdGhlDQo+ID4gYXR0ZW1wdCB0byBpbnN0YWxsIHRoZSBoYW5kbGVyIGZhaWxzLg0KPiA+
IA0KPiA+IEZpeCB0aGlzIGJ5IGlmZGVmJ2luZyBBQ1BJX0FEUl9TUEFDRV9QQ0lfQ09ORklHIGlu
IHRoZSBsaXN0IG9mDQo+ID4gZGVmYXVsdA0KPiA+IGFkZHJlc3Mgc3BhY2VzLg0KPiANCj4gV2hh
dCBpZiB0aGVyZSBhcmUgUENJIG9wZXJhdGlvbiByZWdpb25zIGluIHRoZSBBTUwgb24gdGhlIHBs
YXRmb3JtPw0KPiBIb3cgYXJlIHRoZXkgZ29pbmcgdG8gYmUgaGFuZGxlZD8NCg0KSGksDQoNCkFw
cHJlY2lhdGUgdGhlIHJlc3BvbnNlLg0KDQpJIHRoaW5rIHRoZSBzaG9ydCBhbnN3ZXIgaXMgdGhh
dCBpZiB0aGVyZSBhcmUgUENJIG9wZXJhdGlvbiByZWdpb25zIGluDQp0aGUgQU1MIG9uIHRoZSBw
bGF0Zm9ybSB0aGVuIHRoZSBrZXJuZWwgd2lsbCBuZWVkIHRvIGJlIGJ1aWx0IHdpdGggUENJDQpz
dXBwb3J0IChDT05GSUdfUENJKSBhbmQgaWYgaXQgaXNuJ3QgdGhlbiB0aGVyZSB3b24ndCBiZSBh
IGhhbmRsZXINCmluc3RhbGxlZCBhbmQgdGhlIG9wZXJhdGlvbiB3aWxsIGVycm9yLg0KDQpDb3Jy
ZWN0IG1lIGlmIEknbSB3cm9uZyBidXQgaXQgc2VlbXMgdGhlIGludGVudGlvbiBvZiB0aGUgcGF0
Y2ggc2VyaWVzOg0KDQozNmFkN2QyYjllOWIgQUNQSTogTW92ZSBQQ0kgcmVzZXQgdG8gYSBzZXBh
cmF0ZSBmdW5jdGlvbg0KODY2ODk3NzY4NzhmIEFDUEk6IEFsbG93IENPTkZJR19QQ0kgdG8gYmUg
dW5zZXQgZm9yIHJlYm9vdA0KYmQyM2ZhYzNlYWFhIEFDUElDQTogUmVtb3ZlIFBDSSBiaXRzIGZy
b20gQUNQSUNBIHdoZW4gQ09ORklHX1BDSSBpcw0KdW5zZXQNCjVkMzJhNjY1NDFjNCBQQ0kvQUNQ
STogQWxsb3cgQUNQSSB0byBiZSBidWlsdCB3aXRob3V0IENPTkZJR19QQ0kgc2V0DQoNCndhcyB0
byBkZWNvdXBsZSB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIENPTkZJR19QQ0kgYW5kIENPTkZJR19B
Q1BJLg0KDQpiZDIzZmFjM2VhYWEgKCJBQ1BJQ0E6IFJlbW92ZSBQQ0kgYml0cyBmcm9tIEFDUElD
QSB3aGVuIENPTkZJR19QQ0kgaXMNCnVuc2V0IikgYWRkZWQgYW4gaWZkZWYgYXJvdW5kIHRoZSBj
b2RlIHRvIGluc3RhbGwgdGhlIGhhbmRsZXIgZm9yIHRoZQ0KUENJIENPTkZJRyByZWdpb24gbWFr
aW5nIGl0IGRlcGVuZGVudCBvbiBBQ1BJX1BDSV9DT05GSUdVUkVEIChhbmQgdGh1cw0KQ09ORklH
X1BDSSkuIFRodXMgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGluc3RhbGwgdGhlIGRlZmF1bHQgaGFu
ZGxlciBmb3INCnRoZSBQQ0kgQ09ORklHIHJlZ2lvbiB1bmxlc3MgQ09ORklHX1BDSSBpcyBzZXQg
bWVhbmluZyBpdCBtYWtlcyBubw0Kc2Vuc2UgdG8gaGF2ZSBpdCBpbiB0aGUgbGlzdCBvZiBkZWZh
dWx0IGFkZHJlc3Mgc3BhY2VzLg0KDQpJIGNhbiBnYXRoZXIgdGhhdCB0aGlzIGxlYWRzIHRvIDIg
cG9zc2liaWxpdGllczoNCg0KMS4gSWYgdGhlcmUgYXJlIFBDSSBvcGVyYXRpb24gcmVnaW9ucyBp
biB0aGUgQU1MIG9uIHRoZSBwbGF0Zm9ybSB0aGVuDQp0aGVzZSB3aWxsIGVycm9yIG9uIGEga2Vy
bmVsIG5vdCBjb21waWxlZCB3aXRoIENPTkZJR19QQ0kuDQoNCm9yLA0KDQoyLiBUaGUgY29kZSB0
byBpbnN0YWxsIHRoZSBoYW5kbGVyIGZvciB0aGUgUENJIENPTkZJRyByZWdpb24gc2hvdWxkIG5v
dA0KYmUgaWZkZWYnZWQgYW5kIHNob3VsZCBiZSBleGVjdXRlZCBpcnJlc3BlY3RpdmUgb2YgaWYg
dGhlIGtlcm5lbCBpcw0KY29tcGlsZWQgd2l0aCBDT05GSUdfUENJIHRvIGFsbG93IGZvciBQQ0kg
Q09ORklHIHJlZ2lvbnMgaW4gdGhlIEFNTC4NCg0KVGhhbmtzDQoNCj4gDQo+ID4gRml4ZXM6IGJk
MjNmYWMzZWFhYSAoIkFDUElDQTogUmVtb3ZlIFBDSSBiaXRzIGZyb20gQUNQSUNBIHdoZW4NCj4g
PiBDT05GSUdfUENJIGlzIHVuc2V0IikNCj4gPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZ8Kg
IyA1LjAueC0NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdXJhaiBKaXRpbmRhciBTaW5naCA8c3VyYWpq
c0BhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9hY3BpL2FjcGljYS9ldmhhbmRs
ZXIuYyB8IDIgKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9ldmhhbmRsZXIuYw0KPiA+IGIv
ZHJpdmVycy9hY3BpL2FjcGljYS9ldmhhbmRsZXIuYw0KPiA+IGluZGV4IDFjOGNiNmQ5MjRkZi4u
MzcxMDkzYWNiMzYyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXZoYW5k
bGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V2aGFuZGxlci5jDQo+ID4gQEAg
LTI2LDcgKzI2LDkgQEAgYWNwaV9ldl9pbnN0YWxsX2hhbmRsZXIoYWNwaV9oYW5kbGUgb2JqX2hh
bmRsZSwNCj4gPiDCoHU4IGFjcGlfZ2JsX2RlZmF1bHRfYWRkcmVzc19zcGFjZXNbQUNQSV9OVU1f
REVGQVVMVF9TUEFDRVNdID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgIEFDUElfQURSX1NQQUNFX1NZ
U1RFTV9NRU1PUlksDQo+ID4gwqDCoMKgwqDCoMKgwqAgQUNQSV9BRFJfU1BBQ0VfU1lTVEVNX0lP
LA0KPiA+ICsjaWZkZWYgQUNQSV9QQ0lfQ09ORklHVVJFRA0KPiA+IMKgwqDCoMKgwqDCoMKgIEFD
UElfQURSX1NQQUNFX1BDSV9DT05GSUcsDQo+ID4gKyNlbmRpZg0KPiA+IMKgwqDCoMKgwqDCoMKg
IEFDUElfQURSX1NQQUNFX0RBVEFfVEFCTEUNCj4gPiDCoH07DQo+ID4gDQo+ID4gLS0NCj4gPiAy
LjM0LjENCj4gPiANCj4gPiANCg0K

