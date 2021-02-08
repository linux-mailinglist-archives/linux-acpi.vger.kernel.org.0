Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CA313E84
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhBHTIy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:08:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:33265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236064AbhBHTHv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Feb 2021 14:07:51 -0500
IronPort-SDR: fkFPnCaA3IYTlN7Rt+T3e2LzsM1q7MujW/erLNIPPXHlcdG8uhZQf+gNdjqPzIzE3T+4knwAYL
 cp54/IDtFxiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243263062"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="243263062"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:06:53 -0800
IronPort-SDR: Zj/BnLcfHyAd3UDCv0gS6Xfe270z7UFzGQkSG/ZzQ4Fyast/8H8pTm6f1GWLCi/TEHYkavBWud
 5BH2/EW8jVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="435731804"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2021 11:06:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 11:06:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 11:06:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Feb 2021 11:06:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 8 Feb 2021 11:06:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmGjAtAJQ+bZVrjPA3Vb3QnWh84Ghf+ijm2M733oAvZO9RUJpGB5Wv9HbQr0xmEOgVKds2gFZc2DbKt/AG2zjN0pqltWCUSFP2643GOHYfwe2vTH8axON4iaur3f8QRDvfmjqbGG5iDEeQs/HN2AS0pXPVB8O4SB1aocYXKuaH8oXnSQymYOR5fKLYE73bYYvSRUPCUxggDnNExn6JWEftgTp6+9PfuDcBEUTHnJyClwPBrNXuKSoRDSjEekpFMMTbutpPJpLyQmTuYZg2HWN9kDzwa98uzfv9zS/eP/iAeHs8lsGz0EGgs4QtQzHq5lo6/DkTfUZJQfWaDm2jHFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jEe/8/Li1Br4W0R6Shj+cZ4jfzb2OH2V6PkbtVyswg=;
 b=b6vmMZKx3ftmZpNL+1rzlUvNdaCcNBimkej/c0Z5yh0jDexbBi6HDV/zfzILei9EWbQcPflD4LwCqGT0jSnkjrM26oHlrpQgYJwlUaHXluJbiuNn/tLb+qE2iKJDq9fBAn3r+LqmxTXFPZLGhr5t49iyeciV6nTTfhrJw436/ov2Id7/bSHuTxezCuJ9yV5uRzjfduKQrejJUx9pPDw01T/rtqclspA0KsWj9hT3jVIaSB59zuLh0iqY1OrLMEmcBkAWeHeVSgca5hbp1YQ8I1Y0GN+RUb68oZDYa9b7kLBL/qMc74QOiTHBNRdRPEJydPgk5zdrnsKPp4k+wcRMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jEe/8/Li1Br4W0R6Shj+cZ4jfzb2OH2V6PkbtVyswg=;
 b=kl7JgJpqny8uWsW+grwiD+SKUv6hH5YNf5Yugevb0Uv2iF2DlS37m9p+8hwVCweRSqWzMGnxRbyg56BtWIKG6/x1pW0IqB2o30y2lML/NEBko7G3CoZWI15ilC+5WnocyiDkzfFxAFaixwtrHIcTw7oe9jnTehQYMRv6xuz7Evs=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Mon, 8 Feb
 2021 19:06:49 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 19:06:49 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
 existing buffer"
Thread-Topic: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
 existing buffer"
Thread-Index: AQHW/GUhvu4EQ1vBQEifLLDSD3v09qpK8oqAgANJjgCAAFu8EA==
Date:   Mon, 8 Feb 2021 19:06:49 +0000
Message-ID: <MWHPR11MB1599534717CB4A1447A8DE7CF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210206084937.20853-1-ardb@kernel.org>
 <20210206104854.GC27503@dragon>
 <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca29f30-0fa2-48e8-c66c-08d8cc64b03d
