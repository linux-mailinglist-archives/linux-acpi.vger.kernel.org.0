Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18D922C30F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 12:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXKY5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 06:24:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54033 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgGXKY4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 06:24:56 -0400
X-UUID: 9dbe5281695f49dcbe4e1dd1afcd1041-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QxNgObDGJzQxDLrTGZIVOSiVP4T6qaCHpTNaWSH+6v0=;
        b=CW+hvSKhoe0wHh13K3gvnT01XtI/ixDEAPOA5xTHhdrFcCxwxBTCXzocn//+HqkUt33EOEiSMl2qEGRU/oZNZKZFmztO9ouUg7qodKeHXU7RCSVCapp0gM1nhYsBkmvdE8X6cVNq244fe1TBDyiSV9rZAiYRL5RG1edgRYwwQuw=;
X-UUID: 9dbe5281695f49dcbe4e1dd1afcd1041-20200724
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1631690184; Fri, 24 Jul 2020 18:24:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jul 2020 18:24:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 18:24:49 +0800
Message-ID: <1595586289.14121.5.camel@mtkswgap22>
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
From:   Neal Liu <neal.liu@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Len Brown" <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 24 Jul 2020 18:24:49 +0800
In-Reply-To: <CAJZ5v0g_14D-tyWFEZ9eOJC=GmzR-31iAAPff=Ch8KjFyK2wfw@mail.gmail.com>
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
         <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
         <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
         <1594350535.4670.13.camel@mtkswgap22> <1595233294.8055.0.camel@mtkswgap22>
         <20200723190724.GA1339461@google.com>
         <CAJZ5v0g_14D-tyWFEZ9eOJC=GmzR-31iAAPff=Ch8KjFyK2wfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 525C25BBD1A36A92A548897BC52B0D2A9C1552ADE0B6EEB53F27D34A63DF52742000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTI0IGF0IDExOjU3ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBKdWwgMjMsIDIwMjAgYXQgOTowNyBQTSBTYW1pIFRvbHZhbmVuIDxzYW1p
