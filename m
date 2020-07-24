Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4C22C488
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXLuE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 07:50:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726258AbgGXLuC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 07:50:02 -0400
X-UUID: 55db7f9a7c884a778703db8255597168-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/zejYp/GTVn0VhxNwV3OAw/hISSDpVJ/mNNf/5S0Uhs=;
        b=Rc5v0upbAXkF2nBLLL5gH9B8fJPzNVpPfs7OYGAlclnFjEtRmaECj+70dNiPL/4ryxEuVlSpKPDyIJABdzXVyBgrQiRPCXXzWM1fXCWyCggRJtWDc6Sj1yHXzI6eUqeiAggy7JJb7rRDwmKk9cmXg2vA68phWdpZXJxVDthx4q8=;
X-UUID: 55db7f9a7c884a778703db8255597168-20200724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 223498868; Fri, 24 Jul 2020 19:49:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jul 2020 19:49:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 19:49:48 +0800
Message-ID: <1595591389.14564.3.camel@mtkswgap22>
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
Date:   Fri, 24 Jul 2020 19:49:49 +0800
In-Reply-To: <CAJZ5v0hnW5NB1T90QNSVuzFSZrrXzxKASWYDTW=mFF6MOan9hQ@mail.gmail.com>
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
         <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
         <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
         <1594350535.4670.13.camel@mtkswgap22> <1595233294.8055.0.camel@mtkswgap22>
         <20200723190724.GA1339461@google.com>
         <CAJZ5v0g_14D-tyWFEZ9eOJC=GmzR-31iAAPff=Ch8KjFyK2wfw@mail.gmail.com>
         <1595586289.14121.5.camel@mtkswgap22>
         <CAJZ5v0hnW5NB1T90QNSVuzFSZrrXzxKASWYDTW=mFF6MOan9hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTI0IGF0IDEzOjIwICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBKdWwgMjQsIDIwMjAgYXQgMTI6MjQgUE0gTmVhbCBMaXUgPG5lYWwubGl1
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIDIwMjAtMDctMjQgYXQgMTE6
NTcgKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMjMs
IDIwMjAgYXQgOTowNyBQTSBTYW1pIFRvbHZhbmVuIDxzYW1pdG9sdmFuZW5AZ29vZ2xlLmNvbT4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgSnVsIDIwLCAyMDIwIGF0IDA0OjIxOjM0
UE0gKzA4MDAsIE5lYWwgTGl1IHdyb3RlOg0KPiA+ID4gPiA+IEdlbnRsZSBwaW5nIG9uIHRoaXMg
cGF0Y2guDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIEZyaSwgMjAyMC0wNy0x
MCBhdCAxMTowOCArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUaHUsIDIw
MjAtMDctMDkgYXQgMTQ6MTggKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiBPbiBNb24sIEp1bCA2LCAyMDIwIGF0IDU6MTMgQU0gTmVhbCBMaXUgPG5lYWwubGl1
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBD
b250cm9sIEZsb3cgSW50ZWdyaXR5KENGSSkgaXMgYSBzZWN1cml0eSBtZWNoYW5pc20gdGhhdCBk
aXNhbGxvd3MNCj4gPiA+ID4gPiA+ID4gPiBjaGFuZ2VzIHRvIHRoZSBvcmlnaW5hbCBjb250cm9s
IGZsb3cgZ3JhcGggb2YgYSBjb21waWxlZCBiaW5hcnksDQo+ID4gPiA+ID4gPiA+ID4gbWFraW5n
IGl0IHNpZ25pZmljYW50bHkgaGFyZGVyIHRvIHBlcmZvcm0gc3VjaCBhdHRhY2tzLg0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gaW5pdF9zdGF0ZV9ub2RlKCkgYXNzaWduIHNhbWUg
ZnVuY3Rpb24gY2FsbGJhY2sgdG8gZGlmZmVyZW50DQo+ID4gPiA+ID4gPiA+ID4gZnVuY3Rpb24g
cG9pbnRlciBkZWNsYXJhdGlvbnMuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBz
dGF0aWMgaW50IGluaXRfc3RhdGVfbm9kZShzdHJ1Y3QgY3B1aWRsZV9zdGF0ZSAqaWRsZV9zdGF0
ZSwNCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaGVzLA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqc3RhdGVfbm9kZSkgeyAuLi4NCj4gPiA+
ID4gPiA+ID4gPiAgICAgICAgIGlkbGVfc3RhdGUtPmVudGVyID0gbWF0Y2hfaWQtPmRhdGE7IC4u
Lg0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgaWRsZV9zdGF0ZS0+ZW50ZXJfczJpZGxlID0gbWF0
Y2hfaWQtPmRhdGE7IH0NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEZ1bmN0aW9u
IGRlY2xhcmF0aW9uczoNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IHN0cnVjdCBj
cHVpZGxlX3N0YXRlIHsgLi4uDQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICBpbnQgKCplbnRlcikg
KHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwNCj4gPiA+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgaW50IGluZGV4KTsNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgdm9pZCAoKmVudGVyX3MyaWRsZSkgKHN0cnVjdCBjcHVpZGxlX2Rl
dmljZSAqZGV2LA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBjcHVpZGxlX2RyaXZlciAqZHJ2LA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBpbmRleCk7IH07DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiBJbiB0aGlzIGNhc2UsIGVpdGhlciBlbnRlcigpIG9yIGVudGVyX3MyaWRsZSgp
IHdvdWxkIGNhdXNlIENGSSBjaGVjaw0KPiA+ID4gPiA+ID4gPiA+IGZhaWxlZCBzaW5jZSB0aGV5
IHVzZSBzYW1lIGNhbGxlZS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQ2FuIHlvdSBw
bGVhc2UgZXhwbGFpbiB0aGlzIGluIGEgYml0IG1vcmUgZGV0YWlsPw0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiBBcyBpdCBzdGFuZHMsIEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgcHJvYmxl
bSBzdGF0ZW1lbnQgZW5vdWdoIHRvIGFwcGx5DQo+ID4gPiA+ID4gPiA+IHRoZSBwYXRjaC4NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPa2F5LCBMZXQncyBtZSB0cnkg
dG8gZXhwbGFpbiBtb3JlIGRldGFpbHMuDQo+ID4gPiA+ID4gPiBDb250cm9sIEZsb3cgSW50ZWdy
aXR5KENGSSkgaXMgYSBzZWN1cml0eSBtZWNoYW5pc20gdGhhdCBkaXNhbGxvd3MNCj4gPiA+ID4g
PiA+IGNoYW5nZXMgdG8gdGhlIG9yaWdpbmFsIGNvbnRyb2wgZmxvdyBncmFwaCBvZiBhIGNvbXBp
bGVkIGJpbmFyeSwgbWFraW5nDQo+ID4gPiA+ID4gPiBpdCBzaWduaWZpY2FudGx5IGhhcmRlciB0
byBwZXJmb3JtIHN1Y2ggYXR0YWNrcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGVyZSBh
cmUgbXVsdGlwbGUgY29udHJvbCBmbG93IGluc3RydWN0aW9ucyB0aGF0IGNvdWxkIGJlIG1hbmlw
dWxhdGVkDQo+ID4gPiA+ID4gPiBieSB0aGUgYXR0YWNrZXIgYW5kIHN1YnZlcnQgY29udHJvbCBm
bG93LiBUaGUgdGFyZ2V0IGluc3RydWN0aW9ucyB0aGF0DQo+ID4gPiA+ID4gPiB1c2UgZGF0YSB0
byBkZXRlcm1pbmUgdGhlIGFjdHVhbCBkZXN0aW5hdGlvbi4NCj4gPiA+ID4gPiA+IC0gaW5kaXJl
Y3QganVtcA0KPiA+ID4gPiA+ID4gLSBpbmRpcmVjdCBjYWxsDQo+ID4gPiA+ID4gPiAtIHJldHVy
bg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEluIHRoaXMgY2FzZSwgZnVuY3Rpb24gcHJvdG90
eXBlIGJldHdlZW4gY2FsbGVyIGFuZCBjYWxsZWUgYXJlIG1pc21hdGNoLg0KPiA+ID4gPiA+ID4g
Q2FsbGVyOiAodHlwZSBBKWZ1bmNBDQo+ID4gPiA+ID4gPiBDYWxsZWU6ICh0eXBlIEEpZnVuY0IN
Cj4gPiA+ID4gPiA+IENhbGxlZTogKHR5cGUgQylmdW5jQw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IGZ1bmNBIGNhbGxzIGZ1bmNCIC0+IG5vIHByb2JsZW0NCj4gPiA+ID4gPiA+IGZ1bmNBIGNh
bGxzIGZ1bmNDIC0+IENGSSBjaGVjayBmYWlsZWQNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBU
aGF0J3Mgd2h5IHdlIHRyeSB0byBhbGlnbiBmdW5jdGlvbiBwcm90b3R5cGUuDQo+ID4gPiA+ID4g
PiBQbGVhc2UgZmVlbCBmcmVlIHRvIGZlZWRiYWNrIGlmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMu
DQo+ID4gPiA+DQo+ID4gPiA+IEkgdGhpbmsgeW91IHNob3VsZCBpbmNsdWRlIGEgYmV0dGVyIGV4
cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4gUGVyaGFwcyBzb21ldGhp
bmcgbGlrZSB0aGlzPw0KPiA+ID4gPg0KPiA+ID4gPiAgIGluaXRfc3RhdGVfbm9kZSBhc3NpZ25z
IHRoZSBzYW1lIGNhbGxiYWNrIGZ1bmN0aW9uIHRvIGJvdGggZW50ZXIgYW5kDQo+ID4gPiA+ICAg
ZW50ZXJfczJpZGxlIGRlc3BpdGUgbWlzbWF0Y2hpbmcgZnVuY3Rpb24gdHlwZXMsIHdoaWNoIHRy
aXBzIGluZGlyZWN0DQo+ID4gPiA+ICAgY2FsbCBjaGVja2luZyB3aXRoIENvbnRyb2wtRmxvdyBJ
bnRlZ3JpdHkgKENGSSkuDQo+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gQWxpZ24gZnVuY3Rpb24g
cHJvdG90eXBlIG9mIGVudGVyKCkgc2luY2UgaXQgbmVlZHMgcmV0dXJuIHZhbHVlIGZvcg0KPiA+
ID4gPiA+ID4gPiA+IHNvbWUgdXNlIGNhc2VzLiBUaGUgcmV0dXJuIHZhbHVlIG9mIGVudGVyX3My
aWRsZSgpIGlzIG5vDQo+ID4gPiA+ID4gPiA+ID4gbmVlZCBjdXJyZW50bHkuDQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IFNvIGxhc3QgdGltZSBJIHJlcXVlc3RlZCB5b3UgdG8gZG9jdW1l
bnQgd2h5IC0+ZW50ZXJfczJpZGxlIG5lZWRzIHRvDQo+ID4gPiA+ID4gPiA+IHJldHVybiBhbiBp
bnQgaW4gdGhlIGNvZGUsIHdoaWNoIGhhcyBub3QgYmVlbiBkb25lLiAgUGxlYXNlIGRvIHRoYXQu
DQo+ID4gPiA+DQo+ID4gPiA+IFJhZmFlbCwgYXJlIHlvdSBoYXBweSB3aXRoIHRoZSBjb21taXQg
bWVzc2FnZSBkb2N1bWVudGluZyB0aGUgcmVhc29uLA0KPiA+ID4gPiBvciB3b3VsZCB5b3UgcHJl
ZmVyIHRvIGFsc28gYWRkIGEgY29tbWVudCBiZWZvcmUgZW50ZXJfczJpZGxlPw0KPiA+ID4NCj4g
PiA+IEFzIEkgc2FpZCBiZWZvcmUsIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSBhIGNvbW1lbnQg
aW4gdGhlIGNvZGUgYXMNCj4gPiA+IHdlbGwgb3IgcGVvcGxlIHdpbGwgYmUgd29uZGVyaW5nIHdo
eSBpdCBpcyBuZWNlc3NhcnkgdG8gcmV0dXJuDQo+ID4gPiBhbnl0aGluZyBmcm9tIHRoYXQgY2Fs
bGJhY2ssIGJlY2F1c2UgaXRzIHJldHVybiB2YWx1ZSBpcyBuZXZlciB1c2VkLg0KPiA+ID4NCj4g
PiA+IFRoYW5rcyENCj4gPg0KPiA+IElzIGl0IG9rYXkgdG8gYWRkIHRoZXNlIGNvbW1lbnRzIGJl
Zm9yZSBlbnRlcl9zMmlkbGU/DQo+ID4NCj4gPiAvKg0KPiA+ICAqIEFsaWduIGZ1bmN0aW9uIHR5
cGUgc2luY2UgaW5pdF9zdGF0ZV9ub2RlIGFzc2lnbnMgdGhlIHNhbWUgY2FsbGJhY2sNCj4gDQo+
IGluaXRfc3RhdGVfbm9kZSgpDQo+IA0KPiA+ICAqIGZ1bmN0aW9uIHRvIGJvdGggZW50ZXIgYW5k
IGVudGVyX3MyaWRsZSBkZXNwaXRlIG1pc21hdGNoaW5nIGZ1bmN0aW9uDQo+IA0KPiAtPmVudGVy
X3MyaWRsZQ0KPiANCj4gPiAgKiB0eXBlcywgd2hpY2ggdHJpcHMgaW5kaXJlY3QgY2FsbCBjaGVj
a2luZyB3aXRoIENvbnRyb2wtRmxvdyBJbnRlZ3JpdHkNCj4gPiAgKiAoQ0ZJKS4NCj4gPiAgKi8N
Cj4gPiBpbnQgKCplbnRlcl9zMmlkbGUpKHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICBpbnQgaW5kZXgpOw0KPiANCj4gQnV0IElNTyBpdCB3b3VsZCBiZSBz
dWZmaWNpZW50IHRvIGFkZCBzb21ldGhpbmcgbGlrZSB0aGlzIHRvIHRoZQ0KPiBleGlzdGluZyBj
b21tZW50IHJlZ2FyZGluZyAtPmVudGVyX3MyaWRsZToNCj4gDQo+ICJUaGlzIGNhbGxiYWNrIG1h
eSBwb2ludCB0byB0aGUgc2FtZSBmdW5jdGlvbiBhcyAtPmVudGVyIGlmIGFsbCBvZiB0aGUNCj4g
YWJvdmUgcmVxdWlyZW1lbnRzIGFyZSBtZXQgYnkgaXQuIg0KPiANCj4gVGhhdCB3b3VsZCBleHBs
YWluIHdoeSB0aGUgc2lnbmF0dXJlIGlzIHRoZSBzYW1lIHN1ZmZpY2llbnRseSBpbiBteSB2aWV3
Lg0KPiANCj4gVGhhbmtzIQ0KDQpGb3IgY2xhcmlmaWNhdGlvbiwgZG8geW91IG1lYW4gYWRkIHRo
aXMgY29tbWVudCBvbiBlbnRlcl9zMmlkbGUgZnVuY3Rpb24NCnBvaW50ZXIgZGVjbGFyYXRpb24g
aXMgZW5vdWdoPw0KDQo=

