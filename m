Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA9371192
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 08:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhECGUg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 02:20:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2982 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhECGUc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2021 02:20:32 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYXb16vn4z6tm7b;
        Mon,  3 May 2021 14:08:13 +0800 (CST)
Received: from lhreml718-chm.china.huawei.com (10.201.108.69) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 08:19:04 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 07:19:02 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 14:19:00 +0800
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
Thread-Index: AQHXPa2htgkN1X7dCEatlQZ1LQ756arRBrBQ
Date:   Mon, 3 May 2021 06:19:00 +0000
Message-ID: <51df51d84c764d9292146e11d1031b08@hisilicon.com>
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com>
 <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
 <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
 <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
 <8b5277d9-e367-566d-6bd1-44ac78d21d3f@arm.com>
 <185746c4d02a485ca8f3509439328b26@hisilicon.com>
 <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com>
In-Reply-To: <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBBcHJp
bCAzMCwgMjAyMSAxMDo0MyBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29u
Zy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBWaW5jZW50IEd1aXR0b3QNCj4gPHZpbmNlbnQuZ3Vp
dHRvdEBsaW5hcm8ub3JnPg0KPiBDYzogdGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb207IGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7DQo+IHJqd0Byand5c29ja2kubmV0
OyBicEBhbGllbjguZGU7IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsNCj4g
bGVuYkBrZXJuZWwub3JnOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgcm9zdGVkdEBnb29kbWlzLm9y
ZzsNCj4gYnNlZ2FsbEBnb29nbGUuY29tOyBtZ29ybWFuQHN1c2UuZGU7IG1zeXMubWl6dW1hQGdt
YWlsLmNvbTsNCj4gdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5j
b20+OyBqdXJpLmxlbGxpQHJlZGhhdC5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzdWRl
ZXAuaG9sbGFAYXJtLmNvbTsgYXVicmV5LmxpQGxpbnV4LmludGVsLmNvbTsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7IHh1d2VpIChP
KSA8eHV3ZWk1QGh1YXdlaS5jb20+Ow0KPiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGlj
b24uY29tPjsgZ3VvZG9uZy54dUBsaW5hcm8ub3JnOyB5YW5neWljb25nDQo+IDx5YW5neWljb25n
QGh1YXdlaS5jb20+OyBMaWd1b3podSAoS2VubmV0aCkgPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+
Ow0KPiBsaW51eGFybUBvcGVuZXVsZXIub3JnOyBocGFAenl0b3IuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUkZDIFBBVENIIHY2IDMvNF0gc2NoZWR1bGVyOiBzY2FuIGlkbGUgY3B1IGluIGNsdXN0ZXIg
Zm9yIHRhc2tzDQo+IHdpdGhpbiBvbmUgTExDDQo+IA0KPiBPbiAyOS8wNC8yMDIxIDAwOjQxLCBT
b25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRp
ZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gDQo+IFsuLi5dDQo+IA0KPiA+Pj4+PiBGcm9tOiBE
aWV0bWFyIEVnZ2VtYW5uIFttYWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiA+Pg0K
PiA+PiBbLi4uXQ0KPiA+Pg0KPiA+Pj4+PiBPbiAyMC8wNC8yMDIxIDAyOjE4LCBCYXJyeSBTb25n
IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gVGhvdWdoIHdlIHdpbGwgbmV2ZXIgZ28gdG8g
c2xvdyBwYXRoLCB3YWtlX3dpZGUoKSB3aWxsIGFmZmVjdCB3YW50X2FmZmluZSwNCj4gPiBzbyBl
dmVudHVhbGx5IGFmZmVjdCB0aGUgIm5ld19jcHUiPw0KPiANCj4geWVzLg0KPiANCj4gPg0KPiA+
IAlmb3JfZWFjaF9kb21haW4oY3B1LCB0bXApIHsNCj4gPiAJCS8qDQo+ID4gCQkgKiBJZiBib3Ro
ICdjcHUnIGFuZCAncHJldl9jcHUnIGFyZSBwYXJ0IG9mIHRoaXMgZG9tYWluLA0KPiA+IAkJICog
Y3B1IGlzIGEgdmFsaWQgU0RfV0FLRV9BRkZJTkUgdGFyZ2V0Lg0KPiA+IAkJICovDQo+ID4gCQlp
ZiAod2FudF9hZmZpbmUgJiYgKHRtcC0+ZmxhZ3MgJiBTRF9XQUtFX0FGRklORSkgJiYNCj4gPiAJ
CSAgICBjcHVtYXNrX3Rlc3RfY3B1KHByZXZfY3B1LCBzY2hlZF9kb21haW5fc3Bhbih0bXApKSkg
ew0KPiA+IAkJCWlmIChjcHUgIT0gcHJldl9jcHUpDQo+ID4gCQkJCW5ld19jcHUgPSB3YWtlX2Fm
ZmluZSh0bXAsIHAsIGNwdSwgcHJldl9jcHUsIHN5bmMpOw0KPiA+DQo+ID4gCQkJc2QgPSBOVUxM
OyAvKiBQcmVmZXIgd2FrZV9hZmZpbmUgb3ZlciBiYWxhbmNlIGZsYWdzICovDQo+ID4gCQkJYnJl
YWs7DQo+ID4gCQl9DQo+ID4NCj4gPiAJCWlmICh0bXAtPmZsYWdzICYgc2RfZmxhZykNCj4gPiAJ
CQlzZCA9IHRtcDsNCj4gPiAJCWVsc2UgaWYgKCF3YW50X2FmZmluZSkNCj4gPiAJCQlicmVhazsN
Cj4gPiAJfQ0KPiA+DQo+ID4gSWYgd2FrZV9hZmZpbmUgaXMgZmFsc2UsIHRoZSBhYm92ZSB3b24n
dCBleGVjdXRlLCBuZXdfY3B1KHRhcmdldCkgd2lsbA0KPiA+IGFsd2F5cyBiZSAicHJldl9jcHUi
PyBzbyB3aGVuIHRhc2sgc2l6ZSA+IGNsdXN0ZXIgc2l6ZSBpbiB3YWtlX3dpZGUoKSwNCj4gPiB0
aGlzIG1lYW5zIHdlIHdvbid0IHB1bGwgdGhlIHdha2VlIHRvIHRoZSBjbHVzdGVyIG9mIHdha2Vy
PyBJdCBzZWVtcw0KPiA+IHNlbnNpYmxlLg0KPiANCj4gV2hhdCBpcyBgdGFzayBzaXplYCBoZXJl
Pw0KPiANCj4gVGhlIGNyaXRlcmlvbiBpcyBgIShzbGF2ZSA8IGZhY3RvciB8fCBtYXN0ZXIgPCBz
bGF2ZSAqIGZhY3RvcilgIG9yDQo+IGBzbGF2ZSA+PSBmYWN0b3IgJiYgbWFzdGVyID49IHNsYXZl
ICogZmFjdG9yYCB0byB3YWtlIHdpZGUuDQo+IA0KDQpZZXMuIEZvciAidGFzayBzaXplIiwgSSBh
Y3R1YWxseSBtZWFuIGEgYnVuZGxlIG9mIHdha2VyLXdha2VlIHRhc2tzDQp3aGljaCBjYW4gbWFr
ZSAic2xhdmUgPj0gZmFjdG9yICYmIG1hc3RlciA+PSBzbGF2ZSAqIGZhY3RvciIgZWl0aGVyDQp0
cnVlIG9yIGZhbHNlLCB0aGVuIGNoYW5nZSB0aGUgdGFyZ2V0IGNwdSB3aGVyZSB3ZSBhcmUgZ29p
bmcgdG8gc2Nhbg0KZnJvbS4NCk5vdyBzaW5jZSBJIGhhdmUgbW92ZWQgdG8gY2x1c3RlciBsZXZl
bCB3aGVuIHRhc2tzIGhhdmUgYmVlbiBpbiBzYW1lDQpMTEMgbGV2ZWwsIGl0IHNlZW1zIGl0IHdv
dWxkIGJlIG1vcmUgc2Vuc2libGUgdG8gdXNlICJjbHVzdGVyX3NpemUiIGFzDQpmYWN0b3I/DQoN
Cj4gSSBzZWUgdGhhdCBzaW5jZSB5b3UgZWZmZWN0aXZlbHkgY2hhbmdlIHRoZSBzY2hlZCBkb21h
aW4gc2l6ZSBmcm9tIExMQw0KPiB0byBDTFVTVEVSIChlLmcuIDI0LT42KSBmb3Igd2FrZXVwcyB3
aXRoIGNwdSBhbmQgcHJldl9jcHUgc2hhcmluZyBMTEMNCj4gKGhlbmNlIHRoZSBgbnVtYWN0bCAt
TiAwYCBpbiB5b3VyIHdvcmtsb2FkKSwgd2FrZV93aWRlKCkgaGFzIHRvIHRha2UNCj4gQ0xVU1RF
UiBzaXplIGludG8gY29uc2lkZXJhdGlvbi4NCj4gDQo+IEkgd2FzIHdvbmRlcmluZyBpZiB5b3Ug
c2F3IHdha2Vfd2lkZSgpIHJldHVybmluZyAxIHdpdGggeW91ciB1c2UgY2FzZXM6DQo+IA0KPiBu
dW1hY3RsIC1OIDAgL3Vzci9saWIvbG1iZW5jaC9iaW4vc3RyZWFtIC1QIFs2LDEyXSAtTSAxMDI0
TSAtTiA1DQoNCkkgY291bGRuJ3QgbWFrZSB3YWtlX3dpZGUgcmV0dXJuIDEgYnkgdGhlIGFib3Zl
IHN0cmVhbSBjb21tYW5kLg0KQW5kIEkgY2FuJ3QgcmVwcm9kdWNlIGl0IGJ5IGEgMToxKG1vbm9n
YW1vdXMpIGhhY2tiZW5jaCAiLWYgMSIuDQoNCkJ1dCBJIGFtIGFibGUgdG8gcmVwcm9kdWNlIHRo
aXMgaXNzdWUgYnkgYSBNOk4gaGFja2JlbmNoLCBmb3IgZXhhbXBsZToNCg0KbnVtYWN0bCAtTiAw
IGhhY2tiZW5jaCAtcCAtVCAtZiAxMCAtbCAyMDAwMCAtZyAxDQoNCmhhY2tiZW5jaCB3aWxsIGNy
ZWF0ZSAxMCBzZW5kZXJzIHdoaWNoIHdpbGwgc2VuZCBtZXNzYWdlcyB0byAxMA0KcmVjZWl2ZXJz
LiAoRWFjaCBzZW5kZXIgY2FuIHNlbmQgbWVzc2FnZXMgdG8gYWxsIDEwIHJlY2VpdmVycy4pDQoN
CkkndmUgb2Z0ZW4gc2VlbiBmbGlwcyBsaWtlOg0Kd2FrZXIgd2FrZWUNCjE1MDEgIDM5DQoxNTA5
ICAxNw0KMTEgICAxMzIwDQoxMyAgIDIwMTYNCg0KMTEsIDEzLCAxNyBpcyBzbWFsbGVyIHRoYW4g
TExDIGJ1dCBsYXJnZXIgdGhhbiBjbHVzdGVyLiBTbyB0aGUgd2FrZV93aWRlKCkNCnVzaW5nIGNs
dXN0ZXIgZmFjdG9yIHdpbGwgcmV0dXJuIDEsIG9uIHRoZSBvdGhlciBoYW5kLCBpZiB3ZSBhbHdh
eXMgdXNlDQpsbGNfc2l6ZSBhcyBmYWN0b3IsIGl0IHdpbGwgcmV0dXJuIDAuDQoNCkhvd2V2ZXIs
IGl0IHNlZW1zIHRoZSBjaGFuZ2UgaW4gd2FrZV93aWRlKCkgY291bGQgYnJpbmcgc29tZSBuZWdh
dGl2ZQ0KaW5mbHVlbmNlIHRvIE06TiByZWxhdGlvbnNoaXAoLWYgMTApIGFjY29yZGluZyB0byB0
ZXN0cyBtYWRlIHRvZGF5IGJ5Og0KDQpudW1hY3RsIC1OIDAgaGFja2JlbmNoIC1wIC1UIC1mIDEw
IC1sIDIwMDAwIC1nICQxDQoNCmcgICAgICAgICAgICAgPSAgICAgIDEgICAgIDIgICAgICAgMyAg
ICAgICA0DQpjbHVzdGVyX3NpemUgICAgIDAuNTc2OCAwLjY1NzggIDAuODExNyAxLjAxMTkNCkxM
Q19zaXplICAgICAgICAgMC41NDc5IDAuNjE2MiAgMC42OTIyIDAuNzc1NA0KDQpBbHdheXMgdXNp
bmcgbGxjX3NpemUgYXMgZmFjdG9yIGluIHdha2Vfd2lkZSBzdGlsbCBzaG93cyBiZXR0ZXIgcmVz
dWx0DQppbiB0aGUgMTA6MTAgcG9seWdhbW91cyBoYWNrYmVuY2guDQoNClNvIGl0IHNlZW1zIHRo
ZSBgc2xhdmUgPj0gZmFjdG9yICYmIG1hc3RlciA+PSBzbGF2ZSAqIGZhY3RvcmAgaXNuJ3QNCmEg
c3VpdGFibGUgY3JpdGVyaW9uIGZvciBjbHVzdGVyIHNpemU/DQoNClRoYW5rcw0KQmFycnkNCg0K
