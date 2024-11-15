Return-Path: <linux-acpi+bounces-9602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F59CF4DD
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 20:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F61F21C16
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8CE1891AA;
	Fri, 15 Nov 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6+T2J5F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66E1CF7A2;
	Fri, 15 Nov 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699032; cv=fail; b=K5OrBIiwDzNa3ZQXCrLVLRaeQ08jGMe0vlFcWdrUoXPkyw1SX+3iHGE8wcNUOy/8acw/fXM/dug9guw1h0UMZK4rlmzAwVkvfEgfFyzhRVqB0vXaH5t8fZ0+e1XA8DJ9vyHYHbLGxElIBXRXlSX+tDhRlm1lDrfAq1uGT5LL9Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699032; c=relaxed/simple;
	bh=svRPJGQiE4F9cBpiSXjUib3Of04Ol+n8stUsqkCIHrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ehtzr5Dhs563zFXDOjhCJ3F92RQPG6NCLmrD3qQPCANqiEe7YzdmVe/v0gvhCz2AzWgpGzIDmI/xyXla5DHuH8SQV8qUKaVIdF2VHSlgb6l7hgwiIdb7HnsrQLh/t51Yg+2Qhk3h6GPrk3uwq5g0GWC+p4JrNKJ+OM0aFsz3Brk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6+T2J5F; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731699031; x=1763235031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=svRPJGQiE4F9cBpiSXjUib3Of04Ol+n8stUsqkCIHrE=;
  b=L6+T2J5Fvmhaikq4ghYZJmkTArliiVRLhSJe3qyA86IDCyi0a1ktKMGp
   yd9HPOcDDqH+/rq8Kk5AoWSTPnto95svRRSOwu7mRV2XbVgQaKktXVTIg
   rE1d4P+2dE4QdgNRpkeoVAR3f2kke+AKXEPipOl7kra2dc5tG4XBOAzpt
   3+0ttl5A+OoEH4n4VKl1wQzXGMhIPBe4L7Aw9A+D5PZW6Vc0xuUjCq0NG
   U4sQPL0/B8JG4pROy6gqu0jVupaqxc6CbqnzCoDK9eJuLL5sv1Y98dE25
   A6Que6JvCwfWhTeJH1Rn5FKXKhrllx1MgJinNcaifz+3Ban02ojkIELwA
   Q==;
X-CSE-ConnectionGUID: KFjpECqIQeewqROebV9oMA==
X-CSE-MsgGUID: 3XQp0QRAQgu81tAOEHt4dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31874470"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31874470"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 11:30:30 -0800
X-CSE-ConnectionGUID: yACZ8TLQSB+1Cym1r9LvYw==
X-CSE-MsgGUID: BfwHa3eES1ayt0f/kM/csA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="119490377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 11:30:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 11:30:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 11:30:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 11:30:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AivUA+yQKuQkSeO0HiypbqmyiBZirtyu5OXzMBvotdWCZIUrZBNcHJG49Toz1+rdUy36GfiAP+FdmpPudNWVrUYDkAOLSyvoxwGSaJTX2IUxuoqOutNbx+s1ENeoMswYkFhJUvOI+YNDo4uAI7t2dNtrY1QIM2ttnMTcfZjTcNEbTWR5+GKz/Axir4zjqirl+JdH9vwV3LCn0L6HQkSlr64I8nJEgrSlwQiCX4sBsRSbzFA1pd7UHsCBZdWWMa3H31GOidJJRrhFqFCIFd3nqCRdBbYxPrqblpjQ5bPT/uDqbM0IFrG6UEGE9YBjiFpaTaQEvq64kpCnFefb/N+ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgyUXeYP/vAUswEVStWdIRyk55ilu5Jwsv0pVicRZ6k=;
 b=IiKMkDSajmXgTh7nEuAAwm3m/Pb2R10daKMDh5QqFaLJbc19FFw7lUEsGLRQGF+Be85teDWQpma9vIG1v0CXqDHtDp0kh5lFy/5XN0BGlkW4lkKv0xi0SHIwiLz4qdnuWJ9a3dqNeRfL+9yJ5q9751nNQLz12uUMoIY0C5Qe4bRvmjTPWgwaKwLzhPlj0Kb3fEjNP6Yrpi/nGUqdCSN1KjE9aQkQkrR903TFZpZmUBoO33mxcAXOQ5YcsKKdJYh1RBqGhtDhKo/ONrDun4KElLBdC0K3jZyUXLCCJoB1E5cG/8TaVN0VVzswYnMVEW3Y7KkgPLMBJsqT1qhL5LNDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 19:30:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:30:25 +0000
Date: Fri, 15 Nov 2024 13:30:20 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Suraj Sonawane <surajsonawane0215@gmail.com>,
	<syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <6737a14cdd16b_29946a2944e@iweiny-mobl.notmuch>
