Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE83CB87A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhGPOLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 10:11:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:56555 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240133AbhGPOLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:11:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210724099"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="210724099"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 07:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="431222138"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2021 07:08:59 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 16 Jul 2021 07:08:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 16 Jul 2021 07:08:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 16 Jul 2021 07:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNQ507eiieZ2SRAEo4buQpX8ILXPfwYlpRg/nb1ZaIk9nZLZknVb8xxbTgaU77Fkb+94l/6v42rsqtWYQ2sJQo9euTUK/8NAy2HD11Rzxparbl4EOEuA95KxiGmSbPAZ3WY6eFz8gGO4Sh5kkGK/yLLcp6kChQdnS/Xl21nSNaj7DFhBXtnDpYiGS00xeccLrJrDBRvhZI7IObydltylDYrmnYmdql1ugUESh7lxPgAmONV1ZAlUx6apV+2pPtVoG+Ebq8RzepPwdqe4VuDgx0PjpQ95eSUMrvVtWr+fD491Upjwpm2D33N6w/6qW5mWk3RisX2zG08VomlxWvg1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2kZ3c0OwyKi52DdAIoZNnotVKKiavMDmy02Oq8TMmg=;
 b=gdkkJNz7i/UttNxjRDY9DzCzUvpZ9Kcm47517aj/xAJ6+37p333bfgvZBMsYMOfFUqSC8lhL6TU4TvfP7adqpbmw/LYS2K22SOo4XBQG9puJfWd7pQS/Uf/PMB3TalxTtfVudJI6L0Ct2KD3mge5qlL3SoMnlSDeZk2JKHtKGSrhhfLt4T+S+XvDckUMUs9DSurqDm7YmeenDajeOAMSjYi70v31jmBhN5qFVx1609bguCRVtw5BXyFNRxsj4+njG3yxyYx0tZry+xHHPR/PDT9W9i9aEQe8ENx9KWF0avImRyMOOaqquuDeU/jwDfDPiJYxujq21fFeOUWid/c/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2kZ3c0OwyKi52DdAIoZNnotVKKiavMDmy02Oq8TMmg=;
 b=S3oGajTHEt+Go9nzTekECz8etNjJC2WPuF07nNI/rIf9SojMvPExSEZEZnbtkQgH4xoIjVlZ2ijSN/PgHZsLeuZRw9v9EFw1bja3ryoGEY483uJmtGJBUXPJzWBuneG8ja0uXglr8KJJ6aeq8FOFV9t4P3birAlYpi2inVF+uRs=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 14:08:57 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.028; Fri, 16 Jul 2021
 14:08:57 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Marcin Wojtas <mw@semihalf.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gjb@semihalf.com" <gjb@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "Samer.El-Haj-Mahmoud@arm.com" <Samer.El-Haj-Mahmoud@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Thread-Topic: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Thread-Index: AQHXePnnR//FH/r3cki0IN+Vh3tJWatEEynwgAADIQCAABfIsIAAASwAgAF29XA=
Date:   Fri, 16 Jul 2021 14:08:56 +0000
Message-ID: <BYAPR11MB3256747AF68B07DE102E2B4D87119@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210714214346.1397942-1-mw@semihalf.com>
 <20210714214346.1397942-2-mw@semihalf.com>
 <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAPv3WKeN55zEW65yfyPizB0WA4HLtcf=m-7yUgpk7O1hCKW4SA@mail.gmail.com>
 <BYAPR11MB32569C7DB2041874F540A7A987129@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAPv3WKcBKNAD880Mpf8z4vpY=3wbyyd3PiQ=uzKupaw=P_JpQg@mail.gmail.com>
In-Reply-To: <CAPv3WKcBKNAD880Mpf8z4vpY=3wbyyd3PiQ=uzKupaw=P_JpQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: semihalf.com; dkim=none (message not signed)
 header.d=none;semihalf.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d024cd4b-e6d0-4e8a-b52f-08d94863408c
