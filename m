Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A20380EFD
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhENReI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 13:34:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:9705 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235111AbhENReH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 13:34:07 -0400
IronPort-SDR: iJooTpP+2XJ8fxks51UEC0BD22Cb6P2nt4WZqpqTPaSx51GZATWnpRBZOu87Yn+pgxJsxgCn8N
 bl6JlEi04Oow==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200264082"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="200264082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 10:32:55 -0700
IronPort-SDR: eqrafnxC9vBSjXUPGc5720sTNhefvd26xiHJQPin1X6aoXNfiFY7ue+BnIJ1AEoEYTIHuQZdhB
 N4Xeu3m7tWaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431798241"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2021 10:32:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 14 May 2021 10:32:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 10:32:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 10:32:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 14 May 2021 10:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD7gO2GNoIuX/yMjRC3K0U5l3oUFaqrDIrjymVz4C25d705tbks2rBdmT3P2YkTHwMSRzvWRwxDOH3W27uDiX6TZVwFZAldGpNyuP4zI9jHbORYlSRgbK+yUxdCi4AY2f7mh1TI4SHMQH3yW1sn8/j2H5kMMbxeSO0ybc+kVuY27+3X8lXVp/5f1+ezlL24wcf8cxRIxGXy3O2SswJWCAvGjimz18ACM9efx9gSIpN3VsnZfIxevFW5HFh4xCvLSa1L2T9Jjv88pDice7L4B++TP8Q6RXfwlrP+l5/dJ/57XPZg1Xo/LCs0ANCQf2vfnw8KEWgD3JoKDYB3D2bMJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCGNKZMTviVGzvRPh7lu46Nn+pkXeBjs+fAeGSyhoCw=;
 b=lvy2t+uj+FP/h9WIMiQkXoYsqQys5otd+lwHqX0RxJlprskY3KmaY9oYMZwQBzFA14DQrAnJ4UzuYfOFWF6U7VcOStPwm3Q9w9Q4VfOukQ0T4mUOUqFTpiw4zA1eFR3iMohVHDdv7tFrMzGMAido1mlGl849crMg7jd8nl3D0EeqULEWW71Bmp2f1mnzBsFxjTkL5FIJIcLsNLrLnYv4/RCs+foElQ9bcMa3SnA7Rii6XFBMKiGFLlGObz9lp+zf8FupTpsPZ926voY5HXqJYlyJxu5tB79P2/5ARnET3ok+/1auwhj3epk4/eoSCnu2FcHEzsH1ec8guQoIPAX3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCGNKZMTviVGzvRPh7lu46Nn+pkXeBjs+fAeGSyhoCw=;
 b=d3h8O0f73gkFW4xYo1a91BHBT0CLRN+v6ahUbiszn6FjWf/bBhP7nsmwPOmHZRYL83hrmJi99l53d6gqVF5y2cDM9yE3BFV7xvGMVFjLClomhd2EIhrw2yrYv6T3omVP2lj/NuKxufHymEMfrR4om0VzDuvot/L80moI1PPQACE=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 17:32:43 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4108.036; Fri, 14 May 2021
 17:32:43 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     =?utf-8?B?RmFiaWFuIFfDvHRocmljaA==?= <me@fabwu.ch>
CC:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v3 1/2] ACPI: Add _PLD panel positions
Thread-Topic: [PATCH v3 1/2] ACPI: Add _PLD panel positions
Thread-Index: AQHXRPB/wmBcANfunEiQunHYli/lAqrjQ9HQ
Date:   Fri, 14 May 2021 17:32:43 +0000
Message-ID: <MWHPR11MB1599FF3DE5721065D8DB640AF0509@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210413063435.18111-1-me@fabwu.ch>
 <20210414083022.25453-1-me@fabwu.ch> <20210414083022.25453-2-me@fabwu.ch>
 <CAJZ5v0ich7DA47ybP552MJJg6-TkShnJyGcrz0PpWYETHHREHQ@mail.gmail.com>
 <9cd3609d-238c-afb1-5976-8fb5577c8a3d@fabwu.ch>
