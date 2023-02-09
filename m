Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BD68FBF2
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 01:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBIA0E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 19:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIA0E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 19:26:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFE1B557;
        Wed,  8 Feb 2023 16:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675902363; x=1707438363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7/B/PZSe+SEdSKK2wkuc7wjj5Y98PPhq9voEvU4yyhc=;
  b=ePkqr4N1jKJ5Lz1KyNch4eMPwEwwuRKNHUVhFJPUWvxS5ArjvMu34HzI
   Lk9LYr5g1PHSEwj/kFY5WPHUB2KNdQR4iO5m1xXugl37mVRQFe/YqzFbv
   zr8zAhHrG4GdOszLjdtzkfhTR/DBehp0TvWQwl7jRSEDiIoTShx2TXHHu
   P6CpZvvB+6t8uuYnoVKJbNgPW5vyzTF92dm/j0+d5iHaUKQasKJI9eMnj
   wQqNy1GPvaQqBSXaK2NS1tKqxabxO3e3dxC/zvNCagFpeMHPDMPqihEQH
   1lXq3K8JMsJwmF4kPAcjqryvAsnNMhGqTp2OpLIzpwiir5PdvPOSbfkw9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329995762"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329995762"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841390398"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841390398"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 16:26:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:26:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:26:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 16:26:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 16:25:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgIZ95Z1yumJ9qb4pGeq0aOfTEkOTFCsnNwGguf7KYADK4WP5u5DyJGbQ4tQJYZqoWDewyD3Zx+uMjFoBe7+2w/vjdRnwkOUiZYWIKbe1H4eiqKgcRiD5egReL2IjUD7hG7jusFv4O3oOwSdOWodIj83Wh2xzbaGdEZNZfp6sVWqYHJq4T6AwXA6ZxJMhFDf9iNsMgULjJqBR9v2xEIVL+8iqntdJ9r7IT1HSE/h7vmXMIe81anp+bnX+D7S/tn1Mvr3uhcIvehGCxEtQLE9AuBeaXf1QlHqNX0M4vWm4nI9d2sdilLV+OGViuAvM8XtB6wWGKUqutI4IRt+/9CZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/B/PZSe+SEdSKK2wkuc7wjj5Y98PPhq9voEvU4yyhc=;
 b=XRKAUtELKwg7rh1kK7yBEAe9qEUEGEjFUotP72YrcGISraacGDSUyPZM3bcsYUhS6NPaiiqZ3QA9cYNWYoyXoY3t9IYkD7HpndzAk/9jrkYdrDPW4pyLxAcNS23xJk7cphz7kObyBAgUv+CyMKHjtpsaa05blMm1sDb3x/Lhtjl7z1tt4vSpwJ2bJhSg9pvLUjv0+9tUBVYFQ+xb2T4/vn7IPMyw/Rung/Wn+dq4KmA24POR7Lo4eauwJIl0rlW2vbojg7r8tv35BDinw0Qf6dydLcbikV8F0zA8UcG73CJ5XxgnwPdI2QpS7OcBsLevGv77VowJrMv0pCy08KjMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Thu, 9 Feb
 2023 00:25:58 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 00:25:58 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Thread-Topic: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Thread-Index: AQHZOcbGY8zhAuXAiE+u0IrJY8YsEa7FxpkA
