Return-Path: <linux-acpi+bounces-11747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1DA4D2A3
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 05:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C73ACB66
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 04:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715F1F37C3;
	Tue,  4 Mar 2025 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc/031Vc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9A13B5A0
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741063303; cv=fail; b=HbvGKXEdiqwA+wsD4uBt9xftyYLp0HYlkxOzM66MYsPJW5r9Ch2tywgJ4T8la6bOp8zYMAo8zh2lGc7aQVy2sB9/gVSVAjSMHQilLQyKWPvy4GXO6pvlKWuxJwq/RlTOBFRohj8TDavHYdMFCyLBbngafRIFmLfN9rCfov0RiMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741063303; c=relaxed/simple;
	bh=NBY2WBM03kqYIFSJYVollHTMPez4X1+EH9evFB9aB6w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fB5Ybs27ibBc9SPDoK+2xZSbVqE1SrhD1zdqoVQQk+8ZbBdst/lRofbq2JdBqhsiAwFaDc21l7gdY9V5CgzE9kSM1A/W26fjRGdu050PWHFPpTkZ7RAxtERmWMOZocHBNhxhWujSQZghrP3qSdm29r5LjJTy/quEbyOtnQ1wBHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc/031Vc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741063301; x=1772599301;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NBY2WBM03kqYIFSJYVollHTMPez4X1+EH9evFB9aB6w=;
  b=Hc/031VccxjgYUS5zqeZ6z9GVgMztzcznZDaKMA1mMy1ufVetspRHOs3
   3GT3vg1py7oxqooY9zRTaeWhjtBB2q2klb/+4BKq/KiMWpFetzn3p0PHB
   DVCm3a+l9vIrFl4h6lesL/nP2qbLwjLNS4eDDAyqKVfnD4kKsIEFPN7nB
   xyT/Mn8docBsiuz1RsM+hc8GLlCX5ytr6EOxTu+tUD666mAA06EhnDGfy
   MNc8PB8Os+/EfYV/qH2xJW+swvMEUKbbdZDqg4LwAelk3QkBpK/raDjDa
   63a0KCxjk/0mOJl2HpmxfHyojE751EeCQbS+vkJtNPtvV6iUtNL7Zdl/S
   w==;
X-CSE-ConnectionGUID: HlMvWOllRDi5ndqMzc/6mQ==
X-CSE-MsgGUID: 94Tq09fdQjiGlP9agx+s8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45609909"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45609909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:41:41 -0800
X-CSE-ConnectionGUID: 87XHkMKcRoWwdjczOLp1jA==
X-CSE-MsgGUID: DN617EewRz+zHWytdjRoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118945330"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 20:41:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 20:41:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 20:41:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 20:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmhECPrSYRt1etcrQ3ccJiVCu2D2VAKuKzx4xOUd0VHbX56DviszHEkHMKZbeN6EEGFRB/SBXwz+Q6gDXc5oossUJurliCH9Co5JPnf2Tb6Hlg8e/qZr/eKmocqSlnU+R+jZOd7yqSk1pTpSDLkXL2s0355jTz3aT9D5W+nOYCkF4/gomQy4G0BQZzAJQPd0l9yRPNmJ071CATTeLBRgw++jvhYWFSzEAlLCci2J9DXZt3ZnTNbgNMk1TQJJudUx/0ZA2edgp0Il2zjF9RKnbXUhBjxvqzfHKmA7vqFZkUOd9nJdmuweMIuCTNOUF2AjfkKcoe/zPY/I4fwbx5MGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVGy/PBScqIOO0rZoqYZzAKYTL557XRCeucxSy6goGQ=;
 b=pbeDbcz9z/tI579CfM12RmhRC80KU/RiJBD11+dZ1xHtKJ2777/B02oDCLQQdMJXQ1lHdoYG/o58OQ6OMbum94z8hHw2tuX9OoDiWnEEOtwPUD3/7Ot8LWgebJgVHAvMp3WfP1aehtlzQgl9yfBNpv6vNW/lzjd5XDHuIKv5tykxw/WjdCztGmkjL1QJDvlI9586ixBRfHftY4BnVhDhXszra0lvYy1jDNNpgXFIL5nu1glWmhDBqZUGy+El4F5yIXOCFuOPCsSYdS+xuMLV9A/4bcU6CbkaAh82/dh+75ert+0vzwbhCZ7BUyY2gdR/iv2G+hcfWN7V+kty51nF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 04:41:30 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 04:41:30 +0000
