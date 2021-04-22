Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF836883E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 22:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDVUwR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 16:52:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:62082 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhDVUwR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 16:52:17 -0400
IronPort-SDR: shzk6YkjzHaEkX0cOA7WEVbPTFsrtbSTPoc9DjtP6xIyBlvxK5nWyzNFqeOZr6YWFJV8y9w0zo
 i2WtLbwXD9uA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281299604"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281299604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:51:42 -0700
IronPort-SDR: xLnydiH1v85O48d8XFA7RKJIL6eO4kbw1fH+D40Q+uEVRAyvudQqNTaBoQWr1cgUySFoi+Z0Vg
 0X8GSh1LMDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="391905505"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2021 13:51:41 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 13:51:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 22 Apr 2021 13:51:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 22 Apr 2021 13:51:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i07voj4vPxD7RNcjLmhKvdgrTRcx/E3ymts7YQFEY/YAfwFNQxp9spni5nz/KCECDRTDp3jJXnUOKo5NTmDPpIdDKbrVDJKasFS8YxemDRB+jyAYmEXiHM6T3EE1G9SOEBeZQ9122nZYw9F6L0if1rnuUPPWJnlT1Kd1vXAC7e+rG1OWjIuA7i02TqFbUVjSDQKatNJsXErS5TPlujUi0T0TAedeGAbOi3eOwKfzQf4Ir6mRuNn4OJeYIUqHn3Ig69OWkzq7HDOZ0qoTOQIFp1NoXQ7hw/y6R9w7VrTaY6wQnuiJkAkOwOdflUyW7QWEglW8favDdyqV+grKqAiz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnCZs1El8LFs7CiXMEMzPcJnufXEA8DRd6HMCZzgKWk=;
 b=liEn2v7BEvWa7TttzK4ZU6lJbEedrsHzwiq7dh3ImBReLoLTw7hzXmyhL1W1WnOEsoPAaSsiE5M7Iw4beHtysKHmtsM5NLjwGfaW340ClCsgKNGUV7LifT45yTUm1pL7NRpkS6/tJYo5jA6NHyxhNByWhUsMRm/uqsqDsVbytSbpwB0J8ZyQHtxA6RqMVnow+sYwcFHlrCoM7jPWa1pGFHwmAoOvk5kpPkBa73D+NIc6NASITOZUpvIL1Cy0iK8sz2MEbHyODlUYnRaPLiWMvj4Xh+qj+JxNi4l/7IvHDTpvp7k77xMRCrVkVsXMapwJTNJzz6MkXQ0m9+ZBBU/kUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnCZs1El8LFs7CiXMEMzPcJnufXEA8DRd6HMCZzgKWk=;
 b=su0F/acX88FqRg5itCXFeu/7vtrEe8SXkjyLqzywn5tMXEsTUDPCzJyz4I8PZ6oxRZ4IHfjgkc+L1xU+SZ2mTnPrpeYQ7Zg99k2vaBtqWmmXQ/TpP9Y/ik0lU6srj/0qYU+AwAAI0CKv7T9ALwIRQt0XLRCZvXboukBcT6AdzVg=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 20:51:38 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4065.020; Thu, 22 Apr 2021
 20:51:38 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
Thread-Topic: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
Thread-Index: AQHXN60rn/T9XE0sDUmKj1P9eGMISarA7pmAgAACWYCAAAKogIAADgTA
Date:   Thu, 22 Apr 2021 20:51:38 +0000
Message-ID: <MWHPR11MB1599BAA9352B8C67B5EB9373F0469@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422192442.706906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <98a81d5c-251b-bdb1-f5e4-5925de93f0d7@intel.com>
 <8928afc9-ab59-62f3-45b5-a6d26d96d90e@linux.intel.com>
 <20210422195543.GF7021@zn.tnic>
