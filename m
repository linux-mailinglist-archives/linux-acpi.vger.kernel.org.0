Return-Path: <linux-acpi+bounces-14670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E8BAE9745
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9DF18921DB
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406524EF6B;
	Thu, 26 Jun 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPM/vQPs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9859A23314B;
	Thu, 26 Jun 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924472; cv=fail; b=p3Ax1c6ZJHqC3TUsPyehj77SpXm3MFpDQtuPp3AvJnmjUyengpY6Q12YtdJWOLrEakJvg6fW+Nv1ZSpUPLA2aVm9cgSmVTpQ9BBU+XEvEXSzNuPXm3KO5lSQmmqBarOgf6ymVToV2yYQCXICuzFe7Rixwxx6PgxfGkCXwppr5VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924472; c=relaxed/simple;
	bh=VMG2ebQ55cnmLOnegD9ZD0N38vR1QckK1TNP51l/j7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sC56BJRQZgHFFep74LhrA0Cf267tdQC4YxzThkWwywFKnqsnyuTvezwmLAq52ux31qgOEvWhfRjEbuWd9gqAcRhnVyoLQhns521MlFiyoi1QAND2Z3/8Lj4lPq59ZiPNbNue6GWYyKfk3lmM4KIXUj5vleg7O6ZXu/9yrQO9kW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPM/vQPs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750924470; x=1782460470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VMG2ebQ55cnmLOnegD9ZD0N38vR1QckK1TNP51l/j7k=;
  b=EPM/vQPsxbHLh1Lz5R7TUbzMtqkGIR3y1+dBjBfL/b11uwQDmjE2zdS7
   lugHRtFfjGD1NKefA1LwihgI/J05xPI2H78oXHOskpsXFkoPBCEzykNRM
   JRaLtZfYPOf6PIc+v2eozaRRQ4YVEt9oO5iwvuYCapWKN3DNca8HVOxqh
   HlpKXem2+q0UEiaWspjPDIrI0BS0NfAS3SpCdO/iKDd0BvDVXrTfyBVV6
   W1gdVxyH9vTEXDF428jpBWeeGrHhp7psoeKb2LioCvL/sWs2LholdrwPz
   cUv8fcCFXhukNEA3wa9ilznfotXqxAkkccKXy4mNwUZ33Qcje2sG7YZBP
   Q==;
X-CSE-ConnectionGUID: r5oUfLReTauoqsX5ExtObA==
X-CSE-MsgGUID: Z9QFP3gfRCi05M6nBbUnEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="75752510"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="75752510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 00:54:29 -0700
X-CSE-ConnectionGUID: zz8K9/xBQqCoQDkSGvOZxQ==
X-CSE-MsgGUID: mko+zQhTQtGkjko1Dtr/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152205175"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 00:54:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 00:54:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 00:54:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 00:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLepRE4jbyiE7Rr3cUZC33ak5ukm4TbV19JSWELXeaAsJFZgY6lEf7ln6RSbp9oUpKYJFnlu5IORISAgyzd0LY9oRqnTHkrlSvVe8dcOLScPSPsHq3ck1Jd0FgsNWDNFp2QOQUpSQUg8MWsUmrq+00sFBd7wma+7VPgAJJGai5Fs/nkc1LUAaLIyiBc+T9dx7RrcXIl9QnXFRu9TC8GwEfrSJTO/IY5lpAc0hdly6n8oiio1MFHDMMYnq3sGey8pGrK20RjUQCoLUMcaGykSqZrPoWw+uPh9PmVQmM4KojNW0nDS7u6ivFvyIwo4v78PH4lhg1HMqkU/aINVCUlsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS9h93Hp5ABDRmvzBSKKtYWpeHCK8aY/QOMqRJCnZNI=;
 b=oex14c91bWsU8TkMZHVvF35T/9RjgQwDMtxgMgPesGmqVeslM9c5eE56U5g+EJNrQetzj6N+047oSTZR8mKV/k70/uvr23f+/fWsj3SPHKMMTglfiLlhbk9JYmM3IInEc5O9AmFPrracxAE2qfFQePFEcadHSqJV2yqbMoZ3U3l+HlWzG/2gc4t3WhTs5jLP308XwMbX6UB7pRgm9kN+jlAxoNwMlBriXEFyPIU9qh7jLtv+1wIYCQQxfdl6wr/tkLI/FvHMHRWPdC1GynEoah/QbdH3Vf6P5KQXg5wxqkGmsIszP5JRrHu585mpAnQQIKaL/5L9XSBGCwJQagjSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 07:54:26 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.8835.027; Thu, 26 Jun 2025
 07:54:26 +0000