Date: Tue, 4 Mar 2025 12:41:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <mpagano@gentoo.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <robert.moore@intel.com>,
	<rafael.j.wysocki@intel.com>, Mike Pagano <mpagano@gentoo.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] ACPICA: fix build with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <202503041028.8f769fd1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250228210834.811164-1-mpagano@gentoo.org>
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|DS0PR11MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: d90fe54c-eec2-4adb-fb80-08dd5ad6d43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rV+OrANxtOMhsKX9xxoEDpjHGfG30Glf1CQrsil9f1ZdTkKpOSbFiBjVH3v?=
 =?us-ascii?Q?cSH4qsE3ZsLGRni8q11373nD5/MnTGfYqoAg5DOdDUn3Zs1HH1MM0xO8qZj3?=
 =?us-ascii?Q?2Ps1uTW5+To+VLvuDufwLLZ9Mu46qPBlKLqs/peePBfjdkaHKJ8QczA2TEM5?=
 =?us-ascii?Q?QGpxeKiNUKP/UB6UUYYNGgFafye3cWLNmcMav3QVIFZKDp2wCnxTHpYVfXTW?=
 =?us-ascii?Q?1j83S6kBK36zO1HALCxk5dPPqRgtqKth24KQDC9x03rsJkmtb4KfVB0I6mzT?=
 =?us-ascii?Q?xmu5WA8VG2yjHXR/Cd9zJHUvdh+hqBtFvLw6pMjt5TrIRwuQz5VdsXzAXYWf?=
 =?us-ascii?Q?UJiAX7B5aPsaUE3mVwo7rmGN7E+ZgHxE+yv5TVrmY2807v/KmsE06mdmNkgr?=
 =?us-ascii?Q?7F3rLTlangKRMggbSap+VAJpq/t6mU7dTj8YSfa7fb6uDPB16Bg1QIClEfq8?=
 =?us-ascii?Q?ons1tG+zN46D//2MSlvuAKV8xdxQy99PdH8sOsIvQvl5OmSVtzGJOs8G1szE?=
 =?us-ascii?Q?dzat96THI2pVRQzU+xtT0alGRKru5pb7UytIq+I27XDtnuzgk23ztXYOP/P/?=
 =?us-ascii?Q?0eJ/pTXZqyKrBlhjE5lLu+gtW66XYVYsuRldB9vXclLoT7agq6s7Rhvh56KG?=
 =?us-ascii?Q?gdV4S/ZR9Av2BDYEshp+JQsKx7qCWWqBbdfBJ7WqSSF43nBoXV6YEputS1bW?=
 =?us-ascii?Q?lvIDadOahMXZQTt7ci41DdqqCheV29xvQKSTsFnPfOt7PBI/1tbc4dW5TFwk?=
 =?us-ascii?Q?E+8GqsGXCkzHBH76zZzZG0NxZefmaEbbr88Bkv1uHHFn9jhaTJG8LvbiwYz0?=
 =?us-ascii?Q?s6lwAVVbWZFgpSLSwsMHJHkvY1l1KDXb4Vy4ccBUCsp5BXKYiN4/5uScMVH4?=
 =?us-ascii?Q?aLXv8fzWBT0hS6dsqNTVj04pmNroWabQXfLlYmLgPTitJM6jZpZtyUbfOY4H?=
 =?us-ascii?Q?QZg8bspYxk5F7cF6Z92pg81hPboey2I/Ezu8fTppc1nGzuh8HrVxxhtW4LW3?=
 =?us-ascii?Q?8svCC++xftIWqAZRyyKgeCNWZ5jIcB+yrJK9cVAueKHGkZgc6GhZED5t+A1P?=
 =?us-ascii?Q?5hZhdAeTQ04gZ6bc24ujvbnt7QECTNYQIZSDwCTGwuLEIPVgLhZE9j+NuFl4?=
 =?us-ascii?Q?W7kcLUSW7jQnEzmaMMizkxm6W9bHMg4hZ5obs6JjehtEDBOWOq/0SYSOekcc?=
 =?us-ascii?Q?tOBZisS72BEDaA2KiMCq0+F9PGbGWz0UOsMOUxpcLuJlzFhU8rHmPTYxmFKn?=
 =?us-ascii?Q?oAkzEYYRthMQK3TxfcuqJ7nSinQDFT3swlOCyw4nwmqblbMS7nINzhILSw7D?=
 =?us-ascii?Q?Hhn1qypfCiYnrn2mckeD6eTp2irXVoV1BNcm/MgEQli2lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qMzaOU3tPHFlmtAo4X9A3iYfzpF51cDWMP9bd3zbOyPnNECssUOMbV7RWvnf?=
 =?us-ascii?Q?TiuctKIBnNgs6jsuYVFr8EhwgbZ9n5p57NG9+sRzDypg0QFeWygmQ2QU0fdQ?=
 =?us-ascii?Q?DQvBdG5PVNqvxJSDArE4pCe8Ne4nd8g5DeJk4pEhuYjs0kpRxPXbzt1HO/yP?=
 =?us-ascii?Q?Q9qBu9ki9fKS4HeJo4XOoA+DFIXlrRPVg6O3OVlFgx5RPr+uNfJGyhRKYz9Q?=
 =?us-ascii?Q?HDvZWbM3YGnDq29f7L+1NHZMLwEJ62B4Rw8FQOw7q8j88Ua95oGQBnx1hq8l?=
 =?us-ascii?Q?2e+4henPaJqgWjYj0ugCbULNc3rdC3c3g9zDS/XSuRJZmKincyNtq4fh3XQb?=
 =?us-ascii?Q?s39tAKA2gZ8BHg1r3/5Coh9KvJhWkN0JC0YtWT9lmU3Ok3KNf3gBj7YCJhfK?=
 =?us-ascii?Q?XbkojOD4F6HcdJU4Q+jjbgOCsR5AkPcnaNHA1Gtw17fJ1AN+1tlw0fZ6kkUd?=
 =?us-ascii?Q?zCwG2nP4sWyPiY/SaZiBlV69O3Pi5UQPg1S9Dy3algHM2/clkwfqM29dR7Qi?=
 =?us-ascii?Q?UN4gKdffu6IHydRrwBmJc7b97rAuVbSQUId2YWf8Ehh4q8QgkXx1t/laTtnV?=
 =?us-ascii?Q?bCn9MxOiX4404i6Lj/QStXKaPsgI0zcJFKGVqFPGInDIHO7ZXUklMALOzPXi?=
 =?us-ascii?Q?fPsD8bFAXvfxJt/WM7HxMcG4ct74ztGVescKo9SqnxQbLHzZyW5BkSxzre4b?=
 =?us-ascii?Q?1p2hrDVwMVXSyRmSzCzh874I2j/bzMlWx37ja8cCf6TLkg1fdbnalSOzvR2y?=
 =?us-ascii?Q?f/fdNcib+MOXytM5ADsNwlQP2m2MKgRxS80zlrWOtjcTar0bI06trMWtmr58?=
 =?us-ascii?Q?ob6qqjgxdN9oP4dwZEflMhNvrjHYbrGpMRCZ1FhlLqpxgOOj/PSHMjmIaTTy?=
 =?us-ascii?Q?7tyCaaylUwicWov7M198Zn/h9ksTRb9TMmQTqgNNh/TLEYJ9X9NsTGryY9Mu?=
 =?us-ascii?Q?z1LREtI95147miHezmNaPFKn3bn4r0LJv7+bGAi69u1G1/W8sYVE+xwdDAsc?=
 =?us-ascii?Q?QefSvzLd3MXDjaT1OOCzCRFjN1ddsgwsIIMaFTCpWZqd6syOsuiRs29Ntie9?=
 =?us-ascii?Q?1byAjBC/dfENSu6rqushYiBFl850GQzsGX9SbhK5HIAIlylVfrBnJh7+A3Kr?=
 =?us-ascii?Q?ny3m2+xSo0538ILJ7JeqcG3TOdwW8yR3EwEdshBV5hh+XgU60EqcsCaHybQY?=
 =?us-ascii?Q?oct5VS21be2sPJDfU9NgbcC8du2v7+DKfPmXnm8TKbFNRPdsj0qZH9s5ZQMj?=
 =?us-ascii?Q?5QpcVh/pcGzHdDgeapMNHsyDERsjPFGTGoAy3mWBpJvSzgAfaahgcZSJ/wYS?=
 =?us-ascii?Q?H8QEMUpgKGt2+wTwv+/FifVmadAbbKcg3rmnUIsRv6LB2j9/sGJD/ZvLXlnz?=
 =?us-ascii?Q?kfTBKXTIte0QNgIZ7nHsNiGmn/9Ef66PMagbKp8tGWflrgLAJH+0wvt599bD?=
 =?us-ascii?Q?Obci8vbVnSU4E4oiLuwq8xP+127oX4lz8AJumNAvagvaAgtATDVwBpc+Ut3/?=
 =?us-ascii?Q?A94Y5r0rz/8iZwf1u19+ZrRrTAyU8GWwSApfhGNDHBGu6CFs02WPd5kzDymj?=
 =?us-ascii?Q?U04FbdHiJ7OAWfyMzmdeLay2kvWSZrZDSQOKA7tg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d90fe54c-eec2-4adb-fb80-08dd5ad6d43f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 04:41:30.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oEvGW4oqq5SRp6pORQE5Eukb5m8pX9gpgKeftkh5THu2D7s1ce8AeE2oOM4qRX8L/Oc7pyJ8VBO0WxDLViBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/early_ioremap.c:#__early_ioremap" on:

