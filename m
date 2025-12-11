Return-Path: <linux-acpi+bounces-19558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9BCB6ED2
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273AE3023541
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38AA3161AB;
	Thu, 11 Dec 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWYn5kM0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAD3164A0;
	Thu, 11 Dec 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478450; cv=fail; b=RgFHGX9nJSD+2flpxRK63BJykpvxf4EByWMHlGFcGyDf2/BBOkeyP+R4oF/ONcUVJGuFvRDQUWYAOnVhQHBlCN/YhzolI/PUtZX+niqh4cNvGExJpWY4wwWhzOfQQJnTxyMdvgscmCXrrUCKBZjRZHWbMs1LNPNzoXLQ05UjV08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478450; c=relaxed/simple;
	bh=vh5iSW0oT75/YW0M7gF2YBDyjuuM2tLn4HLx0YuJUgg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qny1K3wmZqCiyv6ysSpClmY3WStB85fqXrqtvpVl0D6dLXsYSIuZvWFh0bcYao/Ju9psY5krBhhVy/xl+3poTHunH+YmzdfDLSfabva8/N1z+fDiEL2AsEl2TEFFu161g/+6pbbjQf6b53cVC5ZJ5g25vnLHLwiDSWCsDJmy9vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWYn5kM0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765478449; x=1797014449;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vh5iSW0oT75/YW0M7gF2YBDyjuuM2tLn4HLx0YuJUgg=;
  b=PWYn5kM0Uyic11Goj4L18MJfOD16JXLtRYGOH1lZY9WcPGY4C9FHmt1U
   3tvZnPuddNCq+n1VjdgxbZzwSo1A06IkvGGQn61yD1KU+nIN0CYTxyzEf
   Aps6NYaU0qjM2BCYEfbcfQ7qkaBL8ee0fumSJhWfzq5WWOLXGXXLMXm0+
   RAwcdlrO78XxBYWhQnJHSRxFg/gYjwfO1RpM5PmlOJh3iC0gkzyVHQ2he
   7V1TsIzs5PMd41eCq5MbF8SdDG+uiAEXJktiyw1THDSjRE8FiAvTHlV+I
   sc/7mlXwpXGegFzD6cwPTOXTK8U88Nsg/9PSMRPuYjnJmBxox7be27sl3
   A==;
X-CSE-ConnectionGUID: TJCeWrlGQ7mKf1XngvYNvw==
X-CSE-MsgGUID: PWUpGnuRRFaDnUsT/8ElHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67640424"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67640424"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:40:49 -0800
X-CSE-ConnectionGUID: +QtQc91wRZ6l+BhdHoPqpw==
X-CSE-MsgGUID: 4bpHP9guTP+1kkxZYUmtIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196773297"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:40:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 10:40:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 10:40:47 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 10:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC0xf/nVil1UJFtuoHUoQ5D3YhN2gTHmI3AJ2isoQeXySLggBu1mTD+0+8+JKBLWz6P8Vnxj8L8d7XOaUabvOyB+Px448sIfmdh7zW53xfEt+60vQDnTe9VqT3C3Qekzxf6Ada2bvhCs/D6+Ym388NpKc0ED4Xrc7YYifrlR7F29H7XQZ2ZYmKYXQLGv04yViwnmZYz9KBSQ8HGlP3PNF8FZRJZZJ4rXoZWOH+ZOx4UhlYK6tUw3JzVvEzFWy2Ex5e2LkTJUfQDyY4uE7V/wL9ybyMmY7ZTJ9ak0HVxJkYKF3zn00y2Nduzis/NLngfLGALi7bqIIlUrWKfaZXogcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kLDIRk37e8JKs8rsEjotGh6NjCHEqb9oH4V+07CKXw=;
 b=jwwHcS4gTn7ml0t+wXs1Vwq2os7T+qnRThn6/wBTmFxl2BpLemkuJpJJZpnJpcYU9QsKw/JJIndD46hIeXegNsCJ3vds9jUsmCPa9BXDVO1tPXEzDHM8dFBdAe1nv6FMcx/gF4pgk93Kif30M4OnhZVvMj4F9W7559ZwKGyYInoPWTv7PkHG7X48ENA5CXb+kPI0MbulUKdOmfIjrafRCYeA5G+1wh9tCGc/zMD30t1OxRq0I9pkAsD2VcQgzPbhUjWYS1on5a5JpS4/c8tYyj6PcXsO2E53Hdo3jV7FzoGwt6elyIZvuo6mZ88CeVXQljjCQRtEzz0mdkCDa3+Zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 18:40:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 18:40:45 +0000
