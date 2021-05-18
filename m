Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF095388264
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352610AbhERVtm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 17:49:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:42254 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236298AbhERVtk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 May 2021 17:49:40 -0400
IronPort-SDR: t/2ogTePujSYSvIz7YJOm04IKM/W1SWd29n0CGJSeQ16aS44JvjDWy2jwOdCNrJoMc8hOBqxtM
 sU6Sncwoo/VQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="264744361"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="264744361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:48:20 -0700
IronPort-SDR: K1d0gldoJqiVwfDFqcO2tTND/v4n2ZJMwPJw27smN4HfdhnWvqR3fcTpY1iEeCmuCVWbV0deE7
 fDCSOD5GKhtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439649759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2021 14:48:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 14:48:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 18 May 2021 14:48:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 18 May 2021 14:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGJgpFg2j+zMpOVfm3a8BYVzTH5XELtcRwhtce1cmzRl+reBDu8i17eUVCoFjMmoYk9mR1u8vaG36Fb9hjyKwGq8P2LcRPXYYz+1/DlOXvz+eqk6FNiqtSDhMwz4V5tJlmaNcY9yua39FWP7fGliaw65J1l3pBlJBluVcF04q+pjsEr0raS6Ze/G+2ap/l79RezEh4bKKghESQHviHgnRFtsi5q6bHEiHzy4zLY9r4KSAl2Fc055Dx65uJ79OH8nhGZXrZ37WeGghKVLLrTvsjij97DWepoGo63s1HRSAtR1vpD5Jv0A9+AhVK+40qTBMYYk6JtSflN/hHBXS+N67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvQAGfjQWBS3a1Vnb9XeEi6gXwUC2F+RBGkth3B/Vmc=;
 b=UMLJn7+PGijhLK7SU3y3iqkpv5RzaPJ2YEd3gBJqlC6/RwWA/hDZgyivFNxdaX3/N8PvmgeDhRJWsgjVoiw324FsGMExw0+u/DMu4FWN8P3U7l4FDCrN9F2Vxn0oRp6JBdq/klplheuE/zUZBwaq8phO9pCUw7CjtMv1DJrXH+dNGlSOYlC15fsm7qPgDC0gGhWY7uI3fg930P+LhcgXOrIEtmhGH419ms+j5mg7967ra+1RpyricgHhxXV5xRiZy4us8MyLAy7lGOCFUstyXD0TNnyKpFquvtt/+R/DVxh7k7GlL+7/STUJcv6HGjQQuqtcCQ4naYH/oZdU88E5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvQAGfjQWBS3a1Vnb9XeEi6gXwUC2F+RBGkth3B/Vmc=;
 b=axOpsvrf4mfzPg7zG16/fiQp9l3FBVkdLQGI1+Q0u6oknmO4GeD0xcheELccODiSRH/aHP++wCqvuoZqsxG/DcmbbZUViPA/gHCPopNnisrC4T3pOtTp5psNzTB9gHj73MIsyY6DKqdx5OSm8D4NMTHJ1mvFAw9XQc9C8+Wb4PM=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 21:48:18 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 21:48:18 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     John Garry <john.garry@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [bug report] Memory leak from acpi_ev_install_space_handler()
Thread-Topic: [bug report] Memory leak from acpi_ev_install_space_handler()
Thread-Index: AQHXKvy6WIVimUzZ4kCPI6jJ5nfkF6qnsRWAgAACOICAQlWCkA==
Date:   Tue, 18 May 2021 21:48:18 +0000
Message-ID: <MWHPR11MB1599342DCB12AEA5B7DD0D54F02C9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <845f6ef8-d2a7-e491-8405-9526e4ba277a@huawei.com>
 <CAJZ5v0gRm+jsd1KtLtSgT=4pc9oab=EtW=zqBuKjHLJ=ZcUkiA@mail.gmail.com>
 <752f16ed-29e3-840e-dc53-6fed24d73861@huawei.com>
