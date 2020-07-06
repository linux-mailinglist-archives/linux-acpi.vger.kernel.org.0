Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB021514F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jul 2020 05:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgGFDNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jul 2020 23:13:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22431 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728709AbgGFDNe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jul 2020 23:13:34 -0400
X-UUID: 961b5db1c8e74aa99f2a2901d7107d2f-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pKniBVcACW/1c0nv/+i0UMEccnPGSztmdOgnnm5URG0=;
        b=IVmYEUN3vmp2vCR+13XeHdnDKPyhhE/A1MhmIXtWqBqo9n7y/LJFMlo1lrJr66e66tiWL5NXk3swUPlOdRxMdnpaUJ7rAlng+92hkbUoiDgjIexlFtPYHV3cD1TC30lk0BBWaYK9O/iZd+ShDjx5cgoaL5SdrkProUBNY4zolkE=;
X-UUID: 961b5db1c8e74aa99f2a2901d7107d2f-20200706
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1664098016; Mon, 06 Jul 2020 11:13:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 11:13:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 11:13:18 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <linux-acpi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2] cpuidle: change enter_s2idle() prototype
Date:   Mon, 6 Jul 2020 11:13:16 +0800
Message-ID: <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 597824827A178439AFED3D26CDAD9F180957C939B943E4CAF103919A77FC3B032000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Q29udHJvbCBGbG93IEludGVncml0eShDRkkpIGlzIGEgc2VjdXJpdHkgbWVjaGFuaXNtIHRoYXQg
ZGlzYWxsb3dzDQpjaGFuZ2VzIHRvIHRoZSBvcmlnaW5hbCBjb250cm9sIGZsb3cgZ3JhcGggb2Yg
YSBjb21waWxlZCBiaW5hcnksDQptYWtpbmcgaXQgc2lnbmlmaWNhbnRseSBoYXJkZXIgdG8gcGVy
Zm9ybSBzdWNoIGF0dGFja3MuDQoNCmluaXRfc3RhdGVfbm9kZSgpIGFzc2lnbiBzYW1lIGZ1bmN0
aW9uIGNhbGxiYWNrIHRvIGRpZmZlcmVudA0KZnVuY3Rpb24gcG9pbnRlciBkZWNsYXJhdGlvbnMu
DQoNCnN0YXRpYyBpbnQgaW5pdF9zdGF0ZV9ub2RlKHN0cnVjdCBjcHVpZGxlX3N0YXRlICppZGxl
X3N0YXRlLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCAqbWF0Y2hlcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vf
bm9kZSAqc3RhdGVfbm9kZSkgeyAuLi4NCiAgICAgICAgaWRsZV9zdGF0ZS0+ZW50ZXIgPSBtYXRj
aF9pZC0+ZGF0YTsgLi4uDQogICAgICAgIGlkbGVfc3RhdGUtPmVudGVyX3MyaWRsZSA9IG1hdGNo
X2lkLT5kYXRhOyB9DQoNCkZ1bmN0aW9uIGRlY2xhcmF0aW9uczoNCg0Kc3RydWN0IGNwdWlkbGVf
c3RhdGUgeyAuLi4NCiAgICAgICAgaW50ICgqZW50ZXIpIChzdHJ1Y3QgY3B1aWRsZV9kZXZpY2Ug
KmRldiwNCiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwN
CiAgICAgICAgICAgICAgICAgICAgICBpbnQgaW5kZXgpOw0KDQogICAgICAgIHZvaWQgKCplbnRl
cl9zMmlkbGUpIChzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBjcHVpZGxlX2RyaXZlciAqZHJ2LA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGluZGV4KTsgfTsNCg0KSW4gdGhpcyBjYXNlLCBlaXRoZXIgZW50
ZXIoKSBvciBlbnRlcl9zMmlkbGUoKSB3b3VsZCBjYXVzZSBDRkkgY2hlY2sNCmZhaWxlZCBzaW5j
ZSB0aGV5IHVzZSBzYW1lIGNhbGxlZS4NCg0KQWxpZ24gZnVuY3Rpb24gcHJvdG90eXBlIG9mIGVu
dGVyKCkgc2luY2UgaXQgbmVlZHMgcmV0dXJuIHZhbHVlIGZvcg0Kc29tZSB1c2UgY2FzZXMuIFRo
ZSByZXR1cm4gdmFsdWUgb2YgZW50ZXJfczJpZGxlKCkgaXMgbm8NCm5lZWQgY3VycmVudGx5Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgICB8ICAgIDYgKysrKy0tDQogZHJpdmVycy9j
cHVpZGxlL2NwdWlkbGUtdGVncmEuYyB8ICAgIDggKysrKystLS0NCiBkcml2ZXJzL2lkbGUvaW50
ZWxfaWRsZS5jICAgICAgIHwgICAgNiArKysrLS0NCiBpbmNsdWRlL2xpbnV4L2NwdWlkbGUuaCAg
ICAgICAgIHwgICAgNiArKystLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9p
ZGxlLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KaW5kZXggNzU1MzRjNS4uNmZm
YjZjOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQorKysgYi9k
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KQEAgLTY1NSw4ICs2NTUsOCBAQCBzdGF0aWMg
aW50IGFjcGlfaWRsZV9lbnRlcihzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCiAJcmV0dXJu
IGluZGV4Ow0KIH0NCiANCi1zdGF0aWMgdm9pZCBhY3BpX2lkbGVfZW50ZXJfczJpZGxlKHN0cnVj
dCBjcHVpZGxlX2RldmljZSAqZGV2LA0KLQkJCQkgICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRy
diwgaW50IGluZGV4KQ0KK3N0YXRpYyBpbnQgYWNwaV9pZGxlX2VudGVyX3MyaWRsZShzdHJ1Y3Qg
Y3B1aWRsZV9kZXZpY2UgKmRldiwNCisJCQkJICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwg
aW50IGluZGV4KQ0KIHsNCiAJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2N4ICpjeCA9IHBlcl9jcHUo
YWNwaV9jc3RhdGVbaW5kZXhdLCBkZXYtPmNwdSk7DQogDQpAQCAtNjc0LDYgKzY3NCw4IEBAIHN0
YXRpYyB2b2lkIGFjcGlfaWRsZV9lbnRlcl9zMmlkbGUoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpk
ZXYsDQogCQl9DQogCX0NCiAJYWNwaV9pZGxlX2RvX2VudHJ5KGN4KTsNCisNCisJcmV0dXJuIDA7
DQogfQ0KIA0KIHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3Jfc2V0dXBfY3B1aWRsZV9jeChzdHJ1
Y3QgYWNwaV9wcm9jZXNzb3IgKnByLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1aWRsZS9jcHVp
ZGxlLXRlZ3JhLmMgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS10ZWdyYS5jDQppbmRleCAxNTAw
NDU4Li5hMTJmYjE0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUtdGVncmEu
Yw0KKysrIGIvZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUtdGVncmEuYw0KQEAgLTI1MywxMSArMjUz
LDEzIEBAIHN0YXRpYyBpbnQgdGVncmFfY3B1aWRsZV9lbnRlcihzdHJ1Y3QgY3B1aWRsZV9kZXZp
Y2UgKmRldiwNCiAJcmV0dXJuIGVyciA/IC0xIDogaW5kZXg7DQogfQ0KIA0KLXN0YXRpYyB2b2lk
IHRlZ3JhMTE0X2VudGVyX3MyaWRsZShzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCi0JCQkJ
ICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwNCi0JCQkJICBpbnQgaW5kZXgpDQorc3RhdGlj
IGludCB0ZWdyYTExNF9lbnRlcl9zMmlkbGUoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsDQor
CQkJCSBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwNCisJCQkJIGludCBpbmRleCkNCiB7DQog
CXRlZ3JhX2NwdWlkbGVfZW50ZXIoZGV2LCBkcnYsIGluZGV4KTsNCisNCisJcmV0dXJuIDA7DQog
fQ0KIA0KIC8qDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZl
cnMvaWRsZS9pbnRlbF9pZGxlLmMNCmluZGV4IGY0NDk1ODQuLmIxNzhkYTMgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQorKysgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRs
ZS5jDQpAQCAtMTc1LDEzICsxNzUsMTUgQEAgc3RhdGljIF9fY3B1aWRsZSBpbnQgaW50ZWxfaWRs
ZShzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCiAgKiBJbnZva2VkIGFzIGEgc3VzcGVuZC10
by1pZGxlIGNhbGxiYWNrIHJvdXRpbmUgd2l0aCBmcm96ZW4gdXNlciBzcGFjZSwgZnJvemVuDQog
ICogc2NoZWR1bGVyIHRpY2sgYW5kIHN1c3BlbmRlZCBzY2hlZHVsZXIgY2xvY2sgb24gdGhlIHRh
cmdldCBDUFUuDQogICovDQotc3RhdGljIF9fY3B1aWRsZSB2b2lkIGludGVsX2lkbGVfczJpZGxl
KHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KLQkJCQkJc3RydWN0IGNwdWlkbGVfZHJpdmVy
ICpkcnYsIGludCBpbmRleCkNCitzdGF0aWMgX19jcHVpZGxlIGludCBpbnRlbF9pZGxlX3MyaWRs
ZShzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCisJCQkJICAgICAgIHN0cnVjdCBjcHVpZGxl
X2RyaXZlciAqZHJ2LCBpbnQgaW5kZXgpDQogew0KIAl1bnNpZ25lZCBsb25nIGVheCA9IGZsZzJN
V0FJVChkcnYtPnN0YXRlc1tpbmRleF0uZmxhZ3MpOw0KIAl1bnNpZ25lZCBsb25nIGVjeCA9IDE7
IC8qIGJyZWFrIG9uIGludGVycnVwdCBmbGFnICovDQogDQogCW13YWl0X2lkbGVfd2l0aF9oaW50
cyhlYXgsIGVjeCk7DQorDQorCXJldHVybiAwOw0KIH0NCiANCiAvKg0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvY3B1aWRsZS5oIGIvaW5jbHVkZS9saW51eC9jcHVpZGxlLmgNCmluZGV4IGVj
MmVmNjMuLmJlZTEwYzAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2NwdWlkbGUuaA0KKysr
IGIvaW5jbHVkZS9saW51eC9jcHVpZGxlLmgNCkBAIC02Niw5ICs2Niw5IEBAIHN0cnVjdCBjcHVp
ZGxlX3N0YXRlIHsNCiAJICogc3VzcGVuZGVkLCBzbyBpdCBtdXN0IG5vdCByZS1lbmFibGUgaW50
ZXJydXB0cyBhdCBhbnkgcG9pbnQgKGV2ZW4NCiAJICogdGVtcG9yYXJpbHkpIG9yIGF0dGVtcHQg
dG8gY2hhbmdlIHN0YXRlcyBvZiBjbG9jayBldmVudCBkZXZpY2VzLg0KIAkgKi8NCi0Jdm9pZCAo
KmVudGVyX3MyaWRsZSkgKHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KLQkJCSAgICAgIHN0
cnVjdCBjcHVpZGxlX2RyaXZlciAqZHJ2LA0KLQkJCSAgICAgIGludCBpbmRleCk7DQorCWludCAo
KmVudGVyX3MyaWRsZSkoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsDQorCQkJICAgIHN0cnVj
dCBjcHVpZGxlX2RyaXZlciAqZHJ2LA0KKwkJCSAgICBpbnQgaW5kZXgpOw0KIH07DQogDQogLyog
SWRsZSBTdGF0ZSBGbGFncyAqLw0KLS0gDQoxLjcuOS41DQo=