x-ms-traffictypediagnostic: SJ0PR11MB5168:
x-microsoft-antispam-prvs: <SJ0PR11MB5168EF9652258E8D9E71C2C687119@SJ0PR11MB5168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llvPts7hfzwkH5akWlJn2d6A9NBVoK2M3sP+OVCxSqdRHlV4jIK+2+K5MYhoGl6R3xr1k8BM1v1wSQbjEx5566qZGNuBzjRWNeCGluq1g4HplpH2m7hHsrt4xCaJJ7K4epkbsEkYYg4Ptv5slcOPD2G818AFRR6wvwIyYRz/mevgPmZRY80a9L7Q/Z108qapLtnLg8CFvQvwaCcKehJuqQ+2STFaeQ88Dg4ex5eQaSivhxsb/Y/OULMZAdsA8RIFc96/DshLQlT2QCtak3dL/goAxIZsU0SM6nKwGcK5/WwzloIPhf9kJIgDAfo0GPBLPxmuS4J95qf7vfRSXJN3v5ORveegBuJKXYvUdSpPN7g6wuM/tvZ7svIck/LoVbDZ1eJZQXi1eoNgEsiE2OBlg88j34Pv6414wBmRR9O+Z2YyRd6Q8wz7jaB9OzINypBtm2WUaQhOYFObtg8pwHYSjuSN1wM02Tt7nIAXMZ1CPBmr+cYZJzi8YKuFV50nwCcFhMSITao+I+Kt7+WN65psk8nfHS78ql1A7CXtoZYv9ug8HNdt9zf5eFLs63MC+lRNcvntZbQbSHh+xrqje0Kuery1fkc3AKTy9KPfKQUqYvhdcOF0fJA3anfhr/zh6BIbpQ77PzpjWlv1g7O98WPsgLhqHoDGHbX+pMxGgG4UQQ/ae6SZbmil/HrS7D2YUNDBejp1rjMlhML4MmIO9dWO19iKQCIkb4FEQM6nMR1gYO0pDXjOewidv53CERzSM+oUZ+FprapgRdJnJ4wuyozEoM6FA05HmTOOUwOMncBBz0j/K7BdyoXicDy+jmDCVoMFDiCQJXJOx5ypKou1z/2XiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(71200400001)(316002)(966005)(86362001)(6506007)(55016002)(9686003)(8936002)(478600001)(83380400001)(45080400002)(8676002)(54906003)(4326008)(2906002)(53546011)(33656002)(7696005)(6916009)(66446008)(52536014)(5660300002)(7416002)(186003)(66556008)(122000001)(64756008)(66476007)(38100700002)(26005)(76116006)(66946007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDNGdXFhdnVvVTVYTlJ2YjVONnJyMVpUWGRadzdVSnZpSXFwaGtnbUhvb3Ez?=
 =?utf-8?B?WExBS0c4Z3p5NTdLemJ4OUdFcERreFhROFFKRVhnc2lULzMvdU9IWnRJOWFR?=
 =?utf-8?B?ZFlBb0VtRURZTEdTMDRjL3FmZmVFT20yQVN1MGNpanZFdi90dmdMNXFZUUpX?=
 =?utf-8?B?US9BR3p2dDVYSU9pQWNxRThoYkY1aG1XRjk1Vy9vZTZOOW1xMTZaNURDNUN1?=
 =?utf-8?B?NS9XcXpmR2RKOXpjTVlscXc0L01nYUFVRENrVWxxem5aemg2SVpHbExZRDd0?=
 =?utf-8?B?bERhajhJc0ZJckVkbTFqZDFrVWRRd3lPLzJTdzZlTTZiZE5VNUtxUmN2d1FI?=
 =?utf-8?B?ZFdIZHM1ajZ0azNmZmZkT0Y3Yy90OC9ZaEhiZnlQcnJZNEJjMS9qUVhWdGJG?=
 =?utf-8?B?VXU5SDlUYjFIU1Q2ZExockUzOXFwVi9zUmxDQ1dXbndiUFFTY0UzTDBrM3d4?=
 =?utf-8?B?VDk4MzZnRlhxeGVHRlFpSXRRTkl6SDg2Z1RnamppQ01YMGdET0p5UVdyQmw1?=
 =?utf-8?B?SmYyWmo0YnVZWWFEMnhFcjY2UWQ0L1Fka3phaC9EZHBocDE5WXYyMGFSaXlp?=
 =?utf-8?B?VjViUHI1VW4yVWd4WllZMnVEbS9JSTBaOXpsRnpSSXB0eFBLeHdYbnVBalRT?=
 =?utf-8?B?OGdqaXRBeEEyQzVEdXl1Z0FteFBQL3JCWXBwZVVkWHF2VXdGMm8vYnRLQUpV?=
 =?utf-8?B?RlJwck5CZ2FlTHlua2xEVHV1emgxWEpBenc1RFhjVldrUGFmN0dzTDJpbXNq?=
 =?utf-8?B?SFNYQzlXK2lrcURQZUxxOTlmSUp0LzBhWDRCaVZmdFpuaitPdnpWV1R5Y1RH?=
 =?utf-8?B?S0dKMWIwU09rQ2RHVWwxWDJOYU1va1RNem81cERTdzFuVEd3QXFzNXgydGhB?=
 =?utf-8?B?VHliTnFBY00wZGVwMkFBQi9Cd2EwSnJmTFZRTHc2ZlRNTEk3UkZVcE1SSEox?=
 =?utf-8?B?bUw4ZTVMTEN3T3JmQ01OSVRBY3Qxb1d4TVNOb0VJSlAzdzVpSXh4bG10UkZW?=
 =?utf-8?B?cWdBM1h4eEVxSytZRlRqa0xFdFpaQ3VuSHRSNUZsRFBEc3VxdU5JUmFCUDJM?=
 =?utf-8?B?QlViVkN0a29OUTZzZkxpQ3dBVkVvdmhkbXEwQmdPNWNoQXVDcUFudHQ1TCtI?=
 =?utf-8?B?YVNLM2FwRXo2akhrc2h2QVFWY2NQWjJ0OGo0TWtCTC8zU1dFdzAveExMTkJq?=
 =?utf-8?B?eVFiVVk4TnFYelRFcXVydjFjNi9XZU1TeVo1K0xEeVozU1B5ZEQrRnh1NWNZ?=
 =?utf-8?B?TS9KaEpCbFRTUC82cURrZ3Jramhib0hwUGwrTXVvYUxvckVDdmZNVHNJMW02?=
 =?utf-8?B?VUZ2LzNSYkUrdldVbVFvdHhFUkZIVFl5N1grRVA2NGNUeEE5cXJtNTYvQjJR?=
 =?utf-8?B?Vm5LOXlQTXU0YnJtUytZQU5zaW1nRlAxVVU0MXJTdk9waG9ZQU8zL1dpcUNG?=
 =?utf-8?B?Yk01WlRMb0tlRGJtNCtKeVFVa2EwdzRqWHc5QjVVbXphTU12Q2drbEF4emp6?=
 =?utf-8?B?QUM1QkVWNmxtd2RwRnBGelRvKzhhNUNQRnVWZVhncmRQUTRXZm1GbmY1b0Z0?=
 =?utf-8?B?QnpOenBFNkdtdzBIc09NdGRaemNEQnIxd0hlT3FRTGN2UlkwUmpZMmJlbUlo?=
 =?utf-8?B?NzZwTnRPMTJ2Wld6RWIwaGQzMnZDSCsxUkZzQWJSc3MzOEkvQ241YWJCbjFP?=
 =?utf-8?B?bWlEVU5qK1gxRnlKcjh2WU5DZUIzQ2ZESUlUMTh4a09oMlRpdEU1RnIvNkJK?=
 =?utf-8?Q?41XpKsCtOg429amwlXTFwgPhG18DFGYyqjTSkBt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d024cd4b-e6d0-4e8a-b52f-08d94863408c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:08:57.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrew0pnG7nrOd0+HM8qiZz843ojdzdhN8FTpUwGLHy4OXIXGQQaGqCUmnYu3FIcAXvLx5eQX83wplVngvN+Fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJjaW4gV29qdGFzIDxtd0Bz
ZW1paGFsZi5jb20+IA0KU2VudDogVGh1cnNkYXksIEp1bHkgMTUsIDIwMjEgODo0NyBBTQ0KVG86
IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQpDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGlj
YS5vcmc7IGphekBzZW1paGFsZi5jb207IGdqYkBzZW1paGFsZi5jb207IHVwc3RyZWFtQHNlbWlo
YWxmLmNvbTsgU2FtZXIuRWwtSGFqLU1haG1vdWRAYXJtLmNvbTsgam9uQHNvbGlkLXJ1bi5jb207
IHRuQHNlbWloYWxmLmNvbTsgcmp3QHJqd3lzb2NraS5uZXQ7IGxlbmJAa2VybmVsLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIEFDUElDQTogQWRkIG5ldyBEQkcyIFNlcmlhbCBQb3J0IFN1
YnR5cGVzDQoNCmN6dy4sIDE1IGxpcCAyMDIxIG8gMTc6NDQgTW9vcmUsIFJvYmVydCA8cm9iZXJ0
Lm1vb3JlQGludGVsLmNvbT4gbmFwaXNhxYIoYSk6DQo+DQo+IFRoZSBwYXRjaCB3YXMgcG9zdGVk
IGFzIGEgcHVsbCByZXF1ZXN0IG9uIG91ciBnaXRodWIgc2l0ZS4NCj4NCg0KSSdtIGF3YXJlIG9m
IHRoYXQsIHNlbWloYWxmLXdvanRhcy1tYXJjaW4gaXMgbWUgOikNCg0KPiBUaGUgbWVyZ2VkIHBh
dGNoIHdpbGwgYmUgcmVsZWFzZWQgYXMgcGFydCBvZiB0aGUgbm9ybWFsIEFDUElDQSByZWxlYXNl
IHByb2Nlc3MsIHdoaWNoIHdpbGwgdGhlbiBtYWtlIGl0IGludG8gTGludXguIFlvdSBzaG91bGQg
dGhlbiByZWJhc2UuDQoNCk9rLCB0aGFua3MgZm9yIGV4cGxhbmF0aW9uLiBXaGVuIGFwcHJveGlt
YXRlbHkgY2FuIHRoaXMgaGFwcGVuPw0KDQpBYm91dCB0aGUgZW5kIG9mIHRoZSBtb250aA0KQm9i
DQoNCkJlc3QgcmVnYXJkcywNCk1hcmNpbg0KDQo+IEJvYg0KPg0KPg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE1LCAyMDIxIDc6MTcgQU0NCj4gVG86IE1vb3JlLCBSb2Jl
cnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgDQo+IGRldmVsQGFjcGljYS5vcmc7
IGphekBzZW1paGFsZi5jb207IGdqYkBzZW1paGFsZi5jb207IA0KPiB1cHN0cmVhbUBzZW1paGFs
Zi5jb207IFNhbWVyLkVsLUhhai1NYWhtb3VkQGFybS5jb207IA0KPiBqb25Ac29saWQtcnVuLmNv
bTsgdG5Ac2VtaWhhbGYuY29tOyByandAcmp3eXNvY2tpLm5ldDsgbGVuYkBrZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBBQ1BJQ0E6IEFkZCBuZXcgREJHMiBTZXJpYWwgUG9y
dCBTdWJ0eXBlcw0KPg0KPiBIaSwNCj4NCj4NCj4gY3p3LiwgMTUgbGlwIDIwMjEgbyAxNjowNyBN
b29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPiBuYXBpc2HFgihhKToNCj4gPg0K
PiA+IFRoaXMgd2FzIGFscmVhZHkgcmVwb3J0ZWQgKHdpdGggYSBwYXRjaCB0aGF0IHdlJ3ZlIGFs
cmVhZHkgbWVyZ2VkKSANCj4gPiBieSBzZW1paGFsZi13b2p0YXMtbWFyY2luDQo+ID4NCj4NCj4g
SSdtIG5vdCBzdXJlIHRvIGJlIGF3YXJlIG9mIHRoZSBwcm9jZXNzLiBSZXBvcnRlZCB3aGVyZT8N
Cj4gQXJlIHlvdSBwbGFubmluZyB0byBpbXBvcnQgdGhlIHVwc3RyZWFtIHBhdGNoIG9uIHlvdXIg
b3duIGFuZCBJIHNob3VsZCByZWJhc2UgdGhlIFNQQ1IgZHJpdmVyIGNoYW5nZSBvbiB0b3Agb25j
ZSBpdCBsYW5kcz8NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBNYXJjaW4NCj4NCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE1hcmNpbiBXb2p0YXMgPG13QHNlbWloYWxm
LmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTQsIDIwMjEgMjo0NCBQTQ0KPiA+IFRv
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgDQo+ID4gZGV2ZWxAYWNwaWNhLm9yZw0KPiA+IENjOiBqYXpAc2VtaWhhbGYuY29tOyBnamJA
c2VtaWhhbGYuY29tOyB1cHN0cmVhbUBzZW1paGFsZi5jb207IA0KPiA+IFNhbWVyLkVsLUhhai1N
YWhtb3VkQGFybS5jb207IGpvbkBzb2xpZC1ydW4uY29tOyB0bkBzZW1paGFsZi5jb207IA0KPiA+
IHJqd0Byand5c29ja2kubmV0OyBsZW5iQGtlcm5lbC5vcmc7IE1vb3JlLCBSb2JlcnQgDQo+ID4g
PHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+
DQo+ID4gU3ViamVjdDogW1BBVENIIDEvMl0gQUNQSUNBOiBBZGQgbmV3IERCRzIgU2VyaWFsIFBv
cnQgU3VidHlwZXMNCj4gPg0KPiA+IEFDUElDQSBjb21taXQgZDk1YzdkMjA2YjU4MzZjNzc3MGU4
ZTljZDYxMzg1OTg4N2ZkZWQ4Zg0KPiA+DQo+ID4gVGhlIE1pY3Jvc29mdCBEZWJ1ZyBQb3J0IFRh
YmxlIDIgKERCRzIpIHNwZWNpZmljYXRpb24gcmV2aXNpb24gU2VwdGVtYmVyIDIxLCAyMDIwIGNv
bXByaXNlcyBhZGRpdGlvbmFsIFNlcmlhbCBQb3J0IFN1YnR5cGVzIFsxXS4NCj4gPiBSZWZsZWN0
IHRoYXQgaW4gdGhlIGFjdGJsMS5oIGhlYWRlciBmaWxlLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0
cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy1oYXJkd2FyZS9kcml2ZXJzL2Jy
aW5ndXAvYWMNCj4gPiBwaQ0KPiA+IC1kZWJ1Zy1wb3J0LXRhYmxlDQo+ID4NCj4gPiBMaW5rOiBo
dHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9jb21taXQvZDk1YzdkMjANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+DQo+ID4gLS0tDQo+ID4g
IGluY2x1ZGUvYWNwaS9hY3RibDEuaCB8IDE1ICsrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvYWNwaS9hY3RibDEuaCBiL2luY2x1ZGUvYWNwaS9hY3RibDEuaCBpbmRl
eCANCj4gPiBlZjI4NzJkZWEwMWMuLjdiYmIzZTJiZDMzZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2FjcGkvYWN0YmwxLmgNCj4gPiArKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwxLmgNCj4gPiBA
QCAtNDgyLDcgKzQ4Miw3IEBAIHN0cnVjdCBhY3BpX2NzcnRfZGVzY3JpcHRvciB7DQo+ID4gICAq
IERCRzIgLSBEZWJ1ZyBQb3J0IFRhYmxlIDINCj4gPiAgICogICAgICAgIFZlcnNpb24gMCAoQm90
aCBtYWluIHRhYmxlIGFuZCBzdWJ0YWJsZXMpDQo+ID4gICAqDQo+ID4gLSAqIENvbmZvcm1zIHRv
ICJNaWNyb3NvZnQgRGVidWcgUG9ydCBUYWJsZSAyIChEQkcyKSIsIERlY2VtYmVyIDEwLA0KPiA+
IDIwMTUNCj4gPiArICogQ29uZm9ybXMgdG8gIk1pY3Jvc29mdCBEZWJ1ZyBQb3J0IFRhYmxlIDIg
KERCRzIpIiwgU2VwdGVtYmVyIDIxLA0KPiA+ICsgMjAyMA0KPiA+ICAgKg0KPiA+DQo+ID4gKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioNCj4gPiAqKg0KPiA+ICoqKioqKioqLw0KPiA+DQo+ID4gQEAgLTUzMiwxMSArNTMy
LDI0IEBAIHN0cnVjdCBhY3BpX2RiZzJfZGV2aWNlIHsNCj4gPg0KPiA+ICAjZGVmaW5lIEFDUElf
REJHMl8xNjU1MF9DT01QQVRJQkxFICAweDAwMDANCj4gPiAgI2RlZmluZSBBQ1BJX0RCRzJfMTY1
NTBfU1VCU0VUICAgICAgMHgwMDAxDQo+ID4gKyNkZWZpbmUgQUNQSV9EQkcyX01BWDMxMVhFX1NQ
SSAgICAgIDB4MDAwMg0KPiA+ICAjZGVmaW5lIEFDUElfREJHMl9BUk1fUEwwMTEgICAgICAgICAw
eDAwMDMNCj4gPiArI2RlZmluZSBBQ1BJX0RCRzJfTVNNOFg2MCAgICAgICAgICAgMHgwMDA0DQo+
ID4gKyNkZWZpbmUgQUNQSV9EQkcyXzE2NTUwX05WSURJQSAgICAgIDB4MDAwNQ0KPiA+ICsjZGVm
aW5lIEFDUElfREJHMl9USV9PTUFQICAgICAgICAgICAweDAwMDYNCj4gPiArI2RlZmluZSBBQ1BJ
X0RCRzJfQVBNODhYWFhYICAgICAgICAgMHgwMDA4DQo+ID4gKyNkZWZpbmUgQUNQSV9EQkcyX01T
TTg5NzQgICAgICAgICAgIDB4MDAwOQ0KPiA+ICsjZGVmaW5lIEFDUElfREJHMl9TQU01MjUwICAg
ICAgICAgICAweDAwMEENCj4gPiArI2RlZmluZSBBQ1BJX0RCRzJfSU5URUxfVVNJRiAgICAgICAg
MHgwMDBCDQo+ID4gKyNkZWZpbmUgQUNQSV9EQkcyX0lNWDYgICAgICAgICAgICAgIDB4MDAwQw0K
PiA+ICAjZGVmaW5lIEFDUElfREJHMl9BUk1fU0JTQV8zMkJJVCAgICAweDAwMEQNCj4gPiAgI2Rl
ZmluZSBBQ1BJX0RCRzJfQVJNX1NCU0FfR0VORVJJQyAgMHgwMDBFDQo+ID4gICNkZWZpbmUgQUNQ
SV9EQkcyX0FSTV9EQ0MgICAgICAgICAgIDB4MDAwRg0KPiA+ICAjZGVmaW5lIEFDUElfREJHMl9C
Q00yODM1ICAgICAgICAgICAweDAwMTANCj4gPiArI2RlZmluZSBBQ1BJX0RCRzJfU0RNODQ1XzFf
ODQzMk1IWiAgMHgwMDExDQo+ID4gKyNkZWZpbmUgQUNQSV9EQkcyXzE2NTUwX1dJVEhfR0FTICAg
IDB4MDAxMg0KPiA+ICsjZGVmaW5lIEFDUElfREJHMl9TRE04NDVfN18zNzJNSFogICAweDAwMTMN
Cj4gPiArI2RlZmluZSBBQ1BJX0RCRzJfSU5URUxfTFBTUyAgICAgICAgMHgwMDE0DQo+ID4NCj4g
PiAgI2RlZmluZSBBQ1BJX0RCRzJfMTM5NF9TVEFOREFSRCAgICAgMHgwMDAwDQo+ID4NCj4gPiAt
LQ0KPiA+IDIuMjkuMA0KPiA+DQo=
