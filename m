Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE513091D3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Jan 2021 05:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhA3EVh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 23:21:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2571 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhA3EIt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2021 23:08:49 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DSHyL2mStzW57K;
        Sat, 30 Jan 2021 10:21:30 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 30 Jan 2021 10:23:32 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 30 Jan 2021 10:23:31 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.2106.006;
 Sat, 30 Jan 2021 10:23:31 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggLW5leHRdIEFDUEk6IHRhYmxlczogTWFyayBhY3Bp?=
 =?utf-8?B?X2luaXRfZnBkdCB3aXRoIHN0YXRpYyBrZXl3b3Jk?=
Thread-Topic: [PATCH -next] ACPI: tables: Mark acpi_init_fpdt with static
 keyword
Thread-Index: AQHW9WeUHRO946uAVEKWeV/lZRaz96o9niYAgAHTE7A=
Date:   Sat, 30 Jan 2021 02:23:31 +0000
Message-ID: <1aadcf4006fd4f94822646fd800deb62@huawei.com>
References: <1611833479-87653-1-git-send-email-zou_wei@huawei.com>
 <0940484c3c64c3a6ba1e05f19f2d5137bc4fdcdf.camel@intel.com>
In-Reply-To: <0940484c3c64c3a6ba1e05f19f2d5137bc4fdcdf.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgUnVpLCANCg0KWW91IGNhbiBmaXggaXQgaW4geW91ciBwYXRjaCB0b2dldGhlci4NCg0KLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBaaGFuZyBSdWkgW21haWx0bzpydWkuemhh
bmdAaW50ZWwuY29tXSANCuWPkemAgeaXtumXtDogMjAyMeW5tDHmnIgyOeaXpSAxNDoyNQ0K5pS2
5Lu25Lq6OiBab3V3ZWkgKFNhbXVlbCkgPHpvdV93ZWlAaHVhd2VpLmNvbT47IHJqd0Byand5c29j
a2kubmV0OyBsZW5iQGtlcm5lbC5vcmcNCuaKhOmAgTogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFtQQVRDSCAtbmV4
dF0gQUNQSTogdGFibGVzOiBNYXJrIGFjcGlfaW5pdF9mcGR0IHdpdGggc3RhdGljIGtleXdvcmQN
Cg0KSGksIFdlaSwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCkdpdmVuIHRoYXQgdGhlcmUg
YXJlIGEgY291cGxlIG9mIHRoaW5ncyBuZWVkIHRvIGJlIGZpeGVkIGluIHRoZSBvcmlnbmFsIHBh
dGNoLCBJJ2QgcHJlZmVyIHRvIHJlZnJlc2ggdGhlIHBhdGNoIHdpdGggYWxsIHRoZSBmaXhlcyBp
bmNsdWRlZA0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYWNw
aS9wYXRjaC8yMDIxMDEyOTA2MTU0OC4xMzQ0OC0xLXJ1aS56aGFuZ0BpbnRlbC5jb20vDQoNCndo
YXQgZG8geW91IHRoaW5rPw0KDQp0aGFua3MsDQpydWkNCg0KT24gVGh1LCAyMDIxLTAxLTI4IGF0
IDE5OjMxICswODAwLCBab3UgV2VpIHdyb3RlOg0KPiBGaXggdGhlIGZvbGxvd2luZyBzcGFyc2Ug
d2FybmluZzoNCj4gDQo+IGRyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYzoyMzA6Njogd2FybmluZzog
c3ltYm9sICdhY3BpX2luaXRfZnBkdCcgd2FzIA0KPiBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBi
ZSBzdGF0aWM/DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdlaS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9hY3BpL2FjcGlfZnBkdC5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hY3BpL2FjcGlfZnBkdC5jIGIvZHJpdmVycy9hY3BpL2FjcGlfZnBkdC5jIGlu
ZGV4IA0KPiBiODEwODExLi45NjhmOWNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNw
aV9mcGR0LmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGlfZnBkdC5jDQo+IEBAIC0yMjcsNyAr
MjI3LDcgQEAgc3RhdGljIGludCBmcGR0X3Byb2Nlc3Nfc3VidGFibGUodTY0IGFkZHJlc3MsIHUz
Mg0KPiBzdWJ0YWJsZV90eXBlKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC12b2lkIGFj
cGlfaW5pdF9mcGR0KHZvaWQpDQo+ICtzdGF0aWMgdm9pZCBhY3BpX2luaXRfZnBkdCh2b2lkKQ0K
PiAgew0KPiAgCWFjcGlfc3RhdHVzIHN0YXR1czsNCj4gIAlzdHJ1Y3QgYWNwaV90YWJsZV9oZWFk
ZXIgKmhlYWRlcjsNCg0K
