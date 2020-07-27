Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3022F5BF
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG0Qtd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 12:49:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:29822 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgG0Qta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jul 2020 12:49:30 -0400
IronPort-SDR: uLPZVqngfvV1XbkbeNP2xoXmPWv2jZvHW3uppe1NGrnHyP0VYfP3Fla5leD5HX8nWixwbx+0F/
 hUqRoiW6YCyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="151047852"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="151047852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 09:49:26 -0700
IronPort-SDR: CO6E6+6UmnnrAFISXuAAKbNzrJRN30gdL8YQi+KVaKTxql6bjHFZnoWoXvx3dYBqWsjdrMzzRy
 hKHH7v8fQXpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="489575793"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2020 09:49:26 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Jul 2020 09:49:25 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 09:49:25 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 27 Jul 2020 09:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5IHX+IkZHqktUom0OQUVvGWtJovye5a/jN6gkAT4rqCXH3lLb5mCYUjSdW4N/d8oA4EXXEcgnOTexERxe4QuO0Z+kaYneSg6KSG5cmL7souQtvMiNkrbb5CjrXa91syrl3wkT/JOviW1m7Qsq8J/fiUn7TJfPbCz7dtIX/GhZy72vmnDF2a0NEU//1DwCz7vlvYsHHglKbMxQLQkmlqnjH345OsLwSUpzUvVKKMgI+IpMSiQX497JWzJkAVHh/pYttILjdoUeAEUjoPcv3/BL5i/QlS1Jl+wJQD/uUL76vmZeViqblQfjx/tyGefBSF/eY93z9oqnIRObJdTEaKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYO4R/zo0NChaVwBQ7PTzXmqSdMTxMJFD6aAE+cFuTM=;
 b=i1YRA19lwKshE0s2c6iNWVgFqBBpoU3v1P4ewLGWThSk7zg/tLw1jR/ToSIGHkU6ZzQfiR/GoUwOIWnwjhbcHQ0e6baGn2VNKZWcEl6b7VhZ63nn+DDgWU/1OZa+5QL096n4sz3wlI20K+vaITGTjPF7jALFreDt0bDRRUpxBb1My5XhHr/Yhorxzmi/w41MOui0DAMwmt6IJP2bpwdGiC+HW/mDoaGW4hlvIisKsZitJswoMwNcVVGirw0jFEMHEzBXc7xyYGSKuCY67x2fc6RdS00W/tnJ5HPfimkUstYE3qCo+4ww2oxcCv3DWug6arUCmGRWQv3JatBN0kNFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYO4R/zo0NChaVwBQ7PTzXmqSdMTxMJFD6aAE+cFuTM=;
 b=ZaMedN/eiTfVXQnkiTbasHpC4K0/2FjjBX7iwaEKcZgbgKMjFpGENL4lr2aE29yOn5layYa0mCLYw3TI246Lo6SDuRhk99kK6Y/v/Rwh/jC6/isEFQHrp3hlGKyZE1NF4VWlDVHnHijK078zZgkSnOXyXkoUTxhBx260Adbxy6M=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1646.namprd11.prod.outlook.com (2603:10b6:301:c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 16:49:23 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f%11]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 16:49:23 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: actypes.h: drop a duplicated word
Thread-Topic: [PATCH] ACPI: actypes.h: drop a duplicated word
Thread-Index: AQHWXWNcAO86uYEMN0it5Wj46PwgAqkbbI4AgABEEPA=
Date:   Mon, 27 Jul 2020 16:49:22 +0000
Message-ID: <MWHPR11MB159948DC963721EF8AA74FA8F0720@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20200719002652.20155-1-rdunlap@infradead.org>
 <CAJZ5v0hw2uZanO6vduyLufh926XSHVwkKRDEs0e8XWgowwqJ4g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hw2uZanO6vduyLufh926XSHVwkKRDEs0e8XWgowwqJ4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.104.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 348a78ff-2e83-4702-b598-08d8324d03d6
