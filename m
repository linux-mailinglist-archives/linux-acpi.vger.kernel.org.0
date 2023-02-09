Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5ED68FBEA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 01:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBIAU5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 19:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBIAU4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 19:20:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6020D39;
        Wed,  8 Feb 2023 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675902054; x=1707438054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jGIlw8Veu014M5bVOdrv1ZojXyq8Bw5M/wOAy7bFVGY=;
  b=CgqLhiMJV7piL9hU9InLf/BZeJ8dmGF83V8mGDWy0Y+a0xUEg4EzDnaI
   /hh/LJXnqX1dahuKJZ3fPbH5A5BC7yPujnWZw3Lt/QCIegVWdDBTKRTsa
   a2GTrMlUe9OubTQv5W41uq8qn+8dOHb6sG7/7hCW6arptmw3xeCZgbjGL
   FEe5L48WTei9ycbm/i5/q7iiA34t4Rn69SbaNYFeBdlZVAqmB2ofEsUfF
   cIwEMvk3RzZ4Bvkn/2XBYIwHmHHspG13JWX8jiNdfG/9ewrU5hTLZiMVi
   Ba71z74vIRNXBePHCBzt2+tDhEF4zkqFKmcAlcT3vNTRiPtWo0LWj/L2H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328616167"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="328616167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="699858031"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="699858031"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2023 16:20:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:20:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 16:20:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 16:20:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByydlK2K4/rjIJc6TnEXQx1uX38pq/hLQn86pj1pOa6wghiW2FqL7Mj4otFGBYHc6dAank6sxZABmNcdMJ+HY7GBV4gJAJKZJ+6/wjVWTz/Kd4jfo/JCs4gK4eMWmqcMV1IMatsiS3u0UByr4cae1Rzw5yEw+ETSV0pxDEmcel6Sg3Jqx9hdipH7uySsLF98z8aHLExJrriLYLkbcp2vaFatmUt8emQw94CWqAcDrQ82TNfLeM8OviwhP9rkYHVbm4Q/xT1MnLBXFd9SkTUvrX5zZYLPg3nDUL+wrD9k9zjOFCoQOSA29MHcsfm7raU9M/nqUUBYopoJZeI7nJrnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGIlw8Veu014M5bVOdrv1ZojXyq8Bw5M/wOAy7bFVGY=;
 b=Jncx2t+DcmnGrqu9wd0XQg9y0ImPfi4piOAioiDCI51GEtmDD0onNy1YLBFVx0ujEHgYaZGEqvZBQM2YPs+qRRq7NCL72dQfUvulUyZmprmaS7mIImmUsB9ol/0pO9eVyYL97V1QRnCbpsN/E+7DFsjlyssvPZ3G3zRfODOmHpQJnk9/xsB9v3Hk1etUMnt/HUjKsLMIv7b7D2zq1MIXVKPPq7hog70J6HkCswtpT77xKgn5m1bgi8mSEOROMy9lxVNL1XDgJjRyEjBe6Dpl9EC9tkwKQbjzDRD54SMxlQ6VV+4lS5AzSm9o+wanZqHC8d7WhydSk7sxMu0PS8vt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 00:20:51 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 00:20:51 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 01/18] cxl/Documentation: Update references to attributes
 added in v6.0
Thread-Topic: [PATCH 01/18] cxl/Documentation: Update references to attributes
 added in v6.0
