Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BD2D0DA5
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 11:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLGKAI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 05:00:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2212 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGKAI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 05:00:08 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqJch6Qfnz67MN5;
        Mon,  7 Dec 2020 17:56:52 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 10:59:24 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 09:59:23 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 7 Dec 2020 17:59:22 +0800
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
Thread-Index: AQHWx46tyJL5OgLpakCat9sEfhhBKKni9KEAgACKRLD//5RWAIAAjDiggAAA9pCAAKpoUIAARlmAgACFXCD//4SLAIAG0N6Q
Date:   Mon, 7 Dec 2020 09:59:21 +0000
Message-ID: <b6bfb636b1404d3c827e2ba2034e6822@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
 <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
 <414fbd167b214452b925ac674575f0d6@hisilicon.com>
 <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
 <d81006facd444d8a83bd7f1e24ccf6d9@hisilicon.com>
 <CAKfTPtAy_5QxnbmHq1pbGRhQYJ69ULovO6CKro-KkNKNnHMveg@mail.gmail.com>
In-Reply-To: <CAKfTPtAy_5QxnbmHq1pbGRhQYJ69ULovO6CKro-KkNKNnHMveg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.26]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBHdWl0dG90
IFttYWlsdG86dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAzLCAyMDIwIDEwOjM5IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
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
aGVkdWxlcjogYWRkIHNjaGVkdWxlciBsZXZlbCBmb3IgY2x1c3RlcnMNCj4gDQo+IE9uIFRodSwg
MyBEZWMgMjAyMCBhdCAxMDoxMSwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFZpbmNlbnQgR3VpdHRvdCBbbWFpbHRv
OnZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnXQ0KPiA+ID4gU2VudDogVGh1cnNkYXksIERlY2Vt
YmVyIDMsIDIwMjAgMTA6MDQgUE0NCj4gPiA+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
IDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4gPiA+IENjOiBWYWxlbnRpbiBTY2huZWlk
ZXIgPHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tPjsgQ2F0YWxpbiBNYXJpbmFzDQo+ID4gPiA8
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsg
UmFmYWVsIEouIFd5c29ja2kNCj4gPiA+IDxyandAcmp3eXNvY2tpLm5ldD47IENjOiBMZW4gQnJv
d24gPGxlbmJAa2VybmVsLm9yZz47DQo+ID4gPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
Sm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gPiA+
IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPjsgSnVyaQ0KPiA+ID4gTGVsbGkgPGp1cmkubGVsbGlAcmVkaGF0LmNvbT47
IERpZXRtYXIgRWdnZW1hbm4NCj4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT47DQo+ID4gPiBT
dGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47IEJlbiBTZWdhbGwgPGJzZWdhbGxA
Z29vZ2xlLmNvbT47IE1lbA0KPiA+ID4gR29ybWFuIDxtZ29ybWFuQHN1c2UuZGU+OyBNYXJrIFJ1
dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgTEFLDQo+ID4gPiA8bGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsDQo+ID4gPiA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QNCj4gPiA+IDxsaW51eC1h
Y3BpQHZnZXIua2VybmVsLm9yZz47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgeHV3
ZWkgKE8pDQo+ID4gPiA8eHV3ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVu
Z0BoaXNpbGljb24uY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMi8yXSBz
Y2hlZHVsZXI6IGFkZCBzY2hlZHVsZXIgbGV2ZWwgZm9yIGNsdXN0ZXJzDQo+ID4gPg0KPiA+ID4g
T24gV2VkLCAyIERlYyAyMDIwIGF0IDIxOjU4LCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+
ID4gPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gU29ycnkuIFBsZWFzZSBpZ25vcmUgdGhpcy4gSSBhZGRlZCBzb21lIHBy
aW50ayBoZXJlIHdoaWxlIHRlc3RpbmcNCj4gPiA+ID4gPiBvbmUgbnVtYS4gV2lsbCB1cGRhdGUg
eW91IHRoZSBkYXRhIGluIGFub3RoZXIgZW1haWwuDQo+ID4gPiA+DQo+ID4gPiA+IFJlLXRlc3Rl
ZCBpbiBvbmUgTlVNQSBub2RlKGNwdTAtY3B1MjMpOg0KPiA+ID4gPg0KPiA+ID4gPiBnPTENCj4g
PiA+ID4gUnVubmluZyBpbiB0aHJlYWRlZCBtb2RlIHdpdGggMSBncm91cHMgdXNpbmcgNDAgZmls
ZSBkZXNjcmlwdG9ycw0KPiA+ID4gPiBFYWNoIHNlbmRlciB3aWxsIHBhc3MgMTAwMDAwIG1lc3Nh
Z2VzIG9mIDEwMCBieXRlcw0KPiA+ID4gPiB3L286IDcuNjg5IDcuNDg1IDcuNDg1IDcuNDU4IDcu
NTI0IDcuNTM5IDcuNzM4IDcuNjkzIDcuNTY4IDcuNjc0PTcuNTg1Mw0KPiA+ID4gPiB3LyA6IDcu
NTE2IDcuOTQxIDcuMzc0IDcuOTYzIDcuODgxIDcuOTEwIDcuNDIwIDcuNTU2IDcuNjk1IDcuNDQx
PTcuNjY5Nw0KPiA+ID4gPiB3LyBidXQgZHJvcHBlZCBzZWxlY3RfaWRsZV9jbHVzdGVyOg0KPiA+
ID4gPiAgICAgIDcuNzUyIDcuNzM5IDcuNzM5IDcuNTcxIDcuNTQ1IDcuNjg1IDcuNDA3IDcuNTgw
IDcuNjA1IDcuNDg3PTcuNjExDQo+ID4gPiA+DQo+ID4gPiA+IGc9Mg0KPiA+ID4gPiBSdW5uaW5n
IGluIHRocmVhZGVkIG1vZGUgd2l0aCAyIGdyb3VwcyB1c2luZyA0MCBmaWxlIGRlc2NyaXB0b3Jz
DQo+ID4gPiA+IEVhY2ggc2VuZGVyIHdpbGwgcGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5
dGVzDQo+ID4gPiA+IHcvbzogMTAuMTI3IDEwLjExOSAxMC4wNzAgMTAuMTk2IDEwLjA1NyAxMC4x
MTEgMTAuMDQ1IDEwLjE2NCAxMC4xNjINCj4gPiA+ID4gOS45NTU9MTAuMTAwNg0KPiA+ID4gPiB3
LyA6IDkuNjk0IDkuNjU0IDkuNjEyIDkuNjQ5IDkuNjg2IDkuNzM0IDkuNjA3IDkuODQyIDkuNjkw
IDkuNzEwPTkuNjg3OA0KPiA+ID4gPiB3LyBidXQgZHJvcHBlZCBzZWxlY3RfaWRsZV9jbHVzdGVy
Og0KPiA+ID4gPiAgICAgIDkuODc3IDEwLjA2OSA5Ljk1MSA5LjkxOCA5Ljk0NyA5Ljc5MCA5Ljkw
NiA5LjgyMCA5Ljg2MyA5LjkwNj05LjkwNDcNCj4gPiA+ID4NCj4gPiA+ID4gZz0zDQo+ID4gPiA+
IFJ1bm5pbmcgaW4gdGhyZWFkZWQgbW9kZSB3aXRoIDMgZ3JvdXBzIHVzaW5nIDQwIGZpbGUgZGVz
Y3JpcHRvcnMNCj4gPiA+ID4gRWFjaCBzZW5kZXIgd2lsbCBwYXNzIDEwMDAwMCBtZXNzYWdlcyBv
ZiAxMDAgYnl0ZXMNCj4gPiA+ID4gdy9vOiAxNS44ODUgMTUuMjU0IDE1LjkzMiAxNS42NDcgMTYu
MTIwIDE1Ljg3OCAxNS44NTcgMTUuNzU5IDE1LjY3NA0KPiA+ID4gPiAxNS43MjE9MTUuNzcyNw0K
PiA+ID4gPiB3LyA6IDE0Ljk3NCAxNC42NTcgMTMuOTY5IDE0Ljk4NSAxNC43MjggMTUuNjY1IDE1
LjE5MSAxNC45OTUgMTQuOTQ2DQo+ID4gPiA+IDE0Ljg5NT0xNC45MDA1DQo+ID4gPiA+IHcvIGJ1
dCBkcm9wcGVkIHNlbGVjdF9pZGxlX2NsdXN0ZXI6DQo+ID4gPiA+ICAgICAgMTUuNDA1IDE1LjE3
NyAxNS4zNzMgMTUuMTg3IDE1LjQ1MCAxNS41NDAgMTUuMjc4IDE1LjYyOCAxNS4yMjgNCj4gPiA+
IDE1LjMyNT0xNS4zNTkxDQo+ID4gPiA+DQo+ID4gPiA+IGc9NA0KPiA+ID4gPiBSdW5uaW5nIGlu
IHRocmVhZGVkIG1vZGUgd2l0aCA0IGdyb3VwcyB1c2luZyA0MCBmaWxlIGRlc2NyaXB0b3JzDQo+
ID4gPiA+IEVhY2ggc2VuZGVyIHdpbGwgcGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5dGVz
DQo+ID4gPiA+IHcvbzogMjAuMDE0IDIxLjAyNSAyMS4xMTkgMjEuMjM1IDE5Ljc2NyAyMC45NzEg
MjAuOTYyIDIwLjkxNCAyMS4wOTANCj4gPiA+IDIxLjA5MD0yMC44MTg3DQo+ID4gPiA+IHcvIDog
MjAuMzMxIDIwLjYwOCAyMC4zMzggMjAuNDQ1IDIwLjQ1NiAyMC4xNDYgMjAuNjkzIDIwLjc5NyAy
MS4zODENCj4gPiA+IDIwLjQ1Mj0yMC41NjQ3DQo+ID4gPiA+IHcvIGJ1dCBkcm9wcGVkIHNlbGVj
dF9pZGxlX2NsdXN0ZXI6DQo+ID4gPiA+ICAgICAgMTkuODE0IDIwLjEyNiAyMC4yMjkgMjAuMzUw
IDIwLjc1MCAyMC40MDQgMTkuOTU3IDE5Ljg4OCAyMC4yMjYNCj4gPiA+IDIwLjU2Mj0yMC4yMzA2
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSBhc3N1bWUgdGhhdCB5b3UgaGF2ZSBydW4gdGhpcyBv
biB2NS45IGFzIHByZXZpb3VzIHRlc3RzLg0KPiA+DQo+ID4gWWVwDQo+ID4NCj4gPiA+IFRoZSBy
ZXN1bHRzIGRvbid0IHNob3cgYW55IHJlYWwgYmVuZWZpdCBvZiBzZWxlY3RfaWRsZV9jbHVzdGVy
KCkNCj4gPiA+IGluc2lkZSBhIG5vZGUgd2hlcmVhcyB0aGlzIGlzIHdoZXJlIHdlIGNvdWxkIGV4
cGVjdCBtb3N0IG9mIHRoZQ0KPiA+ID4gYmVuZWZpdC4gV2UgaGF2ZSB0byB1bmRlcnN0YW5kIHdo
eSB3ZSBoYXZlIHN1Y2ggYW4gaW1wYWN0IG9uIG51bWENCj4gPiA+IHRlc3RzIG9ubHkuDQo+ID4N
Cj4gPiBUaGVyZSBpcyBhIDQtNS41JSBpbmNyZWFzZSB3aGlsZSBnPTIgYW5kIGc9My4NCj4gDQo+
IG15IHBvaW50IHdhcyB3aXRoIHZzIHdpdGhvdXQgc2VsZWN0X2lkbGVfY2x1c3RlcigpIGJ1dCBz
dGlsbCBoYXZpbmcgYQ0KPiBjbHVzdGVyIGRvbWFpbiBsZXZlbA0KPiBJbiB0aGlzIGNhc2UsIHRo
ZSBkaWZmIGlzIC0wLjglIGZvciBnPTEgKzIuMiUgZm9yIGc9MiwgKzMlIGZvciBnPTMgYW5kDQo+
IC0xLjclIGZvciBnPTQNCj4gDQo+ID4NCj4gPiBSZWdhcmRpbmcgdGhlIGh1Z2UgaW5jcmVhc2Ug
aW4gTlVNQSBjYXNlLCAgYXQgdGhlIGZpcnN0IGJlZ2lubmluZywgSSBzdXNwZWN0DQo+ID4gd2Ug
aGF2ZSB3cm9uZyBsbGMgZG9tYWluLiBGb3IgZXhhbXBsZSwgaWYgY3B1MCdzIGxsYyBkb21haW4g
c3Bhbg0KPiA+IGNwdTAtY3B1NDcsIHRoZW4gc2VsZWN0X2lkbGVfY3B1KCkgaXMgcnVubmluZyBp
biB3cm9uZyByYW5nZSB3aGlsZQ0KPiA+IGl0IHNob3VsZCBydW4gaW4gY3B1MC1jcHUyMy4NCj4g
Pg0KPiA+IEJ1dCBhZnRlciBwcmludGluZyB0aGUgbGxjIGRvbWFpbidzIHNwYW4sIEkgZmluZCBp
dCBpcyBjb21wbGV0ZWx5IHJpZ2h0Lg0KPiA+IENwdTAncyBsbGMgc3BhbjogY3B1MC1jcHUyMw0K
PiA+IENwdTI0J3MgbGxjIHNwYW46IGNwdTI0LWNwdTQ3DQo+IA0KPiBIYXZlIHlvdSBjaGVja2Vk
IHRoYXQgdGhlIGNsdXN0ZXIgbWFzayB3YXMgYWxzbyBjb3JyZWN0ID8NCj4gDQo+ID4NCj4gPiBN
YXliZSBJIG5lZWQgbW9yZSB0cmFjZSBkYXRhIHRvIGZpZ3VyZSBvdXQgaWYgc2VsZWN0X2lkbGVf
Y3B1KCkgaXMgcnVubmluZw0KPiA+IGNvcnJlY3RseS4gRm9yIGV4YW1wbGUsIG1heWJlIEkgY2Fu
IGZpZ3VyZSBvdXQgaWYgaXQgaXMgYWx3YXlzIHJldHVybmluZyAtMSwNCj4gPiBvciBpdCByZXR1
cm5zIC0xIHZlcnkgb2Z0ZW4/DQo+IA0KPiB5ZXMsIGNvdWxkIGJlIGludGVyZXN0aW5nIHRvIGNo
ZWNrIGhvdyBvZnRlbiBzZWxlY3RfaWRsZV9jcHUgcmV0dXJuIC0xDQo+IA0KPiA+DQo+ID4gT3Ig
ZG8geW91IGhhdmUgYW55IGlkZWE/DQo+IA0KPiB0cmFja2luZyBtaWdyYXRpb24gYWNyb3NzIG5v
ZCBjb3VsZCBoZWxwIHRvIHVuZGVyc3RhbmQgdG9vDQoNCkkgc2V0IGEgYm9vdGFyZ3MgbWVtPTRH
IHRvIGRvIHN3YXBwaW5nIHRlc3QgYmVmb3JlIHdvcmtpbmcgb24gY2x1c3Rlcg0Kc2NoZWR1bGVy
IGlzc3VlLiBidXQgSSBmb3Jnb3QgdG8gcmVtb3ZlIHRoZSBwYXJhbWV0ZXIuDQoNClRoZSBodWdl
IGluY3JlYXNlIG9uIGFjcm9zcy1udW1hIGNhc2UgY2FuIG9ubHkgYmUgcmVwcm9kdWNlZCB3aGls
ZQ0KaSB1c2UgdGhpcyBtZW09NEcgY21kbGluZSB3aGljaCBtZWFucyBudW1hMSBoYXMgbm8gbWVt
b3J5Lg0KQWZ0ZXIgcmVtb3ZpbmcgdGhlIGxpbWl0YXRpb24sIEkgY2FuJ3QgcmVwcm9kdWNlIHRo
ZSBodWdlIGluY3JlYXNlDQpmb3IgdHdvIE5VTUFzIGFueSBtb3JlLg0KDQpHdWVzcyBzZWxlY3Rf
aWRsZV9jbHVzdGVyKCkgc29tZWhvdyB3b3JrYXJvdW5kIGFuIHNjaGVkdWxlciBpc3N1ZQ0KZm9y
IG51bWEgd2l0aG91dCBtZW1vcnkuDQoNCj4gDQo+IFZpbmNlbnQNCj4gPg0KPiA+DQoNClRoYW5r
cw0KQmFycnkNCg0K
