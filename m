Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425A46B87FE
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 03:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCNCDr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Mar 2023 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCNCDm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Mar 2023 22:03:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53B5DED3;
        Mon, 13 Mar 2023 19:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759412; x=1710295412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ad8lznUIc6mAsm0dCW6P8H9nWPeIXQ0/XZpwzo3FveU=;
  b=e7uZmcRjN2nXomKzFOwvX6kV6fxD7Yen+iJ+xctLqProbL+/UuXxxuPR
   HlSLMsb6fM9LWBC/5StbFwkko95qdH/ZY0kyn7cUOP4SSfFFrNhnezn1c
   B6ONdg5EQs0Jqo73EYbt7vpABxeFMTPSoGYcTiyPahjR/fC1f6z27miIR
   bLojy+OcaG4HG4Gt7tdrWY1vwAOoi+vgoIOaxrySs8GLEmDen8l7Dro56
   VZhlXlD7UrpftIP44S08trlCWMLPv+xvygP3L8vyIRDXp4ZYq6d+53jFZ
   K2T/zIFlhsqwcWQjb2QR6Nlv3Ei0jBEcNmyiC3lIfqYoZatL829v6+l8t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402179884"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="402179884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678915707"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="678915707"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 19:03:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:03:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTBC6zrWklicvxwL3t/1jjiO6gVHKGAzcxwK9NgtspK9tBzUMrKJVR0VupRxqKUutYcFDqwMXlwJ8/62woSHsvosZNV90MC9zEC6HmiF+AQI+Xl6FcotJ8muq8OHHtuSyPIuJmn6va/UET/sshBXdZDQyhOsjHzDfB6L6vg1vZGJRB8+pxqHLns5V8yOxEHsFAC/dsrSVxmgIkzTr7qH3Ajj8MUV+q4y4kDZbEXLaiPRCtJ9tXVSTLM69DWdpSYBoR+W1RHXPnLIkPnAU6nimIps7EUD+rwSo85iyBKk9SLL0PSCk588ObBsJ4pSRLWrxngccFwe/1hHmDs29zo37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad8lznUIc6mAsm0dCW6P8H9nWPeIXQ0/XZpwzo3FveU=;
 b=EIUmAY+rst+bk4hUhuBt5WKn61d5RgzP6drEMJeFRO6Njlmw6IXaGGTK0DgCdWyOuY0txPI+6tC2QmCi0AIrui2dxRvlqjYesPac9SPHV931yq3OCKm9YGj3XC+6uHfL/q4l0ZBPYFOrIEALMeFnsOXUTZ5tFLeQYy22yMsbW+1FLWY7o9tgMwS9xwiNEuyFauiMNer/iRnT/pz6Je0aDMbmIOZ44+9YMTAwTivwLNzSBeKtm0x36v4ecp3loDyVhyfwDLqsO7damTLsJCEJYaAxjKqZlnYEhe9jw5DowJfWVNp8oNV8l604RPLDon14Om+JFws1yRegRZi2Z8bjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 14 Mar
 2023 02:03:23 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:03:23 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] thermal: core: Introduce
 thermal_cooling_device_update()
Thread-Topic: [PATCH v2 3/4] thermal: core: Introduce
 thermal_cooling_device_update()
