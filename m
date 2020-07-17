Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6322432F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jul 2020 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGQSfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jul 2020 14:35:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:14122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSfj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jul 2020 14:35:39 -0400
IronPort-SDR: //4GnEZZPNtM9v6kKKMoFYkMKN2Hre1nNkqxBA1sfhktWyPzLusO6+o3fcv0SFoywkgQ30W+qm
 pR5KLZj8FS/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="147633886"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="147633886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:35:38 -0700
IronPort-SDR: NM0cihuSUbRCIDOLyO/wBY2MF3ksevxSGDa5V+IUtDhZZaOYtFM2Tniyt0T2c8qqZVGvMEg7QH
 jYrVMRbFM3mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="270882934"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2020 11:35:38 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Fri, 17 Jul 2020 11:35:37 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "grandmaster@al2klimov.de" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Thread-Topic: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Thread-Index: AQHWXGeTmvbPt1aLLEiZkNSAVB7nYakMjqkA
Date:   Fri, 17 Jul 2020 18:35:37 +0000
Message-ID: <7a2bdfafc7c8e22e87aa142b18390e1e8c921e4a.camel@intel.com>
References: <20200717182436.75214-1-grandmaster@al2klimov.de>
In-Reply-To: <20200717182436.75214-1-grandmaster@al2klimov.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F90A9ADFCEFEFF4498B736AC8AD77289@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTE3IGF0IDIwOjI0ICswMjAwLCBBbGV4YW5kZXIgQS4gS2xpbW92IHdy
b3RlOg0KPiBSYXRpb25hbGU6DQo+IFJlZHVjZXMgYXR0YWNrIHN1cmZhY2Ugb24ga2VybmVsIGRl
dnMgb3BlbmluZyB0aGUgbGlua3MgZm9yIE1JVE0NCj4gYXMgSFRUUFMgdHJhZmZpYyBpcyBtdWNo
IGhhcmRlciB0byBtYW5pcHVsYXRlLg0KPiANCj4gRGV0ZXJtaW5pc3RpYyBhbGdvcml0aG06DQo+
IEZvciBlYWNoIGZpbGU6DQo+ICAgSWYgbm90IC5zdmc6DQo+ICAgICBGb3IgZWFjaCBsaW5lOg0K
PiAgICAgICBJZiBkb2Vzbid0IGNvbnRhaW4gYFxieG1sbnNcYmA6DQo+ICAgICAgICAgRm9yIGVh
Y2ggbGluaywgYFxiaHR0cDovL1teIyBcdFxyXG5dKig/Olx3fC8pYDoNCj4gCSAgSWYgbmVpdGhl
ciBgXGJnbnVcLm9yZy9saWNlbnNlYCwgbm9yIGBcYm1vemlsbGFcLm9yZy9NUExcYmA6DQo+ICAg
ICAgICAgICAgIElmIGJvdGggdGhlIEhUVFAgYW5kIEhUVFBTIHZlcnNpb25zDQo+ICAgICAgICAg
ICAgIHJldHVybiAyMDAgT0sgYW5kIHNlcnZlIHRoZSBzYW1lIGNvbnRlbnQ6DQo+ICAgICAgICAg
ICAgICAgUmVwbGFjZSBIVFRQIHdpdGggSFRUUFMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kZXIgQS4gS2xpbW92IDxncmFuZG1hc3RlckBhbDJrbGltb3YuZGU+DQo+IC0tLQ0KPiAgQ29u
dGludWluZyBteSB3b3JrIHN0YXJ0ZWQgYXQgOTM0MzFlMDYwN2U1Lg0KPiAgU2VlIGFsc286IGdp
dCBsb2cgLS1vbmVsaW5lICctLWF1dGhvcj1BbGV4YW5kZXIgQS4gS2xpbW92IDxncmFuZG1hc3Rl
ckBhbDJrbGltb3YuZGU+JyB2NS43Li5tYXN0ZXINCj4gDQo+ICBJZiB0aGVyZSBhcmUgYW55IFVS
THMgdG8gYmUgcmVtb3ZlZCBjb21wbGV0ZWx5IG9yIGF0IGxlYXN0IG5vdCBqdXN0IEhUVFBTaWZp
ZWQ6DQo+ICBKdXN0IGNsZWFybHkgc2F5IHNvIGFuZCBJJ2xsICp1bmRvIG15IGNoYW5nZSouDQo+
ICBTZWUgYWxzbzogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi8yNy82NA0KPiANCj4gIElm
IHRoZXJlIGFyZSBhbnkgdmFsaWQsIGJ1dCB5ZXQgbm90IGNoYW5nZWQgVVJMczoNCj4gIFNlZTog
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi8yNi84MzcNCj4gDQo+ICBJZiB5b3UgYXBwbHkg
dGhlIHBhdGNoLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiAgU29ycnkgYWdhaW4gdG8gYWxs
IG1haW50YWluZXJzIHdobyBjb21wbGFpbmVkIGFib3V0IHN1YmplY3QgbGluZXMuDQo+ICBOb3cg
SSByZWFsaXplZCB0aGF0IHlvdSB3YW50IGFuIGFjdHVhbGx5IHBlcmZlY3QgcHJlZml4ZXMsDQo+
ICBub3QganVzdCBzdWJzeXN0ZW0gb25lcy4NCj4gIEkgdHJpZWQgbXkgYmVzdC4uLg0KPiAgQW5k
IHllcywgKkkgY291bGQqIChhdCBsZWFzdCBoYWxmLSlhdXRvbWF0ZSBpdC4NCj4gIEltcG9zc2li
bGUgaXMgbm90aGluZyEgOikNCj4gDQo+IA0KPiAgLi4uL2Zpcm13YXJlLWd1aWRlL2FjcGkvRFNE
LXByb3BlcnRpZXMtcnVsZXMucnN0ICAgICAgIHwgIDQgKystLQ0KPiAgLi4uL2Zpcm13YXJlLWd1
aWRlL2FjcGkvZHNkL2RhdGEtbm9kZS1yZWZlcmVuY2VzLnJzdCAgIHwgIDQgKystLQ0KPiAgRG9j
dW1lbnRhdGlvbi9maXJtd2FyZS1ndWlkZS9hY3BpL2RzZC9ncmFwaC5yc3QgICAgICAgIHwgMTAg
KysrKystLS0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9maXJtd2FyZS1ndWlkZS9hY3BpL2RzZC9sZWRz
LnJzdCAgICAgICAgIHwgIDYgKysrLS0tDQo+ICBEb2N1bWVudGF0aW9uL2Zpcm13YXJlLWd1aWRl
L2FjcGkvbHBpdC5yc3QgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9hY3BpL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMv
YWNwaS9uZml0L25maXQuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+
ICA3IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpG
b3IgbmZpdC9uZml0LmgsDQpBY2tlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBp
bnRlbC5jb20+DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L25maXQuaCBiL2Ry
aXZlcnMvYWNwaS9uZml0L25maXQuaA0KPiBpbmRleCBmNTUyNWY4YmI3NzAuLmEzMDNmMDEyMzM5
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvbmZpdC5oDQo+ICsrKyBiL2RyaXZl
cnMvYWNwaS9uZml0L25maXQuaA0KPiBAQCAtMTYsNyArMTYsNyBAQA0KPiAgLyogQUNQSSA2LjEg
Ki8NCj4gICNkZWZpbmUgVVVJRF9ORklUX0JVUyAiMmYxMGU3YTQtOWU5MS0xMWU0LTg5ZDMtMTIz
YjkzZjc1Y2JhIg0KPiAgDQo+IC0vKiBodHRwOi8vcG1lbS5pby9kb2N1bWVudHMvTlZESU1NX0RT
TV9JbnRlcmZhY2UtVjEuNi5wZGYgKi8NCj4gKy8qIGh0dHBzOi8vcG1lbS5pby9kb2N1bWVudHMv
TlZESU1NX0RTTV9JbnRlcmZhY2UtVjEuNi5wZGYgKi8NCj4gICNkZWZpbmUgVVVJRF9ORklUX0RJ
TU0gIjQzMDlhYzMwLTBkMTEtMTFlNC05MTkxLTA4MDAyMDBjOWE2NiINCj4gIA0KPiAgLyogaHR0
cHM6Ly9naXRodWIuY29tL0hld2xldHRQYWNrYXJkL2hwZS1udm0vYmxvYi9tYXN0ZXIvRG9jdW1l
bnRhdGlvbi8gKi8NCj4gLS0gDQo+IDIuMjcuMA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0
byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnDQo=