References: <20241115164223.20854-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115164223.20854-1-surajsonawane0215@gmail.com>
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cd0a78-31d9-4655-970c-08dd05abf480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e2z24+BdWBoV7m39Zvyg/PQt7poENrsf7C6qFhVY2xbAmQp1ht2fHamsW/nb?=
 =?us-ascii?Q?GNUE5+zPUre0Vc5L8zJmLgQMH+foBNqgEOS5PGR4DHWgove6j9A96rmPUbpl?=
 =?us-ascii?Q?lBY1c5ddPdAieSFFXj/f24PjotlFg3BhioJQEPW3l1ZPouyfvkgCmljI+LQs?=
 =?us-ascii?Q?Ztl0ml5zMPMlaKuR03FRqFxd93lpeE07xWkHKBecXPhnaWM4L6nCv/lIYIl6?=
 =?us-ascii?Q?U6H/aDdyoOkHaSzPPTAWLubQbW5XVBF7tz1u4/jU4Hj5CPEdbGCu2hztFMxY?=
 =?us-ascii?Q?4gc9Mirk+ntv3jFfV9hwl/4flNhmvzbP++p3823WcNz+B3tJIc+qGDx3WU5S?=
 =?us-ascii?Q?QWXWe5CCMNdN6wAbfUXby1sN/C6GOSX23spkw5owbYTLukC1UqNwCVQxXjPq?=
 =?us-ascii?Q?bxykNFSzItAgf7lMfttTjfryWKA6puqUqhCtkO92FfXuKZLEtj23AK8uZBCo?=
 =?us-ascii?Q?raKTwqkLAZGb8Mau58UyKOFWOJaQYdd88zzZ7JYQs2BZoAM0UdMrlIZG7qC5?=
 =?us-ascii?Q?qCgRFuFD5DK7ZxUJoJ0Mx7QMZiY0mTWPOFT74mKCeSqk6sfxkn4cpntrYePC?=
 =?us-ascii?Q?mrg1TuVHIj9ENgmIvemlmVXRMzYhf8YiLjCtvq55ILLmSNzYjEEPoYzh5SjG?=
 =?us-ascii?Q?N5QcL/MWT/jUpg0as/0/rPDiY3oqkEKtX0chCPudQLm6m+9Cyb13wp/RNhIm?=
 =?us-ascii?Q?dNU0w3BL16QIP4Ndem33hRdJyHlTkS/Pz7C2umjGKLrEvgejNZUjoGOTTeSF?=
 =?us-ascii?Q?1KYvepwAhRTsWvWYdyEcZxk7L85ywLUhcIl1EZCRz7HkwcWa1t/5Pqh1hxzA?=
 =?us-ascii?Q?3x+xkIY+A8PlRP+xAMJOP6vj8eOf5ZQs44v8MYRPhKycqCZPZKdiTrZbYe4b?=
 =?us-ascii?Q?EKy1Dhrc+tuiDJaMcUzxdLnaXKUae2kBSb0OYoMP9OSDV6FP+6BFdRue1rgc?=
 =?us-ascii?Q?mbvPNU9Rbu6BqRghacBO8oFu+rAkJOEEE6jfl0JBKEBkqO8sARBfPOeHtGP9?=
 =?us-ascii?Q?98Y2ME2fVoco1Sx8rcaJEH8dJNA3NBzKI/ICj9Z6jJHSRHHpUKZkF0eNBLmj?=
 =?us-ascii?Q?nznIgArQBAKwayeAITEJkDtcM4GIutYbQQ84PtYISPY1aMZt7ADcrqAT79ho?=
 =?us-ascii?Q?RCcuzmIwpkQPo2B5Mt9cK1au5L28+/r6DZXf6+wvfLr8/OfnnKlrXdW6Oho6?=
 =?us-ascii?Q?TMmBG6K0MbZ57oWUXNUubKuZrA4ffjvNdPpx+lJg/3AxmnFEe+xlCQYDJsPE?=
 =?us-ascii?Q?uN5WCp/8hYzGWP9JlLZDR8c/v/UffRk8lktEAHpMGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9Y3bSPKBIb7R9OGTxcZ2zrlzfYDKDkPtv6Hj6Gc2OQJQvdbcHIn98sWB4ci?=
 =?us-ascii?Q?UU/SiK14mtwsOwqQuPjYnBaaWxNYE6JxuNdXRwEhXXczhrW6dDqk6qhqpkPd?=
 =?us-ascii?Q?CBxE8xsNQAoUE+Ayb47xH46cDzVexRB1mabPu2T+q4E7c11jHfwAJblPhQa6?=
 =?us-ascii?Q?3/MbDjYoUhi2KhXpwms6Zyr3YYVIx0gNeAu+o/nltR9xlpudolKz+rsKRay7?=
 =?us-ascii?Q?tImOJlIBKKFS6/lvrufi4zj0tynlNBVS4YJVAhe7hiO5Q4cmbtnMj1JsN917?=
 =?us-ascii?Q?hkg79uagFurodH4v+FWLwGH1uA6BBD5P9qzBkrIl2f2kdPVpM3uv4gBXzkqb?=
 =?us-ascii?Q?oTMcgCE/KeKmhVkS+iMpNosD35M3D4WeETWpkrlIuItLP07OrmIB3SNg6fVc?=
 =?us-ascii?Q?dMiU8F/zTM2QGz2LbndU2T46QOLtzVqcbEyo2z55/r/wY3Gpw7mm+12/YiyY?=
 =?us-ascii?Q?7SQKU32OyTyIkTUSjsoGfrsj32JSeB6LfxDn8EYIut7RQ3V4t2PDmmPMqEHK?=
 =?us-ascii?Q?hgv4+X/OOEnigv05Mt1msDy9hyBbTa68k6GLVqppW27mKJGb0HiXhEgt1fdW?=
 =?us-ascii?Q?PVjeHka6l44pl4sa+r0pGEI+/R3qGItNYEbp4PjykcUyXo+n4shSe/UfyZ7a?=
 =?us-ascii?Q?9eLx4TJiOAX8gDk497Fdyg5baWHWCB8F7pnJV57sNT0fbzMVwAZrcySzskEr?=
 =?us-ascii?Q?CgP4HZwRof87u5bkaKIdfLnx341D4dE9jKvAHSMMT67abLQLyTf6PlcHfzhN?=
 =?us-ascii?Q?Ge2fvUdWQv8b9a2pbkN2Wk1qRzrBSkllEi7sANQDIelJezT95axLKO3Xocxf?=
 =?us-ascii?Q?KPKIEpRe5+1Tkkeh+MmY4Atf62l06hUm8CuuC1L9Vy7OX8C7w1bPDVOtZEFH?=
 =?us-ascii?Q?BNgc2w6+1CScmf5mTOHTDa+qszvAwKLLoMIpUmHRvwtWnqVOK2cEBakt+WKy?=
 =?us-ascii?Q?SVdeWPtwsYTR9np0qLa+j7c6Bk8Fp8f8edxMYT0KflGfPiQ/QMEUK5gS3nXu?=
 =?us-ascii?Q?HTHdDKOWRh4SJ3YGfKxu7Q3lAJNRjXNh4Dc6kdTBtHl5aJnnQKtV0cAeQfmz?=
 =?us-ascii?Q?5J1jGM7ZtLpw3CCRKYLuUWYCVAWbcCt4ukZImEfJPwRIYnxR6P0htkWa+ffz?=
 =?us-ascii?Q?M5xehrzwg43XYXT9ZgZ5eWOUIN17kV6BoNK+tdvMkpBp8G4V2/ZH3vfmeLuB?=
 =?us-ascii?Q?H5cMIt3B0aVPLOgf5XIIrsMO6LgdlS/XYpuPmeqvtE+Xpp9kVCK6tXXpLj/L?=
 =?us-ascii?Q?eNWs6Sm8PyiSdGmf9Bty/Ua2Aw8FAS6cYIkN9c9iqp5Q4GUMZeas3Bp+EvLI?=
 =?us-ascii?Q?oxHHMGySd1puyvUw8ENvYCcYLRGPoHKavGxaqb1Q67th68Yce9aYDAw7uNNq?=
 =?us-ascii?Q?ltL+FscTu8WbqyiopbrgjLLRo/+br4Qf+JwR1Ucqh24AniG+Qy6/4UrDm/aG?=
 =?us-ascii?Q?HHt+9Y0ibVyNl/Qit6S2LK9Nmf5xc97borx07/+eYaKbv3FFvwH+FVEVuFpv?=
 =?us-ascii?Q?JMgsJTBrxKSQZZrXCxXVySb1NgaiSn5jatscwGO/SSywWk6KudcTEDzMwASa?=
 =?us-ascii?Q?KqzvnlktDvkUcMPogmaos7FYhyw+pxVN3hNSN/pM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cd0a78-31d9-4655-970c-08dd05abf480
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:30:25.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CEhDrD1ACK7yu2FwiNoktyeX2nYqT248Wc4AoX1ENFOB7U8u80y4fpT6UlppFIqmjqUencM8sKBQO+XkbqiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com

