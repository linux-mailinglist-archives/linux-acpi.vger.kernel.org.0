Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AD1FD2D9
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQQwX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 12:52:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:9201 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFQQwV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jun 2020 12:52:21 -0400
IronPort-SDR: mzSltu1X9cxe8hGxx/KK3DdE1sN+lmiJCci52/srpZPD4l72cDT+z8X/NR9yj2J6oLkT/2eqh7
 6lfXS01UWhVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 09:52:16 -0700
IronPort-SDR: 6IrQiFjxiXU3WZNWBJtiw/66HsmjxW4Vr3c188ayiwHop36+UMPCZYC9KXb6zzsLCydOYBAgeP
 Oz/wCLiaLuLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="352136298"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2020 09:52:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jun 2020 09:52:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jun 2020 09:52:14 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Jun 2020 09:52:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axXXcPySwtTg55qdfO8km7B4tqJusj5KGXz8nMzu6m1Pe5hd0nms3hmkWwV5qbQp8g184xhvK3rDPH1Oz2SM9o77qjf1ajQkO9bxXYJIAQPus7L7qkDglE6FhD7NAZ2zg5B6gsPh+1rPUYj5x6FaVJfaK44KE6jUvp9oSp979EaGeOsGloK2A/SplA/AChrxfLqz6jeUjwDCcNqpsG64kViC3IYnUOwV+dy22AgcD4wFAOMccssj93uVXLdyDkeLsex1w9ChHGfBeGpN2PkFNscpsLpLP6LTktvFMVnU4jkUYM2En+4/T5mFHYXsxdNRtANyfdlwQT3CRIs2xzMuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMvoLm6hH+Cyr6zWtHq98snUN/c5qEBF9Dj1fHAl8g=;
 b=n57Z8uUGQBjO8Mbv+Sutfz/Fy0F2iPnDjQqmBHx90gfgvyX0C8JCtk8TfFViMFPiP+580c6ZljekTWZdf9KzzFLmLPtM3F26P32gm6dNSDUjEAyvkzV+dT5n5A1A0euS4cFlmFozAMHVw9KXhRpD331GmnKRetJeTPaFebz6uko3aIukWWnwvovgds5AXj7ibITU/3hGMMXAO//Tn4oS0DFO/6g8SeiAG1wUlVupIt8/ST8KqKf9pHCXQdbjzNj837x8RseUho1kD/Tbsrd6+VC87sYG9GLii/VJLfwNZNOGYsAYgVCelklWL9Fdpgy9bqPLJ8Tznwox51siHg/UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMvoLm6hH+Cyr6zWtHq98snUN/c5qEBF9Dj1fHAl8g=;
 b=IiHma/vcIlkfAXOmsTxUOQX1/QrD6kc/gC7t6Iw+IsPx/Qw79XUoQPaf73YbSgK1xJm/LbXKx4Jp7JCQA5auvm/MVc10MZNRxxQ8dB+RRE+LnzhJscvUVcJKCLFbSr0qWhGcXuqX6l2wQMjrRdctTyhvvSUw/ZEoDjJ+Ilqp37A=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1454.namprd11.prod.outlook.com (2603:10b6:301:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 16:52:10 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f%11]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 16:52:10 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH] acpi: disallow loading configfs acpi tables when locked
 down
Thread-Topic: [PATCH] acpi: disallow loading configfs acpi tables when locked
 down
Thread-Index: AQHWQwHsDapEE1DdX0qlaUS5GJuxS6jb0rmAgACscACAAIbWMA==
Date:   Wed, 17 Jun 2020 16:52:10 +0000
Message-ID: <MWHPR11MB159995958420653FBC6D2DE2F09A0@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <20200615104332.901519-1-Jason@zx2c4.com>
 <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
 <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