dG9sdmFuZW5AZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIEp1bCAyMCwgMjAy
MCBhdCAwNDoyMTozNFBNICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gPiA+IEdlbnRsZSBwaW5n
IG9uIHRoaXMgcGF0Y2guDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgMjAyMC0wNy0xMCBh
dCAxMTowOCArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgMjAyMC0wNy0w
OSBhdCAxNDoxOCArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiA+ID4gT24g
TW9uLCBKdWwgNiwgMjAyMCBhdCA1OjEzIEFNIE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5j
b20+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IENvbnRyb2wgRmxvdyBJbnRlZ3Jp
dHkoQ0ZJKSBpcyBhIHNlY3VyaXR5IG1lY2hhbmlzbSB0aGF0IGRpc2FsbG93cw0KPiA+ID4gPiA+
ID4gY2hhbmdlcyB0byB0aGUgb3JpZ2luYWwgY29udHJvbCBmbG93IGdyYXBoIG9mIGEgY29tcGls
ZWQgYmluYXJ5LA0KPiA+ID4gPiA+ID4gbWFraW5nIGl0IHNpZ25pZmljYW50bHkgaGFyZGVyIHRv
IHBlcmZvcm0gc3VjaCBhdHRhY2tzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGluaXRfc3Rh
dGVfbm9kZSgpIGFzc2lnbiBzYW1lIGZ1bmN0aW9uIGNhbGxiYWNrIHRvIGRpZmZlcmVudA0KPiA+
ID4gPiA+ID4gZnVuY3Rpb24gcG9pbnRlciBkZWNsYXJhdGlvbnMuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gc3RhdGljIGludCBpbml0X3N0YXRlX25vZGUoc3RydWN0IGNwdWlkbGVfc3RhdGUg
KmlkbGVfc3RhdGUsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaGVzLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpzdGF0ZV9ub2RlKSB7IC4uLg0KPiA+
ID4gPiA+ID4gICAgICAgICBpZGxlX3N0YXRlLT5lbnRlciA9IG1hdGNoX2lkLT5kYXRhOyAuLi4N
Cj4gPiA+ID4gPiA+ICAgICAgICAgaWRsZV9zdGF0ZS0+ZW50ZXJfczJpZGxlID0gbWF0Y2hfaWQt
PmRhdGE7IH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGdW5jdGlvbiBkZWNsYXJhdGlvbnM6
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gc3RydWN0IGNwdWlkbGVfc3RhdGUgeyAuLi4NCj4g
PiA+ID4gPiA+ICAgICAgICAgaW50ICgqZW50ZXIpIChzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRl
diwNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3B1aWRsZV9kcml2
ZXIgKmRydiwNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBpbnQgaW5kZXgpOw0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgdm9pZCAoKmVudGVyX3MyaWRsZSkgKHN0
cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYsDQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaW5kZXgpOyB9Ow0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IEluIHRoaXMgY2FzZSwgZWl0aGVyIGVudGVyKCkgb3IgZW50ZXJfczJpZGxlKCkg
d291bGQgY2F1c2UgQ0ZJIGNoZWNrDQo+ID4gPiA+ID4gPiBmYWlsZWQgc2luY2UgdGhleSB1c2Ug
c2FtZSBjYWxsZWUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDYW4geW91IHBsZWFzZSBleHBsYWlu
IHRoaXMgaW4gYSBiaXQgbW9yZSBkZXRhaWw/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBpdCBz
dGFuZHMsIEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgcHJvYmxlbSBzdGF0ZW1lbnQgZW5vdWdoIHRv
IGFwcGx5DQo+ID4gPiA+ID4gdGhlIHBhdGNoLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IE9rYXksIExldCdzIG1lIHRyeSB0byBleHBsYWluIG1vcmUgZGV0YWlscy4NCj4gPiA+ID4gQ29u
dHJvbCBGbG93IEludGVncml0eShDRkkpIGlzIGEgc2VjdXJpdHkgbWVjaGFuaXNtIHRoYXQgZGlz
YWxsb3dzDQo+ID4gPiA+IGNoYW5nZXMgdG8gdGhlIG9yaWdpbmFsIGNvbnRyb2wgZmxvdyBncmFw
aCBvZiBhIGNvbXBpbGVkIGJpbmFyeSwgbWFraW5nDQo+ID4gPiA+IGl0IHNpZ25pZmljYW50bHkg
aGFyZGVyIHRvIHBlcmZvcm0gc3VjaCBhdHRhY2tzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBh
cmUgbXVsdGlwbGUgY29udHJvbCBmbG93IGluc3RydWN0aW9ucyB0aGF0IGNvdWxkIGJlIG1hbmlw
dWxhdGVkDQo+ID4gPiA+IGJ5IHRoZSBhdHRhY2tlciBhbmQgc3VidmVydCBjb250cm9sIGZsb3cu
IFRoZSB0YXJnZXQgaW5zdHJ1Y3Rpb25zIHRoYXQNCj4gPiA+ID4gdXNlIGRhdGEgdG8gZGV0ZXJt
aW5lIHRoZSBhY3R1YWwgZGVzdGluYXRpb24uDQo+ID4gPiA+IC0gaW5kaXJlY3QganVtcA0KPiA+
ID4gPiAtIGluZGlyZWN0IGNhbGwNCj4gPiA+ID4gLSByZXR1cm4NCj4gPiA+ID4NCj4gPiA+ID4g
SW4gdGhpcyBjYXNlLCBmdW5jdGlvbiBwcm90b3R5cGUgYmV0d2VlbiBjYWxsZXIgYW5kIGNhbGxl
ZSBhcmUgbWlzbWF0Y2guDQo+ID4gPiA+IENhbGxlcjogKHR5cGUgQSlmdW5jQQ0KPiA+ID4gPiBD
YWxsZWU6ICh0eXBlIEEpZnVuY0INCj4gPiA+ID4gQ2FsbGVlOiAodHlwZSBDKWZ1bmNDDQo+ID4g
PiA+DQo+ID4gPiA+IGZ1bmNBIGNhbGxzIGZ1bmNCIC0+IG5vIHByb2JsZW0NCj4gPiA+ID4gZnVu
Y0EgY2FsbHMgZnVuY0MgLT4gQ0ZJIGNoZWNrIGZhaWxlZA0KPiA+ID4gPg0KPiA+ID4gPiBUaGF0
J3Mgd2h5IHdlIHRyeSB0byBhbGlnbiBmdW5jdGlvbiBwcm90b3R5cGUuDQo+ID4gPiA+IFBsZWFz
ZSBmZWVsIGZyZWUgdG8gZmVlZGJhY2sgaWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucy4NCj4gPg0K
PiA+IEkgdGhpbmsgeW91IHNob3VsZCBpbmNsdWRlIGEgYmV0dGVyIGV4cGxhbmF0aW9uIGluIHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPiBQZXJoYXBzIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+ID4N
Cj4gPiAgIGluaXRfc3RhdGVfbm9kZSBhc3NpZ25zIHRoZSBzYW1lIGNhbGxiYWNrIGZ1bmN0aW9u
IHRvIGJvdGggZW50ZXIgYW5kDQo+ID4gICBlbnRlcl9zMmlkbGUgZGVzcGl0ZSBtaXNtYXRjaGlu
ZyBmdW5jdGlvbiB0eXBlcywgd2hpY2ggdHJpcHMgaW5kaXJlY3QNCj4gPiAgIGNhbGwgY2hlY2tp
bmcgd2l0aCBDb250cm9sLUZsb3cgSW50ZWdyaXR5IChDRkkpLg0KPiA+DQo+ID4gPiA+ID4gPiBB
bGlnbiBmdW5jdGlvbiBwcm90b3R5cGUgb2YgZW50ZXIoKSBzaW5jZSBpdCBuZWVkcyByZXR1cm4g
dmFsdWUgZm9yDQo+ID4gPiA+ID4gPiBzb21lIHVzZSBjYXNlcy4gVGhlIHJldHVybiB2YWx1ZSBv
ZiBlbnRlcl9zMmlkbGUoKSBpcyBubw0KPiA+ID4gPiA+ID4gbmVlZCBjdXJyZW50bHkuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBTbyBsYXN0IHRpbWUgSSByZXF1ZXN0ZWQgeW91IHRvIGRvY3VtZW50
IHdoeSAtPmVudGVyX3MyaWRsZSBuZWVkcyB0bw0KPiA+ID4gPiA+IHJldHVybiBhbiBpbnQgaW4g
dGhlIGNvZGUsIHdoaWNoIGhhcyBub3QgYmVlbiBkb25lLiAgUGxlYXNlIGRvIHRoYXQuDQo+ID4N
Cj4gPiBSYWZhZWwsIGFyZSB5b3UgaGFwcHkgd2l0aCB0aGUgY29tbWl0IG1lc3NhZ2UgZG9jdW1l
bnRpbmcgdGhlIHJlYXNvbiwNCj4gPiBvciB3b3VsZCB5b3UgcHJlZmVyIHRvIGFsc28gYWRkIGEg
Y29tbWVudCBiZWZvcmUgZW50ZXJfczJpZGxlPw0KPiANCj4gQXMgSSBzYWlkIGJlZm9yZSwgaXQg
d291bGQgYmUgZ29vZCB0byBoYXZlIGEgY29tbWVudCBpbiB0aGUgY29kZSBhcw0KPiB3ZWxsIG9y
IHBlb3BsZSB3aWxsIGJlIHdvbmRlcmluZyB3aHkgaXQgaXMgbmVjZXNzYXJ5IHRvIHJldHVybg0K
PiBhbnl0aGluZyBmcm9tIHRoYXQgY2FsbGJhY2ssIGJlY2F1c2UgaXRzIHJldHVybiB2YWx1ZSBp
cyBuZXZlciB1c2VkLg0KPiANCj4gVGhhbmtzIQ0KDQpJcyBpdCBva2F5IHRvIGFkZCB0aGVzZSBj
b21tZW50cyBiZWZvcmUgZW50ZXJfczJpZGxlPw0KDQovKg0KICogQWxpZ24gZnVuY3Rpb24gdHlw
ZSBzaW5jZSBpbml0X3N0YXRlX25vZGUgYXNzaWducyB0aGUgc2FtZSBjYWxsYmFjaw0KICogZnVu
Y3Rpb24gdG8gYm90aCBlbnRlciBhbmQgZW50ZXJfczJpZGxlIGRlc3BpdGUgbWlzbWF0Y2hpbmcg
ZnVuY3Rpb24NCiAqIHR5cGVzLCB3aGljaCB0cmlwcyBpbmRpcmVjdCBjYWxsIGNoZWNraW5nIHdp
dGggQ29udHJvbC1GbG93IEludGVncml0eQ0KICogKENGSSkuDQogKi8NCmludCAoKmVudGVyX3My
aWRsZSkoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsDQoJCSAgICBzdHJ1Y3QgY3B1aWRsZV9k
cml2ZXIgKmRydiwNCgkJICAgIGludCBpbmRleCk7DQoNCg==

