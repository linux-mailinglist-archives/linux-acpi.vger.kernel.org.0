Return-Path: <linux-acpi+bounces-8623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375849954CB
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9915DB24FBE
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8E1E0DF7;
	Tue,  8 Oct 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXoce1Tq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE11E0DF4;
	Tue,  8 Oct 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406006; cv=fail; b=tNFGWrHzwpAtymFY6XMUiiJx1/zJT+QcIQMmWolOvRj8OTPk11vfwV22MSoEdPw+m+QNw14D01nPHKqycGZX79AtGPMzUMApSBAi74Xf8RS0JviteJYL2fPHaErHVW0gUKpfS3jWESLvJPs2fqGcRafvCLInDtDrFXMAsYDXeN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406006; c=relaxed/simple;
	bh=IMzsLgVUEnxfMO+CMbL6jzaAb6jdm9oN++2qs+jDfYU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/t7y1QeBpsM/Jr78P74omnzxh3/FZeXxLBRrY4Ybej3d3xdy09PxRypfWEAtJxYnH+k2OWV+WZWe2p1VUirbjZ5P0YSCIBvUc8wHuEXnWZJKkgoWEPD/qNwbm8TLcpFjI744p5fg5H1qxBEyPEQwUUEGQ6P5P8ymPcl6prgat8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXoce1Tq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406005; x=1759942005;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IMzsLgVUEnxfMO+CMbL6jzaAb6jdm9oN++2qs+jDfYU=;
  b=TXoce1TqIwd/6pTneLBJrNqplLdMHijZFVtuGXJc45X3I4ZiO+JhuP76
   q9y3FnPSC0LdyKkEiKG0Vfz4xH2ps0cZsq0s06KJT/wh3MHL3hsb5Wk5c
   VOHvxd0TJPuzpLYfX9eB3aGEUjiznqM7osXIn+v+QPbp2Vlu7OO+FGdQU
   zI6Z6yMdsfpq9CizHwxiEAGt3V59yTo6n6AWfb6cg8HXVFFlxsBkw2M6A
   08JMrDrOk4m3N9jBjwyLJDytMqOcyRftMFuHf5IyvX4MEHKZNz13XHfB7
   oSPhuz/gV/qyS8jtM8VaLHa/Q1VGLnbW9DHvFsjVdrwiuoPLvBVdzJiks
   Q==;
X-CSE-ConnectionGUID: owNkV+DDTJG/t01sujN4vQ==
X-CSE-MsgGUID: 9QQjkWJZRjuPzKZF7aIVkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27571364"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27571364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:46:44 -0700
X-CSE-ConnectionGUID: yO3lsndwTCmm8fqj1esZ/Q==
X-CSE-MsgGUID: vLORG07JRJKAUTw2il/8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80753566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 09:46:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 09:46:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 09:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX1lqJi7MVh+3OhHPfSGiRkseZ0o0E0AATD3615qeqIGHk0X9SWwHtjifUMlGlHqG/YdsltVAeu1tKOTdQOsW1hO80JPhdAhbyuOMEzl2pJKtYOY01yxG2DPTnW7uAg5fW3tE6qbN7boxmxmhmcP14TOxCSD3YoRkJP/BUteoaWGa01AEI8fFVc7BnrU325BRdyD1VN7zj9ykCyNgi8x5T6ZaLATwPGq5S1RXw2ONzK5rBIzIt1BAKYoRrBndzbg8/DuwA/4BK7NYcftKay8T2qqrn2x3GeXaR1j+yXJYpEaXBmuaLpQMXca3/spmoyQmg6PNEgQ1P2l6XvT+KhajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqW9V13W2wVI2jaB0iCd7g7G8Zrzmea6nkdK17zx9hU=;
 b=bLjsrtie4V8Hrwu/70P1zrH5Qf9qiTVYPMFEPcvyoyvZJb+AwZVYvZpO2+4+DOv4/qrqKk2QBcbxpm/Q8tNhaOKfQ8YeGz4OtTvgP7KKzp6s3/3a6s/bVzPaqqa91Ij99fH3ixfmBfpqcR/oRZRD0QhKX1aEIt0MRMYM7GE7rIpcQ9UVQoUXVbvFWqJZIiM9MggRibemywfVaTWy+bkukzRTOvLdfD7pLYiuSQbjujAFKzjllxVOzJrsvG2W/0uN76x60LEvyT/SXHAC469WSIqSk5KgpiRYZ+ex6BqxxC0e7GStjXDWvHzDPugp4O5W1RF6KgC0MovTojFgfRC6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 16:46:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 16:46:39 +0000