In-Reply-To: <20210422195543.GF7021@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c5bbdf-f2ce-42ea-634f-08d905d06ce1
x-ms-traffictypediagnostic: MWHPR11MB1599:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1599794C0971D39448429D8AF0469@MWHPR11MB1599.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2K1yQlJeSk9yoIIAqFkEeRlcCwTuPNFOg9JQppf20XF1RY5xNTB5ozYG0Le16MZHC/gtT9so66w0at+N2NQxYc/SA79YNT8P8gvs/llRMp1/2N4u8py6aQTl52P04KhjWTEo+E1Xu7nK+QKnfrQ1BF/krCJukEiZ5YVgc3g212pk2G9dRBOIJqfSmnOU8juiwtD1BJF6plmFbaEUUKVsPacjZhB9PhUMi59a21uDmOWL3r89NvvlZDvkmfD9G7EwJ/Bl0QKKhLjdn7R9XnCWKoA3COBmpsNN+U8IVUjBXz8qN9ZHlz8TQFkj+Hb41ycr8jw6DNt5hblCXQYUtW2UUt3wabNymHgaMXscQC2y/ooU21cjtfOO012SPVUmmd8ExrwWOXWz9KHTkTRbBsh2j8CeNBwS2+bMByrD0htv+0OLBXH1os3SN6iL2MbAFkvM+BMhRFR6UYI0jqHTDDpbcunb68rPn3u6PwqjynGhvstlxhVYQ+N2cubE6v1gvinF6k+zLaeOqzIh/VqiuS5BevfvDwxQKdNWcWbSzzty3es/p+dM65g5rYM14IeChoLj9yCroiJ5Lv/VVYb3HdGF2z/5BIWNGFai81JDs98AXgDdKxNEEtkj4A5KiMkZUDjui4TcI4jX95LkMoMidqV5d/vxY6xvH9OyUAFv1406zl/1DB4FaXHO5D/GjBwQV9oV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(8936002)(33656002)(83380400001)(76116006)(66946007)(478600001)(8676002)(966005)(53546011)(52536014)(55016002)(54906003)(5660300002)(2906002)(15650500001)(110136005)(6506007)(38100700002)(122000001)(7416002)(71200400001)(7696005)(64756008)(86362001)(4326008)(26005)(186003)(66556008)(316002)(9686003)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Sjg1cXNQMElpaHJsdURkTERmUW9FZEN1bFJJZnk4Q292TEQ3cHJvQnlxL3Fj?=
 =?utf-8?B?RFVyT2tDL1BkNjJXRlg5QXMxbUhaQUU2NE5aeGYvQ0JsOEY1RUZzQWRPSTQy?=
 =?utf-8?B?aHc0ZDhuQ1pwL2UzeFZVQ1FRU3ZnR2hCY3d1N2tvSTA5RGYzYzVaOGVSREEy?=
 =?utf-8?B?OFBQVVRodE1oWktpSit2Qk1qQ2dtNEFlVXlBQXFtOWtUL3dCcnloa2NYRW95?=
 =?utf-8?B?UmIwS1MyUSt2eUFjdzZOc3hPZUNTOFpLV2VvVktRNzZoWEdMREFVS1RkWEpR?=
 =?utf-8?B?NVFLVlVYQmVlcFZUWEJBZVUwdDhFQ2N4N0ZmbmN6YVQ4SWlXbDJXbUxKNUJJ?=
 =?utf-8?B?dHloWlliblBPTnlhSXlhVUJrc2ZFRUlNQWdrdjQ4QUt4aEJWTnRMNlE3UHJl?=
 =?utf-8?B?VnhPV3NLYWNoWlNEUG5mTnZmVjhTOGtYUExKMTZHSno1WjFGcG5oeDRVdURr?=
 =?utf-8?B?M1ptbzlFZTJWYnljc1cvdDNqanA4UjZIZHlCdGFJRGtscnN6U0V2eFFreGNx?=
 =?utf-8?B?YzlUMUNVc0RsZ1ZkUy81UGpJN2Q4YXJLREllditnSXZtZzFObHpEeEI0UStB?=
 =?utf-8?B?SFYzWms3R2oxZ0k5RlEybzdvWmdmcjZhMmxrdmkwR1BTYnd6VGdKOUZIYUVy?=
 =?utf-8?B?WEZXWDN1OEx1anlFWjJsOUhQQXp3a2xQKzczT083TkptcDgyaCtoaVpxNDZ4?=
 =?utf-8?B?bTZ4Smx2bHdFYkcvcFVySlhxUjJJSVdXQTRrREtKcERsZ0lCS1k0M2JVZWVZ?=
 =?utf-8?B?VkRLaGFWeERqNnVqWFZGNXJKU0RvRXBTalpjNUI5NThMcE1EMFhIQ09mUnlW?=
 =?utf-8?B?L3Exb0RwZlo3dmFTSnlscE95S3FDazVXNnJmTGFmbmY5c2FKUEVneEdWdWFJ?=
 =?utf-8?B?UUpMWkJ0YzBINzIyalpzTE9WUVdNUlQ4TnNXNExuOGNWYVM3WG13WUhqK1hu?=
 =?utf-8?B?MmpETitEMUYyU0NvcERiem5BQ2U3YUptWVdkelZYNDVrRFU5YllraGxTZW11?=
 =?utf-8?B?eEQ2TTVONFh1a2kzVy84SVJGaDVNemR5YzNZRXJJK0RUVWQyMEIxTExJMUFS?=
 =?utf-8?B?bTRZVmRsZkU0aCtoZ1BBRXNvckMyaElYbXZRK3BucnRkVVhNWmY5cGsyU3Ru?=
 =?utf-8?B?eWo5TUNCVEhpVGtrRk5sU2JoTEJMdnNScjhnMzVPLzBmWktNWkZqN1RNbitS?=
 =?utf-8?B?UU9ja0dnVHUvZXNUOUU3cThsY3J1WStBc21aSHlDOWRvQ0I1NUhzaEZXZkFV?=
 =?utf-8?B?MlZjMzlla0ZNdFBBVW1EdlZObnpMMk5QTWpuaGE1Z3F6bDZWWnBhSytDdHpN?=
 =?utf-8?B?RUM5YnRpeTlUQ25ISW5sZzJKb2JJK0x5Y1hudTRTbUlmb2hOT0REUUMyWG50?=
 =?utf-8?B?VmZBNFFlNThCR0RFaXl1c1NQbnJuQ0pRVVNFQ3pkMS9kblNPRmd6RzAxY2tz?=
 =?utf-8?B?eXpKS2g4a2wwTFBVU3MrdE4xTkpqVGR4YzZobFJxN0ZIMG8zRnorMys4WHVO?=
 =?utf-8?B?eVZqQ2xLSHlzRjVLeXpXdVIzL2d4RkhUdEZIRWlNNk5tN3g3bHpMeXg3eERL?=
 =?utf-8?B?aVYxMUxQYWJvdzQ0U21SZjg3UTZVUzdReDA5a2ZBOHVLekIvbzNyZ0Iwcjd3?=
 =?utf-8?B?WkUyOWZFK3Jzalc1dEltb0FwV3R1VzQ2dDZSSmpid3JuSUhnWG9USTZLME1n?=
 =?utf-8?B?VzRZQ2FWTUZTWll5Sk9oKzdQN2NrMWF5NzBRYjY1RDBxaGNaVjg3QUhINFlu?=
 =?utf-8?Q?LEy0qQGCLwWeYIvY0sIUjY1gaA3qwVyQSavwk2Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c5bbdf-f2ce-42ea-634f-08d905d06ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 20:51:38.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7Vbh4r5YoWUGC5amF1QRSXPWP2Hr01jJAb+eX4l6NPB3+U4W2rQUO+DYEaMUKwWDTZ63L3AyEfLiinIyNVLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1599
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMiwgMjAyMSAxMjo1NiBQ
TQ0KPiBUbzogS3VwcHVzd2FteSwgU2F0aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFuYW4u
a3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBIYW5zZW4sIERhdmUgPGRhdmUuaGFu
c2VuQGludGVsLmNvbT47IFJhZmFlbCBKIFd5c29ja2kNCj4gPHJqd0Byand5c29ja2kubmV0Pjsg
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdvIE1vbG5hcg0KPiA8bWlu
Z29AcmVkaGF0LmNvbT47IEggLiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IFBldGVyIFpp
amxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwu
b3JnPjsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IEthbmVkYSwg
RXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwu
b3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB4
ODZAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gQUNQSUNBOiBBQ1BJIDYu
NDogTUFEVDogYWRkIE11bHRpcHJvY2Vzc29yDQo+IFdha2V1cCBNYWlsYm94IFN0cnVjdHVyZQ0K
PiANCj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMTI6NDY6MTNQTSAtMDcwMCwgS3VwcHVzd2Ft
eSwgU2F0aHlhbmFyYXlhbmFuDQo+IHdyb3RlOg0KPiA+ID4gVGhpcyBTb0IgY2hhaW4gZG9lc24n
dCBsb29rIHJpZ2h0LiAgVGhpcyBpcyB3aGF0IGl0IHdvdWxkIGhhdmUgYmVlbiBpZg0KPiA+ID4g
WW91IHNlbnQgaXQgdG8gQm9iIHdobyBzZW50IGl0IHRvIEVyaWssIHdobyBzdWJtaXR0ZWQgaXQu
DQo+ID4gSW50ZXJuYWxseSwgaXRzIHN1Ym1pdHRlZCB0byBCb2IgYW5kIEVyaWsgZm9yIEFDUElD
QSBtZXJnZS4NCj4gPiBJIHRoaW5rIFNpZ24tb2ZmIGlzIGFkZGVkIHRvIHRyYWNrIGl0Lg0KPiAN
Cj4gVGhpcyBpcyBub3QgaG93IHRoaXMgd29ya3MgLSB3aGVuIEVyaWsvQm9iIG1lcmdlIGl0LCAq
dGhlbiogdGhleSBhZGQNCj4gdGhlaXIgU09CLiBSaWdodCBub3cgaXQgc2hvdWxkIGhhdmUgb25s
eSB5b3VyIFNPQi4NCg0KU29ycnkgYWJvdXQgdGhhdC4gVGhlIHNjcmlwdCB0byBmb3JtYXQgdGhl
IEFDUElDQSB1cHN0cmVhbSB0byBMaW51eCBBQ1BJQ0EgYXV0b21hdGljYWxseSBhZGRzIHNpZ25l
ZCBvZmYtYnkgdGFncyBmcm9tIG1lIGFuZCBCb2IgdG8gdGhlIHBhdGNoLiBUaGlzIHdvdWxkIHdv
cmsgaWYgd2UgZ28gdGhyb3VnaCB0aGUgbm9ybWFsIHByb2Nlc3Mgb2YgcnVubmluZyB0aGUgTGlu
dXggc2NyaXB0IGFmdGVyIHdlIGRvIGFuIEFDUElDQSByZWxlYXNlLiBXZSBkZWNpZGVkIHRvIHN1
Ym1pdCB0aGlzIGVhcmxpZXIgdG8gbWVldCBTYXRoeWEncyBkZWFkbGluZS4NCg0KU2F0aHlhLCBQ
bGVhc2UgZHJvcCB0aGVzZSBsaW5lcyBmcm9tIHRoaXMgcGF0Y2ggYW5kIHRoZSBTVktMIHBhdGNo
Lg0KDQpFcmlrDQoNCj4gDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNo
ZXMucnN0LCBzZWN0aW9uICJTaWduIHlvdXIgd29yayAtDQo+IHRoZSBEZXZlbG9wZXIncyBDZXJ0
aWZpY2F0ZSBvZiBPcmlnaW4iDQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNz
LA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90
ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K
