Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43259313F0F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhBHTdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:33:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:8558 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236219AbhBHTbJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Feb 2021 14:31:09 -0500
IronPort-SDR: K77P6ZM3Rrf0u4WDavatuOEM0weia67rUOedT5S05/bWFbuc9YgWR36AdrT2oWr8XSjKB0AWcD
 djTG/i1kswSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="245838148"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="245838148"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:30:28 -0800
IronPort-SDR: BAT6VnLyIpl2DjAs4Zpo3y5/9N1sYQDQFYHj/rNVa3nWPZii/fWLDeniS39R89SUt5J/4pwhba
 hYIDmCj5E2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395661660"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2021 11:30:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 11:30:27 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 11:30:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Feb 2021 11:30:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 8 Feb 2021 11:30:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFb76AtAtcra6yZ7o7Lwt9VCM5stahyBGVpIQhfFY3nmF7a9VjuH537LGSirCmBfW4hYvmatu7PAKrNMcCeJUZIo2d0bYMnmeySOphl+OXBg48uunYKHG54sq1ztgFDz+daXzH0mEZQJJ3EgwmA3u0kOdU9ep5SK8647R/o3AAkx7kS7LSe2Fs8OcmWbdE3N/Zlemfm07Ewq9UjX/PzL+u6iDi5icv+k77Gmt4Sj5JGnrU0eGltbauHP9xJwghpftM9C4cG2TeLMFxl8tl5ddfCk/Z/JlHo1x/nSwnleor4GzKlXZGh68tSeArZF+UtN9c2se36OluOemBTtYEtqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnyHw2e67/Iyxwe8P3cKrmKiP/Au6Z7WMxRJ7LFsd80=;
 b=HRH6qNl5yt5Co6wcUgn87LBCjgKhBmnZUoPYIyXv9p/vVcK6DAsY4CG8VKH4xmA29DjNiP8RslFsRYGd1bIg81CdLMkfN2eH2Bw3Ff1Bq1YKsUCP9dEe5wM59gBxsnF1rdrABCZIrN4Fgn+mmixMM9f/RqPj+uzeqDHB6hG7fC5lExpwIOHZMej8tQBXtasbqG3T3jF3ul2JIwQfHer7aSyhBgX1Txq1Dbnk1FDrk23SK2j6QiI3Rxy1HhFC+amQM26dIT0TzObsDbwrVTEFOsn4FwpzwlPjGA+l5/mOINR2vLZdqoxSX4CGP68v6ZHAZybOnacEXvL922/x67GxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnyHw2e67/Iyxwe8P3cKrmKiP/Au6Z7WMxRJ7LFsd80=;
 b=bmQ+SmB7NB9rqckTOphD/jXGLUh3FaxPYWbHuTt//PN6oPE+hIKgLRjp2HaxQSlCDGKTn1pwq6QQVGl5kJeJKc44vcAuqdrVKPhCJm2zszDw+GBr4PMEZWb+r/mKkwwk9SfBtFKZC4COTxexFJK/2479prwT4u6IXNsGkqgSQFs=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Mon, 8 Feb
 2021 19:30:25 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 19:30:25 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Thread-Index: AQHW/GUhvu4EQ1vBQEifLLDSD3v09qpK8oqAgANJjgCAAFu8EIAADHYAgAAC75A=
Date:   Mon, 8 Feb 2021 19:30:25 +0000
Message-ID: <MWHPR11MB15993FCF4B43A8B7B877265EF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210206084937.20853-1-ardb@kernel.org>
 <20210206104854.GC27503@dragon>
 <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
 <MWHPR11MB1599534717CB4A1447A8DE7CF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
 <CAMj1kXGwedPfS0xBJn9XXoLVVH44eNmKykf7LdGOgOJ4qPqQiw@mail.gmail.com>
