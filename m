Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B773765C3
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhEGNIl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 09:08:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3040 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhEGNIk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 May 2021 09:08:40 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fc9Wm1dHxz71fwN;
        Fri,  7 May 2021 20:59:32 +0800 (CST)
Received: from lhreml713-chm.china.huawei.com (10.201.108.64) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 15:07:38 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 14:07:37 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 7 May 2021 21:07:35 +0800
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
        "peterz@infradead.org" <peterz@infradead.org>,
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
Subject: RE: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
Thread-Topic: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
Thread-Index: AQHXPa2htgkN1X7dCEatlQZ1LQ756arRBrBQgACVCdCAAreDAIADr3lw
Date:   Fri, 7 May 2021 13:07:35 +0000
Message-ID: <aee3fd353a3a4bfca65aa1b78386f9b5@hisilicon.com>
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com>
 <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
 <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
 <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
 <8b5277d9-e367-566d-6bd1-44ac78d21d3f@arm.com>
 <185746c4d02a485ca8f3509439328b26@hisilicon.com>
 <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com>
 <4d1f063504b1420c9f836d1f1a7f8e77@hisilicon.com>
 <142c7192-cde8-6dbe-bb9d-f0fce21ec959@arm.com>
In-Reply-To: <142c7192-cde8-6dbe-bb9d-f0fce21ec959@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.124]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1h
eSA2LCAyMDIxIDEyOjMwIEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25n
LmJhby5odWFAaGlzaWxpY29uLmNvbT47IFZpbmNlbnQgR3VpdHRvdA0KPiA8dmluY2VudC5ndWl0
dG90QGxpbmFyby5vcmc+DQo+IENjOiB0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbTsgY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7
IGJwQGFsaWVuOC5kZTsgdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBs
ZW5iQGtlcm5lbC5vcmc7IHBldGVyekBpbmZyYWRlYWQub3JnOyByb3N0ZWR0QGdvb2RtaXMub3Jn
Ow0KPiBic2VnYWxsQGdvb2dsZS5jb207IG1nb3JtYW5Ac3VzZS5kZTsgbXN5cy5taXp1bWFAZ21h
aWwuY29tOw0KPiB2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbTsgZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT47IGp1cmkubGVsbGlAcmVkaGF0LmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHN1ZGVl
cC5ob2xsYUBhcm0uY29tOyBhdWJyZXkubGlAbGludXguaW50ZWwuY29tOw0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZzsgeHV3ZWkgKE8p
IDx4dXdlaTVAaHVhd2VpLmNvbT47DQo+IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNv
bi5jb20+OyBndW9kb25nLnh1QGxpbmFyby5vcmc7IHlhbmd5aWNvbmcNCj4gPHlhbmd5aWNvbmdA
aHVhd2VpLmNvbT47IExpZ3Vvemh1IChLZW5uZXRoKSA8bGlndW96aHVAaGlzaWxpY29uLmNvbT47
DQo+IGxpbnV4YXJtQG9wZW5ldWxlci5vcmc7IGhwYUB6eXRvci5jb20NCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggdjYgMy80XSBzY2hlZHVsZXI6IHNjYW4gaWRsZSBjcHUgaW4gY2x1c3RlciBm
b3IgdGFza3MNCj4gd2l0aGluIG9uZSBMTEMNCj4gDQo+IE9uIDAzLzA1LzIwMjEgMTM6MzUsIFNv
bmcgQmFvIEh1YSAoQmFycnkgU29uZykgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4gRnJv
bTogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4+PiBGcm9t
OiBEaWV0bWFyIEVnZ2VtYW5uIFttYWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiAN
Cj4gWy4uLl0NCj4gDQo+ID4+PiBPbiAyOS8wNC8yMDIxIDAwOjQxLCBTb25nIEJhbyBIdWEgKEJh
cnJ5IFNvbmcpIHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4+Pj4gRnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRt
YXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gPj4+DQo+ID4+PiBbLi4uXQ0KPiA+Pj4NCj4gPj4+Pj4+
Pj4gRnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNv
bV0NCj4gPj4+Pj4NCj4gPj4+Pj4gWy4uLl0NCj4gPj4+Pj4NCj4gPj4+Pj4+Pj4gT24gMjAvMDQv
MjAyMSAwMjoxOCwgQmFycnkgU29uZyB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+DQo+ID4g
T24gdGhlIG90aGVyIGhhbmQsIGFjY29yZGluZyB0byAic2NoZWQ6IEltcGxlbWVudCBzbWFydGVy
IHdha2UtYWZmaW5lIGxvZ2ljIg0KPiA+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvDQo+ID9pZD02MjQ3
MDQxOQ0KPiA+DQo+ID4gUHJvcGVyIGZhY3RvciBpbiB3YWtlX3dpZGUgaXMgbWFpbmx5IGJlbmVm
aWNpYWwgb2YgMTpuIHRhc2tzIGxpa2UNCj4gcG9zdGdyZXNxbC9wZ2JlbmNoLg0KPiA+IFNvIHVz
aW5nIHRoZSBzbWFsbGVyIGNsdXN0ZXIgc2l6ZSBhcyBmYWN0b3IgbWlnaHQgaGVscCBtYWtlIHdh
a2VfYWZmaW5lIGZhbHNlDQo+IHNvDQo+ID4gaW1wcm92ZSBwZ2JlbmNoLg0KPiA+DQo+ID4gRnJv
bSB0aGUgY29tbWl0IGxvZywgd2hpbGUgY2xpZW50cyA9ICAyKmNwdXMsIHRoZSBjb21taXQgbWFk
ZSB0aGUgYmlnZ2VzdA0KPiA+IGltcHJvdmVtZW50LiBJbiBteSBjYXNlLCBJdCBzaG91bGQgYmUg
Y2xpZW50cz00OCBmb3IgYSBtYWNoaW5lIHdob3NlIExMQw0KPiA+IHNpemUgaXMgMjQuDQo+ID4N
Cj4gPiBJbiBMaW51eCwgSSBjcmVhdGVkIGEgMjQwTUIgZGF0YWJhc2UgYW5kIHJhbiAicGdiZW5j
aCAtYyA0OCAtUyAtVCAyMCBwZ2JlbmNoIg0KPiA+IHVuZGVyIHR3byBkaWZmZXJlbnQgc2NlbmFy
aW9zOg0KPiA+IDEuIHBhZ2UgY2FjaGUgYWx3YXlzIGhpdCwgc28gbm8gcmVhbCBJL08gZm9yIGRh
dGFiYXNlIHJlYWQNCj4gPiAyLiBlY2hvIDMgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMNCj4g
Pg0KPiA+IEZvciBjYXNlIDEsIHVzaW5nIGNsdXN0ZXJfc2l6ZSBhbmQgdXNpbmcgbGxjX3NpemUg
d2lsbCByZXN1bHQgaW4gc2ltaWxhcg0KPiA+IHRwcz0gfjEwODAwMCwgYWxsIG9mIDI0IGNwdXMg
aGF2ZSAxMDAlIGNwdSB1dGlsaXphdGlvbi4NCj4gPg0KPiA+IEZvciBjYXNlIDIsIHVzaW5nIGxs
Y19zaXplIHN0aWxsIHNob3dzIGJldHRlciBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IHRwcyBmb3Ig
ZWFjaCB0ZXN0IHJvdW5kKGNsdXN0ZXIgc2l6ZSBhcyBmYWN0b3IgaW4gd2FrZV93aWRlKToNCj4g
PiAxMzk4LjQ1MDg4NyAxMjc1LjAyMDQwMSAxNjMyLjU0MjQzNyAxNDEyLjI0MTYyNyAxNjExLjA5
NTY5MiAxMzgxLjM1NDI5NA0KPiAxNTM5Ljg3NzE0Ng0KPiA+IGF2ZyB0cHMgPSAxNDY0DQo+ID4N
Cj4gPiB0cHMgZm9yIGVhY2ggdGVzdCByb3VuZChsbGMgc2l6ZSBhcyBmYWN0b3IgaW4gd2FrZV93
aWRlKToNCj4gPiAxNzE4LjQwMjk4MyAxNDQzLjE2OTgyMyAxNTAyLjM1MzgyMyAxNjA3LjQxNTg2
MSAxNTk3LjM5NjkyNCAxNzQ1LjY1MTgxNA0KPiAxODc2LjgwMjE2OA0KPiA+IGF2ZyB0cHMgPSAx
NjQxICAoKzEyJSkNCj4gPg0KPiA+IHNvIGl0IHNlZW1zIHVzaW5nIGNsdXN0ZXJfc2l6ZSBhcyBm
YWN0b3IgaW4gInNsYXZlID49IGZhY3RvciAmJiBtYXN0ZXIgPj0NCj4gc2xhdmUgKg0KPiA+IGZh
Y3RvciIgaXNuJ3QgYSBnb29kIGNob2ljZSBmb3IgbXkgbWFjaGluZSBhdCBsZWFzdC4NCj4gDQo+
IFNvIFNEIHNpemUgPSA0IChpbnN0ZWFkIG9mIDI0KSBzZWVtcyB0byBiZSB0b28gc21hbGwgZm9y
IGAtYyA0OGAuDQo+IA0KPiBKdXN0IGN1cmlvdXMsIGhhdmUgeW91IHNlZW4gdGhlIGJlbmVmaXQg
b2YgdXNpbmcgd2FrZSB3aWRlIG9uIFNEIHNpemUgPQ0KPiAyNCAoTExDKSBjb21wYXJlZCB0byBu
b3QgdXNpbmcgaXQgYXQgYWxsPw0KDQpBdCBsZWFzdCBpbiBteSBiZW5jaG1hcmsgbWFkZSB0b2Rh
eSwgSSBoYXZlIG5vdCBzZWVuIGFueSBiZW5lZml0IHRvIHVzZQ0KbGxjX3NpemUuIEFsd2F5cyBy
ZXR1cm5pbmcgMCBpbiB3YWtlX3dpZGUoKSBzZWVtcyB0byBiZSBtdWNoIGJldHRlci4NCg0KcG9z
dGdyZXNAdWJ1bnR1OiRwZ2JlbmNoIC1pIHBnYmVuY2gNCnBvc3RncmVzQHBnYmVuY2g6JCBwZ2Jl
bmNoIC1UIDEyMCAtYyA0OCBwZ2JlbmNoDQoNCnVzaW5nIGxsY19zaXplLCBpdCBnb3QgdG8gMTIz
dHBzDQphbHdheXMgcmV0dXJuaW5nIDAgaW4gd2FrZV93aWRlKCksIGl0IGdvdCB0byAxNTh0cHMN
Cg0KYWN0dWFsbHksIEkgcmVhbGx5IGNvdWxkbid0IHJlcHJvZHVjZSB0aGUgcGVyZm9ybWFuY2Ug
aW1wcm92ZW1lbnQNCnRoZSBjb21taXQgInNjaGVkOiBJbXBsZW1lbnQgc21hcnRlciB3YWtlLWFm
ZmluZSBsb2dpYyIgbWVudGlvbmVkLg0Kb24gdGhlIG90aGVyIGhhbmQsIHRoZSBjb21taXQgbG9n
IGRpZG4ndCBwcmVzZW50IHRoZSBwZ2JlbmNoIGNvbW1hbmQNCnBhcmFtZXRlciB1c2VkLiBJIGd1
ZXNzIHRoZSBiZW5jaG1hcmsgcmVzdWx0IHdpbGwgaGlnaGx5IGRlcGVuZCBvbg0KdGhlIGNvbW1h
bmQgcGFyYW1ldGVyIGFuZCBkaXNrIEkvTyBzcGVlZC4NCg0KVGhhbmtzDQpCYXJyeQ0KDQo=
