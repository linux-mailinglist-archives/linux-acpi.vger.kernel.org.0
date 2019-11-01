Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C8ECB59
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2019 23:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKAW0k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Nov 2019 18:26:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:37523 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAW0k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Nov 2019 18:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572647199; x=1604183199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zJ5tMJ2GU2wVGaq6jvdZpYhHeVl9vK/DGF24uURnXsU=;
  b=OlL+2iZ41Gzvcj/U8JQuJE+Fx4HSChRLNvaUIC4ubeSHpfnQ61USiNKJ
   VQso+5i8YIQwoH5Hj8977xEUuMnKMX7JqlMORADZwMhvqY8ugNYHI5OiR
   Ar5u9glvckXTl+0+KkJ7bvzsjgWHw/5gA6uSh8SowRQ7QgDDsYUuA4yn/
   Y=;
IronPort-SDR: sKl0NXl8PWUp+cDaDm6dxNB/2ucajloDEbJcHpiN4WViJr5YCz0YD1tr3aesHS+/kzNh2pQwX/
 +WgSACq+UUJg==
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Nov 2019 22:26:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id E2A23A265C;
        Fri,  1 Nov 2019 22:26:36 +0000 (UTC)
Received: from EX13D07UWB001.ant.amazon.com (10.43.161.238) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 1 Nov 2019 22:26:36 +0000
Received: from EX13D07UWB001.ant.amazon.com (10.43.161.238) by
 EX13D07UWB001.ant.amazon.com (10.43.161.238) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 1 Nov 2019 22:26:36 +0000
Received: from EX13D07UWB001.ant.amazon.com ([10.43.161.238]) by
 EX13D07UWB001.ant.amazon.com ([10.43.161.238]) with mapi id 15.00.1367.000;
 Fri, 1 Nov 2019 22:26:36 +0000
