Return-Path: <linux-acpi+bounces-17832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 844ADBE52B0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11ADF4E3EFC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A82222582;
	Thu, 16 Oct 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZvz3lZ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619214B950;
	Thu, 16 Oct 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641574; cv=fail; b=m1Mt4AauDauWBQoaxMfQ3RxcxleaHV3N/IB0i6iZUzMpqEXxl3DiiJDxPy1uUGg8qmGS1hb2VgwTHeJs+dUTJT2mNFBUqPatTo46z+w8yoot09ZqdrG+5CO53eXjGkA2VojZHUWUdbGZ8ND9Gax81z9I3TqB5FHk+aqYcBZUtaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641574; c=relaxed/simple;
	bh=9EfUPKt5zhKT/8Z+C/u6pkQL2aAl00o+9dLVsBuW2PY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=W6hunxuKxayZhr5JKsYz0ejzYpODBKPho5mX162B9gby/VTADCh8cS3gyMKZkVhbOqsY9571QAWUIYRu29fMaP5pEexOjZ6PKdbEhT5JimuH5ip20sX8j4lFZUxh2GRIEBM0o1YGfhjVld3lF0X3rExJU0NZlV38eXQd3DYIWyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZvz3lZ7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760641573; x=1792177573;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9EfUPKt5zhKT/8Z+C/u6pkQL2aAl00o+9dLVsBuW2PY=;
  b=QZvz3lZ776kWqeqCwK7f139qJyko9AQa2Q7NGNsOXzGwuqGzlb7yEkcG
   TuVW3aamfvcUCRjfbtONcE0Zr/rhmJsEZkVBI5g8B24KGXFlhLV/dCWLI
   fY/g2ndHCkVPuqQsCERQSWzmhnSwi4USLrFkCmYB0SBqw1kbwcbhny7ae
   wKOJ13cMEtSJinS5hPGR939RnFco7yF8eCVksCdacCtLunKG9d0SxEvaX
   dQ7R05MnmMgtruY5zNjV+N27/xx8w7RobWyqtsRNuGoaeVdt9cOBwOKRI
   UXaxzlglSabdBknONTvm6du9+W/HnLXt/Mtdy6hkeUaSO06tnB9IQPKVi
   Q==;
X-CSE-ConnectionGUID: 6cfLxsD4RqaRNmj4YHpDZQ==
X-CSE-MsgGUID: M3B2Ij1JRySb6JRhTjlkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="88317011"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="88317011"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:06:12 -0700
X-CSE-ConnectionGUID: YH4oBGWJQqqT+QHdGcp/Qg==
X-CSE-MsgGUID: ptVqLTR5RPqOTlQnX2JkLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186802401"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:06:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 12:06:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 12:06:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 12:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GujNLLxaEW06jje9fbK6/wM+ulcUEAxJrtHOBtjw4eSh+OCbI7Fb8YtnfR5YKSN+/LWmXK/JXH7w5j8/akaQwarMA/CCPiLeBXon3HxhC/GOUxVDOmHd+ihF9wcka9U+PWTbEr2oryJSUCXe6oM4GbBzd6s6sVSGrijZ/T3CU+kPb6PTFiPfJXUfqwWp7qO6n9u7BGZdh0dFp781JY+MqecQ6A0tJgQp37gz/MihjrOA1vWHfHjyF0A3GsaCLYUEKvMye63LYh4BeqUvpK+ZVPH8HaYOxFY4igl+F6MATZ7nxFX1zGZb9pK5e1k65fSrDEmY4CWFtrDYsIB3MQLQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BT7+A/Vz2d5j+ZxZNB4zKjDM/rn2ycdXiDLVtcYOE0=;
 b=Pa+tIPpzezgCHmY2X5pusYE8E4Ojg/c8ragjDd2jGjQEfCVoq8c7pDiWjQGINKjiWUOXwKLztMkNmIVd1Se+NQl96FGJUbQ67ujGmJqDCoeVJhhfDhlih8saKe754L9W83JVQNKmoTff6tWRE+cNvPt676PemYpaswolh+DG6D7siy9twMPElqpbPqo2XkjEhmqnA6/I8ZU7Jp8DNXUdaD58jNp20P16a/SnCksngbYdA96BVfertEX/8D61rFUw3/hROCATYufyC/oZe8yqqtj1VX6jxBf4F8x98gb5BBMWeUV7IvRgRJ6iLysVZDEHFOzcEHc8LyVwUohXwRMSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 19:06:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 19:06:08 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 16 Oct 2025 12:06:07 -0700