Date: Thu, 11 Dec 2025 10:40:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Armin
 Wolf" <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [RFT][PATCH v1 6/6] ACPI: NFIT: core: Convert the driver to a
 platform one
Message-ID: <aTsQKAJF5hpOixIR@aschofie-mobl2.lan>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
 <2028345.PYKUYFuaPT@rafael.j.wysocki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2028345.PYKUYFuaPT@rafael.j.wysocki>
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d04a878-2d78-4c32-bc28-08de38e4cb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0c3kbx88O1Fr/xQPSWMEPTUd1sTC2gXkOBrI+znPwi3GDTJfokAVO8rk1jQ?=
 =?us-ascii?Q?a8rgsUI17PKyb1YMgcB6mzH0Ax1PsJ67UN0jTzLI60G4oGJgdufvJvsBO3/f?=
 =?us-ascii?Q?B2dIjtaLoMLNHE1QjoCvj2VfOlrsI3pRsod1VrlrJsFbSrxKdAO2G00WK5x7?=
 =?us-ascii?Q?kF/HJmSjqDDeLG4HVg+T4w2GCTiD8py5N5N0K2QWbv6NSsLmqV17znBC+AZE?=
 =?us-ascii?Q?PRDP4NTS8+lg4frv3gldNyqZgFLa78h4J+ksmOYyj7xSp/VQ/uZULPUN2xt9?=
 =?us-ascii?Q?FYgG0m8U+R+aqxuVt+fWSKMCdu+a5htoZMOa+BPMR0EU/SR97mJUBJAjglhw?=
 =?us-ascii?Q?1rdhLjGzPXaPQYhHm5pntZFlzkHRLOH02nF9syFS0bY28x3JReBpJ/OTjN1g?=
 =?us-ascii?Q?o7dbUETXPf/IROX5JCvRpvapnjQ8SffR2LGw0HzimwIcclmRcDkTe0aVY+xd?=
 =?us-ascii?Q?BR68EziRywEOj5VeRijOjIcrkdLFHRHenS1zYq8HznsmARissh6wF5Taz9Xj?=
 =?us-ascii?Q?79IZJIrdTVz707LvGCngbcU3gWmmI+TtMYo0DbB/95fs7d1ItHW1m0/7DcZ6?=
 =?us-ascii?Q?mJc/AcTn7qm+2V/OHV6pFNvlkjGc/SNEOgyVNu4nrCrdYQ6rMETIk+mrEUFu?=
 =?us-ascii?Q?JtQoWDe4CYAY+1HFS64ovzqZYw30weYIQIck52T7ni6ehb3GqFt3kLZjEi1K?=
 =?us-ascii?Q?cQIR+3sobu579D8Pkhp/CRdGaBZGsr+0Vc8gYDfQsDLUhPPCEHohYw/Emvbv?=
 =?us-ascii?Q?9fLvKxgjM3Kh+t/eFt2y9Id0P0F9b3gYOyyRKV4to1nNhswm+mFRSdO+3fMh?=
 =?us-ascii?Q?BPhm8io8pWniZyavojwvK4KMyKjFXE6wdgRNFuYzANE4ZmeQhGfpgb/Bw4j3?=
 =?us-ascii?Q?LjhTlSqMdAmp68kfQYQBDXd1QuwrPPaer2NWWpvfEllFfNAXSAMTG3vlmHB4?=
 =?us-ascii?Q?qJdbr/oTFzN4EaL3+vVjotdiJnLpvtfacOExTdn8pNfet7dpiscExVbWKD5C?=
 =?us-ascii?Q?kM4kHg8l/L+F7KqagXoU0PgxLgqvsA2hs5fGXBVvPP/Hnv67poQOJGEeoETh?=
 =?us-ascii?Q?1ion0LVr3vY6wgHncMhO3bCguz1z8jwfNgZYAHKJiV4IMTsguKTxTA+aWynK?=
 =?us-ascii?Q?Em9+j4s/AYB2vhLla19am5l+KJloa7OeDu8RjDMJ72+ZxIxyDQeK+NILItUJ?=
 =?us-ascii?Q?XlUsJo7FZDQfXjrjfgNDn1qf8dUE+3apRAJVPTJRDSUZvDw7vGiFzMIJlKEo?=
 =?us-ascii?Q?Y9gbIIvOpf9RsywlxSeitXzN3N8j6I0LBkEc+uOApLZUQpryE2lO9yHYidAu?=
 =?us-ascii?Q?vZ1JOxLOvhN7B3Y3rKzVqkbINBlTaemO/y3/sPa740ZGkMtEKS1rz1NSoXuB?=
 =?us-ascii?Q?FxZ96Z7uci/6BfScBj+oxlapCRTYLZ5/2KY3cmXgiTDQZO/r0J/4m4iyZytT?=
 =?us-ascii?Q?K2RUptNaSOYArpp/3OkGKRr60ydbpSMflDOevaLUmt3aCOij6wrEvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKMcD8nImLeOdGzSF/aWHDfO9cREZVIQpyCr7hsZMkiDCW6A8qgry54Ceqyb?=
 =?us-ascii?Q?gORXRkGXc5Xt7FbyLhZA929CZo7lnMNF9GXos+/Out9gyiBg4Dd+1dwucwUJ?=
 =?us-ascii?Q?n+EB1uTdQ/Q45wB3v6cgIWFAPN3C+KFgIqys/kV7OKcE6kfgKZxTGFkUumHf?=
 =?us-ascii?Q?ATBm8wnmv7RHTwsutXe6Tn/bnIQJXbSG5qqLg65dMWEqMSKs4GpZk1uiXgKC?=
 =?us-ascii?Q?VKXEweRtRTzSJR0S9C93NBywvleVGYsf6v/2ywABAReT9LxoaWpm3DW0mVnS?=
 =?us-ascii?Q?rTlE/twjH44O3FVpekp3Rdp0BAAAyA4XDSA/zv/dm4DKA88L26El5uzEDygO?=
 =?us-ascii?Q?5/O71Y7FuXsZH9ojf0naMsVYh4BONIXno08JDqdSaFwgHJs6NaWDjy0C1S5R?=
 =?us-ascii?Q?WLmj1bH3K/uGd7CzgtXkyJfbSWBx+ghD0hOO4FGDO774aEiiQV4tGUePqd1T?=
 =?us-ascii?Q?TuM7sGb9WmcV5IWoRYVtgneuwJ6dT8kCoBB/odwTejQvopJgFMF44w2MNSE+?=
 =?us-ascii?Q?s/HEfo/VD5yyVyJqJ9EaiB5fSzQZgkFdHB2WkAM/lPvA7VfcrHWUBxESW6Y3?=
 =?us-ascii?Q?hMhzBUvprHPUkKtUYPDnjqvUwS0fEXal4OmAJZU/jk3Ak00cagD6DDZYQpy4?=
 =?us-ascii?Q?RvM3drdej8cOe67+KQ5z0SKz/GFQTWV/P8SdVZ2pG737HNLjgrrMd+VfQ5rY?=
 =?us-ascii?Q?l4Bw2F0mLSrWNRcIDVpv5vylQcadKZI3I7Dm8pjuQm+1JXVt2pjJ4tkjv9F1?=
 =?us-ascii?Q?UVKdTPgq+I2Oz4LoP6xlHsbjs7GYbzzguaNRCe82aCBfT6kZLowB49ky1u14?=
 =?us-ascii?Q?b1M/pecxZi6qnnfdH7hjhvNeCDdEIhTglIlLUiVzCj7Wdp48ij+NzPowwEW0?=
 =?us-ascii?Q?Gb5CMkA91cckPnWWtYb9EzBKWnZp+Lvf+zMZvmVy/8cohBeuOUjk9ds/n08D?=
 =?us-ascii?Q?V3q3+QhWzKO/xQswYI//X5YF0G3PkWKNWVeCKQsmBj+p1O//QNR7Hj2vIMBI?=
 =?us-ascii?Q?tRHbf6SnEEo/sdnIb2W+0DHLU/WWmjnBtDszgw1zfzsRhPr2QRxC1ljBNNU0?=
 =?us-ascii?Q?KgM18CHqY9s53+T49bhVLKymYryAv7tFjKibOUTD1zsmlRtfBJe7PWehB+2A?=
 =?us-ascii?Q?iZ/XcX+iifuHiHoTV53c77IwvsDK92L+aHGsZktIvI3ie2gUwnpk+IzUJNmi?=
 =?us-ascii?Q?F+joPt5TXrRDL2MynDQnZlqEW/9i8lWfsd+D0ev0HQ0aqukCy7VBI7OyJSo6?=
 =?us-ascii?Q?Rj1IBh8at7jcbJvibLNKcsQUIhbhgSg0zqCXl9xX9PxSLwGoGa3uN65zfL0J?=
 =?us-ascii?Q?pNkxTBF7XdmwXHpjmJAddxYciAeKEoCOorzcz6qN5/DAMNXfLnDyVyfbetBr?=
 =?us-ascii?Q?f7Tj/ud8ir7dhEYYg3iEeQupQ6iQvz83BEk1gPHVvwvu4t3QjCMWEyHG9HE4?=
 =?us-ascii?Q?4ajwZglJG2E8qD+M30eZ302Cg8MTg7vZrGbpIgdpY2KaoSjLrn+mzrDaHOlv?=
 =?us-ascii?Q?lyHeVyBlyD+JPXgnlx4XWNS/mS2AIUe9L1+de/SOG1UKj4L2zI1Ho35TiuES?=
 =?us-ascii?Q?vHDlKIU7sAMoOkhryECLT9Od8UyK6RTxi1iy2+S4IffCcmPkMYdiSZPiO0B4?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d04a878-2d78-4c32-bc28-08de38e4cb58
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 18:40:45.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFdsJd09ddHsI9wUlP6daJQL1omq+vbluvWpj/72XJ0cELXMW2JK4ysLtZnb3d81Rhpilmcl4d+6VHpiDGWO0lF9kTOWh3IMAMxAtGWf/Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