commit: 6ebd152438416123dba1a540e884d998108e57f6 ("[PATCH] ACPICA: fix build with GCC 15 due to -Werror=unterminated-string-initialization")
url: https://github.com/intel-lab-lkp/linux/commits/mpagano-gentoo-org/ACPICA-fix-build-with-GCC-15-due-to-Werror-unterminated-string-initialization/20250301-051004
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20250228210834.811164-1-mpagano@gentoo.org/
patch subject: [PATCH] ACPICA: fix build with GCC 15 due to -Werror=unterminated-string-initialization

in testcase: boot

config: x86_64-randconfig-007-20250302
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------+------------+------------+
|                                                                              | b25eff369f | 6ebd152438 |
+------------------------------------------------------------------------------+------------+------------+
| WARNING:at_mm/early_ioremap.c:#__early_ioremap                               | 0          | 18         |
| RIP:__early_ioremap                                                          | 0          | 18         |
+------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503041028.8f769fd1-lkp@intel.com


[    0.031199][    T0] ------------[ cut here ]------------
[ 0.031907][ T0] WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:139 __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[    0.032833][    T0] Modules linked in:
[    0.033233][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T  6.14.0-rc4-00065-g6ebd15243841 #1 5829eae6911cd154dba5b021a54ee27d9237deca
[    0.034695][    T0] Tainted: [T]=RANDSTRUCT
[    0.035135][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.036029][ T0] RIP: 0010:__early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.036425][ T0] Code: c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 d3 44 5e fb 0f 0b e9 a1 fd ff ff e8 c7 44 5e fb 0f 0b e9 47 ff ff ff e8 bb 44 5e fb <0f> 0b e9 3b ff ff ff 4c 89 6d b0 4c 8b 6d c0 4d 89 ec 49 f7 dc e8
All code
========
   0:	c4                   	(bad)
   1:	38 5b 41             	cmp    %bl,0x41(%rbx)
   4:	5c                   	pop    %rsp
   5:	41 5d                	pop    %r13
   7:	41 5e                	pop    %r14
   9:	41 5f                	pop    %r15
   b:	5d                   	pop    %rbp
   c:	c3                   	ret
   d:	e8 d3 44 5e fb       	call   0xfffffffffb5e44e5
  12:	0f 0b                	ud2
  14:	e9 a1 fd ff ff       	jmp    0xfffffffffffffdba
  19:	e8 c7 44 5e fb       	call   0xfffffffffb5e44e5
  1e:	0f 0b                	ud2
  20:	e9 47 ff ff ff       	jmp    0xffffffffffffff6c
  25:	e8 bb 44 5e fb       	call   0xfffffffffb5e44e5
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 3b ff ff ff       	jmp    0xffffffffffffff6c
  31:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
  35:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
  39:	4d 89 ec             	mov    %r13,%r12
  3c:	49 f7 dc             	neg    %r12
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 3b ff ff ff       	jmp    0xffffffffffffff42
   7:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
   b:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
   f:	4d 89 ec             	mov    %r13,%r12
  12:	49 f7 dc             	neg    %r12
  15:	e8                   	.byte 0xe8
