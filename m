Return-Path: <linux-acpi+bounces-4323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119C87B614
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 02:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431A2B23B54
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF01A38DB;
	Thu, 14 Mar 2024 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="XFKGdyrj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EDEDE
	for <linux-acpi@vger.kernel.org>; Thu, 14 Mar 2024 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378817; cv=none; b=IprYSB01e18prsI04i1D2GOBFFjKQH/ZdzsIBheMKSc0xJgar1Ewlx64EP+Lrm6IPi2kPmhRCpaVtnyOjhd8UYMtZUPWr5w4QVk7dYFSDsuGBrbRP1vLgZfWnzXQjVSkop0FV5Cv8c2c7/FqevIBjmw8c06tQgqK/qOaBd8U8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378817; c=relaxed/simple;
	bh=EMLXlzagD8YBbRmt3b0dmLf3kS1Q2wjnQPJd/cMrSQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gr5COgkKLfRhify/IVOkxKSwV+I4D2nFiB1Znq+cRIDaTbCnn7DQWmrDpKi6sE/3x83FOOszBIpikrp8paFBKuji91EKMolljTTGagJAEGngeCXJhSruJvQEivK/fk8lZ7FBADPDo38Wd7cc8Qg5PwZkPhn/k0YqTOlKxoIaHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=XFKGdyrj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0C3A42C0362;
	Thu, 14 Mar 2024 14:13:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710378812;
	bh=EMLXlzagD8YBbRmt3b0dmLf3kS1Q2wjnQPJd/cMrSQU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XFKGdyrj9+ypF1PO3i7Bqyn5wQ2YGoiUiR6akFgDBQgS34h8RmG0/MnwNFPSG6Wg6
	 qouLhaHtVNfdd6FusbYlqqKysdegyYlQsVV3FP1STMmD0jwuqHvLUxd/emrW9rEx3S
	 P8JUT+UdfDQ4m59O0ELmO5cjBEGb8v0hH/TsiGyORZA/EPFNP5Z3UFHEZh37KnRwUm
	 zE9aLyY7Zfim3V4GsId1wmY961Ci9dkz89NRUOCFhu/hzpCkhp0wGkAPCR5lt6K5Ul
	 87n7CUSkTUJ5wOkMp6vlUojh7X1In1d4vY4WLnAXqHZvl8qWX/cNk9IBIawWT8tnRj
	 GM0/3HgmU8Kfw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f24f3b0001>; Thu, 14 Mar 2024 14:13:31 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 14:13:31 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Thu, 14 Mar 2024 14:13:31 +1300
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>
CC: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "brgl@bgdev.pl"
	<brgl@bgdev.pl>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Thread-Topic: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Thread-Index: AQHadPL2e5DSb6pETUy7jtZsYbUE97E0rVeAgAABiACAAOb0gA==
Date: Thu, 14 Mar 2024 01:13:31 +0000
Message-ID: <f6833616b81e4e35f561dc0ea4dae8dcd0ac026b.camel@alliedtelesis.co.nz>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
	 <ZfGMNWtFrgsuUdLz@smile.fi.intel.com> <ZfGNfucm2-izJBfd@smile.fi.intel.com>
