Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83575222BD1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jul 2020 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgGPTWh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jul 2020 15:22:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:45361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGPTWd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Jul 2020 15:22:33 -0400
IronPort-SDR: vuLOwG2c9CV4RTvmahLiRteriNnTrLzj9qimqKWB06PaJJHs653bWr8iiV8fDqdnLp0OyOPKEO
 R02d11+Ta05A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="211019346"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="211019346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 12:22:32 -0700
IronPort-SDR: sgWxlqjo1o6M17PeT2mAk1npmR0Kl1zMweC45j6CMnKH9JT+PJF2Rv8sb2dKMXOqY+CIftrs+L
 90QbTPTpNyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="269337770"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2020 12:22:31 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.226]) with mapi id 14.03.0439.000;
 Thu, 16 Jul 2020 12:22:30 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Thread-Topic: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Thread-Index: AQHWTjNF6NPdlNtf4Ea9cCuLXaianakLJdUA
Date:   Thu, 16 Jul 2020 19:22:30 +0000
Message-ID: <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
         <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
         <1794490.F2OrUDcHQn@kreacher>
In-Reply-To: <1794490.F2OrUDcHQn@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1158D79CC86D694ABE0899C328498051@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE4OjMzICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+DQo+IA0KPiBUaGUgQUNQSUNBJ3Mgc3RyYXRlZ3kgd2l0aCByZXNwZWN0IHRvIHRoZSBoYW5k
bGluZyBvZiBtZW1vcnkgbWFwcGluZ3MNCj4gYXNzb2NpYXRlZCB3aXRoIG1lbW9yeSBvcGVyYXRp
b24gcmVnaW9ucyBpcyB0byBhdm9pZCBtYXBwaW5nIHRoZQ0KPiBlbnRpcmUgcmVnaW9uIGF0IG9u
Y2Ugd2hpY2ggbWF5IGJlIHByb2JsZW1hdGljIGF0IGxlYXN0IGluIHByaW5jaXBsZQ0KPiAoZm9y
IGV4YW1wbGUsIGl0IG1heSBsZWFkIHRvIGNvbmZsaWN0cyB3aXRoIG92ZXJsYXBwaW5nIG1hcHBp
bmdzDQo+IGhhdmluZyBkaWZmZXJlbnQgYXR0cmlidXRlcyBjcmVhdGVkIGJ5IGRyaXZlcnMpLiAg
SXQgbWF5IGFsc28gYmUNCj4gd2FzdGVmdWwsIGJlY2F1c2UgbWVtb3J5IG9wcmVnaW9ucyBvbiBz
b21lIHN5c3RlbXMgdGFrZSB1cCB2YXN0DQo+IGNodW5rcyBvZiBhZGRyZXNzIHNwYWNlIHdoaWxl
IHRoZSBmaWVsZHMgaW4gdGhvc2UgcmVnaW9ucyBhY3R1YWxseQ0KPiBhY2Nlc3NlZCBieSBBTUwg
YXJlIHNwYXJzZWx5IGRpc3RyaWJ1dGVkLg0KPiANCj4gRm9yIHRoaXMgcmVhc29uLCBhIG9uZS1w
YWdlICJ3aW5kb3ciIGlzIG1hcHBlZCBmb3IgYSBnaXZlbiBvcHJlZ2lvbg0KPiBvbiB0aGUgZmly
c3QgbWVtb3J5IGFjY2VzcyB0aHJvdWdoIGl0IGFuZCBpZiB0aGF0ICJ3aW5kb3ciIGRvZXMgbm90
DQo+IGNvdmVyIGFuIGFkZHJlc3MgcmFuZ2UgYWNjZXNzZWQgdGhyb3VnaCB0aGF0IG9wcmVnaW9u
IHN1YnNlcXVlbnRseSwNCj4gaXQgaXMgdW5tYXBwZWQgYW5kIGEgbmV3ICJ3aW5kb3ciIGlzIG1h
cHBlZCB0byByZXBsYWNlIGl0LiAgTmV4dCwNCj4gaWYgdGhlIG5ldyAid2luZG93IiBpcyBub3Qg
c3VmZmljaWVudCB0byBhY2VzcyBtZW1vcnkgdGhyb3VnaCB0aGUNCj4gb3ByZWdpb24gaW4gcXVl
c3Rpb24gaW4gdGhlIGZ1dHVyZSwgaXQgd2lsbCBiZSByZXBsYWNlZCB3aXRoIHlldA0KPiBhbm90
aGVyICJ3aW5kb3ciIGFuZCBzbyBvbi4gIFRoYXQgbWF5IGxlYWQgdG8gYSBzdWJvcHRpbWFsIHNl
cXVlbmNlDQo+IG9mIG1lbW9yeSBtYXBwaW5nIGFuZCB1bm1hcHBpbmcgb3BlcmF0aW9ucywgZm9y
IGV4YW1wbGUgaWYgdHdvIGZpZWxkcw0KPiBpbiBvbmUgb3ByZWdpb24gc2VwYXJhdGVkIGZyb20g
ZWFjaCBvdGhlciBieSBhIHN1ZmZpY2llbnRseSB3aWRlDQo+IGNodW5rIG9mIHVudXNlZCBhZGRy
ZXNzIHNwYWNlIGFyZSBhY2Nlc3NlZCBpbiBhbiBhbHRlcm5hdGluZyBwYXR0ZXJuLg0KPiANCj4g
VGhlIHNpdHVhdGlvbiBtYXkgc3RpbGwgYmUgc3Vib3B0aW1hbCBpZiB0aGUgZGVmZXJyZWQgdW5t
YXBwaW5nDQo+IGludHJvZHVjZWQgcHJldmlvdXNseSBpcyBzdXBwb3J0ZWQgYnkgdGhlIE9TIGxh
eWVyLiAgRm9yIGluc3RhbmNlLA0KPiB0aGUgYWx0ZXJuYXRpbmcgbWVtb3J5IGFjY2VzcyBwYXR0
ZXJuIG1lbnRpb25lZCBhYm92ZSBtYXkgcHJvZHVjZQ0KPiBhIHJlbGF0aXZlbHkgbG9uZyBsaXN0
IG9mIG1hcHBpbmdzIHRvIHJlbGVhc2Ugd2l0aCBzdWJzdGFudGlhbA0KPiBkdXBsaWNhdGlvbiBh
bW9uZyB0aGUgZW50cmllcyBpbiBpdCwgd2hpY2ggY291bGQgYmUgYXZvaWRlZCBpZg0KPiBhY3Bp
X2V4X3N5c3RlbV9tZW1vcnlfc3BhY2VfaGFuZGxlcigpIGRpZCBub3QgcmVsZWFzZSB0aGUgbWFw
cGluZw0KPiB1c2VkIGJ5IGl0IHByZXZpb3VzbHkgYXMgc29vbiBhcyB0aGUgY3VycmVudCBhY2Nl
c3Mgd2FzIG5vdCBjb3ZlcmVkDQo+IGJ5IGl0Lg0KPiANCj4gSW4gb3JkZXIgdG8gaW1wcm92ZSB0
aGF0LCBtb2RpZnkgYWNwaV9leF9zeXN0ZW1fbWVtb3J5X3NwYWNlX2hhbmRsZXIoKQ0KPiB0byBw
cmVzZXJ2ZSBhbGwgb2YgdGhlIG1lbW9yeSBtYXBwaW5ncyBjcmVhdGVkIGJ5IGl0IHVudGlsIHRo
ZSBtZW1vcnkNCj4gcmVnaW9ucyBhc3NvY2lhdGVkIHdpdGggdGhlbSBnbyBhd2F5Lg0KPiANCj4g
QWNjb3JkaW5nbHksIHVwZGF0ZSBhY3BpX2V2X3N5c3RlbV9tZW1vcnlfcmVnaW9uX3NldHVwKCkg
dG8gdW5tYXAgYWxsDQo+IG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggbWVtb3J5IG9wcmVnaW9ucyB0
aGF0IGdvIGF3YXkuDQo+IA0KPiBSZXBvcnRlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL2V2
cmduaW5pLmMgfCAxNCArKysrLS0tLQ0KPiAgZHJpdmVycy9hY3BpL2FjcGljYS9leHJlZ2lvbi5j
IHwgNjUgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9hY3Bp
L2FjdHlwZXMuaCAgICAgICAgIHwgMTIgKysrKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2NCBp
bnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQoNCkhpIFJhZmFlbCwNCg0KUGlja2lu
ZyB1cCBmcm9tIERhbiB3aGlsZSBoZSdzIG91dCAtIEkgaGFkIHRoZXNlIHBhdGNoZXMgdGVzdGVk
IGJ5IHRoZQ0Kb3JpZ2luYWwgcmVwb3J0ZXIsIGFuZCB0aGV5IHdvcmsgZmluZS4gSSBzZWUgeW91
IGhhZCB0aGVtIHN0YWdlZCBpbiB0aGUNCmFjcGljYS1vc2wgYnJhbmNoLiBJcyB0aGF0IHNsYXRl
ZCB0byBnbyBpbiBkdXJpbmcgdGhlIDUuOSBtZXJnZSB3aW5kb3c/DQoNCllvdSBjYW4gYWRkOg0K
VGVzdGVkLWJ5OiBYaWFuZyBMaSA8eGlhbmcuei5saUBpbnRlbC5jb20+DQo=
