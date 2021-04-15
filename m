Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDC360723
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhDOKaj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 06:30:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3943 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhDOKai (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 06:30:38 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FLbBt1YFfz5pf3;
        Thu, 15 Apr 2021 18:27:50 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 15 Apr 2021 18:30:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 18:30:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.013; Thu, 15 Apr 2021 11:30:04 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Auger Eric <eric.auger@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXMdtSGvoqQxuJ7EiyMPOXug8NR6q1Xacw
Date:   Thu, 15 Apr 2021 10:30:03 +0000
Message-ID: <0c5ef81c82984f6eaabdc9b27ee79070@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-3-shameerali.kolothum.thodi@huawei.com>
 <a64025cd-3312-9621-1771-8e0430220ed8@redhat.com>
In-Reply-To: <a64025cd-3312-9621-1771-8e0430220ed8@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.27.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxNSBBcHJpbCAyMDIx
IDEwOjM5DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJt
QGh1YXdlaS5jb20+OyBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsgR3VvaGFuanVuDQo+IChIYW5qdW4g
R3VvKSA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBTYW1pLk11amF3YXJAYXJtLmNvbTsNCj4gcm9i
aW4ubXVycGh5QGFybS5jb207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDIvOF0gQUNQSS9JT1JUOiBBZGQgc3VwcG9y
dCBmb3IgUk1SIG5vZGUgcGFyc2luZw0KPiANCj4gSGkgU2hhbWVlciwNCj4gT24gMTEvMTkvMjAg
MToxMSBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgcGFy
c2luZyBSTVIgbm9kZSBpbmZvcm1hdGlvbiBmcm9tIEFDUEkuDQo+ID4gRmluZCBhc3NvY2lhdGVk
IHN0cmVhbSBpZHMgYW5kIHNtbXUgbm9kZcKgaW5mbyBmcm9tIHRoZQ0KPiA+IFJNUiBub2RlIGFu
ZCBwb3B1bGF0ZSBhIGxpbmtlZCBsaXN0IHdpdGggUk1SIG1lbW9yeQ0KPiA+IGRlc2NyaXB0b3Jz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYXJt
NjQvaW9ydC5jIHwgMTIyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgYi9kcml2ZXJz
L2FjcGkvYXJtNjQvaW9ydC5jDQo+ID4gaW5kZXggOTkyOWZmNTBjMGMwLi5hOTcwNWFhMzUwMjgg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gPiBAQCAtNDAsNiArNDAsMjUgQEAgc3RydWN0IGlv
cnRfZndub2RlIHsNCj4gPiAgc3RhdGljIExJU1RfSEVBRChpb3J0X2Z3bm9kZV9saXN0KTsNCj4g
PiAgc3RhdGljIERFRklORV9TUElOTE9DSyhpb3J0X2Z3bm9kZV9sb2NrKTsNCj4gPg0KPiA+ICtz
dHJ1Y3QgaW9ydF9ybXJfaWQgew0KPiA+ICsJdTMyICBzaWQ7DQo+ID4gKwlzdHJ1Y3QgYWNwaV9p
b3J0X25vZGUgKnNtbXU7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBPbmUgZW50
cnkgZm9yIElPUlQgUk1SLg0KPiA+ICsgKi8NCj4gPiArc3RydWN0IGlvcnRfcm1yX2VudHJ5IHsN
Cj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCj4gPiArDQo+ID4gKwl1bnNpZ25lZCBpbnQg
cm1yX2lkc19udW07DQo+ID4gKwlzdHJ1Y3QgaW9ydF9ybXJfaWQgKnJtcl9pZHM7DQo+ID4gKw0K
PiA+ICsJc3RydWN0IGFjcGlfaW9ydF9ybXJfZGVzYyAqcm1yX2Rlc2M7DQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgTElTVF9IRUFEKGlvcnRfcm1yX2xpc3QpOyAgICAgICAgIC8qIGxpc3Qg
b2YgUk1SIHJlZ2lvbnMgZnJvbSBBQ1BJDQo+ICovDQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICog
aW9ydF9zZXRfZndub2RlKCkgLSBDcmVhdGUgaW9ydF9md25vZGUgYW5kIHVzZSBpdCB0byByZWdp
c3Rlcg0KPiA+ICAgKgkJICAgICAgIGlvbW11IGRhdGEgaW4gdGhlIGlvcnRfZndub2RlX2xpc3QN
Cj4gPiBAQCAtMzkzLDcgKzQxMiw4IEBAIHN0YXRpYyBzdHJ1Y3QgYWNwaV9pb3J0X25vZGUNCj4g
KmlvcnRfbm9kZV9nZXRfaWQoc3RydWN0IGFjcGlfaW9ydF9ub2RlICpub2RlLA0KPiA+ICAJCWlm
IChub2RlLT50eXBlID09IEFDUElfSU9SVF9OT0RFX05BTUVEX0NPTVBPTkVOVCB8fA0KPiA+ICAJ
CSAgICBub2RlLT50eXBlID09IEFDUElfSU9SVF9OT0RFX1BDSV9ST09UX0NPTVBMRVggfHwNCj4g
PiAgCQkgICAgbm9kZS0+dHlwZSA9PSBBQ1BJX0lPUlRfTk9ERV9TTU1VX1YzIHx8DQo+ID4gLQkJ
ICAgIG5vZGUtPnR5cGUgPT0gQUNQSV9JT1JUX05PREVfUE1DRykgew0KPiA+ICsJCSAgICBub2Rl
LT50eXBlID09IEFDUElfSU9SVF9OT0RFX1BNQ0cgfHwNCj4gPiArCQkgICAgbm9kZS0+dHlwZSA9
PSBBQ1BJX0lPUlRfTk9ERV9STVIpIHsNCj4gPiAgCQkJKmlkX291dCA9IG1hcC0+b3V0cHV0X2Jh
c2U7DQo+ID4gIAkJCXJldHVybiBwYXJlbnQ7DQo+ID4gIAkJfQ0KPiA+IEBAIC0xNjQ3LDYgKzE2
NjcsMTAzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpb3J0X2VuYWJsZV9hY3Moc3RydWN0DQo+IGFj
cGlfaW9ydF9ub2RlICppb3J0X25vZGUpDQo+ID4gICNlbHNlDQo+ID4gIHN0YXRpYyBpbmxpbmUg
dm9pZCBpb3J0X2VuYWJsZV9hY3Moc3RydWN0IGFjcGlfaW9ydF9ub2RlICppb3J0X25vZGUpIHsg
fQ0KPiA+ICAjZW5kaWYNCj4gPiArc3RhdGljIGludCBpb3J0X3Jtcl9kZXNjX3ZhbGlkKHN0cnVj
dCBhY3BpX2lvcnRfcm1yX2Rlc2MgKmRlc2MpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpb3J0X3Jt
cl9lbnRyeSAqZTsNCj4gPiArCXU2NCBlbmQsIHN0YXJ0ID0gZGVzYy0+YmFzZV9hZGRyZXNzLCBs
ZW5ndGggPSBkZXNjLT5sZW5ndGg7DQo+ID4gKw0KPiA+ICsJaWYgKCFJU19BTElHTkVEKHN0YXJ0
LCBTWl82NEspIHx8ICFJU19BTElHTkVEKGxlbmd0aCwgU1pfNjRLKSkNCj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiArDQo+ID4gKwllbmQgPSBzdGFydCArIGxlbmd0aCAtIDE7DQo+ID4gKw0K
PiA+ICsJLyogQ2hlY2sgZm9yIGFkZHJlc3Mgb3ZlcmxhcCAqLw0KPiBJIGRvbid0IGdldCB0aGlz
IGNoZWNrLiBXaGF0IGlzIHRoZSBwcm9ibGVtIGlmIHlvdSBhdHRhY2ggdGhlIHNhbWUgcmFuZ2UN
Cj4gdG8gZGlmZmVyZW50IHN0cmVhbSBpZHMuIFNob3VsZG4ndCB5b3UgY2hlY2sgdGhlcmUgaXMg
bm8gb3ZlcmxhcCBmb3IgdGhlDQo+IHNhbWUgc2lkPw0KDQpUaGF04oCZcyByaWdodC4gVGhlIGNo
ZWNrIHNob3VsZCBiZSBmb3IgbWVtb3J5IGRlc2NyaXB0b3JzIHdpdGhpbiBhbiBSTVIuDQpJIGdv
dCBjb25mdXNlZCBieSB0aGUgd29yZGluZ3MgaW4gdGhlIElPUlQgc3BlYyBhbmQgdGhhdCBpcyBu
b3cgY2xhcmlmaWVkDQp3aXRoIExvcmVuem8gaGVyZSwNCg0KaHR0cHM6Ly9vcC1saXN0cy5saW5h
cm8ub3JnL3BpcGVybWFpbC9saW5hcm8tb3Blbi1kaXNjdXNzaW9ucy8yMDIxLUFwcmlsLzAwMDE1
MC5odG1sDQoNCkkgd2lsbCBjaGFuZ2UgdGhpcy4NCj4gDQo+IA0KPiA+ICsJbGlzdF9mb3JfZWFj
aF9lbnRyeShlLCAmaW9ydF9ybXJfbGlzdCwgbGlzdCkgew0KPiA+ICsJCXU2NCBlX3N0YXJ0ID0g
ZS0+cm1yX2Rlc2MtPmJhc2VfYWRkcmVzczsNCj4gPiArCQl1NjQgZV9lbmQgPSBlX3N0YXJ0ICsg
ZS0+cm1yX2Rlc2MtPmxlbmd0aCAtIDE7DQo+ID4gKw0KPiA+ICsJCWlmIChzdGFydCA8PSBlX2Vu
ZCAmJiBlbmQgPj0gZV9zdGFydCkNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19p
bml0IGlvcnRfcGFyc2Vfcm1yKHN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9ydF9ub2RlKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgaW9ydF9ybXJfaWQgKnJtcl9pZHMsICppZHM7DQo+ID4gKwlzdHJ1
Y3QgaW9ydF9ybXJfZW50cnkgKmU7DQo+ID4gKwlzdHJ1Y3QgYWNwaV9pb3J0X3JtciAqcm1yOw0K
PiA+ICsJc3RydWN0IGFjcGlfaW9ydF9ybXJfZGVzYyAqcm1yX2Rlc2M7DQo+ID4gKwl1MzIgbWFw
X2NvdW50ID0gaW9ydF9ub2RlLT5tYXBwaW5nX2NvdW50Ow0KPiA+ICsJaW50IGksIHJldCA9IDAs
IGRlc2NfY291bnQgPSAwOw0KPiA+ICsNCj4gPiArCWlmIChpb3J0X25vZGUtPnR5cGUgIT0gQUNQ
SV9JT1JUX05PREVfUk1SKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWlmICghaW9y
dF9ub2RlLT5tYXBwaW5nX29mZnNldCB8fCAhbWFwX2NvdW50KSB7DQo+ID4gKwkJcHJfZXJyKEZX
X0JVRyAiSW52YWxpZCBJRCBtYXBwaW5nLCBza2lwcGluZyBSTVIgbm9kZSAlcFxuIiwNCj4gPiAr
CQkgICAgICAgaW9ydF9ub2RlKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlybXJfaWRzID0ga21hbGxvYyhzaXplb2YoKnJtcl9pZHMpICogbWFwX2NvdW50
LCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcm1yX2lkcykNCj4gPiArCQlyZXR1cm4gLUVOT01F
TTsNCj4gPiArDQo+ID4gKwkvKiBSZXRyaWV2ZSBhc3NvY2lhdGVkIHNtbXUgYW5kIHN0cmVhbSBp
ZCAqLw0KPiA+ICsJaWRzID0gcm1yX2lkczsNCj4gbml0OiBkbyB5b3UgbmVlZCBib3RoIHJtcl9p
ZHMgYW5kIGlkcz8NCg0KTm90IHJlYWxseSBhcyB0aGUgc3BlYyBzYXlzIGl0IGlzIE06MSBtYXBw
aW5nLiBTbyB3ZSBvbmx5IHdpbGwgaGF2ZSBvbmUgDQpzaW5nbGUgaWQgaGVyZShhbHNvIG1hcF9j
b3VudCBmb3IgdGhlIG5vZGUgbXVzdCBiZSBzZXQgdG8gMSBhcyB3ZWxsKS4NCg0KPiA+ICsJZm9y
IChpID0gMDsgaSA8IG1hcF9jb3VudDsgaSsrLCBpZHMrKykgew0KPiA+ICsJCWlkcy0+c21tdSA9
IGlvcnRfbm9kZV9nZXRfaWQoaW9ydF9ub2RlLCAmaWRzLT5zaWQsIGkpOw0KPiA+ICsJCWlmICgh
aWRzLT5zbW11KSB7DQo+ID4gKwkJCXByX2VycihGV19CVUcgIkludmFsaWQgU01NVSByZWZlcmVu
Y2UsIHNraXBwaW5nIFJNUg0KPiBub2RlICVwXG4iLA0KPiA+ICsJCQkgICAgICAgaW9ydF9ub2Rl
KTsNCj4gPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiArCQkJZ290byBvdXQ7DQo+ID4gKwkJfQ0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qIFJldHJpZXZlIFJNUiBkYXRhICovDQo+ID4gKwlybXIg
PSAoc3RydWN0IGFjcGlfaW9ydF9ybXIgKilpb3J0X25vZGUtPm5vZGVfZGF0YTsNCj4gPiArCWlm
ICghcm1yLT5ybXJfb2Zmc2V0IHx8ICFybXItPnJtcl9jb3VudCkgew0KPiA+ICsJCXByX2VycihG
V19CVUcgIkludmFsaWQgUk1SIGRlc2NyaXB0b3IgYXJyYXksIHNraXBwaW5nIFJNUg0KPiBub2Rl
ICVwXG4iLA0KPiA+ICsJCSAgICAgICBpb3J0X25vZGUpOw0KPiA+ICsJCXJldCA9IC1FSU5WQUw7
DQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcm1yX2Rlc2MgPSBBQ1BJ
X0FERF9QVFIoc3RydWN0IGFjcGlfaW9ydF9ybXJfZGVzYywgaW9ydF9ub2RlLA0KPiA+ICsJCQkJ
cm1yLT5ybXJfb2Zmc2V0KTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgcm1yLT5ybXJf
Y291bnQ7IGkrKywgcm1yX2Rlc2MrKykgew0KPiA+ICsJCXJldCA9IGlvcnRfcm1yX2Rlc2NfdmFs
aWQocm1yX2Rlc2MpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJcHJfZXJyKEZXX0JVRyAi
SW52YWxpZCBSTVIgZGVzY3JpcHRvclslZF0gZm9yIG5vZGUgJXAsDQo+IHNraXBwaW5nLi4uXG4i
LA0KPiA+ICsJCQkgICAgICAgaSwgaW9ydF9ub2RlKTsNCj4gPiArCQkJZ290byBvdXQ7DQo+IHNv
IEkgdW5kZXJzdGFuZCB5b3Ugc2tpcCB0aGUgd2hvbGUgbm9kZSBhbmQgbm90IGp1c3QgdGhhdCBy
bXIgZGVzYywNCj4gb3RoZXJ3aXNlIHlvdSB3b3VsZCBjb250aW51ZS4gc28gaW4gdGhhdCBjYXNl
IGRvbid0IHlvdSBuZWVkIHRvIGZyZWUNCj4gYm90aCBybXJfaWRzIGFuZCBhbHJlYWR5IGFsbG9j
YXRlZCAnZSc/DQoNCkFncmVlLiBUaGlzIG5lZWRzIHRvIGJlIGNoYW5nZWQuDQoNCj4gPiArCQl9
DQo+ID4gKw0KPiA+ICsJCWUgPSBrbWFsbG9jKHNpemVvZigqZSksIEdGUF9LRVJORUwpOw0KPiA+
ICsJCWlmICghZSkgew0KPiA+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIG91dDsN
Cj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWUtPnJtcl9pZHNfbnVtID0gbWFwX2NvdW50Ow0KPiA+
ICsJCWUtPnJtcl9pZHMgPSBybXJfaWRzOw0KPiA+ICsJCWUtPnJtcl9kZXNjID0gcm1yX2Rlc2M7
DQo+ID4gKw0KPiA+ICsJCWxpc3RfYWRkX3RhaWwoJmUtPmxpc3QsICZpb3J0X3Jtcl9saXN0KTsN
Cj4gPiArCQlkZXNjX2NvdW50Kys7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gKw0KPiA+ICtvdXQ6DQo+ID4gKwlpZiAoIWRlc2NfY291bnQpDQo+IGRvbid0IHlvdSB3YW50
IHRvIHRlc3QgcmV0IGluc3RlYWQ/IHNlZSBjb21tZW50IGFib3ZlLiArIGZyZWUgYWxsb2NhdGVk
ICcnZScNCg0KUmlnaHQuIEkgd2lsbCBjaGFuZ2UgaXQgbmV4dCByZXZpc2lvbi4NCg0KVGhhbmtz
IGZvciB0YWtpbmcgYSBsb29rLg0KDQpSZWdhcmRzLA0KU2hhbWVlcg0KDQo+ID4gKwkJa2ZyZWUo
cm1yX2lkcyk7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4NCj4gPiAgc3RhdGljIHZv
aWQgX19pbml0IGlvcnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKHZvaWQpDQo+ID4gIHsNCj4gPiBA
QCAtMTY3Niw2ICsxNzkzLDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGlvcnRfaW5pdF9wbGF0Zm9y
bV9kZXZpY2VzKHZvaWQpDQo+ID4NCj4gPiAgCQlpb3J0X2VuYWJsZV9hY3MoaW9ydF9ub2RlKTsN
Cj4gPg0KPiA+ICsJCWlmIChpb3J0X3RhYmxlLT5yZXZpc2lvbiA9PSAxKQ0KPiA+ICsJCQlpb3J0
X3BhcnNlX3Jtcihpb3J0X25vZGUpOw0KPiA+ICsNCj4gPiAgCQlvcHMgPSBpb3J0X2dldF9kZXZf
Y2ZnKGlvcnRfbm9kZSk7DQo+ID4gIAkJaWYgKG9wcykgew0KPiA+ICAJCQlmd25vZGUgPSBhY3Bp
X2FsbG9jX2Z3bm9kZV9zdGF0aWMoKTsNCj4gPg0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCg0K
