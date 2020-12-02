Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DC2CB890
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgLBJV0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 04:21:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2188 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLBJVZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 04:21:25 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmCzs5yxPz67LBK;
        Wed,  2 Dec 2020 17:17:45 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 2 Dec 2020 10:20:42 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 2 Dec 2020 09:20:41 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 2 Dec 2020 17:20:39 +0800
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
Thread-Index: AQHWx46tyJL5OgLpakCat9sEfhhBKKni9KEAgACKRLA=
Date:   Wed, 2 Dec 2020 09:20:39 +0000
Message-ID: <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
In-Reply-To: <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.219]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBHdWl0dG90
IFttYWlsdG86dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwg
RGVjZW1iZXIgMiwgMjAyMCA5OjI3IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
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
aGVkdWxlcjogYWRkIHNjaGVkdWxlciBsZXZlbCBmb3IgY2x1c3RlcnMNCj4gDQo+IE9uIFR1ZSwg
MSBEZWMgMjAyMCBhdCAwNDowNCwgQmFycnkgU29uZyA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gQVJNNjQgc2VydmVyIGNoaXAgS3VucGVuZyA5MjAgaGFzIDYg
Y2x1c3RlcnMgaW4gZWFjaCBOVU1BIG5vZGUsIGFuZCBlYWNoDQo+ID4gY2x1c3RlciBoYXMgNCBj
cHVzLiBBbGwgY2x1c3RlcnMgc2hhcmUgTDMgY2FjaGUgZGF0YSwgYnV0IGVhY2ggY2x1c3Rlcg0K
PiA+IGhhcyBsb2NhbCBMMyB0YWcuIE9uIHRoZSBvdGhlciBoYW5kLCBlYWNoIGNsdXN0ZXJzIHdp
bGwgc2hhcmUgc29tZQ0KPiA+IGludGVybmFsIHN5c3RlbSBidXMuIFRoaXMgbWVhbnMgY2FjaGUg
Y29oZXJlbmNlIG92ZXJoZWFkIGluc2lkZSBvbmUgY2x1c3Rlcg0KPiA+IGlzIG11Y2ggbGVzcyB0
aGFuIHRoZSBvdmVyaGVhZCBhY3Jvc3MgY2x1c3RlcnMuDQo+ID4NCj4gPiArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0t
LS0tKw0KPiA+IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICB8DQo+ID4gfCAgfCBDUFUwIHwgICAgfCBjcHUxIHwg
ICAgICAgICAgICAgfCAgICArLS0tLS0tLS0tLS0rICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8
ICArLS0tLS0tKyAgICArLS0tLS0tKyAgICAgICAgICAgICB8ICAgIHwgICAgICAgICAgIHwgICAg
ICAgICB8ICAgICAgICAgfA0KPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICstLS0tKyAgICBMMyAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgKy0tLS0tLSsg
ICAgKy0tLS0tLSsgICBjbHVzdGVyICAgfCAgICB8ICAgIHRhZyAgICB8ICAgICAgICAgfCAgICAg
ICAgIHwNCj4gPiB8ICB8IENQVTIgfCAgICB8IENQVTMgfCAgICAgICAgICAgICB8ICAgIHwgICAg
ICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwgICstLS0tLS0rICAgICstLS0tLS0r
ICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4g
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgIHwNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgfA0KPiA+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgICB8DQo+ID4gfCAgKy0tLS0tLSsgICAgKy0tLS0tLSsgICAgICAgICAgICAgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgIHwNCj4gPiB8ICB8ICAgICAgfCAgICB8ICAgICAg
fCAgICAgICAgICAgICB8ICAgICstLS0tLS0tLS0tLSsgICAgICAgICB8ICAgICAgICAgfA0KPiA+
IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAgfCAg
ICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICB8ICAgIEwzICAgICB8ICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICArLS0tLS0t
KyAgICArLS0tLS0tKyAgICAgICAgICAgICArLS0tLSsgICAgdGFnICAgIHwgICAgICAgICB8ICAg
ICAgICAgfA0KPiA+IHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwgICAgfCAg
ICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgKy0tLS0tLSsgICAgKy0tLS0t
LSsgICAgICAgICAgICAgfCAgICArLS0tLS0tLS0tLS0rICAgICAgICAgfCAgICAgICAgIHwNCj4g
PiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICAgfA0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICBMMyAgICB8DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IGRhdGEgIHwNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwgICstLS0tLS0rICAgICstLS0t
LS0rICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+
ID4gfCAgfCAgICAgIHwgICAgfCAgICAgIHwgICAgICAgICAgICAgfCAgICB8ICAgICAgICAgICB8
ICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICArLS0tLS0tKyAgICArLS0tLS0tKyAgICAgICAg
ICAgICArLS0tLSsgICAgTDMgICAgIHwgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgfCAgICB0YWcgICAgfCAgICAgICAgIHwg
ICAgICAgICB8DQo+ID4gfCAgKy0tLS0tLSsgICAgKy0tLS0tLSsgICAgICAgICAgICAgfCAgICB8
ICAgICAgICAgICB8ICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICB8ICAgICAgfCAgICB8ICAg
ICAgfCAgICAgICAgICAgICsrICAgICstLS0tLS0tLS0tLSsgICAgICAgICB8ICAgICAgICAgfA0K
PiA+IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgfC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsgICAgICAgICB8DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tfCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgIHwNCj4gPiArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18ICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgfA0KPiA+IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICB8DQo+ID4gfCAgfCAgICAgIHwgICAgfCAg
ICAgIHwgICAgICAgICAgICAgfCAgICArLS0tLS0tLS0tLS0rICAgICAgICAgfCAgICAgICAgIHwN
Cj4gPiB8ICArLS0tLS0tKyAgICArLS0tLS0tKyAgICAgICAgICAgICB8ICAgIHwgICAgICAgICAg
IHwgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICstLS0tKyAgICBMMyAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgKy0t
LS0tLSsgICAgKy0tLS0tLSsgICAgICAgICAgICAgfCAgICB8ICAgIHRhZyAgICB8ICAgICAgICAg
fCAgICAgICAgIHwNCj4gPiB8ICB8ICAgICAgfCAgICB8ICAgICAgfCAgICAgICAgICAgICB8ICAg
IHwgICAgICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwgICstLS0tLS0rICAgICst
LS0tLS0rICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8
DQo+ID4gfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgIHwNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgfA0KPiA+ICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICB8DQo+ID4gfCAgKy0tLS0tLSsgICAgKy0tLS0tLSsgICAgICAgICAgICAgKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgIHwNCj4gPiB8ICB8ICAgICAgfCAgICB8
ICAgICAgfCAgICAgICAgICAgICB8ICAgKy0tLS0tLS0tLS0tKyAgICAgICAgICB8ICAgICAgICAg
fA0KPiA+IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICB8ICAgICAgICAg
ICB8ICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIHwgICAgTDMgICAgIHwgICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICAr
LS0tLS0tKyAgICArLS0tLS0tKyAgICAgICAgICAgICArLS0tKyAgICB0YWcgICAgfCAgICAgICAg
ICB8ICAgICAgICAgfA0KPiA+IHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwg
ICB8ICAgICAgICAgICB8ICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gfCAgKy0tLS0tLSsgICAg
Ky0tLS0tLSsgICAgICAgICAgICAgfCAgICstLS0tLS0tLS0tLSsgICAgICAgICAgfCAgICAgICAg
IHwNCj4gPiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICAgfA0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgICAgICAgICAgICAgICAg
ICArKyAgICAgICAgIHwNCj4gPiB8ICArLS0tLS0tKyAgICArLS0tLS0tKyAgICAgICAgICAgICAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgICAgICAgfA0KPiA+IHwgIHwgICAgICB8ICAg
IHwgICAgICB8ICAgICAgICAgICAgIHwgICstLS0tLS0tLS0tLSsgICAgICAgICAgIHwgICAgICAg
ICB8DQo+ID4gfCAgKy0tLS0tLSsgICAgKy0tLS0tLSsgICAgICAgICAgICAgfCAgfCAgICAgICAg
ICAgfCAgICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICB8ICAgIEwzICAgICB8ICAgICAgICAgICB8ICAgICAgICAgfA0KPiA+IHwg
ICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgICstLSsgICAgdGFnICAgIHwgICAgICAg
ICAgIHwgICAgICAgICB8DQo+ID4gfCAgfCAgICAgIHwgICAgfCAgICAgIHwgICAgICAgICAgICAg
fCAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgIHwNCj4gPiB8ICArLS0tLS0tKyAg
ICArLS0tLS0tKyAgICAgICAgICAgICB8ICArLS0tLS0tLS0tLS0rICAgICAgICAgICB8ICAgICAg
ICAgfA0KPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICstLS0tLS0tLS0rDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKw0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBzY2hlZF9kb21haW4g
Zm9yIGNsdXN0ZXJzLiBPbiBrdW5wZW5nIDkyMCwgd2l0aG91dA0KPiA+IHRoaXMgcGF0Y2gsIGRv
bWFpbjAgb2YgY3B1MCB3b3VsZCBiZSBNQyBmb3IgY3B1MC1jcHUyMyB3aXRoDQo+ID4gbWluX2lu
dGVydmFsPTI0LCBtYXhfaW50ZXJ2YWw9NDg7IHdpdGggdGhpcyBwYXRjaCwgTUMgYmVjb21lcyBk
b21haW4xLA0KPiA+IGEgbmV3IGRvbWFpbjAgIkNMIiBpbmNsdWRpbmcgY3B1MC1jcHUzIGlzIGFk
ZGVkIHdpdGggbWluX2ludGVydmFsPTQgYW5kDQo+ID4gbWF4X2ludGVydmFsPTguDQo+ID4gVGhp
cyB3aWxsIGFmZmVjdCBsb2FkIGJhbGFuY2UuIEZvciBleGFtcGxlLCB3aXRob3V0IHRoaXMgcGF0
Y2gsIHdoaWxlIGNwdTANCj4gPiBiZWNvbWVzIGlkbGUsIGl0IHdpbGwgcHVsbCBhIHRhc2sgZnJv
bSBjcHUxLWNwdTE1LiBXaXRoIHRoaXMgcGF0Y2gsIGNwdTANCj4gPiB3aWxsIHRyeSB0byBwdWxs
IGEgdGFzayBmcm9tIGNwdTEtY3B1MyBmaXJzdC4gVGhpcyB3aWxsIGhhdmUgbXVjaCBsZXNzDQo+
ID4gb3ZlcmhlYWQgb2YgdGFzayBtaWdyYXRpb24uDQo+ID4NCj4gPiBPbiB0aGUgb3RoZXIgaGFu
ZCwgd2hpbGUgZG9pbmcgV0FLRV9BRkZJTkUsIHRoaXMgcGF0Y2ggd2lsbCB0cnkgdG8gZmluZA0K
PiA+IGEgY29yZSBpbiB0aGUgdGFyZ2V0IGNsdXN0ZXIgYmVmb3JlIHNjYW5uaW5nIHRoZSBsbGMg
ZG9tYWluLg0KPiA+IFRoaXMgbWVhbnMgaXQgd2lsbCBwcm9hY3RpdmVseSB1c2UgYSBjb3JlIHdo
aWNoIGhhcyBiZXR0ZXIgYWZmaW5pdHkgd2l0aA0KPiA+IHRhcmdldCBjb3JlIGF0IGZpcnN0Lg0K
PiANCj4gV2hpY2ggaXMgYXQgdGhlIG9wcG9zaXRlIG9mIHdoYXQgd2UgYXJlIHVzdWFsbHkgdHJ5
aW5nIHRvIGRvIGluIHRoZQ0KPiBmYXN0IHdha2V1cCBwYXRoOiB0cnlpbmcgdG8gbWluaW1pemUg
cmVzb3VyY2Ugc2hhcmluZyBieSBmaW5kaW5nIGFuDQo+IGlkbGUgY29yZSB3aXRoIGFsbCBzbXQg
aWRsZSBhcyBhbiBleGFtcGxlDQoNCkluIHdha2VfYWZmaW5lIGNhc2UsIEkgZ3Vlc3Mgd2UgYXJl
IGFjdHVhbGx5IHdhbnQgc29tZSBraW5kIG9mDQpyZXNvdXJjZSBzaGFyaW5nIHN1Y2ggYXMgTExD
IHRvIGdldCB3YWtlciBhbmQgd2FrZWUgZ2V0IGNsb3Nlcg0KdG8gZWFjaCBvdGhlci4gZmluZF9p
ZGxlc3RfY3B1KCkgaXMgcmVhbGx5IG9wcG9zaXRlLg0KDQpTbyB0aGUgcmVhbCBxdWVzdGlvbiBp
cyB0aGF0IExMQyBpcyBhbHdheXMgdGhlIHJpZ2h0IGNob2ljZSBvZg0KaWRsZSBzaWJsaW5nPyAN
Cg0KSW4gdGhpcyBjYXNlLCA2IGNsdXN0ZXJzIGFyZSBpbiBzYW1lIExMQywgYnV0IGhhcmR3YXJl
IGhhcyBkaWZmZXJlbnQNCmJlaGF2aW9yIGZvciBpbnNpZGUgc2luZ2xlIGNsdXN0ZXIgYW5kIGFj
cm9zcyBtdWx0aXBsZSBjbHVzdGVycy4NCg0KDQo+IA0KPiA+DQo+ID4gTm90IG11Y2ggYmVuY2ht
YXJrIGhhcyBiZWVuIGRvbmUgeWV0LiBidXQgaGVyZSBpcyBhIHJvdWdoIGhhY2tiZW5jaA0KPiA+
IHJlc3VsdC4NCj4gPiB3ZSBydW4gdGhlIGJlbG93IGNvbW1hbmQgd2l0aCBkaWZmZXJlbnQgLWcg
cGFyYW1ldGVyIHRvIGluY3JlYXNlIHN5c3RlbSBsb2FkDQo+ID4gYnkgY2hhbmdpbmcgZyBmcm9t
IDEgdG8gNCwgZm9yIGVhY2ggb25lIG9mIDEtNCwgd2UgcnVuIHRoZSBiZW5jaG1hcmsgdGVuIHRp
bWVzDQo+ID4gYW5kIHJlY29yZCB0aGUgZGF0YSB0byBnZXQgdGhlIGF2ZXJhZ2UgdGltZToNCj4g
Pg0KPiA+IEZpcnN0LCB3ZSBydW4gaGFja2JlbmNoIGluIG9ubHkgb25lIE5VTUEgbm9kZShjcHUw
LWNwdTIzKToNCj4gPiAkIG51bWFjdGwgLU4gMCBoYWNrYmVuY2ggLXAgLVQgLWwgMTAwMDAwIC1n
ICQxDQo+IA0KPiBXaGF0IGlzIHlvdXIgcmVmIHRyZWUgPyB2NS4xMC1yY1ggb3IgdGlwL3NjaGVk
L2NvcmUgPw0KDQpBY3R1YWxseSBJIHdhcyB1c2luZyA1LjkgcmVsZWFzZS4gIFRoYXQgbXVzdCBi
ZSB3ZWlyZC4gDQpCdXQgdGhlIHJlYXNvbiBpcyB0aGF0IGRpc2sgZHJpdmVyIGlzIGdldHRpbmcg
aGFuZw0KaW4gbXkgaGFyZHdhcmUgaW4gNS4xMC1yY3guDQoNCj4gDQo+ID4NCj4gPiBnPTEgKHNl
ZW4gY3B1IHV0aWxpemF0aW9uIGFyb3VuZCA1MCUgZm9yIGVhY2ggY29yZSkNCj4gPiBSdW5uaW5n
IGluIHRocmVhZGVkIG1vZGUgd2l0aCAxIGdyb3VwcyB1c2luZyA0MCBmaWxlIGRlc2NyaXB0b3Jz
DQo+ID4gRWFjaCBzZW5kZXIgd2lsbCBwYXNzIDEwMDAwMCBtZXNzYWdlcyBvZiAxMDAgYnl0ZXMN
Cj4gPiB3L286IDcuNjg5IDcuNDg1IDcuNDg1IDcuNDU4IDcuNTI0IDcuNTM5IDcuNzM4IDcuNjkz
IDcuNTY4IDcuNjc0PTcuNTg1Mw0KPiA+IHcvIDogNy41MTYgNy45NDEgNy4zNzQgNy45NjMgNy44
ODEgNy45MTAgNy40MjAgNy41NTYgNy42OTUgNy40NDE9Ny42Njk3DQo+ID4gcGVyZm9ybWFuY2Ug
aW1wcm92ZW1lbnQgdy8gcGF0Y2g6IC0xLjAxJQ0KPiA+DQo+ID4gZz0yIChzZWVuIGNwdSB1dGls
aXphdGlvbiBhcm91bmQgNzAlIGZvciBlYWNoIGNvcmUpDQo+ID4gUnVubmluZyBpbiB0aHJlYWRl
ZCBtb2RlIHdpdGggMiBncm91cHMgdXNpbmcgNDAgZmlsZSBkZXNjcmlwdG9ycw0KPiA+IEVhY2gg
c2VuZGVyIHdpbGwgcGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5dGVzDQo+ID4gdy9vOiAx
MC4xMjcgMTAuMTE5IDEwLjA3MCAxMC4xOTYgMTAuMDU3IDEwLjExMSAxMC4wNDUgMTAuMTY0IDEw
LjE2Mg0KPiA5Ljk1NT0xMC4xMDA2DQo+ID4gdy8gOiA5LjY5NCA5LjY1NCA5LjYxMiA5LjY0OSA5
LjY4NiA5LjczNCA5LjYwNyA5Ljg0MiA5LjY5MCA5LjcxMD05LjY4NzgNCj4gPiBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudCB3LyBwYXRjaDogNC4wOCUNCj4gPg0KPiA+IGc9MyAoc2VlbiBjcHUgdXRp
bGl6YXRpb24gYXJvdW5kIDkwJSBmb3IgZWFjaCBjb3JlKQ0KPiA+IFJ1bm5pbmcgaW4gdGhyZWFk
ZWQgbW9kZSB3aXRoIDMgZ3JvdXBzIHVzaW5nIDQwIGZpbGUgZGVzY3JpcHRvcnMNCj4gPiBFYWNo
IHNlbmRlciB3aWxsIHBhc3MgMTAwMDAwIG1lc3NhZ2VzIG9mIDEwMCBieXRlcw0KPiA+IHcvbzog
MTUuODg1IDE1LjI1NCAxNS45MzIgMTUuNjQ3IDE2LjEyMCAxNS44NzggMTUuODU3IDE1Ljc1OSAx
NS42NzQNCj4gMTUuNzIxPTE1Ljc3MjcNCj4gPiB3LyA6IDE0Ljk3NCAxNC42NTcgMTMuOTY5IDE0
Ljk4NSAxNC43MjggMTUuNjY1IDE1LjE5MSAxNC45OTUgMTQuOTQ2DQo+IDE0Ljg5NT0xNC45MDA1
DQo+ID4gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgdy8gcGF0Y2g6IDUuNTMlDQo+ID4NCj4gPiBn
PTQNCj4gPiBSdW5uaW5nIGluIHRocmVhZGVkIG1vZGUgd2l0aCA0IGdyb3VwcyB1c2luZyA0MCBm
aWxlIGRlc2NyaXB0b3JzDQo+ID4gRWFjaCBzZW5kZXIgd2lsbCBwYXNzIDEwMDAwMCBtZXNzYWdl
cyBvZiAxMDAgYnl0ZXMNCj4gPiB3L286IDIwLjAxNCAyMS4wMjUgMjEuMTE5IDIxLjIzNSAxOS43
NjcgMjAuOTcxIDIwLjk2MiAyMC45MTQgMjEuMDkwDQo+IDIxLjA5MD0yMC44MTg3DQo+ID4gdy8g
OiAyMC4zMzEgMjAuNjA4IDIwLjMzOCAyMC40NDUgMjAuNDU2IDIwLjE0NiAyMC42OTMgMjAuNzk3
IDIxLjM4MQ0KPiAyMC40NTI9MjAuNTY0Nw0KPiA+IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IHcv
IHBhdGNoOiAxLjIyJQ0KPiA+DQo+ID4gQWZ0ZXIgdGhhdCwgd2UgcnVuIHRoZSBzYW1lIGhhY2ti
ZW5jaCBpbiBib3RoIE5VTUEgbm9kZXMoY3B1MC1jcHU0Nyk6DQo+ID4gZz0xDQo+ID4gdy9vOiA3
LjM1MSA3LjQxNiA3LjQ4NiA3LjM1OCA3LjUxNiA3LjQwMyA3LjQxMyA3LjQxMSA3LjQyMSA3LjQ1
ND03LjQyMjkNCj4gPiB3LyA6IDcuNjA5IDcuNTk2IDcuNjQ3IDcuNTcxIDcuNjg3IDcuNTcxIDcu
NTIwIDcuNTEzIDcuNTMwIDcuNjgxPTcuNTkyNQ0KPiA+IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50
IGJ5IHBhdGNoOiAtMi4yJQ0KPiA+DQo+ID4gZz0yDQo+ID4gdy9vOiA5LjA0NiA5LjE5MCA5LjA1
MyA4Ljk1MCA5LjEwMSA4LjkzMCA5LjE0MyA4LjkyOCA4LjkwNSA5LjAzND05LjAyOA0KPiA+IHcv
IDogOC4yNDcgOC4wNTcgOC4yNTggOC4zMTAgOC4wODMgOC4yMDEgOC4wNDQgOC4xNTggOC4zODIg
OC4xNzM9OC4xOTEzDQo+ID4gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgYnkgcGF0Y2g6IDkuMyUN
Cj4gPg0KPiA+IGc9Mw0KPiA+IHcvbzogMTEuNjY0IDExLjc2NyAxMS4yNzcgMTEuNjE5IDEyLjU1
NyAxMi43NjAgMTEuNjY0IDEyLjE2NSAxMi4yMzUNCj4gMTEuODQ5PTExLjk1NTcNCj4gPiB3LyA6
IDkuMzg3IDkuNDYxIDkuNjUwIDkuNjEzIDkuNTkxIDkuNDU0IDkuNDk2IDkuNzE2IDkuMzI3IDku
NzIyPTkuNTQxNw0KPiA+IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGJ5IHBhdGNoOiAyMC4yJQ0K
PiA+DQo+ID4gZz00DQo+ID4gdy9vOiAxNy4zNDcgMTcuMjk5IDE3LjY1NSAxOC43NzUgMTYuNzA3
IDE4Ljg3OSAxNy4yNTUgMTguMzU2IDE2Ljg1OQ0KPiAxOC41MTU9MTcuNzY0Nw0KPiA+IHcvIDog
MTAuNDE2IDEwLjQ5NiAxMC42MDEgMTAuMzE4IDEwLjQ1OSAxMC42MTcgMTAuNTEwIDEwLjY0MiAx
MC40NjcNCj4gMTAuNDAxPTEwLjQ5MjcNCj4gPiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBieSBw
YXRjaDogNDAuOSUNCj4gPg0KPiA+IGc9NQ0KPiA+IHcvbzogMjcuODA1IDI2LjYzMyAyNC4xMzgg
MjguMDg2IDI0LjQwNSAyNy45MjIgMzAuMDQzIDI4LjQ1OCAzMS4wNzMNCj4gMjUuODE5PTI3LjQz
ODINCj4gPiB3LyA6IDEzLjgxNyAxMy45NzYgMTQuMTY2IDEzLjY4OCAxNC4xMzIgMTQuMDk1IDE0
LjAwMyAxMy45OTcgMTMuOTU0DQo+IDEzLjkwNz0xMy45NzM1DQo+ID4gcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnQgYnkgcGF0Y2g6IDQ5LjElDQo+ID4NCj4gPiBJdCBzZWVtcyB0aGUgcGF0Y2ggY2Fu
IGJyaW5nIGEgaHVnZSBpbmNyZWFzZSBvbiBoYWNrYmVuY2ggZXNwZWNpYWxseSB3aGVuDQo+ID4g
d2UgYmluZCBoYWNrYmVuY2ggdG8gYWxsIG9mIGNwdTAtY3B1NDcsIGNvbXBhcmluZyB0byA1LjUz
JSB3aGlsZSBydW5uaW5nDQo+ID4gb24gc2luZ2xlIE5VTUEgbm9kZShjcHUwLWNwdTIzKQ0KPiAN
Cj4gSW50ZXJlc3RpbmcgdGhhdCB0aGlzIHBhdGNoIG1haW5seSBpbXBhY3RzIHRoZSBudW1hIGNh
c2UNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9LY29uZmlnICAgICAgIHwg
IDcgKysrKysrKw0KPiA+ICBhcmNoL2FybTY0L2tlcm5lbC9zbXAuYyAgfCAxNyArKysrKysrKysr
KysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3RvcG9sb2d5LmggfCAgNyArKysrKysrDQo+ID4g
IGtlcm5lbC9zY2hlZC9mYWlyLmMgICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZw0K
PiA+IGluZGV4IDZkMjMyODMuLjM1ODNjMjYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9L
Y29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm02NC9LY29uZmlnDQo+ID4gQEAgLTkzOCw2ICs5Mzgs
MTMgQEAgY29uZmlnIFNDSEVEX01DDQo+ID4gICAgICAgICAgIG1ha2luZyB3aGVuIGRlYWxpbmcg
d2l0aCBtdWx0aS1jb3JlIENQVSBjaGlwcyBhdCBhIGNvc3Qgb2Ygc2xpZ2h0bHkNCj4gPiAgICAg
ICAgICAgaW5jcmVhc2VkIG92ZXJoZWFkIGluIHNvbWUgcGxhY2VzLiBJZiB1bnN1cmUgc2F5IE4g
aGVyZS4NCj4gPg0KPiA+ICtjb25maWcgU0NIRURfQ0xVU1RFUg0KPiA+ICsgICAgICAgYm9vbCAi
Q2x1c3RlciBzY2hlZHVsZXIgc3VwcG9ydCINCj4gPiArICAgICAgIGhlbHANCj4gPiArICAgICAg
ICAgQ2x1c3RlciBzY2hlZHVsZXIgc3VwcG9ydCBpbXByb3ZlcyB0aGUgQ1BVIHNjaGVkdWxlcidz
IGRlY2lzaW9uDQo+ID4gKyAgICAgICAgIG1ha2luZyB3aGVuIGRlYWxpbmcgd2l0aCBtYWNoaW5l
cyB0aGF0IGhhdmUgY2x1c3RlcnMoc2hhcmluZyBpbnRlcm5hbA0KPiA+ICsgICAgICAgICBidXMg
b3Igc2hhcmluZyBMTEMgY2FjaGUgdGFnKS4gSWYgdW5zdXJlIHNheSBOIGhlcmUuDQo+ID4gKw0K
PiA+ICBjb25maWcgU0NIRURfU01UDQo+ID4gICAgICAgICBib29sICJTTVQgc2NoZWR1bGVyIHN1
cHBvcnQiDQo+ID4gICAgICAgICBoZWxwDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2Vy
bmVsL3NtcC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMNCj4gPiBpbmRleCAzNTVlZTllLi41
YzhmMDI2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3NtcC5jDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMNCj4gPiBAQCAtMzIsNiArMzIsNyBAQA0KPiA+ICAj
aW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tleGVjLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9rdm1faG9zdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
c2NoZWQvdG9wb2xvZ3kuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSA8YXNtL2FsdGVybmF0aXZlLmg+
DQo+ID4gICNpbmNsdWRlIDxhc20vYXRvbWljLmg+DQo+ID4gQEAgLTcyNiw2ICs3MjcsMjAgQEAg
dm9pZCBfX2luaXQgc21wX2luaXRfY3B1cyh2b2lkKQ0KPiA+ICAgICAgICAgfQ0KPiA+ICB9DQo+
ID4NCj4gPiArc3RhdGljIHN0cnVjdCBzY2hlZF9kb21haW5fdG9wb2xvZ3lfbGV2ZWwgYXJtNjRf
dG9wb2xvZ3lbXSA9IHsNCj4gPiArI2lmZGVmIENPTkZJR19TQ0hFRF9TTVQNCj4gPiArICAgICAg
ICB7IGNwdV9zbXRfbWFzaywgY3B1X3NtdF9mbGFncywgU0RfSU5JVF9OQU1FKFNNVCkgfSwNCj4g
PiArI2VuZGlmDQo+ID4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ0xVU1RFUg0KPiA+ICsgICAgICAg
eyBjcHVfY2x1c3Rlcmdyb3VwX21hc2ssIGNwdV9jb3JlX2ZsYWdzLCBTRF9JTklUX05BTUUoQ0wp
IH0sDQo+ID4gKyNlbmRpZg0KPiA+ICsjaWZkZWYgQ09ORklHX1NDSEVEX01DDQo+ID4gKyAgICAg
ICAgeyBjcHVfY29yZWdyb3VwX21hc2ssIGNwdV9jb3JlX2ZsYWdzLCBTRF9JTklUX05BTUUoTUMp
IH0sDQo+ID4gKyNlbmRpZg0KPiA+ICsgICAgICAgeyBjcHVfY3B1X21hc2ssIFNEX0lOSVRfTkFN
RShESUUpIH0sDQo+ID4gKyAgICAgICAgeyBOVUxMLCB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAg
dm9pZCBfX2luaXQgc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBpbnQgbWF4X2NwdXMpDQo+ID4g
IHsNCj4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCBjcHVfb3BlcmF0aW9ucyAqb3BzOw0KPiA+IEBA
IC03MzUsNiArNzUwLDggQEAgdm9pZCBfX2luaXQgc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBp
bnQgbWF4X2NwdXMpDQo+ID4NCj4gPiAgICAgICAgIGluaXRfY3B1X3RvcG9sb2d5KCk7DQo+ID4N
Cj4gPiArICAgICAgIHNldF9zY2hlZF90b3BvbG9neShhcm02NF90b3BvbG9neSk7DQo+ID4gKw0K
PiA+ICAgICAgICAgdGhpc19jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ID4gICAgICAgICBz
dG9yZV9jcHVfdG9wb2xvZ3kodGhpc19jcHUpOw0KPiA+ICAgICAgICAgbnVtYV9zdG9yZV9jcHVf
aW5mbyh0aGlzX2NwdSk7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdG9wb2xvZ3ku
aCBiL2luY2x1ZGUvbGludXgvdG9wb2xvZ3kuaA0KPiA+IGluZGV4IDVmNjY2NDguLjJjODIzYzAg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC90b3BvbG9neS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC90b3BvbG9neS5oDQo+ID4gQEAgLTIxMSw2ICsyMTEsMTMgQEAgc3RhdGljIGlu
bGluZSBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1X3NtdF9tYXNrKGludA0KPiBjcHUpDQo+ID4g
IH0NCj4gPiAgI2VuZGlmDQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19TQ0hFRF9DTFVTVEVSDQo+
ID4gK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGNwdW1hc2sgKmNwdV9jbHVzdGVyX21hc2so
aW50IGNwdSkNCj4gPiArew0KPiA+ICsgICAgICAgcmV0dXJuIHRvcG9sb2d5X2NsdXN0ZXJfY3B1
bWFzayhjcHUpOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGlu
ZSBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1X2NwdV9tYXNrKGludCBjcHUpDQo+ID4gIHsNCj4g
PiAgICAgICAgIHJldHVybiBjcHVtYXNrX29mX25vZGUoY3B1X3RvX25vZGUoY3B1KSk7DQo+ID4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+
ID4gaW5kZXggMWE2OGEwNS4uYWU4ZWM5MTAgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL3NjaGVk
L2ZhaXIuYw0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiBAQCAtNjEwNiw2ICs2
MTA2LDM3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNlbGVjdF9pZGxlX3NtdChzdHJ1Y3QgdGFza19z
dHJ1Y3QNCj4gKnAsIGludCB0YXJnZXQpDQo+ID4NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19TQ0hF
RF9TTVQgKi8NCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NMVVNURVINCj4gPiArLyoN
Cj4gPiArICogU2NhbiB0aGUgbG9jYWwgQ0xVU1RFUiBtYXNrIGZvciBpZGxlIENQVXMuDQo+ID4g
KyAqLw0KPiA+ICtzdGF0aWMgaW50IHNlbGVjdF9pZGxlX2NsdXN0ZXIoc3RydWN0IHRhc2tfc3Ry
dWN0ICpwLCBpbnQgdGFyZ2V0KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgY3B1Ow0KPiA+ICsN
Cj4gPiArICAgICAgIC8qIHJpZ2h0IG5vdywgbm8gaGFyZHdhcmUgd2l0aCBib3RoIGNsdXN0ZXIg
YW5kIHNtdCB0byBydW4gKi8NCj4gPiArICAgICAgIGlmIChzY2hlZF9zbXRfYWN0aXZlKCkpDQo+
IA0KPiBkb24ndCB1c2Ugc210IHN0YXRpYyBrZXkgYnV0IGEgZGVkaWNhdGVkIG9uZSBpZiBuZWVk
ZWQNCg0KU3VyZS4gDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiAr
DQo+ID4gKyAgICAgICBmb3JfZWFjaF9jcHVfd3JhcChjcHUsIGNwdV9jbHVzdGVyX21hc2sodGFy
Z2V0KSwgdGFyZ2V0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghY3B1bWFza190ZXN0X2Nw
dShjcHUsIHAtPmNwdXNfcHRyKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShjcHUpKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBjcHU7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIC0xOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsjZWxzZSAvKiBD
T05GSUdfU0NIRURfQ0xVU1RFUiAqLw0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBpbnQgc2Vs
ZWN0X2lkbGVfY2x1c3RlcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCB0YXJnZXQpDQo+ID4g
K3sNCj4gPiArICAgICAgIHJldHVybiAtMTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArI2VuZGlmIC8q
IENPTkZJR19TQ0hFRF9DTFVTVEVSICovDQo+ID4gKw0KPiA+ICAvKg0KPiA+ICAgKiBTY2FuIHRo
ZSBMTEMgZG9tYWluIGZvciBpZGxlIENQVXM7IHRoaXMgaXMgZHluYW1pY2FsbHkgcmVndWxhdGVk
IGJ5DQo+ID4gICAqIGNvbXBhcmluZyB0aGUgYXZlcmFnZSBzY2FuIGNvc3QgKHRyYWNrZWQgaW4g
c2QtPmF2Z19zY2FuX2Nvc3QpIGFnYWluc3QNCj4gdGhlDQo+ID4gQEAgLTYyNzAsNiArNjMwMSwx
MCBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX3NpYmxpbmcoc3RydWN0IHRhc2tfc3RydWN0ICpw
LA0KPiBpbnQgcHJldiwgaW50IHRhcmdldCkNCj4gPiAgICAgICAgIGlmICgodW5zaWduZWQpaSA8
IG5yX2NwdW1hc2tfYml0cykNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGk7DQo+ID4NCj4g
PiArICAgICAgIGkgPSBzZWxlY3RfaWRsZV9jbHVzdGVyKHAsIHRhcmdldCk7DQo+ID4gKyAgICAg
ICBpZiAoKHVuc2lnbmVkKWkgPCBucl9jcHVtYXNrX2JpdHMpDQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiBpOw0KPiANCj4gVGhpcyBpcyB5ZXQgYW5vdGhlciBsb29wIGluIHRoZSBmYXN0IHdh
a2UgdXAgcGF0aC4NCj4gDQo+IEknbSBjdXJpb3VzIHRvIGtub3cgd2hpY2ggcGFydCBvZiB0aGlz
IHBhdGNoIHJlYWxseSBnaXZlcyB0aGUgcGVyZiBpbXByb3ZlbWVudCA/DQo+IC1JcyBpdCB0aGUg
bmV3IHNjaGVkIGRvbWFpbiBsZXZlbCB3aXRoIGEgc2hvcnRlciBpbnRlcnZhbCB0aGF0IGlzIHRo
ZW4NCj4gdXNlZCBieSBMb2FkIGJhbGFuY2UgdG8gYmV0dGVyIHNwcmVhZCB0YXNrIGluIHRoZSBj
bHVzdGVyIGFuZCBiZXR3ZWVuDQo+IGNsdXN0ZXJzID8NCj4gLU9yIHRoaXMgbmV3IGxvb3AgaW4g
dGhlIHdha2UgdXAgcGF0aCB3aGljaCB0cmllcyB0byBrZWVwIHRocmVhZHMgaW4NCj4gdGhlIHNh
bWUgY2x1c3RlciA/IHdoaWNoIGlzIGF0IHRoZSBvcHBvc2l0ZSBvZiB0aGUgcmVzdCBvZiB0aGUN
Cj4gc2NoZWR1bGVyIHdoaWNoIHRyaWVzIHRvIHNwcmVhZA0KDQpJZiBJIGRvbid0IHNjYW4gY2x1
c3RlciBmaXJzdCBmb3Igd2FrZV9hZmZpbmUsIEkgYWxtb3N0IGRvbid0IHNlZSBsYXJnZQ0KaGFj
a2JlbmNoIGNoYW5nZSBieSB0aGUgbmV3IHNjaGVfZG9tYWluLg0KRm9yIGV4YW1wbGU6DQpnPTQg
aW4gaGFja2JlbmNoIG9uIGNwdTAtY3B1NDcodHdvIG51bWEpDQp3L28gcGF0Y2g6IDE3Ljc2NDcg
KGF2ZXJhZ2UgdGltZSBpbiAxMCB0aW1lcyBvZiBoYWNrYmVuY2gpDQp3LyB0aGUgZnVsbCBwYXRj
aDogMTAuNDkyNyANCncvIHBhdGNoIGJ1dCBkcm9wIHNlbGVjdF9pZGxlX2NsdXN0ZXIoKTogMTUu
MDkzMQ0KDQpTbyBJIGRvbid0IHRoaW5rIHRoZSBoYWNrYmVuY2ggaW5jcmVhc2UgbWFpbmx5IGNv
bWVzIGZyb20gdGhlIHNob3J0ZXINCmludGVydmFsIG9mIGxvYWQgYmFsYW5jZSBvZiB0aGUgbmV3
IGNsdXN0ZXIgZG9tYWluLg0KDQpXaGF0IGRvZXMgcmVhbGx5IG1hdHRlciBpcyBzZWxlY3RfaWRs
ZV9jbHVzdGVyKCkgYWNjb3JkaW5nIHRvIG15IHRlc3RzLg0KDQo+IA0KPiBBbHNvIGNvdWxkIHRo
ZSBzY2hlZF9mZWF0KFNJU19QUk9QKSBpbXBhY3RzIHNpZ25pZmljYW50bHkgeW91cg0KPiB0b3Bv
bG9neSBiZWNhdXNlIGl0ICBicmVha3MgYmVmb3JlIGxvb2tpbmcgZm9yIGFsbCBjb3JlcyBpbiB0
aGUgTExDID8NCj4gQW5kIHRoaXMgbmV3IGxvb3AgZXh0ZW5kcyB0aGUgbnVtYmVyIG9mIHRlc3Rl
ZCBjb3JlID8NCg0KSW4gdGhpcyBjYXNlLCBjbHVzdGVyIG11c3QgYmVsb25nIHRvIExMQy4gQ2x1
c3RlciBpcyB0aGUgY2hpbGQgb2YgTExDLg0KDQpNYXliZSB0aGUgY29kZSBWYWxlbnRpbiBzdWdn
ZXN0ZWQgaW4gaGlzIHJlcGx5IGlzIGEgZ29vZCB3YXkgdG8NCmtlZXAgdGhlIGNvZGUgYWxpZ24g
d2l0aCB0aGUgZXhpc3Rpbmcgc2VsZWN0X2lkbGVfY3B1KCk6DQoNCnN0YXRpYyBpbnQgc2VsZWN0
X2lkbGVfY3B1KHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgc3RydWN0IHNjaGVkX2RvbWFpbiAqc2Qs
IGludCB0YXJnZXQpDQogew0KIAlzdHJ1Y3QgY3B1bWFzayAqY3B1cyA9IHRoaXNfY3B1X2NwdW1h
c2tfdmFyX3B0cihzZWxlY3RfaWRsZV9tYXNrKTsNCi0Jc3RydWN0IHNjaGVkX2RvbWFpbiAqdGhp
c19zZDsNCisJc3RydWN0IHNjaGVkX2RvbWFpbiAqdGhpc19zZCwgKmNoaWxkID0gTlVMTDsNCiAJ
dTY0IGF2Z19jb3N0LCBhdmdfaWRsZTsNCiAJdTY0IHRpbWU7DQogCWludCB0aGlzID0gc21wX3By
b2Nlc3Nvcl9pZCgpOw0KQEAgLTYxNTAsMTQgKzYxNTAsMjIgQEAgc3RhdGljIGludCBzZWxlY3Rf
aWRsZV9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpwLCBzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwg
aW50IHQNCiANCiAJdGltZSA9IGNwdV9jbG9jayh0aGlzKTsNCiANCi0JY3B1bWFza19hbmQoY3B1
cywgc2NoZWRfZG9tYWluX3NwYW4oc2QpLCBwLT5jcHVzX3B0cik7DQorCWRvIHsNCisJCS8qIFhY
WDogc2Qgc2hvdWxkIHN0YXJ0IGFzIFNNVCdzIHBhcmVudCAqLw0KKwkJY3B1bWFza19hbmQoY3B1
cywgc2NoZWRfZG9tYWluX3NwYW4oc2QpLCBwLT5jcHVzX3B0cik7DQorCQlpZiAoY2hpbGQpDQor
CQkJY3B1bWFza19hbmRub3QoY3B1cywgY3B1cywgc2NoZWRfZG9tYWluX3NwYW4oY2hpbGQpKTsN
CisNCisJCWZvcl9lYWNoX2NwdV93cmFwKGNwdSwgY3B1cywgdGFyZ2V0KSB7DQorCQkJaWYgKCEt
LW5yKQ0KKwkJCQlyZXR1cm4gLTE7DQorCQkJaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShjcHUpIHx8
IHNjaGVkX2lkbGVfY3B1KGNwdSkpDQorCQkJCWJyZWFrOw0KKwkJfQ0KIA0KLQlmb3JfZWFjaF9j
cHVfd3JhcChjcHUsIGNwdXMsIHRhcmdldCkgew0KLQkJaWYgKCEtLW5yKQ0KLQkJCXJldHVybiAt
MTsNCi0JCWlmIChhdmFpbGFibGVfaWRsZV9jcHUoY3B1KSB8fCBzY2hlZF9pZGxlX2NwdShjcHUp
KQ0KLQkJCWJyZWFrOw0KLQl9DQorCQljaGlsZCA9IHNkOw0KKwkJc2QgPSBzZC0+cGFyZW50Ow0K
Kwl9IHdoaWxlIChzZCAmJiBzZC0+ZmxhZ3MgJiBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKTsNCg0K
PiANCj4gPiArDQo+ID4gICAgICAgICBpID0gc2VsZWN0X2lkbGVfY3B1KHAsIHNkLCB0YXJnZXQp
Ow0KPiA+ICAgICAgICAgaWYgKCh1bnNpZ25lZClpIDwgbnJfY3B1bWFza19iaXRzKQ0KPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gaTsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg0KVGhhbmtz
DQpCYXJyeQ0KDQo=