Message-ID: <38ab3fb5-6d1a-491b-ad20-08066b007a28@intel.com>
Date: Thu, 26 Jun 2025 09:54:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: LPSS: Remove AudioDSP related ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250625172133.3996325-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250625172133.3996325-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a66cc89-6ddc-44b9-bd5f-08ddb486ac33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajdZWDJPb1VldjE2TEtsS1pqZUJBOHRFYVg2am9vOXJKY21JbVg4bnNndnc3?=
 =?utf-8?B?SEVuMEIxd05id3JmS3hiVnZtL1BHTHgyYTJOaVRHeUxITjRsTWduOWRQb3FH?=
 =?utf-8?B?VGVub25XdzBiZWp6WmlSSnNCa3BUaVpDbHd5bWFmSEZlTko0S0FsTnlodlZI?=
 =?utf-8?B?akNlU0ZpeUwyMldudTFkRHpad2RTR0piZjdZWWF2SHQvT2xGR3dabHJIQk5P?=
 =?utf-8?B?c0tzR1ZwTHBBUTFKa2FYTXNJN0piS3ZRWHJjSHlod21FQkJmSjl5VUtSVTVl?=
 =?utf-8?B?NXVjcVFOU0lJMThNMFhqbjBqcC92YzdkYjJZNmhBM1dHMFlCZ3VFYzRoSnBM?=
 =?utf-8?B?T2UxS2p4bFdiQThwZVo4dmJXKzNPYzdnTG1jN3pMbFp6bU8ydnlKdENOcmNM?=
 =?utf-8?B?eHBXRWNySjZTSjM2TDk3WmFCWGJBTnlUVlppdnBDWGg5MXk1blo2c2g5aEw4?=
 =?utf-8?B?Y01mL2pmMjMrdk16bGFMZ1JkM2p4RkUyck15MXFIOXNxeTB0L3I4L1VvRUxa?=
 =?utf-8?B?QytOdWNTNDRaTjRqSHdVb1JWUDBZVHVhd3RYeEp5bUoySG1CRmtqZCtCY1NI?=
 =?utf-8?B?T0lCNjVRdmcrSG9aQ3p0WUdwVVlzKzVKbkJsQTFTSlZDY013ZmM3UHg4dUhL?=
 =?utf-8?B?TWJDclh2cytXZTQ0aGdSV3NZc3VjOXRXL2dFMmZ4UkZEYTY2OHdvMkI2ZDlq?=
 =?utf-8?B?UmNTeWZQOHpFRm5XbWxXcncvQk8rNDV3U3ZIQ0RnZjJrc2dVTTZFTlMxSlJX?=
 =?utf-8?B?TkZIZHdxcDNvQkl0Q05zN1hkVTBmSlFuZEJGa0tFNXFoNHIwUDlKbTV1RnJy?=
 =?utf-8?B?RWVYNUpHVDRMelZjbUpDM0pkNHhBV2JEb1BDdTZLUS9OTTBTNDRKdUoveDVR?=
 =?utf-8?B?UzdoZVlpbVlDYVBoLzdlR1Rveld0c09hU0RhZ05sWWNGUXpLUFR0K3U5UytL?=
 =?utf-8?B?eXUwZ3NDdVlPR3QxMFNWUGJwNjl5cGVNRE5jbjRjSmRYT21zbXlqWUFhZUVx?=
 =?utf-8?B?bGE5c3N4cVVYZWVRckc5Ymp2dUN2MFY5MGNyZnU2UVI5ekZDNjVtKytuR0hO?=
 =?utf-8?B?Qmh0eTFLRkZYdmJxbmd5RWp0RmpQZ254dFZmTUZGYnlGTFQ2MnVEcUNQYXVl?=
 =?utf-8?B?ZVZRM2gyQ2gwTkFCcktGczNEbUVmZmJVOGZ5bk1Uc3VSTWhlM2FBWXI3Wkxz?=
 =?utf-8?B?dENscnFTNWxtSFAxS21TU0dXbEl0a3h4WHZYOFJXZkVOekZhQjNMOS9HUCtL?=
 =?utf-8?B?azNUOUdwdGNlTDUreEljODRBRkI1ejYyZEdTK05paGFmQkluaUtGWnFGdlpU?=
 =?utf-8?B?eEdoKzNJWWVwQ2w1eUV6OXRrdExFTExsdS9GUHdlWDZGWWEyTFUzUEpnTmJj?=
 =?utf-8?B?Q3ltd3FZQ0szY040cEg2VWpWLzFEUlR2dnVRaUV3aVZLQWxVUVdJVnVjMUpL?=
 =?utf-8?B?cWk1R3ZyUUdQNGZMQVdQVjBxS3llT2lmczVYU0FzQTNtZGRGbGE1aExsMVYz?=
 =?utf-8?B?OWF3VW5JdGRZYTd1N1VUTDU3TWFld3RvZGRHVWhoK0lySGVYbkRpM0JjQy9X?=
 =?utf-8?B?QnZMYXVYNEZIbFE1bk9aYW1BMnhGYldRMHBVNUdwUFFTNy9GSDhIdk9nQktn?=
 =?utf-8?B?NlVOcHFKTC9jOGJSOHRrSjg0YWlYMURDTmVLTEZlQjMxOFF1MVdQWW5EbHNL?=
 =?utf-8?B?eXhZcmtJc2VNc3pUVVc1Q0kvRjJWclVEc0ZpN0VsRjlHNW5xWlpUcWg5cHBT?=
 =?utf-8?B?OEJBRGZLeFA1VlVDa2RaZENkeWNFbHJEeTZLTmdSbmp6S2ZaM2F3enRiS0h5?=
 =?utf-8?B?VkwwTzdtOC9Xb0VQR2xzSEd3Ui9lZHJVUUtWck1DWlF0cWw2dE9uYllSeFFN?=
 =?utf-8?B?b3pQUEVYM2dWbktEYk9PRkUxbHlHQTRTL21IWWZ2OFgyUVNUTGRsZ0dyOExH?=
 =?utf-8?Q?vPKKlW0JLiw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amdxd1BNVW5BZDBzNDdkLyt0QmJwR2NVdnYwUjNzcWx0Q3pocTRCeHN2YVJS?=
 =?utf-8?B?Wnp5T2xnc0t4Rkh2QjhuOHpneHFSc3ZncFo3R2RwaUpWdFlwdVd6a3VxMmlE?=
 =?utf-8?B?bFZza0JRdGozak8wbHREbHh4SDdGRHk5Y1pOdDhOU09zdTFWMWxkZXpIZVZ6?=
 =?utf-8?B?ZkxXQVc5anR3UkVFbVVIeUZnd3orY1VhZzdXQU1EOXYyRnNoTG1VUVZYOEFW?=
 =?utf-8?B?WUFsVEhLNDRoczhlenprTS9XMkNRTWxpZ1RpUUduQ0RHVm9zdzI4L2dWcUxY?=
 =?utf-8?B?MDBDUnVwYk1ROUtQZCtkL0g0MlpLcUx6UG1TbVpxYnhyQW44RzFVYW9FOTdX?=
 =?utf-8?B?TEVqWHFiTkV5cjkwdkswRW1DSjZZUFlkYWx3SDRzV2ZDZ3lNeXlXRlB1eXRU?=
 =?utf-8?B?c3RVekM2c1p4WXNuQ253K2ZlZnlrSW1SWkN4aVdPL2h0Mmp4UHFYaGwzZWNQ?=
 =?utf-8?B?ZVJKU1F1Z2NSblpKQXNzVU1PNHdxMkVXaFFhUFpBUXVzQUZSV2x2b3pwcGd1?=
 =?utf-8?B?Q2ZsRTRKVDNzUVp6RjBhU1pNeXU3TEhiMUQvelVvekhPTmFFczlsUUh2RHQ3?=
 =?utf-8?B?d3k0SVRUY1NRcy9DSElYSnRLZ1FIVFVSY2VRMHh2S3ZjV3A5R0RFZmtncmNP?=
 =?utf-8?B?RnJrellocnhFWFJ2U0hrcnBtSzVBanZybkRib0VyZzZDNThRRVhnUkFGUzIz?=
 =?utf-8?B?MkQyZXArUFpsazc4Qk9XRUtQS05uSC9aRDZwOStmSmFmU1QvclByUHh4bFIx?=
 =?utf-8?B?ZUVkK1dtWnhwdG0zUGlLN05XSDA5NVcyZFppUWZzUGxOSE1jbHhVRVNiM0Jn?=
 =?utf-8?B?QVRPQ3Z1WDI1bWI1dVBLcUxobHBuazN1UGl5TGY5ejJ6and1TU9FYjBSU1Iy?=
 =?utf-8?B?UVY0cW15UXNPbHpJT2VvdVRoSnRxR1BKd0VjNzIzRUFBSENZYVBVNWNaRkRI?=
 =?utf-8?B?SmhXdzB6MUZ3VWdEdnEvaG1mYUxLSXYxN3hqUDluOXVHWlF4TTg2Qm5CYkds?=
 =?utf-8?B?SVpmR0ZkR0xJT0tXRE5NZWNDeTgxbEVJVjRsZC9XNTV1c013REZuakFkdzlM?=
 =?utf-8?B?M3FSeHk2TGx2cEo1V3ZRbHFQTTFnWWF5R2xqY0xVRmFHNlIraGZaWlhLTjRB?=
 =?utf-8?B?bTMvUThJY0gyL0NiajBUa3VyVEdSRVhoNGhFYkh5TkxxL0VtZXlVdHpoQ2pp?=
 =?utf-8?B?eG93Qks4NiszSGZjU0JUTHVvY2FjSjN0MCtrUGpVN1BhQVJBVHhYVUh3SmdX?=
 =?utf-8?B?RG1BSHJITTBVbHRSWS9nVTVBTXdwMEd4RW9MUGVJcmt0d1BIaWdPQ2JVWGVq?=
 =?utf-8?B?R2tVWkhCZFJFNzhpQlVsZTJPbC9WcS93WmRzTXlKN0Q1WHUyZXB5di9pN3hD?=
 =?utf-8?B?ait4bkJBSEFPRU1nWVJxYm1OeWJ2TXhXNTlUeVJxK2dhOUMrcjg0SjEwYzht?=
 =?utf-8?B?eTdTMjh0QW9aQUJFQk5sMzh0MnhsbkN2SzBsVmVYcmcwd2VXeGFIN3ZjS2th?=
 =?utf-8?B?Uzkya1ZpU3YrOUF0K2RZRjQ1M1dMYXpUZ2ZVaFhUcnp6NGU0M1YrOC9MT0dK?=
 =?utf-8?B?TWtqQzduZlk4YWVhUGg4M09tNFZVVGFZWERtcmpFVDRjcmdoRnlkMmRSWjVw?=
 =?utf-8?B?UVJWZ0JFbzlxTEp1Uklxc29XWlYxOVpXcVFxVlp2S1Q5WFpvY1hxU3hCSnhr?=
 =?utf-8?B?MUdWL0JVODFLNVhYTU1QRFlIUU9nQ1VZOUdtS1djcnZoa0F6cFJsU0xxYStj?=
 =?utf-8?B?eWhRd2NUVHA2bGpqU0xnb3YrMEVQQW5jNXFKN01Sd1dxY2ZIRUtGS21xK3pj?=
 =?utf-8?B?SXdGeVNtWlY5MEdoaDliT2FQNFgwdklzTnlSOEJaaE9ValQ5NnJtdkpXVm9z?=
 =?utf-8?B?ZU5FUVNjSTFDY0h4cXQ1SVc0M1EzWFNDOTQwYWZ3TzV2emdJRXFPTktFVDZj?=
 =?utf-8?B?YXA2S2hVYlAvK0l3d2FzdU05QjRlOGc4ZGZyMitVSVlUcmMzTWFhTVRTNmM5?=
 =?utf-8?B?R2JGSGdIOVlsZnNXbUs2ajNYenBTMjVqOTg1M2NTNVpHc1JTUnlvdm5SZHlr?=
 =?utf-8?B?bzM3TnVGdDRWRXNCRFlzTFo4aDZxS25LeUVPVTFyZHYzQS9DMSsrbG5NaEgx?=
 =?utf-8?B?RGZIRXh3V2tYWUduU3lFb2hBQ2x4cXFhay9CakZYeVFaVGlvQTYxQ2VmRUNT?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a66cc89-6ddc-44b9-bd5f-08ddb486ac33
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:54:26.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRtuO0rLI11v08NGRZ7QDjqbRb4cPFHacWxBD1eZ95U2pvYFfMTbnaOuWQw4JPyH4BZC5pPZlC2v0UfxAMm/geGae4238RlUGYomIs2fVF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com

