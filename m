Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B4391420
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 11:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhEZJ4I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 05:56:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6640 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhEZJ4I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 05:56:08 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FqmSG62lHz1BQrx;
        Wed, 26 May 2021 17:51:42 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 17:54:34 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 10:54:30 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Wed, 26 May 2021 17:54:29 +0800
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
Thread-Index: AQHXPa2htgkN1X7dCEatlQZ1LQ756arRBrBQgACVCdCAAreDAIADr3lwgAjj3ACAExY5IIABpq/Q
Date:   Wed, 26 May 2021 09:54:28 +0000
Message-ID: <bbc339cef87e4009b6d56ee37e202daf@hisilicon.com>
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
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjUsIDIwMjEgODowNyBQTQ0KPiBUbzog
J0RpZXRtYXIgRWdnZW1hbm4nIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+OyBWaW5jZW50IEd1
aXR0b3QNCj4gPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPg0KPiBDYzogdGltLmMuY2hlbkBs
aW51eC5pbnRlbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7
DQo+IHJqd0Byand5c29ja2kubmV0OyBicEBhbGllbjguZGU7IHRnbHhAbGludXRyb25peC5kZTsg
bWluZ29AcmVkaGF0LmNvbTsNCj4gbGVuYkBrZXJuZWwub3JnOyBwZXRlcnpAaW5mcmFkZWFkLm9y
Zzsgcm9zdGVkdEBnb29kbWlzLm9yZzsNCj4gYnNlZ2FsbEBnb29nbGUuY29tOyBtZ29ybWFuQHN1
c2UuZGU7IG1zeXMubWl6dW1hQGdtYWlsLmNvbTsNCj4gdmFsZW50aW4uc2NobmVpZGVyQGFybS5j
b207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBqdXJpLmxlbGxpQHJlZGhhdC5jb207IG1hcmsucnV0
bGFuZEBhcm0uY29tOw0KPiBzdWRlZXAuaG9sbGFAYXJtLmNvbTsgYXVicmV5LmxpQGxpbnV4Lmlu
dGVsLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgeDg2
QGtlcm5lbC5vcmc7IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+Ow0KPiBaZW5ndGFvIChC
KSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgZ3VvZG9uZy54dUBsaW5hcm8ub3JnOyB5YW5n
eWljb25nDQo+IDx5YW5neWljb25nQGh1YXdlaS5jb20+OyBMaWd1b3podSAoS2VubmV0aCkgPGxp
Z3Vvemh1QGhpc2lsaWNvbi5jb20+Ow0KPiBsaW51eGFybUBvcGVuZXVsZXIub3JnOyBocGFAenl0
b3IuY29tDQo+IFN1YmplY3Q6IFJFOiBbUkZDIFBBVENIIHY2IDMvNF0gc2NoZWR1bGVyOiBzY2Fu
IGlkbGUgY3B1IGluIGNsdXN0ZXIgZm9yIHRhc2tzDQo+IHdpdGhpbiBvbmUgTExDDQo+IA0KPiAN
Cj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBEaWV0bWFyIEVn
Z2VtYW5uIFttYWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiA+IFNlbnQ6IEZyaWRh
eSwgTWF5IDE0LCAyMDIxIDEyOjMyIEFNDQo+ID4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29u
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
aW4gb25lIExMQw0KPiA+DQo+ID4gT24gMDcvMDUvMjAyMSAxNTowNywgU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKSB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRtYXIu
ZWdnZW1hbm5AYXJtLmNvbV0NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiA+PiBPbiAwMy8wNS8y
MDIxIDEzOjM1LCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+ID4+DQo+ID4g
Pj4gWy4uLl0NCj4gPiA+Pg0KPiA+ID4+Pj4gRnJvbTogU29uZyBCYW8gSHVhIChCYXJyeSBTb25n
KQ0KPiA+ID4+DQo+ID4gPj4gWy4uLl0NCj4gPiA+Pg0KPiA+ID4+Pj4+IEZyb206IERpZXRtYXIg
RWdnZW1hbm4gW21haWx0bzpkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+ID4gPj4NCj4gPiA+
PiBbLi4uXQ0KPiA+ID4+DQo+ID4gPj4+Pj4gT24gMjkvMDQvMjAyMSAwMDo0MSwgU29uZyBCYW8g
SHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4+Pj4+PiBGcm9tOiBEaWV0bWFy
IEVnZ2VtYW5uIFttYWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiA+ID4+Pj4+DQo+
ID4gPj4+Pj4gWy4uLl0NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+Pj4+Pj4gRnJvbTogRGlldG1hciBF
Z2dlbWFubiBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gPiA+Pj4+Pj4+DQo+
ID4gPj4+Pj4+PiBbLi4uXQ0KPiA+ID4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+Pj4+IE9uIDIwLzA0LzIw
MjEgMDI6MTgsIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBbLi4uXQ0KPiA+ID4+
DQo+ID4gPj4+DQo+ID4gPj4+IE9uIHRoZSBvdGhlciBoYW5kLCBhY2NvcmRpbmcgdG8gInNjaGVk
OiBJbXBsZW1lbnQgc21hcnRlciB3YWtlLWFmZmluZQ0KPiBsb2dpYyINCj4gPiA+Pj4NCj4gPiA+
Pg0KPiA+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvDQo+ID4gPj4gP2lkPTYyNDcwNDE5DQo+ID4gPj4+
DQo+ID4gPj4+IFByb3BlciBmYWN0b3IgaW4gd2FrZV93aWRlIGlzIG1haW5seSBiZW5lZmljaWFs
IG9mIDE6biB0YXNrcyBsaWtlDQo+ID4gPj4gcG9zdGdyZXNxbC9wZ2JlbmNoLg0KPiA+ID4+PiBT
byB1c2luZyB0aGUgc21hbGxlciBjbHVzdGVyIHNpemUgYXMgZmFjdG9yIG1pZ2h0IGhlbHAgbWFr
ZSB3YWtlX2FmZmluZQ0KPiA+IGZhbHNlDQo+ID4gPj4gc28NCj4gPiA+Pj4gaW1wcm92ZSBwZ2Jl
bmNoLg0KPiA+ID4+Pg0KPiA+ID4+PiBGcm9tIHRoZSBjb21taXQgbG9nLCB3aGlsZSBjbGllbnRz
ID0gIDIqY3B1cywgdGhlIGNvbW1pdCBtYWRlIHRoZSBiaWdnZXN0DQo+ID4gPj4+IGltcHJvdmVt
ZW50LiBJbiBteSBjYXNlLCBJdCBzaG91bGQgYmUgY2xpZW50cz00OCBmb3IgYSBtYWNoaW5lIHdo
b3NlIExMQw0KPiA+ID4+PiBzaXplIGlzIDI0Lg0KPiA+ID4+Pg0KPiA+ID4+PiBJbiBMaW51eCwg
SSBjcmVhdGVkIGEgMjQwTUIgZGF0YWJhc2UgYW5kIHJhbiAicGdiZW5jaCAtYyA0OCAtUyAtVCAy
MCBwZ2JlbmNoIg0KPiA+ID4+PiB1bmRlciB0d28gZGlmZmVyZW50IHNjZW5hcmlvczoNCj4gPiA+
Pj4gMS4gcGFnZSBjYWNoZSBhbHdheXMgaGl0LCBzbyBubyByZWFsIEkvTyBmb3IgZGF0YWJhc2Ug
cmVhZA0KPiA+ID4+PiAyLiBlY2hvIDMgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMNCj4gPiA+
Pj4NCj4gPiA+Pj4gRm9yIGNhc2UgMSwgdXNpbmcgY2x1c3Rlcl9zaXplIGFuZCB1c2luZyBsbGNf
c2l6ZSB3aWxsIHJlc3VsdCBpbiBzaW1pbGFyDQo+ID4gPj4+IHRwcz0gfjEwODAwMCwgYWxsIG9m
IDI0IGNwdXMgaGF2ZSAxMDAlIGNwdSB1dGlsaXphdGlvbi4NCj4gPiA+Pj4NCj4gPiA+Pj4gRm9y
IGNhc2UgMiwgdXNpbmcgbGxjX3NpemUgc3RpbGwgc2hvd3MgYmV0dGVyIHBlcmZvcm1hbmNlLg0K
PiA+ID4+Pg0KPiA+ID4+PiB0cHMgZm9yIGVhY2ggdGVzdCByb3VuZChjbHVzdGVyIHNpemUgYXMg
ZmFjdG9yIGluIHdha2Vfd2lkZSk6DQo+ID4gPj4+IDEzOTguNDUwODg3IDEyNzUuMDIwNDAxIDE2
MzIuNTQyNDM3IDE0MTIuMjQxNjI3IDE2MTEuMDk1NjkyIDEzODEuMzU0Mjk0DQo+ID4gPj4gMTUz
OS44NzcxNDYNCj4gPiA+Pj4gYXZnIHRwcyA9IDE0NjQNCj4gPiA+Pj4NCj4gPiA+Pj4gdHBzIGZv
ciBlYWNoIHRlc3Qgcm91bmQobGxjIHNpemUgYXMgZmFjdG9yIGluIHdha2Vfd2lkZSk6DQo+ID4g
Pj4+IDE3MTguNDAyOTgzIDE0NDMuMTY5ODIzIDE1MDIuMzUzODIzIDE2MDcuNDE1ODYxIDE1OTcu
Mzk2OTI0IDE3NDUuNjUxODE0DQo+ID4gPj4gMTg3Ni44MDIxNjgNCj4gPiA+Pj4gYXZnIHRwcyA9
IDE2NDEgICgrMTIlKQ0KPiA+ID4+Pg0KPiA+ID4+PiBzbyBpdCBzZWVtcyB1c2luZyBjbHVzdGVy
X3NpemUgYXMgZmFjdG9yIGluICJzbGF2ZSA+PSBmYWN0b3IgJiYgbWFzdGVyID49DQo+ID4gPj4g
c2xhdmUgKg0KPiA+ID4+PiBmYWN0b3IiIGlzbid0IGEgZ29vZCBjaG9pY2UgZm9yIG15IG1hY2hp
bmUgYXQgbGVhc3QuDQo+ID4gPj4NCj4gPiA+PiBTbyBTRCBzaXplID0gNCAoaW5zdGVhZCBvZiAy
NCkgc2VlbXMgdG8gYmUgdG9vIHNtYWxsIGZvciBgLWMgNDhgLg0KPiA+ID4+DQo+ID4gPj4gSnVz
dCBjdXJpb3VzLCBoYXZlIHlvdSBzZWVuIHRoZSBiZW5lZml0IG9mIHVzaW5nIHdha2Ugd2lkZSBv
biBTRCBzaXplID0NCj4gPiA+PiAyNCAoTExDKSBjb21wYXJlZCB0byBub3QgdXNpbmcgaXQgYXQg
YWxsPw0KPiA+ID4NCj4gPiA+IEF0IGxlYXN0IGluIG15IGJlbmNobWFyayBtYWRlIHRvZGF5LCBJ
IGhhdmUgbm90IHNlZW4gYW55IGJlbmVmaXQgdG8gdXNlDQo+ID4gPiBsbGNfc2l6ZS4gQWx3YXlz
IHJldHVybmluZyAwIGluIHdha2Vfd2lkZSgpIHNlZW1zIHRvIGJlIG11Y2ggYmV0dGVyLg0KPiA+
ID4NCj4gPiA+IHBvc3RncmVzQHVidW50dTokcGdiZW5jaCAtaSBwZ2JlbmNoDQo+ID4gPiBwb3N0
Z3Jlc0BwZ2JlbmNoOiQgcGdiZW5jaCAtVCAxMjAgLWMgNDggcGdiZW5jaA0KPiA+ID4NCj4gPiA+
IHVzaW5nIGxsY19zaXplLCBpdCBnb3QgdG8gMTIzdHBzDQo+ID4gPiBhbHdheXMgcmV0dXJuaW5n
IDAgaW4gd2FrZV93aWRlKCksIGl0IGdvdCB0byAxNTh0cHMNCj4gPiA+DQo+ID4gPiBhY3R1YWxs
eSwgSSByZWFsbHkgY291bGRuJ3QgcmVwcm9kdWNlIHRoZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVu
dA0KPiA+ID4gdGhlIGNvbW1pdCAic2NoZWQ6IEltcGxlbWVudCBzbWFydGVyIHdha2UtYWZmaW5l
IGxvZ2ljIiBtZW50aW9uZWQuDQo+ID4gPiBvbiB0aGUgb3RoZXIgaGFuZCwgdGhlIGNvbW1pdCBs
b2cgZGlkbid0IHByZXNlbnQgdGhlIHBnYmVuY2ggY29tbWFuZA0KPiA+ID4gcGFyYW1ldGVyIHVz
ZWQuIEkgZ3Vlc3MgdGhlIGJlbmNobWFyayByZXN1bHQgd2lsbCBoaWdobHkgZGVwZW5kIG9uDQo+
ID4gPiB0aGUgY29tbWFuZCBwYXJhbWV0ZXIgYW5kIGRpc2sgSS9PIHNwZWVkLg0KPiA+DQo+ID4g
SSBzZWUuIEFuZCBpdCB3YXMgYSB3YXkgc21hbGxlciBtYWNoaW5lICgxMiBDUFVzKSBiYWNrIHRo
ZW4uDQo+ID4NCj4gPiBZb3UgY291bGQgcnVuIHBnYmVuY2ggdmlhIG1tdGVzdHMgaHR0cHM6Ly9n
aXRodWIuY29tL2dvcm1hbm0vbW10ZXN0cy4NCj4gPg0KPiA+IEkuZSB0aGUgYHRpbWVkLXJvLW1l
ZGl1bWAgdGVzdC4NCj4gPg0KPiA+IG1tdGVzdHMjIC4vcnVuLW1tdGVzdHMuc2ggLS1jb25maWcN
Cj4gPiAuL2NvbmZpZ3MvY29uZmlnLWRiLXBnYmVuY2gtdGltZWQtcm8tbWVkaXVtIHRlc3RfdGFn
DQo+ID4NCj4gPiAvc2hlbGxwYWNrcy9zaGVsbHBhY2stYmVuY2gtcGdiZW5jaCBjb250YWlucyBh
bGwgdGhlIGluZGl2aWR1YWwgdGVzdA0KPiA+IHN0ZXBzLiBTb21ldGhpbmcgeW91IGNvdWxkIHVz
ZSBhcyBhIHRlbXBsYXRlIGZvciB5b3VyIHBnYmVuY2ggc3RhbmRhbG9uZQ0KPiA+IHRlc3RzIGFz
IHdlbGwuDQo+ID4NCj4gPiBJIHJhbiB0aGlzIHRlc3Qgb24gYW4gSW50ZWwgWGVvbiBFNS0yNjkw
IHYyIHdpdGggNDAgQ1BVcyBhbmQgNjRHQiBvZg0KPiA+IG1lbW9yeSBvbiB2NS4xMiB2YW5pbGxh
IGFuZCB3L28gd2FrZXdpZGUuDQo+ID4gVGhlIHRlc3QgdXNlcyBgc2NhbGVfZmFjdG9yID0gMjU3
MGAgb24gdGhpcyBtYWNoaW5lLiBJIGd1ZXNzIHRoaXMNCj4gPiByZWxhdGVzIHRvIH40MUdCPyBB
dCBsZWFzdCB0aGlzIHdhcyB0aGUgc2l6ZSBvZiB0aGU6DQo+IA0KPiBUaGFua3MuIERpZXRtYXIs
IHNvcnJ5IGZvciBzbG93IHJlc3BvbnNlLiBTaWNrIGxlYXZlIGZvciB0aGUgd2hvbGUNCj4gbGFz
dCB3ZWVrLg0KPiANCj4gSSBmZWVsIGl0IG1ha2VzIG11Y2ggbW9yZSBzZW5zZSB0byB1c2UgbW10
ZXN0cyB3aGljaCBpcyBzZXR0aW5nDQo+IHNjYWxlX2ZhY3RvciBhY2NvcmRpbmcgdG8gdG90YWwg
bWVtb3J5IHNpemUsIHRodXMsIGNvbnNpZGVyaW5nDQo+IHRoZSBpbXBhY3Qgb2YgcGFnZSBjYWNo
ZS4gQW5kIGl0IGlzIGFsc28gZG9pbmcgZGF0YWJhc2Ugd2FybWluZy11cA0KPiBmb3IgMzBtaW51
dGVzLg0KPiANCj4gSSB3aWxsIGdldCBtb3JlIGRhdGEgYW5kIGNvbXBhcmUgdGhyZWUgY2FzZXM6
DQo+IDEuIHVzZSBjbHVzdGVyIGFzIHdha2Vfd2lkZSBmYWN0b3INCj4gMi4gdXNlIGxsYyBhcyB3
YWtlX3dpZGUgZmFjdG9yDQo+IDMuIGFsd2F5cyByZXR1cm4gMCBpbiB3YWtlX3dpZGUuDQo+IA0K
PiBhbmQgcG9zdCB0aGUgcmVzdWx0IGFmdGVyd2FyZHMuDQoNCkkgdXNlZCBvbmx5IGEgbnVtYSBu
b2RlIHdpdGggMjRjcHVzIGFuZCA2MEdCIG1lbW9yeQ0KKHNjYWxlIGZhY3RvcjogMjM5MikgdG8g
ZmluaXNoIHRoZSB0ZXN0LiBBcyBtZW50aW9uZWQNCmJlZm9yZSwgZWFjaCBudW1hIG5vZGUgc2hh
cmVzIG9uZSBMTEMuIFNvIHdha2VyIGFuZA0Kd2FrZWUgYXJlIGluIHNhbWUgTExDIGRvbWFpbi4N
Cg0KQmFzaWNhbGx5LCB0aGUgZGlmZmVyZW5jZSBpcyBqdXN0IG5vaXNlIGJldHdlZW4gdXNpbmcN
CmNsdXN0ZXIgc2l6ZSBhcyBmYWN0b3IgaW4gd2FrZV93aWRlKCkgYW5kIHVzaW5nIGxsYyBzaXpl
DQphcyBmYWN0b3IgZm9yIDEvNDh0aHJlYWRzLCA4LzQ4dGhyZWFkcywgMTIvNDh0aHJlYWRzLA0K
MjQvNDh0aHJlYWRzLCAzMi80OHRocmVhZHMuIEJ1dCBmb3IgNDgvNDh0aHJlYWRzKHN5c3RlbQ0K
aXMgYnVzeSksIHVzaW5nIGxsYyBzaXplIGFzIGZhY3RvciBzaG93cyA0JSsgcGdiZW5jaA0KaW1w
cm92ZW1lbnQuDQoNCiAgICAgICAgICAgICAgICAgY2x1c3Rlcl9hc19mYWN0b3IgICAgIGxsY19h
c19mYWN0b3INCkhtZWFuICAgICAxICAgICAxMDc3OS42NyAoICAgMC4wMCUpICAgIDEwODY5LjI3
ICogICAwLjgzJSoNCkhtZWFuICAgICA4ICAgICAxOTU5NS4wOSAoICAgMC4wMCUpICAgIDE5NTgw
LjU5ICogIC0wLjA3JSoNCkhtZWFuICAgICAxMiAgICAyOTU1My4wNiAoICAgMC4wMCUpICAgIDI5
NjQzLjU2ICogICAwLjMxJSoNCkhtZWFuICAgICAyNCAgICA0MzM2OC41NSAoICAgMC4wMCUpICAg
IDQzMTk0LjQ3ICogIC0wLjQwJSoNCkhtZWFuICAgICAzMiAgICA0MDI1OC4wOCAoICAgMC4wMCUp
ICAgIDQwMTYzLjIzICogIC0wLjI0JSoNCkhtZWFuICAgICA0OCAgICA0MDQ1MC40MiAoICAgMC4w
MCUpICAgIDQyMjQ5LjI5ICogICA0LjQ1JSoNCg0KSSBjYW4gZnVydGhlciBzZWUgMTQlKyBpbXBy
b3ZlbWVudCBmb3IgNDgvNDh0aHJlYWRzIHRyYW5zYWN0aW9ucw0KY2FzZSBpZiBJIHRvdGFsbHkg
ZG9uJ3QgZGVwZW5kIG9uIHdha2Vfd2lkZSgpLCB0aGF0IGlzIGxpa2UNCndha2Vfd2lkZSgpIGFs
d2F5cyByZXR1cm4gMC4NCg0KICAgICAgICAgICAgICAgIGxsY19hc19mYWN0b3IgICAgICAgICAg
ZG9uJ3RfdXNlX3dha2Vfd2lkZQ0KSG1lYW4gICAgIDEgICAgIDEwODY5LjI3ICggICAwLjAwJSkg
ICAgMTA3MjMuMDggKiAgLTEuMzQlKg0KSG1lYW4gICAgIDggICAgIDE5NTgwLjU5ICggICAwLjAw
JSkgICAgMTk0NjkuMzQgKiAgLTAuNTclKg0KSG1lYW4gICAgIDEyICAgIDI5NjQzLjU2ICggICAw
LjAwJSkgICAgMjk1MjAuMTYgKiAgLTAuNDIlKg0KSG1lYW4gICAgIDI0ICAgIDQzMTk0LjQ3ICgg
ICAwLjAwJSkgICAgNDM3NzQuNzggKiAgIDEuMzQlKg0KSG1lYW4gICAgIDMyICAgIDQwMTYzLjIz
ICggICAwLjAwJSkgICAgNDA3NDIuOTMgKiAgIDEuNDQlKg0KSG1lYW4gICAgIDQ4ICAgIDQyMjQ5
LjI5ICggICAwLjAwJSkgICAgNDgzMjkuMDAgKiAgMTQuMzklKg0KDQpJIGJlZ2luIHRvIGJlbGll
dmUgd2FrZV93aWRlKCkgaXMgdXNlbGVzcyB3aGlsZSB3YWtlciBhbmQgd2FrZWUNCmFyZSBhbHJl
YWR5IGluIHNhbWUgTExDLiBTbyBJIHNlbnQgYW5vdGhlciBwYXRjaCB0byBhZGRyZXNzIHRoaXMN
CmdlbmVyaWMgaXNzdWU6DQpbUEFUQ0hdIHNjaGVkOiBmYWlyOiBkb24ndCBkZXBlbmQgb24gd2Fr
ZV93aWRlIGlmIHdha2VyIGFuZCB3YWtlZSBhcmUgYWxyZWFkeSBpbiBzYW1lIExMQw0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDUyNjA5MTA1Ny4xODAwLTEtc29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb20vDQoNCj4gDQo+ID4NCj4gPiAjbW10ZXN0cy93b3JrL3Rlc3RkaXNrL2Rh
dGEvcGdkYXRhIGRpcmVjdG9yeSB3aGVuIHRoZSB0ZXN0IHN0YXJ0ZWQuDQo+ID4NCj4gPg0KPiA+
IG1tdGVzdHMvd29yay9sb2cjIC4uLy4uL2NvbXBhcmUta2VybmVscy5zaCAtLWJhc2VsaW5lIGJh
c2UgLS1jb21wYXJlDQo+ID4gd29fd2FrZXdpZGUgfCBncmVwIF5IbWVhbg0KPiA+DQo+ID4NCj4g
PiAgICAgICAjY2xpZW50cyAgdjUuMTIgdmFuaWxsYSAgICAgICAgICB2NS4xMiB3L28gd2FrZXdp
ZGUNCj4gPg0KPiA+IEhtZWFuICAgICAxICAgICAxMDkwMy44OCAoICAgMC4wMCUpICAgIDEwNzky
LjU5ICogIC0xLjAyJSoNCj4gPiBIbWVhbiAgICAgNiAgICAgMjg0ODAuNjAgKCAgIDAuMDAlKSAg
ICAyNzk1NC45NyAqICAtMS44NSUqDQo+ID4gSG1lYW4gICAgIDEyICAgIDQ5MTk3LjU1ICggICAw
LjAwJSkgICAgNDc3NTguMTYgKiAgLTIuOTMlKg0KPiA+IEhtZWFuICAgICAyMiAgICA3MjkwMi4z
NyAoICAgMC4wMCUpICAgIDcxMzE0LjAxICogIC0yLjE4JSoNCj4gPiBIbWVhbiAgICAgMzAgICAg
NzU0NjguMTYgKCAgIDAuMDAlKSAgICA3NTkyOS4xNyAqICAgMC42MSUqDQo+ID4gSG1lYW4gICAg
IDQ4ICAgIDYwMTU1LjU4ICggICAwLjAwJSkgICAgNjA0NzEuOTEgKiAgIDAuNTMlKg0KPiA+IEht
ZWFuICAgICA4MCAgICA2MjIwMi4zOCAoICAgMC4wMCUpICAgIDYwODE0Ljc2ICogIC0yLjIzJSoN
Cj4gPg0KPiA+DQo+ID4gU28gdGhlcmUgYXJlIHNvbWUgaW1wcm92ZW1lbnRzIHcvIHdha2V3aWRl
IGJ1dCBub3RoaW5nIG9mIHRoZSBzY2FsZQ0KPiA+IHNob3dlZCBpbiB0aGUgb3JpZ2luYWwgd2Fr
ZXdpZGUgcGF0Y2guDQo+ID4NCj4gPiBJJ20gbm90IGFuIGV4cGVydCBvbiBob3cgdG8gc2V0IHVw
IHRoZXNlIHBnYmVuY2ggdGVzdHMgdGhvdWdoLiBTbyBtYXliZQ0KPiA+IG90aGVyIHBnYmVuY2gg
cmVsYXRlZCBtbXRlc3RzIGNvbmZpZ3Mgb3Igc29tZSBtb3JlIGZpbmUtZ3JhaW5lZCB0dW5pbmcN
Cj4gPiBjYW4gcHJvZHVjZSBiaWdnZXIgZGlmZnM/DQo+IA0KPiBUaGFua3MNCj4gQmFycnkNCg0K
VGhhbmtzDQpCYXJyeQ0KDQo=