x-ms-traffictypediagnostic: CO1PR11MB4929:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB49294ED86C99170B721315C0F08F9@CO1PR11MB4929.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mS7rsnck+eoalGBbYZx3LPESplQylo0+TjRFthlFaPjbGRifw3xGU+sCacItvtfB3mZ27mcoDn7f2AvFlC8eahbY90yp4R4wSpd7AXw6Dwf/jjAUg6drnMewHf4Lpv5WwJYRQ7C3FI+nbSnMFssZjbw0KyRVxNjp9zl3g2jGt38aQOyenbUXzG5q9BxnSdIB0DA3S9ipx8PpR6S1YFy62/4ajwvjn+Z4gKbu1txcw/mYcYyxvWy/B0TkSf6bAvYr5Lc/1kOvYCbXxqLWm+3J4GesDTc9ymP80kcLoX8H/3godmwsqkS+jMzmSGDje04pUuiXFbKUDl5Ta7erP9Jp+1QPoQXRhVGld9ME+N5Vg3zIBoQ5uhwP0BhpDeeMulccCuWipV57aMl49SVyKqNMMNvRkfwBMlf9mKCj8c4T9qm9FjVx+1K0J07+n3uBrpi40iC/12qBZElNqjXyUCDwMolox8COxYKTZfK5xPLqA3+scJ9oa1XX5vZQKXdS67gRsY7ZTF9U3HsDW6eKA5P/sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(346002)(136003)(8936002)(4326008)(66946007)(6506007)(53546011)(26005)(52536014)(83380400001)(110136005)(55016002)(5660300002)(9686003)(66476007)(33656002)(66556008)(86362001)(76116006)(66446008)(7696005)(71200400001)(54906003)(64756008)(186003)(316002)(107886003)(8676002)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QkZoRVh3dE5ldzNCQjNnV21wZ2tTR01PNDNvNlpKVnZKcDFESE1JbWdUT3Rw?=
 =?utf-8?B?dHBwSzlTbHppWG9TWmhEWlNueW1la0Q4SFJ3clpFN2t0ekVFSkR2ekRpMU40?=
 =?utf-8?B?V2NoQWdDWWxmWUdSYlFJaUJycmR0S2s0MFhXZ3AxaVp6bW0rYlc0NmxiZ09m?=
 =?utf-8?B?TTBKWUlYdGFRdEVld0Rxc24yMlc4MlBlRVJBVExFcXlRN2pNVHZUMUpQZm9Q?=
 =?utf-8?B?Z0pScThDTVFJWXFJZHRtWVBZKzRuUU9pVkFYSkVSZmdyVzZ1SEdlS2dPLzN0?=
 =?utf-8?B?VnJxZ1dUVzJ3M1d2OWZxSURiM2taTXhIa1VrMnRoUEVWOGNmSlhwa1J0MGt6?=
 =?utf-8?B?eFlCS2hvVzkvM3VIYUZQOHkweFVxYTZsQXpTb0VIMjQySWZ4UnpneDl4Myt4?=
 =?utf-8?B?ei9sYUNQREk1RkZTNEtLN1g4SS9lT3A5RHFjb3EwT1p4Zk9yVWM0OStPQldP?=
 =?utf-8?B?UVA1TXBlZkRqRERmOEFjNklNcnlGYit2Y1pvVVNoUG5HQ2krcUxpVGV4VXdL?=
 =?utf-8?B?NEdUeWtTZzJCaWVUZk54SEFFWFFaY1E4YXNDekQ3VGZJUldmand2UDFmSEdi?=
 =?utf-8?B?WnU3Qm9Yall2YXdVVXhZbTdYS1ZOOUJGcGwwVDgwZzZFbE9ndEpuc2xpaVhY?=
 =?utf-8?B?bEJ2N3JUT0taYVQ1RVpQdlVjbXlWc0xwMGFQZjFBd1FxQW1ZMEJweXBGQm94?=
 =?utf-8?B?eW1wN01PTzIzRFJxaC9IM0tWYndObU5Ba04xZmErSURCYmhvUW5uRmcyWHBM?=
 =?utf-8?B?ck0wNVN0dE1JWW5sTVpLTnJwZUtiRjRMM0hzSmhxeU1ET3ZXVys0eFA2MFZZ?=
 =?utf-8?B?OTNWQTJ6UlZmQXR3L0xiMW5YUUY4TGw0WE4vcWtNZlBQR1lKdytCMlJXaEJ4?=
 =?utf-8?B?MG40YU5LdEpGNDNGckEvWjd2MVdxQVhuRmtzNUZDYTFyT2FaN3Z3TlRpODRl?=
 =?utf-8?B?M2VRTUE5SFJ1a1dKYlMzeWJhNTc1Zjlzd2hZaEhKSGRQa0orUXo5NlFCYTJS?=
 =?utf-8?B?amgrY0dFQjVpWWtENjJnVU1TWk5vc29CSEJXSnNwUkdoR0dvbjFLaW9UWW9o?=
 =?utf-8?B?RU5IelR5WEtuWGRmdm90S01CekV2QWROMVpVWDNySzBNcjVJUlVyUit6MlNG?=
 =?utf-8?B?emh3ek9IeE14c3VmcEZTVE15TFNIUlUwWG1YSWRZeW1kL1laNUd1M0tucUhP?=
 =?utf-8?B?Tkc0ai9zMk1DVXAwd0g5Nkxlc0U2dExQKzhyL3ZnMnEwY3p1WURlUmxRNHdo?=
 =?utf-8?B?OVVjQmJ0TlpFTFY1SjExL0g0alVsS3ZzQ3VkOUVwZmkycDFzREFpNDljcXUr?=
 =?utf-8?B?ZHNNRFUxeENJa1FuNlpRc0J0RWxlMDlDblJaRkVCUWhZcFlFV0RuOVhVN3h1?=
 =?utf-8?B?Z2FMYkI2RXlqZ0VGYTcvcXVjdEtYUFhQcWhXYnREUmlJYnRNN2pPNUhuamF6?=
 =?utf-8?B?TERESjVjRWFORlpXUXVpOXRpMkxGUDVEQmdsdmRFaTZTY05FWWovZTZWdmRH?=
 =?utf-8?B?bmp5MDVmUWhSdDVHOGthUXk4ZjNyaEZOa2JOM0FjUTcrWmlQYlJQaE9YYWVS?=
 =?utf-8?B?aUEveWF3VTdkSUlIRVRuYlJ2enJlbTNYZlVESjN1bkdWaGZWSDZzTjZFOUFH?=
 =?utf-8?B?VW5XYWFKaHpyQ1NNeW5reHltUWg3UHBaM01LZ0h3YzhnNFptZ2ZGSVB2UU9G?=
 =?utf-8?B?L0xibDR3UFd1c3hrcXVOMlhYMGlRb3dNY0FCOW1zYjhZR2djbkMwNm5WL3ht?=
 =?utf-8?Q?dq7w8MPzHoS0+FwMVc+jzooRC4VABZrcJpg9YC8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca29f30-0fa2-48e8-c66c-08d8cc64b03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:06:49.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjPHpSdTdyhdGwz9kbXZK+vp8pkQ8rKMcfuBzwsJGU4NE9bvR7wc+oCe7oh4Dn2dWqMm0fxcYC9GrhNtvMkc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDgsIDIwMjEg
