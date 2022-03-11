Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F94D6463
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiCKPRf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242902AbiCKPRe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 10:17:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3261C57DC
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 07:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647011791; x=1678547791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mpXdGtsC/JJUUU1DH2nvY33eFTnGcgiUvsilssY1bL0=;
  b=gdQ4fSCEf4L8LKywyRQmg2RJBt7SeZB3IgU8/IKUtMSmIFX3Njjg1qaM
   Vx+cVJdZ+T4KG2PAYxX+lwQ96vYnydJnF6qIHum38d/BWUO+lI62RG1Sa
   KK8JomfsiI7ytkS70wn4oZrkqtcIFkmIZFu6GD2MliRgNP9Ky3R4wlz2l
   TGLL1kkH+E/BaDsM8LWkwVqsOGGWM+hJDcNd6YET+trWXa2W+yzwbKtJ5
   lm11wQKpfNn0+J6nbkjXxwngi91h9fkWzPhsYwX25wm42L0GpnOCOgTsZ
   JRbj6pPA5GwtpiQCqmdzJGc3MUhBZz1Hfo3K90blPjx4X2la/OjerCmPw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235541224"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="235541224"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 07:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="597137054"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2022 07:16:30 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 07:16:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 07:16:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 07:16:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEMaJWLUpb7bEzGfSADzJSNUrTOUNdBBRMuIKJ9ZYSfa+YHuHKnMqcQt6WoeJlBNzvXMvWKtOPFxALMX4QJ/rcCLUJLYoNN9/AWb99MfU8vH6MtoT1Ydz6kskOQhcUCF7ZhYQWuhbjJH3JJgL/EAEmh16CzQkOYx72JnZ2zAJwtqXt3wQIPFuQDTFblIju0iESepEUKaeDZ4NJKbzSZ9p+amOvc22EUGAF353VaKMhETpX3SGMsPiEg+UfL1b16pMgozEMEq9XNWEr9Z5NsgreLRhOj53ifAqkqYwXUFajoFefcShaU6smO3feYj12M7ZFTHIJL6lLZ8xGyx1oRw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpXdGtsC/JJUUU1DH2nvY33eFTnGcgiUvsilssY1bL0=;
 b=hpC/+ZA37M5ZLtKQZoO243JgtmglXyrBqDtga6gieXqKuYfvblp0Ayob2Ze5eBSO9uBIWmlQZPd+bDt+kg0MSPdDI7gg866b90xv1PxxjP2GVPHORnO9XFYhevMC/qvYLmILbNPMQbyH51EdwLN10IcvqlmG0ak7zLUbDyYsgL+aQP6zCkyGOAYEJeMYz/sjQ1oAyEsT15F3rbvhPbgr1a8YEEpp8H0lyCBgkjZZ2L0UcBS843Qgu6i1pP766RPOa8lh/E7KVYI+vu7zNeiHlsW3iWD1To0W9ItPtPdybmDHmD8FEhopj42MRgT/0uqUHQgi88IEWEov4X0NvYkcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by CY4PR1101MB2184.namprd11.prod.outlook.com (2603:10b6:910:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 15:16:27 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::e410:1630:b7b5:b884]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::e410:1630:b7b5:b884%3]) with mapi id 15.20.5061.024; Fri, 11 Mar 2022
 15:16:27 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Huacai Chen <chenhuacai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Jianmin Lv" <lvjianmin@loongson.cn>
Subject: RE: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
Thread-Topic: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
Thread-Index: AQHYMUvSE4s38xrWc0q7d9IDc+SL/Ky119EAgACzBoCAA8hggA==
Date:   Fri, 11 Mar 2022 15:16:27 +0000
Message-ID: <BYAPR11MB3256DACFEA49CBB8DBBC353C870C9@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20220306111838.810959-1-chenhuacai@loongson.cn>
 <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
 <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com>