Date:   Thu, 9 Feb 2023 00:25:57 +0000
Message-ID: <cb42da9994c2a9fb114757a4b94b0e35231f7ea6.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB7879:EE_
x-ms-office365-filtering-correlation-id: c2741b37-8fa8-4ab1-71dc-08db0a3436fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhG6dgV5WnCcVLAVLN1cKugnODaqp9sEq29AypCpuF34z9kmIj96lXLmTBauxn2jT2ZkM5YFaMtunnOZAMk1zfzfQpJaEJRKbbYXbndF/F4xLRouV4Vb9qsxWLTwJsCzxj9xO95I1VWxelgUKTg3EJYP+C0aULSZjqWM91P9SMQBkfttUabmXb74cO+bUJvZEMHTysHBrWel93GYcSwf4wVK1c+waUuDRN9008T4sfhIfvd0sT78twugO3Onn/N5UHpUXVaghQCp4Wei9wAxVMz6IJB7BgZeA2EDDdq3hHlyxXh5FNccT14xLiz1gMK3P9b+B2u2o1SbIApaxqh7PXMx0F7LIhCisLsmdanJ1nPbRxsg6nHn0yu5JOiAbnDwOse+NXXPwkIwK3R3i6C3Cjl0EVXL/pTeR+UOui9Zq14UgD5++OgWFcfxL9FhCgrkY5Vd88LGKTvGf6hbMWsud/YSs++XjT+fXeNJlcpxYy0VTFIE/OA4KR0VCvikV2yRNvY74Obp9JibdcHY38AlvzOXhFo4nf+N0u2V0oFxUsnt8Iw7gH4ND3Jt0GLtFpkZ5uFDh16/BXHgWRhWqP6yfGwd3Qjp11UOmGxAKiy5qYTsqG1/kNoftE77UdduUhfmGCHblaRsgkVlKVs9gl1shTIlyLb5fauYfAvUzWUswVxbTMerqPr+gmZBessqiJI5kio2YexA6h3qhBj15vY2bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199018)(66946007)(66476007)(64756008)(66446008)(4326008)(76116006)(66556008)(8676002)(41300700001)(6506007)(91956017)(8936002)(26005)(186003)(71200400001)(478600001)(6486002)(6512007)(316002)(86362001)(54906003)(110136005)(2906002)(4744005)(5660300002)(2616005)(36756003)(38070700005)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVJOZ1R2NW01MnFibFY5dkJXeWsvZXJvRXA3cWVGZTRGYjNubWplcjJJZGk2?=
 =?utf-8?B?YTlMVmM3RWNONnNFR0hmbkdQYzJXZEtvcjE0TW5Mc2JwK05pazBUSEJGWEpt?=
 =?utf-8?B?OHFnQ2psR1J5Nk9ZRnVadFZxNTZiK2lSbll6UGxrZjhlQ1BDd0ZmVC9BY0w2?=
 =?utf-8?B?UndCV2NFM21PNG5iK3Q4T3lSYW5PRVMxYUNmWGJFQmNPZW9WVC9UUGxHQldk?=
 =?utf-8?B?eU0yVFNycEU0bGN1Uk1ZY241YldxMzRCNmFxc25zaUw0dU9LcFMzR0laTk9I?=
 =?utf-8?B?OTIxZ3Fza3lSMHVmcVd3dmtwMVNpNElqOVMrbUdSbytwMjRUcXlUTnJVbllZ?=
 =?utf-8?B?ajE3M0NuU2M0SnZrQ1pmeHBVcDhkMmlQK1FzaFJidlZHb0hhRjdjcXhyZHl1?=
 =?utf-8?B?cXZrcldQWlFQSFJZZ1pMeEFKS2pIbkVtbE1NMklqL2JITEg2eTY4NzVtYklJ?=
 =?utf-8?B?Y1FWMC9mVzFtMGpGTmlVck1FZXF0eE1OckJSQ0ZSOWt0cTdzZXBaV2EySWNy?=
 =?utf-8?B?QmxJcUpzd0djU1I3WXk2bDBNZGl0RkFiSW8yMkpCSGxwS1h1TWZGYktjR01q?=
 =?utf-8?B?d3lMM3pxb2lvcWpvQytMV0RFejNpVTk1UUlYcGN5Qy9ObEZLM1NOV3BvSlhW?=
 =?utf-8?B?QUpkMXhvODF5WXcxb3JqY3o5TytSb216b0orZCtQLzdGbmE1NjdwQzFFWXVD?=
 =?utf-8?B?d1dpVllHZmFQUjJwRlJGWWw1MkwwUjRHQnUyRzgxNWRBS3JCcGNnRWZEQ2lZ?=
 =?utf-8?B?MmQzKzFtWE83WXh1R0FzY3VoZllWOWV2RitrK1hoZVZ2UDc4dWhhNUNLbUhJ?=
 =?utf-8?B?cmJEMEhLdWh2bFlWbmRoTGo2R3laZ3JZeTNxOGFVeVhJZGUxZzE2YUxjczdr?=
 =?utf-8?B?OER1a0FiQmNST3RvSVFlZmxVVkdZcWFIanlnTVhzV3RmamhPalpmelBEcHhu?=
 =?utf-8?B?TVNxZzZycldueGwwZzRzMDFuelNmN1BJQW5CbnVYdmJhVGh4WDY2YlNmOGhR?=
 =?utf-8?B?Y1pTZnFOUVFFRzNZNTFBeEJwcWUxbmVsTHBSQUVDeFZHQkNQZnZIVmZVQW0v?=
 =?utf-8?B?UmtMRytrM0p5LzY5NURGOVV6THJXbTl3MDhXSjNEQmFhRnI5ajM1R3A3R2N2?=
 =?utf-8?B?UFRtZGU5NkwzQm5oelNQVUhnOUYvYVFSaWg0VFF3WGNHSFBKQkEzdm1XUmVU?=
 =?utf-8?B?Nld3QWtXOUxwNm9jVE5jQlhFZXpFcW5uU1JSaWZPNnhtNlplL3NNemtLdHM4?=
 =?utf-8?B?VXNndDV3eHNDVUpDOHc5WURUSmxGa1Rpc2wwNmgwTnFUeVB2emNFNjZaSEVY?=
 =?utf-8?B?SGxzb0s0ZG9Bek1iL0QyZy8zTG1OODYzRWlZZG01dHIraVVVZldxMEZLbTZ5?=
 =?utf-8?B?L1dObHV0RDhEclU1WVlScjc5aHQvRVlKMjV3UWIxV1JTZUFHTlJta0RHc3FU?=
 =?utf-8?B?SG1ScStmaHlJNHBIK2hkL1B0bldBLzMzK3ZRVGVRZjhGWkpDZ3R6ZEgyNERo?=
 =?utf-8?B?UjhaaENRNVAvWU5TZGhPWnpuVEdaazR1QXRvY2FMUm0yU1RMcVhpSHNFSE9y?=
 =?utf-8?B?ZnM2K0oyWmtaTVc5UUdFT3FVN2NEbU5rWnF0SklMdEFwU0VOZExpYm5QRGR1?=
 =?utf-8?B?amdicDNORm5HMUNpTXJOckxqZWNoKy96VmxFdVhCem53RlJxUmhTVTJ0bjdT?=
 =?utf-8?B?WWE3UEQ4djZJTXY2K2NSa09rVEdmYmwzUUZkK0ZKbHRRTGVhS0psU0h3VGZy?=
 =?utf-8?B?YzdmaWJuenkwekJkZlNNU0pWRmhGamV3eExVUVltWUtGSzFFbUUyZ1l2enJz?=
 =?utf-8?B?SVh5Y2YxWFdZbjY1L3daV3Z3ZXY3SG9Mdm9GN1RwUnRqRFE1T1dwa1d0VkF1?=
 =?utf-8?B?cGh6aWVqSGlKb0RJK1FSVThpSEdZdXMrY1JFNGdDM0dUR2VuWXZzZG11Q3Y2?=
 =?utf-8?B?TjZkOEhKUzJmS2JRelloMGtaazMyaktEQklZTmx4Z1dQdEw5SGJuQ3IwS2l4?=
 =?utf-8?B?SkdFMVlOblV4d0t3cVE2MlpXVXZYTmNaWFJnOGNmbWd0QzFBNW9CdmVaNlI0?=
 =?utf-8?B?TzJlQmJ4WHBWN0NDb040b2ZOTTdtSXFTazQ1NjA0eXhFU3NBVXBvVk1vMDU3?=
 =?utf-8?B?dzFIbzArYm9FV3VPU0hHS1pGQ0VQRUxRZE5xKzdOcTlHTFVJNHRwOW5sTEoz?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C4CF5673B1D94F855FD37F598BD0CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2741b37-8fa8-4ab1-71dc-08db0a3436fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:25:57.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avVXOoc2kqbHHnaeMG1Pj6Q82kcOiCNredDOtIZ1GvaOM0DffGZJbS9xGJ3Yc9YXocVoUbzrAGRblcTjVPNxCY4HcLERxaytg54TVW9hKM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAyIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
