Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF9350C404
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiDVXCW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Apr 2022 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiDVXCE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Apr 2022 19:02:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EAB2FC8A1;
        Fri, 22 Apr 2022 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650666397; x=1682202397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AQbGVwbR+ew7/hFCbMeaoG2NTtSHqzpa2u7UF2EvsU8=;
  b=Ffot2TS4ueA+9dRaHPxKnouoQUeGFK3Sltt84NulcoiVCjRdbpJezs8T
   8oBPzeSV7mOJA/zDqydM261qolPtjmNdQSX0ezwIakPa/4MdIxKgJ4eCm
   pShxtJPOXZrtv4aUF7QULm4fwH92HQwkfzRIYszMw+iJWfyjPWEtUaR2I
   15Puv5EzB6hmJsOdSQDIddWv4LgFpAIVFvBiqMNz6q99a5CG7l2dreb6D
   V5KkCZO+R+oFHsh1rzUjkf5VHDCB8X6ehTTFKrZgice83ibKu5qDjwHM5
   EJdRQc3Vgn49LjplAJm2IBpEWDC5EpAy01Bj8Rhzwpv4Z5hirUTID3cHl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252133060"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="252133060"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 15:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="728717937"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 15:24:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 15:24:39 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 15:24:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 22 Apr 2022 15:24:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Apr 2022 15:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc7ki+dzS2k9k7HYkgehUOTtYxgJSRWZLuFhpRvTMx2KNddKcUvg8R4RVo5EekzklviguHnTjiKP2kSDKCRfZrvaeDsQeAE4S0X7C+D5/yPcUQr60Oy2WI+D9c16hhAKrZaIQ+TADgEK0DQwQP8FBqIRfs4G1RPA0meZk23RsD66fnMuW9IAgK9LtKRFGETs81K5O45M1BEy20xviqqkYlAkJgRL9m+EkFMpVapREXV0kpjWomnyLeWLwxIbtjD9WnHc4rm0nNk56BAimOdKG12jy4/kj8RDRbxZHswQYAfDmZVNi14AoArL6DHmPaF8UDX3BSynnbuWMTt0qfDsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQbGVwbR+ew7/hFCbMeaoG2NTtSHqzpa2u7UF2EvsU8=;
 b=kQ9sN4iqJZZvb1/VH5O9d7n836vV8QLKVhnG4qlOWSQC0JdJqq9Sbd8btpbhnwbq2HBZhm1o+AId9gSySpOK3g0wuUofFcKElPDsqr5jnL1s3S8ru0m7PmnA7fnhpc7BHqFcMb9WOx/5Be7A7zaqJT+3ZbbuHu3oG/Cvpa/gm93sZ+MSfrKHdkH8GnHacp9YWJ8rz5lAvsMpv/sSXgXi6/YEefzqxYGuxeEjIPhnuc3gkYrfd5JiMDw+1ROjmlOyuOtVGaxAPo9R/Oj2VjxVp3Jru+mkIeIWqE//9xksPrigAEULPCjzPK/0CUchySZRRssDKHaOX6oNU/X9hGl1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 22:24:36 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:24:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
