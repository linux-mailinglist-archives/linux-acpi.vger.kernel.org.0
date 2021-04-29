Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6C36E359
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 04:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhD2CjI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 22:39:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2949 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhD2CjD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 22:39:03 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVzxW5L1tz6snSv;
        Thu, 29 Apr 2021 10:30:23 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 04:38:11 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 03:38:09 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 29 Apr 2021 10:38:08 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE:  Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for
 tasks within one LLC
Thread-Topic: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for
 tasks within one LLC
Thread-Index: Adc8nnwEADa6LjKwSIuYGglKI4PdvA==
Date:   Thu, 29 Apr 2021 02:38:08 +0000
Message-ID: <a54d76d3c59149aba74ddd464b2c64a9@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.101]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IERpZXRt
YXIgRWdnZW1hbm4gW21haWx0bzpkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+IA0KPiBbLi4u
XQ0KPiANCj4gPj4+IE9uIDIwLzA0LzIwMjEgMDI6MTgsIEJhcnJ5IFNvbmcgd3JvdGU6DQo+IA0K
PiBbLi4uXQ0KPiANCj4gPj4gSSBhbSByZWFsbHkgY29uZnVzZWQuIFRoZSB3aG9sZSBjb2RlIGhh
cyBvbmx5IGNoZWNrZWQgaWYgd2FrZV9mbGFncw0KPiA+PiBoYXMgV0ZfVFRXVSwgaXQgaGFzIG5l
dmVyIGNoZWNrZWQgaWYgc2RfZG9tYWluIGhhcyBTRF9CQUxBTkNFX1dBS0UgZmxhZy4NCj4gPg0K
PiA+IGxvb2sgYXQgOg0KPiA+ICNkZWZpbmUgV0ZfVFRXVSAgICAgMHgwOCAvKiBXYWtldXA7ICAg
ICAgICAgICAgbWFwcyB0byBTRF9CQUxBTkNFX1dBS0UgKi8NCj4gPg0KPiA+IHNvICB3aGVuIHdh
a2Vfd2lkZSByZXR1cm4gZmFsc2UsIHdlIHVzZSB0aGUgd2FrZV9hZmZpbmUgbWVjYW5pc20gYnV0
DQo+ID4gaWYgaXQncyBmYWxzZSB0aGVuIHdlIGZsbGJhY2sgdG8gZGVmYXVsdCBtb2RlIHdoaWNo
IGxvb2tzIGZvcjoNCj4gPiBpZiAodG1wLT5mbGFncyAmIHNkX2ZsYWcpDQo+ID4NCj4gPiBUaGlz
IG1lYW5zIGxvb2tpbmcgZm9yIFNEX0JBTEFOQ0VfV0FLRSB3aGljaCBpcyBuZXZlciBzZXQNCj4g
Pg0KPiA+IHNvIHNkIHdpbGwgc3RheSBOVUxMIGFuZCB5b3Ugd2lsbCBlbmQgdXAgY2FsbGluZyBz
ZWxlY3RfaWRsZV9zaWJsaW5nIGFueXdheQ0KPiA+DQo+ID4+DQo+ID4+IHN0YXRpYyBpbnQNCj4g
Pj4gc2VsZWN0X3Rhc2tfcnFfZmFpcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwcmV2X2Nw
dSwgaW50IHdha2VfZmxhZ3MpDQo+ID4+IHsNCj4gPj4gICAgICAgICAuLi4NCj4gPj4NCj4gPj4g
ICAgICAgICBpZiAod2FrZV9mbGFncyAmIFdGX1RUV1UpIHsNCj4gPj4gICAgICAgICAgICAgICAg
IHJlY29yZF93YWtlZShwKTsNCj4gPj4NCj4gPj4gICAgICAgICAgICAgICAgIGlmIChzY2hlZF9l
bmVyZ3lfZW5hYmxlZCgpKSB7DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIG5ld19jcHUg
PSBmaW5kX2VuZXJneV9lZmZpY2llbnRfY3B1KHAsIHByZXZfY3B1KTsNCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKG5ld19jcHUgPj0gMCkNCj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gbmV3X2NwdTsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgbmV3X2NwdSA9IHByZXZfY3B1Ow0KPiA+PiAgICAgICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+
PiAgICAgICAgICAgICAgICAgd2FudF9hZmZpbmUgPSAhd2FrZV93aWRlKHApICYmIGNwdW1hc2tf
dGVzdF9jcHUoY3B1LA0KPiBwLT5jcHVzX3B0cik7DQo+ID4+ICAgICAgICAgfQ0KPiA+PiB9DQo+
ID4+DQo+ID4+IEFuZCB0cnlfdG9fd2FrZV91cCgpIGhhcyBhbHdheXMgc2V0IFdGX1RUV1U6DQo+
ID4+IHN0YXRpYyBpbnQNCj4gPj4gdHJ5X3RvX3dha2VfdXAoc3RydWN0IHRhc2tfc3RydWN0ICpw
LCB1bnNpZ25lZCBpbnQgc3RhdGUsIGludCB3YWtlX2ZsYWdzKQ0KPiA+PiB7DQo+ID4+ICAgICAg
ICAgY3B1ID0gc2VsZWN0X3Rhc2tfcnEocCwgcC0+d2FrZV9jcHUsIHdha2VfZmxhZ3MgfCBXRl9U
VFdVKTsNCj4gPj4gICAgICAgICAuLi4NCj4gPj4gfQ0KPiA+Pg0KPiA+PiBTbyB0aGUgY2hhbmdl
IGluIHdha2Vfd2lkZSB3aWxsIGFjdHVhbGx5IGFmZmVjdCB0aGUgdmFsdWUgb2Ygd2FudF9hZmZp
bmUuDQo+ID4+IEFuZCBJIGRpZCBhbHNvIHNlZSBjb2RlIGVudGVyZWQgc2xvdyBwYXRoIGR1cmlu
ZyBteSBiZW5jaG1hcmsuDQo+IA0KPiBZZXMsIHRoaXMgaXMgaGFwcGVuaW5nIGJ1dCBJTUhPIG5v
dCBmb3Igd2FrZXVwcy4gQ2hlY2sgd2FrZV9mbGFncyBmb3INCj4gdGhlIHRhc2tzIHdoaWNoIGdv
IHRocm91Z2ggYHNsb3cgcGF0aGAgb24geW91ciBtYWNoaW5lLiBUaGV5IHNob3VsZCBoYXZlDQo+
IFdGX0VYRUMgb3IgV0ZfRk9SSywgbm90IFdGX1RUV1UgKCYgV0ZfU1lOQykuDQoNClllcy4gQm90
aCBvZiB5b3UgYXJlIHJpZ2h0LiBUaGUgc2xvdyBwYXRoIEkgcmVwb3J0ZWQgeWVzdGVyZGF5IGNh
bWUgZnJvbQ0KV0ZfRk9SSyBhY3R1YWxseS4NCg0KPiANCj4gPj4gT25lIGlzc3VlIEkgbWVudGlv
bmVkIGR1cmluZyBsaW5hcm8gb3BlbiBkaXNjdXNzaW9uIGlzIHRoYXQNCj4gPj4gc2luY2UgSSBo
YXZlIG1vdmVkIHRvIHVzZSBjbHVzdGVyIHNpemUgdG8gZGVjaWRlIHRoZSB2YWx1ZQ0KPiA+PiBv
ZiB3YWtlX3dpZGUsIHJlbGF0aXZlbHkgbGVzcyB0YXNrcyB3aWxsIG1ha2Ugd2FrZV93aWRlKCkN
Cj4gPj4gZGVjaWRlIHRvIGdvIHRvIHNsb3cgcGF0aCwgdGh1cywgdGFza3MgYmVnaW4gdG8gc3By
ZWFkIHRvDQo+ID4+IG90aGVyIE5VTUEsICBidXQgYWN0dWFsbHkgbGxjX3NpemUgbWlnaHQgYmUg
YWJsZSB0byBjb250YWluDQo+ID4+IHRob3NlIHRhc2tzLiBTbyBhIHBvc3NpYmxlIG1vZGVsIG1p
Z2h0IGJlOg0KPiA+PiBzdGF0aWMgaW50IHdha2Vfd2lkZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAp
DQo+ID4+IHsNCj4gPj4gICAgICAgICB0YXNrc2l6ZSA8IGNsdXN0ZXIgOiBzY2FuIGNsdXN0ZXIN
Cj4gPj4gICAgICAgICB0YXNrc2l6ZSA+IGxsYyAgICAgIDogc2xvdyBwYXRoDQo+ID4+ICAgICAg
ICAgdGFza3NpemUgPiBjbHVzdGVyICYmIHRhc2tzaXplIDwgbGxjOiBzY2FuIGxsYw0KPiA+PiB9
DQo+ID4+DQo+ID4+IHRob3VnaHRzPw0KPiANCj4gTGlrZSBWaW5jZW50IGV4cGxhaW5lZCwgdGhl
IHJldHVybiB2YWx1ZSBvZiB3YWtlX3dpZGUoKSBkb2Vzbid0IG1hdHRlci4NCj4gRm9yIHdha2V1
cHMgeW91IGFsd2F5cyBlbmQgdXAgaW4gc2lzKCkuDQoNClRob3VnaCB3ZSB3aWxsIG5ldmVyIGdv
IHRvIHNsb3cgcGF0aCwgd2FrZV93aWRlKCkgd2lsbCBhZmZlY3Qgd2FudF9hZmZpbmUsDQpzbyBl
dmVudHVhbGx5IGFmZmVjdCB0aGUgIm5ld19jcHUiPw0KDQoJZm9yX2VhY2hfZG9tYWluKGNwdSwg
dG1wKSB7DQoJCS8qDQoJCSAqIElmIGJvdGggJ2NwdScgYW5kICdwcmV2X2NwdScgYXJlIHBhcnQg
b2YgdGhpcyBkb21haW4sDQoJCSAqIGNwdSBpcyBhIHZhbGlkIFNEX1dBS0VfQUZGSU5FIHRhcmdl
dC4NCgkJICovDQoJCWlmICh3YW50X2FmZmluZSAmJiAodG1wLT5mbGFncyAmIFNEX1dBS0VfQUZG
SU5FKSAmJg0KCQkgICAgY3B1bWFza190ZXN0X2NwdShwcmV2X2NwdSwgc2NoZWRfZG9tYWluX3Nw
YW4odG1wKSkpIHsNCgkJCWlmIChjcHUgIT0gcHJldl9jcHUpDQoJCQkJbmV3X2NwdSA9IHdha2Vf
YWZmaW5lKHRtcCwgcCwgY3B1LCBwcmV2X2NwdSwgc3luYyk7DQoNCgkJCXNkID0gTlVMTDsgLyog
UHJlZmVyIHdha2VfYWZmaW5lIG92ZXIgYmFsYW5jZSBmbGFncyAqLw0KCQkJYnJlYWs7DQoJCX0N
Cg0KCQlpZiAodG1wLT5mbGFncyAmIHNkX2ZsYWcpDQoJCQlzZCA9IHRtcDsNCgkJZWxzZSBpZiAo
IXdhbnRfYWZmaW5lKQ0KCQkJYnJlYWs7DQoJfQ0KDQpJZiB3YWtlX2FmZmluZSBpcyBmYWxzZSwg
dGhlIGFib3ZlIHdvbid0IGV4ZWN1dGUsIG5ld19jcHUodGFyZ2V0KSB3aWxsDQphbHdheXMgYmUg
InByZXZfY3B1Ij8gc28gd2hlbiAidGFzayBzaXplID4gY2x1c3RlciBzaXplIiBpbiB3YWtlX3dp
ZGUoKSwNCnRoaXMgbWVhbnMgd2Ugd29uJ3QgcHVsbCB0aGUgd2FrZWUgdG8gdGhlIGNsdXN0ZXIg
b2Ygd2FrZXIgc2luY2UgdGFyZ2V0DQppcyBhbHdheXMgcHJldl9jcHU/IEl0IHNlZW1zIHNlbnNp
YmxlLg0KDQpUaGFua3MNCkJhcnJ5DQoNCg==
