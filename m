Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E698838FC75
	for <lists+linux-acpi@lfdr.de>; Tue, 25 May 2021 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEYIQW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 May 2021 04:16:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4000 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhEYIQW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 May 2021 04:16:22 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fq6JG5qgtzmbVW;
        Tue, 25 May 2021 16:12:30 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 16:14:50 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 09:14:47 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 25 May 2021 16:14:45 +0800
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
Thread-Index: AQHXPa2htgkN1X7dCEatlQZ1LQ756arRBrBQgACVCdCAAreDAIADr3lwgAjj3ACAExY5IA==
Date:   Tue, 25 May 2021 08:14:45 +0000
Message-ID: <bdfb60a29867412b97d652d6e04760ef@hisilicon.com>
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
 <aee3fd353a3a4bfca65aa1b78386f9b5@hisilicon.com>
 <45cce983-79ca-392a-f590-9168da7aefab@arm.com>
In-Reply-To: <45cce983-79ca-392a-f590-9168da7aefab@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.248]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBNYXkg
MTQsIDIwMjEgMTI6MzIgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPjsgVmluY2VudCBHdWl0dG90DQo+IDx2aW5jZW50Lmd1aXR0
b3RAbGluYXJvLm9yZz4NCj4gQ2M6IHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tOyBjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOw0KPiByandAcmp3eXNvY2tpLm5ldDsg
YnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207DQo+IGxl
bmJAa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IHJvc3RlZHRAZ29vZG1pcy5vcmc7
DQo+IGJzZWdhbGxAZ29vZ2xlLmNvbTsgbWdvcm1hbkBzdXNlLmRlOyBtc3lzLm1penVtYUBnbWFp
bC5jb207DQo+IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tOyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
PjsganVyaS5sZWxsaUByZWRoYXQuY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gc3VkZWVw
LmhvbGxhQGFybS5jb207IGF1YnJleS5saUBsaW51eC5pbnRlbC5jb207DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyB4dXdlaSAoTykg
PHh1d2VpNUBodWF3ZWkuY29tPjsNCj4gWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29u
LmNvbT47IGd1b2RvbmcueHVAbGluYXJvLm9yZzsgeWFuZ3lpY29uZw0KPiA8eWFuZ3lpY29uZ0Bo
dWF3ZWkuY29tPjsgTGlndW96aHUgKEtlbm5ldGgpIDxsaWd1b3podUBoaXNpbGljb24uY29tPjsN
Cj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZzsgaHBhQHp5dG9yLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCB2NiAzLzRdIHNjaGVkdWxlcjogc2NhbiBpZGxlIGNwdSBpbiBjbHVzdGVyIGZv
ciB0YXNrcw0KPiB3aXRoaW4gb25lIExMQw0KPiANCj4gT24gMDcvMDUvMjAyMSAxNTowNywgU29u
ZyBCYW8gSHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERpZXRtYXIgRWdnZW1hbm4gW21haWx0bzpkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4gT24gMDMvMDUvMjAy
MSAxMzozNSwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPj4NCj4gPj4gWy4u
Ll0NCj4gPj4NCj4gPj4+PiBGcm9tOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+ID4+DQo+
ID4+IFsuLi5dDQo+ID4+DQo+ID4+Pj4+IEZyb206IERpZXRtYXIgRWdnZW1hbm4gW21haWx0bzpk
aWV0bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+ID4+DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4+Pj4+
IE9uIDI5LzA0LzIwMjEgMDA6NDEsIFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgd3JvdGU6DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4+Pj4+IEZyb206IERpZXRtYXIgRWdnZW1hbm4gW21haWx0bzpkaWV0bWFyLmVnZ2VtYW5u
QGFybS5jb21dDQo+ID4+Pj4+DQo+ID4+Pj4+IFsuLi5dDQo+ID4+Pj4+DQo+ID4+Pj4+Pj4+Pj4g
RnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0N
Cj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFsuLi5dDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+PiBPbiAy
MC8wNC8yMDIxIDAyOjE4LCBCYXJyeSBTb25nIHdyb3RlOg0KPiA+Pg0KPiA+PiBbLi4uXQ0KPiA+
Pg0KPiA+Pj4NCj4gPj4+IE9uIHRoZSBvdGhlciBoYW5kLCBhY2NvcmRpbmcgdG8gInNjaGVkOiBJ
bXBsZW1lbnQgc21hcnRlciB3YWtlLWFmZmluZSBsb2dpYyINCj4gPj4+DQo+ID4+DQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvDQo+ID4+ID9pZD02MjQ3MDQxOQ0KPiA+Pj4NCj4gPj4+IFByb3BlciBmYWN0
b3IgaW4gd2FrZV93aWRlIGlzIG1haW5seSBiZW5lZmljaWFsIG9mIDE6biB0YXNrcyBsaWtlDQo+
ID4+IHBvc3RncmVzcWwvcGdiZW5jaC4NCj4gPj4+IFNvIHVzaW5nIHRoZSBzbWFsbGVyIGNsdXN0
ZXIgc2l6ZSBhcyBmYWN0b3IgbWlnaHQgaGVscCBtYWtlIHdha2VfYWZmaW5lDQo+IGZhbHNlDQo+
ID4+IHNvDQo+ID4+PiBpbXByb3ZlIHBnYmVuY2guDQo+ID4+Pg0KPiA+Pj4gRnJvbSB0aGUgY29t
bWl0IGxvZywgd2hpbGUgY2xpZW50cyA9ICAyKmNwdXMsIHRoZSBjb21taXQgbWFkZSB0aGUgYmln
Z2VzdA0KPiA+Pj4gaW1wcm92ZW1lbnQuIEluIG15IGNhc2UsIEl0IHNob3VsZCBiZSBjbGllbnRz
PTQ4IGZvciBhIG1hY2hpbmUgd2hvc2UgTExDDQo+ID4+PiBzaXplIGlzIDI0Lg0KPiA+Pj4NCj4g
Pj4+IEluIExpbnV4LCBJIGNyZWF0ZWQgYSAyNDBNQiBkYXRhYmFzZSBhbmQgcmFuICJwZ2JlbmNo
IC1jIDQ4IC1TIC1UIDIwIHBnYmVuY2giDQo+ID4+PiB1bmRlciB0d28gZGlmZmVyZW50IHNjZW5h
cmlvczoNCj4gPj4+IDEuIHBhZ2UgY2FjaGUgYWx3YXlzIGhpdCwgc28gbm8gcmVhbCBJL08gZm9y
IGRhdGFiYXNlIHJlYWQNCj4gPj4+IDIuIGVjaG8gMyA+IC9wcm9jL3N5cy92bS9kcm9wX2NhY2hl
cw0KPiA+Pj4NCj4gPj4+IEZvciBjYXNlIDEsIHVzaW5nIGNsdXN0ZXJfc2l6ZSBhbmQgdXNpbmcg
bGxjX3NpemUgd2lsbCByZXN1bHQgaW4gc2ltaWxhcg0KPiA+Pj4gdHBzPSB+MTA4MDAwLCBhbGwg
b2YgMjQgY3B1cyBoYXZlIDEwMCUgY3B1IHV0aWxpemF0aW9uLg0KPiA+Pj4NCj4gPj4+IEZvciBj
YXNlIDIsIHVzaW5nIGxsY19zaXplIHN0aWxsIHNob3dzIGJldHRlciBwZXJmb3JtYW5jZS4NCj4g
Pj4+DQo+ID4+PiB0cHMgZm9yIGVhY2ggdGVzdCByb3VuZChjbHVzdGVyIHNpemUgYXMgZmFjdG9y
IGluIHdha2Vfd2lkZSk6DQo+ID4+PiAxMzk4LjQ1MDg4NyAxMjc1LjAyMDQwMSAxNjMyLjU0MjQz
NyAxNDEyLjI0MTYyNyAxNjExLjA5NTY5MiAxMzgxLjM1NDI5NA0KPiA+PiAxNTM5Ljg3NzE0Ng0K
PiA+Pj4gYXZnIHRwcyA9IDE0NjQNCj4gPj4+DQo+ID4+PiB0cHMgZm9yIGVhY2ggdGVzdCByb3Vu
ZChsbGMgc2l6ZSBhcyBmYWN0b3IgaW4gd2FrZV93aWRlKToNCj4gPj4+IDE3MTguNDAyOTgzIDE0
NDMuMTY5ODIzIDE1MDIuMzUzODIzIDE2MDcuNDE1ODYxIDE1OTcuMzk2OTI0IDE3NDUuNjUxODE0
DQo+ID4+IDE4NzYuODAyMTY4DQo+ID4+PiBhdmcgdHBzID0gMTY0MSAgKCsxMiUpDQo+ID4+Pg0K
PiA+Pj4gc28gaXQgc2VlbXMgdXNpbmcgY2x1c3Rlcl9zaXplIGFzIGZhY3RvciBpbiAic2xhdmUg
Pj0gZmFjdG9yICYmIG1hc3RlciA+PQ0KPiA+PiBzbGF2ZSAqDQo+ID4+PiBmYWN0b3IiIGlzbid0
IGEgZ29vZCBjaG9pY2UgZm9yIG15IG1hY2hpbmUgYXQgbGVhc3QuDQo+ID4+DQo+ID4+IFNvIFNE
IHNpemUgPSA0IChpbnN0ZWFkIG9mIDI0KSBzZWVtcyB0byBiZSB0b28gc21hbGwgZm9yIGAtYyA0
OGAuDQo+ID4+DQo+ID4+IEp1c3QgY3VyaW91cywgaGF2ZSB5b3Ugc2VlbiB0aGUgYmVuZWZpdCBv
ZiB1c2luZyB3YWtlIHdpZGUgb24gU0Qgc2l6ZSA9DQo+ID4+IDI0IChMTEMpIGNvbXBhcmVkIHRv
IG5vdCB1c2luZyBpdCBhdCBhbGw/DQo+ID4NCj4gPiBBdCBsZWFzdCBpbiBteSBiZW5jaG1hcmsg
bWFkZSB0b2RheSwgSSBoYXZlIG5vdCBzZWVuIGFueSBiZW5lZml0IHRvIHVzZQ0KPiA+IGxsY19z
aXplLiBBbHdheXMgcmV0dXJuaW5nIDAgaW4gd2FrZV93aWRlKCkgc2VlbXMgdG8gYmUgbXVjaCBi
ZXR0ZXIuDQo+ID4NCj4gPiBwb3N0Z3Jlc0B1YnVudHU6JHBnYmVuY2ggLWkgcGdiZW5jaA0KPiA+
IHBvc3RncmVzQHBnYmVuY2g6JCBwZ2JlbmNoIC1UIDEyMCAtYyA0OCBwZ2JlbmNoDQo+ID4NCj4g
PiB1c2luZyBsbGNfc2l6ZSwgaXQgZ290IHRvIDEyM3Rwcw0KPiA+IGFsd2F5cyByZXR1cm5pbmcg
MCBpbiB3YWtlX3dpZGUoKSwgaXQgZ290IHRvIDE1OHRwcw0KPiA+DQo+ID4gYWN0dWFsbHksIEkg
cmVhbGx5IGNvdWxkbid0IHJlcHJvZHVjZSB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQNCj4g
PiB0aGUgY29tbWl0ICJzY2hlZDogSW1wbGVtZW50IHNtYXJ0ZXIgd2FrZS1hZmZpbmUgbG9naWMi
IG1lbnRpb25lZC4NCj4gPiBvbiB0aGUgb3RoZXIgaGFuZCwgdGhlIGNvbW1pdCBsb2cgZGlkbid0
IHByZXNlbnQgdGhlIHBnYmVuY2ggY29tbWFuZA0KPiA+IHBhcmFtZXRlciB1c2VkLiBJIGd1ZXNz
IHRoZSBiZW5jaG1hcmsgcmVzdWx0IHdpbGwgaGlnaGx5IGRlcGVuZCBvbg0KPiA+IHRoZSBjb21t
YW5kIHBhcmFtZXRlciBhbmQgZGlzayBJL08gc3BlZWQuDQo+IA0KPiBJIHNlZS4gQW5kIGl0IHdh
cyBhIHdheSBzbWFsbGVyIG1hY2hpbmUgKDEyIENQVXMpIGJhY2sgdGhlbi4NCj4gDQo+IFlvdSBj
b3VsZCBydW4gcGdiZW5jaCB2aWEgbW10ZXN0cyBodHRwczovL2dpdGh1Yi5jb20vZ29ybWFubS9t
bXRlc3RzLg0KPiANCj4gSS5lIHRoZSBgdGltZWQtcm8tbWVkaXVtYCB0ZXN0Lg0KPiANCj4gbW10
ZXN0cyMgLi9ydW4tbW10ZXN0cy5zaCAtLWNvbmZpZw0KPiAuL2NvbmZpZ3MvY29uZmlnLWRiLXBn
YmVuY2gtdGltZWQtcm8tbWVkaXVtIHRlc3RfdGFnDQo+IA0KPiAvc2hlbGxwYWNrcy9zaGVsbHBh
Y2stYmVuY2gtcGdiZW5jaCBjb250YWlucyBhbGwgdGhlIGluZGl2aWR1YWwgdGVzdA0KPiBzdGVw
cy4gU29tZXRoaW5nIHlvdSBjb3VsZCB1c2UgYXMgYSB0ZW1wbGF0ZSBmb3IgeW91ciBwZ2JlbmNo
IHN0YW5kYWxvbmUNCj4gdGVzdHMgYXMgd2VsbC4NCj4gDQo+IEkgcmFuIHRoaXMgdGVzdCBvbiBh
biBJbnRlbCBYZW9uIEU1LTI2OTAgdjIgd2l0aCA0MCBDUFVzIGFuZCA2NEdCIG9mDQo+IG1lbW9y
eSBvbiB2NS4xMiB2YW5pbGxhIGFuZCB3L28gd2FrZXdpZGUuDQo+IFRoZSB0ZXN0IHVzZXMgYHNj
YWxlX2ZhY3RvciA9IDI1NzBgIG9uIHRoaXMgbWFjaGluZS4gSSBndWVzcyB0aGlzDQo+IHJlbGF0
ZXMgdG8gfjQxR0I/IEF0IGxlYXN0IHRoaXMgd2FzIHRoZSBzaXplIG9mIHRoZToNCg0KVGhhbmtz
LiBEaWV0bWFyLCBzb3JyeSBmb3Igc2xvdyByZXNwb25zZS4gU2ljayBsZWF2ZSBmb3IgdGhlIHdo
b2xlDQpsYXN0IHdlZWsuDQoNCkkgZmVlbCBpdCBtYWtlcyBtdWNoIG1vcmUgc2Vuc2UgdG8gdXNl
IG1tdGVzdHMgd2hpY2ggaXMgc2V0dGluZw0Kc2NhbGVfZmFjdG9yIGFjY29yZGluZyB0byB0b3Rh
bCBtZW1vcnkgc2l6ZSwgdGh1cywgY29uc2lkZXJpbmcNCnRoZSBpbXBhY3Qgb2YgcGFnZSBjYWNo
ZS4gQW5kIGl0IGlzIGFsc28gZG9pbmcgZGF0YWJhc2Ugd2FybWluZy11cA0KZm9yIDMwbWludXRl
cy4NCg0KSSB3aWxsIGdldCBtb3JlIGRhdGEgYW5kIGNvbXBhcmUgdGhyZWUgY2FzZXM6DQoxLiB1
c2UgY2x1c3RlciBhcyB3YWtlX3dpZGUgZmFjdG9yDQoyLiB1c2UgbGxjIGFzIHdha2Vfd2lkZSBm
YWN0b3INCjMuIGFsd2F5cyByZXR1cm4gMCBpbiB3YWtlX3dpZGUuDQoNCmFuZCBwb3N0IHRoZSBy
ZXN1bHQgYWZ0ZXJ3YXJkcy4NCg0KPiANCj4gI21tdGVzdHMvd29yay90ZXN0ZGlzay9kYXRhL3Bn
ZGF0YSBkaXJlY3Rvcnkgd2hlbiB0aGUgdGVzdCBzdGFydGVkLg0KPiANCj4gDQo+IG1tdGVzdHMv
d29yay9sb2cjIC4uLy4uL2NvbXBhcmUta2VybmVscy5zaCAtLWJhc2VsaW5lIGJhc2UgLS1jb21w
YXJlDQo+IHdvX3dha2V3aWRlIHwgZ3JlcCBeSG1lYW4NCj4gDQo+IA0KPiAgICAgICAjY2xpZW50
cyAgdjUuMTIgdmFuaWxsYSAgICAgICAgICB2NS4xMiB3L28gd2FrZXdpZGUNCj4gDQo+IEhtZWFu
ICAgICAxICAgICAxMDkwMy44OCAoICAgMC4wMCUpICAgIDEwNzkyLjU5ICogIC0xLjAyJSoNCj4g
SG1lYW4gICAgIDYgICAgIDI4NDgwLjYwICggICAwLjAwJSkgICAgMjc5NTQuOTcgKiAgLTEuODUl
Kg0KPiBIbWVhbiAgICAgMTIgICAgNDkxOTcuNTUgKCAgIDAuMDAlKSAgICA0Nzc1OC4xNiAqICAt
Mi45MyUqDQo+IEhtZWFuICAgICAyMiAgICA3MjkwMi4zNyAoICAgMC4wMCUpICAgIDcxMzE0LjAx
ICogIC0yLjE4JSoNCj4gSG1lYW4gICAgIDMwICAgIDc1NDY4LjE2ICggICAwLjAwJSkgICAgNzU5
MjkuMTcgKiAgIDAuNjElKg0KPiBIbWVhbiAgICAgNDggICAgNjAxNTUuNTggKCAgIDAuMDAlKSAg
ICA2MDQ3MS45MSAqICAgMC41MyUqDQo+IEhtZWFuICAgICA4MCAgICA2MjIwMi4zOCAoICAgMC4w
MCUpICAgIDYwODE0Ljc2ICogIC0yLjIzJSoNCj4gDQo+IA0KPiBTbyB0aGVyZSBhcmUgc29tZSBp
bXByb3ZlbWVudHMgdy8gd2FrZXdpZGUgYnV0IG5vdGhpbmcgb2YgdGhlIHNjYWxlDQo+IHNob3dl
ZCBpbiB0aGUgb3JpZ2luYWwgd2FrZXdpZGUgcGF0Y2guDQo+IA0KPiBJJ20gbm90IGFuIGV4cGVy
dCBvbiBob3cgdG8gc2V0IHVwIHRoZXNlIHBnYmVuY2ggdGVzdHMgdGhvdWdoLiBTbyBtYXliZQ0K
PiBvdGhlciBwZ2JlbmNoIHJlbGF0ZWQgbW10ZXN0cyBjb25maWdzIG9yIHNvbWUgbW9yZSBmaW5l
LWdyYWluZWQgdHVuaW5nDQo+IGNhbiBwcm9kdWNlIGJpZ2dlciBkaWZmcz8NCg0KVGhhbmtzDQpC
YXJyeQ0KDQo=
