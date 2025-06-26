Return-Path: <linux-acpi+bounces-14665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA789AE9355
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 02:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E836188B3D8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8676A78F3E;
	Thu, 26 Jun 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaMIDV5v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307BEEDE;
	Thu, 26 Jun 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897072; cv=fail; b=YCo9Ohq4l6iXmnmKvnlWEPaDUbIbb2G6jryVvItXUEvRUuMcAjLOIVALAoxvJSCVhGpvX7bbsfLXy/argDmegktl4dyPMLltWj0ubmwBlV8V61BgzAaAy3gCEdz3eY5g9nZ7KsyyJHzLHXTWwHP6F+CTEopTbU6BhpxLuGh7aLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897072; c=relaxed/simple;
	bh=FvpAvBZ9+D/Ch36wX9Q+HYqI/4dWt2sHYRk/cnKpWPI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=klj7oVquI1NWApI7r03j3sME9rbIWBbBquZNdSoFCiDC5zelSI+zCJbLl76Ln3YxSOQ7XtpqzobrPBkLVlH85B3ccCnu9QIaeY0KvE7ZSHAeyK53v0a16N13uxNAibLjDhP1iut44TvMOgsBuQ0fD4mzDttycxmQJB5gzU+/ucs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaMIDV5v; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750897071; x=1782433071;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FvpAvBZ9+D/Ch36wX9Q+HYqI/4dWt2sHYRk/cnKpWPI=;
  b=TaMIDV5vKbra5ld3NQFu9qaGjnJYSQnVU5UubImBtB0SRAENBAzIeSKl
   aAltacEYAYeFrl/7k0OVPjVpiX6+zwygTvHAm9LUYqP7QPzQnibWt422u
   JrB2TSZuBU96ojeEujXPDadLJ9tPSXdJDWONNZ4sUgiSeFpbgCPNVCeag
   4d0OuvoV6AhFLVSYxyoYAYiPTONhLglWElu11kezvryNM+0BVNYycYMXh
   hqDcCCsY//XmTM27FEh/iUQKXV3fVISrZujQnMNN4toCGVoICaekjBQ/H
   fwTBgkJwAiQkUV9s1Rm1BQ3Br7VIKfUA0lrUuyueAyyo0B0Ln/BTzH1p5
   g==;
X-CSE-ConnectionGUID: 7+c4BgFySXGWZohlbxPBDQ==
X-CSE-MsgGUID: BT1Vul6FTCaU5aAT0pXFtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="56969214"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="56969214"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:17:50 -0700
X-CSE-ConnectionGUID: 8l6Z16IEQaeUgsWWAwojug==
X-CSE-MsgGUID: VVPblpUqTuqBgm1GWh2iwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="151783620"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:17:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 17:17:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 17:17:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 17:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS5CbrK7wfhr2NlngGJl8gfuMvCxNyV7BF090qkDXrBxXfbxbNWicGHTfitSB/dT9JpUcZWYbLJjaDKOlLTiHo6EgiWO+QlVaVT9Iov9GZUc5mR8rr3uCtQn3rfC8LWZhwGOWWZpogR9V6UTFEXLqjlc9rjoEYr2Xd0CaF0frWkFLOKVUuo2vE2poUEZHAqMg7FiW+cTbho+PCxZ6JU5adNEYkjhJ/pIl8jUFu1Yl9trN1uvaKrnZBlgjIBXwq4J4KcyG2o/b2Wcc5XVOSfSXKFX+E3H+5vwStegIAv/mFiP4sDjDb3+u0cIDi86SlFsfp/oWEzJWc30JXplMA4JGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxQtLVou0cT2Ms7uBeg2Q+K5bH02wt2nEwEWclC8ITY=;
 b=Zv9gaZYTK31GnrGotXsFMRpsxbn0qYqOYkA4a3aQdhmiyjpqcF0g24YyIBF3Z7Bs3OGKfZf/wYhUfMP9m00h9th1ixwNww3f/mxIpMTdgq/jVKAvZn483kgs5SA0wIqvXiI0OUqxbE3Gmt+DPtNRbUY0AQStFQb2+5jO/RkfKBa+jIo8Nx8mcR36cyhqCKac/Mna54CTMeU8v+Z0Tbz6UObNna+6N0Xfq14vv9MmGYvnGRQ6zSPLkqErw85hkLuogUwaVd6zwiGQ/cYKdUY4cyzV0yMdbS+KOoyzQZsEflsNvE7CbhzuRFFnDBFEl+d++O1pomrk5NDU8GNJ57s3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 00:17:46 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 00:17:46 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 25 Jun 2025 17:17:44 -0700
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook
	<kees@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>
