Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3842CD231
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgLCJMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:12:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2196 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388247AbgLCJMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:12:01 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cmqlj6mWGz67LZp;
        Thu,  3 Dec 2020 17:09:21 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 10:11:18 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 3 Dec 2020 09:11:17 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 3 Dec 2020 17:11:15 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Topic: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Index: AQHWx46tyJL5OgLpakCat9sEfhhBKKni9KEAgACKRLD//5RWAIAAjDiggAAA9pCAAKpoUIAARlmAgACFXCA=
Date:   Thu, 3 Dec 2020 09:11:15 +0000
Message-ID: <d81006facd444d8a83bd7f1e24ccf6d9@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
 <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
 <414fbd167b214452b925ac674575f0d6@hisilicon.com>
 <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
In-Reply-To: <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.109]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBHdWl0dG90
IFttYWlsdG86dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAzLCAyMDIwIDEwOjA0IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
IDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4gQ2M6IFZhbGVudGluIFNjaG5laWRlciA8
dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMNCj4gPGNhdGFsaW4u
bWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFJhZmFlbCBK
LiBXeXNvY2tpDQo+IDxyandAcmp3eXNvY2tpLm5ldD47IENjOiBMZW4gQnJvd24gPGxlbmJAa2Vy
bmVsLm9yZz47DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKb25hdGhhbiBDYW1lcm9u
IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBJbmdvIE1vbG5hciA8bWluZ29AcmVk
aGF0LmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEp1cmkNCj4g
TGVsbGkgPGp1cmkubGVsbGlAcmVkaGF0LmNvbT47IERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIu
ZWdnZW1hbm5AYXJtLmNvbT47DQo+IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3Jn
PjsgQmVuIFNlZ2FsbCA8YnNlZ2FsbEBnb29nbGUuY29tPjsgTWVsDQo+IEdvcm1hbiA8bWdvcm1h
bkBzdXNlLmRlPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IExBSw0KPiA8
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsDQo+IDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdA0KPiA8
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNv
bT47IHh1d2VpIChPKQ0KPiA8eHV3ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUu
emVuZ0BoaXNpbGljb24uY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MiAyLzJdIHNj
aGVkdWxlcjogYWRkIHNjaGVkdWxlciBsZXZlbCBmb3IgY2x1c3RlcnMNCj4gDQo+IE9uIFdlZCwg
MiBEZWMgMjAyMCBhdCAyMTo1OCwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPg0KPiA+ID4gU29ycnkuIFBs
ZWFzZSBpZ25vcmUgdGhpcy4gSSBhZGRlZCBzb21lIHByaW50ayBoZXJlIHdoaWxlIHRlc3RpbmcN
Cj4gPiA+IG9uZSBudW1hLiBXaWxsIHVwZGF0ZSB5b3UgdGhlIGRhdGEgaW4gYW5vdGhlciBlbWFp
bC4NCj4gPg0KPiA+IFJlLXRlc3RlZCBpbiBvbmUgTlVNQSBub2RlKGNwdTAtY3B1MjMpOg0KPiA+
DQo+ID4gZz0xDQo+ID4gUnVubmluZyBpbiB0aHJlYWRlZCBtb2RlIHdpdGggMSBncm91cHMgdXNp
bmcgNDAgZmlsZSBkZXNjcmlwdG9ycw0KPiA+IEVhY2ggc2VuZGVyIHdpbGwgcGFzcyAxMDAwMDAg
bWVzc2FnZXMgb2YgMTAwIGJ5dGVzDQo+ID4gdy9vOiA3LjY4OSA3LjQ4NSA3LjQ4NSA3LjQ1OCA3
LjUyNCA3LjUzOSA3LjczOCA3LjY5MyA3LjU2OCA3LjY3ND03LjU4NTMNCj4gPiB3LyA6IDcuNTE2
IDcuOTQxIDcuMzc0IDcuOTYzIDcuODgxIDcuOTEwIDcuNDIwIDcuNTU2IDcuNjk1IDcuNDQxPTcu
NjY5Nw0KPiA+IHcvIGJ1dCBkcm9wcGVkIHNlbGVjdF9pZGxlX2NsdXN0ZXI6DQo+ID4gICAgICA3
Ljc1MiA3LjczOSA3LjczOSA3LjU3MSA3LjU0NSA3LjY4NSA3LjQwNyA3LjU4MCA3LjYwNSA3LjQ4
Nz03LjYxMQ0KPiA+DQo+ID4gZz0yDQo+ID4gUnVubmluZyBpbiB0aHJlYWRlZCBtb2RlIHdpdGgg
MiBncm91cHMgdXNpbmcgNDAgZmlsZSBkZXNjcmlwdG9ycw0KPiA+IEVhY2ggc2VuZGVyIHdpbGwg
cGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5dGVzDQo+ID4gdy9vOiAxMC4xMjcgMTAuMTE5
IDEwLjA3MCAxMC4xOTYgMTAuMDU3IDEwLjExMSAxMC4wNDUgMTAuMTY0IDEwLjE2Mg0KPiA+IDku
OTU1PTEwLjEwMDYNCj4gPiB3LyA6IDkuNjk0IDkuNjU0IDkuNjEyIDkuNjQ5IDkuNjg2IDkuNzM0
IDkuNjA3IDkuODQyIDkuNjkwIDkuNzEwPTkuNjg3OA0KPiA+IHcvIGJ1dCBkcm9wcGVkIHNlbGVj
dF9pZGxlX2NsdXN0ZXI6DQo+ID4gICAgICA5Ljg3NyAxMC4wNjkgOS45NTEgOS45MTggOS45NDcg
OS43OTAgOS45MDYgOS44MjAgOS44NjMgOS45MDY9OS45MDQ3DQo+ID4NCj4gPiBnPTMNCj4gPiBS
dW5uaW5nIGluIHRocmVhZGVkIG1vZGUgd2l0aCAzIGdyb3VwcyB1c2luZyA0MCBmaWxlIGRlc2Ny
aXB0b3JzDQo+ID4gRWFjaCBzZW5kZXIgd2lsbCBwYXNzIDEwMDAwMCBtZXNzYWdlcyBvZiAxMDAg
Ynl0ZXMNCj4gPiB3L286IDE1Ljg4NSAxNS4yNTQgMTUuOTMyIDE1LjY0NyAxNi4xMjAgMTUuODc4
IDE1Ljg1NyAxNS43NTkgMTUuNjc0DQo+ID4gMTUuNzIxPTE1Ljc3MjcNCj4gPiB3LyA6IDE0Ljk3
NCAxNC42NTcgMTMuOTY5IDE0Ljk4NSAxNC43MjggMTUuNjY1IDE1LjE5MSAxNC45OTUgMTQuOTQ2
DQo+ID4gMTQuODk1PTE0LjkwMDUNCj4gPiB3LyBidXQgZHJvcHBlZCBzZWxlY3RfaWRsZV9jbHVz
dGVyOg0KPiA+ICAgICAgMTUuNDA1IDE1LjE3NyAxNS4zNzMgMTUuMTg3IDE1LjQ1MCAxNS41NDAg
MTUuMjc4IDE1LjYyOCAxNS4yMjgNCj4gMTUuMzI1PTE1LjM1OTENCj4gPg0KPiA+IGc9NA0KPiA+
IFJ1bm5pbmcgaW4gdGhyZWFkZWQgbW9kZSB3aXRoIDQgZ3JvdXBzIHVzaW5nIDQwIGZpbGUgZGVz
Y3JpcHRvcnMNCj4gPiBFYWNoIHNlbmRlciB3aWxsIHBhc3MgMTAwMDAwIG1lc3NhZ2VzIG9mIDEw
MCBieXRlcw0KPiA+IHcvbzogMjAuMDE0IDIxLjAyNSAyMS4xMTkgMjEuMjM1IDE5Ljc2NyAyMC45
NzEgMjAuOTYyIDIwLjkxNCAyMS4wOTANCj4gMjEuMDkwPTIwLjgxODcNCj4gPiB3LyA6IDIwLjMz
MSAyMC42MDggMjAuMzM4IDIwLjQ0NSAyMC40NTYgMjAuMTQ2IDIwLjY5MyAyMC43OTcgMjEuMzgx
DQo+IDIwLjQ1Mj0yMC41NjQ3DQo+ID4gdy8gYnV0IGRyb3BwZWQgc2VsZWN0X2lkbGVfY2x1c3Rl
cjoNCj4gPiAgICAgIDE5LjgxNCAyMC4xMjYgMjAuMjI5IDIwLjM1MCAyMC43NTAgMjAuNDA0IDE5
Ljk1NyAxOS44ODggMjAuMjI2DQo+IDIwLjU2Mj0yMC4yMzA2DQo+ID4NCj4gDQo+IEkgYXNzdW1l
IHRoYXQgeW91IGhhdmUgcnVuIHRoaXMgb24gdjUuOSBhcyBwcmV2aW91cyB0ZXN0cy4NCg0KWWVw
DQoNCj4gVGhlIHJlc3VsdHMgZG9uJ3Qgc2hvdyBhbnkgcmVhbCBiZW5lZml0IG9mIHNlbGVjdF9p
ZGxlX2NsdXN0ZXIoKQ0KPiBpbnNpZGUgYSBub2RlIHdoZXJlYXMgdGhpcyBpcyB3aGVyZSB3ZSBj
b3VsZCBleHBlY3QgbW9zdCBvZiB0aGUNCj4gYmVuZWZpdC4gV2UgaGF2ZSB0byB1bmRlcnN0YW5k
IHdoeSB3ZSBoYXZlIHN1Y2ggYW4gaW1wYWN0IG9uIG51bWENCj4gdGVzdHMgb25seS4NCg0KVGhl
cmUgaXMgYSA0LTUuNSUgaW5jcmVhc2Ugd2hpbGUgZz0yIGFuZCBnPTMuDQoNClJlZ2FyZGluZyB0
aGUgaHVnZSBpbmNyZWFzZSBpbiBOVU1BIGNhc2UsICBhdCB0aGUgZmlyc3QgYmVnaW5uaW5nLCBJ
IHN1c3BlY3QNCndlIGhhdmUgd3JvbmcgbGxjIGRvbWFpbi4gRm9yIGV4YW1wbGUsIGlmIGNwdTAn
cyBsbGMgZG9tYWluIHNwYW4NCmNwdTAtY3B1NDcsIHRoZW4gc2VsZWN0X2lkbGVfY3B1KCkgaXMg
cnVubmluZyBpbiB3cm9uZyByYW5nZSB3aGlsZQ0KaXQgc2hvdWxkIHJ1biBpbiBjcHUwLWNwdTIz
Lg0KDQpCdXQgYWZ0ZXIgcHJpbnRpbmcgdGhlIGxsYyBkb21haW4ncyBzcGFuLCBJIGZpbmQgaXQg
aXMgY29tcGxldGVseSByaWdodC4NCkNwdTAncyBsbGMgc3BhbjogY3B1MC1jcHUyMw0KQ3B1MjQn
cyBsbGMgc3BhbjogY3B1MjQtY3B1NDcNCg0KTWF5YmUgSSBuZWVkIG1vcmUgdHJhY2UgZGF0YSB0
byBmaWd1cmUgb3V0IGlmIHNlbGVjdF9pZGxlX2NwdSgpIGlzIHJ1bm5pbmcNCmNvcnJlY3RseS4g
Rm9yIGV4YW1wbGUsIG1heWJlIEkgY2FuIGZpZ3VyZSBvdXQgaWYgaXQgaXMgYWx3YXlzIHJldHVy
bmluZyAtMSwNCm9yIGl0IHJldHVybnMgLTEgdmVyeSBvZnRlbj8NCg0KT3IgZG8geW91IGhhdmUg
YW55IGlkZWE/DQoNCg0KPiANCj4gPiBUaGFua3MNCj4gPiBCYXJyeQ0KDQpUaGFua3MNCkJhcnJ5
DQoNCg==
