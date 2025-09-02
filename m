Return-Path: <linux-acpi+bounces-16281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D39B409C2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A4A7AC2DA
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2532C336;
	Tue,  2 Sep 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE6xtmoW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AC2D5408;
	Tue,  2 Sep 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828354; cv=fail; b=YkyChfhPDi0AgD4VXaWDUmPIKFahkFfPr6t1njT/CCAyde/HabuPmQFTYDUgGU76yBq68Y6XOl9JSzhA7f6XqbQiJlQTdBwjRaF9XoySHZJdZJ04HLw28sjgw+ww0YxImnratTVfVvaZpMMJBCAQ0PrEwCcK4ofs0dOTM7VnWkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828354; c=relaxed/simple;
	bh=gX5knC6FchxHXefCl6zM3Pg6PF4yhO98tPuuHoC3RE0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=liF2jYczzas0i3M4wBPhe9gbtU8h8VhL6sSRYVEWyI+Ta7/UCodBBxMV271Ql7gH3kuwI36qW2iXIhVisT9Dqid4UvDuuBysKiPs1yXgIBfOOrT69/GrmxVDa48Fpv1R+doTwN1uJ1XX4XfZSBfyGJdo0s3EQKrzsK7uoyKu3K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE6xtmoW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756828353; x=1788364353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gX5knC6FchxHXefCl6zM3Pg6PF4yhO98tPuuHoC3RE0=;
  b=RE6xtmoWumvJ/sTVIdlIvbtXRNIVlJp+UD8MJMVnMzwfHBpKi/+uHQbP
   lBvN0LYk+BVBkDrE+g9iPkfhovDkZB66gBsN5l9kM04++JauK3xCRcMtC
   Z3kheQEeNaD9yv39GtMk2VVqdGGgSiKGF7JWCPgjU1lvf0rQpXx6L6Wlb
   NtgUnjazA5PyNBWAzkL4JbGSt6zjB1IS43DAXcHCd0XtfXu4aCifh9umx
   rwh6fGfUkzjtPtSLRi74RvHB9gY3+hJrkQnwfes5OdB3p5O049PfLlO0Y
   k8RERZDRbOljrma/wZy1dDGEnGXHdndno2a1JB6WoISjVySRWYi0MBIg+
   g==;
X-CSE-ConnectionGUID: vBxx0OztQ6Cj3oXoyymuFQ==
X-CSE-MsgGUID: JOBqUT6RTKmv9k1RxwL9Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69814936"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69814936"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:52:32 -0700
X-CSE-ConnectionGUID: I2+8QxWhR8G/xUi2bt6jJA==
X-CSE-MsgGUID: MPOKCYBXRkeckEe9RrG1qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175457850"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:52:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:52:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 08:52:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GM+PFd5zmq3FVXKSMl1p/dw7v8+eYULYpH90Z3pmNHNl8teikO5oGOg1fU8heEMi1FwjWwqyAwEJZej80nju1jFmb3feEPTA67f5IlpGlmQ70VWUi5uI4EYUt7qO67GNHM4MjpFtRhhe1dPktqp5x7uMd8/jIHMhwbRH1Ec2VxX1Sq7ZI+edvuCV0IWYglmchSwjUeOhsXKIYl9rjgKDT02Odv+SXlP2BCXoTmzpgTSxGU0ZL2ks48lRQ/LYM4UA3qxd8GBtzX+Pc9Uu8fQSh9Pr6B0E/d9Sbj5Q/vvbOjLpHIyynNHN55z9YK/iVpGfYCXEn/oKfyFnQ/8Zzw8KkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTKyveUIUitZBqnJ4xdTVQ2wFZQAzWyDla1rq6pJIPY=;
 b=tWffEJsxAUhOUTpH5mz006l/RQroAu3sKyfdXL0ZGLR4b5vk8/xwb05bY5i9+SNEn2yfsTdKDv8mXwH2vVBnoce2yoiDxUlYL6HlzpBvtzbQeNkoPCiBtVGdvNnS1gRTYbvEo6C8CZkEb1tkms1dpsFF5zK/CZdNSDoe7pxZuQH9QLxvk6ZuAAw56GSF5Qrh7hUs8sDNdquZnhpUJ821k7DrWyLLBepi8QZeVO9jDK51lU3qvMD2cFcsnLT634WBIERDMthPz5pbJ3dnVeBaZ6JqZShg1OdgGZW3YwDGunKKrvHE1ldwOsMana8xoJNMqNBr07WT0o8ncCWlA9t8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:52:28 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.019; Tue, 2 Sep 2025
 15:52:28 +0000
Date: Tue, 2 Sep 2025 10:54:17 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jia He
	<justin.he@arm.com>, <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: NFIT: Fix incorrect ndr_desc being
 reportedin dev_err message
