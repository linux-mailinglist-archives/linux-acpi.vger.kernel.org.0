Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825C9326490
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBZPNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 10:13:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:41567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBZPNn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Feb 2021 10:13:43 -0500
IronPort-SDR: ju9oCf9RDQRUHEULLBeR0u4ZG7R2iKGNSmv8i7yXlJW1UquJJz5mpyxuvD+d/0Ww2vQQh7WJde
 RTtZlOPtGunQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="247318474"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="247318474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 07:13:00 -0800
IronPort-SDR: KB88wrEPck2WUE5u0vbltJ84DFJsWQO8GwwtXX38608asNXwzOirunLdjbSAhUbS/ocI0Lda5/
 7ZM+09pm/k6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="443099516"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 26 Feb 2021 07:13:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 07:13:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 07:12:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 26 Feb 2021 07:12:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 26 Feb 2021 07:12:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrB95fF9F7ucKOn+ZZdwJncZyOmroUygQWODAUBSNYzONDjr2u7WSceJ4kFmpWthum3kj26Jg1luvVubEj47VyZdbQpOfoO0ditUIhySJs+PhczqmRfpj2uvHo0wGaawHR6GtlG3NP7HSVpUGuXLNiB17c2dQ5R5n/u2gWqcm+O4ZIHPo5VM+MS3a6mXliOXK70FHxmtwTBJdc2Mz9/hJ08ScnpeWQYAGi4QVJraXcCP5u/HWRUlfEISy/wTecRZX0V84hl22o4vPzp3VmiuSC+20TN7un9xihiJyMkfyagl1a4wQI0tHMOCLLE/tWfdPpUOb4bWOJ7VdaF5u8k14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zC6IvwfWwPDzYphErKNpfF0zqS37GOXmSRtnbkAMBY=;
 b=dZZfYohrW1qYh5ldco+DhvJwTaNcY6d2LtCPTn12xnytPWzkuuWecyMgke2MHLpPZWnrlNYu/RKxlpuQ2OFFR4NszyJhMHi+5H0RpW+NsN5ubUgDl3ZDCIIq2dMTm0hibYOL5v7HMtpnh/tBZTjWnK19QCSGaOKd2n3yORWDVCZ0aBgcbkvjOffDA1tZnQ6UAouVoaKhCSUHkkHXJgdwRZe5z4UfZazcGLZDUv8eJ1AqfF2NKfx/vbBvL1EkdRuVGDs3dolyhrEQ9PoMcy7A9OcYiKKypBq/Us7e45oJWOEnQuDMQoNCeTznQ4AWqvp52U6HHuuicgWsUuTK0ZTiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zC6IvwfWwPDzYphErKNpfF0zqS37GOXmSRtnbkAMBY=;
 b=Br88wDVCM04uSMoPAdDO4+CsNG3FtpeQivXFclZSTj2bahHUuBWP12MhPcmPsHnmi7/Ku07tjYoCz0hILuDU2hluepMUDbTaT/NJ6Fo2uGzPxSgP90JQetJb/vD+Nf9eQ7XwxiLApIIRkrQFDnCmY57gnNuCoJq7f+cxgYJCe6M=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Fri, 26 Feb
 2021 15:12:57 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 15:12:57 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Zenghui Yu <yuzenghui@huawei.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: RE: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
Thread-Topic: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
Thread-Index: AQHXC2kwib+gFmscGEib3bZcV79rGKppV0XAgABX4QCAAN1xsA==
Date:   Fri, 26 Feb 2021 15:12:57 +0000
Message-ID: <BYAPR11MB32566AB506BAD2C77356FE07879D9@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210225112620.1827-1-yuzenghui@huawei.com>
 <BYAPR11MB3256E28FD567C5FEB0EDCA94879E9@BYAPR11MB3256.namprd11.prod.outlook.com>
 <3b009c89-c3cc-8fd2-4ef6-5b8d27a88119@huawei.com>