Thread-Index: AQHZOca6WPJSfCOzwEW2OUbuLVC0fa7FxSuA
Date:   Thu, 9 Feb 2023 00:20:50 +0000
Message-ID: <b85f28f618a8d64e082fc63da761174a8ae66db9.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: 7b173145-65f7-4b58-b6f8-08db0a338005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WBc9N1Nw7jKyKyq7jWNBLJRWQpD4fPwqvVKgWvS56tYhBxjYBruz3/Kr0sr9MREx4m9dhFE/PC3yFmMAGj+PNHxLI0ppTHtByWtpXITgP4aIW4/41crWX/mbVkmx/dCNHg31L3NXVTA4wSmfeJ2mpBNGGRjxMYKipSTXxbizRNBQRwFgUUhGs1iZT6ew5d/8Xx8E+T4C7lYWkPshcN7cbermNKqVUQ+iG7R038L/r+lnnpK0c+b4B9jpKbc1SyX7+uwKc1iOUFEglvdKFl+7PAdJBxgpOK1zB9Snyc4Ye1zym74J/kL1Qo0SCHejchXILuzR4ae4gW+tqde0+6Qlw51XDnw4iJ6bBQbR6z7Nl2HM+oxRTfhZ8szCDgGaJU30k4/NaMSs/nUFVvfO+7QMGHlAietwHsa0UhoxCcO+tnw2A0D5o2eHwxRlW9QPJMkfaRuixMrJGR6hCTBrUNoUtc0YzggDiz5Z7pTTjNMJv0bJ98GK1GiIIc8QGKEcq6HmurfdTQmObUU2JuS7czG32C3lLghIRPR07/jU9fne2OPyQWvixhGIxjd8iAiNOfmIDYNTVHDk6knmDXp+K/H8NoTPwSl9VhDuynbQ6WLlwORiDqtxWhWKMmzzODeK3pM+Zg3Q25MBRlhaEtfHEmJ13LJwKHqK0/UeTdn/Inzf1o7DR1iQ+OavcCHWndGdl1b3vW5FUwDz7o5PnGlgezTKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(38070700005)(5660300002)(86362001)(8936002)(122000001)(26005)(186003)(6512007)(2616005)(38100700002)(83380400001)(76116006)(91956017)(54906003)(110136005)(316002)(41300700001)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(82960400001)(478600001)(6506007)(71200400001)(6486002)(36756003)(15650500001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lJTzRMVE5sVkIwbG9hRHhndEw5aTF1YUVlMG1CaVBUcWFLUGk1L0VGOVJG?=
 =?utf-8?B?NUJxMDdBaElRbmNCd2hqWkc3Mk9KSVY0RXpaZDV6VW5ERWZ3aVRmcTlJVVpz?=
 =?utf-8?B?cjZ0c1lYZlBSWThwNk1BL0xZNTNLNTB2cjArMVp5L0FXNlpRT0ZXdHExaGx0?=
 =?utf-8?B?a3lkUEZQclNsWE95dU41MXNoa2huWWVUTXU0VHhDZXRRVXRpTnZFVklWTXFQ?=
 =?utf-8?B?eXRLbHV2ODJTUVh4L0xhb3BGMHVjR0lLYVBTOU96ZTJIYlh1Uk1wS1pYY1pC?=
 =?utf-8?B?VjUrdFhuWlhHMnUyQnBMejVrbnUzTHE1YTJ5N3BXRjNXVFFFMU9HT1NoclFn?=
 =?utf-8?B?OEdqaHlIVWdZWXRuOWNELzZXeElZSS9aT2VwOFRobGY4S2VucEErVWZWOEtu?=
 =?utf-8?B?bEZOR1VmRUN6anFWTjFtSWtjZXdPME5TQlZOOFh2WGllVGhmRk9Ld0w2ZDlj?=
 =?utf-8?B?QmZZS1djMGZscitJNWpXekhmV0lKQWNKL1JpWmhhVGlaMjI3M1U0QXhmQzBG?=
 =?utf-8?B?TEQ3Z0R6SWE4UW55d0p1bWFCemZacmNHMCtFc0RLMlJTTFJqMGtIK0RVbmtz?=
 =?utf-8?B?T3NMMU1yRVk3WGRWUG1rTHorN2Fqb0xXNTZtRTZmS2FzQldPUWRXdzhzelZj?=
 =?utf-8?B?VnRwTVpDV3R6a3kwdU5nWmovQzQ5U29yNEYxWjRhUHNBcnQzb214MkM0Vjlk?=
 =?utf-8?B?dHNibHZaOE8xa1kwVm5aU2tVMTkzbzB6bS9XVGp5dGorQ0VZKzVNREQvZUxL?=
 =?utf-8?B?ZmJISE1QcFJud05WT3YwUmY2Sk5oNEY5M2N5RkRQK0w5RXlJUUxLSlpnWk9K?=
 =?utf-8?B?NUxjVUVad05QNWhIZ3V4OVQ0cHIydDZPY1pSYzBnN09FVzA2eVltb3hTYkQ4?=
 =?utf-8?B?dHZyRzk1dXV4RS94ZyttSjVUckEyL1plckpUdGdtOFRya3pPb2RwOXptMXRM?=
 =?utf-8?B?dFhsQWJ6RERDUFFIQkcrWnlicDdCQ085V2NMYzFidUNoKzNLb2hHMzNITG5t?=
 =?utf-8?B?aU0zZXZLZ3hacGI5MVc2TmlQb0RUSm9ZMDF2eVIrZ0gwSlFURHZGVHlrSUUy?=
 =?utf-8?B?K29yaDdZWFc0L2tFOTg1YkE1NEdRWkdJZHJkdlN0dEpQREN1NWZycXhrOXFJ?=
 =?utf-8?B?aEtHa2phQkRWY2NkS05QckxoTmFkK1VIVFppWFdFODZZdGtpVUEyd2p3Q1Fa?=
 =?utf-8?B?bmM0U0M0Z0dsNmZrTXNSQTBZN2E3cGNqR1VBKzFueFE1YmV2aWYwOENveEpX?=
 =?utf-8?B?NmVIbTQ2a1I2eWMrNitEdGJvWGVqc0Nvc0hFK1psK2tKY0R1VXV3YW5rdDJF?=
 =?utf-8?B?N2k3d25aY0Ria3FIeTBqS3F1TVgrK2R1aVF3RHAxa3AxbEhUODRHRTdHRlNX?=
 =?utf-8?B?TTRvOHpNbk44UXZIbFJaK0ppTnFwWmJTUGhwSTJtMW1wOHpPQU5yQnZOTDhY?=
 =?utf-8?B?RTZGamVSRFN0cFdFS2xqNUtEM2tWMjJSbWpiTVBuZ2tYSGxLQzdIdmg3RjBC?=
 =?utf-8?B?TXRzUTdBby9heE5TY1FFcG5ZRVVtOU5SQnp1ZSsvTHRNOTFCYVAvNlJwTUZJ?=
 =?utf-8?B?bGNBNjc3VFc1MHJNQ2ZESWw0UzYvOFBRck9EUUlWYkVvK2JRZWhjTXIvUkR4?=
 =?utf-8?B?VzArc2tSZzdqeVIxcDNldEQ1dVdCMEd4QjFFbzdRb3NmZHdhU1o2SnlxOWcx?=
 =?utf-8?B?Z3BaNXFOdHhYbFhUUXBlNSthYUhHMHpYdzZZRVMweXREdUpLeEVpQTRISEtC?=
 =?utf-8?B?TUNqV1VQZGpOcXk2VHFyeWFucndUdDAyOG5FbllBSEtpME1KSjZ0a3BuYmE5?=
 =?utf-8?B?YjBhekZ5QWNNR29OMUIzWnI3OTh2TFBFdFlKUDBJQ0I5UExNTWUxSE5VTnVQ?=
 =?utf-8?B?Qlh2bHZ6d20vUWZNUkJSQmpsVE4rTC82UU91U0ZtWUNwUnp4Y1hRKzZJNzRM?=
 =?utf-8?B?MU1RYjUxMW9uUytsa0ZJMmltNTl5dFBaUXFrQUsxSHllSEpXOUx1SmxxZDQx?=
 =?utf-8?B?ZExwelRycVRscW9oV3NqYUgzcXFEVVVqUis0UysxT1VHOEd5c0RpTHFDQ1Fl?=
 =?utf-8?B?ek43NW9zZ3NoOUtJTGprcVVFR3pOb3NPWGNtY2tjVURXYVgrMWJSUUJET2t6?=
 =?utf-8?B?MzNCTEo0N1lUV1F0Q3RveEQ3eEtnTGhSdHVhbURxQTNPQ1NZSi9FM0lnZTc1?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <702A68690EBD854F86C27E02C5C86BB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b173145-65f7-4b58-b6f8-08db0a338005
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:20:51.0056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJUZ5MK/+gjjY78rotZ6IxDtF50UtWukg1FlX4nyqRY2nGUjwYXgtx3sTCjLMZQ7IbIyZ7fGMXGD7j6/ozm5H3vw4Do6Wd8pbMwU8lnuhvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
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
UHJpb3IgdG8gTGludXMgZGVjaWRpbmcgdGhhdCB0aGUga2VybmVsIHRoYXQgZm9sbG93aW5nIHY1
LjE5IHdvdWxkIGJlCj4gdjYuMCwgdGhlIENYTCBBQkkgZG9jdW1lbnRhdGlvbiBhbHJlYWR5IHJl
ZmVyZW5jZWQgdjUuMjAuIEluIHByZXBhcmF0aW9uCj4gZm9yIHVwZGF0aW5nIHRoZXNlIGVudHJp
ZXMgdXBkYXRlIHRoZSBrZXJuZWwgdmVyc2lvbiB0byB2Ni4wLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+IMKgRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hsIHzCoMKgIDMwICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQoKTG9va3MgZ29vZCwKClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT4KCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWN4bCBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtYnVzLWN4bAo+IGluZGV4IDMyOWE3ZTQ2YzgwNS4uNWJlMDMyMzEzZTI5IDEwMDY0NAo+IC0t
LSBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWN4bAo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWN4bAo+IEBAIC0xOTgsNyArMTk4LDcgQEAg
RGVzY3JpcHRpb246Cj4gwqAKPiDCoFdoYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9j
eGwvZGV2aWNlcy9lbmRwb2ludFgvQ0RBVAo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoEp1
bHksIDIwMjIKPiAtS2VybmVsVmVyc2lvbjrCoHY1LjIwCj4gK0tlcm5lbFZlcnNpb246wqB2Ni4w
Cj4gwqBDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZwo+IMKg
RGVzY3JpcHRpb246Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUk8pIElmIHRo
aXMgc3lzZnMgZW50cnkgaXMgbm90IHByZXNlbnQgbm8gRE9FIG1haWxib3ggd2FzCj4gQEAgLTIw
OSw3ICsyMDksNyBAQCBEZXNjcmlwdGlvbjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKg
wqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL2RlY29kZXJYLlkvbW9kZQo+IMKgRGF0ZTrCoMKgwqDC
oMKgwqDCoMKgwqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJzaW9uOsKgdjUuMjAKPiArS2VybmVs
VmVyc2lvbjrCoHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1jeGxAdmdlci5r
ZXJuZWwub3JnCj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoChSVykgV2hlbiBhIENYTCBkZWNvZGVyIGlzIG9mIGRldnR5cGUgImN4bF9kZWNvZGVyX2Vu
ZHBvaW50IiBpdAo+IEBAIC0yMjksNyArMjI5LDcgQEAgRGVzY3JpcHRpb246Cj4gwqAKPiDCoFdo
YXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9jeGwvZGV2aWNlcy9kZWNvZGVyWC5ZL2Rw
YV9yZXNvdXJjZQo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE1heSwgMjAyMgo+IC1LZXJu
ZWxWZXJzaW9uOsKgdjUuMjAKPiArS2VybmVsVmVyc2lvbjrCoHY2LjAKPiDCoENvbnRhY3Q6wqDC
oMKgwqDCoMKgwqBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnCj4gwqBEZXNjcmlwdGlvbjoKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChSTykgV2hlbiBhIENYTCBkZWNvZGVyIGlz
IG9mIGRldnR5cGUgImN4bF9kZWNvZGVyX2VuZHBvaW50IiwKPiBAQCAtMjQwLDcgKzI0MCw3IEBA
IERlc2NyaXB0aW9uOgo+IMKgCj4gwqBXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMv
Y3hsL2RldmljZXMvZGVjb2RlclguWS9kcGFfc2l6ZQo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKg
wqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJzaW9uOsKgdjUuMjAKPiArS2VybmVsVmVyc2lvbjrC
oHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1jeGxAdmdlci5rZXJuZWwub3Jn
Cj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChSVykg
V2hlbiBhIENYTCBkZWNvZGVyIGlzIG9mIGRldnR5cGUgImN4bF9kZWNvZGVyX2VuZHBvaW50IiBp
dAo+IEBAIC0yNjAsNyArMjYwLDcgQEAgRGVzY3JpcHRpb246Cj4gwqAKPiDCoFdoYXQ6wqDCoMKg
wqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9jeGwvZGV2aWNlcy9kZWNvZGVyWC5ZL2ludGVybGVhdmVf
d2F5cwo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJz
aW9uOsKgdjUuMjAKPiArS2VybmVsVmVyc2lvbjrCoHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDC
oMKgwqBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnCj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChSTykgVGhlIG51bWJlciBvZiB0YXJnZXRzIGFjcm9z
cyB3aGljaCB0aGlzIGRlY29kZXIncyBob3N0Cj4gQEAgLTI3NSw3ICsyNzUsNyBAQCBEZXNjcmlw
dGlvbjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZp
Y2VzL2RlY29kZXJYLlkvaW50ZXJsZWF2ZV9ncmFudWxhcml0eQo+IMKgRGF0ZTrCoMKgwqDCoMKg
wqDCoMKgwqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJzaW9uOsKgdjUuMjAKPiArS2VybmVsVmVy
c2lvbjrCoHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1jeGxAdmdlci5rZXJu
ZWwub3JnCj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oChSTykgVGhlIG51bWJlciBvZiBjb25zZWN1dGl2ZSBieXRlcyBvZiBob3N0IHBoeXNpY2FsIGFk
ZHJlc3MKPiBAQCAtMjg3LDcgKzI4Nyw3IEBAIERlc2NyaXB0aW9uOgo+IMKgCj4gwqBXaGF0OsKg
wqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvY3hsL2RldmljZXMvZGVjb2RlclguWS9jcmVhdGVf
cG1lbV9yZWdpb24KPiDCoERhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBNYXksIDIwMjIKPiAtS2Vy
bmVsVmVyc2lvbjrCoHY1LjIwCj4gK0tlcm5lbFZlcnNpb246wqB2Ni4wCj4gwqBDb250YWN0OsKg
wqDCoMKgwqDCoMKgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZwo+IMKgRGVzY3JpcHRpb246Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUlcpIFdyaXRlIGEgc3RyaW5nIGluIHRo
ZSBmb3JtICdyZWdpb25aJyB0byBzdGFydCB0aGUgcHJvY2Vzcwo+IEBAIC0zMDMsNyArMzAzLDcg
QEAgRGVzY3JpcHRpb246Cj4gwqAKPiDCoFdoYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1
cy9jeGwvZGV2aWNlcy9kZWNvZGVyWC5ZL2RlbGV0ZV9yZWdpb24KPiDCoERhdGU6wqDCoMKgwqDC
oMKgwqDCoMKgwqBNYXksIDIwMjIKPiAtS2VybmVsVmVyc2lvbjrCoHY1LjIwCj4gK0tlcm5lbFZl
cnNpb246wqB2Ni4wCj4gwqBDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgtY3hsQHZnZXIua2Vy
bmVsLm9yZwo+IMKgRGVzY3JpcHRpb246Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAoV08pIFdyaXRlIGEgc3RyaW5nIGluIHRoZSBmb3JtICdyZWdpb25aJyB0byBkZWxldGUgdGhh
dCByZWdpb24sCj4gQEAgLTMxMiw3ICszMTIsNyBAQCBEZXNjcmlwdGlvbjoKPiDCoAo+IMKgV2hh
dDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lvblovdXVpZAo+
IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJzaW9uOsKg
djUuMjAKPiArS2VybmVsVmVyc2lvbjrCoHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBs
aW51eC1jeGxAdmdlci5rZXJuZWwub3JnCj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoChSVykgV3JpdGUgYSB1bmlxdWUgaWRlbnRpZmllciBmb3IgdGhl
IHJlZ2lvbi4gVGhpcyBmaWVsZCBtdXN0Cj4gQEAgLTMyMiw3ICszMjIsNyBAQCBEZXNjcmlwdGlv
bjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2Vz
L3JlZ2lvblovaW50ZXJsZWF2ZV9ncmFudWxhcml0eQo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKg
wqDCoE1heSwgMjAyMgo+IC1LZXJuZWxWZXJzaW9uOsKgdjUuMjAKPiArS2VybmVsVmVyc2lvbjrC
oHY2LjAKPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1jeGxAdmdlci5rZXJuZWwub3Jn
Cj4gwqBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChSVykg
U2V0IHRoZSBudW1iZXIgb2YgY29uc2VjdXRpdmUgYnl0ZXMgZWFjaCBkZXZpY2UgaW4gdGhlCj4g
QEAgLTMzMyw3ICszMzMsNyBAQCBEZXNjcmlwdGlvbjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKg
wqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lvblovaW50ZXJsZWF2ZV93YXlzCj4g
wqBEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgTWF5LCAyMDIyCj4gLUtlcm5lbFZlcnNpb246wqB2
NS4yMAo+ICtLZXJuZWxWZXJzaW9uOsKgdjYuMAo+IMKgQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxp
bnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcKPiDCoERlc2NyaXB0aW9uOgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgKFJXKSBDb25maWd1cmVzIHRoZSBudW1iZXIgb2YgZGV2aWNlcyBw
YXJ0aWNpcGF0aW5nIGluIHRoZQo+IEBAIC0zNDMsNyArMzQzLDcgQEAgRGVzY3JpcHRpb246Cj4g
wqAKPiDCoFdoYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9jeGwvZGV2aWNlcy9yZWdp
b25aL3NpemUKPiDCoERhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBNYXksIDIwMjIKPiAtS2VybmVs
VmVyc2lvbjrCoHY1LjIwCj4gK0tlcm5lbFZlcnNpb246wqB2Ni4wCj4gwqBDb250YWN0OsKgwqDC
oMKgwqDCoMKgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZwo+IMKgRGVzY3JpcHRpb246Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUlcpIFN5c3RlbSBwaHlzaWNhbCBhZGRyZXNz
IHNwYWNlIHRvIGJlIGNvbnN1bWVkIGJ5IHRoZSByZWdpb24uCj4gQEAgLTM2MCw3ICszNjAsNyBA
QCBEZXNjcmlwdGlvbjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVz
L2N4bC9kZXZpY2VzL3JlZ2lvblovcmVzb3VyY2UKPiDCoERhdGU6wqDCoMKgwqDCoMKgwqDCoMKg
wqBNYXksIDIwMjIKPiAtS2VybmVsVmVyc2lvbjrCoHY1LjIwCj4gK0tlcm5lbFZlcnNpb246wqB2
Ni4wCj4gwqBDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZwo+
IMKgRGVzY3JpcHRpb246Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUk8pIEEg
cmVnaW9uIGlzIGEgY29udGlndW91cyBwYXJ0aXRpb24gb2YgYSBDWEwgcm9vdCBkZWNvZGVyCj4g
QEAgLTM3Miw3ICszNzIsNyBAQCBEZXNjcmlwdGlvbjoKPiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKg
wqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lvblovdGFyZ2V0WzAuLk5dCj4gwqBE
YXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgTWF5LCAyMDIyCj4gLUtlcm5lbFZlcnNpb246wqB2NS4y
MAo+ICtLZXJuZWxWZXJzaW9uOsKgdjYuMAo+IMKgQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxpbnV4
LWN4bEB2Z2VyLmtlcm5lbC5vcmcKPiDCoERlc2NyaXB0aW9uOgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgKFJXKSBXcml0ZSBhbiBlbmRwb2ludCBkZWNvZGVyIG9iamVjdCBuYW1l
IHRvICd0YXJnZXRYJyB3aGVyZSBYCj4gQEAgLTM5MSw3ICszOTEsNyBAQCBEZXNjcmlwdGlvbjoK
PiDCoAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL3Jl
Z2lvblovY29tbWl0Cj4gwqBEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgTWF5LCAyMDIyCj4gLUtl
cm5lbFZlcnNpb246wqB2NS4yMAo+ICtLZXJuZWxWZXJzaW9uOsKgdjYuMAo+IMKgQ29udGFjdDrC
oMKgwqDCoMKgwqDCoGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcKPiDCoERlc2NyaXB0aW9uOgo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKFJXKSBXcml0ZSBhIGJvb2xlYW4gJ3Ry
dWUnIHN0cmluZyB2YWx1ZSB0byB0aGlzIGF0dHJpYnV0ZSB0bwo+IAo+IAoK