On 2025-06-25 7:21 PM, Andy Shevchenko wrote:
> The AudioDSP drivers are in control for all functions of the hardware
> they have (they are multi-functional devices). The LPSS driver prepares
> for enumeration only single devices, such as DMA, UART, SPI, I²C. Hence
> the registration of AudioDSP should not be covered. Moreover, the very
> same ACPI _HID has been added by the catpt driver a few years ago.
> 
> And even more serious issue with this, is that the register window at
> offset 0x800 is actually D-SRAM0 in case of AudioDSP and writing to it
> is a data corruption.
> 
> That all being said, remove the AudioDSP ID from the LPSS driver,
> where it doesn't belong to.
> 
> Fixes: fb94b7b11c6a ("ASoC: Intel: Remove SST firmware components")
> Fixes: 05668be1b364 ("ASoC: Intel: Remove SST ACPI component")
> Fixes: 7a10b66a5df9 ("ASoC: Intel: catpt: Device driver lifecycle")

Hi Andy,

A nitpick:

The fixes tags used here seem incorrect. The catpt-driver replaced its 
predecessor (the haswell driver) providing no interface changes. Usage 
of INT3438 ID has been introduced with commit c2f8783fa2d0 ("ASoC: 
Intel: Add common SST driver loader on ACPI systems"), if that's what 
you have been looking for.

In regard to the code - the change has been reviewed by me and tested in 
our CI, no regression on the audio side observed:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/acpi/x86/lpss.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
> index 258440b899a9..6daa6372f980 100644
> --- a/drivers/acpi/x86/lpss.c
> +++ b/drivers/acpi/x86/lpss.c
> @@ -387,9 +387,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>   	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
>   	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
>   
> -	/* Wildcat Point LPSS devices */
> -	{ "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
> -
>   	{ }
>   };
>   


