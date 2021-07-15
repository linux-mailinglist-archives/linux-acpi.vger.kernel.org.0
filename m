Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897B23CA19B
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhGOPrX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 11:47:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:31688 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhGOPrW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 11:47:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="274399024"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="274399024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 08:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="655850838"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2021 08:44:22 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 08:44:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 08:44:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 08:44:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQvRjbvDgqr1AbHDwgAyqhEMSJhjyf5dH/D+F4qpIVIFgMBE6KyIC0txc3oDZP6Q501vVnrLuRNUWooCpebnBIhImFLkbNfO4V/WC2bt4AjGvuCDNHq+DKUMr+IQMQrdPtBCWOrYNCyQfLXoXLY1rKbi9bXlp8aBYIeQC0lclmjXJlHr8Kuh9xAz5/dB1XfzmjuRG0RDKp+NSTzwKDLmmmCV7daC5/+zwpu7WliPBV8NUi6GpYwXnALXPkDoZkiKwqoAi5MsVY23rglF0C7mIIErBjSfc8TIM4XDBNSHKvqU+Y79X2OGDVkVy5B8EkP8x9usEOYHNGlUk6v2IMfUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfq3P4+j8SOJ55Vu8KeB+jdr5ehn7CG0WVXT0My8RU=;
 b=T/KUtOF1Wnt2+9JNtZz23zvgQkiFEWk9VEKFe178edUzhIsb+liHTMGLeZJ6xdht98Ee6hg2ZQpPMjZgN/B+t5LqjjTPvIEb6ySfoyJwjFI7CmXgnhqsdbEcfgmy2zOPlA/Z3REX84r2tQogcmwdBa9Bt4tPixgH7Vnagy0arNcK7ff85Ksbp4fzaN+h/LtZS9JgkZgBPiymqrH9OIiv+m9Lk5xQkxPr3ZwB4n+4wqqH537gN7YOb6qfjs+zqbMDVH6/OLR/RDCfosRx0cTGAfmxDIvT+U+KkYvHJ+MLcyqBVznVpTgnoSwdxnEG438zXr+ebXilyhATRAdmBet52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfq3P4+j8SOJ55Vu8KeB+jdr5ehn7CG0WVXT0My8RU=;
 b=RhlDwcPWkUlPM5/hXsdALYGG0ReDlznJb45uKkne4NSGD/qPTgAWJMiH6FRj6z0IHPZlcEB6dD6aZtOVB6nt0+gFDXgubBNhCFAiV1WNQW2mT6PfSe2YYX2g4zDnNHKR68M+2eGgxXTNMfalyBVPbphWG4tb05NWsgw+v7QwUVw=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 15 Jul
 2021 15:44:17 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 15:44:17 +0000
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
Thread-Index: AQHXePnnR//FH/r3cki0IN+Vh3tJWatEEynwgAADIQCAABfIsA==
Date:   Thu, 15 Jul 2021 15:44:17 +0000
Message-ID: <BYAPR11MB32569C7DB2041874F540A7A987129@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210714214346.1397942-1-mw@semihalf.com>
 <20210714214346.1397942-2-mw@semihalf.com>
 <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAPv3WKeN55zEW65yfyPizB0WA4HLtcf=m-7yUgpk7O1hCKW4SA@mail.gmail.com>