Date: Tue, 8 Oct 2024 09:46:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>, <x86@kernel.org>, <linux-mm@kvack.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<david@redhat.com>, <osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <lenb@kernel.org>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a
 smaller alignment
Message-ID: <670561ebe74b7_964fe29460@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-4-gourry@gourry.net>
 <6705489bdc79b_125a729415@iweiny-mobl.notmuch>
 <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 16043286-cafe-436a-a8c3-08dce7b8c7dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4L2NDPczAZWUD1PypkHfdQbpJKHb/EnCd/Jw5akie/+qe4aNpBvjQqqpxvsM?=
 =?us-ascii?Q?seg5KsttzSo/TUZC4MeV9gXE9NZY08mmR1tycbgj2JURKWRJ841E+jv4ceXC?=
 =?us-ascii?Q?CQ86o0UqbEbrlQpQWgSsJJGE1DOhleWyNUOAtoqMrd5wxR5EeXe17fAunvv4?=
 =?us-ascii?Q?CXg4IBW3xtcQgJokcxkk6VxR4K/TaOqK5ai+flJa/YdSubDJ4bqgqrsvjKk3?=
 =?us-ascii?Q?wbmdvq3EZdPdrGk0O1Na0G+5Dx9t0Bcpub/kMDoZtlzfOavS2rqGY4ieiVE5?=
 =?us-ascii?Q?rbwj4sV3iP/EuW5cxK0dQW2FvCbvw3pssXNPXobaKf5/K5wzFKzs/dA//Xlf?=
 =?us-ascii?Q?kdooe/OoGARw2dVi+V04m2CXi/YT623U14B6IX4tICBtqEzEcNWulz5aiKIo?=
 =?us-ascii?Q?8BTpcsjI8S46xUcGYjE6Jn1alee7f9G+KaSequ2HGET7g7qH3y+36PoQR92E?=
 =?us-ascii?Q?44wOoG6SlbCG5Xnq0rrnrViHk9+Wb8n49aTQsMA4RiZgcU/HAn9lbZVA1oOv?=
 =?us-ascii?Q?Ofa7o3wqqTV8wvA3q6y4BF70CsbNyAy0Qw7jsUsU2iCcMbg858mBwYplpHp8?=
 =?us-ascii?Q?XdpfxsYZ3pfECBKTIgxOPmRauoOeOCeXaBGxCkbsl/5cTT8v6ALVzefR4aBZ?=
 =?us-ascii?Q?4A53mONh3V0YhzbO9FCa2OCXbYNMjavgPl9lPJggVpb5jn7UiA9fk0d94/Z6?=
 =?us-ascii?Q?IaSWD0zfaHonoua1dHj1Qpp5453s2eUmRlavFFFTcLBmZdxwf7xArCXknNef?=
 =?us-ascii?Q?9JdZU8VzHz2Od7jftLojOp0bbBTliqLxNfwIzFgLym4llsEqPIFfgXKLC8Xq?=
 =?us-ascii?Q?BVHD+IYbFAubpkFEsHnYeBbwjhCX4C5Zy8r6sM3qBtqROaG258qavGLM8T1K?=
 =?us-ascii?Q?8R4Rc+vCMtTusRh9LdAnJRoSHDaPPXe6ganoEg0ub6RyPG9j1tCybZZWjAOy?=
 =?us-ascii?Q?OejuV7ZXyw7BhwP246zWyaSJEliHizOgssmdKzEa7jVCqoN3naSJwm/TB4vV?=
 =?us-ascii?Q?xCd1HdE9JdkeTJTKv7fJPt+P99bX7CTdySCGs1YLQS4co8W8MnDiQcuzUIeP?=
 =?us-ascii?Q?hqKY5IUPshBr8ERqvbh4slDMpO8hNM4gzhK536MSSKtxyWukcicQUpLNvi1V?=
 =?us-ascii?Q?74UHGmIGhA4NnOROqRZhfc+XdKiU14stNTHJlphAkLMOnG/8oBGa+LZ/PILc?=
 =?us-ascii?Q?RxcBydw1fV/vhaK017Jh9s+Sbr+TthTxA990RDYemORNvj9JOfnpK0Z/ZC5/?=
 =?us-ascii?Q?lanIaZRnG9nC4KJnBgF4/xJzGSdwnX5BDPFUhVe8Kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fas6tBvYr0wNk+BCfXrLcRwO+tPWuK+zg5MSEE9/04Jhw2o0Wqwx9zW2rHAT?=
 =?us-ascii?Q?EzoNoyaD0K9e9yLICK10K37Jf4NCMm8LIuVW3fP/phnkjkFG5vPFzuMVc7VF?=
 =?us-ascii?Q?gE+dnUNVxYIgl7TgWerIEW4S6Nz+6x/Hw+3RB4xFbhj5OjgP8XdZBLc4p/3u?=
 =?us-ascii?Q?er9FISiFkQ1nz/ezlLoVouLG/XKK68qqETet/zSjUxKIUzzilpDay2FE4Kc2?=
 =?us-ascii?Q?9LdZUtzIyneJXiQ8Fy8hdikA5qZCJlElC2EeBDDiqNSkTRBB+nG4p4VnCrRD?=
 =?us-ascii?Q?FQYVTrUAD3KNupb04rlNoySIFgfrTt4cAqTR8D57tnTtK6Qc5T68r8uRVZvP?=
 =?us-ascii?Q?XZw5CE2/dyFTSGmV8jzwrO5LcdKAUn9W4PEU8mryuF+ZSe7fmXiA10hB1FTC?=
 =?us-ascii?Q?9Vz9+SAOaYs1q/KMFfRuwu4Xx2YzuWWGRXNuxvCv+erhdTz6vU/yRo9CvdmE?=
 =?us-ascii?Q?ivrkSQqaWy82LoGRQThRMqaL7cJtaB0ve9qJr6dH4HYiHueRQBMF2okxO7Q2?=
 =?us-ascii?Q?vH/ehgKq6wJtRl7Mq31YxkuInz5MmHAqmQRQp4EilJtzTwJHy66uFk7YpUyz?=
 =?us-ascii?Q?EDokjERNH5ZeGfaywrraZyPDwvM+Sd13CXaXvkiSX4MmFBk6XTzLMG17TNIt?=
 =?us-ascii?Q?xOM8FefZgPg/A7zmRX0kmAbRUu22p8Xi5VxIwbWALP362SJy3W7Nqs8PTHIK?=
 =?us-ascii?Q?BAObyxD3duG+mjBWD8yjd3iWqMkDeEJfWrtxNy8KiVXMVeX/+BzaU429efxt?=
 =?us-ascii?Q?LVOrQheuehJUjXszL7IgtTgl5NIj/7dkdI+8a0B6c+j05LWhkKH+QgpRtbQR?=
 =?us-ascii?Q?XZwDaEoaqiLjJ5cn86+/r3o7ZWj6iuKUueHHZuIFKh/APM1iSJqjFOd7wOFV?=
 =?us-ascii?Q?lJY/BM7fTtEWqd0g2xuHACuH8LMEkQ7vZdse4iVcCVZbUSeyQzgRuRlKm7vA?=
 =?us-ascii?Q?vWNk6blEw9+LG8Fq+Q4JPdozSk1vJdpFX9pPBrBMmDmEBhGjVGR5Ug1WLrNv?=
 =?us-ascii?Q?HDJbfG2UNbIiTJCL8sDZSCQpoKNXWVfqFx9wzzBViQG78xYTHIP3WO6G1LUi?=
 =?us-ascii?Q?oFcgD5cHLh0uTxW4ub70R9sB3N9uoy5MGuDIjeWgytJ2MYJT0nbU0mA8eOIz?=
 =?us-ascii?Q?X+tK5QLdX/qytmK1DkVT8CHQkyHa9tSc01vsWQps9j3WzwhCCSZaIxkdFy+B?=
 =?us-ascii?Q?4W+Vb3PdGAkzZDl7PDZw4Ayl6VD/fx8gOU2uaE+o6XR7mJLkvTfGx+FbW2mT?=
 =?us-ascii?Q?E73UaNKpDwTGllmc6CgldexKH5gE5VQp+VmPIvvmSBn5JR3jrg5rv5lnI/fy?=
 =?us-ascii?Q?s0Q1hN9b8deAiFYQXRuBVOKm2j8V62tlZKTaYkgEEc7i9T4eW3M8dFA8RafO?=
 =?us-ascii?Q?WcbD7CxFmloS8gVC/IzOrImzfyXv/xbgmGwUPP/v97olbfMDJfIDQtCgv21x?=
 =?us-ascii?Q?Sfw4yz02fa/ElxrHebQRWj+FrwETj83RWl3CbE/bGIC5giwFMMoUQGyj/sH+?=
 =?us-ascii?Q?YZoAeBF6Bjil4SgGkDmEEwEjjU8Vg0zE3l7+HhlAWzyHVCVQdG3xsK2ASsNq?=
 =?us-ascii?Q?Tbr9oOKYNj+oXayzY/LgxrA/DBpdOV+LAubFYpKLAZWM344Y1eqO4w1Pltzy?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16043286-cafe-436a-a8c3-08dce7b8c7dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 16:46:39.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRSFKtMGXKlUEiicbW7gDbmrpNJPwK5OdL6iBRx/s59dtxXEtvs+mWIhqUIxAI/CJijRcK+ZOuqdntRbSAnUv8uLr6RrkICOeyY5azQyNXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Oct 08, 2024 at 09:58:35AM -0500, Ira Weiny wrote:
