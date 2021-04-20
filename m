Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B8366228
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhDTWcP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 18:32:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2893 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWcN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 18:32:13 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FPys56N8Nz68BVB;
        Wed, 21 Apr 2021 06:24:09 +0800 (CST)
Received: from lhreml718-chm.china.huawei.com (10.201.108.69) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 00:31:39 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 23:31:38 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Wed, 21 Apr 2021 06:31:36 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for x86
Thread-Topic: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for
 x86
Thread-Index: AQHXNhNyntgmOcGglU+2M2SQGIS0vaq993vQ
Date:   Tue, 20 Apr 2021 22:31:36 +0000
Message-ID: <28ce8c4b8fc347ed9565a2ccac44a39b@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-5-song.bao.hua@hisilicon.com>
 <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com>
 <67cc380019fd40d88d7a493b6cbc0852@hisilicon.com>
 <422b5d06-ec0e-f064-32fe-15df5b2957dd@linux.intel.com>
In-Reply-To: <422b5d06-ec0e-f064-32fe-15df5b2957dd@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.57]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltIENoZW4gW21haWx0
bzp0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAy
MSwgMjAyMSA2OjMyIEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJh
by5odWFAaGlzaWxpY29uLmNvbT47DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtl
cm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0Ow0KPiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9y
ZzsgYnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207
IGxlbmJAa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IGRpZXRtYXIuZWdnZW1h
bm5AYXJtLmNvbTsgcm9zdGVkdEBnb29kbWlzLm9yZzsgYnNlZ2FsbEBnb29nbGUuY29tOw0KPiBt
Z29ybWFuQHN1c2UuZGUNCj4gQ2M6IG1zeXMubWl6dW1hQGdtYWlsLmNvbTsgdmFsZW50aW4uc2No
bmVpZGVyQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBqdXJpLmxlbGxpQHJlZGhh
dC5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gYXVi
cmV5LmxpQGxpbnV4LmludGVsLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2Vy
bmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+
OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsNCj4gZ3VvZG9uZy54dUBs
aW5hcm8ub3JnOyB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5jb20+OyBMaWd1b3podSAo
S2VubmV0aCkNCj4gPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+OyBsaW51eGFybUBvcGVuZXVsZXIu
b3JnOyBocGFAenl0b3IuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY1IDQvNF0gc2No
ZWR1bGVyOiBBZGQgY2x1c3RlciBzY2hlZHVsZXIgbGV2ZWwgZm9yIHg4Ng0KPiANCj4gDQo+IA0K
PiBPbiAzLzIzLzIxIDQ6MjEgUE0sIFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgd3JvdGU6DQo+
IA0KPiA+Pg0KPiA+PiBPbiAzLzE4LzIxIDk6MTYgUE0sIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4+
PiBGcm9tOiBUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pg0KPiA+
Pj4gVGhlcmUgYXJlIHg4NiBDUFUgYXJjaGl0ZWN0dXJlcyAoZS5nLiBKYWNvYnN2aWxsZSkgd2hl
cmUgTDIgY2FoY2UNCj4gPj4+IGlzIHNoYXJlZCBhbW9uZyBhIGNsdXN0ZXIgb2YgY29yZXMgaW5z
dGVhZCBvZiBiZWluZyBleGNsdXNpdmUNCj4gPj4+IHRvIG9uZSBzaW5nbGUgY29yZS4NCj4gPj4+
DQo+ID4+PiBUbyBwcmV2ZW50IG92ZXJzdWJzY3JpcHRpb24gb2YgTDIgY2FjaGUsIGxvYWQgc2hv
dWxkIGJlDQo+ID4+PiBiYWxhbmNlZCBiZXR3ZWVuIHN1Y2ggTDIgY2x1c3RlcnMsIGVzcGVjaWFs
bHkgZm9yIHRhc2tzIHdpdGgNCj4gPj4+IG5vIHNoYXJlZCBkYXRhLg0KPiA+Pj4NCj4gPj4+IEFs
c28gd2l0aCBjbHVzdGVyIHNjaGVkdWxpbmcgcG9saWN5IHdoZXJlIHRhc2tzIGFyZSB3b2tlbiB1
cA0KPiA+Pj4gaW4gdGhlIHNhbWUgTDIgY2x1c3Rlciwgd2Ugd2lsbCBiZW5lZml0IGZyb20ga2Vl
cGluZyB0YXNrcw0KPiA+Pj4gcmVsYXRlZCB0byBlYWNoIG90aGVyIGFuZCBsaWtlbHkgc2hhcmlu
ZyBkYXRhIGluIHRoZSBzYW1lIEwyDQo+ID4+PiBjbHVzdGVyLg0KPiA+Pj4NCj4gPj4+IEFkZCBD
UFUgbWFza3Mgb2YgQ1BVcyBzaGFyaW5nIHRoZSBMMiBjYWNoZSBzbyB3ZSBjYW4gYnVpbGQgc3Vj
aA0KPiA+Pj4gTDIgY2x1c3RlciBzY2hlZHVsZXIgZG9tYWluLg0KPiA+Pj4NCj4gPj4+IFNpZ25l
ZC1vZmYtYnk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+IFNp
Z25lZC1vZmYtYnk6IEJhcnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiA+
Pg0KPiA+Pg0KPiA+PiBCYXJyeSwNCj4gPj4NCj4gPj4gQ2FuIHlvdSBhbHNvIGFkZCB0aGlzIGNo
dW5rIHRvIHRoZSBwYXRjaC4NCj4gPj4gVGhhbmtzLg0KPiA+DQo+ID4gU3VyZSwgVGltLCBUaGFu
a3MuIEknbGwgcHV0IHRoYXQgaW50byBwYXRjaCA0LzQgaW4gdjYuDQo+ID4NCj4gDQo+IEJhcnJ5
LA0KPiANCj4gVGhpcyBjaHVuayB3aWxsIGFsc28gbmVlZCB0byBiZSBhZGRlZCB0byByZXR1cm4g
Y2x1c3RlciBpZCBmb3IgeDg2Lg0KPiBQbGVhc2UgYWRkIGl0IGluIHlvdXIgbmV4dCByZXYuDQoN
Clllcy4gVGhhbmtzLiBJJ2xsIHB1dCB0aGlzIGluIGVpdGhlciBSRkMgdjcgb3IgUGF0Y2ggdjEu
DQoNCkZvciBzcHJlYWRpbmcgcGF0aCwgdGhpbmdzIGFyZSBtdWNoIGVhc2llciwgdGhvdWdoIHBh
Y2tpbmcgcGF0aCBpcyANCnF1aXRlIHRyaWNreS4gQnV0IEl0IHNlZW1zIFJGQyB2NiBoYXMgYmVl
biBxdWl0ZSBjbG9zZSB0byB3aGF0IHdlIHdhbnQNCnRvIGFjaGlldmUgdG8gcGFjayByZWxhdGVk
IHRhc2tzIGJ5IHNjYW5uaW5nIGNsdXN0ZXIgZm9yIHRhc2tzIHdpdGhpbg0Kc2FtZSBOVU1BOg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDQyMDAwMTg0NC45MTE2LTEtc29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20vDQoNCklmIGNvdXBsZXMgaGF2ZSBiZWVuIGFscmVhZHkgaW4g
c2FtZSBMTEMobnVtYSksIHNjYW5uaW5nIGNsdXN0ZXJzIHdpbGwNCmdhdGhlciB0aGVtIGZ1cnRo
ZXIuIElmIHRoZXkgYXJlIHJ1bm5pbmcgaW4gZGlmZmVyZW50IE5VTUEgbm9kZXMsIHRoZQ0Kb3Jp
Z2luYWwgc2Nhbm5pbmcgTExDIHdpbGwgbW92ZSB0aGVtIHRvIHRoZSBzYW1lIG5vZGUsIGFmdGVy
IHRoYXQsDQpzY2FubmluZyBjbHVzdGVyIG1pZ2h0IHB1dCB0aGVtIGNsb3NlciB0byBlYWNoIG90
aGVyLg0KDQppdCBzZWVtcyBpdCBpcyBraW5kIG9mIHRoZSB0d28tbGV2ZWwgcGFja2luZyBEaWV0
bWFyIGhhcyBzdWdnZXN0ZWQuDQoNClNvIHBlcmhhcHMgd2Ugd29uJ3QgaGF2ZSBSRkMgdjcsIEkg
d2lsbCBwcm9iYWJseSBzZW5kIHBhdGNoIHYxIGFmdGVyd2FyZHMuDQoNCj4gDQo+IFRoYW5rcy4N
Cj4gDQo+IFRpbQ0KPiANCj4gLS0tDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdG9wb2xvZ3kuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4g
aW5kZXggODAwZmE0OGM5ZmNkLi4yNTQ4ZDgyNGYxMDMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdG9w
b2xvZ3kuaA0KPiBAQCAtMTA5LDYgKzEwOSw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqY3B1X2NsdXN0ZXJncm91cF9tYXNrKGludCBjcHUpOw0KPiAgI2RlZmluZSB0b3BvbG9neV9w
aHlzaWNhbF9wYWNrYWdlX2lkKGNwdSkJKGNwdV9kYXRhKGNwdSkucGh5c19wcm9jX2lkKQ0KPiAg
I2RlZmluZSB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChjcHUpCQkoY3B1X2RhdGEoY3B1KS5sb2dp
Y2FsX2RpZV9pZCkNCj4gICNkZWZpbmUgdG9wb2xvZ3lfZGllX2lkKGNwdSkJCQkoY3B1X2RhdGEo
Y3B1KS5jcHVfZGllX2lkKQ0KPiArI2RlZmluZSB0b3BvbG9neV9jbHVzdGVyX2lkKGNwdSkJCShw
ZXJfY3B1KGNwdV9sMmNfaWQsIGNwdSkpDQo+ICAjZGVmaW5lIHRvcG9sb2d5X2NvcmVfaWQoY3B1
KQkJCShjcHVfZGF0YShjcHUpLmNwdV9jb3JlX2lkKQ0KPiANCj4gIGV4dGVybiB1bnNpZ25lZCBp
bnQgX19tYXhfZGllX3Blcl9wYWNrYWdlOw0KDQpUaGFua3MNCkJhcnJ5DQoNCg==