In-Reply-To: <9cd3609d-238c-afb1-5976-8fb5577c8a3d@fabwu.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: fabwu.ch; dkim=none (message not signed)
 header.d=none;fabwu.ch; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.17.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1cce40-c049-40ee-56e0-08d916fe4801
x-ms-traffictypediagnostic: MW3PR11MB4681:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4681610CAEB50285F8D498ECF0509@MW3PR11MB4681.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4L6fRbgI9G557mF15wFu5/DjWRaCcrA/ZEpqZq6Rgs5e2y+qGl70vcTLUOo+degkOhtmtroAx8aPO73r987dp3Eyb9FgZSSNkI0QYjKDQP6uMfTxyqY0V4ZiW0EKmzZ3wt914h/V6oCkEhA8xEkVFUCgdCK4guMPH9Lohkpft17+3R9EMwVOz1Y5GBcQWbSMe+9zO90PH8hM5mjBkv4mMwwhy/0P2BucLnxqcLr/o54Y+esrQpqSvM21i9Rfj+V579LhpuKVMSLZxtJXbpKK+4tW3/Viap97Uy4LqEy5FalX+/0gZtMugyEkOKEUXNfjriX4ZcNzMXq7o7khsspvQrGfWHg9Er/KYwDOvYvpuzm+4bpxwK1fK0PVFGH4QRXO5o1O/3pSsVtAEOKGehNHRaljXfDqn5i/hgUy7A3UAM0VuDi9cqEk5gOrh42ZeRK9BtHOrZd/H+euyvog9a5Y8tqr1eg5MDbWGXa3UajyMkhi+XRHnDQM/bvwxqNgtIuzdl54W92lUjl3f076vBesYfWHTKT3TVa0HfXC1UukMSw6QSjDPrrreDvA4Hei1RrDXkzG3LXzZI1Kc2rrW2+dZuf5LG7C3WjK8YPuiqM+qQtZCaMUhBnu65y2k8Vi2cVEXM+d3M5agWM6dnBYL9ZmgGBm9JdD6XcCINVZQckRZmNGf1/U2mZHf+c4o7kBqx/w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39860400002)(6506007)(83380400001)(66574015)(76116006)(2906002)(6916009)(71200400001)(66446008)(66556008)(7416002)(186003)(86362001)(54906003)(7696005)(8936002)(33656002)(316002)(38100700002)(122000001)(9686003)(478600001)(55016002)(52536014)(66476007)(66946007)(64756008)(8676002)(26005)(966005)(5660300002)(53546011)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M0Vxa1NVT3JPcFpqL3JEVzFKTklqZEJyRGloK25YM2FvaGtBT1RiTU00S1Z1?=
 =?utf-8?B?R2R3SUJGZ3hmRURxYW5ONVd6bHJUWWhGMmQzOEZzRWdEa0hiLzZHR1QydTFF?=
 =?utf-8?B?WU80NUxmR0UvQlJMdnRGTDkrSWp5cGlEcDRaNGNLVzJBMlhtTElUcEh5cWNu?=
 =?utf-8?B?dHkxNTRkd3hvQm1KQSt0cWdDcWZSOThlVE1NVFFuaEM0V2xCelZpc1lUcEFl?=
 =?utf-8?B?LzIxV1k0QW0vOXJhSlZoNkQySVgremlMYTdvRU9qdmFCVmlveVIzeHRlWnJL?=
 =?utf-8?B?MXJ0dG10WUQwdFdLd3U0VUxEejZhUlZCcFI3dW0zR2RJdDVYWmxLNkl0RzVt?=
 =?utf-8?B?eThOV0JCRUNwb0dreE93OWpOMHpLS2RlU1JYczA3QjlGNjhtVy9uTzZOcXMx?=
 =?utf-8?B?SWorWnZ1SDhNQlNMa3VLL255ZytJekI5UzEyMkZyOVpvd1FEajJHdzJ1NDlV?=
 =?utf-8?B?Qm9DaVlhQWZXSzRQMk1qbzZIL1J2NTMwc040TzVCQ0VuaExHYjRnT3NaQWlw?=
 =?utf-8?B?S2FKaHkrZnkwaFB5NFpySitVcmR3Q001OExLUk9oTkdKVjlHczVkQjlIWkVX?=
 =?utf-8?B?U29Hd3ZlMTdHckJkUmx2Z08xYjIxWUkzQlBkbC9oQThSOUhib0xqWVpjSFRQ?=
 =?utf-8?B?c3R6K0NGMU1ObU85dVppcG1nTUNhUkszVzFmb3pFcXZOUUhMOWEva29BblA3?=
 =?utf-8?B?ZzJ4STQ2eUNqR2lBWXQ3OTB0NjNJa0ZGYTJaR2RpNDJ0ZXlDK3VnM1I0NHY0?=
 =?utf-8?B?VVVTR282NjNkeVFOM0psRklxRFJmTWZsbEZwa1ltZTdhclZzeGZvTkRBaUxG?=
 =?utf-8?B?a0kvM0JDWklnaHRqaGFrT2NrSm9MNFVaT2JVdTJmZ282Y1VoL2x6Q3lEbmlC?=
 =?utf-8?B?b0IxMjduTGxWQTVkRXlRQ0wwNDQzd2ZTWlc5K2g1Nm1jSk9BcjR6bU5ySUhn?=
 =?utf-8?B?bXk2ZE9zUUx2ZFh3Y0xJcGRycTl2QWhYemx1ZC9NTG5lNFROOHI4YW5MUGI4?=
 =?utf-8?B?ODdGMlBUc3dRRXYwdVk4OTNYK0FMUlNzSllFRitCb0pmNThBcFJtcS96RG4v?=
 =?utf-8?B?SStEa3o5U0ViZ2MvZEtuMXhCZ05aODVrSnliZXV0Z01VSW96QzBiRllySkN2?=
 =?utf-8?B?L1p0ZGhWS0JPVjg5RUZiUk9vTVpEMjJOdyszYTF2WTNIREJvTjJ3a1hiQlJJ?=
 =?utf-8?B?d1l4aXVJemZJalNVQjYxUUJTK0lRZHNjMnRXU3FwNTA5dmdXaGZmd2h6ekJD?=
 =?utf-8?B?SFBPMmdxWW5TcjZmMDJuaTZKQ0NPWEl5aDBFQjBqemM1RXdGdVplR0xtdi80?=
 =?utf-8?B?b1lkSmwyeVllY1I4NWdKOHYwVlBJSkVxTGNNbjF2aEFmbWFPRXhSeWErY3ln?=
 =?utf-8?B?U0RBVytWMHdxVEpYWFpDelpBMkVxSTNZMTdrWjhqZFdRbWdGTTN6azIvQUt4?=
 =?utf-8?B?ZVZuSTlxVEJuRTRNd3h3NU9ua25KUHVaellFWEw3bytSRW9pNFdySFAwZzhF?=
 =?utf-8?B?U2ZNRWpncGY3cmQ2VDh3N2ErOVptZlZKaDAwQ3dDdzJIVWVvb1ZQeEhUMDJR?=
 =?utf-8?B?MFJabjJwMGVzY3lkY3V6dmtBb1lPVU8zamtlUjJYNkZBMXVSeTNLM3JNeWhN?=
 =?utf-8?B?c1hjeXpkbGFXaFZtUmt0WmVEK1FpTGlodldJNmZSMFJhMlhOQ3BZa0lnVG42?=
 =?utf-8?B?YnBFNXdJSktZUUp1aWFPbDR2bi9JN0tHUE5EaHVTU0JZeERSVDBCV1oxbjhx?=
 =?utf-8?Q?cP9IjG2DTMxRcSBJHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1cce40-c049-40ee-56e0-08d916fe4801
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 17:32:43.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7uT5n59vNmAslMV3/Ca917amWW2+Vi9p5hor02VpWdRQitlLLrhxWh2hYu+U2yu8THV4rstH+5wUIA3IQqX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaWFuIFfDvHRocmlj
aCA8bWVAZmFid3UuY2g+DQo+IFNlbnQ6IFN1bmRheSwgTWF5IDksIDIwMjEgOToyOSBBTQ0KPiBU
bzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+IENjOiBMaW51eCBNZWRp
YSBNYWlsaW5nIExpc3QgPGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZz47IEFDUEkgRGV2ZWwN
Cj4gTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OkFD
UEkgQ09NUE9ORU5UDQo+IEFSQ0hJVEVDVFVSRSAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNhLm9yZz47
IEphY29wbyBNb25kaQ0KPiA8amFjb3BvQGptb25kaS5vcmc+OyBaaGksIFlvbmcgPHlvbmcuemhp
QGludGVsLmNvbT47IFNha2FyaSBBaWx1cw0KPiA8c2FrYXJpLmFpbHVzQGxpbnV4LmludGVsLmNv
bT47IENhbywgQmluZ2J1IDxiaW5nYnUuY2FvQGludGVsLmNvbT47IERhbg0KPiBTY2FsbHkgPGRq
cnNjYWxseUBnbWFpbC5jb20+OyBRaXUsIFRpYW4gU2h1IDx0aWFuLnNodS5xaXVAaW50ZWwuY29t
PjsNCj4gTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBNb29yZSwg
Um9iZXJ0DQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsNCj4gTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
MS8yXSBBQ1BJOiBBZGQgX1BMRCBwYW5lbCBwb3NpdGlvbnMNCj4gDQo+IEhpIEVyaWssDQo+IA0K
SGkgRmFiaWFuLA0KDQo+IERvIEkgbmVlZCB0byBhZGQgYW55dGhpbmcgdG8gdGhpcyBwYXRjaCBv
ciBpcyBpdCBmaW5lIGxpa2UgdGhhdD8NCg0KU29ycnkgYWJvdXQgdGhlIGxhdGUgcmVzcG9uc2Uu
IEkgc3VibWl0dGVkIGEgcHVsbCByZXF1ZXN0IG9uIHlvdXIgYmVoYWxmIGZvciBBQ1BJQ0EgdXBz
dHJlYW0gaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2EvcHVsbC82ODkNCg0K
SSdsbCBwb3J0IGl0IHRvIExpbnV4IGFuZCBjaXJjdWxhdGUgb24gdGhpcyBtYWlsaW5nIGxpc3Qg
YWZ0ZXIgQUNQSUNBIGRvZXMgYSByZWxlYXNlICh1c3VhbGx5IGFib3V0IG9uY2UgcGVyIG1vbnRo
KS4NCg0KVGhhbmtzLA0KRXJpaw0KPiANCj4gVGhhbmtzLA0KPiBGYWJpYW4NCj4gDQo+IE9uIDE0
LjA0LjIxIDE1OjUwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiBPbiBXZWQsIEFwciAx
NCwgMjAyMSBhdCAxMDozMCBBTSBGYWJpYW4gV8O8dGhyaWNoIDxtZUBmYWJ3dS5jaD4NCj4gd3Jv
dGU6DQo+ID4+DQo+ID4+IFRoZSBBQ1BJIHNwZWNpZmljYXRpb24gdjYuMyBkZWZpbmVzIHRoZSBw
YW5lbCBwb3NpdGlvbnMgaW4gY2hhcHRlciA2LjEuOA0KPiA+PiAiX1BMRCAoUGh5c2ljYWwgTG9j
YXRpb24gb2YgRGV2aWNlKSINCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRmFiaWFuIFfDvHRo
cmljaCA8bWVAZmFid3UuY2g+DQo+ID4+IFJldmlld2VkLWJ5OiBEYW5pZWwgU2NhbGx5IDxkanJz
Y2FsbHlAZ21haWwuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+DQo+ID4gVGhpcyBpcyBBQ1BJQ0EgbWF0ZXJpYWwu
DQo+ID4NCj4gPiBFcmlrLCBjYW4geW91IHBpY2sgdXAgdGhpcyBvbmUsIHBsZWFzZT8NCj4gPg0K
PiA+PiAtLS0NCj4gPj4gIGluY2x1ZGUvYWNwaS9hY2J1ZmZlci5oIHwgOSArKysrKysrKysNCj4g
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvYWNwaS9hY2J1ZmZlci5oIGIvaW5jbHVkZS9hY3BpL2FjYnVmZmVyLmgNCj4g
Pj4gaW5kZXggMTgxOTdjMTYxNDlmLi5kNDJlODJhODI4NTIgMTAwNjQ0DQo+ID4+IC0tLSBhL2lu
Y2x1ZGUvYWNwaS9hY2J1ZmZlci5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY2J1ZmZlci5o
DQo+ID4+IEBAIC0yMDcsNCArMjA3LDEzIEBAIHN0cnVjdCBhY3BpX3BsZF9pbmZvIHsNCj4gPj4g
ICNkZWZpbmUgQUNQSV9QTERfR0VUX0hPUklaX09GRlNFVChkd29yZCkgICAgICAgIEFDUElfR0VU
X0JJVFMNCj4gKGR3b3JkLCAxNiwgQUNQSV8xNkJJVF9NQVNLKQ0KPiA+PiAgI2RlZmluZSBBQ1BJ
X1BMRF9TRVRfSE9SSVpfT0ZGU0VUKGR3b3JkLHZhbHVlKSAgQUNQSV9TRVRfQklUUw0KPiAoZHdv
cmQsIDE2LCBBQ1BJXzE2QklUX01BU0ssIHZhbHVlKSAgICAgIC8qIE9mZnNldCAxMjgrMTY9MTQ0
LCBMZW4gMTYgKi8NCj4gPj4NCj4gPj4gKy8qIFBhbmVsIHBvc2l0aW9uIGRlZmluZWQgaW4gX1BM
RCBzZWN0aW9uIG9mIEFDUEkgU3BlY2lmaWNhdGlvbiA2LjMgKi8NCj4gPj4gKyNkZWZpbmUgQUNQ
SV9QTERfUEFORUxfVE9QICAgICAgICAgICAgICAgICAgICAgMA0KPiA+PiArI2RlZmluZSBBQ1BJ
X1BMRF9QQU5FTF9CT1RUT00gICAgICAgICAgICAgICAgICAxDQo+ID4+ICsjZGVmaW5lIEFDUElf
UExEX1BBTkVMX0xFRlQgICAgICAgICAgICAgICAgICAgIDINCj4gPj4gKyNkZWZpbmUgQUNQSV9Q
TERfUEFORUxfUklHSFQgICAgICAgICAgICAgICAgICAgMw0KPiA+PiArI2RlZmluZSBBQ1BJX1BM
RF9QQU5FTF9GUk9OVCAgICAgICAgICAgICAgICAgICA0DQo+ID4+ICsjZGVmaW5lIEFDUElfUExE
X1BBTkVMX0JBQ0sgICAgICAgICAgICAgICAgICAgIDUNCj4gPj4gKyNkZWZpbmUgQUNQSV9QTERf
UEFORUxfVU5LTk9XTiAgICAgICAgICAgICAgICAgNg0KPiA+PiArDQo+ID4+ICAjZW5kaWYgICAg
ICAgICAgICAgICAgICAgICAgICAgLyogQUNCVUZGRVJfSCAqLw0KPiA+PiAtLQ0KPiA+PiAyLjMx
LjENCj4gPj4NCg==
