Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5287E3829E6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhEQKg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 06:36:26 -0400
Received: from m13134.mail.163.com ([220.181.13.134]:49708 "EHLO
        m13134.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhEQKgZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 06:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=htUTD
        rKHExNjHJkv6jIxAPGZulZz5Qz90C/UbmzlItU=; b=UWjgYRW8R52eh4WEu0okF
        2cc3XIgLBpIHlJBvORBFabJZQwzkYM3f4TjzF2aoc4F6Sk23uje2XpYQgYbUMVh2
        srzjT+A2PGgovLEPika26wxhC3bkaX3dUIZGCJFHOjSv8Pym+08qPEX1y2+o4Lyd
        CSulMcuy/tPT5u+Ns9NCkA=
Received: from wsj20369$163.com ( [211.94.251.182] ) by
 ajax-webmail-wmsvr134 (Coremail) ; Mon, 17 May 2021 17:48:10 +0800 (CST)
X-Originating-IP: [211.94.251.182]
Date:   Mon, 17 May 2021 17:48:10 +0800 (CST)
From:   wsj20369 <wsj20369@163.com>
To:     "Zhang Rui" <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Box" <david.e.box@linux.intel.com>
Subject: Re:Re: [PATCH] Revert "ACPI: power: Turn off unused power resources
 unconditionally"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <bd4d1d94a4497a4c7407ede70eeae566ac343f23.camel@intel.com>
References: <20210430124224.6383-1-wsj20369@163.com>
 <0e480ceabe4d42d79bf49a1989c0f95f@intel.com>
 <CAJZ5v0i8RnOg2HgEmLze7d3rYvofVDFDQORMOigNc0vEhLW16Q@mail.gmail.com>
 <bd4d1d94a4497a4c7407ede70eeae566ac343f23.camel@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4762460c.5c81.17979b9cc3b.Coremail.wsj20369@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hsGowACXn2PaO6Jg+oTjAA--.54537W
X-CM-SenderInfo: hzvmjiqtwzqiywtou0bp/xtbB0gKVF1UMbkpOAgABsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

QXQgMjAyMS0wNS0xMCAyMTo1OTowMywgIlpoYW5nIFJ1aSIgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
IHdyb3RlOgo+T24gTW9uLCAyMDIxLTA1LTEwIGF0IDE0OjEzICswMjAwLCBSYWZhZWwgSi4gV3lz
b2NraSB3cm90ZToKPj4gT24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgODozNyBBTSBaaGFuZywgUnVp
IDxydWkuemhhbmdAaW50ZWwuY29tPgo+PiB3cm90ZToKPj4gPiAKPj4gPiBIaSwgU2h1anVuLAo+
PiA+IAo+PiA+IEknbSBleHBlcmllbmNpbmcgc2ltaWxhciBwcm9ibGVtLCBhbmQgaXQgc2hvdWxk
IGJlIGEgQklPUyBwcm9ibGVtLAo+PiAKPj4gUmlnaHQsIGFuZCBJIGNvbmZ1c2VkIHRoaW5ncy4g
IFNvcnJ5IGFib3V0IHRoYXQuCj4+IAo+PiBJZiBjb21taXQgN2U0ZmRlYWZhNjFmMmI2NTNmICgi
QUNQSTogcG93ZXI6IFR1cm4gb2ZmIHVudXNlZCBwb3dlcgo+PiByZXNvdXJjZXMgdW5jb25kaXRp
b25hbGx5IikgY2F1c2VzIHByb2JsZW1zIHRvIGhhcHBlbiwgdGhpcyBtZWFucwo+PiB0aGF0Cj4+
IHRoZSBwbGF0Zm9ybSBmaXJtd2FyZSBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0IGZvbGxvdyB0aGUg
QUNQSQo+PiBzcGVjaWZpY2F0aW9uLgo+PiAKPj4gPiB3aGljaCBjYW4gYmUgZml4ZWQgYnkgYSBj
dXN0b21pemVkIERTRFQuCj4+ID4gQ2FuIHlvdSBwbGVhc2UgYXR0YWNoIHRoZSBmdWxsIGFjcGlk
dW1wIG91dHB1dCBvbiB0aGlzIG1hY2hpbmU/IEkKPj4gPiBqdXN0IHdhbnQgdG8gbWFrZSBzdXJl
IGlmIGl0IGlzIHRoZSBzYW1lIHByb2JsZW0uCj4+IAo+PiBZZXMsIHBsZWFzZS4KPj4gCj4+IFJ1
aSwgY2FuIHlvdSBjcmVhdGUgYSBCWiBmb3IgdGhpcyBwbGVhc2UgYW5kIGNhbiB5b3UgYm90aCBh
dHRhY2gKPj4gZG1pZGVjb2RlIG91dHB1dCBmcm9tIHRoZSBhZmZlY3RlZCBzeXN0ZW1zPwo+PiAK
Pj4gSSBkb24ndCB3YW50IHRvIHJldmVydCB0aGlzIGNvbW1pdCBjb21wbGV0ZWx5LCBzbyB0aGUg
ZGVmYXVsdAo+PiBiZWhhdmlvcgo+PiBpcyBzcGVjLWNvbXBsaWFudCwgYnV0IHRoZXJlIGNhbiBi
ZSBhIERNSS1iYXNlZCBibGFja2xpc3QgZm9yIHN5c3RlbXMKPj4gaGF2aW5nIHByb2JsZW1zIHdp
dGggaXQuCj4+IAo+RG9uZS4KPmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjEzMDE5Cj4KPlNodWp1biwKPmNhbiB5b3UgcGxlYXNlIGF0dGFjaCB0aGUgYWNwaWR1
bXAgYW5kIGRtaWRlY29kZSBvdXRwdXQgaW4gdGhpcyBidWcKPnJlcG9ydD8KPgo+dGhhbmtzLAo+
cnVpCgpIaSBSdWk6CgpTb3JyeSBmb3IgbGF0ZSwgSSBoYXZlIGF0dGFjaGVkIHRoZSBhY3BpZHVt
cCBhbmQgZG1pZGVjb2RlIGluIHRoZSBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTIxMzAxOQoKQlIKU2h1anVuIFdhbmcKCj4KPj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tCj4+ID4gPiBGcm9tOiBTaHVqdW4gV2FuZyA8d3NqMjAzNjlAMTYzLmNvbT4K
Pj4gPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMzAsIDIwMjEgODo0MiBQTQo+PiA+ID4gVG86IHJq
d0Byand5c29ja2kubmV0OyBsZW5iQGtlcm5lbC5vcmc7IAo+PiA+ID4gbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQo+PiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZwo+PiA+ID4g
Q2M6IFNodWp1biBXYW5nIDx3c2oyMDM2OUAxNjMuY29tPgo+PiA+ID4gU3ViamVjdDogW1BBVENI
XSBSZXZlcnQgIkFDUEk6IHBvd2VyOiBUdXJuIG9mZiB1bnVzZWQgcG93ZXIKPj4gPiA+IHJlc291
cmNlcwo+PiA+ID4gdW5jb25kaXRpb25hbGx5Igo+PiA+ID4gCj4+ID4gPiBUaGlzIHJldmVydHMg
Y29tbWl0IDdlNGZkZWFmYTYxZjJiNjUzZmNmOTY3OGYwOTkzNWU1NTc1NmFlZDIuCj4+ID4gPiBJ
dCBtYXkgY2F1c2Ugc29tZSBOVk1lIGRldmljZSBwcm9iZXMgdG8gZmFpbCwgYW5kIHRoZSBzeXN0
ZW0gbWF5Cj4+ID4gPiBnZXQgc3R1Y2sKPj4gPiA+IHdoZW4gdXNpbmcgYW4gTlZNZSBkZXZpY2Ug
YXMgdGhlIHJvb3QgZmlsZXN5c3RlbS4KPj4gPiA+IAo+PiA+ID4gSW4gdGhlIGZ1bmN0aW9uIG52
bWVfcGNpX2VuYWJsZShzdHJ1Y3QgbnZtZV9kZXYgKmRldiksIGFzIHNob3duCj4+ID4gPiBiZWxv
dywKPj4gPiA+IHJlYWRsKE5WTUVfUkVHX0NTVFMpIGFsd2F5cyByZXR1cm5zIC0xIHdpdGggdGhl
IGNvbW1pdCwgd2hpY2gKPj4gPiA+IHJlc3VsdHMgaW4KPj4gPiA+IHRoZSBwcm9iZSBmYWlsZWQu
Cj4+ID4gPiAKPj4gPiA+ICAgaWYgKHJlYWRsKGRldi0+YmFyICsgTlZNRV9SRUdfQ1NUUykgPT0g
LTEpIHsKPj4gPiA+ICAgICAgIHJlc3VsdCA9IC1FTk9ERVY7Cj4+ID4gPiAgICAgICBnb3RvIGRp
c2FibGU7Cj4+ID4gPiAgIH0KPj4gPiA+IAo+PiA+ID4gZG1lc2c6Cj4+ID4gPiAgIFsgICAgMS4x
MDYyODBdIG52bWUgMDAwMDowNDowMC4wOiBwbGF0Zm9ybSBxdWlyazogc2V0dGluZwo+PiA+ID4g
c2ltcGxlIHN1c3BlbmQKPj4gPiA+ICAgWyAgICAxLjEwOTExMV0gbnZtZSBudm1lMDogcGNpIGZ1
bmN0aW9uIDAwMDA6MDQ6MDAuMAo+PiA+ID4gICBbICAgIDEuMTEzMDY2XSBudm1lIDAwMDA6MDQ6
MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+Cj4+ID4gPiAwMDAyKQo+PiA+ID4gICBbICAg
IDEuMTIxMDQwXSBudm1lIG52bWUwOiBSZW1vdmluZyBhZnRlciBwcm9iZSBmYWlsdXJlIHN0YXR1
czoKPj4gPiA+IC0xOQo+PiA+ID4gCj4+ID4gPiBsc3BjaToKPj4gPiA+ICAgTm9uLVZvbGF0aWxl
IG1lbW9yeSBjb250cm9sbGVyOiBLSU9YSUEgQ29ycG9yYXRpb24gRGV2aWNlIDAwMDEKPj4gPiA+
IAo+PiA+ID4gZGV2aWNlIHVldmVudDoKPj4gPiA+ICAgRFJJVkVSPW52bWUKPj4gPiA+ICAgUENJ
X0NMQVNTPTEwODAyCj4+ID4gPiAgIFBDSV9JRD0xRTBGOjAwMDEKPj4gPiA+ICAgUENJX1NVQlNZ
U19JRD0xRTBGOjAwMDEKPj4gPiA+ICAgUENJX1NMT1RfTkFNRT0wMDAwOjA0OjAwLjAKPj4gPiA+
ICAgTU9EQUxJQVM9cGNpOnYwMDAwMUUwRmQwMDAwMDAwMXN2MDAwMDFFMEZzZDAwMDAwMDAxYmMw
MXNjMDhpMDIKPj4gPiA+IAo+PiA+ID4gVGhpcyBwYXRjaCB3YXMgdGVzdGVkIGluIExlbm92byBU
aGlua3BhZCBYMS4KPj4gPiA+IAo+PiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1anVuIFdhbmcgPHdz
ajIwMzY5QDE2My5jb20+Cj4+ID4gPiAtLS0KPj4gPiA+ICBkcml2ZXJzL2FjcGkvcG93ZXIuYyB8
IDExICsrKysrKysrKystCj4+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4gPiA+IAo+PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9w
b3dlci5jIGIvZHJpdmVycy9hY3BpL3Bvd2VyLmMgaW5kZXgKPj4gPiA+IDU2MTAyZWFhYTJkYS4u
OGJmMTBhYmViMmUwIDEwMDY0NAo+PiA+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3Bvd2VyLmMKPj4g
PiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9wb3dlci5jCj4+ID4gPiBAQCAtMTAwNCw5ICsxMDA0LDE4
IEBAIHZvaWQKPj4gPiA+IGFjcGlfdHVybl9vZmZfdW51c2VkX3Bvd2VyX3Jlc291cmNlcyh2b2lk
KQo+PiA+ID4gICAgICAgbXV0ZXhfbG9jaygmcG93ZXJfcmVzb3VyY2VfbGlzdF9sb2NrKTsKPj4g
PiA+IAo+PiA+ID4gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9yZXZlcnNlKHJlc291cmNlLAo+
PiA+ID4gJmFjcGlfcG93ZXJfcmVzb3VyY2VfbGlzdCwKPj4gPiA+IGxpc3Rfbm9kZSkgewo+PiA+
ID4gKyAgICAgICAgICAgICBpbnQgcmVzdWx0LCBzdGF0ZTsKPj4gPiA+ICsKPj4gPiA+ICAgICAg
ICAgICAgICAgbXV0ZXhfbG9jaygmcmVzb3VyY2UtPnJlc291cmNlX2xvY2spOwo+PiA+ID4gCj4+
ID4gPiAtICAgICAgICAgICAgIGlmICghcmVzb3VyY2UtPnJlZl9jb3VudCkgewo+PiA+ID4gKyAg
ICAgICAgICAgICByZXN1bHQgPSBhY3BpX3Bvd2VyX2dldF9zdGF0ZShyZXNvdXJjZS0KPj4gPiA+
ID5kZXZpY2UuaGFuZGxlLAo+PiA+ID4gJnN0YXRlKTsKPj4gPiA+ICsgICAgICAgICAgICAgaWYg
KHJlc3VsdCkgewo+PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmcmVz
b3VyY2UtPnJlc291cmNlX2xvY2spOwo+PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOwo+PiA+ID4gKyAgICAgICAgICAgICB9Cj4+ID4gPiArCj4+ID4gPiArICAgICAgICAgICAg
IGlmIChzdGF0ZSA9PSBBQ1BJX1BPV0VSX1JFU09VUkNFX1NUQVRFX09OCj4+ID4gPiArICAgICAg
ICAgICAgICAgICAmJiAhcmVzb3VyY2UtPnJlZl9jb3VudCkgewo+PiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgIGRldl9pbmZvKCZyZXNvdXJjZS0+ZGV2aWNlLmRldiwgIlR1cm5pbmcKPj4gPiA+
IE9GRlxuIik7Cj4+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgX19hY3BpX3Bvd2VyX29mZihy
ZXNvdXJjZSk7Cj4+ID4gPiAgICAgICAgICAgICAgIH0KPj4gPiA+IC0tCj4+ID4gPiAyLjI1LjEK

