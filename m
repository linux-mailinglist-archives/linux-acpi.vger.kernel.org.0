Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9269118A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 20:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBITrj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBITri (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 14:47:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22C23671;
        Thu,  9 Feb 2023 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675972057; x=1707508057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cWwqbM2WlFHwD0Bt+kIq3HIFxMcLVUpmEFvVVJPp9f8=;
  b=BZfa7gP2Rbuj1a+ShwBBQSk2zu3Rj9nldSzGsBr7BRsMn3vqDkCmeBTd
   N7e/nRJzxq1l+cInLuZVkSajMr4T4Hwj5+vNOVT5CsMrKETWt4i2sbQRI
   uiVsSpKpVUWd5tonrA3CupztyyEfCcUT6U8Rdo6w1fy+GNeK2tI9I6I6D
   Bxmvd3wY582DJPJPJk2D1vy47wC4NnW+OsZnFo60xyui17vESnrNtcrK2
   nbiHgN0cxkK57x4YIW2wHCwO/aLr1j4pv3v9gXvk+szH/eRTu/48Wxrmn
   FoE04Zso7zRbEuNGerAhNMZm/R5ryfLKvfIyJU/OlNPakvfmjqslwlsto
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="313871417"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="313871417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 11:47:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="810502349"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="810502349"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2023 11:47:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 11:47:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 11:47:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 11:47:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHGuKZOJP5Bg47N3+LXLWpPZPgNrJqFjgcY1HNUSFqGM5Ozp4Gd8y0Zx+sXUTYOOXVdKdPts9Zlmq7Pm14hzBdT/ACWYr5WBG5a0x5eRXpUecerzqNlQofTyzOB5ze7xIpb6MadnWPYD1+VG0DZBipeTN9Xx0PH30HO5Y/VZ6dJD9ELekKBDIxR9nKY5HrN86sPNiwwW2kLnsNHHIZq8DKxEs6W72QDyWU4CbtZhMDfmdCQ48nGJnQpswxF3x6tQR2p+lDe9v/kvZMczFHvAsCcMnJtbyZBzC8M5McGUvR4YxomOXXVR+MeJk62Ru/fDZfFVrbImkwG8nuXlFBVQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWwqbM2WlFHwD0Bt+kIq3HIFxMcLVUpmEFvVVJPp9f8=;
 b=KOExON8agSFtd7jpyGsDf9mt8OA4/yoZKuUOCXw9tFTzeV6XKGOZ/ha6w2DlU0gXNKAzyZflaHJZYHRfv/XenCfkNr+5AYx4XGkK4JB6woF2TfpEfCcxwOgjOR4/MVGr/gCv6tWrEPt8KjE8+l6JgzAJ65DFH1NW3jY2PMp7111joAm4jAbyOB4krVgj61ELjXusYu45ZjMrfeE7w5pxzBmv9qBpM+3Yhhjme4kTKYZG67BlPGFe+mxSa1J/Z46GrRFV/Iu7OjclnlucYH0Uu2oldhkGiPuzV6z4MQpcv6k12woo9E1Vq/IYnwqtRDzZppAfirWutNmxDrQRdLyLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 19:47:04 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 19:47:04 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Thread-Topic: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Thread-Index: AQHZOcbYG2zjUIGzNUG9aE+fflquf67HCvuA
Date:   Thu, 9 Feb 2023 19:47:03 +0000
Message-ID: <e0ae75df59c346cff79215b0e4cc5d4638617c65.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB6423:EE_
x-ms-office365-filtering-correlation-id: 41e21be3-c901-4fa7-ee84-08db0ad66b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: phhcLzXFYusiqXZpqMPodC4ucSoY3BCFx/YDfDn8ISP6ca5gIgc8sLw0qmHGY9qcFF1N/b6DMEAA6IQlcqr1E8uVA5v0pk6r7d3lo/jhDrDFodWEzed2vyoxOMHqRlt70uQdtpNlkvWzYhQ05MYWSvLeREp4wBSovTMkzxXHK2yIGjwU4EJhxLAMZpLY2dOUK5+H9pdPsFTRpUwVPk0flumAwylFjt3V2K6R+WuaYw9V1bOai6pU952mk1lfx40RCZNomo6yUeuY0SQGUm/t2pgzHuYCnp/p30IfthFXIO9rkg/brnP/nG8ZC5xks+TfAK43caentBClyafXqHLLzgq6SBtik28fLEdzyj/21jZptjFDvRstu/xyk43yN8xofCVvniMSVdQZ2weDZp74AU9vha2aMZWL1AMT/6Jv5Bxpwsh873ju5jOfMgr0IuU0Lsb/+EjF0PF3Xinm34FomgYikfuhVTsxbxHOeJOZV8/XbcbJyAAdINArXVdyxZ6xmza00HUeeO/eeLcNOcX63riLcR05X+LNF694V0LeJNTbl2+QfYnk4sQ+J95vmx5WIRFvwCW26PX9mC4EfW+6IhKxLbIQZmH0qAzQKJlN9FtgK8sELl6E0bK8VZOhtyvzKfcRnZwACoNA6vpSyyPMe2cFEzVPT/9UFf502E4Bv5B/OzuxTvPj07IswTiyOkTK4gG/al2BXcDfUUY+R+Mfnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(36756003)(83380400001)(122000001)(38100700002)(82960400001)(6512007)(186003)(6506007)(26005)(54906003)(2906002)(71200400001)(478600001)(38070700005)(6486002)(316002)(110136005)(41300700001)(5660300002)(8936002)(86362001)(2616005)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWlvR25pTEZnejRhNVlKM1R6M2NvMkx4Mm4wY0lPaDZnNkdLMGlpUERJV043?=
 =?utf-8?B?YWcwU0VJaWVHak1kd2NmMlRLUzllTHdlbUxCVTYvOFQxeGRxc1pvSVNhSk9Z?=
 =?utf-8?B?UGhJajhXdFRVVzVhTm12Q1lhMm0zc0tiODIwRFdsMzFHbm1WTU5wNloza2xr?=
 =?utf-8?B?a2kxcXlid3dCT2ZZNjExSk0xWEFRWWhUQkQ3ZStJc2QrR2JDbklrSHpWRWVG?=
 =?utf-8?B?WmlSSlprQ1oxbS9SU3d2bVB6RXF4em9JNFJ3NFdZU3BkN3VQMTF5OHZPS2w4?=
 =?utf-8?B?eTNUMTFLM3VlNEpzZVFjYWFKc1FvOUVYU0tYUlF5QmRxNEJudWszeThmSlVW?=
 =?utf-8?B?dXpDMDFQQ0FhRUQ0YXUwdkp2bk92Uy9TWjV6cSszeitWR3RVUTF3RGduR20r?=
 =?utf-8?B?cWc4U1JpUEpaQ0hiMFNUd3Jyb3BTTDBvVHN3dWlsR2hTVUEzZTZUNW1GMG1L?=
 =?utf-8?B?U0U3UHF5TllHeldsYVE0bkg0aVJyZXNhaGdZZmUrcTZ1cFduWjVHZzVHRmh4?=
 =?utf-8?B?cXZFcVFHOTl2aEd1aXhwME9pMzd2UzF4eW1TUE4xQWVCSmlvK2ZrUEVrQzhr?=
 =?utf-8?B?bzRQU05UeEFPcWpIb2l2Ri9Tam11NjlsQ2ZvSnVaU1lwK3JwY0dmVlFmK0x3?=
 =?utf-8?B?NHBhemovTDAzeHpBNGVjYkhNQ08zOWFhajBFQ0JBWU5VQSsxUGZ6MUFlZUxE?=
 =?utf-8?B?MDRHMkZFWldoa3dyMi9yOEw4ZkxDYktYbW5aMDVnSzQxOXZqbmFubk5jK0Iy?=
 =?utf-8?B?WG9uOFlxRjZhZGU4NmlLUXEvcGFrNnhubkhlNTBDSEN4Rk9xbjFnTDJ4dnNT?=
 =?utf-8?B?L3hFVFhXZG9TUDhuUEk1YWFqbHRQaENDRXFNQkxvVzl0YzJwZkhhMnIxeHNu?=
 =?utf-8?B?VndOSTdDMnE4ejI5N0k2SjhKMTFGR3VZci83OU90YWVsclJnaHJ2c3gvMUpt?=
 =?utf-8?B?Nm5Mb0lFanpCSkpiY0tSZFg3QXRNTlpReENidCtqSkFzU1dnMnIrZjYzWHFU?=
 =?utf-8?B?ZjdmZm8wN0Z5YnBqcW5SajlNZ1h0L0kyVzlTbWp4QTduV0dOeDFmUXNaQ1BD?=
 =?utf-8?B?bHVKSTRWdXkreWp4OEpIcTR2RWNueVpDdWZaT24rSVZKL3NOdEJMMDdnWW5G?=
 =?utf-8?B?SjlXT1VxcXo4blpsTFdKK20xczBFUEVUUzc0aUJyRnRhaHhEcDhXMDFCMkdp?=
 =?utf-8?B?RXBDVmttT242WlVLK3owVlJWd2R4MGdsekJkWEJURW4wQ1hsNWthaHBKWjJF?=
 =?utf-8?B?a2lEaGswRW1sdm5kQ1NhY2xBbkpPdWpSSDhHekNXS0FTamxwUGxLbGQxRDlY?=
 =?utf-8?B?ZGxlQTBsUjFDTDJoMEZONTlBRnhKbldmSjVLdW1UOFh5Y0NSR3ZaR2JUdjFP?=
 =?utf-8?B?T1YrUTdFdkFJSWlyaWlwMlNTNWRnUW96TjF2cHlGSTlYQ3Q5aW4xTDM2Wlp0?=
 =?utf-8?B?QTZwN09GWEwvT3d3YjBDRWFKQlR3Y1dNUkZMTGpHempza3VtTDhhUDA1L0kr?=
 =?utf-8?B?Q3hpYVRpTmI4bC9UbkZDQTIzQU1DbythZzBnemZPV0xCaUtKNTNwUXBVODVL?=
 =?utf-8?B?NThpZ1MwVTZ2NUNicDVMTCt0WW9mbXRjaUZGN2tRbkhCMFlJY2IxdEtpeGpO?=
 =?utf-8?B?TnQwb2ZxVVVkYktEbzh3bXdRNE0ydmI3MkMzdHpobDZMSGlOenIxTjYwdVMz?=
 =?utf-8?B?TXZEMCt3QlZHY3pLTWtMTHlEYkRzUDRDbnhGcnNEdXk0SzduemkxQ0ZhVU5n?=
 =?utf-8?B?Y3hTN0lPNkhIbUVnRm15dEtWM1NRTGVrSVhtRkxqSGVRYkNXZ2R6TWJOcXFQ?=
 =?utf-8?B?ck1HUHhlQlZkUTM3bjVhNlJKeWdDamlkZHJmVHg0bTBvc3FRUGlzU1lWeVFl?=
 =?utf-8?B?QmdKSWM1c1NoekJudEVZd21lc1FJRnU3S2YzcTMvWURyL2JCaGpOOWIzZmFk?=
 =?utf-8?B?K0J3VDdicGR5cG1PZ2prZXAxdXY0akIxQ3RQUWpkWFcxRnh5cHFBZTV4a1VW?=
 =?utf-8?B?SVNGSTBtMWowNy9kVDlhOFBpMHg1MGsvRTlrRm0zbDRmM2ljKzRKd0JQczh1?=
 =?utf-8?B?bmR4R1FOKzVpZlBFeS9DaExmeXVFTmpqZG5MTXl1N2FaOTZYby85blJxRUt0?=
 =?utf-8?B?Z0M4K2VDUWtyZjFtRWFMR3c2MW1CeHp2VUF5aElnbEZndFZ0bnh6TzhsWmRD?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7B4204B09CF442964E21C3749FBE1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e21be3-c901-4fa7-ee84-08db0ad66b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 19:47:03.9490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+620BtQroBjyaBkuQPisKw3ONxlEUHmlaj6BnnqfafJvYfyxPcV0NpezCih/vwaDP3rCgQBjiUeQs8wgUapekgkeXR34m4z+1v+4uUYKAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
SW4gc3VwcG9ydCBvZiB0aGUgQ1hMIHN1YnN5c3RlbSdzIHVzZSBvZiAnc3RydWN0IHJhbmdlJyB0
byB0cmFjayBkZWNvZGUKPiBhZGRyZXNzIHJhbmdlcywgYWRkIGEgY29tbW9uIHJhbmdlX2NvbnRh
aW5zKCkgaW1wbGVtZW50YXRpb24gd2l0aAo+IGlkZW50aWNhbCBzZW1hbnRpY3MgYXMgcmVzb3Vy
Y2VfY29udGFpbnMoKTsKPiAKPiBUaGUgZXhpc3RpbmcgJ3JhbmdlX2NvbnRhaW5zKCknIGluIGxp
Yi9zdGFja2luaXRfa3VuaXQuYyBpcyBuYW1lc3BhY2VkCj4gd2l0aCBhICdzdGFja2luaXRfJyBw
cmVmaXguCj4gCj4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgo+IFNpZ25l
ZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+
IMKgZHJpdmVycy9jeGwvY29yZS9wY2kuYyB8wqDCoMKgIDUgLS0tLS0KPiDCoGluY2x1ZGUvbGlu
dXgvcmFuZ2UuaMKgIHzCoMKgwqAgNSArKysrKwo+IMKgbGliL3N0YWNraW5pdF9rdW5pdC5jwqAg
fMKgwqDCoCA2ICsrKy0tLQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCgpMb29rcyBnb29kLAoKUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlz
aGFsLmwudmVybWFAaW50ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29y
ZS9wY2kuYyBiL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMKPiBpbmRleCAxZDE0OTI0NDAyODcuLjll
ZDIxMjBkYmY4YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jCj4gKysrIGIv
ZHJpdmVycy9jeGwvY29yZS9wY2kuYwo+IEBAIC0yMTQsMTEgKzIxNCw2IEBAIHN0YXRpYyBpbnQg
ZGV2bV9jeGxfZW5hYmxlX21lbShzdHJ1Y3QgZGV2aWNlICpob3N0LCBzdHJ1Y3QgY3hsX2Rldl9z
dGF0ZSAqY3hsZHMpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkZXZtX2FkZF9hY3Rpb25fb3Jf
cmVzZXQoaG9zdCwgY2xlYXJfbWVtX2VuYWJsZSwgY3hsZHMpOwo+IMKgfQo+IMKgCj4gLXN0YXRp
YyBib29sIHJhbmdlX2NvbnRhaW5zKHN0cnVjdCByYW5nZSAqcjEsIHN0cnVjdCByYW5nZSAqcjIp
Cj4gLXsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcjEtPnN0YXJ0IDw9IHIyLT5zdGFydCAmJiBy
MS0+ZW5kID49IHIyLT5lbmQ7Cj4gLX0KPiAtCj4gwqAvKiByZXF1aXJlIGR2c2VjIHJhbmdlcyB0
byBiZSBjb3ZlcmVkIGJ5IGEgbG9ja2VkIHBsYXRmb3JtIHdpbmRvdyAqLwo+IMKgc3RhdGljIGlu
dCBkdnNlY19yYW5nZV9hbGxvd2VkKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqYXJnKQo+IMKg
ewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3JhbmdlLmggYi9pbmNsdWRlL2xpbnV4L3Jh
bmdlLmgKPiBpbmRleCAyNzQ2ODFjYzMxNTQuLjdlZmI2YTliMDY5YiAxMDA2NDQKPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3JhbmdlLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3JhbmdlLmgKPiBAQCAt
MTMsNiArMTMsMTEgQEAgc3RhdGljIGlubGluZSB1NjQgcmFuZ2VfbGVuKGNvbnN0IHN0cnVjdCBy
YW5nZSAqcmFuZ2UpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYW5nZS0+ZW5kIC0gcmFuZ2Ut
PnN0YXJ0ICsgMTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgaW5saW5lIGJvb2wgcmFuZ2VfY29udGFp
bnMoc3RydWN0IHJhbmdlICpyMSwgc3RydWN0IHJhbmdlICpyMikKPiArewo+ICvCoMKgwqDCoMKg
wqDCoHJldHVybiByMS0+c3RhcnQgPD0gcjItPnN0YXJ0ICYmIHIxLT5lbmQgPj0gcjItPmVuZDsK
PiArfQo+ICsKPiDCoGludCBhZGRfcmFuZ2Uoc3RydWN0IHJhbmdlICpyYW5nZSwgaW50IGF6LCBp
bnQgbnJfcmFuZ2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1NjQgc3RhcnQs
IHU2NCBlbmQpOwo+IMKgCj4gZGlmZiAtLWdpdCBhL2xpYi9zdGFja2luaXRfa3VuaXQuYyBiL2xp
Yi9zdGFja2luaXRfa3VuaXQuYwo+IGluZGV4IDQ1OTFkNmNmNWUwMS4uMDU5NDdhMmZlYjkzIDEw
MDY0NAo+IC0tLSBhL2xpYi9zdGFja2luaXRfa3VuaXQuYwo+ICsrKyBiL2xpYi9zdGFja2luaXRf
a3VuaXQuYwo+IEBAIC0zMSw4ICszMSw4IEBAIHN0YXRpYyB2b2xhdGlsZSB1OCBmb3JjZWRfbWFz
ayA9IDB4ZmY7Cj4gwqBzdGF0aWMgdm9pZCAqZmlsbF9zdGFydCwgKnRhcmdldF9zdGFydDsKPiDC
oHN0YXRpYyBzaXplX3QgZmlsbF9zaXplLCB0YXJnZXRfc2l6ZTsKPiDCoAo+IC1zdGF0aWMgYm9v
bCByYW5nZV9jb250YWlucyhjaGFyICpoYXlzdGFja19zdGFydCwgc2l6ZV90IGhheXN0YWNrX3Np
emUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNoYXIgKm5lZWRsZV9zdGFydCwgc2l6ZV90IG5lZWRsZV9zaXplKQo+ICtzdGF0aWMgYm9vbCBz
dGFja2luaXRfcmFuZ2VfY29udGFpbnMoY2hhciAqaGF5c3RhY2tfc3RhcnQsIHNpemVfdCBoYXlz
dGFja19zaXplLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYXIgKm5lZWRsZV9zdGFydCwgc2l6ZV90IG5l
ZWRsZV9zaXplKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobmVlZGxlX3N0YXJ0ID49IGhh
eXN0YWNrX3N0YXJ0ICYmCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZWVkbGVfc3RhcnQgKyBu
ZWVkbGVfc2l6ZSA8PSBoYXlzdGFja19zdGFydCArIGhheXN0YWNrX3NpemUpCj4gQEAgLTE3NSw3
ICsxNzUsNyBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCB0ZXN0XyAjIyBuYW1lIChzdHJ1Y3Qga3Vu
aXQgKnRlc3QpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4g
wqDCoMKgwqDCoMKgwqDCoC8qIFZhbGlkYXRlIHRoYXQgY29tcGlsZXIgbGluZWQgdXAgZmlsbCBh
bmQgdGFyZ2V0LiAqL8KgwqBcCj4gwqDCoMKgwqDCoMKgwqDCoEtVTklUX0FTU0VSVF9UUlVFX01T
Ryh0ZXN0LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBcCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhbmdlX2NvbnRhaW5z
KGZpbGxfc3RhcnQsIGZpbGxfc2l6ZSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGFja2luaXRfcmFuZ2VfY29udGFpbnMoZmlsbF9zdGFy
dCwgZmlsbF9zaXplLMKgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfc3RhcnQsIHRhcmdldF9zaXplKSzCoMKgwqDCoMKgwqDC
oMKgwqBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAic3RhY2sgZmlsbCBtaXNz
ZWQgdGFyZ2V0IT8gIsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIihmaWxsICV6dSB3aWRlLCB0YXJnZXQgb2Zm
c2V0IGJ5ICVkKVxuIizCoMKgwqDCoMKgwqDCoFwKPiAKPiAKCg==