In-Reply-To: <CAPv3WKeN55zEW65yfyPizB0WA4HLtcf=m-7yUgpk7O1hCKW4SA@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 80cf6142-b306-4334-d770-08d947a767d4
x-ms-traffictypediagnostic: SJ0PR11MB4813:
x-microsoft-antispam-prvs: <SJ0PR11MB4813196FCB56AD994CC4574287129@SJ0PR11MB4813.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RygDNKgrYOURVGl9L/fZ8MCKAmf09ynk9NIy1pmFYIKtRBEDJf8mhY65SRlf18zp4Zr/HYOTjRKomIvncVZljmZ8fkCZqhS4ak0/Ama0R3V4hDuxFS2coEYdMmCDfnJk29Dqalg9Gi1Vd9VnbLL4AsNBVn3QqTwzk1IfX3en4ZZsf6RRw4mQati8OrOIKUVNzWK3zEOTNKSWIsRhl98u/xA8Xpe+qNI6hThBALCy7TfADBNEj4OSQdgcoX6aYGQW8cG36GWWuihY6QrtW0WUSPJ1WC/m250JWIGLff3l4vlETa6lidRd8Kr4T1xsmUzKr0Nd7UTDCCHFurarQdmKmGjUOAwqqexvjSsof5Qr7fePkN5kWL4yIoQBq4JeG8dg7nGQ5obxN76hWwtRCul9BdBJ3PDX3df/exnhPEOmamefCY9k+4h/hcnx3mHqW70wT/37WDoOIK7iSVIa593FmnPGSooe7/Drt+S2EYgU9el/HKEo/vzrgafTkGyf9TnGjmvJ/q7OMkNuSGIAxYZ6abNUVWi9vdp60YpJfb4pFN+OQi3z7pu28BhtrtOQKrCrQbM6iKwmaKurrOP+Ctot0lJ4vvfolwJraDie1wWAnweVFfP4+qKTb4L1iLWkt6GuA7adX2ANxSQPH/TqPczo9mO6gtHoCdq3Nxi0VaVZ4O+CZ9xtsC9bImF88EUG6f9YVMueglQC90CefzcZMJKHixEVdn+udvMJ6RUKypy3LLIONySXDr6mS80YFmSbyfe2wO4VU5HADlRKM28eKPAzsMFVCOMww3GlvPOOP9wSJLlwwFlKUAIlVJm5pJAkyo+HC0zS7nZhYnr6r++zXQS1SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(33656002)(38100700002)(122000001)(5660300002)(83380400001)(86362001)(7696005)(76116006)(8676002)(4326008)(53546011)(6506007)(8936002)(316002)(71200400001)(2906002)(6916009)(966005)(52536014)(45080400002)(478600001)(54906003)(7416002)(66476007)(26005)(66446008)(9686003)(64756008)(55016002)(66556008)(186003)(66946007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZCM3lMTDg5QlJ3eERkRU85ZEZGOGd3ZWZ6OEd4N1lpaTVJcFhnb3ZYcWtu?=
 =?utf-8?B?c2dWd1lEb040RjZ0cDdGUWZhbTd3dDZaNi81aU9MYTQ4MGtIeDQzYmlKa0M1?=
 =?utf-8?B?bkRjZUd4SzZxVjVPZUdIOVlVM0FscFlaWjBZY09GLzJqYXRESmZ4SmhKd05a?=
 =?utf-8?B?R2hNS2lMRzlOOUE2ckcva0JSSndSLzltaXJCT3ZWUTBnbjI5NDAwc2NRbHVF?=
 =?utf-8?B?VXJycWFES3FjZ3FSamJKSHhCNkJnSTU4YmdjSzZKY2hmcGFvQzFxcG8yZkkx?=
 =?utf-8?B?U1g3QTZ3dk56TjJwSmtWNG9ycFlZQWV5UE9DRVVMeldEU2ViK2Z3Qm54Z25z?=
 =?utf-8?B?ZTVNTURvRHloeGk0TGZUTUFXbHVnNnRjTWVhZStYeTlHOHoyeUxCc0tNc3RU?=
 =?utf-8?B?ZnpRU1hUcytDS3d2UXlGYkpwTnozbGVCMmx4QXZNeFRZNDRsOEN5dnBkRlZy?=
 =?utf-8?B?Zjg1UkJxZUNLN1dheDM2OXVVeWFoQ0VMWjMyb29rcDhPZ2VVOHM3aWp2bzNp?=
 =?utf-8?B?Y3hWTERMVytpM2FoakdDYkI2ZlRwT2tlMnByaU05S1I4NFVEQ3g1N1huNVRl?=
 =?utf-8?B?cFNSWWhsZmNzd25NM2VISS82SUF5YkdNUmFTSTdQNEZhaFhTZkZBTGFLYVha?=
 =?utf-8?B?TVRFNGZOcy82S3RUU1h5LzF6RndkVU5BaUhnVWUxdUtjckZpVm5ob3FleWF5?=
 =?utf-8?B?czVMVTZXaXFZekxZRUNOZlBZRVFEREEwcEJaRHVnVWdoWmhsekxGamM1am9n?=
 =?utf-8?B?ZkpjT3oyOUVYbFpoeXdwcDRlV0N0TGxaZTgrZTl2eGJ1Q1M3dXVGRnduNUZv?=
 =?utf-8?B?N1N4c0l0R3ZSWXNvR253aTBJK0FJV2JOSnBSanp3Z3BIUzc1MHg4c3ViejYx?=
 =?utf-8?B?czd6eHM4WGtBUzlLMnV3WEE2c0paNFNtc0huQUtGc3BSWDVHWnFTZmEvRG1r?=
 =?utf-8?B?Sndvb0pWVVVZQ200ZEpmQXNMNHYrZkEvQmNvZGh2eE9WMkNhMXZLekgyUG45?=
 =?utf-8?B?NXF2Vkd4VW5CYWlPR3NkYUFhZExqait0WEVFTkNCUm1KSkN1TUQ0MXYyMWY1?=
 =?utf-8?B?cVZhMVRVdXdSempSekNDaGhsc2wyR1lYTnJsSUdhUEJnWkJqb0xuQUZQQ1RI?=
 =?utf-8?B?K05yUVJSZVlNZXBqbUNTZ3FUcTRaa216Zmo3aXhIV2VxUnRlcE9JK1dGb0l3?=
 =?utf-8?B?V1hkc1g1MVl4Q3BkUEJLWVVPSnplaVZyNjAxOUFmWXhpQkpHWFdBNG1WaHVV?=
 =?utf-8?B?cW1TZzY0dUlldFAyYlJlNUs0cjdJdDNXQUNBME90NkxSOUhJeWcrSlAxMGxK?=
 =?utf-8?B?UlYrY1Y5VnhNVHdzQ3dhUm9lUzQzTGZYQTVMeDBoejE5Wlp0SDZ0alRkTE10?=
 =?utf-8?B?dEVLK0FML05KN2VZdzQ5RjlqOGlZNEZDQVFNVCt4bmV2dzFyeGUzVGxmMGtU?=
 =?utf-8?B?VWV5N3NxcEoxSE9YT0N5UWhITmhJTGpqMG5ZUjgzdlJFUnRtY2FJS1Z5Sm1T?=
 =?utf-8?B?d1N3c0poUi9LL2hVYzA3ZU1xQWpBVFhSeVdYdE1ET1R4cjArRXhQYjIrNE91?=
 =?utf-8?B?UTlKWThMUDFrQmo1MXk3UzlLRm9QVmRwVm9SZWhNdXZMSjM5UzdLY3lpckEz?=
 =?utf-8?B?UzhacE1jenlhQWRoSzVleXQ0LzR3dkU5cHJQc2xOMndLN2JwcVMzVmZkd3pG?=
 =?utf-8?B?NW5yMDdaWjB5Tlk1QnFZeUdEMDA0aGRWbm1FdnRQRTFST1hQQUYrR2lFSSsv?=
 =?utf-8?Q?of0R8/LFXjCgOcr+CtQtu8sv2Sf8OjSgtz7egCO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf6142-b306-4334-d770-08d947a767d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 15:44:17.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wtwLeWnJ4YSQQ+s6eaAIHKpYqC3a/hu1Z9Mmk2VeAgzBaLTtgvtdjj/7gW/E+SmWOQbi8PuO1iknAg6djQE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhlIHBhdGNoIHdhcyBwb3N0ZWQgYXMgYSBwdWxsIHJlcXVlc3Qgb24gb3VyIGdpdGh1YiBzaXRl
Lg0KDQpUaGUgbWVyZ2VkIHBhdGNoIHdpbGwgYmUgcmVsZWFzZWQgYXMgcGFydCBvZiB0aGUgbm9y
bWFsIEFDUElDQSByZWxlYXNlIHByb2Nlc3MsIHdoaWNoIHdpbGwgdGhlbiBtYWtlIGl0IGludG8g
TGludXguIFlvdSBzaG91bGQgdGhlbiByZWJhc2UuDQpCb2INCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYuY29tPiANClNlbnQ6
IFRodXJzZGF5LCBKdWx5IDE1LCAyMDIxIDc6MTcgQU0NClRvOiBNb29yZSwgUm9iZXJ0IDxyb2Jl
cnQubW9vcmVAaW50ZWwuY29tPg0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBqYXpAc2VtaWhhbGYu
Y29tOyBnamJAc2VtaWhhbGYuY29tOyB1cHN0cmVhbUBzZW1paGFsZi5jb207IFNhbWVyLkVsLUhh
ai1NYWhtb3VkQGFybS5jb207IGpvbkBzb2xpZC1ydW4uY29tOyB0bkBzZW1paGFsZi5jb207IHJq
d0Byand5c29ja2kubmV0OyBsZW5iQGtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBBQ1BJQ0E6IEFkZCBuZXcgREJHMiBTZXJpYWwgUG9ydCBTdWJ0eXBlcw0KDQpIaSwNCg0KDQpj
encuLCAxNSBsaXAgMjAyMSBvIDE2OjA3IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRl
bC5jb20+IG5hcGlzYcWCKGEpOg0KPg0KPiBUaGlzIHdhcyBhbHJlYWR5IHJlcG9ydGVkICh3aXRo
IGEgcGF0Y2ggdGhhdCB3ZSd2ZSBhbHJlYWR5IG1lcmdlZCkgYnkgDQo+IHNlbWloYWxmLXdvanRh
cy1tYXJjaW4NCj4NCg0KSSdtIG5vdCBzdXJlIHRvIGJlIGF3YXJlIG9mIHRoZSBwcm9jZXNzLiBS
ZXBvcnRlZCB3aGVyZT8NCkFyZSB5b3UgcGxhbm5pbmcgdG8gaW1wb3J0IHRoZSB1cHN0cmVhbSBw
YXRjaCBvbiB5b3VyIG93biBhbmQgSSBzaG91bGQgcmViYXNlIHRoZSBTUENSIGRyaXZlciBjaGFu
Z2Ugb24gdG9wIG9uY2UgaXQgbGFuZHM/DQoNCkJlc3QgcmVnYXJkcywNCk1hcmNpbg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNpbiBXb2p0YXMgPG13QHNlbWlo
YWxmLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE0LCAyMDIxIDI6NDQgUE0NCj4gVG86
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
OyANCj4gZGV2ZWxAYWNwaWNhLm9yZw0KPiBDYzogamF6QHNlbWloYWxmLmNvbTsgZ2piQHNlbWlo
YWxmLmNvbTsgdXBzdHJlYW1Ac2VtaWhhbGYuY29tOyANCj4gU2FtZXIuRWwtSGFqLU1haG1vdWRA
YXJtLmNvbTsgam9uQHNvbGlkLXJ1bi5jb207IHRuQHNlbWloYWxmLmNvbTsgDQo+IHJqd0Byand5
c29ja2kubmV0OyBsZW5iQGtlcm5lbC5vcmc7IE1vb3JlLCBSb2JlcnQgDQo+IDxyb2JlcnQubW9v
cmVAaW50ZWwuY29tPjsgTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMS8yXSBBQ1BJQ0E6IEFkZCBuZXcgREJHMiBTZXJpYWwgUG9ydCBTdWJ0eXBlcw0K
Pg0KPiBBQ1BJQ0EgY29tbWl0IGQ5NWM3ZDIwNmI1ODM2Yzc3NzBlOGU5Y2Q2MTM4NTk4ODdmZGVk
OGYNCj4NCj4gVGhlIE1pY3Jvc29mdCBEZWJ1ZyBQb3J0IFRhYmxlIDIgKERCRzIpIHNwZWNpZmlj
YXRpb24gcmV2aXNpb24gU2VwdGVtYmVyIDIxLCAyMDIwIGNvbXByaXNlcyBhZGRpdGlvbmFsIFNl
cmlhbCBQb3J0IFN1YnR5cGVzIFsxXS4NCj4gUmVmbGVjdCB0aGF0IGluIHRoZSBhY3RibDEuaCBo
ZWFkZXIgZmlsZS4NCj4NCj4gWzFdIA0KPiBodHRwczovL2RvY3MubWljcm9zb2Z0LmNvbS9lbi11
cy93aW5kb3dzLWhhcmR3YXJlL2RyaXZlcnMvYnJpbmd1cC9hY3BpDQo+IC1kZWJ1Zy1wb3J0LXRh
YmxlDQo+DQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL2NvbW1pdC9k
OTVjN2QyMA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+
DQo+IC0tLQ0KPiAgaW5jbHVkZS9hY3BpL2FjdGJsMS5oIHwgMTUgKysrKysrKysrKysrKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2FjdGJsMS5oIGIvaW5jbHVkZS9hY3BpL2FjdGJsMS5o
IGluZGV4IA0KPiBlZjI4NzJkZWEwMWMuLjdiYmIzZTJiZDMzZiAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9hY3BpL2FjdGJsMS5oDQo+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3RibDEuaA0KPiBAQCAt
NDgyLDcgKzQ4Miw3IEBAIHN0cnVjdCBhY3BpX2NzcnRfZGVzY3JpcHRvciB7DQo+ICAgKiBEQkcy
IC0gRGVidWcgUG9ydCBUYWJsZSAyDQo+ICAgKiAgICAgICAgVmVyc2lvbiAwIChCb3RoIG1haW4g
dGFibGUgYW5kIHN1YnRhYmxlcykNCj4gICAqDQo+IC0gKiBDb25mb3JtcyB0byAiTWljcm9zb2Z0
IERlYnVnIFBvcnQgVGFibGUgMiAoREJHMikiLCBEZWNlbWJlciAxMCwgDQo+IDIwMTUNCj4gKyAq
IENvbmZvcm1zIHRvICJNaWNyb3NvZnQgRGVidWcgUG9ydCBUYWJsZSAyIChEQkcyKSIsIFNlcHRl
bWJlciAyMSwNCj4gKyAyMDIwDQo+ICAgKg0KPiAgIA0KPiAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioq
KioqLw0KPg0KPiBAQCAtNTMyLDExICs1MzIsMjQgQEAgc3RydWN0IGFjcGlfZGJnMl9kZXZpY2Ug
ew0KPg0KPiAgI2RlZmluZSBBQ1BJX0RCRzJfMTY1NTBfQ09NUEFUSUJMRSAgMHgwMDAwDQo+ICAj
ZGVmaW5lIEFDUElfREJHMl8xNjU1MF9TVUJTRVQgICAgICAweDAwMDENCj4gKyNkZWZpbmUgQUNQ
SV9EQkcyX01BWDMxMVhFX1NQSSAgICAgIDB4MDAwMg0KPiAgI2RlZmluZSBBQ1BJX0RCRzJfQVJN
X1BMMDExICAgICAgICAgMHgwMDAzDQo+ICsjZGVmaW5lIEFDUElfREJHMl9NU004WDYwICAgICAg
ICAgICAweDAwMDQNCj4gKyNkZWZpbmUgQUNQSV9EQkcyXzE2NTUwX05WSURJQSAgICAgIDB4MDAw
NQ0KPiArI2RlZmluZSBBQ1BJX0RCRzJfVElfT01BUCAgICAgICAgICAgMHgwMDA2DQo+ICsjZGVm
aW5lIEFDUElfREJHMl9BUE04OFhYWFggICAgICAgICAweDAwMDgNCj4gKyNkZWZpbmUgQUNQSV9E
QkcyX01TTTg5NzQgICAgICAgICAgIDB4MDAwOQ0KPiArI2RlZmluZSBBQ1BJX0RCRzJfU0FNNTI1
MCAgICAgICAgICAgMHgwMDBBDQo+ICsjZGVmaW5lIEFDUElfREJHMl9JTlRFTF9VU0lGICAgICAg
ICAweDAwMEINCj4gKyNkZWZpbmUgQUNQSV9EQkcyX0lNWDYgICAgICAgICAgICAgIDB4MDAwQw0K
PiAgI2RlZmluZSBBQ1BJX0RCRzJfQVJNX1NCU0FfMzJCSVQgICAgMHgwMDBEDQo+ICAjZGVmaW5l
IEFDUElfREJHMl9BUk1fU0JTQV9HRU5FUklDICAweDAwMEUNCj4gICNkZWZpbmUgQUNQSV9EQkcy
X0FSTV9EQ0MgICAgICAgICAgIDB4MDAwRg0KPiAgI2RlZmluZSBBQ1BJX0RCRzJfQkNNMjgzNSAg
ICAgICAgICAgMHgwMDEwDQo+ICsjZGVmaW5lIEFDUElfREJHMl9TRE04NDVfMV84NDMyTUhaICAw
eDAwMTENCj4gKyNkZWZpbmUgQUNQSV9EQkcyXzE2NTUwX1dJVEhfR0FTICAgIDB4MDAxMg0KPiAr
I2RlZmluZSBBQ1BJX0RCRzJfU0RNODQ1XzdfMzcyTUhaICAgMHgwMDEzDQo+ICsjZGVmaW5lIEFD
UElfREJHMl9JTlRFTF9MUFNTICAgICAgICAweDAwMTQNCj4NCj4gICNkZWZpbmUgQUNQSV9EQkcy
XzEzOTRfU1RBTkRBUkQgICAgIDB4MDAwMA0KPg0KPiAtLQ0KPiAyLjI5LjANCj4NCg==