x-ms-traffictypediagnostic: MWHPR11MB1646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1646DFCBC3F611C7C80C6F85F0720@MWHPR11MB1646.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cKZBNL1NkImbBrTmxOoEsU1WDmSKoXqjclZwKh0Up9X/IgerPOm11R6lWkJaM0qdFt3EicbWxOCxfVncb7ewr6KHxNsN1NcSjtk8zZNrdEQb3mVdRrT7Y8vqG88z17+o7elYKnNmvJQFfsuguGLtpb7qYYIwX8wyMKVd85+odGsbOQwrAgskNaDIo0xU8Kg0Jn//QhrL9TNEP+qDs3hg/jhpY/h760lp86Wn2p2MhvOQyqXJ7WLG/YVRdOCakUFkWyTHFb3TCQfR9DkN3IOn6fC7IOaBv4dwL0x5W2Z4p888teNtaAZSSMnN051kIOy6zUeOUIJ8i0C0MvyMsWzPf0JQE6vLk1eQmA6jsycEkkhvAiPbkO1SSU+XuWYerR0je2DL9WEphK6Vkg2aebVgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(107886003)(66446008)(2906002)(7696005)(26005)(86362001)(52536014)(8936002)(966005)(64756008)(4326008)(33656002)(71200400001)(8676002)(110136005)(186003)(54906003)(53546011)(66556008)(6506007)(478600001)(83380400001)(5660300002)(66476007)(76116006)(316002)(9686003)(66946007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PfxjOm6rraZ6CChKFbCZ6txPmtZojH+77pVac3cO3FxI79aEPamzpTG1bfyYWyxN2s64pfbDZ1EyfRtnmxTggP12TudZ+UBA76hXGwDo7XNSFIpnK0Rxdv9dzwrMbShytTsZMpNVaV91qRRte+6gXCbyNFqPEPN7SnoVu98Dlbao52dNv/gw09UYYoHLQISTFqCn+avjR0iq3Cy6cjwX7YRsO+YwvxWT8aTaGAn3BZ0d4P83V+GYuAmdlZ2XoLBG8x82sMBYP5o9ClqpcsraMLp0kTyd7qu27Ed75k4MYl/KJJaItDPus3m+pL9XC94xuqU92VrndU9ORuFuxVB7A0E7SHiJESZ+IL85KKRoZxYoGvlSXT6wxMH/HpGr+M4vWN9QReUNpVQgrZfvTTsMtZfBKnnq3ib6CP1yuP7Mdvmgk8ADiqvIPpT0I/0vZPkFrXl7PQUUwCfawfAxZSyQpI+Br27kCfwR81PAhqftz3c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348a78ff-2e83-4702-b598-08d8324d03d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 16:49:22.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BdEfTZ+0vV9q9qyvlWl4YS6Cb14FHsf8Rp93pu0NJEZWHM+pz6KMzqWWiRm2NbgqEpgY3APRw/V4bcaqVG3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1646
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjcsIDIwMjAgNTo0
NCBBTQ0KPiBUbzogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+OyBLYW5lZGEs
IEVyaWsNCj4gPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gQ2M6IExpbnV4IEtlcm5lbCBNYWls
aW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBSYWZhZWwgSi4NCj4gV3lz
b2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEFD
UEkgRGV2ZWwNCj4gTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTW9v
cmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gQUNQSTogYWN0eXBlcy5oOiBkcm9wIGEgZHVwbGljYXRlZCB3b3JkDQo+IA0KPiBPbiBT
dW4sIEp1bCAxOSwgMjAyMCBhdCAyOjI3IEFNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IERyb3AgdGhlIHJlcGVhdGVkIHdvcmQgImFuIiBp
biBhIGNvbW1lbnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj4gPiBDYzogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lz
b2NraS5uZXQ+DQo+ID4gQ2M6IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiA+IENjOiBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZw0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2FjcGkvYWN0
eXBlcy5oIHwgICAgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IC0tLSBsaW51eC1uZXh0LTIwMjAwNzE3Lm9yaWcvaW5jbHVk
ZS9hY3BpL2FjdHlwZXMuaA0KPiA+ICsrKyBsaW51eC1uZXh0LTIwMjAwNzE3L2luY2x1ZGUvYWNw
aS9hY3R5cGVzLmgNCj4gPiBAQCAtODI0LDcgKzgyNCw3IEBAIHR5cGVkZWYgdTggYWNwaV9hZHJf
c3BhY2VfdHlwZTsNCj4gPiAgICoNCj4gPiAgICogTm90ZTogQSBEYXRhIFRhYmxlIHJlZ2lvbiBp
cyBhIHNwZWNpYWwgdHlwZSBvZiBvcGVyYXRpb24gcmVnaW9uDQo+ID4gICAqIHRoYXQgaGFzIGl0
cyBvd24gQU1MIG9wY29kZS4gSG93ZXZlciwgaW50ZXJuYWxseSwgdGhlIEFNTA0KPiA+IC0gKiBp
bnRlcnByZXRlciBzaW1wbHkgY3JlYXRlcyBhbiBvcGVyYXRpb24gcmVnaW9uIHdpdGggYW4gYW4g
YWRkcmVzcw0KPiA+ICsgKiBpbnRlcnByZXRlciBzaW1wbHkgY3JlYXRlcyBhbiBvcGVyYXRpb24g
cmVnaW9uIHdpdGggYW4gYWRkcmVzcw0KPiA+ICAgKiBzcGFjZSB0eXBlIG9mIEFDUElfQURSX1NQ
QUNFX0RBVEFfVEFCTEUuDQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIEFDUElfQURSX1NQQUNFX0RB
VEFfVEFCTEUgICAgICAgKGFjcGlfYWRyX3NwYWNlX3R5cGUpIDB4N0UNCj4gLyogSW50ZXJuYWwg
dG8gQUNQSUNBIG9ubHkgKi8NCj4gDQo+IFRoaXMgaXMgYW4gQUNQSUNBIGhlYWRlciBmaWxlLCBz
byBpdCdzIGJldHRlciB0byByb3V0ZSB0aGUgY2hhbmdlDQo+IHRocm91Z2ggdGhlIHVwc3RyZWFt
Lg0KPiANCj4gRXJpaywgY2FuIHlvdSBwaWNrIHVwIHRoaXMgb25lLCBwbGVhc2U/DQoNCkRvbmUu
DQoNCkkgbWFkZSBhIHB1bGwgcmVxdWVzdCBoZXJlOiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNh
L2FjcGljYS9wdWxsLzYxOA0KSXQgd2lsbCBiZSBpbiB0aGUgbmV4dCBBQ1BJQ0EgcmVsZWFzZS4N
Cg0KVGhhbmtzIQ0KRXJpaw0K