> > Gregory Price wrote:
> > > The CXL Fixed Memory Window allows for memory aligned down to the
> > > size of 256MB.  However, by default on x86, memory blocks increase
> > > in size as total System RAM capacity increases. On x86, this caps
> > > out at 2G when 64GB of System RAM is reached.
> > > 
> > > When the CFMWS regions are not aligned to memory block size, this
> > > results in lost capacity on either side of the alignment.
> > > 
> > > Parse all CFMWS to detect the largest common denomenator among all
> > > regions, and reduce the block size accordingly.
> > > 
> > > This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
> > > enabled, but the surrounding code may not necessarily require these
> > > configs, so build accordingly.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
[..]
> > To help address David's comment as well;
> > 
> > Is there a way to scan all the alignments of the windows and pass the
> > desired alignment to the arch in a new call and have the arch determine if
> > changing the order is ok?
> > 
> 
> At least on x86, it's only OK during init, so it would probably look like
> setting a static bit (like the global value in x86) and just refusing to
> update once it is locked.
> 
> I could implement that on the x86 side as an example.
> 
> FWIW: this was Dan's suggestion (quoting discord, sorry Dan!)
> ```
>     I am assuming we would call it here
>         drivers/acpi/numa/srat.c::acpi_parse_cfmws()
>     which should be before page-allocator init
> ```
> 
> It's only safe before page-allocator init (i.e. once blocks start getting
> populated and used), and this area occurs before that.

I will note though that drivers/acpi/numa/srat.c is always built-in, so
there is no need for set_memory_block_size_order() to be EXPORT_SYMBOL
for modules to play with, just an extern for NUMA init to access.

