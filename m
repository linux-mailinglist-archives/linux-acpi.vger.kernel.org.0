Return-Path: <linux-acpi+bounces-13630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C54AAF13D
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C3E7A5B41
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 02:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002851D416E;
	Thu,  8 May 2025 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSxfLtmH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBD1BDCF
	for <linux-acpi@vger.kernel.org>; Thu,  8 May 2025 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672541; cv=fail; b=fkWyichzA6OHUV+FUCLLPBfOWuyhXKufjqkfkk+L+FBF6YMPjJcR20AYcPqgHJXt1Nbb8bg/65xaYRGn5N81TW5VJTQ2iFBSXcOCbh6Ab5oh8CEttJ6NZH9xq25LRHZ6NfR/pib8S5rdrYGbWlYMj+QeUYqjikVZJ7BgfWbqCLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672541; c=relaxed/simple;
	bh=JLA3z3oTPA7HIhWGMEdcTsubL/q5DIG6Hy0i+mksJGs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oof60qNlbOpYbCCHcfgV9MxaElE5PY4lbdfW/W5U31fv5m0lp+8C5siLG88jsWty0OoZg0EazPg8I19G0UAwmfxT7K2Uitr+wtyvBjqt50Mx9lv0Oz9ug8nhC+xs0rHOQzuElzNq5qg6DnMloE/1ktMWI8oGyCy7wQhEv1R3qOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSxfLtmH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746672539; x=1778208539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JLA3z3oTPA7HIhWGMEdcTsubL/q5DIG6Hy0i+mksJGs=;
  b=ZSxfLtmH4/ICzZZuJVL/3waDxQdKcWQUdWX+/62Zy+UPP/bUZ7hjctXb
   Wnbet4tw1Y7LNIPO3W5fldXbtwyFrLdCBfyG/q861Wb95joxLV69gz3Ai
   AG/nNgr+jAkIYFn/DXZ+UBb4fcKBd26GGSIKZT2i5hSa3YyYCKZks3G3q
   vhO7RGTzuAYLR6EjcqlNROLzAoj9v8fARGEf3MTkgqlv6h7bU3/rtMKBm
   wDCFMZ1KJFPvW1OkgJKV4vl1IRGwVzNd8Kjgv5r2q0SmC1jzogRcgvKuq
   JqyYr2SDAzmi2nwaVr997C16rMqG0qcbeyqJwwotCZuhChJSC4BCCsj7o
   w==;
X-CSE-ConnectionGUID: KWP7gQf/QFi7bvPBwsBo0Q==
X-CSE-MsgGUID: 8t2h2dtiR/6+x7RIV6VyfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52247964"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52247964"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:48:59 -0700
X-CSE-ConnectionGUID: uddEb5DaTGi2C/zkGMC8Wg==
X-CSE-MsgGUID: bJxBGSvgQHGlk7M827MrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="173362696"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:48:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 19:48:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 19:48:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 19:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko51YxHPcdvs9iX1i4WeYtsckc9lVmJHMt3YM7m3rP78pixz4MGSkujigvx6w7HATZ/UHZFs9VV1LMsu5dPB5q/BUzclKykoXvyn7RYBQHrzPwQnO+II2zKJzX2Ho+ydFV9CbWsPiOD3BF7b/1j1W4fLELpjh7pmUisxP4t2DDRGDOi0eCW3TvNzfQpbFicaQSDFadavQjv1VzeXfyHTR8+YFUaJrCs4JC4RM/PMcbTlF2Nt8yYXzA/h/jY2OSg/t9/ChoykYph5JZDq+GQsf913a7pTxtLYvRlJ28C9tdjlAGckPaCjMXZjI9Y8ubzSWmhbF7wO2fAcXWI3kkqEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PjHJ4Fp2aaZYD24WL0o2ZU0AiSm8QxiptcCsexP6YI=;
 b=LcFQ/zISOXP9qzjxmXpUNQZWKt78SgwBjAD5wnyASjv+5SBPCxuT3USj/xxN3/jyyYlcoRyIkO3JhrXkZ0+5JvA0qU7llDZbh+GLFDzJrJJc8wgaFogYbrt2jPc53uTIRu1bTOpYkCQVJV+vpBiyYyO+VKwgK3eGEuAZ1JMjFXCklCmuIRPmRbqjfiDzXx/zMkMk0df7x0KN3zhAwIq7xYzs3gllK2FqigA7TbvKgHdure/HEA7LBTFf3Ofzc3cZNuUnn36ixlEMg3fJeSIEtVK/E6t+5vBlTK5Z7kL9HIOLpKjm/GYMBF5LdHfu1vi55bKxAjRQR6+9AlAW6Wh8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 8 May
 2025 02:48:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 02:48:45 +0000