In-Reply-To: <3b009c89-c3cc-8fd2-4ef6-5b8d27a88119@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c200068-b21f-46f3-a1c3-08d8da68ffd7
x-ms-traffictypediagnostic: SJ0PR11MB4816:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4816F7F4CEAD7A8FC3329E68879D9@SJ0PR11MB4816.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7Rf7u7bvjprLLMfB7QRqj30QiejVsaApXoKVTjQLj3MJej2L7vcfMX4+C7yU9XvHTq5KQl6Pj3+S7KXknzy5JR4Iwv5wbURfHYDs/cJPRzyjQfcLgb5J9FWeP1swVkVXk46FdBJS2w3cuGoLPa/sMiiJrQGhtglYistc1C07q4lGVulWohTmBt2HDQgqRXRuH9rNgXasqnjGGDlvtUFSRmmFenr5690DyT/M7vWZh2Nf3rrfO3dPfbDYx97vLIpkfyhS+Ej6YgTzhY0CEjFo3W/Aa9/pzr9mFSq3JqSkqRaBnuPYnlg6VPASg5uRTnhJoFzn8G8+L4bB0cS/Pu+QqQZD5ruBWL5Q5KgHS6bI/gPN4IfhHCgC8DKbVR2kLcQsUGsqP3vh3NDSoqJUjKLXopuNrtd5gprO7ix4QA/8DoisNawSnmwPVwvGXZxdwfb7wT1OgGVXP4fySl7sX8WTbFHegCTs3y4c2Cy1Ql1H/Sn9qoTVXNJZWK/9H8UVPRo8/NrUOQdQqQsE11ipVBPmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(478600001)(5660300002)(316002)(26005)(186003)(9686003)(86362001)(66556008)(71200400001)(33656002)(66446008)(52536014)(55016002)(4326008)(53546011)(83380400001)(2906002)(8676002)(7696005)(110136005)(6506007)(54906003)(76116006)(64756008)(66946007)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WXZKSGpMcGVOK2VvYld4Q0toRHBHSGpzMmdlNUNZYlVHVnltb0xiRFBkazUx?=
 =?utf-8?B?cTVwUDlGQXZsVE1hSXVoSjRISnFHdU52UVR5MzQ5N1JYdVBqRmFjS1J2NXYr?=
 =?utf-8?B?R1lsNzk1WS9mOTlsbGhuTXdZR1Q1bEZqRFZlaHBRdjNWOFVHWEpxSEdpMUlB?=
 =?utf-8?B?bmNmWFBOV0RaSVoxamsvdSs1T1RteGluTGRNTURJbm9ybXAva01PLzdhS1B1?=
 =?utf-8?B?YkJBYUx3SUhObkc0TlFvcEJtb1JiZ3J4ZHkrb2NOM2xjQ2dyMGdpOHpSVXor?=
 =?utf-8?B?Vkc0OUlTZTB1S3dpZ2k0SGxQQU5pc0tqakVXWmtsVXJNd2tOeG9xMnlNMVhR?=
 =?utf-8?B?RVpkM0FrM0pUTFlmRFhWUjBKb0tBNmxXQmRTUktpa3pubXIyMGZ3ckEyWnZQ?=
 =?utf-8?B?eFFROWZ1ZnlpZmV0Rzd6aHRQUGp6TlNiUHBHR1lNU0Z5aGNkM1BpR0FIa3RW?=
 =?utf-8?B?QnF1cXJuNmdHMGxJT1pSTkdDQ0JHOS9mRndTSzZGeVV4a3RrU0Jtc1pDc2oy?=
 =?utf-8?B?UEMrVUlBVjZqTENBOUYxNUJKaitWYW9KRWpVQ1BiRnZVTTd6c2h0V3RUTFlp?=
 =?utf-8?B?VFNzQStRcVJpa3NMRDdHOG90aTkwclQ1OHJuaWJUTEpCSkZWbkhZWHptWEpu?=
 =?utf-8?B?SlZNbXpwdEl6VHE0a3FPTnJjMnN0UEI5ODdXNGJ1bnRyWThGUU9JYy9weE9v?=
 =?utf-8?B?UmJjMmxHQ0d1MEt0Wi9Tbk1VNWI1V1ZmdloxSUg1Q29qTzNkMEt3VzI4QktK?=
 =?utf-8?B?R1FSVkhZeXpHaTNEU3FJT3ZVdWdWL09uMTFlVjduZVVmeDhTWURQdE9kMVIw?=
 =?utf-8?B?TjZDdGkrYlhxcjQzQ2dweFRoN3NYWFZUWW9FUGJJK0cyU3B2SWwyUVoySzdo?=
 =?utf-8?B?b0ZwVmJqQkRXck5uOE1RU0RlV2pMdUtsNU1oTEpWbXYvR28zRTlKMGFwL1pS?=
 =?utf-8?B?ZGtLbENra240SUQreG1DemdRR0ZVWHlnRFZ5YWN5WDVyekdTNW5ZejBva1Uv?=
 =?utf-8?B?NWVDZFZOWkFhc0Q3NFZQMGZPdU1ucWVDWEVlZ0piY24wclRzTXVlRGdGMTV0?=
 =?utf-8?B?bk9RY2lwdnNoZlFpZkpMUHc0YlFrVFJFVmVtRmd5eXVSUCswMU5VTC94MEgz?=
 =?utf-8?B?ditCQlEzUVJKNHpRbWRTcUVWN3N0SVhFMzFUL2g2MlNVWDJtL1pMMlZuMzZp?=
 =?utf-8?B?OXE1bmIzcUV6YWttUmdPRXVlUUN5VGwzejVSeVBvcnRMbXVZS2hLVWNWQ3Ux?=
 =?utf-8?B?M0xZM2pNbCswaGNaMklqRFpCZjRSVktiMGliZWpXUnhza3gwQkVsR2x6M3RT?=
 =?utf-8?B?YVY1ZUEvYklhSFlMTE9MUXBnUTVjTUxVNGlXNVV4QjhwRXg4UFVpYThFSENm?=
 =?utf-8?B?Z0Ryd1B0UUovRVRmT21jQW5WZmpmdThDN05tMFVLVEFLck9ucDBFMTlNSkhS?=
 =?utf-8?B?RU92Vm9UZHU4NTVxaTVHY0RzYjhZbWphdjdUWUM1VjI4L2NYMVdzTDkzdmhX?=
 =?utf-8?B?Z2NpMEsxNG5lK2pxZ3prSHJhRHZVWHJuVnhtTFAzakxNUURrbWs2YXkwOVNP?=
 =?utf-8?B?UHB1WWE4RmxjVjYyeW1KR3lOYmdHQmhPYlJQS1R0UFZFTmFvdnI5WVMyVm9p?=
 =?utf-8?B?eFdiRHNnYmhsYUpBR2k4MUlWYzRLa1MrVXB6enNQMlc4YlcydXBVNDJaM0hn?=
 =?utf-8?B?eW9VYWVjVXljK0R6OTQwME8wV296ZUxMcE5qc3kzOEJsUzJsaE9PVTFNU1Jy?=
 =?utf-8?Q?lOo3pdFdoqLeW78jzvPWkOdG8zgCT4siL2SZPwU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c200068-b21f-46f3-a1c3-08d8da68ffd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 15:12:57.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qOrQI/P74F2q33i4Xw7HnksPUmiL3tp9bs9g7noRE2zlgfLOyYp6kWJjOEZawxYwxbp1l7MCQG9asttCMFXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