In-Reply-To: <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a289ef38-3111-41cc-592a-08da03721cdd
x-ms-traffictypediagnostic: CY4PR1101MB2184:EE_
x-microsoft-antispam-prvs: <CY4PR1101MB2184A3CAADE2108636D65729870C9@CY4PR1101MB2184.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCerlzZwrF1cmalaD7A2GNFS3BReGodT79jxJ1cvMdEpXnESPLyMdu351XIhX3BVxG+i5vFCWRcwGOk3mV4yeaS4+CQI+ttVBRwHUeseCgSlNWF5OFGxZXD0Ge+A42duO1K6ClwTMopJBGwcSyKRs1/ftBUKBuZjXSwXEBnXPDud5onIR0dtQDFjMAlPM/zJTFSCD2hnSqMIJrBhCqj7IG8dXlTPkiS1szLWmNJ5jTJRH5U3evKxFxyZ0cNVBHg6UCbpVkYjbGkya5UbE7S0tabSCvKIHIkmI+SgqX7LuvuOq9+7/1J/XCVB1/39OapoCtOWhZXf3B3ClE0zgPGbvK0gU2F/UBNxf1HG0cChGAIx0qzMTdSx5lMSt6u1K5sDTWVX7bWHQx2y4KEYEtrUGymAKpvLf6DgJgWRU/E4dMw4fukwWgZ2026nOubP9l0sQ9gFO4PTkmhlByeVvoaxhrW2XrDeyZV7NmnlWvgTXZ1V/LU7bRxYxzQsizsW3jnv9kuCQe8jqfnEcpSgbQZvKpbIu2t2tOnnEfmG4i17Gt29QPpmXCrTBwYLTaq9Pd24Daymb8WoixqMsX4De8R+buGcRONUfEt+atL0XQyT2z5hhBYAmjJImAsBYweeXusl+1hH+schnFZ4gkGTQ29mnyLRP2U6a5ijE68iafaSxTqa6zOKTFBj+EIvaoA4ucgx+0CMsL/ZtEjTzJAa2RAVwAdRfMdn1yVZaKdYTW2gTAvy5rDE4Hbbbnxi7fd9nNHFnm86jI6RQGG5pYg4PXMVUni0+cL7kFDqVwGjTXd55phtiEcp4y2TRFJsGomeIfwjbIYOi+iXp40DOgo64pUhCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(55016003)(966005)(186003)(52536014)(53546011)(16799955002)(4326008)(8936002)(8676002)(86362001)(38100700002)(66476007)(66556008)(66946007)(26005)(64756008)(66446008)(316002)(9686003)(76116006)(83380400001)(7416002)(71200400001)(33656002)(110136005)(5660300002)(54906003)(508600001)(38070700005)(7696005)(2906002)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXFoWjh3TjNIWlYvSWc0MW00ZzVLYU45ckpob25WMmVoaXZ5aW9uYkk0YzR6?=
 =?utf-8?B?MnllZ2lFTGVhdlkvOFp6WGpVL082aHcrWEtNdFBZcnlWTm1XR2RUdWxDcWp1?=
 =?utf-8?B?SE8zTmpVN0UvdHB4OEFCT0Fkc25YSlZaMFRVdXFQRERZd3VjSElUNUR3MWx6?=
 =?utf-8?B?bzBOcHBmTjJjaVdiOTBwQVF3cTlvd2pDUGlRRGczbDJPQytmQXNPWHNrbGFO?=
 =?utf-8?B?a3pheElBNEFjZmk4RGFvNVpUTy9veWU4czJzcXZhZ3hEOTR3QmpvQm8rR3Qy?=
 =?utf-8?B?NGs1bG5obVBpdVlWeEJ4eE9YOFhLUjRWaDRzbnk0a0Rlbzd5VTgwd3NNRWJL?=
 =?utf-8?B?UyswRUpaUWZjVUJRbHJnbUNBV2xqSFZmVTExdk82cFdKcVRRaGl3SldtbVZU?=
 =?utf-8?B?Mm5TdWlPK1lPTmRvSzF1cEc3U2FQMUY5ZmFlQVRQODJ0dWFPM3FEVWVKSzBN?=
 =?utf-8?B?Z2pBTzJMUGl1aDdVaWtHRnB5T3IrUCtTeHpEQ0VvOUFWdDIzVjhMK09ydk9h?=
 =?utf-8?B?emoyd1BoaVNhYnlGa3owUGtGN1ZBK241MW1jZ2x6eHI2czc5SlJaY0ZLc25L?=
 =?utf-8?B?aVU2TXNWUXQ1NzZqRGo2aU5tRzdQbGM0VGF6ckJMaUc2MEthSExwamppelpn?=
 =?utf-8?B?VFdMaXJiQVU0M0d4UVpIOUNPUHh2T1R0Vk1ZSTJKRFhUcGtIY0l6RGpNUHBZ?=
 =?utf-8?B?bTRvQXk4Q0lod3FpZnlqa2tZWHZmRVJpODE3aGVDZG9keExIenRoZjZ5clFm?=
 =?utf-8?B?YkN0dnlIQmJ6UUs2dzNwUU1DOFd1V0I4Z1FvNTVCV0ljUzRjT3FJenlyTkYw?=
 =?utf-8?B?WXM1ejNUUk56STJ5aEJVWmdXY0laV2M5MjZGbjRIbjVoM3BuNGVVWjZkV1pk?=
 =?utf-8?B?bWxDbDgzOTJNMXNkMFBhdlQwOGxyUno0QmxvSjJ2Ti9sZGl4djB6eVJpbGs3?=
 =?utf-8?B?V1lGeXBHanFBWnpDc2c1bmdnVzhJMGllU1M1ZDBGWWt2Q1JUL1VnSGpoaEFJ?=
 =?utf-8?B?UDJmai9CU2RHKzR2WExHVWJWcnRtZlRvUGo5NzU5RS90bndIQmYrdy9LdW1H?=
 =?utf-8?B?M0sreGxuOFBabWJ1dlpvZndTaXVXZlo1bGlkWGU2LzkzTGc2c3UrWGIwcWxB?=
 =?utf-8?B?dDQ1bFBZcENzTXFHWFhPMXJxS2Ziems3aVJwL295YzNFeHRJVDB2MTZxWUVZ?=
 =?utf-8?B?VGU5VU80bGxMbVJ4SHZ4dnN3em5VUkJtdnlyUFJpOGRGQVUzTWlrdlZJSjR2?=
 =?utf-8?B?c2NGVlRMbkhoWlR5RlFJU0k3MGJwaW5SYWc5ekNqMEQzMXREek4yT0FibEJQ?=
 =?utf-8?B?c1hnZkhTRUt2V2ZFUFRkZVhtTUpSZk9VSEJ2eHZ3dXFnNndJZ2grbjM0bEsv?=
 =?utf-8?B?WDQrcWx4T05NOGxyVVc3dU5yS1VXQXlKQml1VFNRNHViQUNzejJUbnZyRzFG?=
 =?utf-8?B?K01pbG5iYjY1cGk0TVJlOHFmYkl3ZElPOTdJQ1Qyb1pJbUtoNFpVM0txWFVY?=
 =?utf-8?B?R3M5N1NhY1A4eVl5WU1yb3ZHME0vd01jT29rdFVQbVllTkRpMkhsZzNiZDAw?=
 =?utf-8?B?VWNidElEU2RJb3hvMkJ6UE1UYzFpbUxxbGFmQmRlNUhTakxITFFSQXR5ZjRz?=
 =?utf-8?B?V051bDduK3VaeCs4c01iWTlmZE9adno5QnlkNTJ6aTh5Y0c4Z1pKUmQvUVBF?=
 =?utf-8?B?ZlRvNVU1bnZTL2VmNnFMWUlzSVc1a1FaVzdyY2lVeTlrSDNUS1M3Q3YvNW1I?=
 =?utf-8?B?SzBhWWhaQ0VzQ0dPT2E5VE1zMENpcjlUQTJDRVlMaGNPQ1FhWXlRb1g2MnFV?=
 =?utf-8?B?NWI0YVZ5bjVicVU4OE1kRjdCNWZIeER5MXlYTGFDQ2JOM2JVZVpZMXNQc0Mw?=
 =?utf-8?B?VFZBWStBb3RJMUc2VnowNzFTQlhTQUUrUnFEYVZNMytrL2hoV2dUalJIcGpw?=
 =?utf-8?Q?sCD6fNVtK8AkZ+LxdmhMchkbR7q2cUgj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a289ef38-3111-41cc-592a-08da03721cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 15:16:27.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPNIkRwWSr1To+vVRbGTJeghmfTDIcO4SIh+bqT1jDCnMI2T8qWSx97rFLCNB3fEWv1xT93oKpNz0XiYpaMC7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1