On Thu, Dec 11, 2025 at 03:22:00PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> While binding drivers directly to struct acpi_device objects allows
> basic functionality to be provided, at least in the majority of cases,
> there are some problems with it, related to general consistency, sysfs
> layout, power management operation ordering, and code cleanliness.
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI NFIT core driver to a platform one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.

Changes sysfs layout? That means it changes sysfs paths?
Does it change paths defined in Documentation/ABI/testing/sysfs "What:"


> 
> This change was mostly developed by Michal Wilczynski [1].
> 
> Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/nfit/core.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
>   */
> +#include <linux/platform_device.h>
>  #include <linux/list_sort.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/module.h>
> @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(s
>  			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
>  		return NULL;
>  
> -	return to_acpi_device(acpi_desc->dev);
> +	return ACPI_COMPANION(acpi_desc->dev);
>  }
>  
>  static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
> @@ -3283,11 +3284,11 @@ static void acpi_nfit_put_table(void *ta
>  
>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_device *adev = data;
> +	struct device *dev = data;
>  
> -	device_lock(&adev->dev);
> -	__acpi_nfit_notify(&adev->dev, handle, event);
> -	device_unlock(&adev->dev);
> +	device_lock(dev);
> +	__acpi_nfit_notify(dev, handle, event);
> +	device_unlock(dev);
>  }
>  
>  static void acpi_nfit_remove_notify_handler(void *data)
> @@ -3328,18 +3329,19 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>  
> -static int acpi_nfit_add(struct acpi_device *adev)
> +static int acpi_nfit_probe(struct platform_device *pdev)
>  {
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_nfit_desc *acpi_desc;
> -	struct device *dev = &adev->dev;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct acpi_table_header *tbl;
>  	acpi_status status = AE_OK;
>  	acpi_size sz;
>  	int rc = 0;
>  
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -					     acpi_nfit_notify, adev);
> +					     acpi_nfit_notify, dev);
>  	if (rc)
>  		return rc;
>  
> @@ -3369,7 +3371,7 @@ static int acpi_nfit_add(struct acpi_dev
>  	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>  	if (!acpi_desc)
>  		return -ENOMEM;
> -	acpi_nfit_desc_init(acpi_desc, &adev->dev);
> +	acpi_nfit_desc_init(acpi_desc, dev);
>  
>  	/* Save the acpi header for exporting the revision via sysfs */
>  	acpi_desc->acpi_header = *tbl;
> @@ -3474,11 +3476,11 @@ static const struct acpi_device_id acpi_
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>  
> -static struct acpi_driver acpi_nfit_driver = {
> -	.name = KBUILD_MODNAME,
> -	.ids = acpi_nfit_ids,
> -	.ops = {
> -		.add = acpi_nfit_add,
> +static struct platform_driver acpi_nfit_driver = {
> +	.probe = acpi_nfit_probe,
> +	.driver = {
> +		.name = "acpi-nfit",
> +		.acpi_match_table = acpi_nfit_ids,
>  	},
>  };
>  
> @@ -3516,7 +3518,7 @@ static __init int nfit_init(void)
>  		return -ENOMEM;
>  
>  	nfit_mce_register();
> -	ret = acpi_bus_register_driver(&acpi_nfit_driver);
> +	ret = platform_driver_register(&acpi_nfit_driver);
>  	if (ret) {
>  		nfit_mce_unregister();
>  		destroy_workqueue(nfit_wq);
> @@ -3529,7 +3531,7 @@ static __init int nfit_init(void)
>  static __exit void nfit_exit(void)
>  {
>  	nfit_mce_unregister();
> -	acpi_bus_unregister_driver(&acpi_nfit_driver);
> +	platform_driver_unregister(&acpi_nfit_driver);
>  	destroy_workqueue(nfit_wq);
>  	WARN_ON(!list_empty(&acpi_descs));
>  }
> 
> 
> 
> 

