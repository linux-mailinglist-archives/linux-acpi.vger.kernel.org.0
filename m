Return-Path: <linux-acpi+bounces-9616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4865D9D04BF
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAADD1F21DBC
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B901DA314;
	Sun, 17 Nov 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDIMlNuP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92D1D9694;
	Sun, 17 Nov 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731863353; cv=fail; b=hq6GdEeueVkoIeGBWkho8g0M3+e+Erlw9PTDA9qw9+KfBjD5ZHd6GeoZ/7uIIhwvVQ/K+g2ROdvGQ/eNVx11bMOwH3ZJyGtLg//ctvW5zauBZVfLoJdIDziBIQo98C9f3rfqa2BVqNjzDBqqwtYb3c/AINUVEleirVBxi80sf6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731863353; c=relaxed/simple;
	bh=1tb43d/iVQKvPs70uoeKUlluTN/vf3YFYUr+39ubyLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLKJcaUG5X6BQXLMu1QJK/k8fTlR1bQ7Z211cotpSoJMKANGUHmvWgrHv7mYX2CRMhOUkl/+aUPrXuWLQJe1oq+HXedrjRyaoo5k0qDExuuoi1j2lSY6FJeyUlXseIrRPPZTFdCO73/LLAqr9FqYV04/y+M/ScOubAPr+HseIjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDIMlNuP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731863351; x=1763399351;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1tb43d/iVQKvPs70uoeKUlluTN/vf3YFYUr+39ubyLQ=;
  b=nDIMlNuPsPid7ApJSjuj/q5Pq5f3FmddcAMDJgtiL19yoMnw9Jz9skdn
   jYCvs3X0JeNO8rejsSJLygrvjW4oNaExsGUjuRdjwbBaFur2O9A8Hl63e
   DCQnQfafSp7OoyCCwuCw4uPv+z7fDDzQX/Jo+ht+MeEhbHtV1lKLsA+wQ
   dp4GleVHMD5uEQK6yzzYZk0NtwwT2dt6YQ3zDNOPiT4EqMA8KmQsjT76h
   EiK1Kpr2A/lyQhaqTYTy+bXSfYoyKr6sA8FmFQtYVVOhlKe4PC7JW2FUK
   dqIQ3po59j/3gpsgNoPMESmB2Hv3V3dj2UoAphgPAwdazwGuH6WkYqdMz
   A==;
X-CSE-ConnectionGUID: gLYK/vjRReS194WHZ1+LHw==
X-CSE-MsgGUID: w2aaJOlsQDO7YbXAzMZCPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35491892"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="35491892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 09:09:11 -0800
X-CSE-ConnectionGUID: D4Fh0l1uQ5+2eAB8Psx9ug==
X-CSE-MsgGUID: ELbNUpLSQP2XltSCvU4ycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89019719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2024 09:09:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 17 Nov 2024 09:09:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 17 Nov 2024 09:09:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 17 Nov 2024 09:09:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hncrlUBOPMDutpeiwmDLusSi1zh0+TPwTyh9R6Zh4qN7o5dmfN36naUxyuk7LcnSGEACra1THEMgcUTcNk9pjipfZYA2E137NcKyjtouXz3SkqFz18/9f547D5ZIqNxelMikIGqjC4kdOdNT8wxjxnGPZq6SjQwJZdSg8ljWTaOhKe+eGZZjJmaLOpDe09MlmGrtzDhMvO7eZlkS6bRlqb/+an+TCEzYStUyXR6Q8Yel2BHPi9eQM9oZnaziZUG6g/Eb+H56BrGAP5wUM5bASCbizjCEB6mRkyBWlbbg8rucFonokXGFlsi85R9PqkJGTuSuLjyMHde0yVnYz/ynSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8yWoEc+fXlSWXwpmmvVrjPuRZTB1LRY8INYTeq7r8o=;
 b=kiD/sp5wuXeEodqLU6B50XjNuDNEVH/JJc4hLbedCOLVOkT65+nYzAlJRvahwpxn+2I7lzI3qfKZQXrFDdpVrSmerntXWxPb002F3bW/BiPwBHrWuvVLcZ0fmRlypcDw06rzaq0HLC0KaLeHs8Xmc/JaaMell4tYBkSuRk4/Awc9tGKazq4TCQoCT7QagkLi2LKZrqOAPnYdAknUwiJfTSlEFQDT1UWzab/9bBExYjXEUVonUrsqsCaPP5IrAL2T7gCUvAfM0S5fg2oS28wRYJQfIKL4rRCoaHdPm3O9Tdi3Fl0zBqWPXe5O6YPwcte9xQuxKOvglI1Z4qYQEm1HyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.21; Sun, 17 Nov 2024 17:09:06 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%2]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 17:09:06 +0000