YWNhaUBnbWFpbC5jb20+IA0KU2VudDogVHVlc2RheSwgTWFyY2ggMDgsIDIwMjIgOTozMCBQTQ0K
VG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCkNjOiBIdWFjYWkgQ2hl
biA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5jbj47IFJhZmFlbCBKIC4gV3lzb2NraSA8cmp3QHJqd3lz
b2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IE1vb3JlLCBSb2JlcnQgPHJv
YmVydC5tb29yZUBpbnRlbC5jb20+OyBFcmlrIEthbmVkYSA8ZXJpay5rYW5lZGFAaW50ZWwuY29t
PjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBv
cGVuIGxpc3Q6QUNQSSBDT01QT05FTlQgQVJDSElURUNUVVJFIChBQ1BJQ0EpIDxkZXZlbEBhY3Bp
Y2Eub3JnPjsgWHVlZmVuZyBMaSA8bGl4dWVmZW5nQGxvb25nc29uLmNuPjsgSmlheHVuIFlhbmcg
PGppYXh1bi55YW5nQGZseWdvYXQuY29tPjsgSmlhbm1pbiBMdiA8bHZqaWFubWluQGxvb25nc29u
LmNuPg0KU3ViamVjdDogUmU6IFtQQVRDSCBWMiAwLzJdIEFDUEk6IEFkZCBMb29uZ0FyY2gtcmVs
YXRlZCBkZWZpbml0aW9ucw0KDQpIaSwgUmFmYWVsLA0KDQpPbiBXZWQsIE1hciA5LCAyMDIyIGF0
IDI6NDkgQU0gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4N
Cj4gT24gU3VuLCBNYXIgNiwgMjAyMiBhdCAxMjoxNyBQTSBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNh
aUBsb29uZ3Nvbi5jbj4gd3JvdGU6DQo+ID4NCj4gPiBMb29uZ0FyY2ggaXMgYSBuZXcgUklTQyBJ
U0EsIHdoaWNoIGlzIGEgYml0IGxpa2UgTUlQUyBvciBSSVNDLVYuDQo+ID4gTG9vbmdBcmNoIGlu
Y2x1ZGVzIGEgcmVkdWNlZCAzMi1iaXQgdmVyc2lvbiAoTEEzMlIpLCBhIHN0YW5kYXJkIA0KPiA+
IDMyLWJpdCB2ZXJzaW9uIChMQTMyUykgYW5kIGEgNjQtYml0IHZlcnNpb24gKExBNjQpLiBMb29u
Z0FyY2ggdXNlIA0KPiA+IEFDUEkgYXMgaXRzIGJvb3QgcHJvdG9jb2wgTG9vbmdBcmNoLXNwZWNp
ZmljIGludGVycnVwdCBjb250cm9sbGVycyANCj4gPiAoc2ltaWxhciB0byBBUElDKSBhcmUgYWxy
ZWFkeSBhZGRlZCBpbiB0aGUgbmV4dCByZXZpc2lvbiBvZiBBQ1BJIA0KPiA+IFNwZWNpZmljYXRp
b24gKGN1cnJlbnQgcmV2aXNpb24gaXMgNi40KS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2hzZXQgYXJl
IHByZXBhcmluZyB0byBhZGQgTG9vbmdBcmNoIHN1cHBvcnQgaW4gbWFpbmxpbmUgDQo+ID4ga2Vy
bmVsLCB3ZSBjYW4gc2VlIGEgc25hcHNob3QgaGVyZToNCj4gPiBodHRwczovL2dpdGh1Yi5jb20v
bG9vbmdzb24vbGludXgvdHJlZS9sb29uZ2FyY2gtbmV4dA0KPiA+DQo+ID4gQ3Jvc3MtY29tcGls
ZSB0b29sIGNoYWluIHRvIGJ1aWxkIGtlcm5lbDoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbG9v
bmdzb24vYnVpbGQtdG9vbHMvcmVsZWFzZXMNCj4gPg0KPiA+IExvb25nc29uIGFuZCBMb29uZ0Fy
Y2ggZG9jdW1lbnRhdGlvbnM6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2xvb25nc29uL0xvb25n
QXJjaC1Eb2N1bWVudGF0aW9uDQo+ID4NCj4gPiBFQ1IgZm9yIExvb25nQXJjaC1zcGVjaWZpYyBp
bnRlcnJ1cHQgY29udHJvbGxlcnM6DQo+ID4gaHR0cHM6Ly9tYW50aXMudWVmaS5vcmcvbWFudGlz
L3ZpZXcucGhwP2lkPTIyMDMNCj4gPiBodHRwczovL21hbnRpcy51ZWZpLm9yZy9tYW50aXMvdmll
dy5waHA/aWQ9MjMxMw0KPiA+DQo+ID4gQUNQSSBjaGFuZ2VzIG9mIExvb25nQXJjaCBoYXZlIGJl
ZW4gYXBwcm92ZWQgaW4gdGhlIGxhc3QgeWVhciwgYnV0IA0KPiA+IHRoZSBuZXcgdmVyc2lvbiBv
ZiBBQ1BJIFNQRUMgaGFzbid0IGJlZW4gbWFkZSBwdWJsaWMgeWV0Lg0KPiA+DQo+ID4gVjI6IFJl
bW92ZSBtZXJnZWQgcGF0Y2hlcyBhbmQgdXBkYXRlIGNvbW1pdCBtZXNzYWdlcy4NCj4gPg0KPiA+
IEh1YWNhaSBDaGVuIGFuZCBKaWFubWluIEx2KDIpOg0KPiA+ICBBQ1BJQ0E6IE1BRFQ6IEFkZCBM
b29uZ0FyY2ggQVBJQ3Mgc3VwcG9ydC4NCj4gPiAgQUNQSUNBOiBFdmVudHM6IFN1cHBvcnQgZml4
ZWQgcGNpZSB3YWtlIGV2ZW50Lg0KPg0KPiBCb3RoIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgYXJl
IG1vc3RseSBBQ1BJQ0EgbWF0ZXJpYWwgd2hpY2ggbmVlZHMgdG8gDQo+IGJlIHN1Ym1pdHRlZCB0
byB0aGUgdXBzdHJlYW0gQUNQSUNBIHByb2plY3QgdmlhIA0KPiBodHRwczovL2dpdGh1Yi5jb20v
YWNwaWNhL2FjcGljYQ0KPg0KPiBJdCB3aWxsIGJlIHB1bGxlZCBieSB0aGUgTGludXgga2VybmVs
IGZyb20gdGhlcmUuDQpJIGZvdW5kIHRoYXQgeW91IGFyZSBhbHNvIGEgbWFpbnRhaW5lciBvZiB0
aGUgQUNQSUNBIHByb2plY3QsIGRvIHlvdSBtZWFuIEkgc2hvdWxkIHN1Ym1pdCBieSBnaXRodWIg
UFIsIG5vdCBieSBtYWlsbGlzdD8NCg0KWWVzLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SHVhY2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24uY24+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Smlhbm1pbiBMdiA8bHZqaWFubWluQGxvb25nc29uLmNuPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2FjcGkvYWNwaWNhL2V2ZXZlbnQuYyAgfCAgMTcgKysrKy0tICANCj4gPiBkcml2ZXJzL2FjcGkv
YWNwaWNhL2h3c2xlZXAuYyAgfCAgMTIgKysrKw0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL3V0
Z2xvYmFsLmMgfCAgIDQgKysNCj4gPiAgZHJpdmVycy9hY3BpL3RhYmxlcy5jICAgICAgICAgIHwg
IDEwICsrKysNCj4NCj4gVGhpcyB0YWJsZXMuYyBjaGFuZ2UgY2FuIGJlIHN1Ym1pdHRlZCBhcyBh
IHNlcGFyYXRlIHBhdGNoIHdoZW4gdGhlIA0KPiBBQ1BJQ0EgY2hhbmdlcyBnZXQgaW50ZWdyYXRl
ZC4NCkRvIHlvdSBtZWFuIHNwbGl0IHRoZSBmaXJzdCBwYXRjaCBpbnRvIC5oIHBhcnRzIGFuZCAu
YyBwYXJ0cywgdGhlbiBzdWJtaXQgdGhlIC5oIHBhcnRzIGFuZCB0aGUgc2Vjb25kIHBhdGNoIGJ5
IGdpdGh1YiBQUiwgdGhlbiBzdWJtaXQgdGhlIC5jIHBhcnRzIG9mIHRoZSBmaXJzdCBwYXRjaCBi
eSBtYWlsbGlzdD8NCg0KTm8sIHRoYXQgaXMgbm90IG5lY2Vzc2FyeS4NCg0KSHVhY2FpDQo+DQo+
ID4gIGluY2x1ZGUvYWNwaS9hY3RibDIuaCAgICAgICAgICB8IDEyNSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICBpbmNsdWRlL2FjcGkvYWN0eXBlcy5oICAg
ICAgICAgfCAgIDMgKy0NCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAxNjMgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkNCj4gPiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo=
