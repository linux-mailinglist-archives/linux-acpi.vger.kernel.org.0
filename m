Return-Path: <linux-acpi+bounces-9512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3709C656A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 00:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB07B27D1B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721FC219E4D;
	Tue, 12 Nov 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+n0JFgU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB6204930;
	Tue, 12 Nov 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447260; cv=fail; b=SKeMWlBbnhBSBX3ZnRjsCo/Xq2SV9Crrz8fulJ4v0Me//3Vzz92/AXk5vhsv3G1w82pwnNBshEQHpa8t9p9siefWfwwzT/70lN07F7rzkHOPLvZ76J6rQ3oqlFGLiIvyJItDpjMTwIqYr/HBhDzZSsbFLSBi7DNr9osXx2jV3rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447260; c=relaxed/simple;
	bh=oH3spxb7/LLfXtVp0vgyEyQtJcdbPiHW2zeVy7hVBmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCnePMBhvigJZS7t3Ayf0LVguzRZ5NoGRzNMvBFoG8d9PasDRPzY6D0IEj6NMcc5SaDtWATpT0YGlIEBImnUcWvuQER9nQ2KmXfzvAA9dSzewvN3Yzp8N0Mh8vJdITxAL691Jr28URXjdEqEgzkxbHpKctawRb9USpxZHsS61c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+n0JFgU; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731447258; x=1762983258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oH3spxb7/LLfXtVp0vgyEyQtJcdbPiHW2zeVy7hVBmc=;
  b=T+n0JFgUhKarFTVi61qIoff2af1RPc0715cDsXb1f7fIwAhz1gUU+D4z
   x7eyH6p+8VzOqB55V7CSR/T+rMxszForPXfHW3pKyHhbhT03jpiggX1ai
   zpbZZOOcm5kS3p4+fMlttFoBA6JqP3ionhozv8QZM6gOAk1sy+v+4VEtV
   M5ZgqZtBXX6/+XaOJR8aahAexjt50C1QAGVG/YjNSvotd8SLsNNpzLXeX
   +ourT0nf3j4SfbSJaToiUhZgYFPl2XxCrgC923x2pR+btjIA2dCbIvXBx
   ma3oxfwuVbXHILU2aSiUEFQwFN7lGO9OXQ8uHX15+NYS8RucsGTs4tvw3
   w==;
X-CSE-ConnectionGUID: OltYVkatScmfjxN46TiHjg==
X-CSE-MsgGUID: i/grKZECSqWDxsnBLe+CTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31188151"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="31188151"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 13:34:17 -0800
X-CSE-ConnectionGUID: 35L9srsnQxmBaXR5BF8Aiw==
X-CSE-MsgGUID: GcSN6dzGQyC2O8eim8dPjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="118599751"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 13:34:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 13:34:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 13:34:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 13:34:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp019wdED+ixfBUj4K3Wp2YR8tvgdd4r05xHEf0+9CaUtEa20dE8y8azB5/vmCSRl4uE8brbr80bN6BIFYPkEp6Zl3u72AWw6VgFy8d/WbQeua4SniNGyMVNlNdwiBEagAuoi2HUZTwUevkx7h3f8S03AdrEUzCjLnRz6TGSNcXcSAXzv7uWZlAp6CQT+ojlhxzH8BtXre44pg0Ynd534keFKJh6OxxCa734kfVwZyZtI+D9J5/zWkLPcWg8uv6NoAlFXWO5/ViDqFRkiLtjua8/jH7kY+jfJrU2NPwDYL9ZYi+Tvo93QtA+ek1rlmI6GEGOTF0ULuXhyqTnemEa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iiYSVgQs4muyvGX1Ld1ZkvGEAwwt/xYq9/I0VBTFSQ=;
 b=qcXaYU637gw1FlMpmGSjm/Lq+30uU+fi3EUlQoqIvSqXyvgcDbf+ow+MEot3VJtnemXJ6aHcn32XElc7Jn4PsakuxEtqOVFoSzvFistkaH0chu/0URZRt6gtPYcLSoIBI3+NcrINEVO1rikGCB8Xs0kQGmkSRUMf2spjshm/p//xiYNI6t+OELQkbzPeRWmRUnFzRmR+gABQNlQHqTcBvBTfcg680LKRdMf8w9eW3yyOfN2LBurhNYtnVvRsoZcYHt9rgAZWdh67TEbOOcT+xXjGY8HMCJnsH3TW7xPa53bNPsGFm+dxaQYDI7wHvVrN4sQEABKEn8oOBFSkhpzpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 21:34:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 21:34:12 +0000