Date: Thu, 8 May 2025 10:48:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ahmed Salem <x0rw3ll@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <oliver.sang@intel.com>
Subject: [linux-next:master] [ACPICA]  1f5f181b9b:
 BUG:KASAN:global-out-of-bounds_in_acpi_ut_safe_strncpy
Message-ID: <202505081033.50e45ff4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 74570a10-815f-4bff-f5d4-08dd8ddada04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17HOCLi244D0KIXO0IbvVMjipt466BZL+ZSzFCEJ7SfeSGartewc8SbHKGw0?=
 =?us-ascii?Q?Tlo2NGuukUGHV8o+4Gk9aP6hnjSfCfhMb0OGuutFBnoeIpuENNCi9s1a/dIt?=
 =?us-ascii?Q?MZb+Y1G+Q393Eu4EfW2NaiObhRw7MdsTrdaD4ER8KoLDR64mQDp8yrZdeTOG?=
 =?us-ascii?Q?44MT2phQ18y1v/zE5LUmX8WqkaZoghaxJfdvjK6CA2ecOgG6GgI0qrG8PpfY?=
 =?us-ascii?Q?e6kXQqEJw0C45hgUAqbIbn6K/TXilKO18c/YFIQkYaQduSv1/VhkacKQH0Zb?=
 =?us-ascii?Q?vrG7tiL8l9pQJdBs5VggvL+JAwBSL8eZRvk6F5XnxgvN3sSbSXXiOlo0I/ad?=
 =?us-ascii?Q?dSFKDA2n3exX+LBTTgvWx6TvWo/bZshEhmC/4z2BlOZXXg3BBcJHgok/r74J?=
 =?us-ascii?Q?mFgpaBN039yWWylhPacYvOp7FMLkkMt+gVSmY5zwvDR3wLgHboJ9Rob91N6i?=
 =?us-ascii?Q?znGoYgkg1XfP9iRIP00fVIzGlFVFelDRxgUnTwMsJ1PbIjtTYOTDdr6KRa7O?=
 =?us-ascii?Q?h4aYl+ssdZoPHSEefSLEk0DFYr94KBa5PkDmGcUs6aFmbnD8sRK2yKPCJTa0?=
 =?us-ascii?Q?9zVQc/g2Y+vzWbzEpfGj+4hZmb4qzExYFgguHGBo3asesTbJ/vCRG2otFG8E?=
 =?us-ascii?Q?l4J2YEv6AlaQTH/tOscCiVBusQLDNbERlHhhgxKS5LzUha9Fs12tAvzz3dR+?=
 =?us-ascii?Q?C5T0Lif395n0YaMz0fHuNEKpJWkqcCh57YHlVtxAg00gYNh78j+M2ril4KTl?=
 =?us-ascii?Q?5LQMOJ/fIuN5YFhpSpb+fuULxADtW28JF2RU8i/Gv9eAeIexcXOxpCwkDuUg?=
 =?us-ascii?Q?5MrbOZHGozTSmwf5uVCw49IH2WI4hBfUvplfsZ6JMaKUEhuwN3l/dwzf3j3h?=
 =?us-ascii?Q?COtoLzOW283HWsCCdeXtuJgE7GCMy1xX8K95ouqhAZqAAv3agML7oNwlpVGu?=
 =?us-ascii?Q?GAzQCqmCmmEEiSz2jU+9i4Qzf6ojill/VnyMkXEx6Aqt/0N20N90qf0lHehA?=
 =?us-ascii?Q?N2V4/saPO/aYvxNX66WkA2ZjOEdTo5s2wQg6qqGxa5TNN3zByLg5Bj3/d/m9?=
 =?us-ascii?Q?kKfoYfLtagdmF1eRtIOczMxUbC2UFgleYx5jww6hKpziw9JR8kbRf02e9yOp?=
 =?us-ascii?Q?sU+BN+zVndOzZJd8lHiAmsBRNW8miSnXevke2tJdozY03OoX3mF6IPc+9yXv?=
 =?us-ascii?Q?SOEzFE+RfImj+kJQihLz3Pma9yyaQEAiQPrqs1TD0yBaK9vOjenfL7tiKOC7?=
 =?us-ascii?Q?o2PiEF6LHVcj1/nPnOgzp8sYgWcX8eUxAw6wPHFFh+Ls0O+6aKY60Z2Ac8Gi?=
 =?us-ascii?Q?hSh4XUgoy4rVXnDdNjelnlLrFDEakxnnCj6ZNNCgc3bf5PuPFrSywl5pGHQp?=
 =?us-ascii?Q?mhJ2axa3Yhbt2xCZCUaS6PItjaH3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5J5txNUKv+lUlkuard9ByP4K2fVTg6zmd6N6aMecZzOrqSCVf3kMX/fMfHeC?=
 =?us-ascii?Q?FT/aoVA/d7W4rswMlU+ToQ7KLYnF/5uj27b6xaSw8vNToM8XgDWavonk51Pq?=
 =?us-ascii?Q?z3Q46ee7S5IBZnywBtaZfQ8T9DA/ZVaCTisAYJdF9R6YtaP+vCI/FvDAT8oo?=
 =?us-ascii?Q?CPZHO2a63ULAB8hm9nGNGiik0CKfA8/wUO9gK7cCmVVtblx++OLQ6KdYu+iR?=
 =?us-ascii?Q?uYeJbSLttgoKMTGi058NkSda8OnlQPZJfLM/MLWkd1BFgFoI2703xkIg07kJ?=
 =?us-ascii?Q?BZA9vD03HWyIKjq633o9ACtcbZxauocAD9/swx2JUFtzrjPAc13ITozXzWKR?=
 =?us-ascii?Q?nP4zu3R1LICnziNRCW+WZRDw1E1xrWKMt2c/uIRRAcUPZ0isIfJo3xWAmFSv?=
 =?us-ascii?Q?l2RO5rUHBz6O+AV5yIQ8TO+Bv4uEu6uBjd0uMKCXLsNSY0Se66zQSbHliGL6?=
 =?us-ascii?Q?A8aruLh9pARdbI2Gfg3VjJPQIS0hD5PZ833syraW+PvdD/RCD93n85ygpm07?=
 =?us-ascii?Q?3BgZZHz7CpXGEmh3lG8GLi0LTo47x2egI9LYyLKb/PqNtZNTE/fBaP+sefoF?=
 =?us-ascii?Q?4tVG+CpgGK9JCyNAbUoaSaWU/jbzMI7pKpKcveTDzJfV9liZxGYI9f7/Gjy1?=
 =?us-ascii?Q?gzI0gFgd3JdLcwwjI0QZyefAJz1qQ6X3v9R33RaXDK2AY08XbBTY35l7EdqW?=
 =?us-ascii?Q?LPXt2ncQwNnJvcRzLTYcctvmJ1JhrWnpH2ihC/ZbPpeLznbkB5az8Rm5IweM?=
 =?us-ascii?Q?Y3UqdrO+EOb+o+37OTrqk7YyypI8LyabEQdD2DINHUBauIDfr5q2ERN/8e+s?=
 =?us-ascii?Q?ygHzp4RO4NsPjFqHPQ0B36gVzeI5RXuA8NjxK7ItGd0JdWtSkbvtnSZ4pQEM?=
 =?us-ascii?Q?E71xBH0J9JFYxiqEnUBorfsg5g/4kG19bINUlIgET9cpSc4CqQRAfsn563Vz?=
 =?us-ascii?Q?uc8+kr2awDuMcldvd7WGdB/4LPdZw5+Fv1pVBC7Pg4dbgx2jyJzPzSJT5OIh?=
 =?us-ascii?Q?I2iIc5q8eYFC7yfvuo5y8Cq6YIs+EPTDc0WH6NVQcuivhuTLxiAj/GWjXxTx?=
 =?us-ascii?Q?dErLrwRSxg+Pi000rozx0K/wvtmExSb3QHoIn3rGPWYgb0Nmzq5OAAqZ5JvR?=
 =?us-ascii?Q?S1S5x8+JZ2wM/lbNbLiLDap5iCj2Gy/0VgWGoAzh0MxS5HDvoZKcV4uIB44Y?=
 =?us-ascii?Q?ty3FvIgqTcyFf/4VWRu7uvFqA6kTkzevmKiLzSpOtDECur0gsS1yrbQDBf9Y?=
 =?us-ascii?Q?76orI9zcnbPW88WkSx3XnYz0RnMcJjEVvNg/3LOFzJkkw+2q5+uWzxDuoY3+?=
 =?us-ascii?Q?Zn+Lqt7L4+48l2jMwZwRdHk3ReJoBc9fuggLsnXRl4jgAE9zBn8yVOsh2b7i?=
 =?us-ascii?Q?xqfKfL5ib2A7BgdUNwtPVioc5HJ7SDNq6i4J/mxzU6ykN7P3fPLEq8v2pAXC?=
 =?us-ascii?Q?Unn/GKOkeZYEXL8ETicYvtVBBjG8W7YIESsT6gb0uegUTG4qfYGFQsxyhkez?=
 =?us-ascii?Q?y/zyKhs9kTLh9XMJRVxdaNRTSjsAICd/nRsu5em+IIHi2PkNrl6vW/auyK3l?=
 =?us-ascii?Q?+n6BuyJ6f5QkiiaTXKKjYXl7mFt5m24hTcdWcQZteXKq1tVkj9UUUakJglGd?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74570a10-815f-4bff-f5d4-08dd8ddada04
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:48:45.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfu+V/Y4SD7D4PeC+GGJgFFvez0xNxs3ogzcxLDgMTlRXCbL5JvLzo1YrR10nYlDuM0uVxyhivFk8Bd1j7OKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_acpi_ut_safe_strncpy" on:

