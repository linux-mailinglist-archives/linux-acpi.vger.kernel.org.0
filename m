Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AB371457
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhECLgS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 07:36:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2985 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhECLgR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2021 07:36:17 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYgjr62kBz6wlP8;
        Mon,  3 May 2021 19:29:36 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 13:35:22 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 12:35:20 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 19:35:18 +0800
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
Thread-Index: AQHXPa2htgkN1X7dCEatlQZ1LQ756arRBrBQgACVCdA=
Date:   Mon, 3 May 2021 11:35:18 +0000
Message-ID: <4d1f063504b1420c9f836d1f1a7f8e77@hisilicon.com>
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com>
 <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
 <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
 <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
 <8b5277d9-e367-566d-6bd1-44ac78d21d3f@arm.com>
 <185746c4d02a485ca8f3509439328b26@hisilicon.com>
 <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com> 
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiBTZW50OiBNb25kYXksIE1heSAzLCAyMDIxIDY6MTIgUE0NCj4gVG86ICdE
aWV0bWFyIEVnZ2VtYW5uJyA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPjsgVmluY2VudCBHdWl0
dG90DQo+IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4NCj4gQ2M6IHRpbS5jLmNoZW5AbGlu
dXguaW50ZWwuY29tOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOw0K
PiByandAcmp3eXNvY2tpLm5ldDsgYnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1p
bmdvQHJlZGhhdC5jb207DQo+IGxlbmJAa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7
IHJvc3RlZHRAZ29vZG1pcy5vcmc7DQo+IGJzZWdhbGxAZ29vZ2xlLmNvbTsgbWdvcm1hbkBzdXNl
LmRlOyBtc3lzLm1penVtYUBnbWFpbC5jb207DQo+IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29t
OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tPjsganVyaS5sZWxsaUByZWRoYXQuY29tOyBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsNCj4gc3VkZWVwLmhvbGxhQGFybS5jb207IGF1YnJleS5saUBsaW51eC5pbnRl
bC5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBr
ZXJuZWwub3JnOyB4dXdlaSAoTykgPHh1d2VpNUBodWF3ZWkuY29tPjsNCj4gWmVuZ3RhbyAoQikg
PHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGd1b2RvbmcueHVAbGluYXJvLm9yZzsgeWFuZ3lp
Y29uZw0KPiA8eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgTGlndW96aHUgKEtlbm5ldGgpIDxsaWd1
b3podUBoaXNpbGljb24uY29tPjsNCj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZzsgaHBhQHp5dG9y
LmNvbQ0KPiBTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCB2NiAzLzRdIHNjaGVkdWxlcjogc2NhbiBp
ZGxlIGNwdSBpbiBjbHVzdGVyIGZvciB0YXNrcw0KPiB3aXRoaW4gb25lIExMQw0KPiANCj4gDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGlldG1hciBFZ2dl
bWFubiBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gPiBTZW50OiBGcmlkYXks
IEFwcmlsIDMwLCAyMDIxIDEwOjQzIFBNDQo+ID4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29u
ZykgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPjsgVmluY2VudCBHdWl0dG90DQo+ID4gPHZp
bmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPg0KPiA+IENjOiB0aW0uYy5jaGVuQGxpbnV4LmludGVs
LmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsNCj4gPiByandA
cmp3eXNvY2tpLm5ldDsgYnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJl
ZGhhdC5jb207DQo+ID4gbGVuYkBrZXJuZWwub3JnOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgcm9z
dGVkdEBnb29kbWlzLm9yZzsNCj4gPiBic2VnYWxsQGdvb2dsZS5jb207IG1nb3JtYW5Ac3VzZS5k
ZTsgbXN5cy5taXp1bWFAZ21haWwuY29tOw0KPiA+IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29t
OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA+IDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBqdXJpLmxlbGxpQHJlZGhhdC5jb207DQo+IG1hcmsu
cnV0bGFuZEBhcm0uY29tOw0KPiA+IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyBhdWJyZXkubGlAbGlu
dXguaW50ZWwuY29tOw0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1hY3BpQHZnZXIua2VybmVs
Lm9yZzsgeDg2QGtlcm5lbC5vcmc7IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+Ow0KPiA+
IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBndW9kb25nLnh1QGxpbmFy
by5vcmc7IHlhbmd5aWNvbmcNCj4gPiA8eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgTGlndW96aHUg
KEtlbm5ldGgpIDxsaWd1b3podUBoaXNpbGljb24uY29tPjsNCj4gPiBsaW51eGFybUBvcGVuZXVs
ZXIub3JnOyBocGFAenl0b3IuY29tDQo+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjYgMy80
XSBzY2hlZHVsZXI6IHNjYW4gaWRsZSBjcHUgaW4gY2x1c3RlciBmb3IgdGFza3MNCj4gPiB3aXRo
aW4gb25lIExMQw0KPiA+DQo+ID4gT24gMjkvMDQvMjAyMSAwMDo0MSwgU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKSB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRtYXIu
ZWdnZW1hbm5AYXJtLmNvbV0NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiA+Pj4+PiBGcm9tOiBE
aWV0bWFyIEVnZ2VtYW5uIFttYWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiA+ID4+
DQo+ID4gPj4gWy4uLl0NCj4gPiA+Pg0KPiA+ID4+Pj4+IE9uIDIwLzA0LzIwMjEgMDI6MTgsIEJh
cnJ5IFNvbmcgd3JvdGU6DQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gPiBUaG91Z2ggd2Ugd2ls
bCBuZXZlciBnbyB0byBzbG93IHBhdGgsIHdha2Vfd2lkZSgpIHdpbGwgYWZmZWN0IHdhbnRfYWZm
aW5lLA0KPiA+ID4gc28gZXZlbnR1YWxseSBhZmZlY3QgdGhlICJuZXdfY3B1Ij8NCj4gPg0KPiA+
IHllcy4NCj4gPg0KPiA+ID4NCj4gPiA+IAlmb3JfZWFjaF9kb21haW4oY3B1LCB0bXApIHsNCj4g
PiA+IAkJLyoNCj4gPiA+IAkJICogSWYgYm90aCAnY3B1JyBhbmQgJ3ByZXZfY3B1JyBhcmUgcGFy
dCBvZiB0aGlzIGRvbWFpbiwNCj4gPiA+IAkJICogY3B1IGlzIGEgdmFsaWQgU0RfV0FLRV9BRkZJ
TkUgdGFyZ2V0Lg0KPiA+ID4gCQkgKi8NCj4gPiA+IAkJaWYgKHdhbnRfYWZmaW5lICYmICh0bXAt
PmZsYWdzICYgU0RfV0FLRV9BRkZJTkUpICYmDQo+ID4gPiAJCSAgICBjcHVtYXNrX3Rlc3RfY3B1
KHByZXZfY3B1LCBzY2hlZF9kb21haW5fc3Bhbih0bXApKSkgew0KPiA+ID4gCQkJaWYgKGNwdSAh
PSBwcmV2X2NwdSkNCj4gPiA+IAkJCQluZXdfY3B1ID0gd2FrZV9hZmZpbmUodG1wLCBwLCBjcHUs
IHByZXZfY3B1LCBzeW5jKTsNCj4gPiA+DQo+ID4gPiAJCQlzZCA9IE5VTEw7IC8qIFByZWZlciB3
YWtlX2FmZmluZSBvdmVyIGJhbGFuY2UgZmxhZ3MgKi8NCj4gPiA+IAkJCWJyZWFrOw0KPiA+ID4g
CQl9DQo+ID4gPg0KPiA+ID4gCQlpZiAodG1wLT5mbGFncyAmIHNkX2ZsYWcpDQo+ID4gPiAJCQlz
ZCA9IHRtcDsNCj4gPiA+IAkJZWxzZSBpZiAoIXdhbnRfYWZmaW5lKQ0KPiA+ID4gCQkJYnJlYWs7
DQo+ID4gPiAJfQ0KPiA+ID4NCj4gPiA+IElmIHdha2VfYWZmaW5lIGlzIGZhbHNlLCB0aGUgYWJv
dmUgd29uJ3QgZXhlY3V0ZSwgbmV3X2NwdSh0YXJnZXQpIHdpbGwNCj4gPiA+IGFsd2F5cyBiZSAi
cHJldl9jcHUiPyBzbyB3aGVuIHRhc2sgc2l6ZSA+IGNsdXN0ZXIgc2l6ZSBpbiB3YWtlX3dpZGUo
KSwNCj4gPiA+IHRoaXMgbWVhbnMgd2Ugd29uJ3QgcHVsbCB0aGUgd2FrZWUgdG8gdGhlIGNsdXN0
ZXIgb2Ygd2FrZXI/IEl0IHNlZW1zDQo+ID4gPiBzZW5zaWJsZS4NCj4gPg0KPiA+IFdoYXQgaXMg
YHRhc2sgc2l6ZWAgaGVyZT8NCj4gPg0KPiA+IFRoZSBjcml0ZXJpb24gaXMgYCEoc2xhdmUgPCBm
YWN0b3IgfHwgbWFzdGVyIDwgc2xhdmUgKiBmYWN0b3IpYCBvcg0KPiA+IGBzbGF2ZSA+PSBmYWN0
b3IgJiYgbWFzdGVyID49IHNsYXZlICogZmFjdG9yYCB0byB3YWtlIHdpZGUuDQo+ID4NCj4gDQo+
IFllcy4gRm9yICJ0YXNrIHNpemUiLCBJIGFjdHVhbGx5IG1lYW4gYSBidW5kbGUgb2Ygd2FrZXIt
d2FrZWUgdGFza3MNCj4gd2hpY2ggY2FuIG1ha2UgInNsYXZlID49IGZhY3RvciAmJiBtYXN0ZXIg
Pj0gc2xhdmUgKiBmYWN0b3IiIGVpdGhlcg0KPiB0cnVlIG9yIGZhbHNlLCB0aGVuIGNoYW5nZSB0
aGUgdGFyZ2V0IGNwdSB3aGVyZSB3ZSBhcmUgZ29pbmcgdG8gc2Nhbg0KPiBmcm9tLg0KPiBOb3cg
c2luY2UgSSBoYXZlIG1vdmVkIHRvIGNsdXN0ZXIgbGV2ZWwgd2hlbiB0YXNrcyBoYXZlIGJlZW4g
aW4gc2FtZQ0KPiBMTEMgbGV2ZWwsIGl0IHNlZW1zIGl0IHdvdWxkIGJlIG1vcmUgc2Vuc2libGUg
dG8gdXNlICJjbHVzdGVyX3NpemUiIGFzDQo+IGZhY3Rvcj8NCj4gDQo+ID4gSSBzZWUgdGhhdCBz
aW5jZSB5b3UgZWZmZWN0aXZlbHkgY2hhbmdlIHRoZSBzY2hlZCBkb21haW4gc2l6ZSBmcm9tIExM
Qw0KPiA+IHRvIENMVVNURVIgKGUuZy4gMjQtPjYpIGZvciB3YWtldXBzIHdpdGggY3B1IGFuZCBw
cmV2X2NwdSBzaGFyaW5nIExMQw0KPiA+IChoZW5jZSB0aGUgYG51bWFjdGwgLU4gMGAgaW4geW91
ciB3b3JrbG9hZCksIHdha2Vfd2lkZSgpIGhhcyB0byB0YWtlDQo+ID4gQ0xVU1RFUiBzaXplIGlu
dG8gY29uc2lkZXJhdGlvbi4NCj4gPg0KPiA+IEkgd2FzIHdvbmRlcmluZyBpZiB5b3Ugc2F3IHdh
a2Vfd2lkZSgpIHJldHVybmluZyAxIHdpdGggeW91ciB1c2UgY2FzZXM6DQo+ID4NCj4gPiBudW1h
Y3RsIC1OIDAgL3Vzci9saWIvbG1iZW5jaC9iaW4vc3RyZWFtIC1QIFs2LDEyXSAtTSAxMDI0TSAt
TiA1DQo+IA0KPiBJIGNvdWxkbid0IG1ha2Ugd2FrZV93aWRlIHJldHVybiAxIGJ5IHRoZSBhYm92
ZSBzdHJlYW0gY29tbWFuZC4NCj4gQW5kIEkgY2FuJ3QgcmVwcm9kdWNlIGl0IGJ5IGEgMToxKG1v
bm9nYW1vdXMpIGhhY2tiZW5jaCAiLWYgMSIuDQo+IA0KPiBCdXQgSSBhbSBhYmxlIHRvIHJlcHJv
ZHVjZSB0aGlzIGlzc3VlIGJ5IGEgTTpOIGhhY2tiZW5jaCwgZm9yIGV4YW1wbGU6DQo+IA0KPiBu
dW1hY3RsIC1OIDAgaGFja2JlbmNoIC1wIC1UIC1mIDEwIC1sIDIwMDAwIC1nIDENCj4gDQo+IGhh
Y2tiZW5jaCB3aWxsIGNyZWF0ZSAxMCBzZW5kZXJzIHdoaWNoIHdpbGwgc2VuZCBtZXNzYWdlcyB0
byAxMA0KPiByZWNlaXZlcnMuIChFYWNoIHNlbmRlciBjYW4gc2VuZCBtZXNzYWdlcyB0byBhbGwg
MTAgcmVjZWl2ZXJzLikNCj4gDQo+IEkndmUgb2Z0ZW4gc2VlbiBmbGlwcyBsaWtlOg0KPiB3YWtl
ciB3YWtlZQ0KPiAxNTAxICAzOQ0KPiAxNTA5ICAxNw0KPiAxMSAgIDEzMjANCj4gMTMgICAyMDE2
DQo+IA0KPiAxMSwgMTMsIDE3IGlzIHNtYWxsZXIgdGhhbiBMTEMgYnV0IGxhcmdlciB0aGFuIGNs
dXN0ZXIuIFNvIHRoZSB3YWtlX3dpZGUoKQ0KPiB1c2luZyBjbHVzdGVyIGZhY3RvciB3aWxsIHJl
dHVybiAxLCBvbiB0aGUgb3RoZXIgaGFuZCwgaWYgd2UgYWx3YXlzIHVzZQ0KPiBsbGNfc2l6ZSBh
cyBmYWN0b3IsIGl0IHdpbGwgcmV0dXJuIDAuDQo+IA0KPiBIb3dldmVyLCBpdCBzZWVtcyB0aGUg
Y2hhbmdlIGluIHdha2Vfd2lkZSgpIGNvdWxkIGJyaW5nIHNvbWUgbmVnYXRpdmUNCj4gaW5mbHVl
bmNlIHRvIE06TiByZWxhdGlvbnNoaXAoLWYgMTApIGFjY29yZGluZyB0byB0ZXN0cyBtYWRlIHRv
ZGF5IGJ5Og0KPiANCj4gbnVtYWN0bCAtTiAwIGhhY2tiZW5jaCAtcCAtVCAtZiAxMCAtbCAyMDAw
MCAtZyAkMQ0KPiANCj4gZyAgICAgICAgICAgICA9ICAgICAgMSAgICAgMiAgICAgICAzICAgICAg
IDQNCj4gY2x1c3Rlcl9zaXplICAgICAwLjU3NjggMC42NTc4ICAwLjgxMTcgMS4wMTE5DQo+IExM
Q19zaXplICAgICAgICAgMC41NDc5IDAuNjE2MiAgMC42OTIyIDAuNzc1NA0KPiANCj4gQWx3YXlz
IHVzaW5nIGxsY19zaXplIGFzIGZhY3RvciBpbiB3YWtlX3dpZGUgc3RpbGwgc2hvd3MgYmV0dGVy
IHJlc3VsdA0KPiBpbiB0aGUgMTA6MTAgcG9seWdhbW91cyBoYWNrYmVuY2guDQo+IA0KPiBTbyBp
dCBzZWVtcyB0aGUgYHNsYXZlID49IGZhY3RvciAmJiBtYXN0ZXIgPj0gc2xhdmUgKiBmYWN0b3Jg
IGlzbid0DQo+IGEgc3VpdGFibGUgY3JpdGVyaW9uIGZvciBjbHVzdGVyIHNpemU/DQoNCk9uIHRo
ZSBvdGhlciBoYW5kLCBhY2NvcmRpbmcgdG8gInNjaGVkOiBJbXBsZW1lbnQgc21hcnRlciB3YWtl
LWFmZmluZSBsb2dpYyINCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYyNDcwNDE5DQoNClByb3BlciBm
YWN0b3IgaW4gd2FrZV93aWRlIGlzIG1haW5seSBiZW5lZmljaWFsIG9mIDE6biB0YXNrcyBsaWtl
IHBvc3RncmVzcWwvcGdiZW5jaC4NClNvIHVzaW5nIHRoZSBzbWFsbGVyIGNsdXN0ZXIgc2l6ZSBh
cyBmYWN0b3IgbWlnaHQgaGVscCBtYWtlIHdha2VfYWZmaW5lIGZhbHNlIHNvDQppbXByb3ZlIHBn
YmVuY2guDQoNCkZyb20gdGhlIGNvbW1pdCBsb2csIHdoaWxlIGNsaWVudHMgPSAgMipjcHVzLCB0
aGUgY29tbWl0IG1hZGUgdGhlIGJpZ2dlc3QNCmltcHJvdmVtZW50LiBJbiBteSBjYXNlLCBJdCBz
aG91bGQgYmUgY2xpZW50cz00OCBmb3IgYSBtYWNoaW5lIHdob3NlIExMQw0Kc2l6ZSBpcyAyNC4N
Cg0KSW4gTGludXgsIEkgY3JlYXRlZCBhIDI0ME1CIGRhdGFiYXNlIGFuZCByYW4gInBnYmVuY2gg
LWMgNDggLVMgLVQgMjAgcGdiZW5jaCINCnVuZGVyIHR3byBkaWZmZXJlbnQgc2NlbmFyaW9zOg0K
MS4gcGFnZSBjYWNoZSBhbHdheXMgaGl0LCBzbyBubyByZWFsIEkvTyBmb3IgZGF0YWJhc2UgcmVh
ZA0KMi4gZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQoNCkZvciBjYXNlIDEsIHVz
aW5nIGNsdXN0ZXJfc2l6ZSBhbmQgdXNpbmcgbGxjX3NpemUgd2lsbCByZXN1bHQgaW4gc2ltaWxh
cg0KdHBzPSB+MTA4MDAwLCBhbGwgb2YgMjQgY3B1cyBoYXZlIDEwMCUgY3B1IHV0aWxpemF0aW9u
Lg0KDQpGb3IgY2FzZSAyLCB1c2luZyBsbGNfc2l6ZSBzdGlsbCBzaG93cyBiZXR0ZXIgcGVyZm9y
bWFuY2UuDQoNCnRwcyBmb3IgZWFjaCB0ZXN0IHJvdW5kKGNsdXN0ZXIgc2l6ZSBhcyBmYWN0b3Ig
aW4gd2FrZV93aWRlKToNCjEzOTguNDUwODg3IDEyNzUuMDIwNDAxIDE2MzIuNTQyNDM3IDE0MTIu
MjQxNjI3IDE2MTEuMDk1NjkyIDEzODEuMzU0Mjk0IDE1MzkuODc3MTQ2DQphdmcgdHBzID0gMTQ2
NA0KDQp0cHMgZm9yIGVhY2ggdGVzdCByb3VuZChsbGMgc2l6ZSBhcyBmYWN0b3IgaW4gd2FrZV93
aWRlKToNCjE3MTguNDAyOTgzIDE0NDMuMTY5ODIzIDE1MDIuMzUzODIzIDE2MDcuNDE1ODYxIDE1
OTcuMzk2OTI0IDE3NDUuNjUxODE0IDE4NzYuODAyMTY4DQphdmcgdHBzID0gMTY0MSAgKCsxMiUp
DQoNCnNvIGl0IHNlZW1zIHVzaW5nIGNsdXN0ZXJfc2l6ZSBhcyBmYWN0b3IgaW4gInNsYXZlID49
IGZhY3RvciAmJiBtYXN0ZXIgPj0gc2xhdmUgKg0KZmFjdG9yIiBpc24ndCBhIGdvb2QgY2hvaWNl
IGZvciBteSBtYWNoaW5lIGF0IGxlYXN0Lg0KDQpUaGFua3MNCkJhcnJ5DQo=