Thread-Topic: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
Thread-Index: AQHYTwk1Q2ULHsfELEKXFQDAlajYQqz8kWiA
Date:   Fri, 22 Apr 2022 22:24:34 +0000
Message-ID: <4f277b84c2ee770f6a2706744b96fb1dfd6184a7.camel@intel.com>
References: <20220413073618.291335-1-vishal.l.verma@intel.com>
In-Reply-To: <20220413073618.291335-1-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a44e6be-f1dd-4567-5bd9-08da24aee149
x-ms-traffictypediagnostic: PH0PR11MB5109:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB51098F5F39056BD1BF2C2ACAC7F79@PH0PR11MB5109.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVp2ZkxPsUBXAx0qNg69fu6qQ4R3cJ5gVa6Gj5Zpk4GSokzT2KhZNBDzU3Cf7jsgkuWa7y3XUjeStHB/DKuTttPhXfQI3/ntQsmP9FdNV+w01EKMzQl2tb2LuAWKsTchsxwX2/CGT5JoYvB+vtFDURsyCfX0opgju9oYAb4S81M18wv6L+AeOA/b7aYw3QxEF15fCrSsFMolNbqzfbN2VfDW3weJybzfYbj/zFSgLjpg07JC6QVNlyBigkDCLiR2ulkswRJRt1FWSqj2ypiIaSrtM2bP1P24dRx2pWzvHkjeLVslezbst7t0+Nujrd4nvKZ9lP9QqEYTBoDpkyuBUGwRcSNFW4hNyycTEXqAf7Z0GEc1RDhJbla0XGQM/x9HtGPu/a9SzXWhSeV2boIJgOXfcPTCGuagHdOyl1qTD/WEvsQ3Y94z5qIf6CF5C9WL9w0kmIF5QxqpW9ikwdcuaBlXTNHoJD4b/q5p9lqqissxxLMTu9Vi9d0vdK2Mr84i6Xd2t1hK7DpYiplN5Gv4b1NJnDlMqijNI538odcVt00uaHc8LRgCsShyoodRMAExw3HsyzGaM9PvOpHvCwMbiHOyravnURbcamC+rcaeIqZmNi6EJb8pqYAlRHMV+i27XwWCwEV82eY/Y+qbpFaSaGsQr2KQ85kWcswaTGy7iOO/124XNU3LGgHZG14kc/whmuoKvUqFRLO7426jC4Mpq4B2lTnS97pAhHPguR2zkRrnWYvimPVrlLc5j+dYhoavhzGK/OHlgHcCo97tmWf17i5gJLRe4u5/1PJcFqa1htifv3KY510C2ACMRzch8+sC2+TwqZaYOYAmL4zIByLBVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(83380400001)(91956017)(66446008)(8676002)(66556008)(4326008)(966005)(66476007)(38070700005)(82960400001)(122000001)(6486002)(2616005)(8936002)(5660300002)(71200400001)(26005)(6512007)(508600001)(2906002)(38100700002)(36756003)(76116006)(186003)(66946007)(316002)(6916009)(54906003)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFFDN05GWHlSVHJsOXBTU21uazgrOEgxYlBXQ2tXbHRDcXlLU0JJVmR2UnpF?=
 =?utf-8?B?eUFvMS9pbEM0T3dPSG1OMmhkeDhTUlFVcElUWll6cmphQ08xaWprVnBzelAy?=
 =?utf-8?B?VzZtSVRGL3RyU2U3NXdHYWhLa0IveXJGZ2hvL2ljR2VWRU8vMUF5MEphZXNx?=
 =?utf-8?B?QlpVODAveHJoUzFIVkgxTE9VeXArNGd3ZnBuWUpzY1FqVHhQUWc5WWFrUFBB?=
 =?utf-8?B?RGJTMUVrZlkrRDJZdmpKclVsSDBLVTAxWEhUYlJLblFtcnJhaVdiNE01NnFw?=
 =?utf-8?B?cGZUOTJJWTBkeFFiN0FjSG1GV0lnOFpXdEZmTythMG1MODh6VjA0d2p4SVh5?=
 =?utf-8?B?VFVFai8yMlNoWWhHNDlxbjdtUnk3Ym05aVQvbytSVk9XYUY0aFNZRkNSdS9X?=
 =?utf-8?B?Yzc1VVhpUTRKeWt2d2xPMy9xc2J4TXJmWXl5ZlE4elRnVzFaL01yWVdMWkls?=
 =?utf-8?B?VWVTNGEraWZndVhjZXUrbEFWUlVTZHl5UXlQR01rSmpBNXdsSVE0R0FWZ2p2?=
 =?utf-8?B?V3ZwNkxDNVpkRXRXS0pTclRKRzVmL2RaazAxT3BiWFJMYnQyR3V3QW1Ib3ZF?=
 =?utf-8?B?Z1dQbGljR0dNVVZxTzhnWnk2c1gvLzBGaFVrSStCdXFBNjM5QkxBOXY0WUVB?=
 =?utf-8?B?eXBPdnh1TjBUeVBmK2NyT1BYakdlRkFzQW96WjBPUkUxSGZ4bDJMS0p5OVhT?=
 =?utf-8?B?dlo2c2JlVlArcXRUMmx3eHc0R1FPbWg1Q3MwU3Z4ZmYreHByUWU5SERjOGc1?=
 =?utf-8?B?QTcrZnd1cGdtcW9qRGVJR3ZsODlKM3hZS1FONTJpcmhPcGFiU3phdUNrK2JT?=
 =?utf-8?B?d1JjYjBselZvcVdpdXlIdUJRMUwzOHk1VURmRWlDWUJ2bWRWSG1aWEo3bFFm?=
 =?utf-8?B?NzlFK3E1WkkxdnFTR0VLQVNRSFMydUdwaHJ1MG9jZ2hWempyS3Q3SnFZdHYy?=
 =?utf-8?B?a1FXSVdnb0s4V0MvTUtkVVJpWUF5UzcrMWdEV0swKzAwcjBzUXhlOC9mL1FO?=
 =?utf-8?B?RURjbitCTEZSUnFtTGg2dE5SaTIxTWVFeCtDSDVIWHpXRGRYUWZZSk5EeStR?=
 =?utf-8?B?c0FmQTNaMXJoVlJRb3NkZmxvYXFlczdmVDdneEZScUx6VDhKZWtZZFV5YWJn?=
 =?utf-8?B?ZFhqdlZvWVFhVFhOekxIbUUrcVZqTjhSRU1BRG5sNFdVNlJma0J3TEtOeUYr?=
 =?utf-8?B?bkdIM0trajU3TUdkNndrVFBKZUF5RG93b3VERjR6TjVvcVBldFRiMVkxd1JI?=
 =?utf-8?B?UE5zK1BQZUo3ZHoxMksxd0tiM01pS2c5bkFBRkFuQWJSM00yZlJ4VFFCczRj?=
 =?utf-8?B?N3pvYUl0V1kvU1VyQVJQd25xdVVDUmVMUU9WdXBVV1VwMVgwKzh0c2Y3N21L?=
 =?utf-8?B?U0R3d2hCN3NqLzI3UW9TVFdTa05QdnVpeUpod0crV2hKOVVxQXk5aGsyTDZ1?=
 =?utf-8?B?b293N2dIUC9sMHRMWDRjZ2l2eGlDR3YvYkZyYlBkSTIzUlp4eWJQS0pLd3RW?=
 =?utf-8?B?QXhtNTh0emFhN3Vvb3Q3LzVyV1RlK0dwbUxvcXNkNlRuNHRpQ3hHM2tBSEsw?=
 =?utf-8?B?YWs3eWY2TGhGdlpKdEtTU24xbzFUK3JGVjhKSi9SYkRWcmFoYU5qVU9DcHJU?=
 =?utf-8?B?aVU4L0tZQm92MHZaVVpqNlBlek9PekxPUmQ1a3dtQmFTWWhiMEFabVBDV3dp?=
 =?utf-8?B?aEE1VGtjelZTdEg5SDJwd3pKb2VtNmVRd21jQ2RacEVKMjUzbDVFWENxU2VF?=
 =?utf-8?B?QTRWbHFDL2hVRVdHdjBKMkhWWUFJMFVPTzhHSXpUaXlYclkrMGZZeTdMaGl4?=
 =?utf-8?B?cUpZUW9PNUdpM0gzR29ST1UzaXgyQVh5bHNkNlJ6MkptUTQyK3dOU2pNSFc0?=
 =?utf-8?B?RysrbS8wcUUrSmV6eVBZR092eHhBQ3J5QWRDSEJ4RzhKYjN2dFcwUXRCMFBG?=
 =?utf-8?B?RlpESkMrTTYzaTdLWnF0UFVTa3Q3cFFFM3BmZFU2eExrTXFNaERuVkVlbGNN?=
 =?utf-8?B?SGw1YlVPVkhKU010U2NISlNxTXN5T3d5c25xZURsQVI0eVArYm1QQnF6NG0v?=
 =?utf-8?B?YUttcUovallWQzIrSWFlTEtVQTR5ZVFCL1p0RHF3RDFuSm1Rb3FkQ0hxOXA2?=
 =?utf-8?B?VUhndGJFMTNRSlh0aGhibytGS1NUSTZVcWswdTRqTU9XWmxSRDhKa3ZUcUZr?=
 =?utf-8?B?VDlLcXpvQVU4QUZlK2lBRzFFZ0x4VWZQQVhZemdEdGFUbHUvNkw3ekRHWlAr?=
 =?utf-8?B?VWJHd1BwTDB0Rzg4WXRFRytEQ2NvVElVdlNiVElMVlVFZzQ0dHVSNU1MdWhi?=
 =?utf-8?B?WUE4SWN2MU9DcXZXb2RHQktLSEN2ajZFT0F1NFowWE1CWHkzOGpFdmVabnRo?=
 =?utf-8?Q?Wkb2LM9dQgdg+IBw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B89156C4E87144AAE0C41155118045F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a44e6be-f1dd-4567-5bd9-08da24aee149
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 22:24:34.8624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWr5jNZ90wz5EJ++DbMluQIdj1dhiHl7GaPR5tdvcnB0GoHV9zYdwBIPWp57B02VfjnrQ+lUAjKCSNxK7M7fITtJgf0fOQ+oSmG820wI30w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTEzIGF0IDAxOjM2IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IENoYW5nZXMgc2luY2UgdjVbMV06DQo+IC0gQ29sbGVjdCBhbiByZXZpZXdlZC1ieSB0YWdzIGZy
b20gUmFmYWVsLCBBZGFtLCBhbmQgRGF2aWQNCj4gLSBGaXggYSBjb3VwbGUgb2YgbWlzc2VkIHMv
Q1hML2V4dGVuZGVkLyBpbiBhY3BpX2J1cy5oIChSYWZhZWwpDQoNClJhZmFlbCwgb3IgQmpvcm4s
DQoNCkRhbiBoYXMgb2ZmZXJlZCB0byB0YWtlIHRoaXMgdGhyb3VnaCBjeGwuZ2l0LiBBbnkgb2Jq
ZWN0aW9ucyB0byB0aGF0IC0NCndvdWxkIHlvdSBwcmVmZXIgaXQgdG8gZ28gdGhyb3VnaCBlaXRo
ZXIgdGhlIFBDSSBvciBBQ1BJIHRyZWVzIGluc3RlYWQ/DQoNCj4gDQo+IEFkZCBzdXBwb3J0IGZv
ciB1c2luZyB0aGUgQ1hMIGRlZmluaXRpb24gb2YgX09TQyB3aGVyZSBhcHBsaWNhYmxlLCBhbmQN
Cj4gbmVnb3RpYXRpbmcgQ1hMIHNwZWNpZmljIHN1cHBvcnQgYW5kIGNvbnRyb2wgYml0cy4NCj4g
DQo+IFBhdGNoIDEgaXMgYSBwcmVsaW1pbmFyeSBjbGVhbnVwIHRoYXQgcmVwbGFjZXMgb3Blbi1j
b2RlZCBwb2ludGVyDQo+IGFyaXRobWV0aWMgdG8gcmV0cmlldmUgdGhlIENvbnRyb2wgRFdPUkQg
d2l0aCBhbiBpbmxpbmUgaGVscGVyLg0KPiANCj4gUGF0Y2ggMiBhZGRzIHRoZSBuZXcgQ1hMIF9P
U0MgVVVJRCwgYW5kIHVzZXMgaXQgaW5zdGVhZCBvZiB0aGUgUENJIFVVSUQNCj4gd2hlbiBhIHJv
b3QgcG9ydCBpcyBDWEwgZW5hYmxlZC4gSXQgcHJvdmlkZXMgYSBmYWxsYmFjayBtZXRob2QgZm9y
DQo+IENYTC0xLjEgcGxhdGZvcm1zIHRoYXQgbWF5IG5vdCBpbXBsZW1lbnQgdGhlIENYTC0yLjAg
X09TQy4NCj4gDQo+IFBhdGNoIDMgcGVyZm9ybXMgbmVnb3RpYXRpb24gZm9yIHRoZSBDWEwgc3Bl
Y2lmaWMgX09TQyBzdXBwb3J0IGFuZA0KPiBjb250cm9sIGJpdHMuDQo+IA0KPiBJJ3ZlIHRlc3Rl
ZCB0aGVzZSBhZ2FpbnN0IGEgY3VzdG9tIHFlbXVbMl0sIHdoaWNoIGFkZHMgdGhlIENYTCBfT1ND
IChpbg0KPiBhZGRpdGlvbiB0byBvdGhlciBDWEwgc3VwcG9ydCkuIFNwZWNpZmljYWxseSwgX09T
QyBzdXBwb3J0IGlzIGFkZGVkDQo+IGhlcmVbM10uDQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LWN4bC8yMDIyMDQwNjAyMzc0Ni4yODA3MzI4LTEtdmlzaGFsLmwudmVy
bWFAaW50ZWwuY29tDQo+IFsyXTogaHR0cHM6Ly9naXRsYWIuY29tL2ppYzIzL3FlbXUvLS90cmVl
L2N4bC12OC1kcmFmdA0KPiBbM106IGh0dHBzOi8vZ2l0bGFiLmNvbS9qaWMyMy9xZW11Ly0vY29t
bWl0LzFkNjdkZjZiNmUzNzE2YzI3NDYyODczZjM0NTE5NTZmNWMwNjczYTMNCj4gDQo+IERhbiBX
aWxsaWFtcyAoMSk6DQo+IMKgIFBDSS9BQ1BJOiBQcmVmZXIgQ1hMIF9PU0MgaW5zdGVhZCBvZiBQ
Q0llIF9PU0MgZm9yIENYTCBob3N0IGJyaWRnZXMNCj4gDQo+IFZpc2hhbCBWZXJtYSAoMik6DQo+
IMKgIFBDSS9BQ1BJOiBhZGQgYSBoZWxwZXIgZm9yIHJldHJpZXZpbmcgX09TQyBDb250cm9sIERX
T1JEcw0KPiDCoCBQQ0kvQUNQSTogbmVnb3RpYXRlIENYTCBfT1NDDQo+IA0KPiDCoGluY2x1ZGUv
bGludXgvYWNwaS5owqDCoMKgIHzCoCA0MiArKysrKystDQo+IMKgaW5jbHVkZS9hY3BpL2FjcGlf
YnVzLmggfMKgIDEyICstDQo+IMKgZHJpdmVycy9hY3BpL2J1cy5jwqDCoMKgwqDCoCB8wqDCoCAy
ICstDQo+IMKgZHJpdmVycy9hY3BpL3BjaV9yb290LmMgfCAyNDAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQ0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMjYyIGluc2VydGlv
bnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiAwNWU4MTU1Mzlm
M2YxNjE1ODVjMTNhOWFiMDIzMzQxYmFkZTJjNTJmDQoNCg==