In-Reply-To: <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76760d82-dcd5-4c0b-5bd2-08d812dec73a
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB1454CC52F68E9C445A5E98E5F09A0@MWHPR11MB1454.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfTGTBweMDFnhK/Q4/ttxdfqBnC1PD5BLtQSWZxSmB6Ntxu5fFBrOl2xGg+Y4ipH/k4G3YbSc5cOW803wZNEOnuJigtxBl1qG51NUQqmibLKWfVxAzRBebXVEKrjF0VQ1m6M8YIprlRGsQbY1ErrkrSXBlONJsRbOrEHuPr7Ctz5hK3kYyFClzWg9atnNKwwF3cY9fiRLgpJ/8b6W9Y8gWPD814U6WbovPC5JAVS8kefGza2HXh9PYp8Cmm7yaOkD6Nz0ppndDZzkSp9kHTkSAysr/Y3JKO9/fdpcIt+wsAmKZ5fdrKsNySDTHId6CZNPof36AKbM/KCejoiLRSoz4qvhu0rhO2kH9RimNyJCmH0Tby3ay5JmiTmKWhQd88+Ok9ieeoUcKiL7+uEfJR4Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(5660300002)(316002)(86362001)(52536014)(55016002)(54906003)(9686003)(110136005)(33656002)(4326008)(186003)(71200400001)(26005)(76116006)(66446008)(66946007)(8676002)(966005)(8936002)(64756008)(478600001)(6506007)(53546011)(45080400002)(7696005)(66476007)(66556008)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p+64fFfgdJ6s8b3CCIYFdptTvNQOX9MJfoWz5yVByVdkL1ze8kNzK+37VfTFMEX3oH4QcfzUYqPnM0HaubrBiBussfDGLDyyK84I0eZd2JG+pkSCxJCw/LrWv2cSYlUAaUT+3LV9+9s+yYq5FNPw6zerm0Jboi2b+SczgRKXi4vXy+/w9IOjDoV9nVFYEWG38oeY6jnLyBHu0I46fq4Nkmr5nHVBFL/DGPoT71Fzfk44+8DTHCV4ztSc4nw6E6MAzzbZQ409hZuB0hsJZUBcObDt/FWk+Z0FNbZKtrEOHl03C6xckEmP2RTgACWzCOn4cVMm6VjIY0W5kpAZXYuqliV3TdlhP7M4zDJ7PejBOXr8k0qwxgQxEEu4BcU6gBNI3iZxrVBYnUgaNJ3eu0351yZ+UWNbDVVC4ACVLNU18p64elCfYue2SGwkIoVWq4+vZ9JsN6H8YPZhp4O3Ay+K4pNYv8Dgxm9/RqC2siGYugo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76760d82-dcd5-4c0b-5bd2-08d812dec73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 16:52:10.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9LQXjqJ3DrOdpm3PdRQCRtn4xEN2LIyM1I+/Q5bs/JIZkhR9NTnEKKQlFMaZn/P6Nug1AbtbAn1RULSCcclEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIEFyZCBCaWVzaGV1dmVsDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxNywg
MjAyMCAxOjM4IEFNDQo+IFRvOiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4N
Cj4gQ2M6IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgUmFmYWVsIEouIFd5c29ja2kgPHJq
d0Byand5c29ja2kubmV0PjsNCj4gTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZz47
IEtlcm5lbCBIYXJkZW5pbmcgPGtlcm5lbC0NCj4gaGFyZGVuaW5nQGxpc3RzLm9wZW53YWxsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYWNwaTogZGlzYWxsb3cgbG9hZGluZyBjb25maWdm
cyBhY3BpIHRhYmxlcyB3aGVuIGxvY2tlZA0KPiBkb3duDQo+IA0KPiBPbiBXZWQsIDE3IEp1biAy
MDIwIGF0IDAwOjIxLCBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBSYWZhZWwsIExlbiwNCj4gPg0KPiA+IExvb2tzIGxpa2UgSSBzaG91
bGQgaGF2ZSBDQydkIHlvdSBvbiB0aGlzIHBhdGNoLiBUaGlzIGlzIHByb2JhYmx5DQo+ID4gc29t
ZXRoaW5nIHdlIHNob3VsZCBnZXQgaW50byA1LjgtcmMyLCBzbyB0aGF0IGl0IGNhbiB0aGVuIGdl
dCBwdXQgaW50bw0KPiA+IHN0YWJsZSBrZXJuZWxzLCBhcyBzb21lIHBlb3BsZSB0aGluayB0aGlz
IGlzIHNlY3VyaXR5IHNlbnNpdGl2ZS4NCj4gPiBCaWdnZXIgcGljdHVyZSBpcyB0aGlzOg0KPiA+
DQo+ID4gaHR0cHM6Ly9kYXRhLnp4MmM0LmNvbS9hbWVyaWNhbi11bnNpZ25lZC1sYW5ndWFnZS0y
LmdpZg0KPiA+IGh0dHBzOi8vZGF0YS56eDJjNC5jb20vYW1lcmljYW4tdW5zaWduZWQtbGFuZ3Vh
Z2UtMi1mZWRvcmEtNS44LnBuZw0KPiA+DQpIaSwNCg0KPiA+IEFsc28sIHNvbWVib2R5IG1lbnRp
b25lZCB0byBtZSB0aGF0IE1pY3Jvc29mdCdzIEFDUEkgaW1wbGVtZW50YXRpb24NCj4gPiBkaXNh
bGxvd3Mgd3JpdGVzIHRvIHN5c3RlbSBtZW1vcnkgYXMgYSBzZWN1cml0eSBtaXRpZ2F0aW9uLiBJ
IGhhdmVuJ3QNCj4gPiBsb29rZWQgYXQgd2hhdCB0aGF0IGFjdHVhbGx5IGVudGFpbHMsIGJ1dCBJ
IHdvbmRlciBpZiBlbnRpcmVseQ0KPiA+IGRpc2FibGluZyBzdXBwb3J0IGZvciBBQ1BJX0FEUl9T
UEFDRV9TWVNURU1fTUVNT1JZIHdvdWxkIGJlDQo+IHNlbnNpYmxlLg0KDQpObywgV2luZG93cyB1
c2VzIHRoZXNlIGFzIHdlbGwuIFRoZXkgbWlnaHQgaGF2ZSBzb21lIHJlc3RyaWN0aW9uIG9uIHdo
aWNoIGFyZWFzIGFyZSBhbGxvd2VkIHRob3VnaC4NCldpdGggdGhhdCBzYWlkLCB0aGVyZSBhcmUg
cGxlbnR5IG9mIHVzZSBjYXNlcyAoU01JIGhhbmRsZXJzLCBwb3dlciBtYW5hZ2VtZW50LCBldGMp
IHdoZXJlIHRoaXMgaXMgbmVlZGVkLg0KRGlzYWJsaW5nIFN5c3RlbU1lbW9yeSB3b3VsZCBkZWZp
bml0ZWx5IGJyZWFrIGV4aXN0aW5nIHN5c3RlbXMuDQoNCkVyaWsNCj4gPiBJIGhhdmVuJ3QgbG9v
a2VkIGF0IHRvbyBtYW55IERTRFRzLiBXb3VsZCB0aGF0IGJyZWFrIHJlYWwgaGFyZHdhcmUsIG9y
DQo+ID4gZG9lcyBub2JvZHkgZG8gdGhhdD8gQWx0ZXJuYXRpdmVseSwgdGhlIHJhbmdlIG9mIGFj
Y2VwdGFibGUgYWRkcmVzc2VzDQo+ID4gZm9yIFN5c3RlbU1lbW9yeSBjb3VsZCBleGNsdWRlIGtl
cm5lbCBtZW1vcnkuIFdvdWxkIHRoYXQgYnJlYWsNCj4gPiBhbnl0aGluZz8gSGF2ZSB5b3UgaGVh
cmQgYWJvdXQgTWljcm9zb2Z0J3MgbWl0aWdhdGlvbiB0byBrbm93IG1vcmUNCj4gPiBkZXRhaWxz
IG9uIHdoYXQgdGhleSBmaWd1cmVkIG91dCB0aGV5IGNvdWxkIHNhZmVseSByZXN0cmljdCB3aXRo
b3V0DQo+ID4gYnJlYWtpbmcgaGFyZHdhcmU/IEVpdGhlciB3YXksIGZvb2QgZm9yIHRob3VnaHQg
SSBzdXBwb3NlLg0KPiA+DQo+IA0KPiBBQ1BJX0FEUl9TUEFDRV9TWVNURU1fTUVNT1JZIG1heSBi
ZSB1c2VkIGZvciBldmVyeXRoaW5nIHRoYXQgaXMNCj4gbWVtb3J5DQo+IG1hcHBlZCwgaS5lLiwg
UENJZSBFQ0FNIHNwYWNlLCBHUElPIGNvbnRyb2wgcmVnaXN0ZXJzIGV0Yy4NCj4gDQo+IEkgYWdy
ZWUgdGhhdCB1c2luZyBBQ1BJX0FEUl9TUEFDRV9TWVNURU1fTUVNT1JZIGZvciBhbnkgbWVtb3J5
IHRoYXQNCj4gaXMNCj4gdW5kZXIgdGhlIGtlcm5lbCdzIGNvbnRyb2wgaXMgYSBiYWQgaWRlYSwg
YW5kIHRoaXMgc2hvdWxkIGJlIGVhc3kgdG8NCj4gZmlsdGVyIG91dDogdGhlIFN5c3RlbU1lbW9y
eSBhZGRyZXNzIHNwYWNlIGhhbmRsZXIgbmVlZHMgdGhlIEFDUEkNCj4gc3VwcG9ydCByb3V0aW5l
cyB0byBtYXAgdGhlIHBoeXNpY2FsIGFkZHJlc3NlcyB1c2VkIGJ5IEFNTCBpbnRvDQo+IHZpcnR1
YWwga2VybmVsIGFkZHJlc3Nlcywgc28gYWxsIHRoZXNlIGFjY2Vzc2VzIGdvIHRocm91Z2gNCj4g
YWNwaV9vc19pb3JlbWFwKCkuIFNvIGFzIGEgZmlyc3Qgc3RlcCwgaXQgc2hvdWxkIGJlIHJlYXNv
bmFibGUgdG8gcHV0DQo+IGEgbG9ja2Rvd24gY2hlY2sgdGhlcmUsIGFuZCBmYWlsIGFueSBhY2Nl
c3MgdG8gT1Mgb3duZWQgbWVtb3J5IGlmDQo+IGxvY2tkb3duIGlzIGVuYWJsZWQsIGFuZCBwcmlu
dCBhIHdhcm5pbmcgaWYgaXQgaXMgbm90Lg0KDQo=