In-Reply-To: <752f16ed-29e3-840e-dc53-6fed24d73861@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:39db:8e7d:a733:e8b9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27ca3c47-96a9-4e80-f533-08d91a46a60f
x-ms-traffictypediagnostic: CO1PR11MB5203:
x-microsoft-antispam-prvs: <CO1PR11MB5203822384B5570BF74DFA5BF02C9@CO1PR11MB5203.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zv3BF4TDETEVaynyN3PX30Go/I2po8ccQs9qZKz8YyHdrz3w9nfE5Enn+DnfibzKZ5lKEYLSyzaaOMxhlMd7pcvCS+LAdoynaWyZqyCjsYw6UQS5AU+SCqlEJ1khoemSXEmbSmYdR179+/qGJaYv2X7SqYkItc9mBfQni5ucMdKLYNpnokW1kDUlrqKs2LINjC4hDUhFX6VfUjPpMwqa+/VVFVXMIlB/PCWdnDHDVI8WUFY9+I8SKJCmVT98Z4+KqpV66p6bkCP4KrtT2+6zlxBxyjHhlllFC03xBpzhgUU4JzumdHtyKQqEiI7uw4mWu5LHcR9u07W7uXNIqv+6S7UiCZ44gI2kpxGJQ+bPhOUZPeBJyU6nNQwEZ8Vg6X4HSvldvKNPzUB//MRHm80pPtVH0JmKARcfnVb7yN7SFLt36pkk2jUO4sQEScips8wabH6vhqb6lyKCb8jqgx3qYkClFy30/DzdgnArb5yUf8MYJlosBQHkaIQ7uhhEDiokde3i/DpZVjNH021LgNqlt9E7GbK+v+eMfQk0VKDiO36eobPLANLHCJ3mV5Gx5toqiDcN8Vt3c2E9wC/K5JKktCcQ4uN7684AxpbbHv1ThGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(33656002)(71200400001)(9686003)(55016002)(66476007)(83380400001)(4326008)(5660300002)(64756008)(54906003)(6506007)(53546011)(110136005)(316002)(122000001)(38100700002)(52536014)(66446008)(8936002)(2906002)(186003)(76116006)(66946007)(478600001)(66556008)(7696005)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VVhIU2ZtSjZURVJuSitSUExHSkVxWE04QXR2UFNWemhJcWZzcHFadS9lV1VJ?=
 =?utf-8?B?QytMRVhrZGJtU3REMml3dFB3MzhOS0tnc2hNbzhTZWE4aU1VUHhDV2VUV3Uy?=
 =?utf-8?B?N0hlT29Lem94NkJhZkZ2V1c2eUNuaTM2QWc4bi9vY2IybGd5MHVBTTB5Y3Rk?=
 =?utf-8?B?SnBWVXFvWGMwSjUzT0EvcVVIaGF4VEhGMVN4RkExRFdUazVXMXRwYUpDQjlw?=
 =?utf-8?B?WDlZOC91MnEzZllJRlhRQktLQjRlL2NGZjY1bWhnY0JSdWFWT3lIVHVQSnZE?=
 =?utf-8?B?aHlvOWsxNWlZcXBJTFhiejU5akNkVE9aSTNJQzFTUVFjZytyMDc5NlFmeFhP?=
 =?utf-8?B?LzczWUZ4aDVrYUNKLzAyTzZYZUZNSVNnWm5Cd1NEVzlVcjF2UHZYN0xQRHpk?=
 =?utf-8?B?d1NGZzJZNTBwWmtMU0ZnZC9OMmMrZHkzMm45dVRmUlNqM1cra0tlYXVQVEYy?=
 =?utf-8?B?cnovMnNaOEk4djB0TXVtOVN2Qm1xMXV5K0xiZytOY3lyQWhlb1RzazhwWkdG?=
 =?utf-8?B?aVhDYjlLVy9xZGxCa3psZ1ZZNjVRRkczWmNpdGNCNGEzY0E4RlpkekJISkh5?=
 =?utf-8?B?Y1BZZzRrUTY3c05HWWdWNjk0YU1vZlBJd0lRUmw2OEltbk1LajNJM3RQTmw2?=
 =?utf-8?B?cEk0SXJXZ0twek9iYklmZUdmbHRDL2UwZXEvKzBJdC9FUVV1RkhSL2pJeHBp?=
 =?utf-8?B?UDFhbXI4cHZkOWU4UDhPdDFpRTdZamE1eHI4azlXN1U1ZUJRVFVDOHdvbk1v?=
 =?utf-8?B?QjdwRzZ4cmxGTnQwdGZZR3lZK0ZQNkxUai8vWVRwUURCbnpablBDNHdZUmY5?=
 =?utf-8?B?R2JFQXU1d2hLUlpST1JITUFUTVQveHpHeVFraGVPTDJ2ZjgyTEZGL2N5b1d2?=
 =?utf-8?B?L0sybFVLTDNYR3ZvTU4zMFNEQVNXb0xHMkhSeWtkV0JuWGttaGdGUXNLazdl?=
 =?utf-8?B?aG9MS2JXUUZmMzJGN2RQczk5bkx3SmdsUjBpVDVTc1dVRFRrY1VuWGExWGFW?=
 =?utf-8?B?T2hkcTF0bmRSYzlLaEdKNko1cFBNYWQ1SExvWUhZWVBSYnF5eWUzaFJvRDVi?=
 =?utf-8?B?cW1INGxaOWtsSlNxNmE3VEg2WFIyc1hVbWloOEMvVWIxSDBGS2w1NmpaT1h1?=
 =?utf-8?B?Vm1YVjZNckJZeGpIQVJ6d3VaSmJEOUNLcFVGZkFRWDVWQ2dUVjI0TU1LY2Ra?=
 =?utf-8?B?Wi9DRzJ6ZmF5VVdkbmRZdlBlbm54OG95NGpJSUo1NllwdEZRYmUwQUxSYnRl?=
 =?utf-8?B?TnloZjIra2NYRnJlYlRBRXZaSDhxNFYwSkd6R3E3MjZpVEVKSUNZWkRqNXJy?=
 =?utf-8?B?SDI3T0t0KzRINlNxcEovSkNVTkZRdWx6TnA5SDdld3JDMU5yTHJjbFZoY1Fz?=
 =?utf-8?B?cVdRYlVoQWhtREpCeU5yTWdDZWZOK0JWeXVJVWhPMzVyTjk2TXN6eUhxd2hG?=
 =?utf-8?B?a1VHNXlxTTZadUQ1dHVRMWZzRTd1dG0xdExFUXVaNlc4dE13RnBKREw3L1Za?=
 =?utf-8?B?aW5VVVN5NFBLNjl0eXpPbmMvdUdyL21KcHV0TGhrNGRNSUVqb3FnSzYxeko4?=
 =?utf-8?B?OExCTzhReHdQZm9POFkxQmxDMjA2VGVWZzgxT1hLNGI1N0dwREhqalVid2Zz?=
 =?utf-8?B?Tnk5RVh2YjZ3dC95SFhyNW9GMXBwdUhkeHNuYkFFNHJ5TVpHcmx6aE5VeDNj?=
 =?utf-8?B?MmNsamRTcUw1SGJLYW1JYWtrOXVQZmI2d291TXFLZTRhQm9CVDUyUmNNekpI?=
 =?utf-8?B?aVVYQ2ZPOVkxdUpYY0k2anlBTHB5VVY4VndETWZSdE5tUFJ0MXRHbW9RU2xl?=
 =?utf-8?B?eURNUUxjZHA4WkYzaGk2VHVQaWVLc1N5dHROZy91Qm9ZRkxiVEMxMU82UGpx?=
 =?utf-8?Q?lKtELGT+UDXLI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ca3c47-96a9-4e80-f533-08d91a46a60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 21:48:18.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5zi/tJiZdD535/dAkcKa0ipLKZ6dTUQVTUfPmyBmhO+uzE814xtGbV2ZQ8wouQM4oA0l3fDmajcM8hSxW3mwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeSA8am9o
