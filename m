Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41AD2FF7F0
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAUWar (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 17:30:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:38201 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbhAUWap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 17:30:45 -0500
IronPort-SDR: DO81v/G4dfKwHyjMZ3OhRcbTcTjQnYa8wwRGA+jtrZio4EAOxv5xFtMYgRinFF+6dp1O4vKt58
 O5Wa0b1A4Frw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="167031934"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="167031934"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 14:29:43 -0800
IronPort-SDR: D/pvcUFpI5A/FHcG3ZYjcxJZLBXyCC152P+dAaMvs/GlKxDXZSVhixb5mIxUXroK2ct+Fj+TF+
 CuCo1FkSjIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="355004156"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2021 14:29:43 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 14:29:42 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 14:29:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Jan 2021 14:29:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 21 Jan 2021 14:28:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw2C/0omqGkdOOd6LZBgyw1yjLzBaiJS9zj3Qtp7DIGZhUI36QFUs8qljtfclHOai9smqhdBLxx0Dk81WhUDuv5i5Eqyn3O066ej/xdP3Uh3TP+7VnjPvob6Lro/gQhqlv3Vt4ZQFHXnnh650hpzLS0zYTxPI23PSRBHPKp5Ws9g641dYBngDsYWlMdESDMfSAAFbycyxpGtq5A4BHcmihEgj9qUCuc6IavMKcseLpCqQqIc8Qo+pwQVTBBemPwcbns0EqLQVVzXhbNddE4rEKLSRGGG953Sly5vSCNGqz6j5VUYbAV/pOfF627Aajy55lIJFHsnoil9rRDlkE1stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE/LP/6yO+4jtEBFTgOxYdk3XzES5C46J7jnI6M0pzQ=;
 b=nN4IJSEJDKGZtqNsHbYlEoPHssA8yPzJLtl5UUH7KB/BIfugJaVW7a9i/nwcYP9+cKzxyNAqcNyqt1jmg1pl82T/drq3nzSWrHGTOikCFfGkawpzZxJF3YN9DeWDiTib5zvER9Hc3mRxHDa8YErPLQQQ46dxm61E6Irw2dNent6MDQFfU/2ShagV9HQODZUXZidMWoRX6vw400ltMrBdDRjHJiyljGwPPQfaRM7RvCd+FdHwMttIgB7wMVGkioDW8PlrveNTE4OmAVxaiXqNFxBo10r/c72d/n6A7wNJY8OcMO9ULdIQpn/2bIEJ9h7c6JZ5aSoRYRfsP22moxc91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE/LP/6yO+4jtEBFTgOxYdk3XzES5C46J7jnI6M0pzQ=;
 b=WvQ563QhDlo8xYrUPpvH1UDiM2Klza8M16sNLTMVJ1Mi9gJ1ShcGwgqVvoqwD8J4FmEfKlMgPBh7JYvLSgc40SIki/yTIpgD4KW9GFT4bJBj8M57ECPqlC7u4V0ZPFH6TuiTvuQqmiycKirZR9vm7oPDzOmyLRzWx53FN2yAgbI=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1247.namprd11.prod.outlook.com (2603:10b6:300:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 22:28:07 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3763.014; Thu, 21 Jan
 2021 22:28:07 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough
Thread-Topic: [PATCH] ACPICA: fix -Wfallthrough
Thread-Index: AQHWt9BQlYjhl8Bfrk+mO8TKTgEi+KoySncAgACWFoCAAAE0gIAAN1Mw
Date:   Thu, 21 Jan 2021 22:28:07 +0000
Message-ID: <MWHPR11MB159916E99EBE052E376FC8D6F0A10@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com>
 <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
 <CAKwvOdnG6Ew+7HMjJuH3Or8kEE_ZyP-xNGbwaX8HdT=6FApYxA@mail.gmail.com>
In-Reply-To: <CAKwvOdnG6Ew+7HMjJuH3Or8kEE_ZyP-xNGbwaX8HdT=6FApYxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deea18fb-0ae4-4610-8ea8-08d8be5bd3cc
x-ms-traffictypediagnostic: MWHPR11MB1247:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB12478716E341FAF6D75E0E15F0A19@MWHPR11MB1247.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wqyzh31GBPQR3No+Q7PQ6QqI1vjORIQMkzLLETWE+LWwVYQoArW0ikk06jamq3OnZ9EeEGVGk9CVnUldwBTBT7EJnvhcNB0FpLDI4donjz0JP74kUyP9lDpUjK1cXPXgwvE5JFJuXCju/g6qMFdtV7sudOC5YqXw6zpO7EqL4b5NWaetC0Ooq7jiJJGtKMV9JgC8i+0xhTLkw/+pqrzgk1teHRNGvBjIqrUdPIPWBA+oDSN96q3PRuy549HFp1wm/9pbMuFOMoU1QDUj+kkmPvnvz7uqtdvIOoYuo1LF9f366LugX3kNs9fVzL2LBh2EXkjUWJfE/Iq1HWOAhlx6Mwcq0ONO/kGuXvprk9zHqjk62URnYzGjmy7CXe1yVCruDAEOhlyamTIo4jZJu8ief5yUU01AJ1hqA/zE9IxFqsDvp1GpT9V6W+5t06hP+ych5xiY6JiS9bkhSq/cwCXYXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(4326008)(316002)(52536014)(2906002)(5660300002)(8936002)(55016002)(478600001)(83380400001)(966005)(9686003)(71200400001)(64756008)(7416002)(66476007)(54906003)(33656002)(66556008)(66446008)(8676002)(7696005)(6506007)(26005)(53546011)(76116006)(186003)(66946007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M3V0dGFZeDU1ODA5cE1Ca0ppeEFIdFZ3SmtTeHVIM25wODZRdW9QaEEyOEZZ?=
 =?utf-8?B?NVAzMjNENWJXdHl3U1h6VldpYUZ4SmJzS1VIb2dtOUFoK013Q1JvWWJsdFJ1?=
 =?utf-8?B?TzM2bEdUblk1YjZab2pCYVRzWWhrNklOUWhyR0xOQnZOdUN2a0RHTmpORUJ5?=
 =?utf-8?B?Y1A5MnlZWTJJY25RSlhYeDNGTldUUzE0aXc0SmJtYmFPVU1PNDBGWExVTnlS?=
 =?utf-8?B?dkN3WDh6TFdJSUdtaUhTaUVYTEQ1eVNlZDQ3akE3SlBNb1FxcitQbkx2VnR4?=
 =?utf-8?B?dlloclFoVGpQVGg4L0pnWHA5a1pweFFEbzc2UzlSZDZoelNTMHNjQUU1TWVB?=
 =?utf-8?B?SjNhMkZycWY5SGtQd1pRSEt2NUhUcVlGdnl2UW1wUHdDTTd0STZkU21UakNE?=
 =?utf-8?B?c1NSUytpWnpPQUxwa2N6UGthMUUxOEtjNzdvNFhIWlhRWXA1RDczZ092Nkh1?=
 =?utf-8?B?dTZLRDdTTnkvdFFwNjFucXRZNkM3Wm1tOVc0UWcvQnQ5M2tpL1lXRmZVUWx2?=
 =?utf-8?B?OFpvdk01UHlyV08vK1VZalM1eStEZGV2T0hzSnBnZXYxaW9aMmhhVjNvcUlN?=
 =?utf-8?B?c3BId1RaM3VwNzUydTZCV0V2UWNUazd0djVUSG9kT25XVVJzZnVySW1oZ0Za?=
 =?utf-8?B?TWllVkNqK2xDT0hiSkRuaWlkSFhyVzhVdHVsRUgweU5OTjZ1ZGM0UElPMTdT?=
 =?utf-8?B?b3VzUWFBWXYxS1ZtcUlyak5xaHI0b3VEVkFXbU1Ca3RhM1NNbTVycjc5TGN0?=
 =?utf-8?B?SmlyMEowWlBtbzN0aFdFMEp4SDNXUDRYMER4WUJ1MWxFVE9vWnFERDQ5YkVC?=
 =?utf-8?B?dkx3cXFJalRiNWE0cVRZbzdMSWVDNjIyWkpSbmRxcjVhZEJPL1hWbExZdTBB?=
 =?utf-8?B?cndEa1NsYThuNXFUZFRZRW52VWdhSWxTNGZ6Y3I4TnFsdC9JK0lUVjRVOEIw?=
 =?utf-8?B?dXhRQTcrMkpoYVpMejNaV1ZTK29nRjAxRE9YR2Y2TXQ1aUpYd2c0ZkhBbjdI?=
 =?utf-8?B?bFIzemZueUZDWFQ4L3N6RzhSN1hYQ1hwbmhSd01NMWRGOHR4bWN6aUt2QllD?=
 =?utf-8?B?RnphY29KbVJtVzJsRDhuVm9zYjR5eXVDdzUzOW5VWExNVVNlWnExTnkveGNG?=
 =?utf-8?B?VkF0WFRGWE15R0QxUW9waUZ3NENHRCtoWHllNmRGelQ2WWh1ZXpBMWNFZGto?=
 =?utf-8?B?QTVuZk11WHU5RlVDOG1QS3dwZFFYdTFubzVnRUZIQm1EWlg2WXpWaWRnakJr?=
 =?utf-8?B?TFlVc2g0QnE2bFFQYTE1OExKZEtNb0xmWElCbXlWTmc3dTBldk9nZ0V4Ukdl?=
 =?utf-8?B?bjFIZks5Zm80MllPM3hJb21VeHExNXFCZTZzM0JwaWlJeVREc2JPdHViVk1J?=
 =?utf-8?B?RDdkZFQwa1VhOU44RExteFc5dFh3UVhoOEpkNTRxN24rc2NTZnlaRDNSZVdU?=
 =?utf-8?Q?7PTA9za+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deea18fb-0ae4-4610-8ea8-08d8be5bd3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 22:28:07.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smQhCATiZ7P/QlNrDzzS7bdJkI2h3hCh9gG79wrk6foexZYyDwcVX1FH/D+8Y+Z/hgTaI0CMIUyiL+iXqUI5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1247
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljayBEZXNhdWxuaWVy
cyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIx
LCAyMDIxIDExOjA4IEFNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5v
cmc+OyBLYW5lZGEsIEVyaWsNCj4gPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gQ2M6IEpvbiBI
dW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1v
b3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbT47DQo+IEd1c3Rhdm8gQSAuIFIgLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPjsg
Y2xhbmctYnVpbHQtbGludXggPGNsYW5nLWJ1aWx0LQ0KPiBsaW51eEBnb29nbGVncm91cHMuY29t
PjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBBQ1BJIERldmVsDQo+IE1hbGluZyBMaXN0
IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVA0K
PiBBUkNISVRFQ1RVUkUgKEFDUElDQSkgPGRldmVsQGFjcGljYS5vcmc+OyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtdGVn
cmEgPGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
QUNQSUNBOiBmaXggLVdmYWxsdGhyb3VnaA0KPiANCj4gT24gVGh1LCBKYW4gMjEsIDIwMjEgYXQg
MTE6MDMgQU0gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDExOjA4IEFNIEpvbiBIdW50ZXIgPGpv
bmF0aGFuaEBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMTEv
MTEvMjAyMCAwMjoxMSwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4gPiA+ID4gVGhlICJmYWxs
dGhyb3VnaCIgcHNldWRvLWtleXdvcmQgd2FzIGFkZGVkIGFzIGEgcG9ydGFibGUgd2F5IHRvDQo+
IGRlbm90ZQ0KPiA+ID4gPiBpbnRlbnRpb25hbCBmYWxsdGhyb3VnaC4gVGhpcyBjb2RlIHNlZW1l
ZCB0byBiZSB1c2luZyBhIG1peCBvZg0KPiA+ID4gPiBmYWxsdGhyb3VnaCBjb21tZW50cyB0aGF0
IEdDQyByZWNvZ25pemVzLCBhbmQgc29tZSBraW5kIG9mIGxpbnQNCj4gbWFya2VyLg0KPiA+ID4g
PiBJJ20gZ3Vlc3NpbmcgdGhhdCBsaW50ZXIgaGFzbid0IGJlZW4gcnVuIGluIGEgd2hpbGUgZnJv
bSB0aGUgbWl4ZWQgdXNlDQo+ID4gPiA+IG9mIHRoZSBtYXJrZXIgdnMgY29tbWVudHMuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVy
c0Bnb29nbGUuY29tPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBJIGtub3cgdGhpcyBpcyBub3QgdGhl
IGV4YWN0IHZlcnNpb24gdGhhdCB3YXMgbWVyZ2VkLCBJIGNhbid0IGZpbmQgaXQgb24NCj4gPiA+
IHRoZSBsaXN0LCBidXQgbG9va3MgbGlrZSB0aGUgdmVyc2lvbiB0aGF0IHdhcyBtZXJnZWQgWzBd
LA0KPiA+DQo+ID4gSXQgd291bGQgYmUgdGhpcyBwYXRjaDoNCj4gPg0KPiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj4gYWNwaS9wYXRjaC8yMDIxMDExNTE4
NDgyNi4yMjUwLTQtZXJpay5rYW5lZGFAaW50ZWwuY29tLw0KPiA+DQo+ID4gTmljaywgRXJpaz8N
Cj4gDQo+IG9oLCBzaGl0LCBsb29rcyBsaWtlIGEgbGluZSB3YXMgZHJvcHBlZC4gIEhlcmUncyB3
aGF0IEkgc2VudCB1cHN0cmVhbToNCj4gaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2Ev
cHVsbC82NTAvZmlsZXMjZGlmZi0NCj4gY2NjZDk2ZTkwMGUwMWY3MjI0YzgxNTA4Y2JkZGZiMWFm
NmZjZmJmZjk1OWQ2YmZiNTUxMjNlMWI5Y2FkNGUzOFIxNTQNCj4gMw0KPiBOb3RlIGluIHRoZSBw
YXRjaCBSYWZhZWwgbGlua3MgdG8gdGhhdCBsaW5lIGlzIG1pc3NpbmcgYW5kIHRoZXJlJ3MNCj4g
aW5zdGVhZCBhbiAjaWZkZWYgdGhhdCdzIGVtcHR5LiAgV2FzIHRoaXMgbGluZSBhY2NpZGVudGFs
bHkgZHJvcHBlZD8NCg0KTG9va3MgbGlrZSB0aGlzIGxpbmUgd2FzIGRyb3BwZWQgYnkgQUNQSUNB
J3MgTGludXgtaXplIHNjcmlwdHMuIEknbGwgcmUtYWRkIGl0IGFuZCBzZW5kIGFnYWluLg0KDQpS
YWZhZWwsIGRvIHlvdSB3YW50IG1lIHRvIHJlLXNlbmQgdGhlIHNlcmllcyBvciBkbyB5b3Ugd2Fu
dCBtZSB0byByZXNlbmQgdGhlIHNwZWNpZmljIGNvbW1pdD8gSSBkb24ndCBtaW5kIGVpdGhlciB3
YXkuDQoNClRoYW5rcywNCkVyaWsNCj4gDQo+ID4NCj4gPiA+IGlzIGNhdXNpbmcgYnVpbGQgZXJy
b3JzIHdpdGggb2xkZXIgdG9vbGNoYWlucyAoR0NDIHY2KSAuLi4NCj4gPiA+DQo+ID4gPiAvZHZz
L2dpdC9kaXJ0eS9naXQtbWFzdGVyX2w0dC0NCj4gdXBzdHJlYW0va2VybmVsL2RyaXZlcnMvYWNw
aS9hY3BpY2EvZHNjb250cm9sLmM6IEluIGZ1bmN0aW9uDQo+IOKAmGFjcGlfZHNfZXhlY19iZWdp
bl9jb250cm9sX29w4oCZOg0KPiA+ID4gL2R2cy9naXQvZGlydHkvZ2l0LW1hc3Rlcl9sNHQtDQo+
IHVwc3RyZWFtL2tlcm5lbC9kcml2ZXJzL2FjcGkvYWNwaWNhL2RzY29udHJvbC5jOjY1OjM6IGVy
cm9yOg0KPiDigJhBQ1BJX0ZBTExUSFJPVUdI4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQ0KPiA+ID4gICAgQUNQSV9GQUxMVEhST1VHSDsNCj4gPiA+ICAgIF5+fn5+
fn5+fn5+fn5+fn4NCj4gPiA+IC9kdnMvZ2l0L2RpcnR5L2dpdC1tYXN0ZXJfbDR0LQ0KPiB1cHN0
cmVhbS9rZXJuZWwvZHJpdmVycy9hY3BpL2FjcGljYS9kc2NvbnRyb2wuYzo2NTozOiBub3RlOiBl
YWNoDQo+IHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVh
Y2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbg0KPiA+ID4gL2R2cy9naXQvZGlydHkvZ2l0LW1hc3Rl
cl9sNHQtDQo+IHVwc3RyZWFtL2tlcm5lbC9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4NzogcmVj
aXBlIGZvciB0YXJnZXQNCj4gJ2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNjb250cm9sLm8nIGZhaWxl
ZA0KPiA+ID4NCj4gPiA+IENoZWVycw0KPiA+ID4gSm9uDQo+ID4gPg0KPiA+ID4gWzBdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL2NvbW1pdC80YjkxMzVmNQ0KPiA+ID4NCj4gPiA+
IC0tDQo+ID4gPiBudnB1YmxpYw0KPiANCj4gDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IH5OaWNr
IERlc2F1bG5pZXJzDQo=
