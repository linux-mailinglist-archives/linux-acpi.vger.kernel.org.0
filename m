Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F28152176
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2020 21:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBDU0J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Feb 2020 15:26:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:29662 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDU0I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Feb 2020 15:26:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 12:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="249465172"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2020 12:26:08 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.111]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.147]) with mapi id 14.03.0439.000;
 Tue, 4 Feb 2020 12:26:08 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Hanjun Guo <guohanjun@huawei.com>, Jean Delvare <jdelvare@suse.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: Note about acpi_get_table_header
Thread-Topic: Note about acpi_get_table_header
Thread-Index: AQHV2zvloyZ/xj6GCkWRNLokcE58cagLVMSAgAAnUFA=
Date:   Tue, 4 Feb 2020 20:26:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96D90D1@ORSMSX110.amr.corp.intel.com>
References: <20200204101707.30eaa5bb@endymion>
 <150c32b4-d00c-5508-b16b-e7856e0cb09a@huawei.com>
In-Reply-To: <150c32b4-d00c-5508-b16b-e7856e0cb09a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmY2YWRiY2MtYWUwZi00ODBlLWI5ZTgtNThmNDZmMDhlZmNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOFpSVEdTWlh3WEtCRXVZNGxqZU9CNmF6K0NPT0ZvRVlcL2ExbTdwRlVHYm5NVHY2Njk0dkFaQWtYXC9hWDZjNlE0In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5qdW4gR3VvIDxndW9oYW5q
dW5AaHVhd2VpLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAwNCwgMjAyMCAyOjA1IEFN
DQpUbzogSmVhbiBEZWx2YXJlIDxqZGVsdmFyZUBzdXNlLmRlPjsgbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmcNCkNjOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgS2Fu
ZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+OyBXeXNvY2tpLCBSYWZhZWwgSiA8cmFm
YWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogTm90ZSBhYm91dCBhY3BpX2dl
dF90YWJsZV9oZWFkZXINCg0KT24gMjAyMC8yLzQgMTc6MTcsIEplYW4gRGVsdmFyZSB3cm90ZToN
Cj4gSGVsbG8sDQo+IA0KPiBUaGUgZGVzY3JpcHRpb24gYmxvY2sgYmVmb3JlIGFjcGlfZ2V0X3Rh
YmxlX2hlYWRlcigpIGluIA0KPiBkcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZhY2UuYyBpbmNsdWRl
cyB0aGUgZm9sbG93aW5nIGNvbW1lbnQ6DQo+IA0KPiAgKiBOT1RFOiAgICAgICAgQ2FsbGVyIGlz
IHJlc3BvbnNpYmxlIGluIHVubWFwcGluZyB0aGUgaGVhZGVyIHdpdGgNCj4gICogICAgICAgICAg
ICAgIGFjcGlfb3NfdW5tYXBfbWVtb3J5DQoNCkknbSBjb25mdXNlZCBhcyB3ZWxsIHdoZW4gSSB3
YXMgcmVhZGluZyB0aGUgY29kZS4NCg0KPiANCj4gSG93ZXZlciwgbG9va2luZyBhdCB0aGUgY29k
ZSwgaXQgc2VlbXMgdGhhdCB3ZSBhcmUgYWxyZWFkeSBjYWxsaW5nDQo+IGFjcGlfb3NfdW5tYXBf
bWVtb3J5KCkgaW50ZXJuYWxseSBhcyBhcHByb3ByaWF0ZSwgYW5kIHdlIGFsd2F5cyByZXR1cm4g
DQo+IGEgY29weSBvZiB0aGUgaGVhZGVyLCBub3QgYSBwb2ludGVyIHRvIGl0LiBTbyBJIHNlZSBu
byByZWFzb24gd2h5IHRoZSANCj4gY2FsbGVyIHdvdWxkIGV2ZXIgbmVlZCB0byBjYWxsIGFjcGlf
b3NfdW5tYXBfbWVtb3J5KCkuIEFzIGEgbWF0dGVyIG9mIA0KPiBmYWN0IHRoZSBvbmx5IGN1cnJl
bnQgY2FsbGVyIG9mIHRoaXMgZnVuY3Rpb24gZG9lcyBOT1QgY2FsbA0KPiBhY3BpX29zX3VubWFw
X21lbW9yeSgpIGFmdGVyd2FyZHMuDQo+IA0KPiBTbyBJIGJlbGlldmUgdGhpcyBub3RlIGlzIHdy
b25nIGFuZCBzaG91bGQgYmUgcmVtb3ZlZD8NCg0KWWVzLCB0aGUgbm90ZSBpcyBvYnNvbGV0ZS4g
SSdsbCByZW1vdmUgaXQuDQoNCkJvYg0KDQpJIHRoaW5rIHNvLg0KDQpUaGFua3MNCkhhbmp1bg0K
DQoNCg==
