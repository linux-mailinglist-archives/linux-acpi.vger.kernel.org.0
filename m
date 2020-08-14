Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0DF244FF6
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Aug 2020 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNWw0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 18:52:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:19123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNWw0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 18:52:26 -0400
IronPort-SDR: lFaJ2iTa6tZwj5+ngm+FPqY8rAvKVC8AxTIRR2kF+uS5Ml3ig0S8Ih5dm0GA5eKhrRfZgM/001
 +Is2SZUMCYtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="218826061"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="218826061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 15:52:24 -0700
IronPort-SDR: QtYe4ERaVseq+kun6wFxk7mE42lBWQgAOOMGQ/RKzYPpmMR/E9NRIKE6J+A0D+pB2U5eTREaSG
 ZxdaSUyW4VUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="440253926"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2020 15:52:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 15:52:23 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 15:52:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 14 Aug 2020 15:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To0YaHOOomsZhiQeWcxHNRwWsI+EXy1N6Hcqb2qn9ycO3VGVKOYZnXj2bmwpd1f+IFM50w0gwQzMD8JpZfiSYF2S/YbZElTwLFagzDv9+P0NlvCTyu86a1j2dvzrBR0JyhP94UGIjP3WJ8Fz2F/G+oIhdNzilmhsojkIb+3Oj7Np+ayDHcb9D58RqH0osS4phEZTE69Qtg+9eEMi5eeC5N1COuvvrzgJVPpwzCwPOy2VJz6g0/uabsO5I7s9oKhEputWzlxVSD58QXzlAcywnQninhyH0OOBWyQES0HQ4gCaiGJEUidOZxHJKRh7V6EAYVPzDmnETWG/qDA09netyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjKIYh2MkKStzQgtUxKeRMmPzuXeAHwOfLWyTA/tmk=;
 b=Bpw5dQ9Nk5XhMpXid5zzJHO9sMdHaXpejQ9wGjFvZly8aVvVAkax6EgWUaJCa+vcyRZJHCpWaqdSUO4a8F52er2LvcKckKoqMijfsXw4ePBdYQKE0XO5dFVpEpwIFOvPjEuqve3vK5HS+z6VN9Snfy9cvoH0+cYR7TdUOjYN//YF4lRBL4f8B1F+SqP8cGKUTT+EW/qN3aqB2q38TZZU6urvN74V4T0FJmBQfBoZt/SrpkBMibIOj6DifXCBka9I+07ke7AiMJ+wWKcQr1smP64PYTk5vemACncpUkWv6M13js7kfbcHBrlI2ipTNVrGtO8RUzfo6Xpb45cmrFinuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjKIYh2MkKStzQgtUxKeRMmPzuXeAHwOfLWyTA/tmk=;
 b=n4RjppD397tWb8PWRfhm41k6ik572CTqRFe4zsu1oRRJfmSHX89tMaGfY2Mp/sHPPASozmnIDw1bkRJTbxrYXamQLpxjxyluYr9jHVJmTea9f1PLuJy1Mn0n/KZ6mwOzNIh6/MR0UhtmbI6w2RyI+mKP0xSyxfX/mj1cnRqPLnA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3477.namprd11.prod.outlook.com (2603:10b6:a03:7c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 22:52:20 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 22:52:20 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "wangqing@vivo.com" <wangqing@vivo.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/nfit: Use kobj_to_dev() instead
Thread-Topic: [PATCH] acpi/nfit: Use kobj_to_dev() instead
Thread-Index: AQHWcRxpj/rghooL6kKeKlMDqnI2Vqk3vQEAgAB75oA=
Date:   Fri, 14 Aug 2020 22:52:20 +0000
Message-ID: <4e23dc722419e82d13772afc8e060d3203fd5a86.camel@intel.com>
References: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
         <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a00d7bb8-2ec7-411a-2f1f-08d840a4b39a
x-ms-traffictypediagnostic: BYAPR11MB3477:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3477A6E6CCA61F463EC4B285C7400@BYAPR11MB3477.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWYKV3JQbRLXmKxuJ+/nUfCZCan8qUjV6dGBY1vAVxpF3KHPok9nW6hSDCQ3rxvf2P42x5cHga+WvxEPNhon3SPB+rH3B3WKuPeB6MyZoPo90SPrmjljAOPUCzvPOkNg12e0DEzVBVrxBGrYtuDKX7mT9eUrU/RFd9Nm/wIE6fLwWADR7qQJ0qjW/+xThLLCIwOf0K8r9MI5tIUhIrG2hqJzW4P+ovAJxTcNec4ElmEHfmNYHU3hC2h7EAmSyIebHaz2wylesMJn4Uo3RX+7Va+DqonplW5l4u9qGeKIfQQYZQKzvrmqXlVm+1IHxhey/osErU5w1ALAkMKLfq2qaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(54906003)(4326008)(64756008)(8936002)(66946007)(2906002)(8676002)(2616005)(83380400001)(66476007)(66556008)(76116006)(186003)(66446008)(5660300002)(26005)(316002)(478600001)(6506007)(71200400001)(53546011)(36756003)(110136005)(86362001)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0gsoDWFQLB0VAe3pjYtdYnCr0dahtV0pz1UotAmdmvMRk20zrYmANobodV13was1+og5UEYifTLjSw8LfSpqWUbfi977gsqccpjOq5FtF6QZld5c57cDLXvuUOcfhAPYLLT4e728dnK0LQDYXy6GnBQJaKq27ZIeaE+DJTh1MGyGhHFko5PrDP+dJ32MFCcAYrz3x+/uDl1hWsEQZbvwGft2d4vk9jvc+gxzpI6IfhdMsPfpZ/WiQ3oEnSyb2xuwRbNesggie7a4M+EoXguQeddJLACfSWotBWeEvkuyYbFDoXXMdH0bEEJk8VVTlwVH6joef18AHbcQLwEoFrPIWDP1PMEdqIgFMKfhEobCd7xVFuh5Jjc1egCJRNJumnbsqRFdwezGGsqUxtNqIqC8Wq2Hw9vLEVLL6m/iuBCwA1BXhlPGOFpceina5cxTVHpw9CLYA78OUovkb80ignOeIHq8bv28vT14k2g/G3yltNeDey22+Z+IzoeyDwdLx3ClilKFzeXJA4zs5UtS6LlSWPWRPDyCaoaHKqXRgAZbSEK1Df0iMRfW+yyQHzV5TSPdlRQ7P18R1BqAbabDuZ/cN7nLuBgtH6wk0/pYxKG5GLfgFSE1lq9ialQEiH5gALYWttFVz6yGplIMT+Goe/2BPA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BEEF98980247B4E865FB383C7D5DC8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00d7bb8-2ec7-411a-2f1f-08d840a4b39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 22:52:20.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf2wdwrIyOBfbLClc/QcJn8/SM0m//welJzAR0Gwp65GbqvyGZOIKlAff1tJpf/GQgstsErWl835zTtQ9jVgR95K2XRiF8q1an6e5nD3aVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3477
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIwLTA4LTE0IGF0IDE3OjI4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMTMsIDIwMjAgYXQgNDo1NCBBTSBXYW5nIFFpbmcgPHdhbmdxaW5n
QHZpdm8uY29tPiB3cm90ZToNCj4gPiBVc2Uga29ial90b19kZXYoKSBpbnN0ZWFkIG9mIGNvbnRh
aW5lcl9vZigpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2
aXZvLmNvbT4NCj4gDQo+IExHVE0NCj4gDQo+IERhbiwgYW55IG9iamVjdGlvbnM/DQoNCkxvb2tz
IGdvb2QgdG8gbWUgLSB5b3UgY2FuIGFkZDoNCkFja2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9uZml0
L2NvcmUuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9j
b3JlLmMgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gPiBpbmRleCBmYTQ1MDBmLi4zYmIz
NTBiDQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9hY3BpL25maXQvY29yZS5jDQo+ID4gQEAgLTEzODIsNyArMTM4Miw3IEBAIHN0YXRpYyBib29s
IGFyc19zdXBwb3J0ZWQoc3RydWN0IG52ZGltbV9idXMgKm52ZGltbV9idXMpDQo+ID4gDQo+ID4g
IHN0YXRpYyB1bW9kZV90IG5maXRfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0
IGF0dHJpYnV0ZSAqYSwgaW50IG4pDQo+ID4gIHsNCj4gPiAtICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9IGNvbnRhaW5lcl9vZihrb2JqLCBzdHJ1Y3QgZGV2aWNlLCBrb2JqKTsNCj4gPiArICAg
ICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGtvYmpfdG9fZGV2KGtvYmopOw0KPiA+ICAgICAgICAg
c3RydWN0IG52ZGltbV9idXMgKm52ZGltbV9idXMgPSB0b19udmRpbW1fYnVzKGRldik7DQo+ID4g
DQo+ID4gICAgICAgICBpZiAoYSA9PSAmZGV2X2F0dHJfc2NydWIuYXR0ciAmJiAhYXJzX3N1cHBv
cnRlZChudmRpbW1fYnVzKSkNCj4gPiBAQCAtMTY2Nyw3ICsxNjY3LDcgQEAgc3RhdGljIHN0cnVj
dCBhdHRyaWJ1dGUgKmFjcGlfbmZpdF9kaW1tX2F0dHJpYnV0ZXNbXSA9IHsNCj4gPiAgc3RhdGlj
IHVtb2RlX3QgYWNwaV9uZml0X2RpbW1fYXR0cl92aXNpYmxlKHN0cnVjdCBrb2JqZWN0ICprb2Jq
LA0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYXR0cmlidXRlICphLCBpbnQgbikNCj4gPiAg
ew0KPiA+IC0gICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gY29udGFpbmVyX29mKGtvYmosIHN0
cnVjdCBkZXZpY2UsIGtvYmopOw0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0ga29i
al90b19kZXYoa29iaik7DQo+ID4gICAgICAgICBzdHJ1Y3QgbnZkaW1tICpudmRpbW0gPSB0b19u
dmRpbW0oZGV2KTsNCj4gPiAgICAgICAgIHN0cnVjdCBuZml0X21lbSAqbmZpdF9tZW0gPSBudmRp
bW1fcHJvdmlkZXJfZGF0YShudmRpbW0pOw0KPiA+IA0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPiAN
Cg==