SW4gcHJlcGFyYXRpb24gZm9yIGEgbmV3IHJlZ2lvbiBtb2RlLCBkbyBub3QsIGZvciBleGFtcGxl
LCBhbGxvdwo+ICdyYW0nIGRlY29kZXJzIHRvIGJlIGFzc2lnbmVkIHRvICdwbWVtJyByZWdpb25z
IGFuZCB2aWNlIHZlcnNhLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8
wqDCoMKgIDYgKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpMb29r
cyBnb29kLAoKUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZl
cnMvY3hsL2NvcmUvcmVnaW9uLmMKPiBpbmRleCBjOWU3ZjA1Y2FhMGYuLjUzZDZkYmU0ZGU2ZCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4gKysrIGIvZHJpdmVycy9j
eGwvY29yZS9yZWdpb24uYwo+IEBAIC0xMjE3LDYgKzEyMTcsMTIgQEAgc3RhdGljIGludCBjeGxf
cmVnaW9uX2F0dGFjaChzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwKPiDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IGN4bF9kcG9ydCAqZHBvcnQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBpLCByYyA9IC1F
TlhJTzsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmIChjeGxlZC0+bW9kZSAhPSBjeGxyLT5tb2Rl
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJmN4bHItPmRldiwg
IiVzIHJlZ2lvbiBtb2RlOiAlZCBtaXNtYXRjaDogJWRcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfbmFtZSgmY3hsZWQtPmN4bGQuZGV2KSwg
Y3hsci0+bW9kZSwgY3hsZWQtPm1vZGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqBpZiAoY3hsZWQtPm1vZGUgPT0gQ1hMX0RFQ09ERVJfREVBRCkgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZygmY3hsci0+ZGV2LCAiJXMgZGVhZFxuIiwgZGV2X25h
bWUoJmN4bGVkLT5jeGxkLmRldikpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9ERVY7Cj4gCgo=