Date: Sun, 17 Nov 2024 11:09:02 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>, <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <rafael@kernel.org>,
	<syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>,
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v5] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <673a232e4bd9_29b0ab294a2@iweiny-mobl.notmuch>
References: <20241116114027.19303-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241116114027.19303-1-surajsonawane0215@gmail.com>
X-ClientProxiedBy: MW2PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:302:1::33) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4c83ff-2daa-46af-7b74-08dd072a8b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6TGnmCcUPDY8oLZh1rqHmCaMUD4QcuTG4N17D8EjUFmuaveV6yR6Zfd0MTx?=
 =?us-ascii?Q?x+Ry165exB33o3MGBF3C6pYX0DoGBlX7ieGSscesG0SbQXw01cCEbX7NAn+1?=
 =?us-ascii?Q?/IVSt5vtSkbQsKE+lhMDJSY6P+7LNSgG5iCLHQjNVoq1upaxYL5qTQfRV5Ey?=
 =?us-ascii?Q?RtK7pY6O7qyPE9Run0CpK8NWwvoo616DZ9h//6RrgXqgY0GpsA2ps6ojlL+H?=
 =?us-ascii?Q?NxpLd7nA4atj9BnvxVHg8FNhV/XLEMd6EfeQ4gPgUZjtGw8jVGxE/N2v+N0w?=
 =?us-ascii?Q?8O0CYUpMZuMvXIgPD0AmQYTWczkpP74I4ftD8qrD11kJSxo9RLgvlbuCfPXt?=
 =?us-ascii?Q?EksxNV9pQc9C4m6Zaclf4L9c1CwrSzz/qvtjx5NbYWHKEMIevLTRK8WSpwBq?=
 =?us-ascii?Q?+liu/hIQ37ZiYZJiGzctewOFtHibid0Zdz6RlFa/iD2Wwchez77zJyWmwQRc?=
 =?us-ascii?Q?XZnImKtmb8ZWr9OmXZ/u5RicFLQiIwFfwg48/SG3YnC6FY3TLMlLjFlAzXG6?=
 =?us-ascii?Q?59w7vBu3fomMVOL5b5Bm+uukDlnZEhmNPIY9s3CarLOTClDuzqaQd0crSYtx?=
 =?us-ascii?Q?+G4tw8wCEg/k339bIJWq2j21COeIOFd+N4nE/YzRe9EhWDM4gq8IWjSjx1jA?=
 =?us-ascii?Q?VdMHnk8DN0ntfkeFk5W/+8xcNHTUQirV4heff2fyPyDSuxfc09EqfVLZ8q4Q?=
 =?us-ascii?Q?pujEIB7euotXDwX5R7UQK3oVu4uHtMga+0fKK96tq9h7J4+pSOTtklJWXMQM?=
 =?us-ascii?Q?KT+uM4I8YSQP1nkulqSJtmBgVOZZ7n8i7T2lkUt9rcHO6WUI0sRjm0Gd0grq?=
 =?us-ascii?Q?ajhRHJlZ81Cx+9iPdIvpHuPfZVu78jiWmG1fLtAzqwPCBnFnMx16m7PvA9gU?=
 =?us-ascii?Q?ltbsQYOvPzE4daPWbZcMTg7Vm32IfIusSsC9+jE3TL+Mf7mts3DwJlPUX3eP?=
 =?us-ascii?Q?PIERCeiuyFI1uV0IOJh+V7Hfa7+bpbolUNBMopZ5TTzLJ7A6LFA+WDE9VsTx?=
 =?us-ascii?Q?OoaXQ28hTLLyrxwXNzmVKAIbGPPEhNrEWnxC+k1qTDTj7YN3UOZ78pwmc0Tw?=
 =?us-ascii?Q?y60fGqvabXiAceMNg5QW6B4sO6MkYqAno1pc6lBxzU7nOpDzvqHFK9YPS2P5?=
 =?us-ascii?Q?aFyCd7at4RYt+GQgIVsz8gnPdNOu86BtZDjMZad308qeYv4Nw7xUl2tSvayi?=
 =?us-ascii?Q?xb0mk9qquTBArSp+WVw3PlRveg8WdJvb9fj5UO3slNyXOyY4EKsinYSrveFx?=
 =?us-ascii?Q?z1BrZRehIaiB1cozLh8UP4t+dXMo5XNBGxG4yJjYFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0D2PeD1tYvLflbig7IJL/kwMZ7789PHvN9C1h+6N9fEha0PZPeXhsFbxFML?=
 =?us-ascii?Q?KwS16stHbnov9o4kA0lOy1U5ususuSISCx0EDTE9mRZHc+a81OVGMOhBEVY7?=
 =?us-ascii?Q?/bBnFbhkon9hujgZ5AM1WCNQE2YWEcV++UoanBF1T4f1luhSgUGQjcpH8f/u?=
 =?us-ascii?Q?754W3r0cjuqIpEEH8EyvZipmTZO7Qm82XfrQlZ6iyRuCfeGZUUe/vtVa7NyU?=
 =?us-ascii?Q?w1oKravT2EdLCfiWqVzn8gbsciycdknoSAhvq5phbsOgHHv6OSt7NGWFqR1L?=
 =?us-ascii?Q?NaQPnrm28iXi9feNigRN/ox2skiSL8xgmAYQ9NUW0H3zQByG2R+/D5JNa1GX?=
 =?us-ascii?Q?uIpQ+Awj4KKE4B2fT9mdb6Fug1YDKzW/gvdN3rySGbLstDp/d8tM33aqWxi1?=
 =?us-ascii?Q?lkrd3/MjSchJ8YPPs4GSvEkI95aiZZ9lcn7HIuadSknd3o3TGx8cYp7cQln4?=
 =?us-ascii?Q?h1d48Y6Ump4FTUefAKEp9NpOMuyfHdPYKMgUO44YF+1gctHBm0CP1YtB/E9H?=
 =?us-ascii?Q?EqDDLrtM/Q7Ghp7UH8fag3/Z/6TJK40SAx2JUKkXFDHM1KDbL7KJWMS7kj3a?=
 =?us-ascii?Q?JKo5tXAnQRwl6QZS9WgkQMmfdBrl87p+0mYg+DDTqigWrEzdcv5Ar2GE9nQz?=
 =?us-ascii?Q?lv4fcQ53R2XdU+dfU7T8I8gvaESw88qS/NOIp0aE/CAawey1pH91vbFMohcI?=
 =?us-ascii?Q?ecancv1k/UScWfKof8Lm6h2/iS42+RLR5dCe9V+qq1818G1CRgFr9kcYahPv?=
 =?us-ascii?Q?UE6yaED/g7cC5rc/CjpEFaI9khGYqAmjE/Qxj3UQ9/tYZCqlTVSCfmLKeGqe?=
 =?us-ascii?Q?zmy4ej1/J5p1yhUBiggKrsP+vpo6drUsyyiXtZikyFVjySfEBbvp9Iq6s1Mk?=
 =?us-ascii?Q?uGCjHF1+jIINIfRwrgjioxlgJQGlx4l2XDuHDyiMtcM8/pvFRDgdwi8Bo1fJ?=
 =?us-ascii?Q?fIMgSau7AF4z18xQ6rs+Qeajb9e0PorUpxYAO1blkQdT6eVK0iEGyK1Em5Mg?=
 =?us-ascii?Q?m9I9+v83dXYNAUoCfWkqQ696PSzVqECPMia9TTyDwUiVwQaBXYb9xI11PZz6?=
 =?us-ascii?Q?DgNPElM0/mINfl0tommkEKSzTReMSiy8vT6fGij559+RtS8eocm84E0YMypq?=
 =?us-ascii?Q?ox0Q1UY5GCOHVWnPkqG8ba9uVViw3AbdBCWYC2tMgFduIqCCZDw6lEHLXfo8?=
 =?us-ascii?Q?r5vw+tMwbOdgmcTqvMZ8O+ST4Qy++zYUNLVH4bh/Iwm9gUFn13mBaJngKpjb?=
 =?us-ascii?Q?wEGNgWQpPLacScfdKWelqeRNhUPvntunHvehE+bTy1BDDzavphelsSebh5L2?=
 =?us-ascii?Q?Jp0uQXdGpaqjtFeHFRFjvYtnrTSb2SXks+ksMFaXdeuRJy1qybTqEsDJfFTa?=
 =?us-ascii?Q?7LlK8NmpV1i4uU6t+yNDfnDIxMRH4nk/jzc2FvRgmx9R0bkl31fT/VPni3PO?=
 =?us-ascii?Q?zQj+z41IqKbcmALgfaNcGiy7AYbYS203HEJ0cnaJ4xV3kqbh3V0C8DzNo85f?=
 =?us-ascii?Q?11yJi7dA8RfRO5dYVmNmIzaYVKI0SBotA5UZhwbcXB9ZRSP4HUpiJFFRzxiK?=
 =?us-ascii?Q?JbOzqneSPiVZk2cKc2YVe/8r503IasCavmidQhkc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4c83ff-2daa-46af-7b74-08dd072a8b5a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 17:09:06.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVUMINb7XaossqyiHZG9LFx1zFkjPyoyfb5r/GzKExmdRhsy3OnYVxtpz+wc2ZVCwmSioTxsWOgRyq1R1pGMhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
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
> V5: Re-Initialized `out_obj` to NULL. To prevent
> potential uninitialized variable usage if condition is true.
> 
>  drivers/acpi/nfit/core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..573ed264c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	union acpi_object in_obj, in_buf, *out_obj;
> +	union acpi_object in_obj, in_buf, *out_obj = NULL;

This is not needed...

>  	const struct nd_cmd_desc *desc = NULL;
>  	struct device *dev = acpi_desc->dev;
>  	struct nd_cmd_pkg *call_pkg = NULL;
> @@ -454,8 +454,15 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> -	if (cmd == ND_CMD_CALL)
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg)) {
> +			rc = -EINVAL;
> +			goto out;

Just return -EINVAL.

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