In-Reply-To: <ZfGNfucm2-izJBfd@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB8EF91C67990648BABFAEE946196BB1@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=65f24f3b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=fzn4atkRgMAA:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=rHCuErA-0DJHcIhzJiIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDEzOjI2ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFdlZCwgTWFyIDEzLCAyMDI0IGF0IDAxOjIxOjI1UE0gKzAyMDAsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4gPiBPbiBXZWQsIE1hciAxMywgMjAyNCBhdCAwNDowMjo1MVBNICsxMzAw
LCBIYW1pc2ggTWFydGluIHdyb3RlOg0KPiA+ID4gQSBtZW1vcnkgbGVhayBvY2N1cnMgaW4gYSBz
Y2VuYXJpbyB3aGVyZSBhbiBBQ1BJIFNTRFQgb3ZlcmxheSBpcw0KPiA+ID4gcmVtb3ZlZA0KPiA+
ID4gYW5kIHRoYXQgaXMgdGhlIHRyaWdnZXIgZm9yIHRoZSByZW1vdmFsIG9mIHRoZSBhY3BpX2dw
aW9fY2hpcC4NCj4gPiA+IFRoaXMgb2NjdXJzIGJlY2F1c2Ugd2UgdXNlIHRoZSBBQ1BJX0hBTkRM
RSBvZiB0aGUgY2hpcC0+cGFyZW50IGFzDQo+ID4gPiBhDQo+ID4gPiBjb252ZW5pZW50IGxvY2F0
aW9uIHRvIHRpZSB0aGUgJ3N0cnVjdCBhY3BpX2dwaW9fY2hpcCcgdG8sIHVzaW5nDQo+ID4gPiBh
Y3BpX2F0dGFjaF9kYXRhKCkuDQo+ID4gPiBUaGlzIGlzIGZpbmUgaW4gdGhlIHVzdWFsIGNhc2Ug
b2YgcmVtb3ZhbCBvZiB0aGUgJ3N0cnVjdA0KPiA+ID4gYWNwaV9ncGlvX2NoaXAnDQo+ID4gPiB2
aWEgYSBjYWxsIHRvIGFjcGlfZ3Bpb2NoaXBfcmVtb3ZlKCkgYmVjYXVzZSB1c3VhbGx5IHRoZSBB
Q1BJDQo+ID4gPiBkYXRhIGlzDQo+ID4gPiBzdGlsbCB2YWxpZC4NCj4gPiA+IEJ1dCBpbiB0aGUg
Y2FzZSBvZiBhbiBTU0RUIG92ZXJsYXkgcmVtb3ZhbCwgdGhlIEFDUEkgZGF0YSBoYXMNCj4gPiA+
IGJlZW4NCj4gPiA+IG1hcmtlZCBhcyBpbnZhbGlkIGJlZm9yZSB0aGUgcmVtb3ZhbCBjb2RlIGlz
IHRyaWdnZXJlZCAoc2VlIHRoZQ0KPiA+ID4gc2V0dGluZw0KPiA+ID4gb2YgdGhlIGFjcGlfZGV2
aWNlIGhhbmRsZSB0byBJTlZBTElEX0FDUElfSEFORExFIGluDQo+ID4gPiBhY3BpX3NjYW5fZHJv
cF9kZXZpY2UoKSkuIFRoaXMgbWVhbnMgdGhhdCBieSB0aGUgdGltZSB3ZSBleGVjdXRlDQo+ID4g
PiBhY3BpX2dwaW9jaGlwX3JlbW92ZSgpLCB0aGUgaGFuZGxlcyBhcmUgaW52YWxpZCBhbmQgd2Ug
YXJlIHVuYWJsZQ0KPiA+ID4gdG8NCj4gPiA+IHJldHJpZXZlIHRoZSAnc3RydWN0IGFjcGlfZ3Bp
b19jaGlwJyB1c2luZyBhY3BpX2dldF9kYXRhKCkuDQo+ID4gPiBVbmFibGUgdG8NCj4gPiA+IGdl
dCBvdXIgZGF0YSwgd2UgaGl0IHRoZSBmYWlsdXJlIGNhc2UgYW5kIHNlZSB0aGUgZm9sbG93aW5n
DQo+ID4gPiB3YXJuaW5nDQo+ID4gPiBsb2dnZWQ6DQo+ID4gPiDCoCBGYWlsZWQgdG8gcmV0cmll
dmUgQUNQSSBHUElPIGNoaXANCj4gPiA+IFRoaXMgbWVhbnMgd2UgYWxzbyBmYWlsIHRvIGtmcmVl
KCkgdGhlIHN0cnVjdCBhdCB0aGUgZW5kIG9mDQo+ID4gPiBhY3BpX2dwaW9jaGlwX3JlbW92ZSgp
Lg0KPiA+ID4gDQo+ID4gPiBUaGUgZml4IGlzIHRvIG5vIGxvbmdlciB0aWUgdGhlIGFjcGlfZ3Bp
b19jaGlwIGRhdGEgdG8gdGhlIEFDUEkNCj4gPiA+IGRhdGEsDQo+ID4gPiBidXQgaW5zdGVhZCBo
YW5nIGl0IGRpcmVjdGx5IGZyb20gdGhlICdzdHJ1Y3QgZ3Bpb19jaGlwJyB3aXRoIGENCj4gPiA+
IG5ldw0KPiA+ID4gZmllbGQuIFRoaXMgZGVjb3VwbGVzIHRoZSBsaWZlY3ljbGUgb2YgdGhlIGFj
cGlfZ3Bpb19jaGlwIGZyb20NCj4gPiA+IHRoZSBBQ1BJDQo+ID4gPiBkYXRhLCBhbmQgdGllcyBp
dCB0byB0aGUgZ3Bpb19jaGlwLiBUaGlzIHNlZW1zIGEgbXVjaCBiZXR0ZXINCj4gPiA+IHBsYWNl
IHNpbmNlDQo+ID4gPiB0aGV5IHNoYXJlIGEgY29tbW9uIGxpZmVjeWNsZS4NCj4gPiANCj4gPiBN
YXliZSBpbiB0aGlzIGNhc2UgaXQncyBpbmRlZWQgYmV0dGVyLg0KPiA+IA0KPiA+ID4gVGhlIGdl
bmVyYWwgY29uY2VwdCBvZiBhdHRhY2hpbmcgZGF0YSB0byB0aGUgQUNQSSBvYmplY3RzIG1heQ0K
PiA+ID4gYWxzbyBuZWVkDQo+ID4gPiByZXZpc2l0aW5nIGluIGxpZ2h0IG9mIHRoZSBpc3N1ZSB0
aGlzIHBhdGNoIGFkZHJlc3Nlcy4gRm9yDQo+ID4gPiBpbnN0YW5jZQ0KPiA+ID4gaTJjX2FjcGlf
cmVtb3ZlX3NwYWNlX2hhbmRsZXIoKSBpcyB2dWxuZXJhYmxlIHRvIGEgc2ltaWxhciBsZWFrDQo+
ID4gPiBkdWUgdG8NCj4gPiA+IHVzaW5nIGFjcGlfYnVzX2dldF9wcml2YXRlX2RhdGEoKSwgd2hp
Y2gganVzdCB3cmFwcw0KPiA+ID4gYWNwaV9hdHRhY2hfZGF0YSgpLg0KPiA+ID4gVGhpcyBtYXkg
bmVlZCBhIG1vcmUgd2lkZXNwcmVhZCBjaGFuZ2UgdGhhbiBpcyBhZGRyZXNzZWQgaW4gdGhpcw0K
PiA+ID4gcGF0Y2guDQo+ID4gDQo+ID4gQnV0IHdpdGggdGhpcyBpdCBzb3VuZHMgdG8gbWUgdGhh
dCB0aGUgcm9vdCBjYXVzZSBpcyBsaWtlIHlvdSBzYWlkDQo+ID4gaW4gQUNQSQ0KPiA+IHJlbW92
YWwgZGV2aWNlIGNvZGUsIGkuZS4gYWNwaV9zY2FuX2Ryb3BfZGV2aWNlLiBTaG91bGRuJ3QgdGhh
dCBiZQ0KPiA+IGZpeGVkIGZpcnN0DQo+ID4gdG8gYmUgbW9yZSBjbGV2ZXI/DQpQb3RlbnRpYWxs
eSwgYWx0aG91Z2ggSSB0aGluayBsb2NraW5nIGJlY29tZXMgYW4gaXNzdWUuIEZvciBpbnN0YW5j
ZSBJDQp0cmllZCB0byB1c2UgdGhlIGFjcGlfZ3Bpb19jaGlwX2RoKCkgZnVuY3Rpb24gZm9yIGl0
cyBjb3JyZWN0IHB1cnBvc2UNCmFzIGl0IGlzIGludm9rZWQgaW4gYWNwaV9uc19kZWxldGVfbm9k
ZSgpIHdoaWNoIGlzIHRvIGFsbG93IHRoZQ0KYXR0YWNoZWQgZGF0YSB0byBiZSBjbGVhbmVkIHVw
Lg0KLS0tLS0tLS0tPjgtLS0tLS0tLS0tLQ0KLyogSW52b2tlIHRoZSBhdHRhY2hlZCBkYXRhIGRl
bGV0aW9uIGhhbmRsZXIgaWYgcHJlc2VudCAqLw0KDQoJCWlmIChvYmpfZGVzYy0+ZGF0YS5oYW5k
bGVyKSB7DQoJCQlvYmpfZGVzYy0+ZGF0YS5oYW5kbGVyKG5vZGUsIG9ial9kZXNjLQ0KPmRhdGEu
cG9pbnRlcik7DQoJCX0NCi0tLS0tLS0tLT44LS0tLS0tLS0tLS0NCg0KU28gSSB0cmllZCB0byBk
byB0aGUgd29yayBkb25lIGluIGFjcGlfZ3Bpb2NoaXBfcmVtb3ZlKCkgYXQgdGhhdCB0aW1lDQpi
dXQgaGl0IGxvY2tpbmcgaXNzdWVzIGRvd25zdHJlYW0gb2YgYWNwaV9ncGlvY2hpcF9mcmVlX3Jl
Z2lvbnMoKS4gSQ0KY291bGQganVzdCBrZnJlZSB0aGUgYWNwaV9ncGlvX2NoaXAgaW4gIGFjcGlf
Z3Bpb19jaGlwX2RoKCksIGFuZCBhbHRlcg0KYWNwaV9ncGlvY2hpcF9yZW1vdmUoKSB0byBqdXN0
IHNpbGVudGx5IGlnbm9yZSB0aGUgZmFpbHVyZSBvZg0KYWNwaV9nZXRfZGF0YSgpIGZvciBteSB1
c2UgY2FzZSwgYnV0IHRoYXQgc2VlbXMgYSBsaXR0bGUgdW50aWR5IHNpbmNlDQppdCB3b3VsZCBs
ZWF2ZSB0d28gZGlmZmVyZW50IHBsYWNlcyB3aGVyZSB0aGUgYWNwaV9ncGlvX2NoaXAgaXMNCnJl
bW92ZWQuIFRoYXQgaXMgc2FmZSB0byBkbyBzaW5jZSBhbGwgdGhlIHN0dWZmIGFjdHVhbGx5IHJl
bW92ZWQgdW5kZXINCmFjcGlfZ3Bpb2NoaXBfZnJlZV9yZWdpb25zKCkgZ2V0cyBjbGVhbmVkIHVw
IGJ5IHRoZSBkZWxldGlvbiBvZiB0aGUNCm5hbWVzcGFjZSBub2RlIC0gYnV0IGFnYWluLCBpdCBz
ZWVtcyB1bnRpZHkgdG8gaGF2ZSB0d28gZGlmZmVyZW50DQpkZWxldGlvbiBwYXRocyBkZXBlbmRp
bmcgb24gaG93IHRoZSByZW1vdmFsIGlzIHRyaWdnZXJlZC4NClJlbW92aW5nIHRoZSBzZXR0aW5n
IG9mIHRoZSBoYW5kbGUgdG8gaW52YWxpZCBtYXkgYmUgdGhlIHJpZ2h0IGZpeCBidXQNCkkgZG9u
J3QgZmVlbCBJIGtub3cgdGhlIGNvZGUgd2VsbCBlbm91Z2ggdG8gbWFrZSBhIGRlY2lzaW9uIG9u
IHRoYXQuIEl0DQpjZXJ0YWlubHkgZG9lc24ndCByZXNvbHZlIHRoaW5ncyBpbW1lZGlhdGVseSAt
IEkgc2F3IHJlZiBjb3VudGluZw0Kd2FybmluZ3Mgb3V0cHV0Lg0KDQo+ID4gT3IgYXJlIHlvdSBz
dGF0aW5nIHRoYXQgYmFzaWNhbGx5IGFjcGlfYnVzX2dldF9wcml2YXRlX2RhdGEoKSBhbmQNCj4g
PiBjb25jZXB0IG9mDQo+ID4gdGhlIHByaXZhdGUgZGF0YSBpcyB3ZWFrIHRvIHRoZSBwb2ludCB0
aGF0IG1vc3RseSBiZWNvbWUgdXNlbGVzcz8NCkkgdGhpbmsgYXMgaXQgaXMgd3JpdHRlbiwgYW55
IGNvZGUgaW4gZHJpdmVyIHJlbW92ZSgpIHBhdGhzIHRoYXQgdHJpZXMNCnRvIGdldCBhbnkgYXR0
YWNoZWQgZGF0YSBjYW5ub3QgcmVsaWFibGUgYWNoaWV2ZSB0aGF0IGluIFNTRFQgb3ZlcmxheQ0K
cmVtb3ZhbCBzY2VuYXJpb3MuIEkgdGhpbmsgdGhpcyBpcyBtb3N0bHkgZmFpbGluZyBzaWxlbnRs
eSB3aXRoIHNtYWxsDQpsZWFrcy4gQWxzbywgcGVyaGFwcyByZW1vdmluZyB0aGVzZSBTU0RUIG92
ZXJsYXlzIGlzIG5vdCBhIGNvbW1vbiB1c2UNCmNhc2UuDQoNCj4gDQo+IEFub3RoZXIgUSBpcyBo
b3cgZG9lcyB0aGUgT0YgY2FzZSBzdXJ2aXZlIHNpbWlsYXIgZmxvdyAoRFQgb3ZlcmxheQ0KPiBy
ZW1vdmFsKT8NCj4gDQpGb3IgRFQgb3ZlcmxheXMsIGluIHRoZSBncGlvX2NoaXAgY2FzZSB0aGVy
ZSBpcyBubyBkYXRhIGNyZWF0ZWQgYW5kDQphdHRhY2hlZCB0byB0aGUgb2Zfbm9kZS4gSXQgc2lt
cGx5IHRha2VzIGEgcmVmIChvZl9ub2RlX2dldChjaGlwLQ0KPm9mX25vZGUpIGluIG9mX2dwaW9j
aGlwX2FkZCgpIGFuZCByZWxlYXNlIGl0IG9uIHJlbW92YWwNCihvZl9ub2RlX3B1dChjaGlwLT5v
Zl9ub2RlKSBpbiBvZl9ncGlvY2hpcF9yZW1vdmUoKSkuDQpJbiBhIG1vcmUgZ2VuZXJhbCBzZW5z
ZSwgSSBoYXZlbid0IHNlZW4gYW55IGF0dGFjaGluZyBvZiBkYXRhIHRvIHRoZQ0Kb2Zfbm9kZSBv
YmplY3RzIGluIGFueSBvZiB0aGUgZHJpdmVycyBJJ20gZmFtaWxpYXIgd2l0aCBvciBoYXZlIHNl
ZW4uDQpJbiBteSBleHBlcmllbmNlIHRoZSBkZXZpY2UgdHJlZSBpcyB1c2VkIGF0IHByb2JlKCkg
dGltZSwgbm90aGluZyBpcw0KYWRkZWQgdG8gaXQgYnkgdGhlIGRyaXZlcnMsIGFuZCBpdCBpcyBu
b3QgdXNlZCBhdCByZW1vdmUoKSB0aW1lLg0KDQpUaGFua3MgZm9yIHlvdXIgaGVscCB3aXRoIHRo
aXMgc3R1ZmYuIEFueSBmdXJ0aGVyIGlkZWFzIG9yIHJlcXVlc3RzIGZvcg0KaW5mbyB3b3VsZCBi
ZSBhcHByZWNpYXRlZC4NCg0KVGhhbmtzLA0KSGFtaXNoIE0NCg0K