From:   "Agarwal, Anchal" <anchalag@amazon.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
CC:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Topic: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Index: AQHVkPqVm6n+MpBEcEmxJhBMWECi4Kd23XsA//+SDwA=
Date:   Fri, 1 Nov 2019 22:26:36 +0000
Message-ID: <E31BA312-7B9D-4AA9-8BD5-F60E28069979@amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <CF6A88132359CE47947DB4C6E1709ED53C66675F@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C66675F@ORSMSX122.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.16]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D426CA524C5845AAD93119E8BFA81F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQrvu78gICAgKyBSYWZhZWwsIEJvYg0KICAgIA0KICAgIEFsc28sIGlzIHRoZXJlIGEgcmVhc29u
IHdoeSB0aGlzIHdhc24ndCBDQy1lZCB0byBsaW51eC1hY3BpIG1haWxpbmcgbGlzdD8gSXQgd291
bGQgYmUgZ29vZCB0byBnZXQgZmVlZGJhY2sgZnJvbSB0aGVyZSB0b28uLg0KSSB0aGluayBJIGRp
ZCB0byBhbGwgdGhlIGVtYWlsIGlkJ3MgZ2VuZXJhdGVkIGZyb20gZ2V0X21haW50YWluZXIucGwu
IENjaW5nIGFnYWluIA0KKyBsaW51eC1hY3BpDQoNCiAgICBUaGFua3MsDQogICAgRXJpaw0KICAg
IA0KICAgID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCiAgICA+IEZyb206IEFuY2hhbCBB
Z2Fyd2FsIDxhbmNoYWxhZ0BhbWF6b24uY29tPg0KICAgID4gU2VudDogTW9uZGF5LCBPY3RvYmVy
IDI5LCAyMDE4IDEwOjUyIEFNDQogICAgPiBTdWJqZWN0OiBbUEFUQ0hdIEFDUElDQTogRW5hYmxl
IHNsZWVwIGJ1dHRvbiBvbiBBQ1BJIGxlZ2FjeSB3YWtlDQogICAgPiANCiAgICA+IEN1cnJlbnRs
eSB3ZSBkbyBub3Qgc2VlIHNsZWVwX2VuYWJsZSBiaXQgc2V0IGFmdGVyIGd1ZXN0IHJlc3VtZXMg
ZnJvbQ0KICAgID4gaGliZXJuYXRpb24uIEhpYmVybmF0aW9uIGlzIHRyaWdnZXJlZCBpbiBndWVz
dCBvbiByZWNlaXZpbmcgYSBzbGVlcCB0cmlnZ2VyDQogICAgPiBmcm9tIHRoZSBoeXBlcnZpc29y
KFM0IHN0YXRlKS4gV2Ugc2VlIHRoYXQgcG93ZXIgYnV0dG9uIGlzIGVuYWJsZWQgb24gd2FrZQ0K
ICAgID4gdXAgZnJvbSBTNCBzdGF0ZSBob3dldmVyIHNsZWVwIGJ1dHRvbiBpc24ndC4gVGhpcyBj
YXVzZXMgc3Vic2VxdWVudA0KICAgID4gaW52b2NhdGlvbiBvZiBzbGVlcCBzdGF0ZSB0byBmYWls
IGluIHRoZSBndWVzdC4gQW55IGVudmlyb25tZW50ICBnb2luZyB0aHJvdWdoDQogICAgPiBhY3Bp
X2h3X2xlZ2FjeV93YWtlKCkgd29uJ3QgaGF2ZSBzbGVlcCBidXR0b24gZW5hYmxlZC4NCiAgICA+
IA0KICAgID4gU2lnbmVkLW9mZi1ieTogQW5jaGFsIEFnYXJ3YWwgPGFuY2hhbGFnQGFtYXpvbi5j
b20+DQogICAgPiBSZXZpZXdlZC1ieTogQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4N
CiAgICA+IFJldmlld2VkLWJ5OiBGcmFuayB2YW4gZGVyIExpbmRlbiA8ZmxsaW5kZW5AYW1hem9u
LmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvaHdzbGVlcC5jIHwg
MTEgKysrKysrKysrKysNCiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0K
ICAgID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9od3NsZWVwLmMg
Yi9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3c2xlZXAuYw0KICAgID4gaW5kZXggYjYyZGI4ZWM0NDZm
Li5hMTc2Yzc4MDI3NjAgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3
c2xlZXAuYw0KICAgID4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS9od3NsZWVwLmMNCiAgICA+
IEBAIC0zMDAsNiArMzAwLDE3IEBAIGFjcGlfc3RhdHVzIGFjcGlfaHdfbGVnYWN5X3dha2UodTgg
c2xlZXBfc3RhdGUpDQogICAgPiAgCQkJCSAgICBbQUNQSV9FVkVOVF9QT1dFUl9CVVRUT05dLg0K
ICAgID4gIAkJCQkgICAgc3RhdHVzX3JlZ2lzdGVyX2lkLCBBQ1BJX0NMRUFSX1NUQVRVUyk7DQog
ICAgPiANCiAgICA+ICsJLyogRW5hYmxlIHNsZWVwIGJ1dHRvbiAqLw0KICAgID4gKwkodm9pZCkN
CiAgICA+ICsJICAgICAgYWNwaV93cml0ZV9iaXRfcmVnaXN0ZXIoYWNwaV9nYmxfZml4ZWRfZXZl
bnRfaW5mbw0KICAgID4gKwkJCQkgICAgICBbQUNQSV9FVkVOVF9TTEVFUF9CVVRUT05dLg0KICAg
ID4gKwkJCQkgICAgICBlbmFibGVfcmVnaXN0ZXJfaWQsDQogICAgPiBBQ1BJX0VOQUJMRV9FVkVO
VCk7DQogICAgPiArDQogICAgPiArCSh2b2lkKQ0KICAgID4gKwkgICAgICBhY3BpX3dyaXRlX2Jp
dF9yZWdpc3RlcihhY3BpX2dibF9maXhlZF9ldmVudF9pbmZvDQogICAgPiArCQkJCSAgICAgIFtB
Q1BJX0VWRU5UX1NMRUVQX0JVVFRPTl0uDQogICAgPiArCQkJCSAgICAgIHN0YXR1c19yZWdpc3Rl
cl9pZCwgQUNQSV9DTEVBUl9TVEFUVVMpOw0KICAgID4gKw0KICAgID4gIAlhY3BpX2h3X2V4ZWN1
dGVfc2xlZXBfbWV0aG9kKE1FVEhPRF9QQVRITkFNRV9fU1NULA0KICAgID4gQUNQSV9TU1RfV09S
S0lORyk7DQogICAgPiAgCXJldHVybl9BQ1BJX1NUQVRVUyhzdGF0dXMpOw0KICAgID4gIH0NCiAg
ICA+IC0tDQogICAgPiAyLjE1LjMuQU1aTg0KICAgIA0KICAgIA0KDQo=