[    0.037790][    T0] RSP: 0000:ffffffff85207cc8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
[    0.038377][    T0] RAX: ffffffff860d9bc5 RBX: 0000000000000000 RCX: ffffffff8523e000
[    0.038929][    T0] RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000000040
[    0.039482][    T0] RBP: ffffffff85207d28 R08: ffffffff85305b03 R09: 1ffffffff0a60b60
[    0.040047][    T0] R10: dffffc0000000000 R11: fffffbfff0a60b61 R12: 00000000000005ff
[    0.040602][    T0] R13: 0000000000001001 R14: 0000000000000000 R15: fffffbfff0c3544a
[    0.041157][    T0] FS:  0000000000000000(0000) GS:ffffffff852c1000(0000) knlGS:0000000000000000
[    0.041779][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.042239][    T0] CR2: ffff88843ffff000 CR3: 00000000052a1000 CR4: 00000000000000b0
[    0.042794][    T0] Call Trace:
[    0.043021][    T0]  <TASK>
[ 0.043223][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 0.043523][ T0] ? __warn (kernel/panic.c:242) 
[ 0.043821][ T0] ? __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.044166][ T0] ? report_bug (lib/bug.c:?) 
[ 0.044481][ T0] ? __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.044827][ T0] ? early_fixup_exception (arch/x86/mm/extable.c:415 (discriminator 512)) 
[ 0.045213][ T0] ? do_early_exception (arch/x86/kernel/head64.c:384 (discriminator 1)) 
[ 0.045565][ T0] ? early_idt_handler_common (arch/x86/kernel/head_64.S:542) 
[ 0.045954][ T0] ? __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.046300][ T0] ? __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.046645][ T0] ? __early_ioremap (mm/early_ioremap.c:139 (discriminator 10)) 
[ 0.046993][ T0] early_memremap (mm/early_ioremap.c:223) 
[ 0.047308][ T0] __acpi_map_table (arch/x86/kernel/acpi/boot.c:115) 
[ 0.047642][ T0] acpi_os_map_iomem (drivers/acpi/osl.c:337) 
[ 0.047984][ T0] ? acpi_os_unmap_iomem (drivers/acpi/osl.c:424) 
[ 0.048347][ T0] acpi_os_map_memory (drivers/acpi/osl.c:378) 
[ 0.048685][ T0] acpi_tb_parse_root_table (drivers/acpi/acpica/tbutils.c:290) 
[ 0.049072][ T0] ? _printk (kernel/printk/printk.c:2460) 
[ 0.049360][ T0] acpi_initialize_tables (drivers/acpi/acpica/tbxface.c:113) 
[ 0.049729][ T0] acpi_locate_initial_tables (drivers/acpi/tables.c:722) 
[ 0.050118][ T0] acpi_boot_table_init (arch/x86/kernel/acpi/boot.c:1595) 
[ 0.050467][ T0] setup_arch (arch/x86/kernel/setup.c:1096) 
[ 0.050770][ T0] start_kernel (include/linux/jump_label.h:267 init/main.c:920) 
[ 0.051079][ T0] x86_64_start_reservations (??:?) 
[ 0.051463][ T0] x86_64_start_kernel (??:?) 
[ 0.051811][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.052152][    T0]  </TASK>
[    0.052358][    T0] irq event stamp: 0
[ 0.052624][ T0] hardirqs last enabled at (0): 0x0 
[ 0.053117][ T0] hardirqs last disabled at (0): 0x0 
[ 0.053608][ T0] softirqs last enabled at (0): 0x0 
[ 0.054100][ T0] softirqs last disabled at (0): 0x0 
[    0.054591][    T0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250304/202503041028.8f769fd1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