Date: Tue, 12 Nov 2024 13:34:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <linux-cxl@vger.kernel.org>, <kernel-team@meta.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <Terry.Bowman@amd.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <alison.schofield@intel.com>, <gourry@gourry.net>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>
Subject: Re: [PATCH v6 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-3-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106155847.7985-3-gourry@gourry.net>
X-ClientProxiedBy: MW2PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:302:1::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: bc73152b-ec77-46d2-fbe2-08dd0361c019
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m1Tp/Jd+k8FndzWa0IaZXsUyTh2+P5vU/UjqKwGl7VnDJEABji4xm9ZPsq8M?=
 =?us-ascii?Q?IvMLgQMqDh1TByVXrQHR1kgK4Xi+YbzWXW9wcmUhQVHw53ESFOW6yLEdlkxN?=
 =?us-ascii?Q?QyS4EHFofeJZzHX/vzP0E3rAYajCJOQH6QuqNs5evuXHKGyIzKEiaaZztU+h?=
 =?us-ascii?Q?dj26uFQLABanN9+XHd6Kd/xZkxZyDJan4pN6wwAbqksWd8NhB5OaiJgzVHwL?=
 =?us-ascii?Q?tR/GuQFP5P5P6eELmVI+xU65oGASQzGDJ+i/xrp3Q1z4WfTatEA7fsU3ZMOg?=
 =?us-ascii?Q?8iEiZkM8MTHQ1w5f1wyLjHkSrvQrz+e9uNR9kYoVRN+5o2L68fsK4nkPhIsb?=
 =?us-ascii?Q?5v2YVIfEo58LtN70/4TeeiUjYhJN2mZHKecMZtIUcEWFVKvevS78lvg30zH9?=
 =?us-ascii?Q?zsVZvMboq9jqy9HRVGE3au2x/lovpcfl1Bcpjkx6jIPMSt5bbEldUSUhl6WQ?=
 =?us-ascii?Q?/PF/btSLth2H4uLt+MxiUAr34jX3KL4YlHDwVA7cuAyNueBzMaf1u1q8jfBI?=
 =?us-ascii?Q?/NTINf6dVMKYs9IG4J1mwQaj7hrE00hWxquXoTODyCofGTCEBZKKfUPBh66A?=
 =?us-ascii?Q?73VrK3kjzIadG/dee2hIxtOHCchB5QoREkcU1W6cSZiyreOVN+UYyrNyePCz?=
 =?us-ascii?Q?Uu1I96PxrHOgPf5IkvTHVgAu83xN5yDW6eisw6RzdqsTkRVlgBQuRGRFBptl?=
 =?us-ascii?Q?7/hFTo1REYc9TC4qCdrRTBB0gE+I/c38kBSIRnxT1JqGZyUoHWSQNB9+R7VO?=
 =?us-ascii?Q?0DbwmAAHbggUoSWQjU6FWZc+wZ+g929Lhxc6zcbbqpFBZ+1u3HV5w2wSXjKh?=
 =?us-ascii?Q?+/4PJeXrLlLgvrihtU/JAJk2qiiYkZEgrCWmZAp3oMJQidrUVCVXyNrD/wIn?=
 =?us-ascii?Q?FezVPPYJNKH7X4e/2zuOLcZP6zVo2XX4fHqZlJsQxklwOeD3PBwht2a1ZPZD?=
 =?us-ascii?Q?zNq57LpLx9PzXM0faQKlU/FVQ09QQgsz63oqfsFdPkVDH40bVv9L3A9R2BDj?=
 =?us-ascii?Q?lVfSzlEANmcSZtMXjBCI3r6tmYU7Pfw0fYlWshq4ggQr6XU8Zn1TEJJgBCZE?=
 =?us-ascii?Q?jU5/Hrtbw372ikkhN69wxgBT22Kg4Wkpn53XFI1/BZ6BPZzICpotz/A+nbCz?=
 =?us-ascii?Q?HF/W3w/60JD2Zkx437PEmdEqdUtgwj508+TLnTy6WLZHjZKuGkJZykScN7p1?=
 =?us-ascii?Q?mCsi+XE/MuA+bIkTkGrTCEsomO4j+yv4Be1iud0tF55ywiuhb/JJ128FfOGH?=
 =?us-ascii?Q?R8bH6ZOC+n7s3nscMHcHbw3UhOdSpr/9+BHpkemKyrAtHtW0XRfZvyhAsK6a?=
 =?us-ascii?Q?8oZwL3SoesmFnGlyVoCyzfda?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E7oKBS0a144WraZ8U8ewPu1EKnV29DkNX8VGqwNx9iIOU+HF0aDVbQPqg6Fj?=
 =?us-ascii?Q?Xhi4AsaTrdZmte0SO8MOtMrsP/byowzf7TRx8VQAK+g7piNfksZ+gDTfim1m?=
 =?us-ascii?Q?VA7ZLKhlv2aqk7Zvh2s9SmYwaRnDIPMiL8sfkuL8y9WLR7C7SyqEfmsN1PIV?=
 =?us-ascii?Q?1sc0hu0A1XLm43bV0f3aihTUpc/FEU9HgiiXN4LSoA/BBlM4u+4hHnxJwdKT?=
 =?us-ascii?Q?008OovCmnldSPkMX82W0jb2DbdSrA0PR76y3waBOuIQ+p139JrvHio9+rFGv?=
 =?us-ascii?Q?lnmm0TOJSkGpMe6E+/RDzuK/FAHMEsIxzl2idsgyAplBOzBpvH6opsdGvLu5?=
 =?us-ascii?Q?8ykhsz7+lsvPQ54VC6eI/4AqpU41+g3vF86fCUTNvHdPFbtFUL9sCDqLF45d?=
 =?us-ascii?Q?bbiwd9TL+D/Xw7JvrrbfrvkHPM46BsCTM4X95kmJGZVOwbPklkVPCCioJOI3?=
 =?us-ascii?Q?DhT/QlxQUKsg3fbSfmxSddm5DFQ8SyqCNzH6CtQcCtBWM/Xg9gZIoiD9Jq6P?=
 =?us-ascii?Q?xpVbMO32oBkxJk4/coaENezcZmaP0bTqNhWnu3mjhQ7ikgRD/b8VYzprIWS7?=
 =?us-ascii?Q?bR/dj4HVRrOfwR/JHlkr63bMCsXoCGhrM+aKo/SYMOQYBxwacxF+mTIzMORr?=
 =?us-ascii?Q?4+Pzi5YPwDIwCPcS3edQBTJwh/WRighH0S4rEO7bLbojj6fp9qll7TnLaBO1?=
 =?us-ascii?Q?w4NvxmuN+8iR3fMfDxndFma6tIDGwUvE1GTn9hZIMFvDRhyHDUAB0AfCttK7?=
 =?us-ascii?Q?FP1U1vjFn3TeU+J1H9o9amuGqV1Nsrk2bw8es5BARzdxIJuJZEbfGZpKmsAX?=
 =?us-ascii?Q?XqG2YlH+V+hQVxzX7fclRL8rQ4f6lRTNT/6Zn08v0tR5iPyg68hU3DaQyzoI?=
 =?us-ascii?Q?wMjF633ps0nMJgHTHossBthT/EoYz6sVJbg/TzIGui/IBXpf5KGvFJW2t3ao?=
 =?us-ascii?Q?6qYql2JA3FqXMZlsFK4UZZa3fkyU8lTeM5TgX5n3IxSdM0Y+9wMRkcn2LYIY?=
 =?us-ascii?Q?DKgPXidzgRPfPtuAWWPzvYjvLC/AYoldpb2CZ6c/LflyIL8RafcUVKxAqVWw?=
 =?us-ascii?Q?vi1aQ86BmGspgKoksZGcYuoxnxZlfbB/itTkM3Kae1R8B5dY45yCMYc1Kxih?=
 =?us-ascii?Q?iAcKsmnwryDjfBk52BF2ikXNprylpR42kexqtqCRBBiAIDWJfmk/kIve4C9N?=
 =?us-ascii?Q?ahi27O0SHbj4gTlLwEZehu/+30CQRlfDGqwBfweleTSxUa/96mQhwLh04FO7?=
 =?us-ascii?Q?4/QqSIrOBRIH3jNe9IXGbIe7CzLRbBm6/3mIFADwXkPp2T8CF85gX9N8baXU?=
 =?us-ascii?Q?KJpzjFljbyR9Nh0dpyvMYV86Y+uIhtzc6TR5ZxICDDDx52d7gvLMavZj8Jy9?=
 =?us-ascii?Q?02wJirIrzIeo1nZxeHdPRebdE+Gk+SjfJUa71Tp0M1g6zQUgNr2wZhm5BJ3M?=
 =?us-ascii?Q?hCcXdD2xY/jMlub30Y01iHyb483r3czbamsmHMvyqMhRXYoCWUIynZ0tS3Tg?=
 =?us-ascii?Q?tQoIOygJPMRSbSck93kb1ayoMgZhSrAh/r/9+fzQUnf4BzaA1hVrMoj7nqeV?=
 =?us-ascii?Q?dtaNITiBU9zM54UDHkW4SHG6uTSeyGMRN/YCzMkeNrAbihoKMAVmxkAfb2Hd?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73152b-ec77-46d2-fbe2-08dd0361c019
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:34:12.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIc5vr1FFVECMX8Uqljx6nZ3JUlXEoXw9lHbLcFe/jTlLV+k/jnAmvMHFVgQKctz+5eul0vBfT7EIDpU+pYUzvji1zDLrcIWETcA1z5c+GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) if no hotplug advice: Max block size if system is bare-metal,
>    otherwise use end of memory alignment.
> 4) if hotplug advice: lesser of advice and end of memory alignment.

This seems like documentation that also belongs in-line in the code.
Perhaps a follow-on to add this to memory_block_advised_max_size()?
For this one:

Acked-by: Dan Williams <dan.j.williams@intel.com>

