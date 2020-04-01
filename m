Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0719B7F1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Apr 2020 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgDAVzR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Apr 2020 17:55:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:33086 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbgDAVzR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Apr 2020 17:55:17 -0400
IronPort-SDR: hDrvLfXTRpr7d8ZVKwBKkjlPeoCE50hjSyzuE8hDfhI+BitszEF0TUf0WR55ocfp9wPIfDt7rz
 KzZaOXo/RLWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 14:55:16 -0700
IronPort-SDR: SI31RKCH03Ysov5qWPvre2uuILxLP9cHATE/L26X929Gs2tMWByNHH+K7u320bQiUxWs3ZRhkW
 qqI/SWl0GI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="449377887"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2020 14:55:16 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 14:55:16 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 14:55:15 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 14:55:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 14:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPWE7hoUHPzGH8RvOtRYnPPQfHvaFGKkWrPDPG5F/S2Xhv1c4hnNG+aYye1YaAMKf+/zodUBnTRCLxw2yyTr1bgPcMk1O5+Mac8T/PUrrScyzzazQM6WkdHzxDw6gVzNH2E7MZuSdk9DsiP0449fj0IRk+HLS87Ed/YnQMfEz3zg9bjOtMxv3ogPEi88gIuM/PJBT0r2qKho4tL7I/5U3CSMa33qv46orXh4WNHdojJRGA9rC5m/VrCdwVMQOyvNfD4syhXHxezb2ggpS+R00CIetXAlSYGS/3UV6bS0N/U4agWdfrrHH/HPz9mNgDeK0kaMLrHzuxKZBpvmHdCKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJDvoaAezW4adzYrGxcBsycGI2MfGbNpsin64ag4K8s=;
 b=K74WECsGDIkrXlUTVr73yWmORawDUjFotQc0aR7F9tVf/FTsMVApttJScVtgdPdSFqBDL268mxlK6hyVGkZBh/vM8CPvLvs0DS7y8oH5H98ZTKl3ulHIXAgNncRb7/38J6JcZqSI6dulmDPjFWchFiQwZjsJGenhQgreRRhaHPFLyYOKmxg1ciHQ/rVc4TcFsJJbmDgTE5Fn0zzlvizshSKe71mCr33WeoNdrUyf1JtKztv0HfzBNB1N5gtfQ6ZjVzejAI0aCfAeIu6tVM7tt5d+bqFqhMTcyeeTLzoKqArOxUuco+45F5rTDmTv8pwNXXsqBfg0Tp/3dxR/Pq7oFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJDvoaAezW4adzYrGxcBsycGI2MfGbNpsin64ag4K8s=;
 b=NvO71/kNKYTu0dyOMrLLLCyFf0TVeG49oZ76xgd3IA8biE+PZauOTbpCiBiNKAVmg2JRhQBJosweFfIWO2fxGf+y/w8ZpJPVs7KHTGVGwpNp7kuXdI85ZLz4nwKCdYk+Qu+qtSWZYzDggFYpX6R/yixqd7hoCwKIHbjx6gcNF+M=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1589.namprd11.prod.outlook.com (2603:10b6:910:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 21:55:07 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad%11]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 21:55:07 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] acpica: clear global_lock bits at FACS initialization