bi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA2LCAyMDIxIDk6NDgg
QU0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gQ2M6IEFD
UEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGVuIEJy
b3duDQo+IDxsZW5iQGtlcm5lbC5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2Nr
aS5uZXQ+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W2J1ZyByZXBvcnRdIE1lbW9yeSBsZWFrIGZyb20gYWNwaV9ldl9pbnN0YWxsX3NwYWNlX2hhbmRs
ZXIoKQ0KPiANCj4gT24gMDYvMDQvMjAyMSAxNzo0MCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+ID4gT24gVHVlLCBBcHIgNiwgMjAyMSBhdCA1OjUxIFBNIEpvaG4gR2FycnkgPGpvaG4uZ2Fy
cnlAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4+DQo+ID4+IEhpIGd1eXMsDQo+ID4+DQo+ID4+
IE9uIG5leHQtMjAyMTA0MDYsIEkgZW5hYmxlZCBDT05GSUdfREVCVUdfS01FTUxFQUsgYW5kDQo+
ID4+IENPTkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUgZm9yIG15IGFybTY0IHN5c3RlbSwg
YW5kIHNlZQ0KPiB0aGlzOg0KPiA+DQo+IA0KPiBIaSBSYWZhZWwsDQo+IA0KPiA+IFdoeSBleGFj
dGx5IGRvIHlvdSB0aGluayB0aGF0IGFjcGlfZXZfaW5zdGFsbF9zcGFjZV9oYW5kbGVyKCkgbGVh
a3MNCj4gbWVtb3J5Pw0KPiA+DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoYXQgYWNwaV9ldl9pbnN0
YWxsX3NwYWNlX2hhbmRsZXIoKSBpdHNlbGYgbGVha3MgbWVtb3J5LA0KPiBidXQgaXQgc2VlbXMg
dGhhdCB0aGVyZSBpcyBzb21ldGhpbmcgbWlzc2luZyBpbiB0aGUgY29kZSB3aGljaCBpcyBtZWFu
dA0KPiB0byB1bmRvL2NsZWFuIHVwIGFmdGVyIHRoYXQgb24gdGhlIHVuaW5zdGFsbCBwYXRoIC0g
SSBkaWQgbWFrZSB0aGUgcG9pbnQNCj4gaW4gd3JpdGluZyAibWVtb3J5IGxlYWsgZnJvbSIsIGJ1
dCBtYXliZSBzdGlsbCBub3Qgd29yZGVkIGNsZWFybHkuDQo+IA0KPiBBbnl3YXksIEkgaGF2ZSBu
b3QgYW5hbHl6ZWQgdGhlIHByb2JsZW0gZnVsbHkgLSBJJ20ganVzdCByZXBvcnRpbmcuDQo+IA0K
DQpIaSBKb2huLA0KDQo+IEkgZG9uJ3QgbWluZCBsb29raW5nIGZ1cnRoZXIgaWYgcmVxdWVzdGVk
Lg0KDQpTb21lb25lIGVsc2UgcmVwb3J0ZWQgdGhpcyBhcyB3ZWxsLiBDb3VsZCB5b3UgdHJ5IHRo
ZSBwYXRjaCBiZWxvdz8gSSB0aGluayBpdCBtaWdodCBoZWxwIGZpeCB0aGlzIGlzc3VlLi4NCg0K
VGhhbmtzLA0KRXJpaw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0
ZS5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQppbmRleCA2MjRhMjY3OTRkNTUu
LmU1YmE5Nzk1ZWM2OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRkZWxldGUu
Yw0KKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQpAQCAtMjg1LDYgKzI4NSwx
NCBAQCBzdGF0aWMgdm9pZCBhY3BpX3V0X2RlbGV0ZV9pbnRlcm5hbF9vYmoodW5pb24gYWNwaV9v
cGVyYW5kX29iamVjdCAqb2JqZWN0KQ0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAg
ICBicmVhazsNCg0KKyAgICAgICBjYXNlIEFDUElfVFlQRV9MT0NBTF9BRERSRVNTX0hBTkRMRVI6
DQorDQorICAgICAgICAgICAgICAgQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9BTExPQ0FUSU9O
UywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKioqKiogQWRkcmVzcyBoYW5k
bGVyICVwXG4iLCBvYmplY3QpKTsNCisNCisgICAgICAgICAgICAgICBhY3BpX29zX2RlbGV0ZV9t
dXRleChvYmplY3QtPmFkZHJlc3Nfc3BhY2UuY29udGV4dF9tdXRleCk7DQorICAgICAgICAgICAg
ICAgYnJlYWs7DQorDQogICAgICAgIGRlZmF1bHQ6DQoNCiAgICAgICAgICAgICAgICBicmVhazsN
Cg0KPiANCj4gVGhhbmtzLA0KPiBKb2huDQo+IA0KPiA+PiByb290QGRlYmlhbjovaG9tZS9qb2hu
IyBtb3JlIC9zeXMva2VybmVsL2RlYnVnL2ttZW1sZWFrDQo+ID4+IHVucmVmZXJlbmNlZCBvYmpl
Y3QgMHhmZmZmMjAyODAzYzExZjAwIChzaXplIDEyOCk6DQo+ID4+IGNvbW0gInN3YXBwZXIvMCIs
IHBpZCAxLCBqaWZmaWVzIDQyOTQ4OTQzMjUgKGFnZSAzMzcuNTI0cykNCj4gPj4gaGV4IGR1bXAg
KGZpcnN0IDMyIGJ5dGVzKToNCj4gPj4gMDAgMDAgMDAgMDAgMDIgMDAgMDAgMDAgMDggMWYgYzEg
MDMgMjggMjAgZmYgZmYuLi4uLi4uLi4uLi4oIC4uDQo+ID4+IDA4IDFmIGMxIDAzIDI4IDIwIGZm
IGZmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwLi4uLiggLi4uLi4uLi4uLg0KPiA+PiBiYWNrdHJh
Y2U6DQo+ID4+IFs8MDAwMDAwMDA2NzBhMDkzOD5dIHNsYWJfcG9zdF9hbGxvY19ob29rKzB4OWMv
MHgyZjgNCj4gPj4gWzwwMDAwMDAwMGEzZjQ3YjM5Pl0ga21lbV9jYWNoZV9hbGxvYysweDE5OC8w
eDJhOA0KPiA+PiBbPDAwMDAwMDAwMmJkYmE4NjQ+XSBhY3BpX29zX2NyZWF0ZV9zZW1hcGhvcmUr
MHg1NC8weGUwDQo+ID4+IFs8MDAwMDAwMDBiY2Q1MTNmZT5dIGFjcGlfZXZfaW5zdGFsbF9zcGFj
ZV9oYW5kbGVyKzB4MjRjLzB4MzAwDQo+ID4+IFs8MDAwMDAwMDAwMmUxMTZlMj5dIGFjcGlfaW5z
dGFsbF9hZGRyZXNzX3NwYWNlX2hhbmRsZXIrMHg2NC8weGIwDQo+ID4+IFs8MDAwMDAwMDBiYTAw
YWJjNT5dIGkyY19hY3BpX2luc3RhbGxfc3BhY2VfaGFuZGxlcisweGQ0LzB4MTM4DQo+ID4+IFs8
MDAwMDAwMDA4ZGE0MjA1OD5dIGkyY19yZWdpc3Rlcl9hZGFwdGVyKzB4MzY4LzB4OTEwDQo+ID4+
IFs8MDAwMDAwMDBjMDNmNzE0Mj5dIGkyY19hZGRfYWRhcHRlcisweDljLzB4MTAwDQo+ID4+IFs8
MDAwMDAwMDAwMGJhMmZjZj5dIGkyY19hZGRfbnVtYmVyZWRfYWRhcHRlcisweDQ0LzB4NTgNCj4g
Pj4gWzwwMDAwMDAwMDdkZjIyZDY3Pl0gaTJjX2R3X3Byb2JlX21hc3RlcisweDY4Yy8weDkwMA0K
PiA+PiBbPDAwMDAwMDAwNjgyZGZjOTg+XSBkd19pMmNfcGxhdF9wcm9iZSsweDQ2MC8weDY0MA0K
PiA+PiBbPDAwMDAwMDAwYWQyZGQzZWU+XSBwbGF0Zm9ybV9wcm9iZSsweDhjLzB4MTA4DQo+ID4+
IFs8MDAwMDAwMDBkZDE4M2UzZj5dIHJlYWxseV9wcm9iZSsweDE5MC8weDY3MA0KPiA+PiBbPDAw
MDAwMDAwNjYwMTczNDE+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4OGMvMHhmOA0KPiA+PiBbPDAw
MDAwMDAwYzQ0MWU4NDM+XSBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDljLzB4YTgNCj4gPj4gWzww
MDAwMDAwMGY5MWRjNzA5Pl0gX19kcml2ZXJfYXR0YWNoKzB4ODgvMHgxMzgNCj4gPj4gdW5yZWZl
cmVuY2VkIG9iamVjdCAweGZmZmYwMDI4MDQ1MmMxMDAgKHNpemUgMTI4KToNCj4gPj4gY29tbSAi
c3dhcHBlci8wIiwgcGlkIDEsIGppZmZpZXMgNDI5NDg5NDU1OCAoYWdlIDMzNi42MDRzKQ0KPiA+
PiBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMpOg0KPiA+PiAwMCAwMCAwMCAwMCAwMiAwMCAwMCAw
MCAwOCBjMSA1MiAwNCAyOCAwMCBmZiBmZi4uLi4uLi4uLi5SLiguLi4NCj4gPj4gMDggYzEgNTIg
MDQgMjggMDAgZmYgZmYgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAuLlIuKC4uLi4uLi4uLi4uDQo+
ID4+IGJhY2t0cmFjZToNCj4gPj4gWzwwMDAwMDAwMDY3MGEwOTM4Pl0gc2xhYl9wb3N0X2FsbG9j
X2hvb2srMHg5Yy8weDJmOA0KPiA+PiBbPDAwMDAwMDAwYTNmNDdiMzk+XSBrbWVtX2NhY2hlX2Fs
bG9jKzB4MTk4LzB4MmE4DQo+ID4+IFs8MDAwMDAwMDAyYmRiYTg2ND5dIGFjcGlfb3NfY3JlYXRl
X3NlbWFwaG9yZSsweDU0LzB4ZTANCj4gPj4gWzwwMDAwMDAwMGJjZDUxM2ZlPl0gYWNwaV9ldl9p
bnN0YWxsX3NwYWNlX2hhbmRsZXIrMHgyNGMvMHgzMDANCj4gPj4gWzwwMDAwMDAwMDAyZTExNmUy
Pl0gYWNwaV9pbnN0YWxsX2FkZHJlc3Nfc3BhY2VfaGFuZGxlcisweDY0LzB4YjANCj4gPj4gWzww
MDAwMDAwMDk4OGQ0ZjYxPl0gYWNwaV9ncGlvY2hpcF9hZGQrMHgyMGMvMHg0YTANCj4gPj4gWzww
MDAwMDAwMDczZDRmYWFiPl0gZ3Bpb2NoaXBfYWRkX2RhdGFfd2l0aF9rZXkrMHhkMTAvMHgxNjgw
DQo+ID4+IFs8MDAwMDAwMDAxZDUwYjk4YT5dIGRldm1fZ3Bpb2NoaXBfYWRkX2RhdGFfd2l0aF9r
ZXkrMHgzMC8weDc4DQo+ID4+IFs8MDAwMDAwMDBmYzNlN2VhZj5dIGR3YXBiX2dwaW9fcHJvYmUr
MHg4MjgvMHhiMjgNCj4gPj4gWzwwMDAwMDAwMGFkMmRkM2VlPl0gcGxhdGZvcm1fcHJvYmUrMHg4
Yy8weDEwOA0KPiA+PiBbPDAwMDAwMDAwZGQxODNlM2Y+XSByZWFsbHlfcHJvYmUrMHgxOTAvMHg2
NzANCj4gPj4gWzwwMDAwMDAwMDY2MDE3MzQxPl0gZHJpdmVyX3Byb2JlX2RldmljZSsweDhjLzB4
ZjgNCj4gPj4gWzwwMDAwMDAwMGM0NDFlODQzPl0gZGV2aWNlX2RyaXZlcl9hdHRhY2grMHg5Yy8w
eGE4DQo+ID4+IFs8MDAwMDAwMDBmOTFkYzcwOT5dIF9fZHJpdmVyX2F0dGFjaCsweDg4LzB4MTM4
DQo+ID4+IFs8MDAwMDAwMDBkMzMwY2FlZD5dIGJ1c19mb3JfZWFjaF9kZXYrMHhlYy8weDE2MA0K
PiA+PiBbPDAwMDAwMDAwZWViYzVmMDQ+XSBkcml2ZXJfYXR0YWNoKzB4MzQvMHg0OA0KPiA+PiBy
b290QGRlYmlhbjovaG9tZS9qb2huIw0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IEpvaG4NCj4g
PiAuDQo+ID4NCg0K