Message-ID: <68b71329c4f86_4bae5294d3@iweiny-mobl.notmuch>
References: <20250902114518.2625680-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902114518.2625680-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c6e50-36bc-417a-abaa-08ddea38b807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hSLWjOG5Zg8Rm5trHBgFejz1BjoUXhW3XPvGL7cZam5z23qCIwFwSk6WceKE?=
 =?us-ascii?Q?XfZ4S5CwkQlJAbHBOoEc9z1OWcU1zQWEyHjjXQkmKZS0Av4jDxdWR26cap0U?=
 =?us-ascii?Q?E/5Bh2x7u62TX1hmiM8++lCxKNLQIpt8rjehhYU184xsOw96cGGRS7IUgbRc?=
 =?us-ascii?Q?v/ueoN8sf0NVG5PSDDveK0zPx3PwdKJTTh2dz+v5SeLlrcO7i4CxUqJbsbT/?=
 =?us-ascii?Q?gBlioIpPnencznHQQNrL4CyrhEVCeiRiyZgfJCpEVc+YoLK/D/K9eNkATBjH?=
 =?us-ascii?Q?oftgacNKaGPZ4BH/3KdwSpbhrEA+XGTD7E1w2XXeyTWi8XeGyPRbwDG6UJgL?=
 =?us-ascii?Q?yiAeRpHc/I11ypHj9vpHgD46zdzq4p17ztlTE4A8Jab6xfaDCAK9xWa9W0Rm?=
 =?us-ascii?Q?V0hObP3/B4imi1KxHkpZXeuqspAmGIrjXKidpHacseMLW+FNJo7eNzY/jlg6?=
 =?us-ascii?Q?Cw5Au/l3FRMi/X1DAlayie3SfMY+XiqEsABVSoxl/VlCDcV6H3pD1wmJq+lq?=
 =?us-ascii?Q?9vSpssW81QEvyRgDgEiE6GpjPqD0RJsoI+eleDeJN97bH4MQpF7cOnDrcwWo?=
 =?us-ascii?Q?fuMCKhyRx4tL9cnxPbTmIHqHgXIYFisSg3TNw8bQhf6dCKMlESIm0/RCCYJ2?=
 =?us-ascii?Q?ANXQONI9EDUhKF6EiatsGpmD1/QBj9yTocsA/CtBn63BV7jckIQ6LeStS2SE?=
 =?us-ascii?Q?FGE60GVnEsUiMCBVkP+o8DIGuqZ5q/GmE5egCioW5WwHXwxkYEasLsJ57dex?=
 =?us-ascii?Q?BLioJH4O50SBt0JlkW584HSosNuNXyQFvDOsVVNYN9MwtpZACwWI1UdOAN3Q?=
 =?us-ascii?Q?XxAWw56NHnue9riaG975ox7P4B5Y/M0vmgzeLtX9gOzD+Gv6xXjS/y6znBmu?=
 =?us-ascii?Q?i6q2X8ZdKLH9NV7xKzNb6qy2gxJd5pGnmPoq7CAb6t5J/sq8aacumR7d81Kv?=
 =?us-ascii?Q?w/Wuy394E9E/N/hYvctclzhNcY5reNAMfGz0zNuDPJr6NSSnkFp7DOuMOflW?=
 =?us-ascii?Q?nFDLfSrTfvhrxo45AXP7diZ5ieuv66KaBfMBMAs+PVYM9WrgP/c9t2ibywYw?=
 =?us-ascii?Q?AdyS5sTWwQ0xRLnEosnqB8wMOxGscVp1rtRGonk8dh2fn1NdlxTuGRJqVaXP?=
 =?us-ascii?Q?DNNlShCFZLZFCbkbYb4pY6IL5F1K9t8Nfq2sP5RrqPMe5xQKxEa7OOenS3GB?=
 =?us-ascii?Q?XElEZpXSkF5nXLl1vtB45qYHVzGhlp/2vvjU9tBvpdJ/AEyF8D6COVRZTA2K?=
 =?us-ascii?Q?Dnfa6wtQX4WkC2nn2AruLYUHc4O/Pw/v2CYFySG8z3CnKdg5oahuV+r0+he2?=
 =?us-ascii?Q?AOIq8RYTeBvPlxs+i0FP6B7djGllbrWBffJuLbYkVSk/I9RnrBK+EBA5DMH/?=
 =?us-ascii?Q?mQR9fSblxngYu5nlyJPi6r3BCcYlqG7AHCLF0A2huQo4HvjAamWi6bUVS0SR?=
 =?us-ascii?Q?0e3BqVul+307oMcltIF5CtvFUDw++5s5SZ84sW5VkB5D/OwTQsWM5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kQrhNVAdQq9q2tt1/xfqhNzWkWRy64iAoCP1hL/LtZ8v5hfNX/LpzYiuefL?=
 =?us-ascii?Q?RH/W0f9PTMS8pNKNMOpMCK5NU3+eF7WohMWAw8xoc7UfP8/UR+x0k5tFLTwt?=
 =?us-ascii?Q?/vyIrRS4uvTLWE0exBBAOYIHY+eDlqSopUP1TeyYVOER3bqH81MsjURicSF3?=
 =?us-ascii?Q?3+ATxj+MQn4Ru9xhyeIKK3FVvP4y5/9ayhMehYvup3NNV6WqhGnr5sBd6XsS?=
 =?us-ascii?Q?U65/UPnF/oGsS6uboxGMePqOJwOY7elItf07vet5M47LceOCqjeZzpXhfuW/?=
 =?us-ascii?Q?rtyhhCxbg2n5XmVxWV3tGNWcs5tAOfJ55K1OyF9rKxAjdP8M/RK0oaIj1DLZ?=
 =?us-ascii?Q?HiUmKzQlvXYkIHA/uU6kTGTRW8B1DQD1HAa8DAQYrrz+4VWmf6WAetl+5yVS?=
 =?us-ascii?Q?vU8ql0p1hGv1NDjyYYm1NPcMzpbPofjpycYuZDK6KCEQIzwFi1xysVdY5HEw?=
 =?us-ascii?Q?vo90NzkF1VLvGnl7w3WEQTE+jTK/079joCQHn8bBS1Dp2IHqe5Ho/AOOsr8V?=
 =?us-ascii?Q?rJI2E0orYh8Z3Wiln7rn5hlXe27RfmM0evhn28Wjyq3T2YINWLwUo3f8TBFb?=
 =?us-ascii?Q?Q6h51KQWhkqJs4TYAGWWVN9gKZXKhPApz6RbcxFv9wkMbVhXroO46fbEyigr?=
 =?us-ascii?Q?D558gdrCBptkikuRDKfUrrPesnoc3XKg9xw7iKOJBFXgjKvCjR6VrgldEAac?=
 =?us-ascii?Q?UPP+DZOfywwW5L569h/X7rUsCnoBJGWGVlbEejzYyz10e6v7JxFQgtCHanvN?=
 =?us-ascii?Q?Yd/38Mo8TAlIiegrii0o2p4B02EEIDra1CdTcztfhSFqyBluUF2DXGrM9ED9?=
 =?us-ascii?Q?AVaqeDOabjIWng761rGNXAbxwimbK6XeuMAchFHb2Y54QRzAAFVoAWRFoW4S?=
 =?us-ascii?Q?JUGlTtxyf3MtQsNDFKS/Z31L/1T3GNUSGNFufdOAcTiGAp3ZU2dsz1wdcjym?=
 =?us-ascii?Q?tKmTKVSvISVqVnq7pb5pssrVv8KLTjr74cdPjhi9l8ef4CMEMJa5Hm2o2No4?=
 =?us-ascii?Q?gJMhaLDqTw5fq1T01ZPwZjhelPSzf1f0NzjwPP+/6M6h1wFYT5NylEPmM1sm?=
 =?us-ascii?Q?JAtWeO7vIHYB+3j1tq5KpdNavtnDAhq2jY/WqtSiuR0lU2UgQ0VtoMDT6JWm?=
 =?us-ascii?Q?KzQNI0YxbEtTQjkTpl3cfLFv5lxHQDC61HnAzJ8LXgkMuOYR9ZgGbIJ+dW1O?=
 =?us-ascii?Q?YapAi5ij+jZ8SiiWOVR9ANFITT1NHi6d9t6IxuheZ7RYrCGFSxP3QjVKFzcE?=
 =?us-ascii?Q?PQFigD+mlJ0TEALRXp/3m5etBOsSV0LtJrs+/TXb1hPknXgozbUs9uqvSSDQ?=
 =?us-ascii?Q?NEvORiD/x90XyslAx6lfEB5SgmzqoluG58cmJpYsUYuuxugGzBt3rf+GMY5F?=
 =?us-ascii?Q?hnpa9vZaiyblLCOOgbCrBcLcDCUvn+AFrzyvgZ3hwZNUNTHwmJMPwoVDWT8N?=
 =?us-ascii?Q?ZW9IiFwEtVtGEMRRGDpy1RwnqLCfZKqiVN9YLr7Zw/GS1TleYBujK6Pj91Tf?=
 =?us-ascii?Q?EzePqVwwyTfJTESQ4YshJ4H7bGQuD4O0krdUgKzz/L/Y8Uk9f3WK4mEY6sYE?=
 =?us-ascii?Q?UPS6JY79XkGqhqap30eWLDrXslCsgMBoabqVm3oG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c6e50-36bc-417a-abaa-08ddea38b807
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:52:28.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNJl4lDWPTb9y5OD/EjGMr7TkQ5QvCOs+rH4UrqPyYSyhSW166qNwyFIDlqm37gLbtlYjYTa+3chBGZ6cq08Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com

Colin Ian King wrote:
> There appears to be a cut-n-paste error with the incorrect field

NIT: 'There __is__ a cut-n-paste error..."  ;-)

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ndr_desc->numa_node being reported for the target node. Fix this by
> using ndr_desc->target_node instead.
> 
> Fixes: f060db99374e ("ACPI: NFIT: Use fallback node id when numa info in NFIT table is incorrect")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index ae035b93da08..3eb56b77cb6d 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2637,7 +2637,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>  	if (ndr_desc->target_node == NUMA_NO_NODE) {
>  		ndr_desc->target_node = phys_to_target_node(spa->address);
>  		dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
> -			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
> +			NUMA_NO_NODE, ndr_desc->target_node, &res.start, &res.end);
>  	}
>  
>  	/*
> -- 
> 2.51.0
> 