Thread-Topic: [PATCH] acpica: clear global_lock bits at FACS initialization
Thread-Index: AQHWBnGD5Rg0jHRzck+SrWIXSlQtE6hj/kIAgADEq9A=
Date:   Wed, 1 Apr 2020 21:55:06 +0000
Message-ID: <CY4PR11MB171939B742CF12CD476E6BCEF0C90@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200330085852.31328-1-jengelh@inai.de>
 <CAJZ5v0iMJYG1ptdoeiHVo21NqhWBVPw691LJ5=3oRMA7OMQ91Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iMJYG1ptdoeiHVo21NqhWBVPw691LJ5=3oRMA7OMQ91Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [192.55.52.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a80edad-53e1-4e2e-4340-08d7d6875754
x-ms-traffictypediagnostic: CY4PR11MB1589:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1589737B63D1ABF741E9368FF0C90@CY4PR11MB1589.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(376002)(366004)(136003)(346002)(396003)(186003)(4326008)(76116006)(53546011)(316002)(8936002)(66446008)(64756008)(2906002)(66476007)(54906003)(6636002)(66946007)(7696005)(71200400001)(6506007)(52536014)(66556008)(9686003)(966005)(110136005)(33656002)(81156014)(8676002)(478600001)(81166006)(55016002)(26005)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvfGNJqpDk0+kCJRgvg4ggRdv/XdcLHn3DgveaUZ1gkrUQUoK04zGQIZnhr54dv3x845Ao/HmJs1MRoj/75M/pdZSeK0aidcR/LVoIPUwOnVchYSilL7AWPFhqq+c2kINpLGe5/jb0kcOAkFkw/51E6bJ3LS2+Y8tI3BoD1YGKtJkeCRSYSR7MhuVawp5QF5ftROa7Ax3ExYiet62c84lTgKX7L1XtI0z+P+Wuqsg0nF4rjsmxUYOwCcIgUTFuANDdctWoTIYgPIeDQeB6U/mtwkvhznspvf5s9JoyKVGrrCncKBDdenswxkDIf3yEcLcC7qZfh6gIKjGFEa0KllTmxAAWRRbcQSiNapSn5FALeytXJ+PYWZWQskTEj6RJ3QmaA8hJ17UMiPCG5FC33gXHTrm2c6Q/hTI1Kw+ID92WzVyw3LJNviJ27CT/HInLZ0wT0ZyRD564xPlfcPrPnZBj3CACOwBIS6hcdKqegYIAwY2sHA9tlURTX3bj6cfnK5zsAIBeiRlumb+LmJD5pQ1w==
x-ms-exchange-antispam-messagedata: IBOJ4kyrksnfT5+v69Xxf1wqWijwe+YG7KmcNSii7reiiSdtyEz8xCLCgZ69WevsiviK+tWHq8YVxVerPJ81vawOMIwY9we2OEghEnbRQZp6wtJu4qNxIICNQHAw9eZGGNNgJ/QB09R6rdoRcDu8Mg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a80edad-53e1-4e2e-4340-08d7d6875754
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 21:55:06.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMnLhZF8EGWwd0QGrx5X/mpSXZE/y8ModrHCE9SQ9Qxb2OQ26YP/lisctuNpkiXrhQVth/Pm7O3IdMx/yfMAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1589
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwg
MSwgMjAyMCAyOjEyIEFNDQo+IFRvOiBKYW4gRW5nZWxoYXJkdCA8amVuZ2VsaEBpbmFpLmRlPjsg
S2FuZWRhLCBFcmlrDQo+IDxlcmlrLmthbmVkYUBpbnRlbC5jb20+OyBNb29yZSwgUm9iZXJ0IDxy
b2JlcnQubW9vcmVAaW50ZWwuY29tPg0KPiBDYzogV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdA0KPiA8bGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYWNwaWNhOiBj
bGVhciBnbG9iYWxfbG9jayBiaXRzIGF0IEZBQ1MgaW5pdGlhbGl6YXRpb24NCj4gDQo+IE9uIE1v
biwgTWFyIDMwLCAyMDIwIGF0IDEwOjU4IEFNIEphbiBFbmdlbGhhcmR0IDxqZW5nZWxoQGluYWku
ZGU+IHdyb3RlOg0KPiA+DQpIaSBKYW4sDQoNCkkndmUgYmVlbiByZWFkaW5nIHRoZSBBQ1BJIHNw
ZWMgYW5kIHRoZXJlJ3Mgbm90aGluZyBzdGF0ZWQgYWJvdXQgd2hhdCB0aGUNCmluaXRpYWwgc3Rh
dGUgb2YgdGhlIGxvY2sgc2hvdWxkIGJlLi4uIFRoaXMgcGF0Y2ggaXMgYXNzdW1pbmcgdGhhdCB0
aGUgbG9jayBzaG91bGQNCmJlIGZyZWUgd2hlbiB0aGUgRkFDUyBpcyBiZWluZyBpbml0aWFsaXpl
ZCBhbmQgSSBkb24ndCB0aGluayB0aGlzIGlzIGEgc2FmZQ0KYXNzdW1wdGlvbiB0byBtYWtlLg0K
DQpXaGF0IGlmIHRoaXMgaXMgYSBsZWdpdGltYXRlIGFjcXVpc2l0aW9uIGJ5IGFuIFNNSSBoYW5k
bGVyIHZlcnkgZWFybHkgaW4gT1MgYm9vdD8NCg0KPiA+IFdoZW4gdGhlIGZpcm13YXJlIFJPTSBz
dXBwbGllcyBhIEZBQ1MgdGFibGUgd2l0aCBnYXJiYWdlLCBhbmQgdGhlDQo+ID4gZmlybXdhcmUg
Y29kZSBkb2VzIG5vdCBjbGVhciB0aGUgZ2xvYmFsX2xvY2sgZmllbGQgYmVmb3JlIGJvb3Rpbmcg
dG8gYQ0KPiA+IGxvYWRlci9PUywgdGhlIGdhcmJhZ2UgYnl0ZXMgaW4gdGhhdCBmaWVsZCAobGlr
ZSAweGZmZmZmZmZmKSBjYW4NCj4gPiBpbmRpY2F0ZSB0aGF0IHRoZSBsb2NrIGlzIHRha2VuIHdo
ZW4gaXQgaXMgbm90LCB0aGVyZWJ5IHByZXZlbnRpbmcNCj4gPiBvYnRhaW5pbmcgc2FpZCBsb2Nr
IGV2ZW4gdGhvdWdoIGl0IGlzIG90aGVyd2lzZSBwZXJmZWN0bHkgdXNhYmxlIGlmDQo+ID4gdGhl
IGZpZWxkIHdlcmUgbm90IHByZXBvcHVsYXRlZCB3aXRoIGdhcmJhZ2UuDQoNCkhvdyBkbyB3ZSBr
bm93IHRoYXQgdGhlIGxvY2sgaXMgdGFrZW4gd2hlbiBpdCBpcyBub3Q/DQoNCkVyaWsNCj4gPg0K
PiA+IFJlc2V0IHRoZSBsb2NrIHRvIGEga25vd24gZ29vZCBzdGF0ZSB1cG9uIEFDUEkgaW5pdGlh
bGl6YXRpb24uDQo+ID4NCj4gPiBSZWZlcmVuY2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIwNjU1Mw0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBFbmdlbGhh
cmR0IDxqZW5nZWxoQGluYWkuZGU+DQo+IA0KPiBCb2IsIEVyaWssIHBsZWFzZSBsZXQgbWUga25v
dyBpZiB5b3Ugd2FudCBtZSB0byBhcHBseSB0aGlzIGRpcmVjdGx5IG9yIHlvdQ0KPiBwcmVmZXIg
dG8gcm91dGUgaXQgdGhyb3VnaCB0aGUgdXBzdHJlYW0uDQo+IA0KPiA+IC0tLQ0KPiA+DQo+ID4g
IGRyaXZlcnMvYWNwaS9hY3BpY2EvdGJ1dGlscy5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9h
Y3BpY2EvdGJ1dGlscy5jDQo+ID4gYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RidXRpbHMuYyBpbmRl
eCBjNWYwYjhlYzcwY2MuLjI2YmRiYzU4NWQ3ZQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvYWNwaS9hY3BpY2EvdGJ1dGlscy5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS90
YnV0aWxzLmMNCj4gPiBAQCAtNTYsNiArNTYsOSBAQCBhY3BpX3N0YXR1cyBhY3BpX3RiX2luaXRp
YWxpemVfZmFjcyh2b2lkKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZmYWNzKSk7DQo+ID4gICAgICAgICAg
ICAgICAgIGFjcGlfZ2JsX0ZBQ1MgPSBmYWNzOw0KPiA+ICAgICAgICAgfQ0KPiA+ICsgICAgICAg
LyogQ2xlYXIgcG90ZW50aWFsIGdhcmJhZ2UgZnJvbSB0aGUgaW5pdGlhbCBGQUNTIHRhYmxlLiAq
Lw0KPiA+ICsgICAgICAgaWYgKGZhY3MgIT0gTlVMTCkNCj4gPiArICAgICAgICAgICAgICAgZmFj
cy0+Z2xvYmFsX2xvY2sgJj0gfjB4MzsNCj4gPg0KPiA+ICAgICAgICAgLyogSWYgdGhlcmUgaXMg
bm8gRkFDUywganVzdCBjb250aW51ZS4gVGhlcmUgd2FzIGFscmVhZHkgYW4NCj4gPiBlcnJvciBt
c2cgKi8NCj4gPg0KPiA+IC0tDQo+ID4gMi4yNi4wDQo+ID4NCg==