In-Reply-To: <CAMj1kXGwedPfS0xBJn9XXoLVVH44eNmKykf7LdGOgOJ4qPqQiw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 4ac057e5-b673-4c26-b81f-08d8cc67fc18
x-ms-traffictypediagnostic: MW3PR11MB4731:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47312BB2C41862768ACED3E2F08F9@MW3PR11MB4731.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Me6W4XRqKgOEEQSagClaUGFWHVeM2GsY2Rc3bg2MY61dkZIEyF8i7q851S9gfOXFshqM0DDgIhDDC5n0uByCAzCbuwdMoueXJzcXRgXbFs9GRJHSvX0zzNg32t3UnR+JliEPEkNcIoBQkgEKFzkAZX+L6oUGhShNiIekl/RrxU9ZN7vr3qm3dlKEH3HoXNubRQr0ML5d1LzqfmyY2XEbhFqM28uEaxK+xiyzTiN3i9l3+xSXt5ARFNHpvv70cwhZSL8tuCB3Q9aACWFRXR6Oukd5cukk8fOH3lrGqZwGv5ULyUXwwKU7HphoFjkefA2RQ7pjtFNYX+bDjcwEQmn4/dP0C8cYA6oxoJ3ZCab+Ckn/Jx8xW/p7O03lc5H/a6we9I1WgZJzk+lk3/G3mtOS7j90H121h43uTHY6JEdWv4aFzQA5TgHYiqlgnQSfWsUIkQ8+zVuje0SMIKhp9Qzm3taIcaL3v4hv3FTrtFPWUfBIiAcTqQs7Rx867veCXRObjwYzljmGDH0GLIsD3RbRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(76116006)(55016002)(66946007)(66556008)(478600001)(7696005)(5660300002)(33656002)(9686003)(316002)(4326008)(66446008)(64756008)(66476007)(52536014)(71200400001)(54906003)(2906002)(86362001)(8936002)(26005)(186003)(6506007)(53546011)(6916009)(8676002)(83380400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NW4yREwrakx0UzZ2YTB4SXRqSGUxRkpTbllEdE5GYjlEV3k1RW13SFllSVp5?=
 =?utf-8?B?dXdBSDhFVHBoalAxa0M4SDZodWVpWkh5cVVzRE8zbXRUdEFMSUsxS05GeDl6?=
 =?utf-8?B?a1FIay9xZWpEVzh5c0dkVXRkb3FlRTB6ZDMyU3dGYmZRdDZ6V1YrYUZPclcy?=
 =?utf-8?B?d2dXU29jVzVlQzFud2ptVUJsV3F2TGdtV09KUVMwemxzZkZFTmxZeWMvSUZY?=
 =?utf-8?B?cTQ0WlRnbm8yY0llOVJEQWhiN05BOElMa2JydlNPRVlQaURDRWVPS2NPRUxX?=
 =?utf-8?B?VXhCeE10RGhvbjJxZ1Y3YnAzNlg2STdBeHluVXdLakFFcFpuSWt1V0JpdGJa?=
 =?utf-8?B?MjV5TnE0VUNMaWlBK3ZjMklEOHdDVlR2K2pOR1pjMHkrakdRbHpMdVRNS05L?=
 =?utf-8?B?dTJpVHV3NHhLbjM3NEsyaVQwSTBpZSsyQ0JmcmtnamJHUXduTXBkcGt1enJ3?=
 =?utf-8?B?ZGVHMmlCSDZCeHp2YllYRGpzbWsrNlR6ZWFzMEN2VElDYmdMZHR1SXhaWmky?=
 =?utf-8?B?STQydkw5QUJSTXFQaFlCYVlKSWZhZ3poNTc1VHZCMkp3dUhWVTBQaE5RZlJu?=
 =?utf-8?B?QkN4V3VhUXBIc0dLOTdORzgxZTZLa2Q4MkNLWTZydWJpdTNaUzdmTDRKci9r?=
 =?utf-8?B?THk2emRLNUp6eU12eXROM05Pa245OVN4REUyUDJIcCtxWlo1eVpLdE1FNEhH?=
 =?utf-8?B?Mm1KcXR6RXMvNUtCT2dmVURmN1hwdHU1NkhLZnd5UDlWczUvbDJoVG9DZ2lW?=
 =?utf-8?B?dWMyQkR4bVBxZkwzNjlVOTBVeUhta20ybVRkbXVJL3V1Q2FickFGNzVTNFdK?=
 =?utf-8?B?aGFpMTdZTzFtWjA5UEo1MVJtcStIVUtzZGxxYSs1OEhCUmhHMkVpSjRTWGg3?=
 =?utf-8?B?WFpEcGdaSDhBTTFJd1NoYXpyUnNESXhKbEFRTDBNcTgvUmRobW10dmVHdzJE?=
 =?utf-8?B?WlRLd3RjODE3WDlWTGxEK1paTEUwYTlPdk9lNlh1WHdzL3VpZEt5VHVhemJQ?=
 =?utf-8?B?Vlc1NGdSOEpvNnEzQ05hVisrMGRNZFgzZFFPcVcrWHpIeGZXTGpxbklHR0dr?=
 =?utf-8?B?a0svZlZUUGxEZTN3bkNnU0M0ZEZ1VTE3YWxJRWtaK29TRnIzTEUrZlhIM1NE?=
 =?utf-8?B?eWw2UGhLKzNZLytkZkEzL0tMV2l6L0ZkMVVhRktuQmJnR1R6V0crMmFWQ3Yz?=
 =?utf-8?B?aWVGQk0xRk5UZ1NkOTlkb0RicFZSSE10bmRiazdhT1ByTFBhT1FoMGNXcjNZ?=
 =?utf-8?B?eGh3Nk5hVkl0NDEwWTJsN1dseDk1TUdDSWxrQUlNNDN6QW5KUVlubXFhRUQy?=
 =?utf-8?B?QzRvMUQrR1pCdTQxVVE2UVFaZkp2KysxdWJrcUg4ZTVydE02bFlQZmJKYUZn?=
 =?utf-8?B?bi9lTlpZT2s2eklwVEp3Y05sU09MNUNmdDdRTGx0NWJ0RHR0U2pZRjFtTUZV?=
 =?utf-8?B?ckY5d3Y1QmVMSENiTEVRNVZYOVI4MU52UGdNWFpYWVBBUjJoLzZwc21ORUt4?=
 =?utf-8?B?ZUtNOHpRYXRHdUNubHRudWdwR1N5TDhtQitHYzU0eHd6ajVlTnZybjh4TXJh?=
 =?utf-8?B?V3VkdG9zcUxnY2lrWXFVWmhCY2VBVmpmbDBZbFgyYzFGVTF3UkZicXJ4Rldl?=
 =?utf-8?B?VitCamRkTWFVekNQUkxoa2p6U3QrZFJ6WVF3SXVFWVppd2p2ellwRENrZnlZ?=
 =?utf-8?B?QUtqOStaMUt5MXZmRHhjQkFETUw0bW1QRHVUcWlUdXg1NUxLRHczVXpqNzRn?=
 =?utf-8?Q?oOjQOa4wxCARWCN99Zm9+yg280WITaTUM4hud17?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac057e5-b673-4c26-b81f-08d8cc67fc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:30:25.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lD0bCSyCPcDxcqPgo3cTWGehFx4fUdbceoJ48Xs/v0FkHNnLHBDq4x6EKvYGh2K49u5MLCi3gIrlAotaAF458A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwg
PGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA4LCAyMDIxIDExOjE0
IEFNDQo+IFRvOiBLYW5lZGEsIEVyaWsgPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gQ2M6IFJh
ZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd24u
Z3VvQGxpbmFyby5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc+OyBBQ1BJIERldmVsIE1hbGluZyBMaXN0IDxsaW51eC0NCj4gYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVCBBUkNISVRFQ1RVUkUN
Cj4gKEFDUElDQSkgPGRldmVsQGFjcGljYS5vcmc+OyBXeXNvY2tpLCBSYWZhZWwgSg0KPiA8cmFm
YWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IE1v
b3JlLA0KPiBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFJldmVydCAiQUNQSUNBOiBJbnRlcnByZXRlcjogZml4IG1lbW9yeSBsZWFrIGJ5IHVz
aW5nDQo+IGV4aXN0aW5nIGJ1ZmZlciINCj4gDQo+IE9uIE1vbiwgOCBGZWIgMjAyMSBhdCAyMDow
NywgS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJhZmFl
bCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgOCwgMjAyMSA1OjAxIEFNDQo+ID4gPiBUbzogU2hhd24gR3VvIDxzaGF3bi5ndW9AbGlu
YXJvLm9yZz47IEFyZCBCaWVzaGV1dmVsDQo+ID4gPiA8YXJkYkBrZXJuZWwub3JnPjsgS2FuZWRh
LCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+ID4gPiBDYzogTGludXggQVJNIDxsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBBQ1BJIERldmVsIE1hbGluZw0KPiA+
ID4gTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0IDxsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6
QUNQSSBDT01QT05FTlQgQVJDSElURUNUVVJFDQo+ID4gPiAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNh
Lm9yZz47IFd5c29ja2ksIFJhZmFlbCBKDQo+ID4gPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IE1vb3JlLA0KPiA+ID4gUm9iZXJ0IDxy
b2JlcnQubW9vcmVAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gUmV2ZXJ0
ICJBQ1BJQ0E6IEludGVycHJldGVyOiBmaXggbWVtb3J5IGxlYWsgYnkNCj4gdXNpbmcNCj4gPiA+
IGV4aXN0aW5nIGJ1ZmZlciINCj4gPiA+DQo+ID4gPiBPbiBTYXQsIEZlYiA2LCAyMDIxIGF0IDEx
OjQ5IEFNIFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBTYXQsIEZlYiAwNiwgMjAyMSBhdCAwOTo0OTozN0FNICswMTAwLCBBcmQg
Qmllc2hldXZlbCB3cm90ZToNCj4gPiA+ID4gPiBUaGlzIHJldmVydHMgY29tbWl0IDMyY2YxYTEy
Y2FkNDMzNThlNDdkYWM4MDE0Mzc5YzJmMzNkZmJlZDQuDQo+ID4gPiA+ID4NCj4gPg0KPiA+IEhp
IEJvYiwgQXJkIGFuZCBSYWZhZWwsDQo+ID4NCj4gPiA+ID4gPiBUaGUgJ2V4aXNpdG5nIGJ1ZmZl
cicgaW4gdGhpcyBjYXNlIGlzIHRoZSBmaXJtd2FyZSBwcm92aWRlZCB0YWJsZSwgYW5kDQo+ID4g
PiA+ID4gd2Ugc2hvdWxkIG5vdCBtb2RpZnkgdGhhdCBpbiBwbGFjZS4gVGhpcyBmaXhlcyBhIGNy
YXNoIG9uIGFybTY0IHdpdGgNCj4gPiA+ID4gPiBpbml0cmQgdGFibGUgb3ZlcnJpZGVzLCBpbiB3
aGljaCBjYXNlIHRoZSBEU0RUIGlzIG5vdCBtYXBwZWQgd2l0aA0KPiA+ID4gPiA+IHJlYWQvd3Jp
dGUgcGVybWlzc2lvbnMuDQo+ID4NCj4gPiBTaW5jZSB0aGlzIGNvZGUgcnVucyBvbiBiYXNpY2Fs
bHkgZXZlcnkgX0hJRCBhbmQgX0NJRCBpbnZvY2F0aW9uLCBJIHdvdWxkDQo+IGhhdmUgZXhwZWN0
ZWQgdGhpcyBraW5kIG9mIHJldmVydCB0byBjb21lIGluIGZvciBrZXJuZWxzIHRoYXQgZG8gbm90
IHVzZSBpbml0cmQNCj4gb3ZlcnJpZGUuLi4gU28gaXQgc291bmRzIGxpa2UgdGhlcmUgaXMgYSBk
aWZmZXJlbmNlIGJldHdlZW4gaG93IHBhZ2VzIGFyZQ0KPiBtYXBwZWQgZm9yIGluaXRyZCB0YWJs
ZSBvdmVycmlkZXMgYW5kIHRhYmxlcyBleHBvc2VkIHRocm91Z2ggdGhlIFhTRFQgZm9yDQo+IEFS
TS4uIEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIGZvciB1cyB0byBtYWtlIHRoZXNlIGZpeGVz
IGluIHRoZSBmdXR1cmUgaWYgd2UNCj4gY291bGQgYWxsIGNvbWUgdG8gYSBjb25zZW5zdXMgb24g
d2hldGhlciBpZiB3ZSBzaG91bGQgYXNzdW1lIHRoYXQgdGhlc2UNCj4gcGFnZXMgYXJlIHdyaXRh
YmxlIG9yIG5vdC4NCj4gPg0KPiA+IFNob3VsZCB3ZSBhc3N1bWUgdGhhdCBhbGwgQUNQSSB0YWJs
ZXMgYXJlIG5vbi13cml0YWJsZSBhbmQgcmVhZCBvbmx5DQo+IHJlZ2FyZGxlc3Mgb2YgaW5pdHJk
IG92ZXJyaWRlIGFuZCBhcmNoaXRlY3R1cmU/DQo+ID4NCj4gDQo+IEFDUEkgdGFibGVzIGFyZSBt
ZWFzdXJlZCBpbnRvIHRoZSBUUE0gb24gbWVhc3VyZWQgYm9vdCBzeXN0ZW1zLCBhbmQNCj4gY2hl
Y2tzdW1tZWQsIHNvIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGV2ZXIgbW9kaWZ5IHRoZW0gaW4g
cGxhY2UuDQoNCkknbSBub3Qga25vd2xlZGdlYWJsZSBvbiBUUE0gYnV0IEknbSBjdXJpb3VzIC0g
d2hhdCBoYXBwZW5zIHdoZW4gdGhlIFRQTSBkZXRlY3RzIHRoYXQgdGhlc2UgQUNQSSB0YWJsZXMg
YXJlIG1vZGlmaWVkPw0KDQo+IA0KPiBCdXQgaWYgd2UgbmVlZCBjb2RlIGxpa2UgdGhpcywgaXQg
c2hvdWxkIGJlIGNvbmRpdGlvbmFsIGF0IHRoZSB2ZXJ5DQo+IGxlYXN0LCBpLmUuLCBpdCBzaG91
bGQgb25seSByZXdyaXRlIF9ISURzIGFuZCBfQ0lEcyBpZiB0aGV5IGFyZQ0KPiBpbmNvcnJlY3Qg
dG8gYmVnaW4gd2l0aC4NCg0KSSBhZ3JlZSB0aGF0IHRoaXMgd291bGQgYmUgYSBtb3JlIGVmZmlj
aWVudCBhcHByb2FjaA0KDQpFcmlrDQo=