To: Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
Message-ID: <68f1421f4320b_2a2b1004e@dwillia2-mobl4.notmuch>
In-Reply-To: <32ca1961-5ed6-47b5-af0e-70e7e87bba96@intel.com>
References: <20251015162958.11249-1-dave.jiang@intel.com>
 <68f001e4e4a2c_2f8991001a@dwillia2-mobl4.notmuch>
 <32ca1961-5ed6-47b5-af0e-70e7e87bba96@intel.com>
Subject: Re: [PATCH v2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f85816-57a6-4137-3422-08de0ce71061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3JOQVA3NGp4SU5NV01PRVBkbVErZkdndDh0dGt4UE9GYnlHNGRlQ09sNVph?=
 =?utf-8?B?RXdPNHc2Z0JOcmRMLzNUMG82Snp3RW9XS1lZNVNJT0tWYTU0S0lqMnNCVHBX?=
 =?utf-8?B?WHhUQnRkbjJteDZKVEpFdDJCd3FrVFBUL1ZtRG14TktUaUw1YUlWRWViTG9n?=
 =?utf-8?B?ZXRmODZQL0FZSzdkU2tsV1lDL29XMVgrbEpQM09QV3RWY0tmb1Bsak1adDdq?=
 =?utf-8?B?NUpMdllvUUQ3SmliUXFwbnI3cjk2dmZJazM4ZWZhdFhWd2JaNEZaemtBZWI4?=
 =?utf-8?B?RTFSSlBUTHhVM2FGNDFXTC90WkV1M2hrTkJ6QnM3SElqamZIVVNYZWlaOFNT?=
 =?utf-8?B?dzF4WXFjVjhZR2U0My9vQ2ZEMU1rT0R4TXduQ2E5TFpsTGV1aEQwa0ZBaldQ?=
 =?utf-8?B?eGdhaHA3dDAxNE5DMEJXRHExaWFwbXBXVEk0NHVwaWdFMEQzRFJHSUE1Z0Zj?=
 =?utf-8?B?aklQZmJTcHVpcFJ2aU5xdCtHQzJGOFNpalpTQ2NERWFiZzE2OGdUOXRMTHZK?=
 =?utf-8?B?cmM2dEtvS0pxaGRtU3dFVTViQnZqc0J4OGlSYXl6cDFXNTlwM2FvdUk4QitW?=
 =?utf-8?B?dHhBVWNuWWVHQmhrVEsyVmVPVVNsRHBZWDdKd3lQU1VSQ0RRbTNINVduT0Jw?=
 =?utf-8?B?K3R6K2ZUdkRyVUwyTDNDL0dsbFVhazRiKzVvSFF6dU00S1VvaWhLWUs4Tnk4?=
 =?utf-8?B?S3ZoWExkNEp4ekw4SG1INmQwVkVsY3hNN3p6Sk40WnFKZUpxOHF4RVNvcUNP?=
 =?utf-8?B?MFlZUU9CczhsN0YwWS9ud0lwUWdtTU5zNEwwdHA3WTRyN0V5aVVvQjlxMTla?=
 =?utf-8?B?TlkyYTFGdTlZOW1YN25YaG15dEYxamRZVTJsUCtGc0dFM2Z3eWF1K0wwS01B?=
 =?utf-8?B?VXM0d0dlcUwwcFVhdFJKbDFoYUMvb3c5U3BSUWIzTUJwTUl2RFhVOStkRlZr?=
 =?utf-8?B?bE1XUWJXWXpMQWJjVngxMTJsbkpNWThuTkxycjZjMVZQLytJZFJrL3g2R1dU?=
 =?utf-8?B?aWRSdytlbVRiTkZEUElGRm1VdE0zckF2M2wzbGNaYXYwOHhrOVNucEg1MzlI?=
 =?utf-8?B?ekN6b0hMUFUrNmNyZ1J2QW1paFJGL0F5MnRFZWNDNkZlWGV4dzF4ZWV1NFRP?=
 =?utf-8?B?WVVJdE0vM28xZDJnK245MHM4UUFmaVRZNUR5bElOVFhwZkNCellhYWNkRDNp?=
 =?utf-8?B?TFBrTms4Vkx1bEk1WGFscS85NjNZTHFzdmlWa3JORGlUd1RpbitHY2VOd0Ur?=
 =?utf-8?B?RmFUWGpyUTZpbjRKOW9KSjdzVHJCRkczUEJ1dU5hNWpGUXNWRHRRQUhpRndh?=
 =?utf-8?B?eWpFS3ZKc2l0WGQ4S2pQajFFeFBQeUYwRkx3WGJtNm9NcHQwNElLUFlPdG01?=
 =?utf-8?B?RC9LbytNdG5jQXY0SzhoVFUvTktyUnlaUVo3Z2pMWmF2WHhKYitTUllEODk5?=
 =?utf-8?B?aHI3MlFTTXpySEhRdVlQeFVSOWFleFdlblNnMG1rT2NNUHZYdkhLZlVhTlpv?=
 =?utf-8?B?b0F3TlY5RXZ5dWFPQnZmR0F0K0llcDdLU3NyZUlTUnRnUmpPb3JLT0NKMDND?=
 =?utf-8?B?M3F6dXFkV3FPa2p5RTlqSXRaU2VUTHBvWWdTT2M4aEpCaFlPSURpZXY4N1Nh?=
 =?utf-8?B?SndhMTJnWDNoMHhNSFBnZmwyZDFlekJIc05TM3NrQTdQVWJPZndHVzlhbWtB?=
 =?utf-8?B?WkRWL0ZsSEE2aHJ3dDhJZnJ4elRNc2lrTHBNVXlER2h2T25iMFVGdCtQcVgz?=
 =?utf-8?B?R3ZIa0VkVkVGNjg2MkIwKys4Vk1XcXovMGRtaE4rNzBPa3VhclFkMzV4UU9o?=
 =?utf-8?B?VU1kSy90YVViRzZJQlhhZmpkc1FmOHBNc3o0OG90NUdYdFBZaVZKYkp3aVlx?=
 =?utf-8?B?SlRHc00xRkNpT2VMalplSjlVNEJYemhDc3ZPYWY1U0ZSTmRpcFUxamxXSFY1?=
 =?utf-8?Q?4rFG/iBK24aP+CdbsinHQbgSS7PstSDh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlIWFNTLzN6VWlCc0dlUHBZL2IvMHF2L0FOUjA3emgyYldqMUI0NWVoMmlD?=
 =?utf-8?B?OFd2b0VSb05sYWYwd0dpOTl1SEdXTlMrVWJQQld6SjdWdGxOWFVxaDlVc0lS?=
 =?utf-8?B?QjUrVU9zRHZCcWNXNWVybkxpSzdaRStjR2VkbjlMaE1uNUtyYnFyQk5uU28x?=
 =?utf-8?B?UGVYR0hCV2FhYWFhVUZsSk5OSFlIVW1meXNvMFp0dzVxQUVybXdQWC9OejU2?=
 =?utf-8?B?ZFY0NW1zMlNFSzJKVVpKT1UrYTRUc2k4WlZTM0hlS0dQdTRjQTJ3bFhWc3Rj?=
 =?utf-8?B?d01GbGpiSG1OUHJNMExSN2dkRVQ3UlVmdE9INVBEdGtWQ2tTOFA1TytIb3Ir?=
 =?utf-8?B?c0ZvaUdTakVsMUxpNXZqbWJjT1ZEZXJpdnM5S2NTdXhoSjNHM1BvemFSYXZz?=
 =?utf-8?B?clhNL1lhS3lIZHZoYUxCbVdGOGNsbjM5T0Q4VVZuTzNPaTRwVnpRYXNIeG94?=
 =?utf-8?B?Q1RtSGR2TmJOUTNoVG5xME11YzlJVVVTSVJscjl6c252aURqWmpTVERrVk9S?=
 =?utf-8?B?Q25CVXROZVJNcGJsYmVqRkhoTkNSSmlVSGtwTFhxMU9oRTJYVVY1UzYxWFlu?=
 =?utf-8?B?Y2lmdnhJQjNJQmRaenBuZ0trNjl6V0czVmNNN1VQbWRybUk2UHdNUlBxQVBP?=
 =?utf-8?B?SU93OWZqbFhXSjNrWm5McnBFSXZRSVlzYUNlSkVLQkpCdUR0eXZuZ25TVVhq?=
 =?utf-8?B?SmRBY0lySWhPcDYrQUZKajhQeGlUT01iSXc3UnNXdExZc3dJdTNQaDYrMVRW?=
 =?utf-8?B?aFFWUTVsbGlhQnorc1VmdDlONnpFYXZXRWh1L0twRzBsNHBhQWhzY1B3ekJW?=
 =?utf-8?B?eDlqZlB6Vklxc0djd3RJYVJFTWpqNEllVzN1L2gzcGN2aFVpc3hiZk5CVmxa?=
 =?utf-8?B?RHVKRS8wWmdJQnpxNFhvVHNXU3JvZjYvaDBXL1ovR0dzUTYzdVZuWDN5VDJi?=
 =?utf-8?B?cXdsL2krVk84QXRVdStHaGdFRkRUTTRqdG9lb1RrYnYvbHQ5OGpBTHROM1Va?=
 =?utf-8?B?aTNxYlUvWHdyZ004QisyZm9LUE1DL05TV3pyWEt3K0xyQmRsS1RuaFNrZWNk?=
 =?utf-8?B?WjFrcXlNS0hLbVBJb2k3alhVOFhScHNwK0NheTNRazFSMXlZbDQ0WFFoM3Ey?=
 =?utf-8?B?T1BKVnNoU0UxbE1EcXhlVEx0QTFyVkVXWHI3UUw2SDgvdWVIVEtmN3Rpbnl3?=
 =?utf-8?B?WDZDY0FvNGtWaFFUZzIzMmhXY05RWW5KZ0lnMVo1M2VnbWVUQ1VkRUZ1RlUv?=
 =?utf-8?B?T08vYnljWFdVTHQ2NUNacEhFOXdic3M1QmxEM21PM3R4MlZHUWdMeEhFZTA5?=
 =?utf-8?B?bEZYbmh5UkFlM1FIRWQrNUs4clpCdnUwRUpnOVB0SW0wQ1NUajdXaThWNjN0?=
 =?utf-8?B?emFaQ1ZscUJLRjVjK0p1eTQ0dHh5NnYyYkJWMEZCQWVMU3NpemI5SXA1Z1VJ?=
 =?utf-8?B?clphVU1BQUVtWjNJN1RDS0wrVDV0bVI4c3JDSkpiUHR2eHUrdEFQNkRBVllx?=
 =?utf-8?B?UUZlY254WW1EZFg5RGhUS1dlbEJqZTFPL2lnWUd1c2lQaERrb3Y3VFNjM3Z4?=
 =?utf-8?B?Ym45L21WdjY2aWc4cERYSkFmYWpvRnhVYTlnbnk2TkJvN3ZTUVc0VnFXZ3Vs?=
 =?utf-8?B?NEJKWXpDN3Q2SHM1MGV1cDhTOFBSZ2Q5T0FSMHlCV0J3MGV0NXIxejlSRXpR?=
 =?utf-8?B?T2d4MEhMYVJubUYyRjNCMFM1eldhYmVEZ1EyODh6YlpQdFBsNnZwRlBlZGEy?=
 =?utf-8?B?TjFUYTB5YWYyRDJyVTFod1pTOXRXVGtEN0l4RGNMSUFHUTBSWitVTGlsdHZi?=
 =?utf-8?B?dEEvaDJsbkFlNTNLWnpqWFJWK1pTZmNjUHZRTWwwc3IrNHN3ZGpDVCs4NSty?=
 =?utf-8?B?N1Yzb1huVTB0WUhKNy9ZSjl0dEd1UXJmNlFDdnpTWnloSnByd3VBVllWV3k4?=
 =?utf-8?B?bHJzL3ZIMGZWcUhUUVJvUTZoWFdOVHlWTElST0lzb1lmS0ZSWlJjcXlENFR1?=
 =?utf-8?B?VmxBd0lQZUlJWDBPQ095WHE4V0x5R1gyTVBlNVRaenhxMWZjQm9uU0E0TE14?=
 =?utf-8?B?OXFsaFJoTmhCNkIzZDZkaHEraWxlVkQzVjI0Ukt4dGhJNkgzZXZsQnB4S3Yx?=
 =?utf-8?B?VC9HWk8xMlVhanV6WXRTeW9vWkhqSlFTR3lQWlNPWDZTdStTZ24rV3U3c2xr?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f85816-57a6-4137-3422-08de0ce71061
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:06:08.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB1HTCSEFxSSRfVHoxO7tLL0Jk0LXeIk6F5FvuwzVpSYnE5My9p7B6aJuEpqRae5Bf6z77+vW0BcF6UuJ+3YwH5kCZeqoZ2JWUPtNUcdqSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 5a36d57289b4..9f9f09480765 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -867,6 +867,9 @@ static void hmat_register_target_devices(struct memory_target *target)
> >         if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> >                 return;
> >  
> > +       if (target->registered)
> > +               return;
> > +
> 
> So this still triggers the lockdep warning. I don't think it's smart
> enough to know that it gets around the issue. My changes with a new
> flag does not trigger the lockdep.

You have a case where target->registered is false in the
hmat_callback() path? How does that happen?

...and the splat is the same hmem_resource lock entanglement?