commit: 1f5f181b9bdfd4d55a058aaec0b6d17f18084e75 ("ACPICA: Replace strncpy() with memcpy()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 37ff6e9a2ce321b7932d3987701757fb4d87b0e6]

in testcase: boot

config: x86_64-randconfig-r051-20250501
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 9d57241663 | 1f5f181b9b |
+--------------------------------------------------------+------------+------------+
| BUG:KASAN:global-out-of-bounds_in_acpi_ut_safe_strncpy | 0          | 12         |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505081033.50e45ff4-lkp@intel.com


[ 16.282972][ T1] BUG: KASAN: global-out-of-bounds in acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[   16.283199][    T1] Read of size 16 at addr ffffffff88301f40 by task swapper/0/1
[   16.283199][    T1]
[   16.283199][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc3-00029-g1f5f181b9bdf #1 VOLUNTARY
[   16.283199][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   16.283199][    T1] Call Trace:
[   16.283199][    T1]  <TASK>
[ 16.283199][ T1] __dump_stack (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/lib/dump_stack.c:95) 
[ 16.283199][ T1] dump_stack_lvl (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/lib/dump_stack.c:123) 
[ 16.283199][ T1] ? show_regs_print_info (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/lib/dump_stack.c:104) 
[ 16.283199][ T1] ? lock_acquire (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/locking/lockdep.c:118 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/locking/lockdep.c:5842) 
[ 16.283199][ T1] ? load_image (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/printk/printk.c:2470) 
[ 16.283199][ T1] ? lock_release (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/trace/events/lock.h:69) 
[ 16.283199][ T1] ? __virt_addr_valid (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/include/asm/preempt.h:85 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/rcupdate.h:955 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/mmzone.h:2127 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/mm/physaddr.c:65) 
[ 16.283199][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[ 16.283199][ T1] print_report (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/report.c:409) 
[ 16.283199][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[ 16.283199][ T1] kasan_report (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/report.c:636) 
[ 16.283199][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[ 16.283199][ T1] kasan_check_range (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/generic.c:?) 
[ 16.283199][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[ 16.283199][ T1] __asan_memcpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/shadow.c:105) 
[ 16.283199][ T1] acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utnonansi.c:172) 
[ 16.283199][ T1] acpi_ps_init_op (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/psutils.c:68) 
[ 16.283199][ T1] acpi_ps_alloc_op (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/psutils.c:122) 
[ 16.283199][ T1] ? acpi_ns_get_normalized_pathname (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/nsnames.c:307) 
[ 16.283199][ T1] ? acpi_ps_create_scope_op (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/psutils.c:86) 
[ 16.283199][ T1] ? acpi_debug_print_raw (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utdebug.c:266) 
[ 16.283199][ T1] acpi_ps_create_scope_op (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/psutils.c:34) 
[ 16.283199][ T1] acpi_ps_execute_table (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/psxface.c:?) 
[ 16.283199][ T1] ? __kmalloc_cache_noprof (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/slub.c:4373) 
[ 16.283199][ T1] acpi_ns_execute_table (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/nsparse.c:?) 
[ 16.283199][ T1] ? acpi_ns_get_attached_data (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/nsparse.c:45) 
[ 16.283199][ T1] ? acpi_debug_print_raw (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utdebug.c:266) 
[ 16.283199][ T1] ? acpi_os_signal_semaphore (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/osl.c:?) 
[ 16.283199][ T1] ? acpi_ut_release_mutex (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/utmutex.c:?) 
[ 16.283199][ T1] acpi_ns_parse_table (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/nsparse.c:268) 
[ 16.283199][ T1] acpi_ns_load_table (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/nsload.c:72) 
[ 16.283199][ T1] acpi_tb_load_namespace (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/tbxfload.c:158) 
[ 16.283199][ T1] ? acpi_ev_install_region_handlers (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/evhandler.c:101) 
[ 16.283199][ T1] acpi_load_tables (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/acpica/tbxfload.c:67) 
[ 16.283199][ T1] acpi_bus_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/bus.c:?) 
[ 16.283199][ T1] ? acpi_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/bus.c:1337) 
[ 16.283199][ T1] ? kasan_save_alloc_info (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/generic.c:563) 
[ 16.283199][ T1] ? __kasan_kmalloc (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/common.c:398) 
[ 16.283199][ T1] ? __kasan_check_write (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/mm/kasan/shadow.c:37) 
[ 16.283199][ T1] ? kobject_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/include/asm/atomic.h:28) 
[ 16.283199][ T1] acpi_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/drivers/acpi/bus.c:1455) 
[ 16.283199][ T1] do_one_initcall (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1257) 
[ 16.283199][ T1] ? acpi_arch_init+0x10/0x10 
[ 16.283199][ T1] ? IS_ERR_OR_NULL (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1248) 
[ 16.283199][ T1] ? _raw_spin_unlock_irqrestore (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/spinlock_api_smp.h:? kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/locking/spinlock.c:194) 
[ 16.283199][ T1] ? _raw_spin_unlock_irqrestore (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/include/asm/irqflags.h:146 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/locking/spinlock.c:194) 
[ 16.283199][ T1] ? _raw_spin_unlock (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/locking/spinlock.c:193) 
[ 16.283199][ T1] ? t_show (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/ucopysize.h:57 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/uaccess.h:207 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/trace/trace.c:6336) 
[ 16.283199][ T1] ? irqentry_exit (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/entry/common.c:?) 
[ 16.283199][ T1] ? sysvec_apic_timer_interrupt (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/kernel/apic/apic.c:1049) 
[ 16.283199][ T1] ? stop_critical_timings (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/trace/trace_irqsoff.c:633) 
[ 16.283199][ T1] ? sysvec_apic_timer_interrupt (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/kernel/apic/apic.c:1049) 
[ 16.283199][ T1] ? irqentry_exit (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/entry/common.c:?) 
[ 16.283199][ T1] ? sysvec_apic_timer_interrupt (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/kernel/apic/apic.c:1049) 
[ 16.283199][ T1] ? trace_hardirqs_on (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/trace/trace_preemptirq.c:80) 
[ 16.283199][ T1] ? irqentry_exit (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/entry/common.c:?) 
[ 16.283199][ T1] ? sysvec_apic_timer_interrupt (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/kernel/apic/apic.c:1049) 
[ 16.283199][ T1] ? asm_sysvec_apic_timer_interrupt (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/include/asm/idtentry.h:702) 
[ 16.283199][ T1] ? do_initcall_level (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1303) 
[ 16.283199][ T1] ? next_arg (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/lib/cmdline.c:273) 
[ 16.283199][ T1] ? parameq (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/params.c:90 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/params.c:99) 
[ 16.283199][ T1] ? parse_args (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/params.c:153) 
[ 16.283199][ T1] ? parameq (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/params.c:168) 
[ 16.283199][ T1] ? t_show (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/ucopysize.h:57 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/include/linux/uaccess.h:207 kbuild/obj/consumer/x86_64-randconfig-r051-20250501/kernel/trace/trace.c:6336) 
[ 16.283199][ T1] ? do_initcalls (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1329) 
[ 16.283199][ T1] do_initcall_level (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1318) 
[ 16.283199][ T1] do_initcalls (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1332) 
[ 16.283199][ T1] do_basic_setup (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1355) 
[ 16.283199][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1571) 
[ 16.283199][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1449) 
[ 16.283199][ T1] kernel_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1459) 
[ 16.283199][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1449) 
[ 16.283199][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/kernel/process.c:159) 
[ 16.283199][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/init/main.c:1449) 
[ 16.283199][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-r051-20250501/arch/x86/entry/entry_64.S:258) 
[   16.283199][    T1]  </TASK>
[   16.283199][    T1]
[   16.283199][    T1] The buggy address belongs to the variable:
[ 16.283199][ T1] .str.8+0x0/0x20 
[   16.283199][    T1]
[   16.283199][    T1] The buggy address belongs to the physical page:
[   16.283199][    T1] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8301
[   16.283199][    T1] flags: 0x4000000000002000(reserved|zone=1)
[   16.283199][    T1] raw: 4000000000002000 ffffea000020c048 ffffea000020c048 0000000000000000
[   16.283199][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   16.283199][    T1] page dumped because: kasan: bad access detected
[   16.283199][    T1] page_owner info is not present (never set?)
[   16.283199][    T1]
[   16.283199][    T1] Memory state around the buggy address:
[   16.283199][    T1]  ffffffff88301e00: 00 00 00 00 00 00 00 00 05 f9 f9 f9 04 f9 f9 f9
[   16.283199][    T1]  ffffffff88301e80: 06 f9 f9 f9 05 f9 f9 f9 00 02 f9 f9 00 02 f9 f9
[   16.283199][    T1] >ffffffff88301f00: 00 03 f9 f9 07 f9 f9 f9 06 f9 f9 f9 07 f9 f9 f9
[   16.283199][    T1]                                            ^
[   16.283199][    T1]  ffffffff88301f80: 00 f9 f9 f9 07 f9 f9 f9 07 f9 f9 f9 07 f9 f9 f9


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250508/202505081033.50e45ff4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


