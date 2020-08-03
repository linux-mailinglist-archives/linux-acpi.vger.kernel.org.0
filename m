Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37AA239D87
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 04:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHCClJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Aug 2020 22:41:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23943 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgHCClJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2020 22:41:09 -0400
X-UUID: cd93467867384170a77c3c57c92a57c2-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UYxwZ0P+q+fKx3RTeT/v3epewQ6EV5HJGSldwskUAqU=;
        b=IBdd+dV6dpcIzkCcXrMv+7cCDs0UMvUTkFB34HVk7myeRxDiALnln2j/TOXvGwph/PXvzmrrZ96ag1XsTxmvSHOC5K05dixBzTlzcLwXSKRRovNUb0mN11zhfQx3zLg2aIjrdXjsS8IEwFTSMR2lXRYHEF1wzoHW2MCxPyylbs8=;
X-UUID: cd93467867384170a77c3c57c92a57c2-20200803
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2071013625; Mon, 03 Aug 2020 10:41:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 10:41:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 10:40:56 +0800
Message-ID: <1596422456.22971.1.camel@mtkswgap22>
Subject: Re: [PATCH] acpi: fix 'return' with no value build warning
From:   Neal Liu <neal.liu@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 3 Aug 2020 10:40:56 +0800
In-Reply-To: <CAJZ5v0gk9a-PVr4+zerNWdBORyC563K8XgUdgxENAQ+Y5-85tg@mail.gmail.com>
References: <1596166744-2954-1-git-send-email-neal.liu@mediatek.com>
         <1596166744-2954-2-git-send-email-neal.liu@mediatek.com>
         <CAJZ5v0gk9a-PVr4+zerNWdBORyC563K8XgUdgxENAQ+Y5-85tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTMxIGF0IDEzOjMzICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBKdWwgMzEsIDIwMjAgYXQgNTozOSBBTSBOZWFsIExpdSA8bmVhbC5saXVA
bWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZpeGluZyBDRkkgaXNzdWUgd2hpY2ggaW50
cm9kdWNlZCBieSBjb21taXQgZWZlOTcxMTIxNGU2IGlzDQo+ID4gaW5jb21wbGV0ZS4NCj4gPiBB
ZGQgcmV0dXJuIHZhbHVlIHRvIGZpeCByZXR1cm4tdHlwZSBidWlsZCB3YXJuaW5nLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4NCj4gDQo+
IEFwcGxpZWQgd2l0aCBlZGl0ZWQgc3ViamVjdCBhbmQgY2hhbmdlbG9nLCBidXQgLT4NCj4gDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jIHwgICAgNCArKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgYi9kcml2ZXJz
L2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiA+IGluZGV4IDZmZmI2YzkuLjY4NzAwMjAgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMNCj4gPiArKysgYi9kcml2
ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiA+IEBAIC02NjQsMTEgKzY2NCwxMSBAQCBzdGF0
aWMgaW50IGFjcGlfaWRsZV9lbnRlcl9zMmlkbGUoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYs
DQo+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIgPSBfX3RoaXNf
Y3B1X3JlYWQocHJvY2Vzc29ycyk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgaWYgKHVubGlr
ZWx5KCFwcikpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiANCj4gLT4gdGhlcmUgaXMgbm8g
cG9pbnQgcmV0dXJuaW5nIGFuIGVycm9yIGNvZGUgaGVyZSwgc28gSSd2ZSBtYWRlIGl0DQo+IGp1
c3QgcmV0dXJuIDAuDQoNCnJldHVybiAwIGlzIG5vdCBtYXRjaGVkIHdpdGggdGhlIG1lYW5pbmcg
b2YgY29udGV4dHMsIGJ1dCBpdCdzIGZpbmUgZm9yDQp0aGlzIHBhdGNoLg0KVGhhbmtzICENCg0K
PiANCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBpZiAocHItPmZsYWdzLmJtX2NoZWNrKSB7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgYWNwaV9pZGxlX2VudGVyX2JtKHByLCBjeCwgZmFs
c2UpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBBQ1BJX0ZMVVNIX0NQVV9DQUNIRSgpOw0KPiA+ICAg
ICAgICAgICAgICAgICB9DQo+ID4gLS0NCg0K