NTowMSBBTQ0KPiBUbzogU2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz47IEFyZCBCaWVz
aGV1dmVsDQo+IDxhcmRiQGtlcm5lbC5vcmc+OyBLYW5lZGEsIEVyaWsgPGVyaWsua2FuZWRhQGlu
dGVsLmNvbT4NCj4gQ2M6IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnPjsgQUNQSSBEZXZlbCBNYWxpbmcNCj4gTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5l
bC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVCBBUkNISVRFQ1RVUkUNCj4gKEFD
UElDQSkgPGRldmVsQGFjcGljYS5vcmc+OyBXeXNvY2tpLCBSYWZhZWwgSg0KPiA8cmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb20+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IE1vb3JlLA0K
PiBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IFJldmVydCAiQUNQSUNBOiBJbnRlcnByZXRlcjogZml4IG1lbW9yeSBsZWFrIGJ5IHVzaW5nDQo+
IGV4aXN0aW5nIGJ1ZmZlciINCj4gDQo+IE9uIFNhdCwgRmViIDYsIDIwMjEgYXQgMTE6NDkgQU0g
U2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBTYXQs
IEZlYiAwNiwgMjAyMSBhdCAwOTo0OTozN0FNICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgMzJjZjFhMTJjYWQ0MzM1OGU0N2RhYzgwMTQzNzlj
MmYzM2RmYmVkNC4NCj4gPiA+DQoNCkhpIEJvYiwgQXJkIGFuZCBSYWZhZWwsDQoNCj4gPiA+IFRo
ZSAnZXhpc2l0bmcgYnVmZmVyJyBpbiB0aGlzIGNhc2UgaXMgdGhlIGZpcm13YXJlIHByb3ZpZGVk
IHRhYmxlLCBhbmQNCj4gPiA+IHdlIHNob3VsZCBub3QgbW9kaWZ5IHRoYXQgaW4gcGxhY2UuIFRo
aXMgZml4ZXMgYSBjcmFzaCBvbiBhcm02NCB3aXRoDQo+ID4gPiBpbml0cmQgdGFibGUgb3ZlcnJp
ZGVzLCBpbiB3aGljaCBjYXNlIHRoZSBEU0RUIGlzIG5vdCBtYXBwZWQgd2l0aA0KPiA+ID4gcmVh
ZC93cml0ZSBwZXJtaXNzaW9ucy4NCg0KU2luY2UgdGhpcyBjb2RlIHJ1bnMgb24gYmFzaWNhbGx5
IGV2ZXJ5IF9ISUQgYW5kIF9DSUQgaW52b2NhdGlvbiwgSSB3b3VsZCBoYXZlIGV4cGVjdGVkIHRo
aXMga2luZCBvZiByZXZlcnQgdG8gY29tZSBpbiBmb3Iga2VybmVscyB0aGF0IGRvIG5vdCB1c2Ug
aW5pdHJkIG92ZXJyaWRlLi4uIFNvIGl0IHNvdW5kcyBsaWtlIHRoZXJlIGlzIGEgZGlmZmVyZW5j
ZSBiZXR3ZWVuIGhvdyBwYWdlcyBhcmUgbWFwcGVkIGZvciBpbml0cmQgdGFibGUgb3ZlcnJpZGVz
IGFuZCB0YWJsZXMgZXhwb3NlZCB0aHJvdWdoIHRoZSBYU0RUIGZvciBBUk0uLiBJIHRoaW5rIGl0
IHdvdWxkIGJlIGVhc2llciBmb3IgdXMgdG8gbWFrZSB0aGVzZSBmaXhlcyBpbiB0aGUgZnV0dXJl
IGlmIHdlIGNvdWxkIGFsbCBjb21lIHRvIGEgY29uc2Vuc3VzIG9uIHdoZXRoZXIgaWYgd2Ugc2hv
dWxkIGFzc3VtZSB0aGF0IHRoZXNlIHBhZ2VzIGFyZSB3cml0YWJsZSBvciBub3QuDQoNClNob3Vs
ZCB3ZSBhc3N1bWUgdGhhdCBhbGwgQUNQSSB0YWJsZXMgYXJlIG5vbi13cml0YWJsZSBhbmQgcmVh
ZCBvbmx5IHJlZ2FyZGxlc3Mgb2YgaW5pdHJkIG92ZXJyaWRlIGFuZCBhcmNoaXRlY3R1cmU/DQoN
Cj4gPiA+DQo+ID4gPiBDYzogUm9iZXJ0IE1vb3JlIDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPg0K
PiA+ID4gQ2M6IEVyaWsgS2FuZWRhIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+ID4gPiBDYzog
IlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gPiBD
YzogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQo+ID4gPiBSZXBvcnRlZC1ieTogU2hhd24g
R3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVz
aGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4NCj4gPiBUZXN0ZWQtYnk6IFNoYXduIEd1byA8
c2hhd24uZ3VvQGxpbmFyby5vcmc+DQo+IA0KPiBBcHBsaWVkLCB0aGFua3MhDQo+IA0KPiBFcmlr
LCB0aGUgdXBzdHJlYW0gd2lsbCBuZWVkIHRvIHN5bmMgdXAgd2l0aCB0aGlzIHJldmVydC4NCg0K
T2sgc291bmRzIGdvb2QuDQoNCkVyaWsNCg==