Suraj Sonawane wrote:
> Fix an issue detected by syzbot with KASAN:
> 
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
> core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> 
> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
> array is accessed without verifying that call_pkg points to a buffer
> that is appropriately sized as a struct nd_cmd_pkg. This can lead
> to out-of-bounds access and undefined behavior if the buffer does not
> have sufficient space.
> 
> To address this, a check was added in acpi_nfit_ctl() to ensure that
> buf is not NULL and that buf_len is less than sizeof(*call_pkg)
> before accessing it. This ensures safe access to the members of
> call_pkg, including the nd_reserved2 array.
> 
> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/ 
> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
> potential uninitialized variable usage if condition is true.
> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
> and updated the Fixes tag to reference the correct commit.
> V4: Removed the explicit cast to maintain the original code style.
> 
>  drivers/acpi/nfit/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..84d8eef2a 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -454,8 +454,15 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> -	if (cmd == ND_CMD_CALL)
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg)) {
> +			rc = -EINVAL;
> +			goto out;

This goto is wrong.  This will result in ACPI_FREE() being called on an
undefined out_obj.

This should be:
			return -EINVAL;

Ira

> +		}
> +
>  		call_pkg = buf;
> +	}
> +
>  	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>  	if (func < 0)
>  		return func;
> -- 
> 2.34.1
> 