Thread-Index: AQHZVbj4CSPoxsKvPkG8uH5+KaivhK75htwA
Date:   Tue, 14 Mar 2023 02:03:23 +0000
Message-ID: <263ba0ac2053dfb0b402ebaa768bad8a8267f460.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher> <2156873.irdbgypaU6@kreacher>
In-Reply-To: <2156873.irdbgypaU6@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: a44e2a8e-d1ff-4ffe-9e72-08db24304a9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ep3me5AwhoZV4Tm1PBqa1zVvumu4X4A3TSZ9/HYlelmRulLHpHZu8unlhEp/YEhCQWDAD+i5FCxXFjvcIHTPPYUbiSw/2m7647Tm8eIv0KMjbnw3kG/yDN5L7uNO9KIe8nSmXBqfsBqmA7ZXnB/xelj1hVH4a90TkTD3TORgjLFFSiRSelLv3P2sWTuQWUgS8wt45hWU30aAuK8JGihqW+3bjsH6FBDYyWUWRkiOFEnJB4J6s/pqQtDNML+aJiBgTSU1hDxcjGa4uaxOrLErdG7eSRlbwyS6B8OuShMgWUk5gkgDcR0mV6OlZKLSV362PGuuGDwpWy55FcjYD4m1ITYshRI2tLU2XAcuVHtBJpSrk659162Vyd0pZ5G3X3Dvp1dUraxal0ZFeuSlUGfjZ/DNWGxmCh1Ml3S2fAJB5EE6csDbtn8CCplj8FWFAbgbjwr+bnKS/Kq9/R8xsRFTxblSDeeqhe9c8OK152JwRSgQ9dFYEDM9P9DK5SPI5VHpB4uIAIfPEEd3jl8zNXSCb8V3Sx5Yd3ZAtuK3L2RR2PNkT+uCmazRG6fYvMUogzN11xtfCCB+1fiR8jMw+wAAsoK9yLnKF5b1pfbteFCBK/lpwhmqnjjQBYQkUk/rRogVTx29986TDGKkWpLNtdNAmD/mf+cE9vPxrfD1a9sq4AbUWPE26DdDfgIbP8yJFpQlbozyhsVT7H3cL09hoQ9dvxZnNweqfSTlgl1t/h9LDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(84970400001)(2616005)(2906002)(186003)(38100700002)(122000001)(82960400001)(26005)(6512007)(41300700001)(38070700005)(6506007)(83380400001)(5660300002)(478600001)(316002)(8936002)(64756008)(54906003)(110136005)(36756003)(66476007)(6486002)(91956017)(966005)(86362001)(8676002)(66946007)(66556008)(66446008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlRqVGc0TGt3ZDJramNCU3dUVEVWNlY5YlJCMHF4RzNoUU5jK25KRTN4OUlH?=
 =?utf-8?B?MlJEQ2FOL2w5cG1NZXR2TVp6ekFEeHI1dk11bGFzVjBkNE4wUk8wUFFDblNk?=
 =?utf-8?B?YXpvUzYrR0lGWEtYaFBveW5MSUFvd093KzBlMTJxU1Fqc1pRS24yK2NPeFdC?=
 =?utf-8?B?MUtpdC96bmNkM0dGN3J2RHRpUnUveXJVM05jTG9Yb0gxMmhZdE5jQzliMnQr?=
 =?utf-8?B?VzNISjR0bWFaSmdiYlFId09zZlFhbFRvNWZFTjJ6QXZqYlNEQVlZWnROWTdP?=
 =?utf-8?B?REtBT2VXUDhvREo1VUMvR2NhSGh3ZG5BM2NsSTY3dGZOWW5YdDlqTzZkbFBC?=
 =?utf-8?B?cmNSVmluaWdvZTk1THhSS011SW1PY1FiRHFIbFh4S041dlFjWTM0NVFDMjFL?=
 =?utf-8?B?bnRxcnMvaGlNTkdhYXlQM1p1cGw2akF3UWZROGpLZkxKbmFYdzJUM1BiVG5C?=
 =?utf-8?B?bDFZWktYbjh2QmV3VkVZcFd2Ykl0aXlmaThYTVZBcnNGcnhQSGhrVUpxalU0?=
 =?utf-8?B?VjVvUDhKYmQvckdJTXUrVWhXRGNqMERTRHVKMXhPWU5YNWw4eDdPajhoc0tm?=
 =?utf-8?B?QmgwNXdQazgrTHI5UU1oTGNJSUtGUnRsSjMvMlhWRUUyT1JzRTlHL29HL3N3?=
 =?utf-8?B?UnAwQzhlalhsZWZTZDVMZCt6ZkV4UUsza05zVHJxZVBORkNRN2NETk1wMXBL?=
 =?utf-8?B?YVQ0QTJQZExndXNQNDNqdzBoZkJwNDFIWjVxd0dEYzMwKzBlc2tSNnRRMFlv?=
 =?utf-8?B?cEs0dk9jeEg1NUdaZmtFTEhnSjIwVitmdG9wNk1idkRvQVFoV01SKytEZmNu?=
 =?utf-8?B?OENlMjJNZ1dmQ09wMHY2OUxzU2pRQnFWNDVDWXUwd3JPSStUT0tMckliTUJL?=
 =?utf-8?B?ckRZOEszWGhSWWZGMEpwNDQrck1kZHJITmJyNTViU2prcWo4ZGlXME5CN3Fr?=
 =?utf-8?B?bHVsaXFONVBCZHNreUF3VDZkNVc3S0hudHhUV2lDUUk1aFNoUiswOWxxcllq?=
 =?utf-8?B?Sm9GWkJ4NTdzNWsyODJuaTJMck13YVFCbSs3ZkxHYTUrQ0xaWFlqaGQ3YVdo?=
 =?utf-8?B?WVk4d3U1TDNLR1JKdks3NnVmR1h2NVUwOGxEUnVFMmtDNE5HTjRxQ25xOVQ4?=
 =?utf-8?B?R2kzYy9saTd6eUtIU2ZqaktLNGR0dEhQM1VtU25BTHV0dWJLRld2YkhqQjZ6?=
 =?utf-8?B?NEdRR2s2czFKU1FTTzlGdGtjdkVPaFMzWWpIQ1YzM3g3dENKZmxuSHI5UjBa?=
 =?utf-8?B?RFArL1NTbnJRS2luZHFpRzlOQ1hmVWE1TEdiTzNlYlJvYzNYMXRVbEhDRXhw?=
 =?utf-8?B?azhwT1pIbzdEYnpkdXMxM0ZrdGsveUpGeDNUL1NFS1dDY1p5UUkxM1VYSDlj?=
 =?utf-8?B?ZXhWSS9YSm5Pb3hmV3NXQ3VUVVkyS0hGWlczQUZlM1hIK2U3VGNYVXpLMGtS?=
 =?utf-8?B?VkZmdFdrcDF0ZUJ3TklYYXgyV3hmbVZLbHZGdmhNTjA1TmlrcXdNdEFvYXZF?=
 =?utf-8?B?WnRtekpwVW9hV2FuYWEyVGJ3d05obmJKWExsM0NHNG1Bb011SVZoRjFpM2pO?=
 =?utf-8?B?Y3FxU0hLN29lbmZaK0hWa1pWK2dyY3lNUG9ZU09uMmRQWG9IeFloZEhRWXR1?=
 =?utf-8?B?Z0l3eERUd3NNY1ZmZHZNZDJNTzVNQ2NlT090K2NHOFNlZzBhUnNEbm9yYk5m?=
 =?utf-8?B?d2dBYVdxeEdDNERQRnByc1RObGl6OExsTVRpajJjWEJzRTA3cEFmYzh2QVAv?=
 =?utf-8?B?UCtMdWYwczMzdWlZcExMN1Jxczc3T1I3U0tqUmpHbkhVSVNLakE3NXNaTmRL?=
 =?utf-8?B?NnBGbjdZQ1lxdVBGUUpDV2xLT0pUWjAzdFlFaGpZK0s1WlBoNFBvekZIMmt1?=
 =?utf-8?B?TjVKOGZXU3NHNDk5NVE0K05VSjNaMnozZy9QUUtsMGRlSFRDR1FVdWczeitQ?=
 =?utf-8?B?ZzFvSnowcDFaQkxrM2FtZkNRdnprejBiZ05TKzJQa1BseEJQOSttRzg0b3E1?=
 =?utf-8?B?QWNFUUFjNUNOQVdEbnh0SmpLNUVDZW1YL0FheFo3bUJJUmhPN2l5bCtmMjZW?=
 =?utf-8?B?OFFuYjBkbWhuYUdjNUhLbFFQN2cxRHpRdDNGek9qTUxCdFV4MUdrckVicDVa?=
 =?utf-8?Q?MNIKX4KaVBn/gUTpoxFScU2He?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E78EA448169B234C832BDAC6EC775A3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e2a8e-d1ff-4ffe-9e72-08db24304a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:03:23.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eD2wchHLGDxtnJJ9Znmnx3AxGEX3YN+MhSXlHdFQLjvNHMriTBl0bfJOUyY+Wa4psHm1kpqsoOhj2RwIbBNWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE1OjMyICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSW50cm9kdWNlIGEgY29yZSB0aGVybWFsIEFQSSBmdW5jdGlvbiwNCj4gdGhlcm1h
bF9jb29saW5nX2RldmljZV91cGRhdGUoKSwNCj4gZm9yIHVwZGF0aW5nIHRoZSBtYXhfc3RhdGUg
dmFsdWUgZm9yIGEgY29vbGluZyBkZXZpY2UgYW5kIHJlYXJyYW5naW5nDQo+IGl0cyBzdGF0aXN0
aWNzIGluIHN5c2ZzIGFmdGVyIGEgcG9zc2libGUgY2hhbmdlIG9mIGl0cw0KPiAtPmdldF9tYXhf
c3RhdGUoKQ0KPiBjYWxsYmFjayByZXR1cm4gdmFsdWUuDQo+IA0KPiBUaGF0IGNhbGxiYWNrIGlz
IG5vdyBpbnZva2VkIG9ubHkgb25jZSwgZHVyaW5nIGNvb2xpbmcgZGV2aWNlDQo+IHJlZ2lzdHJh
dGlvbiwgdG8gcG9wdWxhdGUgdGhlIG1heF9zdGF0ZSBmaWVsZCBpbiB0aGUgY29vbGluZyBkZXZp
Y2UNCj4gb2JqZWN0LCBzbyBpZiBpdHMgcmV0dXJuIHZhbHVlIGNoYW5nZXMsIGl0IG5lZWRzIHRv
IGJlIGludm9rZWQgYWdhaW4NCj4gYW5kIHRoZSBuZXcgcmV0dXJuIHZhbHVlIG5lZWRzIHRvIGJl
IHN0b3JlZCBhcyBtYXhfc3RhdGUuICBNb3Jlb3ZlciwNCj4gdGhlIHN0YXRpc3RpY3MgcHJlc2Vu
dGVkIGluIHN5c2ZzIG5lZWQgdG8gYmUgcmVhcnJhbmdlZCBpbiBnZW5lcmFsLA0KPiBiZWNhdXNl
IHRoZXJlIG1heSBub3QgYmUgZW5vdWdoIHJvb20gaW4gdGhlbSB0byBzdG9yZSBkYXRhIGZvciBh
bGwNCj4gb2YgdGhlIHBvc3NpYmxlIHN0YXRlcyAoaW4gdGhlIGNhc2Ugd2hlbiBtYXhfc3RhdGUg
Z3Jvd3MpLg0KPiANCj4gVGhlIG5ldyBmdW5jdGlvbiB0YWtlcyBjYXJlIG9mIHRoYXQgKGFuZCBz
b21lIG90aGVyIG1pbm9yIHRoaW5ncw0KPiByZWxhdGVkIHRvIGl0KSwgYnV0IHNvbWUgZXh0cmEg
bG9ja2luZyBhbmQgbG9ja2RlcCBhbm5vdGF0aW9ucyBhcmUNCj4gYWRkZWQgaW4gc2V2ZXJhbCBw
bGFjZXMgdG9vIHRvIHByb3RlY3QgYWdhaW5zdCBjcmFzaGVzIGluIHRoZSBjYXNlcw0KPiB3aGVu
IHRoZSBzdGF0aXN0aWNzIGFyZSBub3QgcHJlc2VudCBvciB3aGVuIGEgc3RhbGUgbWF4X3N0YXRl
IHZhbHVlDQo+IG1pZ2h0IGJlIHVzZWQgYnkgc3lzZnMgYXR0cmlidXRlcy4NCj4gDQo+IE5vdGUg
dGhhdCB0aGUgYWN0dWFsIHVzZXIgb2YgdGhlIG5ldyBmdW5jdGlvbiB3aWxsIGJlIGFkZGVkDQo+
IHNlcGFyYXRlbHkuDQo+IA0KPiBMaW5rOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtcG0vNTNlYzFmMDZmNjFjOTg0MTAwODY4OTI2ZjI4MjY0N2U1N2VjZmIyZC5jYW1lbEBpbnRl
bC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5j
b20+DQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFu
a3MsDQpydWkNCg0KPiAtLS0NCj4gDQo+IHYxIC0+IHYyOg0KPiAgICAgKiBNYWtlIHRoZXJtYWxf
Y29vbGluZ19kZXZpY2VfdXBkYXRlKCkgZG8gdGhlIGZ1bGwNCj4gSVNfRVJSX09SX05VTEwoKSBj
aGVjaw0KPiAgICAgICBvbiBjZGV2LCBzbyB0aGF0IGl0cyBjYWxsZXJzIGRvbid0IG5lZWQgdG8g
ZG8gaXQuDQo+ICAgICAqIFJlbW92ZSAtPnNldF9jdXJfc3RhdGUoKSBjYWxsYmFjayBpbnZvY2F0
aW9uIGZyb20NCj4gICAgICAgdGhlcm1hbF9jb29saW5nX2RldmljZV91cGRhdGUoKSwgYmVjYXVz
ZSBpdCBpcyByZWR1bmRhbnQgKGFuZA0KPiBpdCBkb2Vzbid0DQo+ICAgICAgIG1ha2Ugc2Vuc2Ug
dG8gcGFzcyBhIHN0YXRlIHZhbHVlIGV4Y2VlZGluZyBtYXhfc3RhdGUgdG8gaXQNCj4gYW55d2F5
KS4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jICB8ICAgNDAg
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5o
ICB8ICAgIDEgDQo+ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jIHwgICA3Mg0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4
L3RoZXJtYWwuaCAgICAgICAgIHwgICAgMSANCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBJbmRleDogbGludXgtcG0vZHJpdmVycy90
aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcv
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gQEAgLTEwNTcsNiArMTA1Nyw0NiBAQCBzdGF0aWMgYm9v
bCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3ByZXNlDQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0K
PiAgDQo+ICt2b2lkIHRoZXJtYWxfY29vbGluZ19kZXZpY2VfdXBkYXRlKHN0cnVjdCB0aGVybWFs
X2Nvb2xpbmdfZGV2aWNlDQo+ICpjZGV2KQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgc3RhdGU7
DQo+ICsNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoY2RldikpDQo+ICsJCXJldHVybjsNCj4gKw0K
PiArCS8qDQo+ICsJICogSG9sZCB0aGVybWFsX2xpc3RfbG9jayB0aHJvdWdob3V0IHRoZSB1cGRh
dGUgdG8gcHJldmVudCB0aGUNCj4gZGV2aWNlDQo+ICsJICogZnJvbSBnb2luZyBhd2F5IHdoaWxl
IGJlaW5nIHVwZGF0ZWQuDQo+ICsJICovDQo+ICsJbXV0ZXhfbG9jaygmdGhlcm1hbF9saXN0X2xv
Y2spOw0KPiArDQo+ICsJaWYgKCF0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3ByZXNlbnQoY2Rldikp
DQo+ICsJCWdvdG8gdW5sb2NrX2xpc3Q7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFVwZGF0ZSB1bmRl
ciB0aGUgY2RldiBsb2NrIHRvIHByZXZlbnQgdGhlIHN0YXRlIGZyb20gYmVpbmcNCj4gc2V0IGJl
eW9uZA0KPiArCSAqIHRoZSBuZXcgbGltaXQgY29uY3VycmVudGx5Lg0KPiArCSAqLw0KPiArCW11
dGV4X2xvY2soJmNkZXYtPmxvY2spOw0KPiArDQo+ICsJaWYgKGNkZXYtPm9wcy0+Z2V0X21heF9z
dGF0ZShjZGV2LCAmY2Rldi0+bWF4X3N0YXRlKSkNCj4gKwkJZ290byB1bmxvY2s7DQo+ICsNCj4g
Kwl0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3N0YXRzX3JlaW5pdChjZGV2KTsNCj4gKw0KPiArCWlm
IChjZGV2LT5vcHMtPmdldF9jdXJfc3RhdGUoY2RldiwgJnN0YXRlKSB8fCBzdGF0ZSA+IGNkZXYt
DQo+ID5tYXhfc3RhdGUpDQo+ICsJCWdvdG8gdW5sb2NrOw0KPiArDQo+ICsJdGhlcm1hbF9jb29s
aW5nX2RldmljZV9zdGF0c191cGRhdGUoY2Rldiwgc3RhdGUpOw0KPiArDQo+ICt1bmxvY2s6DQo+
ICsJbXV0ZXhfdW5sb2NrKCZjZGV2LT5sb2NrKTsNCj4gKw0KPiArdW5sb2NrX2xpc3Q6DQo+ICsJ
bXV0ZXhfdW5sb2NrKCZ0aGVybWFsX2xpc3RfbG9jayk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9M
X0dQTCh0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3VwZGF0ZSk7DQo+ICsNCj4gIHN0YXRpYyB2b2lk
IF9fdW5iaW5kKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwgaW50IG1hc2ssDQo+ICAJ
CSAgICAgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYpDQo+ICB7DQo+IEluZGV4
OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jDQo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfc3lzZnMuYw0KPiAr
KysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfc3lzZnMuYw0KPiBAQCAtNjg1LDYg
KzY4NSw4IEBAIHZvaWQgdGhlcm1hbF9jb29saW5nX2RldmljZV9zdGF0c191cGRhdGUNCj4gIHsN
Cj4gIAlzdHJ1Y3QgY29vbGluZ19kZXZfc3RhdHMgKnN0YXRzID0gY2Rldi0+c3RhdHM7DQo+ICAN
Cj4gKwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZjZGV2LT5sb2NrKTsNCj4gKw0KPiAgCWlmICghc3Rh
dHMpDQo+ICAJCXJldHVybjsNCj4gIA0KPiBAQCAtNzA2LDEzICs3MDgsMjIgQEAgc3RhdGljIHNz
aXplX3QgdG90YWxfdHJhbnNfc2hvdyhzdHJ1Y3QgZA0KPiAgCQkJCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyLCBjaGFyDQo+ICpidWYpDQo+ICB7DQo+ICAJc3RydWN0IHRoZXJtYWxfY29v
bGluZ19kZXZpY2UgKmNkZXYgPSB0b19jb29saW5nX2RldmljZShkZXYpOw0KPiAtCXN0cnVjdCBj
b29saW5nX2Rldl9zdGF0cyAqc3RhdHMgPSBjZGV2LT5zdGF0czsNCj4gKwlzdHJ1Y3QgY29vbGlu
Z19kZXZfc3RhdHMgKnN0YXRzOw0KPiAgCWludCByZXQ7DQo+ICANCj4gKwltdXRleF9sb2NrKCZj
ZGV2LT5sb2NrKTsNCj4gKw0KPiArCXN0YXRzID0gY2Rldi0+c3RhdHM7DQo+ICsJaWYgKCFzdGF0
cykNCj4gKwkJZ290byB1bmxvY2s7DQo+ICsNCj4gIAlzcGluX2xvY2soJnN0YXRzLT5sb2NrKTsN
Cj4gIAlyZXQgPSBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBzdGF0cy0+dG90YWxfdHJhbnMpOw0KPiAg
CXNwaW5fdW5sb2NrKCZzdGF0cy0+bG9jayk7DQo+ICANCj4gK3VubG9jazoNCj4gKwltdXRleF91
bmxvY2soJmNkZXYtPmxvY2spOw0KPiArDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiBA
QCAtNzIxLDExICs3MzIsMTggQEAgdGltZV9pbl9zdGF0ZV9tc19zaG93KHN0cnVjdCBkZXZpY2Ug
KmRldg0KPiAgCQkgICAgICBjaGFyICpidWYpDQo+ICB7DQo+ICAJc3RydWN0IHRoZXJtYWxfY29v
bGluZ19kZXZpY2UgKmNkZXYgPSB0b19jb29saW5nX2RldmljZShkZXYpOw0KPiAtCXN0cnVjdCBj
b29saW5nX2Rldl9zdGF0cyAqc3RhdHMgPSBjZGV2LT5zdGF0czsNCj4gKwlzdHJ1Y3QgY29vbGlu
Z19kZXZfc3RhdHMgKnN0YXRzOw0KPiAgCXNzaXplX3QgbGVuID0gMDsNCj4gIAlpbnQgaTsNCj4g
IA0KPiArCW11dGV4X2xvY2soJmNkZXYtPmxvY2spOw0KPiArDQo+ICsJc3RhdHMgPSBjZGV2LT5z
dGF0czsNCj4gKwlpZiAoIXN0YXRzKQ0KPiArCQlnb3RvIHVubG9jazsNCj4gKw0KPiAgCXNwaW5f
bG9jaygmc3RhdHMtPmxvY2spOw0KPiArDQo+ICAJdXBkYXRlX3RpbWVfaW5fc3RhdGUoc3RhdHMp
Ow0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8PSBjZGV2LT5tYXhfc3RhdGU7IGkrKykgew0KPiBA
QCAtNzM0LDYgKzc1Miw5IEBAIHRpbWVfaW5fc3RhdGVfbXNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpk
ZXYNCj4gIAl9DQo+ICAJc3Bpbl91bmxvY2soJnN0YXRzLT5sb2NrKTsNCj4gIA0KPiArdW5sb2Nr
Og0KPiArCW11dGV4X3VubG9jaygmY2Rldi0+bG9jayk7DQo+ICsNCj4gIAlyZXR1cm4gbGVuOw0K
PiAgfQ0KPiAgDQo+IEBAIC03NDIsOCArNzYzLDE2IEBAIHJlc2V0X3N0b3JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGQNCj4gIAkgICAgc2l6ZV90IGNvdW50KQ0KPiAgew0KPiAgCXN0cnVj
dCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2ID0gdG9fY29vbGluZ19kZXZpY2UoZGV2KTsN
Cj4gLQlzdHJ1Y3QgY29vbGluZ19kZXZfc3RhdHMgKnN0YXRzID0gY2Rldi0+c3RhdHM7DQo+IC0J
aW50IGksIHN0YXRlcyA9IGNkZXYtPm1heF9zdGF0ZSArIDE7DQo+ICsJc3RydWN0IGNvb2xpbmdf
ZGV2X3N0YXRzICpzdGF0czsNCj4gKwlpbnQgaSwgc3RhdGVzOw0KPiArDQo+ICsJbXV0ZXhfbG9j
aygmY2Rldi0+bG9jayk7DQo+ICsNCj4gKwlzdGF0cyA9IGNkZXYtPnN0YXRzOw0KPiArCWlmICgh
c3RhdHMpDQo+ICsJCWdvdG8gdW5sb2NrOw0KPiArDQo+ICsJc3RhdGVzID0gY2Rldi0+bWF4X3N0
YXRlICsgMTsNCj4gIA0KPiAgCXNwaW5fbG9jaygmc3RhdHMtPmxvY2spOw0KPiAgDQo+IEBAIC03
NTcsNiArNzg2LDkgQEAgcmVzZXRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZA0K
PiAgDQo+ICAJc3Bpbl91bmxvY2soJnN0YXRzLT5sb2NrKTsNCj4gIA0KPiArdW5sb2NrOg0KPiAr
CW11dGV4X3VubG9jaygmY2Rldi0+bG9jayk7DQo+ICsNCj4gIAlyZXR1cm4gY291bnQ7DQo+ICB9
DQo+ICANCj4gQEAgLTc2NCwxMCArNzk2LDE4IEBAIHN0YXRpYyBzc2l6ZV90IHRyYW5zX3RhYmxl
X3Nob3coc3RydWN0IGQNCj4gIAkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hh
cg0KPiAqYnVmKQ0KPiAgew0KPiAgCXN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2
ID0gdG9fY29vbGluZ19kZXZpY2UoZGV2KTsNCj4gLQlzdHJ1Y3QgY29vbGluZ19kZXZfc3RhdHMg
KnN0YXRzID0gY2Rldi0+c3RhdHM7DQo+ICsJc3RydWN0IGNvb2xpbmdfZGV2X3N0YXRzICpzdGF0
czsNCj4gIAlzc2l6ZV90IGxlbiA9IDA7DQo+ICAJaW50IGksIGo7DQo+ICANCj4gKwltdXRleF9s
b2NrKCZjZGV2LT5sb2NrKTsNCj4gKw0KPiArCXN0YXRzID0gY2Rldi0+c3RhdHM7DQo+ICsJaWYg
KCFzdGF0cykgew0KPiArCQlsZW4gPSAtRU5PREFUQTsNCj4gKwkJZ290byB1bmxvY2s7DQo+ICsJ
fQ0KPiArDQo+ICAJbGVuICs9IHNucHJpbnRmKGJ1ZiArIGxlbiwgUEFHRV9TSVpFIC0gbGVuLCAi
DQo+IEZyb20gIDogICAgVG9cbiIpOw0KPiAgCWxlbiArPSBzbnByaW50ZihidWYgKyBsZW4sIFBB
R0VfU0laRSAtIGxlbiwgIiAgICAgICA6ICIpOw0KPiAgCWZvciAoaSA9IDA7IGkgPD0gY2Rldi0+
bWF4X3N0YXRlOyBpKyspIHsNCj4gQEAgLTc3NSw4ICs4MTUsMTAgQEAgc3RhdGljIHNzaXplX3Qg
dHJhbnNfdGFibGVfc2hvdyhzdHJ1Y3QgZA0KPiAgCQkJYnJlYWs7DQo+ICAJCWxlbiArPSBzbnBy
aW50ZihidWYgKyBsZW4sIFBBR0VfU0laRSAtIGxlbiwNCj4gInN0YXRlJTJ1ICAiLCBpKTsNCj4g
IAl9DQo+IC0JaWYgKGxlbiA+PSBQQUdFX1NJWkUpDQo+IC0JCXJldHVybiBQQUdFX1NJWkU7DQo+
ICsJaWYgKGxlbiA+PSBQQUdFX1NJWkUpIHsNCj4gKwkJbGVuID0gUEFHRV9TSVpFOw0KPiArCQln
b3RvIHVubG9jazsNCj4gKwl9DQo+ICANCj4gIAlsZW4gKz0gc25wcmludGYoYnVmICsgbGVuLCBQ
QUdFX1NJWkUgLSBsZW4sICJcbiIpOw0KPiAgDQo+IEBAIC03OTksOCArODQxLDEyIEBAIHN0YXRp
YyBzc2l6ZV90IHRyYW5zX3RhYmxlX3Nob3coc3RydWN0IGQNCj4gIA0KPiAgCWlmIChsZW4gPj0g
UEFHRV9TSVpFKSB7DQo+ICAJCXByX3dhcm5fb25jZSgiVGhlcm1hbCB0cmFuc2l0aW9uIHRhYmxl
IGV4Y2VlZHMNCj4gUEFHRV9TSVpFLiBEaXNhYmxpbmdcbiIpOw0KPiAtCQlyZXR1cm4gLUVGQklH
Ow0KPiArCQlsZW4gPSAtRUZCSUc7DQo+ICAJfQ0KPiArDQo+ICt1bmxvY2s6DQo+ICsJbXV0ZXhf
dW5sb2NrKCZjZGV2LT5sb2NrKTsNCj4gKw0KPiAgCXJldHVybiBsZW47DQo+ICB9DQo+ICANCj4g
QEAgLTgzMCw2ICs4NzYsOCBAQCBzdGF0aWMgdm9pZCBjb29saW5nX2RldmljZV9zdGF0c19zZXR1
cChzDQo+ICAJdW5zaWduZWQgbG9uZyBzdGF0ZXMgPSBjZGV2LT5tYXhfc3RhdGUgKyAxOw0KPiAg
CWludCB2YXI7DQo+ICANCj4gKwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZjZGV2LT5sb2NrKTsNCj4g
Kw0KPiAgCXZhciA9IHNpemVvZigqc3RhdHMpOw0KPiAgCXZhciArPSBzaXplb2YoKnN0YXRzLT50
aW1lX2luX3N0YXRlKSAqIHN0YXRlczsNCj4gIAl2YXIgKz0gc2l6ZW9mKCpzdGF0cy0+dHJhbnNf
dGFibGUpICogc3RhdGVzICogc3RhdGVzOw0KPiBAQCAtODU1LDYgKzkwMyw4IEBAIG91dDoNCj4g
IA0KPiAgc3RhdGljIHZvaWQgY29vbGluZ19kZXZpY2Vfc3RhdHNfZGVzdHJveShzdHJ1Y3QNCj4g
dGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldikNCj4gIHsNCj4gKwlsb2NrZGVwX2Fzc2VydF9o
ZWxkKCZjZGV2LT5sb2NrKTsNCj4gKw0KPiAgCWtmcmVlKGNkZXYtPnN0YXRzKTsNCj4gIAljZGV2
LT5zdGF0cyA9IE5VTEw7DQo+ICB9DQo+IEBAIC04NzksNiArOTI5LDEyIEBAIHZvaWQgdGhlcm1h
bF9jb29saW5nX2RldmljZV9kZXN0cm95X3N5c2YNCj4gIAljb29saW5nX2RldmljZV9zdGF0c19k
ZXN0cm95KGNkZXYpOw0KPiAgfQ0KPiAgDQo+ICt2b2lkIHRoZXJtYWxfY29vbGluZ19kZXZpY2Vf
c3RhdHNfcmVpbml0KHN0cnVjdA0KPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2KQ0KPiAr
ew0KPiArCWNvb2xpbmdfZGV2aWNlX3N0YXRzX2Rlc3Ryb3koY2Rldik7DQo+ICsJY29vbGluZ19k
ZXZpY2Vfc3RhdHNfc2V0dXAoY2Rldik7DQo+ICt9DQo+ICsNCj4gIC8qIHRoZXNlIGhlbHBlciB3
aWxsIGJlIHVzZWQgb25seSBhdCB0aGUgdGltZSBvZiBiaW5kaWcgKi8NCj4gIHNzaXplX3QNCj4g
IHRyaXBfcG9pbnRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KPiBjaGFyICpidWYpDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9jb3JlLmgNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmgNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuaA0KPiBAQCAtMTI3LDYgKzEyNyw3IEBAIGludCB0aGVybWFsX3pvbmVf
Y3JlYXRlX2RldmljZV9ncm91cHMoc3QNCj4gIHZvaWQgdGhlcm1hbF96b25lX2Rlc3Ryb3lfZGV2
aWNlX2dyb3VwcyhzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZQ0KPiAqKTsNCj4gIHZvaWQgdGhl
cm1hbF9jb29saW5nX2RldmljZV9zZXR1cF9zeXNmcyhzdHJ1Y3QNCj4gdGhlcm1hbF9jb29saW5n
X2RldmljZSAqKTsNCj4gIHZvaWQgdGhlcm1hbF9jb29saW5nX2RldmljZV9kZXN0cm95X3N5c2Zz
KHN0cnVjdA0KPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2KTsNCj4gK3ZvaWQgdGhlcm1h
bF9jb29saW5nX2RldmljZV9zdGF0c19yZWluaXQoc3RydWN0DQo+IHRoZXJtYWxfY29vbGluZ19k
ZXZpY2UgKmNkZXYpOw0KPiAgLyogdXNlZCBvbmx5IGF0IGJpbmRpbmcgdGltZSAqLw0KPiAgc3Np
emVfdCB0cmlwX3BvaW50X3Nob3coc3RydWN0IGRldmljZSAqLCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqLA0KPiBjaGFyICopOw0KPiAgc3NpemVfdCB3ZWlnaHRfc2hvdyhzdHJ1Y3QgZGV2aWNl
ICosIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICosIGNoYXINCj4gKik7DQo+IEluZGV4OiBsaW51
eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1w
bS5vcmlnL2luY2x1ZGUvbGludXgvdGhlcm1hbC5oDQo+ICsrKyBsaW51eC1wbS9pbmNsdWRlL2xp
bnV4L3RoZXJtYWwuaA0KPiBAQCAtMzg4LDYgKzM4OCw3IEBAIGRldm1fdGhlcm1hbF9vZl9jb29s
aW5nX2RldmljZV9yZWdpc3RlcigNCj4gIAkJCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiAg
CQkJCWNoYXIgKnR5cGUsIHZvaWQgKmRldmRhdGEsDQo+ICAJCQkJY29uc3Qgc3RydWN0IHRoZXJt
YWxfY29vbGluZ19kZXZpY2Vfb3BzDQo+ICpvcHMpOw0KPiArdm9pZCB0aGVybWFsX2Nvb2xpbmdf
ZGV2aWNlX3VwZGF0ZShzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqKTsNCj4gIHZvaWQg
dGhlcm1hbF9jb29saW5nX2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdf
ZGV2aWNlDQo+ICopOw0KPiAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnRoZXJtYWxfem9u
ZV9nZXRfem9uZV9ieV9uYW1lKGNvbnN0IGNoYXINCj4gKm5hbWUpOw0KPiAgaW50IHRoZXJtYWxf
em9uZV9nZXRfdGVtcChzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosIGludA0KPiAqdGVt
cCk7DQo+IA0KPiANCj4gDQo=