CC: <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <linux-hardening@vger.kernel.org>
Message-ID: <685c91a8c3ed5_1608bd10024@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aFxtOLs6Yv_uzgt4@kspp>
References: <aFxtOLs6Yv_uzgt4@kspp>
Subject: Re: [PATCH v4][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a229a5-2255-4924-242d-08ddb446e098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2h6dWp4VTR0dGxCQzFFQ3l4OW8vTHZzNDFjY1JHNlBpWGQ4anZ4eDlTZXZq?=
 =?utf-8?B?d0lSN3Z2Y2lNdXBZSUV3aEN4djBONXFsWS9CRGY4QXdlaitEZEdXcW54LzBh?=
 =?utf-8?B?RnJUOVdwYVFGOGpBaGdMR2V5NFZ2eGRPUUlXdVRHNmF2UURlVldXZVdCM3NC?=
 =?utf-8?B?bC85dGhGOWNseHlsZjUzWC9RVWt4QmtnTlNmWUk4dnhIYXUvUDVRNDRPNHQ0?=
 =?utf-8?B?QklCZkNzNUkyOUtIM2IzMW1zNGVVZUc3dzEwNUVZV2s4Wll1OFdGSUNqTHk3?=
 =?utf-8?B?akpJQjBlRmIxSE5mbE5Db25ISjVLY2xiMGFzc1VYRy9tc1pFTU1MNEEyaUpi?=
 =?utf-8?B?OGdKcUxwc1RqUUZ6Vi85Vnd5ZHJOSlRZZ1NtWWVzRmZZekRLTytMWS9jaVRa?=
 =?utf-8?B?L1pYUkRjNmo0UVROWUVCVTMvNnplclU3MzRiN1hXemVnZ0dHQTllaDlkRTVp?=
 =?utf-8?B?Rkd3bVFlUWRkKzQzbkdzN3gxZ0oyYWxrOWtTdVNuNVFTWStqcmE4QkJmQ0o0?=
 =?utf-8?B?UzVPTWpDaHBBcXR4bFNnNi80K1ZJQkxXN2NjQzZHblpnRm5LRWlFVS9Pb05k?=
 =?utf-8?B?R3Z4TEFQdXpEWjlYTEp1eE42TXhqNm83K2dKWWpVMVZoajRxSHlzMVMvblBy?=
 =?utf-8?B?QXAxbHBSQUdDa3FaVFEwTzRuVDJxNjgyTzBFQ0V3RGdmd205Uk5nblorMEI1?=
 =?utf-8?B?ZGRxMWkzQzRZS2YwSFUzK2xzS3JhMVF2K0lKOVV5N05ISjJKTzNEbG5ZbS8v?=
 =?utf-8?B?RU5hVEgzTHBTSlo5M1lNQW5nTG5WblJvbTZHWHJUSXJMb1JDWllSVUYrdFFR?=
 =?utf-8?B?M2JjR3NlZTBsdUpPL0hyQ3VkYU5UbEkyb0l3bG9GOGRVOVFFTEQycnVqWk9G?=
 =?utf-8?B?VU1taVNpSk5Ya0pvMjU5VlJ4ckk2TE1QWm52Wm5pTExTVHNwRXZSUFBIQ3NO?=
 =?utf-8?B?TjR6Q0FnY1FaQlpBZHVNUkJXZGhlUXVuUkFxaXlZdEZCVCs3a2NURmI4L0FV?=
 =?utf-8?B?VHFzcFZISFl6cmUydWFCdWJHc0dobEJQQ3JwQ0ZmR0lDbUhHVWg1d3lTLzdK?=
 =?utf-8?B?VCtGS3BDRmFyTWVTeWRLNGdvMHA5M3piTXJ0VjJKZXEyQ1EyNDhVM09tN3Fn?=
 =?utf-8?B?dUg2QTBITmltcno1VlBRaHhtaFRNUWR0SXh1azJkLzh2ejdpNFhtU3dvc3Iy?=
 =?utf-8?B?Rkw5VTdlZEF0Y0YwMHdRU0Y5MGxXM2xNMkRZaHpEYldhMXZDejA3MTRCV1Zy?=
 =?utf-8?B?aGF3NzE0UzRHa3V0QjgwNjdkR1NlbDNoNGVhc0ZCdUF3Q2VMV09oSEtUR0NX?=
 =?utf-8?B?VmtyTFQ3Nnh3V2lwSUZDdGVlY28xd1pXL0tSc3U3RUsxbkVONnNHUURyUjJ2?=
 =?utf-8?B?N1pqY0x5RDllMXpPN2t2MHRqeXNXSENGYUFRRGd6YmhhSDh0T3hlMDdQeVRh?=
 =?utf-8?B?ZlRGQldpUFd1bGJJSTVuL2FHczFMSlBqWUlldFUxc0VETlUrNktIdFZKODEw?=
 =?utf-8?B?UGY5b0tXNU43ZTUxdEJDSUx6ZzJXVGp1eEhvbW0vcEZNYW52UXBZYkVnbDhP?=
 =?utf-8?B?MVRQSVU3ZHhnU2RVMWI2RVdTSFpneW9JRGVuYmR6aWNncFNObUlEQXh1RlU0?=
 =?utf-8?B?c0g2U2x2eVdWMVpsTk1FT0M0RE1mYW9Id0ZFY0ptV29ETitqUUs5MThqK25Y?=
 =?utf-8?B?dlRlR1ZPaWE2c1hFMmo4ZWFGYzVsY0RMSlVHazZ6RzB6T0dhMXBpc2ZCekVM?=
 =?utf-8?B?cFZuY2JodnpYRVp2UCtkNFJxcUVXS1BlTVdLRXo4bUZoVVdqNUdUcFV6Y1Fa?=
 =?utf-8?B?QnFhN3c5YWl6bWlWL3VaMkRKV3B3WU1jbUhrQ2hub3FkVXBkSEVSaXJtM2Qx?=
 =?utf-8?B?aUErblN5N0RVb3IrciswYVpDZ2h5aC9OR2FCd1FyZGlyVWg1c01mQURTYU5q?=
 =?utf-8?Q?8mtAUIrHTOw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpCUjlEbTB1eW9ac3ZaYXJnMWtrelpxKzRYR0MyTDZQTTBPT0hLaDIzWFVS?=
 =?utf-8?B?LzZWNnhjY3FNZytKUkZHTTBqUGsySW9yU2UrT3kySHdkMk5xekY3aWxhRmxE?=
 =?utf-8?B?aXJ4SDAwckx4eFg0OHN5Z3dWaVlDN2t3TXJiRFd4RzB4NkwzQkVSc1p2Ujlx?=
 =?utf-8?B?VHVIU0xjZld4ckZpc3F6aVRQc1RjL2ppL1dFaHRiZlBQRTViTTRJN2FiRVdu?=
 =?utf-8?B?aGtKZ1BUY1BIZzFRbDdqWnlkVGU3anVCOHUxbm05UUJ6ZnRuM093M2RxZDBZ?=
 =?utf-8?B?T0ZoeWpIZGpTSzZ2bURWeTAxREozc0cxZ0F3dkFtTEhqUlVwQVVrSDdXdkQz?=
 =?utf-8?B?VkgzZ1ZLU3pIYlhJRVQzYy8rdzQ5aE9MSHlpbk5QTTRMcnZEK3V6ZVdrdUo2?=
 =?utf-8?B?UWFadDUvcFpYZGZscjl6d1RvWlFITW1WcVRsNW50cXVUTHNhcytnWVhvWHV2?=
 =?utf-8?B?ejVQYk5lcExaRWdhMHRmV3VzSDRnZ1BmRE1mVWRDMURIWjdKTnBnd05aZFRW?=
 =?utf-8?B?M3UrZEZFem52N1M2VjhRK2pUQjg0QlIwTFVpWVEzNnlBakh3UDE3T0hrVWJL?=
 =?utf-8?B?TGU2RDh5dktPdHZ2Si96Qzl3Z1VoWURMdW1lc3pJMHF0a2x5NkFmVDU0dHRB?=
 =?utf-8?B?bTZGbXJPNjhReXRkMjkzVS9QU2tGd01hOXJYMGs4WWo2Rk9EUFUzbE9kUWNP?=
 =?utf-8?B?Q0tKL3hhM1FJOUY0VEsrTTNoVGV1bUxBaGpibDQ1V215blpUOURrVE9nbHBV?=
 =?utf-8?B?L2pjQ01jb0V0QjQ0M3VJZDdPQnpSVk44OHgvUEljRXJPdldLUmNPWWY1b1ZW?=
 =?utf-8?B?RnlraDlDdDkrZHdCS1JjcXAyemEzc1AxU3pyWnE1YkxlOFgzRGtsREZadGUz?=
 =?utf-8?B?ZDZtRnVDZ2F6RndFUGVhbTA0MVJDWTVFaFlTVlprV3JyRkRmTmY3cll1QkM2?=
 =?utf-8?B?blRsNUJFM3pCa1k5VjdGcDZVTFpvK3FuTW04NlN5a2hXT25jYmwzODEzeExH?=
 =?utf-8?B?cXEzVFBuZ21QdEV2aTdCdDNLVUMzYjAvWE1tdVdBekU5bVBhVitkWXVlRnpu?=
 =?utf-8?B?Y1ZFaTRxM2txT1U4VkVDcXBSNXBpcU9Lb1pBMCtmV1dxQlpjNE1kN2V2NE1u?=
 =?utf-8?B?bWVOYVFxMmtBRmcxMVF3SkhtVnk4M01qeTdoWmFNWktvM2llUy9BMVFLQmxN?=
 =?utf-8?B?QnNyNXZ3c2UxRldYdDFRMDNORTExeEZxNnRkLzNsSDFDalFmcHh0ZmpvUjR0?=
 =?utf-8?B?L1FJbm43RnBYMjhpRks2NGlVcXNiVC9TWVpmajJaUnVGL0NPei9Yd2ZGNWw0?=
 =?utf-8?B?bmFqaE0rSStmd1FnUW5JOTMvdkR3WEl5WDNJWkI3WERReFV5ZjdMMUJBR1cw?=
 =?utf-8?B?SFFGVVNpcEk1QUtXRUNEZG5wMEplVUthRC9iYlRQeHE3SmRVdEFCWkRLdmds?=
 =?utf-8?B?SDllRVUyRzRjSnFISW1QZmpnUmZHV05sY2Z6SXNtN0thRUQydENjbnp0d0I5?=
 =?utf-8?B?Tk02OXg0aWI0L1RuRklGcWk5WTlqMUptc1Z1a1FlOG45U0dUWFBKdlQ4RlRh?=
 =?utf-8?B?bDIrUFREWkM4ODM0Mk9oNUVaK2lwS1ozQWJuVFJJekdpcDNjalQ4bk5sWkg4?=
 =?utf-8?B?TStEYitRZTJRMVlLSHF0cTlES1dsVFJUVHlqWEFIWHdNS2NIcHdvd1NUOWk2?=
 =?utf-8?B?YUdQelkyUG10QjNtdVdvZHl2RHhlc0VaRFFiOVYzYlJ0ZTBMK3ZEa2djWE1E?=
 =?utf-8?B?M3BLVTR6N0ZlcTBpSDkrWE1ERGdZZUY5UGhiWkw2bGcrYUk0M2wyMjVlN3ZI?=
 =?utf-8?B?aEhvZzhsWGJ1czJ5TjJBMWh6QUNxQUt5ZWI2aHdnMzIzS1BweXA5UTR4Z2ZZ?=
 =?utf-8?B?Mi9pS2orTVExaFkzelJPN3dUL3NodjBQZjBaeUxCc2wwU1BacnRxNTlVeFBS?=
 =?utf-8?B?ZkxsUGpzanlwdHpTb3ZYOHB2TC9ndHVJZHRyTUE3eGI0cU9WSjBwUHBuVWpP?=
 =?utf-8?B?dldRZ3prcXNaNlVabFoxdFJDNVppSjhaYlZpRjhUNXhWVEE0V01USGlhRnB1?=
 =?utf-8?B?WGU0dVJyTmp0ZCtHSUxtcG54cGo2YUoxakhueGNWQTFrMlgycWtlVjMwMVNI?=
 =?utf-8?B?dUlyMVZGWXZrUzR4SzlxSjlwTVNyeGpYWEJaMytPT3h1Y3pXNDZvblVYZGtk?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a229a5-2255-4924-242d-08ddb446e098
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 00:17:46.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1e4ySEHxTmv35XWtheVHIQAxeNm5pxf3UHqLMGlAw2uDbgfMv6E+R4e8hG48GjMe0H3QRDlhFY8u3ffGQ3UVc8ZJXXJ9X6vpDEhsuLseb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com

Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix a dozen instances of
> the following type of warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>

Looks like our mails crossed [1], but I rushed this testing, apologies.
This patch does cause a regression, and the conversion is not equivalent
according to pahole:

union pkg_nd_intel_bus_fw_activate {
        struct nd_cmd_pkg          pkg;                /*     0    64 */
        struct {
                u8                 _offset_to_fam[64]; /*     0    64 */
                /* --- cacheline 1 boundary (64 bytes) --- */
                struct nd_intel_bus_fw_activate cmd;   /*    64     5 */
        } __attribute__((__packed__));                 /*     0    69 */
};
struct pkg_nd_intel_bus_fw_activate2 {
        struct nd_cmd_pkg          pkg;                  /*     0    64 */

        /* XXX last struct has a flexible array */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct nd_intel_bus_fw_activate cmd;             /*    64     5 */

        /* size: 72, cachelines: 2, members: 2 */
        /* padding: 3 */
        /* flexible array members: end: 1 */
        /* last cacheline: 8 bytes */
};

Now, why the padding at the end matters for this test, I am still
trying to figure that out.

[1]: http://lore.kernel.org/685c772aa7cc1_23a2a10080@dwillia2-mobl4.notmuch

