Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159548E920
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfHOKi3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 06:38:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfHOKi3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Aug 2019 06:38:29 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 70EE84512D7F81ED1EA0;
        Thu, 15 Aug 2019 11:38:27 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.44]) by
 LHREML710-CAH.china.huawei.com ([10.201.108.33]) with mapi id 14.03.0415.000;
 Thu, 15 Aug 2019 11:38:18 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     Vijaya Kumar K <vkilari@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tomasz Nowicki <Tomasz.Nowicki@cavium.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        Richard Ruigrok <rruigrok@qti.qualcomm.com>,
        "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Subject: RE: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Topic: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Index: AdUoR6JBXCmGfD+rTvOGseVrKJ7QIACYz8KAAbik43ADLDuVgAVDqs8g
Date:   Thu, 15 Aug 2019 10:38:18 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F370753@lhreml524-mbs.china.huawei.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
 <d3341796-d7ce-8b1b-3575-333eda7e6d07@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83F2DBB39@lhreml524-mbs.china.huawei.com>
 <6b863739-fc6d-424c-6b70-21e2e3775b78@arm.com>
In-Reply-To: <6b863739-fc6d-424c-6b70-21e2e3775b78@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgSmFtZXMsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuIEl0IHRvb2sgYSB3aGlsZSB0byBnZXQg
YmFjayBpbnRvIHRoaXMuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
SmFtZXMgTW9yc2UgW21haWx0bzpqYW1lcy5tb3JzZUBhcm0uY29tXQ0KPiBTZW50OiAxOSBKdWx5
IDIwMTkgMTY6MzANCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGku
a29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IFZpamF5YSBLdW1hciBLIDx2a2lsYXJp
QGNvZGVhdXJvcmEub3JnPjsgTG9yZW56byBQaWVyYWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20+OyBUb21hc3ogTm93aWNraQ0KPiA8VG9tYXN6Lk5vd2lja2lAY2F2aXVtLmNvbT47
IEplZmZyZXkgSHVnbyA8amh1Z29AY29kZWF1cm9yYS5vcmc+Ow0KPiBHdW9oYW5qdW4gKEhhbmp1
biBHdW8pIDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3
ZWkuY29tPjsgSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRvbkBhcm0uY29tPjsNCj4gbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgU3VkZWVwIEhvbGxhDQo+IDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IHdhbmd4aW9uZ2Zlbmcg
KEMpDQo+IDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgUmljaGFyZCBSdWlncm9rDQo+IDxy
cnVpZ3Jva0BxdGkucXVhbGNvbW0uY29tPg0KPiBTdWJqZWN0OiBSZTogTVBBTSBicmFuY2ggdmVy
aWZpY2F0aW9uICh3YXMgUkU6IFtSRkMgUEFUQ0ggMi8yXSBBQ1BJIC8gUFBUVDoNCj4gY2FjaGVp
bmZvOiBMYWJlbCBjYWNoZXMgYmFzZWQgb24gZndfdG9rZW4pDQo+IA0KPiBIaSBTaGFtZWVyLA0K
PiANCj4gT24gMDMvMDcvMjAxOSAxMzoyNywgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90
ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gT24gMjEvMDYvMjAxOSAx
Njo1NywgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEphbWVzIE1vcnNlIFttYWlsdG86amFtZXMu
bW9yc2VAYXJtLmNvbV0NCj4gDQo+ID4+IFRoZSBkb21pZCBiaXRmaWVsZCBub3QgYmVpbmcgYmln
IGVub3VnaCBmb3IgdGhlIHdpZHRoIG9mIHRoZSBjYWNoZWluZm8gaWQgZmllbGQNCj4gPj4gbG9v
a3MgbGlrZQ0KPiA+PiBhIGJ1ZyBpbiB0aGUgZXhpc3RpbmcgcmVzY3RybCBjb2RlLiBDb3VsZCB5
b3Ugc3BpbiB0aGF0IGFzIGEgcGF0Y2ggYWdhaW5zdA0KPiA+PiBtYWlubGluZT8NCj4gPg0KPiA+
IFllcyBpdCBjb3VsZCBiZSBhIGJ1Zy4gQnV0IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhlIGFzc3Vt
cHRpb24gb24geDg2DQo+IHBsYXRmb3JtcyB3aXRoDQo+ID4gcmVzcGVjdCB0byBjYWNoZSBpZCB3
aWR0aC4gQWxzbyBhbnkgbmVlZCB0byBjb25zaWRlciAzMiBiaXQgc3lzdGVtcyBhdCBhbGwgb3IN
Cj4gbm90Lg0KPiA+DQo+ID4+IEl0IHdvbid0IGFmZmVjdCBhbnkgeDg2IHN5c3RlbSwgYnV0IEkg
ZG9uJ3Qgd2FudCB0byAnZml4JyBhbnl0aGluZyBhcyBwYXJ0IG9mDQo+IHRoZQ0KPiA+PiBtcGFt
DQo+ID4+IHN1cHBvcnQuDQo+ID4NCj4gPiBEb2VzIHRoYXQgbWVhbiB0aGUgY2FjaGUgaWQgd2lk
dGggb24geDg2IHdpbGwgbmV2ZXIgYmUgPjE0IGJpdHM/DQo+IA0KPiBJIGhhdmUgbm8gaWRlYS4g
VG9kYXkgdGhleSdyZSAwLDEsMiwgc28gaXRzIHVubGlrZWx5PywgYnV0DQo+IERvY3VtZW50YXRp
b24veDg2L3Jlc2N0cmwucnN0J3MNCj4gIkNhY2hlIElEcyIgc2VjdGlvbiBzYXlzICJpdCBpc24n
dCBndWFyYW50ZWVkIHRvIGJlIGEgY29udGlndW91cyBzZXF1ZW5jZSIsIHNvDQo+IG1heWJlPw0K
PiANCj4gVGhlIHByb2JsZW0gaXMgJ3N0cnVjdCBjYWNoZWluZm8ncyBpZCBmaWVsZCBpcyBhbiBp
bnQsIGl0cyBleHBvc2VkIHZpYSBzeXNmcyBhcyBhbg0KPiBpbnQsDQo+IGJ1dCByZXNjdHJsIHBh
Y2tzIGl0IGludG8gYSBzbWFsbGVyIHNpemUuIFRoYXQncyBnb2luZyB0byBiaXRlIG9uZSBkYXks
IGl0IHdvdWxkIGJlDQo+IGdvb2QNCj4gdG8gZml4IGl0IG5vdyB3ZSBrbm93IGl0cyBhIHByb2Js
ZW0uDQo+IA0KPiANCj4gPj4gV2UgYWxtb3N0IGNlcnRhaW5seSBuZWVkIHRvIGNvbXByZXNzIHRo
ZSBjYWNoZS1pZCBudW1iZXJzIGRvd24gdG8gezAsMSwyfQ0KPiBpZg0KPiA+PiBvbmx5IHNvIHdl
DQo+ID4+IGhhdmVuJ3QgZmlsbGVkIGFsbCB0aGUgZXhwb3NlZCBiaXRzIG9uIGRheS0xLiAoc28g
aXQgbWlnaHQgbm90IG1hdHRlciBmb3IgYXJtNjQNCj4gPj4gZWl0aGVyLi4uKQ0KPiA+DQo+ID4g
VGhhdCB3aWxsIGJlIG5pY2UgaWYgd2UgY2FuIGNvbXByZXNzIGl0IGxpa2UgdGhhdD4gSSB0aGlu
ayB3ZSBjYW4gbGVhdmUgdGhlIGZpeA0KPiBmb3Igbm93DQo+ID4gYW5kIGNvbWUgdXAgd2l0aCBh
IHNvbHV0aW9uIHdoZW4gdGhpbmdzIGdldHMgcmVhbGx5IGdvaW5nLg0KPiA+DQo+ID4gTWVhbiB0
aW1lIEkgYW0gdHJ5aW5nIHRvIHByb2JlIG1lbW9yeSBjb250cm9sbGVyIGFzIHdlbGwgb24gb3Vy
IHN5c3RlbSBhbmQNCj4gaXQgbG9va3MNCj4gPiBsaWtlIHRoZXJlIGFyZSBzdGlsbCBpc3N1ZXMu
DQo+IA0KPiBUeXBvIGluIHRoZSBNQkEgcGlja2luZyBjb2RlPyBTaG91bGQgYmU6DQo+IHwgaWYg
KCFtcGFtX2hhc19mZWF0dXJlKG1wYW1fZmVhdF9tYndfcGFydCwgY2xhc3MtPmZlYXR1cmVzKSAm
Jg0KPiB8ICAgICAhbXBhbV9oYXNfZmVhdHVyZShtcGFtX2ZlYXRfbWJ3X21heCwgY2xhc3MtPmZl
YXR1cmVzKSkgew0KPiANCj4gSXQgY2FuIGRvIHNvbWV0aGluZyB1c2VmdWwgd2l0aCBlaXRoZXIg
b2YgdGhvc2UgZmVhdHVyZXMsIGJ1dCB0aGUgKCFwYXJ0IHx8ICFtYXgpDQo+IHByZXZpb3VzbHkg
Zm9yY2VkIGl0IHRvIGhhdmUgYm90aC4NCj4gDQo+IChUaGlzIHN0aWxsIGRvZXNuJ3Qgd29yayBv
biB0aGUgbW9kZWwgYXMgaXRzIGRlc2NyaWJpbmcgYSAwLWJpdCBiaXRtYXANCj4gTUJXX1BBUlQp
DQoNCkkgdGhpbmsgd2hhdCBoYXBwZW5zIG9uIG91ciBoYXJkd2FyZSBpcywgdGhlIE1CQSByZXBv
cnRzIFBNR19NQVggPSAwIGFuZCB0aGF0DQp1cHNldHMgbXBhbV9wbWdfYml0cygpIC0tPmlsb2cy
KCkuIEkgYW0gbm90IGVudGlyZWx5IHN1cmUgd2hldGhlciBQTUdfTUFYPSAwIGlzDQphbGxvd2Vk
IGFzIHBlciBzcGVjIHdoZW4gdGhlIHJlc291cmNlIHJlcG9ydHMgSEFTX01TTU9OID0xLiBCdXQg
aGFzbid0IGZvdW5kDQphbnl0aGluZyBpbiBzcGVjIHRoYXQgZm9yYmlkcyB0aGlzIGFzIHRoZSBm
aWx0ZXIgaXMgYSBjb21iaW5hdGlvbiBvZiBQUkFUSUQ6UE1HLg0KDQpJIGhhdmUgYSB0ZW1wIGhh
Y2sgaGVyZSB0byBrZWVwIGl0IGdvaW5nLA0KDQpodHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29u
L2tlcm5lbC1kZXYvY29tbWl0LzVlMDg4MWM0Y2RkZWQ0MDY2ZGZhYzc2MDNjNTMyNDIzODU0MTdh
M2ENCiANCj4gDQo+ID4gSSB3aWxsIGRlYnVnIGFuZCB1cGRhdGUgaWYgaXQgcmVhbGx5IGlzIGEg
cHJvYmxlbS4gUGxlYXNlDQo+ID4gbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHBsYW5zIHRv
IHVwZGF0ZSB0aGUgYnJhbmNoIHNvIHRoYXQgSSBjYW4gdHJ5IHRoZQ0KPiBsYXRlc3QuDQo+IA0K
PiBJIGhvcGUgdG8gcHVzaCBhIG5ldyB2ZXJzaW9uIGJ5IHRoZSBlbmQgb2YgSnVuZS4gKHdob29z
aCEgVGhlcmUgZ29lcyBKdW5lKS4NCj4gaHR0cDovL3d3dy5saW51eC1hcm0ub3JnL2dpdD9wPWxp
bnV4LWptLmdpdDthPXNob3J0bG9nO2g9cmVmcy9oZWFkcy9tcGFtL3MNCj4gbmFwc2hvdC9qdW4N
Cg0KVGhhbmtzIGZvciB0aGF0LiBJIGFtIHVzaW5nIHRoaXMgbm93LiAoQW5kIEkgc2VlIGEgbW9y
ZSByZWNlbnQgb25lIG1wYW0vNS4zLXRtcA0Kbm93LiBIYXMgYW55dGhpbmcgY2hhbmdlZCBvdGhl
ciB0aGFuIHJlYmFzZT8pDQoNCj4NCj4gVGhlIGNoYW5nZXMgaW4gdGhlcmUgYXJlIHRvIGF2b2lk
IHRoZSBrbm93bi1pc3N1ZXMgd2hlbiB0aGUgc2FtZSAndGhpbmcnIGlzDQo+IHBpY2tlZCBhcyBi
b3RoDQo+IEwzIHJlc291cmNlIGFuZCB0aGUgTUJBIHJlc291cmNlLg0KDQpOb3cgd2l0aCB0aGUg
YWJvdmUgZml4IGZvciBQTUdfTUFYPTAsIEkgYW0gaGl0dGluZyBhbm90aGVyIGlzc3VlLg0KbW91
bnQgLXQgcmVzY3RybCByZXNjdHJsIC9zeXMvZnMvcmVzY3RybCBmYWlscyB3aXRoICJGaWxlIGV4
aXN0cyIgZXJyb3IuDQoNCkRlYnVnZ2luZyBwb2ludHMgdG8sDQpyZHRfZ2V0X3RyZWUoKSANCiAg
bWtkaXJfbW9uZGF0YV9hbGwoKQ0KICAgIG1rZGlyX21vbmRhdGFfc3ViZGlyX2FsbGRvbSgpDQog
ICAgICBta2Rpcl9tb25kYXRhX3N1YmRpcigpIA0KICAgICAgICBtb25fYWRkZmlsZSgpDQoNCkl0
IGxvb2tzIGxpa2Ugci0+ZXZ0X2xpc3QgZ2V0cyBjb3JydXB0ZWQgc29tZWhvdyBhbmQgaGFzIGR1
cGxpY2F0ZSBlbnRyaWVzLiBJIGhhdmVu4oCZdA0KZ29uZSBpbnRvIHRoZSBib3R0b20gb2YgdGhp
cyBpc3N1ZSwgYnV0IHBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgaWRlYS4NCg0K
Q2hlZXJzLA0KU2hhbWVlcg0KDQo+IEkgdGhpbmsgdGhlIHJpc2sgb2Ygc2xlZXBpbmctd2hpbGUt
YXRvbWljIGlmIG5vdCBhbGwgbXBhbTpkZXZpY2VzIGFyZSBhY2Nlc3NpYmxlDQo+IGZyb20gYWxs
DQo+IENQVXMgaW4gdGhlIHJlc2N0cmw6ZG9tYWluIGlzIG15IG5leHQgaGlnaGVzdCBwcmlvcml0
eSBpc3N1ZS4uLg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVzDQo=
