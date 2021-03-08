Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6A331A0F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 23:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhCHWPo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 17:15:44 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4648 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHWPO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 17:15:14 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DvXfk4tyczYGrj;
        Tue,  9 Mar 2021 06:13:34 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 9 Mar 2021 06:15:10 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 06:15:10 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 9 Mar 2021 06:15:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Tim Chen <tim.c.chen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Cc: Len Brown" <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        yangyicong <yangyicong@huawei.com>, x86 <x86@kernel.org>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Thread-Topic: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Thread-Index: AQHXDu99D3AbdiYnOU2vOW1slo8ZO6p5d6KAgAE3XxA=
Date:   Mon, 8 Mar 2021 22:15:10 +0000
Message-ID: <ac28f09819c745d0b42f1716da022594@hisilicon.com>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-3-song.bao.hua@hisilicon.com>
 <CAKfTPtAeCHoYTYrQZK-4MQ1Q5U-CXvt1GfKKb9NCnE62D8h4-g@mail.gmail.com>
In-Reply-To: <CAKfTPtAeCHoYTYrQZK-4MQ1Q5U-CXvt1GfKKb9NCnE62D8h4-g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.229]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBHdWl0dG90
IFttYWlsdG86dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmddDQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDksIDIwMjEgMTI6MjYgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNv
bmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiBDYzogVGltIENoZW4gPHRpbS5jLmNoZW5AbGlu
dXguaW50ZWwuY29tPjsgQ2F0YWxpbiBNYXJpbmFzDQo+IDxjYXRhbGluLm1hcmluYXNAYXJtLmNv
bT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraQ0KPiA8
cmp3QHJqd3lzb2NraS5uZXQ+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IFRob21h
cyBHbGVpeG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJl
ZGhhdC5jb20+OyBDYzogTGVuIEJyb3duDQo+IDxsZW5iQGtlcm5lbC5vcmc+OyBQZXRlciBaaWps
c3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBEaWV0bWFyIEVnZ2VtYW5uDQo+IDxkaWV0bWFy
LmVnZ2VtYW5uQGFybS5jb20+OyBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47
IEJlbiBTZWdhbGwNCj4gPGJzZWdhbGxAZ29vZ2xlLmNvbT47IE1lbCBHb3JtYW4gPG1nb3JtYW5A
c3VzZS5kZT47IEp1cmkgTGVsbGkNCj4gPGp1cmkubGVsbGlAcmVkaGF0LmNvbT47IE1hcmsgUnV0
bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBdWJyZXkgTGkNCj4gPGF1YnJleS5saUBsaW51
eC5pbnRlbC5jb20+OyBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IFplbmd0YW8gKEIp
DQo+IDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBHdW9kb25nIFh1IDxndW9kb25nLnh1QGxp
bmFyby5vcmc+Ow0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgU3VkZWVwIEhvbGxhIDxz
dWRlZXAuaG9sbGFAYXJtLmNvbT47IGxpbnV4LWtlcm5lbA0KPiA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IGxpbnV4YXJtQG9wZW5ldWxlci5vcmc7IEFDUEkgRGV2ZWwgTWFsaW5nDQo+
IExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgeHV3ZWkgKE8pIDx4dXdlaTVAaHVh
d2VpLmNvbT47IEpvbmF0aGFuDQo+IENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT47IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47DQo+IHg4NiA8eDg2QGtlcm5l
bC5vcmc+OyBtc3lzLm1penVtYUBnbWFpbC5jb207IExpZ3Vvemh1IChLZW5uZXRoKQ0KPiA8bGln
dW96aHVAaGlzaWxpY29uLmNvbT47IFZhbGVudGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVp
ZGVyQGFybS5jb20+Ow0KPiBMQUsgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjQgMi8zXSBzY2hlZHVsZXI6IGFkZCBzY2hl
ZHVsZXIgbGV2ZWwgZm9yIGNsdXN0ZXJzDQo+IA0KPiBPbiBUdWUsIDIgTWFyIDIwMjEgYXQgMDA6
MDgsIEJhcnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPiB3cm90ZToNCj4gPg0K
PiA+IEFSTTY0IGNoaXAgS3VucGVuZyA5MjAgaGFzIDYgb3IgOCBjbHVzdGVycyBpbiBlYWNoIE5V
TUEgbm9kZSwgYW5kIGVhY2gNCj4gPiBjbHVzdGVyIGhhcyA0IGNwdXMuIEFsbCBjbHVzdGVycyBz
aGFyZSBMMyBjYWNoZSBkYXRhLCBidXQgZWFjaCBjbHVzdGVyDQo+ID4gaGFzIGxvY2FsIEwzIHRh
Zy4gT24gdGhlIG90aGVyIGhhbmQsIGVhY2ggY2x1c3RlcnMgd2lsbCBzaGFyZSBzb21lDQo+ID4g
aW50ZXJuYWwgc3lzdGVtIGJ1cy4gVGhpcyBtZWFucyBjYWNoZSBjb2hlcmVuY2Ugb3ZlcmhlYWQg
aW5zaWRlIG9uZQ0KPiA+IGNsdXN0ZXIgaXMgbXVjaCBsZXNzIHRoYW4gdGhlIG92ZXJoZWFkIGFj
cm9zcyBjbHVzdGVycy4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc2NoZWRfZG9tYWlu
IGZvciBjbHVzdGVycy4gT24ga3VucGVuZyA5MjAsIHdpdGhvdXQNCj4gPiB0aGlzIHBhdGNoLCBk
b21haW4wIG9mIGNwdTAgd291bGQgYmUgTUMgd2l0aCBjcHUwfmNwdTIzIHdpdGggOyB3aXRoIHRo
aXMNCj4gPiBwYXRjaCwgTUMgYmVjb21lcyBkb21haW4xLCBhIG5ldyBkb21haW4wICJDTFMiIGlu
Y2x1ZGluZyBjcHUwLWNwdTMuDQo+ID4NCj4gPiBUaGlzIHdpbGwgaGVscCBzcHJlYWQgdW5yZWxh
dGVkIHRhc2tzIGFtb25nIGNsdXN0ZXJzLCB0aHVzIGRlY3JlYXNlIHRoZQ0KPiA+IGNvbnRlbnRp
b24gYW5kIGltcHJvdmUgdGhlIHRocm91Z2hwdXQsIGZvciBleGFtcGxlLCBzdHJlYW0gYmVuY2ht
YXJrIGNhbg0KPiA+IGltcHJvdmUgYXJvdW5kIDQuMyV+Ni4zJSBieSB0aGlzIHBhdGNoOg0KPiA+
DQo+ID4gdy9vIHBhdGNoOg0KPiA+IG51bWFjdGwgLU4gMCAvdXNyL2xpYi9sbWJlbmNoL2Jpbi9z
dHJlYW0gLVAgMTIgLU0gMTAyNE0gLU4gNQ0KPiA+IFNUUkVBTSBjb3B5IGxhdGVuY3k6IDMuMzYg
bmFub3NlY29uZHMNCj4gPiBTVFJFQU0gY29weSBiYW5kd2lkdGg6IDU3MDcyLjUwIE1CL3NlYw0K
PiA+IFNUUkVBTSBzY2FsZSBsYXRlbmN5OiAzLjQwIG5hbm9zZWNvbmRzDQo+ID4gU1RSRUFNIHNj
YWxlIGJhbmR3aWR0aDogNTY1NDIuNTIgTUIvc2VjDQo+ID4gU1RSRUFNIGFkZCBsYXRlbmN5OiA1
LjEwIG5hbm9zZWNvbmRzDQo+ID4gU1RSRUFNIGFkZCBiYW5kd2lkdGg6IDU2NDgyLjgzIE1CL3Nl
Yw0KPiA+IFNUUkVBTSB0cmlhZCBsYXRlbmN5OiA1LjE0IG5hbm9zZWNvbmRzDQo+ID4gU1RSRUFN
IHRyaWFkIGJhbmR3aWR0aDogNTYwNjkuNTIgTUIvc2VjDQo+ID4NCj4gPiB3LyBwYXRjaDoNCj4g
PiAkIG51bWFjdGwgLU4gMCAvdXNyL2xpYi9sbWJlbmNoL2Jpbi9zdHJlYW0gLVAgMTIgLU0gMTAy
NE0gLU4gNQ0KPiA+IFNUUkVBTSBjb3B5IGxhdGVuY3k6IDMuMjIgbmFub3NlY29uZHMNCj4gPiBT
VFJFQU0gY29weSBiYW5kd2lkdGg6IDU5NjYwLjk2IE1CL3NlYyAgICAtPiAgKzQuNSUNCj4gPiBT
VFJFQU0gc2NhbGUgbGF0ZW5jeTogMy4yNSBuYW5vc2Vjb25kcw0KPiA+IFNUUkVBTSBzY2FsZSBi
YW5kd2lkdGg6IDU5MDAyLjI5IE1CL3NlYyAgIC0+ICArNC4zJQ0KPiA+IFNUUkVBTSBhZGQgbGF0
ZW5jeTogNC44MCBuYW5vc2Vjb25kcw0KPiA+IFNUUkVBTSBhZGQgYmFuZHdpZHRoOiA2MDAzNi42
MiBNQi9zZWMgICAgIC0+ICArNi4zJQ0KPiA+IFNUUkVBTSB0cmlhZCBsYXRlbmN5OiA0Ljg2IG5h
bm9zZWNvbmRzDQo+ID4gU1RSRUFNIHRyaWFkIGJhbmR3aWR0aDogNTkyMjguMzAgTUIvc2VjICAg
LT4gICs1LjYlDQo+ID4NCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgd2hpbGUgZG9pbmcgV0FLRV9B
RkZJTkUsIHRoaXMgcGF0Y2ggd2lsbCB0cnkgdG8gZmluZA0KPiA+IGEgY29yZSBpbiB0aGUgdGFy
Z2V0IGNsdXN0ZXIgYmVmb3JlIHNjYW5uaW5nIHRoZSB3aG9sZSBsbGMgZG9tYWluLiBTbyBpdA0K
PiA+IGhlbHBzIGdhdGhlciByZWxhdGVkIHRhc2tzIHdpdGhpbiBvbmUgY2x1c3Rlci4NCj4gDQo+
IENvdWxkIHlvdSBzcGxpdCB0aGlzIHBhdGNoIGluIDIgcGF0Y2hlcyA/IE9uZSBmb3IgYWRkaW5n
IGEgY2x1c3Rlcg0KPiBzY2hlZCBkb21haW4gbGV2ZWwgYW5kIG9uZSBmb3IgbW9kaWZ5aW5nIHRo
ZSB3YWtlIHVwIHBhdGggPw0KDQpZZXMuIElmIHRoaXMgaXMgaGVscGZ1bCwgSSB3b3VsZCBsaWtl
IHRvIHNwbGl0IGludG8gdHdvIHBhdGNoZXMuDQoNCj4gDQo+IFRoaXMgd291bGQgZWFzZSB0aGUg
cmV2aWV3IGFuZCBJIHdvdWxkIGJlIGN1cmlvdXMgYWJvdXQgdGhlIGltcGFjdCBvZg0KPiBlYWNo
IGZlYXR1cmUgaW4gdGhlIHBlcmZvcm1hbmNlLiBJbiBwYXJ0aWN1bGFyLCBJJ20gc3RpbGwgbm90
DQo+IGNvbnZpbmNlZCB0aGF0IHRoZSBtb2RpZmljYXRpb24gb2YgdGhlIHdha2V1cCBwYXRoIGlz
IHRoZSByb290IG9mIHRoZQ0KPiBoYWNrYmVuY2ggaW1wcm92ZW1lbnQ7IGVzcGVjaWFsbHkgd2l0
aCBnPTE0IHdoZXJlIHRoZXJlIHNob3VsZCBub3QgYmUNCj4gbXVjaCBpZGxlIENQVXMgd2l0aCAx
NCo0MCB0YXNrcyBvbiBhdCBtb3N0IDMyIENQVXMuICBJSVJDLCB0aGVyZSB3YXMNCg0KTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IHRocmVhZHMgY291bGQgYmUgYmxvY2tlZCBkdWUgdG8gcGlwZS4g
U28gQ1BVcw0Kc3RpbGwgaGF2ZSBzb21lIGNoYW5jZSB0byBiZSBpZGxlIGZvciBhIGJpZyBnLiBB
bHNvIG5vdGUgdGhlIGRlZmF1bHQgZw0Kb2YgaGFja2JlbmNoIGlzIDEwLg0KDQpBbnl3YXksIGkn
ZCBsaWtlIHRvIGFkZCBzb21lIHRyYWNlcG9pbnRzIHRvIGdldCB0aGUgcGVyY2VudGFnZXMgb2Yg
aG93DQptYW55IGFyZSBwaWNrZWQgZnJvbSBjbHVzdGVyLCBob3cgbWFueSBhcmUgc2VsZWN0ZWQg
ZnJvbSBjcHVzIG91dHNpZGUNCmNsdXN0ZXIuDQoNCj4gbm8gb2J2aW91cyBpbXByb3ZlbWVudCB3
aXRoIHRoZSBjaGFuZ2VzIGluIHNlbGVjdF9pZGxlX2NwdSB1bmxlc3MgeW91DQo+IGhhY2sgdGhl
IGJlaGF2aW9yIHRvIG5vdCBmYWxsIGJhY2sgdG8gbGxjIGRvbWFpbg0KPiANCg0KWW91IGhhdmUg
YSBnb29kIG1lbW9yeS4gSW4gYSB2ZXJ5IG9sZCB2ZXJzaW9uIEkgb25jZSBtZW50aW9uZWQgdGhh
dC4gQnV0DQphdCB0aGF0IHRpbWUsIEkgZGlkbid0IGRlY3JlYXNlIG5yIGFmdGVyIHNjYW5uaW5n
IGNsdXN0ZXIsIHNvIGl0IHdhcw0Kc2Nhbm5pbmcgYXQgbGVhc3QgOCBjcHVzKDQgd2l0aGluIGNs
dXN0ZXIsIDQgb3V0c2lkZSBjbHVzdGVyKS4gSSBndWVzcw0KdGhhdCBpcyB0aGUgcmVhc29uIG15
IGhhY2sgdG8gbm90IGZhbGwgYmFjayB0byBsbGMgZG9tYWluIGNvdWxkIGJyaW5naW5nDQphY3R1
YWwgaGFja2JlbmNoIGltcHJvdmVtZW50Lg0KDQo+ID4gd2UgcnVuIHRoZSBiZWxvdyBoYWNrYmVu
Y2ggd2l0aCBkaWZmZXJlbnQgLWcgcGFyYW1ldGVyIGZyb20gMiB0byAxNCwgZm9yDQo+ID4gZWFj
aCBkaWZmZXJlbnQgZywgd2UgcnVuIHRoZSBjb21tYW5kIDEwIHRpbWVzIGFuZCBnZXQgdGhlIGF2
ZXJhZ2UgdGltZQ0KPiA+ICQgbnVtYWN0bCAtTiAwIGhhY2tiZW5jaCAtcCAtVCAtbCAyMDAwMCAt
ZyAkMQ0KPiA+DQo+ID4gaGFja2JlbmNoIHdpbGwgcmVwb3J0IHRoZSB0aW1lIHdoaWNoIGlzIG5l
ZWRlZCB0byBjb21wbGV0ZSBhIGNlcnRhaW4gbnVtYmVyDQo+ID4gb2YgbWVzc2FnZXMgdHJhbnNt
aXNzaW9ucyBiZXR3ZWVuIGEgY2VydGFpbiBudW1iZXIgb2YgdGFza3MsIGZvciBleGFtcGxlOg0K
PiA+ICQgbnVtYWN0bCAtTiAwIGhhY2tiZW5jaCAtcCAtVCAtbCAyMDAwMCAtZyAxMA0KPiA+IFJ1
bm5pbmcgaW4gdGhyZWFkZWQgbW9kZSB3aXRoIDEwIGdyb3VwcyB1c2luZyA0MCBmaWxlIGRlc2Ny
aXB0b3JzIGVhY2gNCj4gPiAoPT0gNDAwIHRhc2tzKQ0KPiA+IEVhY2ggc2VuZGVyIHdpbGwgcGFz
cyAyMDAwMCBtZXNzYWdlcyBvZiAxMDAgYnl0ZXMNCj4gPiBUaW1lOiA4Ljg3NA0KPiA+DQo+ID4g
VGhlIGJlbG93IGlzIHRoZSByZXN1bHQgb2YgaGFja2JlbmNoIHcvIGFuZCB3L28gdGhlIHBhdGNo
Og0KPiA+IGc9ICAgIDIgICAgICA0ICAgICA2ICAgICAgIDggICAgICAxMCAgICAgMTIgICAgICAx
NA0KPiA+IHcvbzogMS45NTk2IDQuMDUwNiA1Ljk2NTQgOC4wMDY4IDkuODE0NyAxMS40OTAwIDEz
LjExNjMNCj4gPiB3LyA6IDEuOTM2MiAzLjkxOTcgNS42NTcwIDcuMTM3NiA4LjUyNjMgMTAuMDUx
MiAxMS4zMjU2DQo+ID4gICAgICAgICAgICAgKzMuMyUgICs1LjIlICArMTAuOSUgKzEzLjIlICAr
MTIuOCUgICsxMy43JQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFycnkgU29uZyA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+ID4gLS0tDQo+ID4gLXY0Og0KPiA+ICAgKiByZWJhc2Vk
IHRvIHRpcC9zY2hlZC9jb3JlIHdpdGggdGhlIGxhdGVzdCB1bmlmaWVkIGNvZGUgb2Ygc2VsZWN0
X2lkbGVfY3B1DQo+ID4gICAqIGFsc28gYWRkZWQgYmVuY2htYXJrIGRhdGEgb2Ygc3ByZWFkaW5n
IHVucmVsYXRlZCB0YXNrcw0KPiA+ICAgKiBhdm9pZGVkIHRoZSBpdGVyYXRpb24gb2Ygc2NoZWRf
ZG9tYWluIGJ5IG1vdmluZyB0byBzdGF0aWNfa2V5KGFkZHJlc3NpbmcNCj4gPiAgICAgVmluY2Vu
dCdzIGNvbW1lbnQNCj4gPg0KPiA+ICBhcmNoL2FybTY0L0tjb25maWcgICAgICAgICAgICAgfCAg
NyArKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NjaGVkL2NsdXN0ZXIuaCAgfCAxOSArKysrKysr
KysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9zY2hlZC9zZF9mbGFncy5oIHwgIDkgKysrKysrDQo+
ID4gIGluY2x1ZGUvbGludXgvc2NoZWQvdG9wb2xvZ3kuaCB8ICA3ICsrKysrDQo+ID4gIGluY2x1
ZGUvbGludXgvdG9wb2xvZ3kuaCAgICAgICB8ICA3ICsrKysrDQo+ID4gIGtlcm5lbC9zY2hlZC9j
b3JlLmMgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKw0KPiA+ICBrZXJuZWwvc2NoZWQvZmFp
ci5jICAgICAgICAgICAgfCA2Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4gPiAga2VybmVsL3NjaGVkL3NjaGVkLmggICAgICAgICAgIHwgIDEgKw0KPiA+
ICBrZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYyAgICAgICAgfCAgNiArKysrDQo+ID4gIDkgZmlsZXMg
Y2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zY2hlZC9jbHVzdGVyLmgNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L0tjb25maWcgYi9hcmNoL2FybTY0L0tjb25maWcNCj4gPiBpbmRl
eCBmMzk1NjhiLi4xNThiMGZhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvS2NvbmZpZw0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZw0KPiA+IEBAIC05NzEsNiArOTcxLDEzIEBAIGNv
bmZpZyBTQ0hFRF9NQw0KPiA+ICAgICAgICAgICBtYWtpbmcgd2hlbiBkZWFsaW5nIHdpdGggbXVs
dGktY29yZSBDUFUgY2hpcHMgYXQgYSBjb3N0IG9mIHNsaWdodGx5DQo+ID4gICAgICAgICAgIGlu
Y3JlYXNlZCBvdmVyaGVhZCBpbiBzb21lIHBsYWNlcy4gSWYgdW5zdXJlIHNheSBOIGhlcmUuDQo+
ID4NCj4gPiArY29uZmlnIFNDSEVEX0NMVVNURVINCj4gPiArICAgICAgIGJvb2wgIkNsdXN0ZXIg
c2NoZWR1bGVyIHN1cHBvcnQiDQo+ID4gKyAgICAgICBoZWxwDQo+ID4gKyAgICAgICAgIENsdXN0
ZXIgc2NoZWR1bGVyIHN1cHBvcnQgaW1wcm92ZXMgdGhlIENQVSBzY2hlZHVsZXIncyBkZWNpc2lv
bg0KPiA+ICsgICAgICAgICBtYWtpbmcgd2hlbiBkZWFsaW5nIHdpdGggbWFjaGluZXMgdGhhdCBo
YXZlIGNsdXN0ZXJzKHNoYXJpbmcgaW50ZXJuYWwNCj4gPiArICAgICAgICAgYnVzIG9yIHNoYXJp
bmcgTExDIGNhY2hlIHRhZykuIElmIHVuc3VyZSBzYXkgTiBoZXJlLg0KPiA+ICsNCj4gPiAgY29u
ZmlnIFNDSEVEX1NNVA0KPiA+ICAgICAgICAgYm9vbCAiU01UIHNjaGVkdWxlciBzdXBwb3J0Ig0K
PiA+ICAgICAgICAgaGVscA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL2Ns
dXN0ZXIuaCBiL2luY2x1ZGUvbGludXgvc2NoZWQvY2x1c3Rlci5oDQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5lYTZjNDc1DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQvY2x1c3Rlci5oDQo+ID4gQEAgLTAsMCArMSwx
OSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ICsj
aWZuZGVmIF9MSU5VWF9TQ0hFRF9DTFVTVEVSX0gNCj4gPiArI2RlZmluZSBfTElOVVhfU0NIRURf
Q0xVU1RFUl9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3RhdGljX2tleS5oPg0KPiA+
ICsNCj4gPiArI2lmZGVmIENPTkZJR19TQ0hFRF9DTFVTVEVSDQo+ID4gK2V4dGVybiBzdHJ1Y3Qg
c3RhdGljX2tleV9mYWxzZSBzY2hlZF9jbHVzdGVyX3ByZXNlbnQ7DQo+ID4gKw0KPiA+ICtzdGF0
aWMgX19hbHdheXNfaW5saW5lIGJvb2wgc2NoZWRfY2x1c3Rlcl9hY3RpdmUodm9pZCkNCj4gPiAr
ew0KPiA+ICsgICAgICAgcmV0dXJuIHN0YXRpY19icmFuY2hfbGlrZWx5KCZzY2hlZF9jbHVzdGVy
X3ByZXNlbnQpOw0KPiA+ICt9DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBz
Y2hlZF9jbHVzdGVyX2FjdGl2ZSh2b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPiA+ICsNCj4gPiAr
I2VuZGlmDQo+ID4gKw0KPiA+ICsjZW5kaWYNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9zY2hlZC9zZF9mbGFncy5oDQo+IGIvaW5jbHVkZS9saW51eC9zY2hlZC9zZF9mbGFncy5oDQo+
ID4gaW5kZXggMzRiMjFlOS4uZmMzYzg5NCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3NjaGVkL3NkX2ZsYWdzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkL3NkX2ZsYWdz
LmgNCj4gPiBAQCAtMTAwLDYgKzEwMCwxNSBAQA0KPiA+ICBTRF9GTEFHKFNEX1NIQVJFX0NQVUNB
UEFDSVRZLCBTREZfU0hBUkVEX0NISUxEIHwgU0RGX05FRURTX0dST1VQUykNCj4gPg0KPiA+ICAv
Kg0KPiA+ICsgKiBEb21haW4gbWVtYmVycyBzaGFyZSBDUFUgY2x1c3RlciByZXNvdXJjZXMgKGku
ZS4gbGxjIGNhY2hlIHRhZ3MpDQo+ID4gKyAqDQo+ID4gKyAqIFNIQVJFRF9DSElMRDogU2V0IGZy
b20gdGhlIGJhc2UgZG9tYWluIHVwIHVudGlsIHNwYW5uZWQgQ1BVcyBubyBsb25nZXINCj4gc2hh
cmUNCj4gPiArICogICAgICAgICAgICAgICB0aGUgY2x1c3RlciByZXNvdWNlcyAoc3VjaCBhcyBs
bGMgdGFncyBhbmQgaW50ZXJuYWwgYnVzKQ0KPiA+ICsgKiBORUVEU19HUk9VUFM6IENhY2hlcyBh
cmUgc2hhcmVkIGJldHdlZW4gZ3JvdXBzLg0KPiA+ICsgKi8NCj4gPiArU0RfRkxBRyhTRF9TSEFS
RV9DTFNfUkVTT1VSQ0VTLCBTREZfU0hBUkVEX0NISUxEIHwgU0RGX05FRURTX0dST1VQUykNCj4g
PiArDQo+ID4gKy8qDQo+ID4gICAqIERvbWFpbiBtZW1iZXJzIHNoYXJlIENQVSBwYWNrYWdlIHJl
c291cmNlcyAoaS5lLiBjYWNoZXMpDQo+ID4gICAqDQo+ID4gICAqIFNIQVJFRF9DSElMRDogU2V0
IGZyb20gdGhlIGJhc2UgZG9tYWluIHVwIHVudGlsIHNwYW5uZWQgQ1BVcyBubyBsb25nZXINCj4g
c2hhcmUNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC90b3BvbG9neS5oDQo+
IGIvaW5jbHVkZS9saW51eC9zY2hlZC90b3BvbG9neS5oDQo+ID4gaW5kZXggOGYwZjc3OC4uODQ2
ZmNhYyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3RvcG9sb2d5LmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkL3RvcG9sb2d5LmgNCj4gPiBAQCAtNDIsNiArNDIs
MTMgQEAgc3RhdGljIGlubGluZSBpbnQgY3B1X3NtdF9mbGFncyh2b2lkKQ0KPiA+ICB9DQo+ID4g
ICNlbmRpZg0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ0xVU1RFUg0KPiA+ICtzdGF0
aWMgaW5saW5lIGludCBjcHVfY2x1c3Rlcl9mbGFncyh2b2lkKQ0KPiA+ICt7DQo+ID4gKyAgICAg
ICByZXR1cm4gU0RfU0hBUkVfQ0xTX1JFU09VUkNFUyB8IFNEX1NIQVJFX1BLR19SRVNPVVJDRVM7
DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAjaWZkZWYgQ09ORklHX1NDSEVEX01D
DQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGNwdV9jb3JlX2ZsYWdzKHZvaWQpDQo+ID4gIHsNCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90b3BvbG9neS5oIGIvaW5jbHVkZS9saW51eC90
b3BvbG9neS5oDQo+ID4gaW5kZXggODBkMjdkNy4uMGIzNzA0YSAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3RvcG9sb2d5LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3RvcG9sb2d5
LmgNCj4gPiBAQCAtMjEyLDYgKzIxMiwxMyBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBj
cHVtYXNrICpjcHVfc210X21hc2soaW50DQo+IGNwdSkNCj4gPiAgfQ0KPiA+ICAjZW5kaWYNCj4g
Pg0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfU0NIRURfQ0xVU1RFUikgJiYgIWRlZmluZWQoY3B1
X2NsdXN0ZXJfbWFzaykNCj4gPiArc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgY3B1bWFzayAq
Y3B1X2NsdXN0ZXJfbWFzayhpbnQgY3B1KQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gdG9w
b2xvZ3lfY2x1c3Rlcl9jcHVtYXNrKGNwdSk7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0K
PiA+ICBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVfY3B1X21hc2soaW50
IGNwdSkNCj4gPiAgew0KPiA+ICAgICAgICAgcmV0dXJuIGNwdW1hc2tfb2Zfbm9kZShjcHVfdG9f
bm9kZShjcHUpKTsNCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUuYyBiL2tlcm5l
bC9zY2hlZC9jb3JlLmMNCj4gPiBpbmRleCA4OGEyZTJiLi5kODA1ZTU5IDEwMDY0NA0KPiA+IC0t
LSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4gPiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+
ID4gQEAgLTc3OTcsNiArNzc5NywxNiBAQCBpbnQgc2NoZWRfY3B1X2FjdGl2YXRlKHVuc2lnbmVk
IGludCBjcHUpDQo+ID4gICAgICAgICBpZiAoY3B1bWFza193ZWlnaHQoY3B1X3NtdF9tYXNrKGNw
dSkpID09IDIpDQo+ID4gICAgICAgICAgICAgICAgIHN0YXRpY19icmFuY2hfaW5jX2NwdXNsb2Nr
ZWQoJnNjaGVkX3NtdF9wcmVzZW50KTsNCj4gPiAgI2VuZGlmDQo+ID4gKw0KPiA+ICsjaWZkZWYg
Q09ORklHX1NDSEVEX0NMVVNURVINCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBXaGVu
IGdvaW5nIHVwLCBpbmNyZW1lbnQgdGhlIG51bWJlciBvZiBjbHVzdGVyIGNwdXMgd2l0aA0KPiA+
ICsgICAgICAgICogY2x1c3RlciBwcmVzZW50Lg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAg
ICBpZiAoY3B1bWFza193ZWlnaHQoY3B1X2NsdXN0ZXJfbWFzayhjcHUpKSA+IDEpDQo+ID4gKyAg
ICAgICAgICAgICAgIHN0YXRpY19icmFuY2hfaW5jX2NwdXNsb2NrZWQoJnNjaGVkX2NsdXN0ZXJf
cHJlc2VudCk7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgICAgICAgIHNldF9jcHVfYWN0aXZl
KGNwdSwgdHJ1ZSk7DQo+ID4NCj4gPiAgICAgICAgIGlmIChzY2hlZF9zbXBfaW5pdGlhbGl6ZWQp
IHsNCj4gPiBAQCAtNzg3Myw2ICs3ODgzLDE0IEBAIGludCBzY2hlZF9jcHVfZGVhY3RpdmF0ZSh1
bnNpZ25lZCBpbnQgY3B1KQ0KPiA+ICAgICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNoX2RlY19j
cHVzbG9ja2VkKCZzY2hlZF9zbXRfcHJlc2VudCk7DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gKyNp
ZmRlZiBDT05GSUdfU0NIRURfQ0xVU1RFUg0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAq
IFdoZW4gZ29pbmcgZG93biwgZGVjcmVtZW50IHRoZSBudW1iZXIgb2YgY3B1cyB3aXRoIGNsdXN0
ZXIgcHJlc2VudC4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGNwdW1hc2tfd2Vp
Z2h0KGNwdV9jbHVzdGVyX21hc2soY3B1KSkgPiAxKQ0KPiA+ICsgICAgICAgICAgICAgICBzdGF0
aWNfYnJhbmNoX2RlY19jcHVzbG9ja2VkKCZzY2hlZF9jbHVzdGVyX3ByZXNlbnQpOw0KPiA+ICsj
ZW5kaWYNCj4gPiArDQo+ID4gICAgICAgICBpZiAoIXNjaGVkX3NtcF9pbml0aWFsaXplZCkNCj4g
PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVs
L3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiBpbmRleCA4YThiZDdiLi4z
ZGI3YjA3IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiArKysgYi9r
ZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gQEAgLTYwMDksNiArNjAwOSwxMSBAQCBzdGF0aWMgaW5s
aW5lIGludCBfX3NlbGVjdF9pZGxlX2NwdShpbnQgY3B1KQ0KPiA+ICAgICAgICAgcmV0dXJuIC0x
Ow0KPiA+ICB9DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19TQ0hFRF9DTFVTVEVSDQo+ID4gK0RF
RklORV9TVEFUSUNfS0VZX0ZBTFNFKHNjaGVkX2NsdXN0ZXJfcHJlc2VudCk7DQo+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKHNjaGVkX2NsdXN0ZXJfcHJlc2VudCk7DQo+ID4gKyNlbmRpZg0KPiA+ICsN
Cj4gPiAgI2lmZGVmIENPTkZJR19TQ0hFRF9TTVQNCj4gPiAgREVGSU5FX1NUQVRJQ19LRVlfRkFM
U0Uoc2NoZWRfc210X3ByZXNlbnQpOw0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChzY2hlZF9zbXRf
cHJlc2VudCk7DQo+ID4gQEAgLTYxMTYsNiArNjEyMSwyNiBAQCBzdGF0aWMgaW5saW5lIGludCBz
ZWxlY3RfaWRsZV9jb3JlKHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqcCwgaW50IGNvcmUsIHN0cnVj
dCBjcHVtYQ0KPiA+DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfU0NIRURfU01UICovDQo+ID4NCj4g
PiArc3RhdGljIGlubGluZSBpbnQgX3NlbGVjdF9pZGxlX2NwdShib29sIHNtdCwgc3RydWN0IHRh
c2tfc3RydWN0ICpwLCBpbnQNCj4gdGFyZ2V0LCBzdHJ1Y3QgY3B1bWFzayAqY3B1cywgaW50ICpp
ZGxlX2NwdSwgaW50ICpucikNCj4gPiArew0KPiA+ICsgICAgICAgaW50IGNwdSwgaTsNCj4gPiAr
DQo+ID4gKyAgICAgICBmb3JfZWFjaF9jcHVfd3JhcChjcHUsIGNwdXMsIHRhcmdldCkgew0KPiA+
ICsgICAgICAgICAgICAgICBpZiAoc210KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
aSA9IHNlbGVjdF9pZGxlX2NvcmUocCwgY3B1LCBjcHVzLCBpZGxlX2NwdSk7DQo+ID4gKyAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCEtLSpu
cikNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBpID0gX19zZWxlY3RfaWRsZV9jcHUoY3B1KTsNCj4gPiAr
ICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCh1bnNpZ25l
ZCBpbnQpaSA8IG5yX2NwdW1hc2tfYml0cykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gaTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gLTE7DQo+
ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFNjYW4gdGhlIExMQyBkb21haW4gZm9yIGlk
bGUgQ1BVczsgdGhpcyBpcyBkeW5hbWljYWxseSByZWd1bGF0ZWQgYnkNCj4gPiAgICogY29tcGFy
aW5nIHRoZSBhdmVyYWdlIHNjYW4gY29zdCAodHJhY2tlZCBpbiBzZC0+YXZnX3NjYW5fY29zdCkg
YWdhaW5zdA0KPiB0aGUNCj4gPiBAQCAtNjEyNCw3ICs2MTQ5LDcgQEAgc3RhdGljIGlubGluZSBp
bnQgc2VsZWN0X2lkbGVfY29yZShzdHJ1Y3QgdGFza19zdHJ1Y3QNCj4gKnAsIGludCBjb3JlLCBz
dHJ1Y3QgY3B1bWENCj4gPiAgc3RhdGljIGludCBzZWxlY3RfaWRsZV9jcHUoc3RydWN0IHRhc2tf
c3RydWN0ICpwLCBzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwNCj4gaW50IHRhcmdldCkNCj4gPiAg
ew0KPiA+ICAgICAgICAgc3RydWN0IGNwdW1hc2sgKmNwdXMgPSB0aGlzX2NwdV9jcHVtYXNrX3Zh
cl9wdHIoc2VsZWN0X2lkbGVfbWFzayk7DQo+ID4gLSAgICAgICBpbnQgaSwgY3B1LCBpZGxlX2Nw
dSA9IC0xLCBuciA9IElOVF9NQVg7DQo+ID4gKyAgICAgICBpbnQgaSwgaWRsZV9jcHUgPSAtMSwg
bnIgPSBJTlRfTUFYOw0KPiA+ICAgICAgICAgYm9vbCBzbXQgPSB0ZXN0X2lkbGVfY29yZXModGFy
Z2V0LCBmYWxzZSk7DQo+ID4gICAgICAgICBpbnQgdGhpcyA9IHNtcF9wcm9jZXNzb3JfaWQoKTsN
Cj4gPiAgICAgICAgIHN0cnVjdCBzY2hlZF9kb21haW4gKnRoaXNfc2Q7DQo+ID4gQEAgLTYxMzQs
NyArNjE1OSwxMiBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX2NwdShzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnAsDQo+IHN0cnVjdCBzY2hlZF9kb21haW4gKnNkLCBpbnQgdA0KPiA+ICAgICAgICAgaWYg
KCF0aGlzX3NkKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4NCj4gPiAtICAg
ICAgIGNwdW1hc2tfYW5kKGNwdXMsIHNjaGVkX2RvbWFpbl9zcGFuKHNkKSwgcC0+Y3B1c19wdHIp
Ow0KPiA+ICsgICAgICAgaWYgKCFzY2hlZF9jbHVzdGVyX2FjdGl2ZSgpKQ0KPiA+ICsgICAgICAg
ICAgICAgICBjcHVtYXNrX2FuZChjcHVzLCBzY2hlZF9kb21haW5fc3BhbihzZCksIHAtPmNwdXNf
cHRyKTsNCj4gPiArI2lmZGVmIENPTkZJR19TQ0hFRF9DTFVTVEVSDQo+ID4gKyAgICAgICBpZiAo
c2NoZWRfY2x1c3Rlcl9hY3RpdmUoKSkNCj4gPiArICAgICAgICAgICAgICAgY3B1bWFza19hbmQo
Y3B1cywgY3B1X2NsdXN0ZXJfbWFzayh0YXJnZXQpLCBwLT5jcHVzX3B0cik7DQo+ID4gKyNlbmRp
Zg0KPiA+DQo+ID4gICAgICAgICBpZiAoc2NoZWRfZmVhdChTSVNfUFJPUCkgJiYgIXNtdCkgew0K
PiA+ICAgICAgICAgICAgICAgICB1NjQgYXZnX2Nvc3QsIGF2Z19pZGxlLCBzcGFuX2F2ZzsNCj4g
PiBAQCAtNjE1NSwyNCArNjE4NSwzMiBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX2NwdShzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnAsDQo+IHN0cnVjdCBzY2hlZF9kb21haW4gKnNkLCBpbnQgdA0KPiA+
ICAgICAgICAgICAgICAgICB0aW1lID0gY3B1X2Nsb2NrKHRoaXMpOw0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4gLSAgICAgICBmb3JfZWFjaF9jcHVfd3JhcChjcHUsIGNwdXMsIHRhcmdldCkgew0K
PiA+IC0gICAgICAgICAgICAgICBpZiAoc210KSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgaSA9IHNlbGVjdF9pZGxlX2NvcmUocCwgY3B1LCBjcHVzLCAmaWRsZV9jcHUpOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGlmICgodW5zaWduZWQgaW50KWkgPCBucl9jcHVtYXNrX2Jp
dHMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaTsNCj4gPiAr
ICAgICAgIC8qIHNjYW4gY2x1c3RlciBiZWZvcmUgc2Nhbm5pbmcgdGhlIHdob2xlIGxsYyAqLw0K
PiA+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NMVVNURVINCj4gPiArICAgICAgIGlmIChzY2hlZF9j
bHVzdGVyX2FjdGl2ZSgpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGkgPSBfc2VsZWN0X2lkbGVf
Y3B1KHNtdCwgcCwgdGFyZ2V0LCBjcHVzLCAmaWRsZV9jcHUsICZucik7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmICgodW5zaWduZWQgaW50KSBpIDwgbnJfY3B1bWFza19iaXRzKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaWRsZV9jcHUgPSBpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZG9uZTsNCj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChuciA8PSAw
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPg0KPiA+IC0gICAg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICghLS1u
cikNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBpZGxlX2NwdSA9IF9fc2VsZWN0X2lkbGVfY3B1KGNwdSk7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCh1bnNpZ25lZCBpbnQpaWRsZV9jcHUg
PCBucl9jcHVtYXNrX2JpdHMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gPiAtICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICBjcHVtYXNr
X2FuZChjcHVzLCBzY2hlZF9kb21haW5fc3BhbihzZCksIHAtPmNwdXNfcHRyKTsNCj4gPiArICAg
ICAgICAgICAgICAgY3B1bWFza19hbmRub3QoY3B1cywgY3B1cywgY3B1X2NsdXN0ZXJfbWFzayh0
YXJnZXQpKTsNCj4gPiAgICAgICAgIH0NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICsgICAgICAg
aSA9IF9zZWxlY3RfaWRsZV9jcHUoc210LCBwLCB0YXJnZXQsIGNwdXMsICZpZGxlX2NwdSwgJm5y
KTsNCj4gPiArICAgICAgIGlmICgodW5zaWduZWQgaW50KSBpIDwgbnJfY3B1bWFza19iaXRzKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIGlkbGVfY3B1ID0gaTsNCj4gPiArICAgICAgICAgICAgICAg
Z290byBkb25lOw0KPiA+ICsgICAgICAgfSBlbHNlIGlmIChuciA8PSAwKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLTE7DQo+ID4NCj4gPiAgICAgICAgIGlmIChzbXQpDQo+ID4gICAgICAg
ICAgICAgICAgIHNldF9pZGxlX2NvcmVzKHRoaXMsIGZhbHNlKTsNCj4gPg0KPiA+ICtkb25lOg0K
PiA+ICAgICAgICAgaWYgKHNjaGVkX2ZlYXQoU0lTX1BST1ApICYmICFzbXQpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgdGltZSA9IGNwdV9jbG9jayh0aGlzKSAtIHRpbWU7DQo+ID4gICAgICAgICAg
ICAgICAgIHVwZGF0ZV9hdmcoJnRoaXNfc2QtPmF2Z19zY2FuX2Nvc3QsIHRpbWUpOw0KPiA+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc2NoZWQuaCBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oDQo+
ID4gaW5kZXggMTBhMTUyMi4uNDhhMDIwZiAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvc2NoZWQv
c2NoZWQuaA0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oDQo+ID4gQEAgLTYsNiArNiw3
IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2F1dG9ncm91cC5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvc2NoZWQvY2xvY2suaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVk
L2NsdXN0ZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2NvcmVkdW1wLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9zY2hlZC9jcHVmcmVxLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9z
Y2hlZC9jcHV0aW1lLmg+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC90b3BvbG9neS5j
IGIva2VybmVsL3NjaGVkL3RvcG9sb2d5LmMNCj4gPiBpbmRleCAwOWQzNTA0Li5kMDE5YzI1IDEw
MDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC90b3BvbG9neS5jDQo+ID4gKysrIGIva2VybmVs
L3NjaGVkL3RvcG9sb2d5LmMNCj4gPiBAQCAtMTM2MSw2ICsxMzYxLDcgQEAgc3RhdGljIHZvaWQg
Y2xhaW1fYWxsb2NhdGlvbnMoaW50IGNwdSwgc3RydWN0DQo+IHNjaGVkX2RvbWFpbiAqc2QpDQo+
ID4gICAqLw0KPiA+ICAjZGVmaW5lIFRPUE9MT0dZX1NEX0ZMQUdTICAgICAgICAgICAgICBcDQo+
ID4gICAgICAgICAoU0RfU0hBUkVfQ1BVQ0FQQUNJVFkgICB8ICAgICAgIFwNCj4gPiArICAgICAg
ICBTRF9TSEFSRV9DTFNfUkVTT1VSQ0VTIHwgICAgICAgXA0KPiA+ICAgICAgICAgIFNEX1NIQVJF
X1BLR19SRVNPVVJDRVMgfCAgICAgICBcDQo+ID4gICAgICAgICAgU0RfTlVNQSAgICAgICAgICAg
ICAgICB8ICAgICAgIFwNCj4gPiAgICAgICAgICBTRF9BU1lNX1BBQ0tJTkcpDQo+ID4gQEAgLTE0
ODAsNiArMTQ4MSwxMSBAQCBzdGF0aWMgdm9pZCBjbGFpbV9hbGxvY2F0aW9ucyhpbnQgY3B1LCBz
dHJ1Y3QNCj4gc2NoZWRfZG9tYWluICpzZCkNCj4gPiAgI2lmZGVmIENPTkZJR19TQ0hFRF9TTVQN
Cj4gPiAgICAgICAgIHsgY3B1X3NtdF9tYXNrLCBjcHVfc210X2ZsYWdzLCBTRF9JTklUX05BTUUo
U01UKSB9LA0KPiA+ICAjZW5kaWYNCj4gPiArDQo+ID4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ0xV
U1RFUg0KPiA+ICsgICAgICAgeyBjcHVfY2x1c3Rlcmdyb3VwX21hc2ssIGNwdV9jbHVzdGVyX2Zs
YWdzLCBTRF9JTklUX05BTUUoQ0xTKSB9LA0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gICNpZmRl
ZiBDT05GSUdfU0NIRURfTUMNCj4gPiAgICAgICAgIHsgY3B1X2NvcmVncm91cF9tYXNrLCBjcHVf
Y29yZV9mbGFncywgU0RfSU5JVF9OQU1FKE1DKSB9LA0KPiA+ICAjZW5kaWYNCj4gPiAtLQ0KPiA+
IDEuOC4zLjENCj4gPg0KPiA+DQpUaGFua3MNCkJhcnJ5DQoNCg==