WWVzLCB5b3UgYXJlIGNvcnJlY3QuIEFDUElfRE1UX0ZMQUdTMSBXaWxsIHBpY2sgdXAgdHdvIGJp
dHMgYXQgYml0IFsyOjFdDQpTb3JyeSBmb3IgdGhlIG5vaXNlLA0KQm9iDQoNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFplbmdodWkgWXUgPHl1emVuZ2h1aUBodWF3ZWkuY29t
PiANClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyNSwgMjAyMSA1OjU5IFBNDQpUbzogTW9vcmUs
IFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IGRldmVsQGFjcGljYS5vcmc7IGxpbnV4
LWFjcGlAdmdlci5rZXJuZWwub3JnDQpDYzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRl
bC5jb20+OyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPjsgZ3VvaGFuanVuQGh1YXdlaS5jb207IHdhbmdoYWliaW4ud2Fu
Z0BodWF3ZWkuY29tOyBLdW5rdW4gSmlhbmcgPGppYW5na3Vua3VuQGh1YXdlaS5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBbQUNQSUNBXSBJT1JUOiBGaXggSFRUVSBPdmVycmlkZSBtYXNrIGZv
ciB0aGUgU01NVXYzIHN1YnRhYmxlDQoNCk9uIDIwMjEvMi8yNiA0OjQ1LCBNb29yZSwgUm9iZXJ0
IHdyb3RlOg0KPiBJZiB0aGUgZmllbGQgaXMgdHdvIGJpdHMsIEkgdGhpbmsgdGhlIEFDUElfRE1U
Xyogc3ltYm9sIHNob3VsZCBiZSBBQ1BJX0RNVF9GTEFHUzIsIG5vdCBBQ1BJX0RNVF9GTEFHUzEN
Cg0KVGhlIFNNTVV2MyBmbGFncyBpcyBkZWNvZGVkIGFzOg0KDQotIGJpdFswXQkiQ09IQUNDIE92
ZXJyaWRlIg0KLSBiaXRbMjoxXQkiSFRUVSBPdmVycmlkZSINCi0gYml0WzNdCSJQcm94aW1pdHkg
RG9tYWluIFZhbGlkIg0KLSBiaXRbMzE6NF0JIlJlc2VydmVkIg0KDQp3aGlsc3QgQUNQSV9ETVRf
RkxBR1MyIHdpbGwgZXh0cmFjdCBiaXRbMzoyXSBmb3IgdXMsIHJpZ2h0Pw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFplbmdodWkgWXUgPHl1emVuZ2h1aUBodWF3ZWku
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjUsIDIwMjEgMzoyNiBBTQ0KPiBUbzog
ZGV2ZWxAYWNwaWNhLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1vb3Jl
LCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBLYW5lZGEsIEVyaWsgPGVyaWsua2Fu
ZWRhQGludGVsLmNvbT47IHJvYmluLm11cnBoeUBhcm0uY29tOyBXeXNvY2tpLCBSYWZhZWwgSiA8
cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBndW9oYW5qdW5AaHVhd2VpLmNvbTsgd2FuZ2hh
aWJpbi53YW5nQGh1YXdlaS5jb207IFplbmdodWkgWXUgPHl1emVuZ2h1aUBodWF3ZWkuY29tPjsg
S3Vua3VuIEppYW5nIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hd
IFtBQ1BJQ0FdIElPUlQ6IEZpeCBIVFRVIE92ZXJyaWRlIG1hc2sgZm9yIHRoZSBTTU1VdjMgc3Vi
dGFibGUNCj4gDQo+IEFzIHBlciB0aGUgSU9SVCBzcGVjLCB0aGlzIGZpZWxkIG92ZXJyaWRlcyB0
aGUgdmFsdWUgaW4gU01NVV9JUkQwLkhUVFUgd2hpY2ggc2hvdWxkIGFsd2F5cyBoYXZlIGJlZW4g
MiBiaXRzLg0KPiANCj4gRml4ZXM6IDlmN2MzZTE0OGY0NCAoIklPUlQ6IEFkZCBpbiBzdXBwb3J0
IGZvciB0aGUgU01NVXYzIHN1YnRhYmxlIikNCj4gUmVwb3J0ZWQtYnk6IEt1bmt1biBKaWFuZyA8
amlhbmdrdW5rdW5AaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmVuZ2h1aSBZdSA8eXV6
ZW5naHVpQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgIHNvdXJjZS9jb21tb24vZG10YmluZm8yLmMg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291cmNlL2NvbW1vbi9kbXRiaW5mbzIuYyBiL3NvdXJjZS9j
b21tb24vZG10YmluZm8yLmMgaW5kZXggMTdhODBiYTIxLi4zMjFmMTA2ZmEgMTAwNjQ0DQo+IC0t
LSBhL3NvdXJjZS9jb21tb24vZG10YmluZm8yLmMNCj4gKysrIGIvc291cmNlL2NvbW1vbi9kbXRi
aW5mbzIuYw0KPiBAQCAtMzQzLDcgKzM0Myw3IEBAIEFDUElfRE1UQUJMRV9JTkZPICAgICAgICAg
ICBBY3BpRG1UYWJsZUluZm9Jb3J0NFtdID0NCj4gICAgICAge0FDUElfRE1UX1VJTlQ2NCwgICBB
Q1BJX0lPUlQ0X09GRlNFVCAoQmFzZUFkZHJlc3MpLCAgICAgICAgICAgICJCYXNlIEFkZHJlc3Mi
LCAwfSwNCj4gICAgICAge0FDUElfRE1UX1VJTlQzMiwgICBBQ1BJX0lPUlQ0X09GRlNFVCAoRmxh
Z3MpLCAgICAgICAgICAgICAgICAgICJGbGFncyAoZGVjb2RlZCBiZWxvdykiLCAwfSwNCj4gICAg
ICAge0FDUElfRE1UX0ZMQUcwLCAgICBBQ1BJX0lPUlQ0X0ZMQUdfT0ZGU0VUIChGbGFncywgMCks
ICAgICAgICAgICJDT0hBQ0MgT3ZlcnJpZGUiLCAwfSwNCj4gLSAgICB7QUNQSV9ETVRfRkxBRzEs
ICAgIEFDUElfSU9SVDRfRkxBR19PRkZTRVQgKEZsYWdzLCAwKSwgICAgICAgICAgIkhUVFUgT3Zl
cnJpZGUiLCAwfSwNCj4gKyAgICB7QUNQSV9ETVRfRkxBR1MxLCAgIEFDUElfSU9SVDRfRkxBR19P
RkZTRVQgKEZsYWdzLCAwKSwgICAgICAgICAgIkhUVFUgT3ZlcnJpZGUiLCAwfSwNCj4gICAgICAg
e0FDUElfRE1UX0ZMQUczLCAgICBBQ1BJX0lPUlQ0X0ZMQUdfT0ZGU0VUIChGbGFncywgMCksICAg
ICAgICAgICJQcm94aW1pdHkgRG9tYWluIFZhbGlkIiwgMH0sDQo+ICAgICAgIHtBQ1BJX0RNVF9V
SU5UMzIsICAgQUNQSV9JT1JUNF9PRkZTRVQgKFJlc2VydmVkKSwgICAgICAgICAgICAgICAiUmVz
ZXJ2ZWQiLCAwfSwNCj4gICAgICAge0FDUElfRE1UX1VJTlQ2NCwgICBBQ1BJX0lPUlQ0X09GRlNF
VCAoVmF0b3NBZGRyZXNzKSwgICAgICAgICAgICJWQVRPUyBBZGRyZXNzIiwgMH0sDQo+IC0tDQo+
IDIuMTkuMQ0KPiANCj4gLg0KPiANCg==
