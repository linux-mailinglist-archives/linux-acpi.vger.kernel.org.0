Return-Path: <linux-acpi+bounces-14668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0AAE946A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 04:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195784E1723
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 02:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858211CDFAC;
	Thu, 26 Jun 2025 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVfYZB59"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90392191499;
	Thu, 26 Jun 2025 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906287; cv=fail; b=VxIPHbCnNyqaLZ4jhK4aD/wd7U0cWFBlV4w84xUUi+4zZXMPxjKGIJlxG5BjMcX9zCqC4e0SAg60QrLWGEuHcndcPq8C6mKL4j+bH7A5NEUWdw8lWXyHyMoJghztvQ9598eW0dmvHnXnbK+zcIErv4n/WgxoMbBKtK6UAdkn0iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906287; c=relaxed/simple;
	bh=8MkxAudyw7bJnlXbxV77pa2Qp42rSrZAlhm3aE67oyk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CG5UsG6MStaHxJSVupAIa5VHk7KCXRWFekc+/5+q2yZ29M5ursTAQ+EKOS/X7aFHlUHjTqgUZTgwsYPIeWFK/GmCkd2O+ZYZ9W0lRqmhJLxA1YSZ6W+h4sfnSmKQGnBrE7B0DKxRMpH0OqnF9UR0J+IfDVT3/eMKAgQggz4yT1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVfYZB59; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750906284; x=1782442284;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8MkxAudyw7bJnlXbxV77pa2Qp42rSrZAlhm3aE67oyk=;
  b=nVfYZB59oTMbXVxUZnuCL72aci93u73SezOJWLeRByqFAOLSLsdmwlRp
   gkjus2HSriBQEe+lXwKxn8ABPQY2kZkYXuJhivtnWEJw1ZuknUn3pOVzO
   4lKRmQtqyg6uXYrJ5oK/2aVLHc4IIm7VqGO5JMLu05biTy38XZfbDo/80
   wpuL2pkAKXseixWJwOAG+3h/Rxy3aW0jUhvDEK3HedcTlYfO/wn9lLDAc
   9mnkSziZ6N2fetkBYW8k40oBdindDzAN+5G7i1fQmcFpa7nqB+Dq3Hn6W
   1jUvh5LqCelh4na3CsS6tDOXy4II0rDo5ya6icqsEZdvTqXuQSZJINBUJ
   Q==;
X-CSE-ConnectionGUID: UpF6reQTRlW6lahKcPRtmA==
X-CSE-MsgGUID: GtGectsXTL6RZUUFbjyM2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53334484"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="53334484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 19:51:24 -0700
X-CSE-ConnectionGUID: 0N5VrHWfQtmbWdSWU611Kw==
X-CSE-MsgGUID: ZtbXnP11QNaz5OXUlb5JPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="156653129"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 19:51:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 19:51:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 19:51:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 19:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEZHe8NZ55bUk5WyxmyktZp9UTdRsMODvPSxLL8rvtI1zDdW9wk9VpeTjGR1/uQnoz+Lxg58FvrzBV2OCrhK9c2CwrJ+Xp0OE/9+Wx7FvgMLL1+/dtb/lnJybv9QZ9yH0Nq3IKHyM+5uL9BuruA8ihz1Ew/DBFx5zI5d8y3331JkW46R0wK3YcI5A3WpiFcI6tMX+4dlgXOrCH9Dk9mRISJBLgH6GC03PF6C0IJ6VRk1qGunb9DEb8bLmln+vG6BRMZfPO5BXR1SywkP1KarNnotL/CXef3vsHmai/e7gkk+ayWPwIG/EfGMKaTU0rdwdif8CiEBpE858qPlrkZPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBTTR1HjK6Op2oUEIh7uuFyr4baX5gKyWEeZUgSl8XY=;
 b=BjLjWpGtr5YTOy8DSCakDY17LVMb3nwTybVWQNRQrgJloAxlF57oHxsMX9URL+OreyZv9oEC5mAlS8Mnr3xlnsexyST9JvOrgW6TdidbdEo8sMqo432jyf3wWptSmVaXUT9d6SvdpDIXHUoTFbZ6LC78+6+iUOoySzWAlEzotAWAuzGodlawkNMGkHvsg2AgAn1knubukHBC4uFO0LfXeXQ5yddHjs1QFN0vc3jwEi8wteU0E2I9TsiYgO6x+jhA1pFlD38GZVpc1mKykN7AdDOtoXcF/kZDRtVk9x5Wwqth0oJR/PUj2B/px5QSti4YvaFbF1uDFVCJAjomDZd7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 02:51:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8857.025; Thu, 26 Jun 2025
 02:51:18 +0000
Date: Thu, 26 Jun 2025 10:51:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Brahmajit Das <listout@listout.xyz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rafael@kernel.org>, <lenb@kernel.org>, <lv.zheng@intel.com>,
	<kees@kernel.org>, <rui.zhang@intel.com>, <len.brown@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions
 with sysfs_emit
Message-ID: <202506261036.895ef959-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624133739.25215-1-listout@listout.xyz>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 606d6bf1-5bff-4411-0eee-08ddb45c5323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+FrBFrGt4NsDEyy57PHrTEo824pl9kaypt/JEiH4MMer0yRGq4L/Jp/ZXR02?=
 =?us-ascii?Q?2oevUSh8c5qCEohPnSsb3aR6dtYgR0iPb9v5b8njuqKx5MyLCdUoyuNwQIEO?=
 =?us-ascii?Q?7xxOWvnFVFGDGkwh2hFma0YBn5ydsC3oIr+awN+GHRzps/JGH5153xNenggt?=
 =?us-ascii?Q?I0xR/HrnQXLHitrCltuh4f0r347MHrSaohnfxoRkAAeYOCLYn3TujsZxnmzI?=
 =?us-ascii?Q?3Rz/C1ix9DwP+8u7bt5ZpnPoz0z0fVKEdMBtmMVwEnE1+t8rVOG+VaKRSicF?=
 =?us-ascii?Q?t/xAFAsb0tSmOtMgHbK5QIMDSq70agimXDncLviGrCT9X2FITP9dPjIiwRM6?=
 =?us-ascii?Q?m6aTHDhX09p5LZMkkNOE6R8B47BXxHpgerFq8EdLx/FODPTCg08JjhlnyMg1?=
 =?us-ascii?Q?oL44Ya4Nap/En4Ej945zoKQjVaMYZol7RbRfdmmfw6ObJ/B+Hhhav3FIlk3E?=
 =?us-ascii?Q?w/lNHEgp6gwQWEmx30hrl3jWI5XsNT3+gbLNFb9+DwIR4kQuE5TAptbiITUO?=
 =?us-ascii?Q?YKEV8Kh/rjjuVWPV8epRPDpsypqkdPUIBrtD64zuNGFNduW88Pj5r6qjeeOh?=
 =?us-ascii?Q?SzMSaWIHvM48gwmlkM/3S/Zy8F+HLacx/38loNpj1vwWNz4UgxY/cZoNRyWb?=
 =?us-ascii?Q?tYlipeTgJWB7bwKRBasf8UjT2InAKmxoMSqlkJ9VTbe6LOKiItvFqWNO8dMV?=
 =?us-ascii?Q?fg9Z4AL3aQb6ueUu7ncbkuBsiV7cFstpIFvL1A4CwCgNo/HulH2CeXEMHMrS?=
 =?us-ascii?Q?saJ1VZnWRGC8jXTIfTmNKIlXZQWxweWONj/9qb4BgBovlWwMAmUyQy9/bWXn?=
 =?us-ascii?Q?Sa4sEA99LUM6eyxYughPYr5FqKVqW2Agx5tMvUmI0Olx8h5yzGDU3j3UNke2?=
 =?us-ascii?Q?29+9fYmDNV+WS5WXPeAVIE9EQO+acFOdFD4OK18mNywbPlc0ilmg2xNQJO87?=
 =?us-ascii?Q?spS2BKSrZQQdwRmk8wE7NqST9PBfND68QLifiK0ruTE4ut3cmB+y3u+E/tfA?=
 =?us-ascii?Q?2kadBZdta5fxaF59xGhznGX/4MEKMs4CpNbpfX3wK/Qhq9h5Dg/TsyfVh5sZ?=
 =?us-ascii?Q?X4oJCtFBbMEQrEJ+Bv33MohVKsnHAGZ7xSf+R3XwqZZEhTVuYRge2fPuUSJU?=
 =?us-ascii?Q?CRNeA0KqPn8XGj8xoHx2DBHsmFkpXirfxvovJXhAZ9LrcCxXrUoldRjXyKF2?=
 =?us-ascii?Q?dJuAlT5ROKbdiJYrBQEiJCThBf3I0qyFPiv6kt+Z0Qq4f4tlDLhHXDTIzO0O?=
 =?us-ascii?Q?5iYzmJxLzi9HWwOcNSk8Emfc97c4OhVIE5fETpeBgLkItb9VoEUGb0qZ/Ibl?=
 =?us-ascii?Q?OC1DfL2OAB/g6xOFxKRR+C9WnHqiVfaM249wFOSSnrPpyOx/o9Fux04uEZom?=
 =?us-ascii?Q?opyPebSnSKxUQSKP2EtdyOgdeV7/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oGf1zIlwzwqefZeex8fL5RXI/GJu+MZizXSRl5/ByWz4IYcfF9fx6qIUmwH?=
 =?us-ascii?Q?zj1nRhC0xaCBYhgYwG6gipHcFbigWj+2b5fc1dIyaf2hXViaaWh178ha6Ddq?=
 =?us-ascii?Q?li6YO7yPg2kXZoaah91KKSsn9SMyePTNwXIa8MPYGZ6KsN6nMfeCd9lki0On?=
 =?us-ascii?Q?/No/f4c7fSif7Y5dFC7MmcfUub5mNCb95sIwd1ctZDNLhA0s+oOrRgEWer3s?=
 =?us-ascii?Q?ybjBge9JxXsYIci8zIyrljNjr55EVqApiJcno1+oMf6urPb6tdcTqIDcgED4?=
 =?us-ascii?Q?uXDfATezZoDCpdg4r6eW3CC0qOvnJJeyxLGSa6UspXUxhIquPTFp9Ew1tij4?=
 =?us-ascii?Q?+3fOXm5+wT+gNs0D7pxSFfiIN3sY6OqqWhLN40Z+KG07Gqjg5D/lxA3WJ1Pb?=
 =?us-ascii?Q?TEzOJnP4xr5V2x1KUEGARmKhZmeEmcD7A3q7tXf3bNweBOXFCEbDIyYWkGJN?=
 =?us-ascii?Q?/3wgZmDeYX2hLWzmpJEQWHoAJWeEJgh1No0bSPifCBKQh7xEjQwyiMzYKY6V?=
 =?us-ascii?Q?qhFgV/5Y6vJY6ockOfyTIdijcnXw2a4tqxP30w99wYx3CyCnbd8YRfYG4gA+?=
 =?us-ascii?Q?BIxwbMzmTo7zXJmyxXV3mno4Ve09HKKrx5iIkpsl4qBGGKrOV4/9pm3/txGl?=
 =?us-ascii?Q?oMz347qV9OapdhJIRmFhyC82HEIO4xuRjFyVisMF5Ia/9zEgk6sbXXPTq4Dh?=
 =?us-ascii?Q?hhEB8UxK4UVfRJi3FrdMh7L0ql09CTugnxmNDxxaM/lEnPzoIoAgLqP3261J?=
 =?us-ascii?Q?iACoUzUZLoiUmZnvTWhUBbcrVtwZUfTVoboAMH+K5J+7gK1ny+wNopnUMZ3M?=
 =?us-ascii?Q?Evd6RrsgitR9ECyB2gm7YsE3DOGte5j7MXfx0vZybQoG96y1+xdaPma4//R4?=
 =?us-ascii?Q?NFBDnom6UkmSMFn6K3w7Q99oAGGJ7OyGnIARhRC9c7zCuSZvBmXeHkV18JFV?=
 =?us-ascii?Q?/BMvx2vCqiIq2Ca7GgEP+yV9Z0PBQVOij/SFxk4cjjMzToYiBEnB78rNrFjK?=
 =?us-ascii?Q?3KtOGPuVB/xl9AWGJlFYUzoFAH8G63VCxDY9bI2H5KD6sugA23rXZTv5sYf5?=
 =?us-ascii?Q?Rldq0gmCxtGGTiqtIdqPogLVyk4FJR5mrql3S3uYd6Mxw46FN7RAtihLtnAS?=
 =?us-ascii?Q?GgFhufdMdTzlFf0mvhUdmBO5x88ryHhZYB4wo8SEYbgOjLM1dWbn435xWml1?=
 =?us-ascii?Q?oS4ap5RFlu3EKvFQk0s5/nX/scDPyxybouvF3Iou2b45W5E9DNSpLF061G1O?=
 =?us-ascii?Q?mmLwhYyoym8RIuS2mVWuNRUw+cnBSJUVfJ8ILq+X/QgDr8jsHw1buOz9HOXd?=
 =?us-ascii?Q?3w2qbJDkl+vZit4tNLdbBNVyBzazLifZZSeBRISfFDer96uA+tjEzNBXtVPA?=
 =?us-ascii?Q?8UBxdsfYRoWSQvcPvebCu5ZzpDlP6Zy0Eluho8mGQXerNdGnks0kB5O5hbEU?=
 =?us-ascii?Q?v03sKc9cEsbex2Kfmd1FnMu1OE33YrCCcowmxASx/Cg0mS2rq82HwYjtu1rX?=
 =?us-ascii?Q?sacw9kHBsni1cjvI/YNx2q4kJuKkhLPsDW75rgmd0eolf6cqmbX16FWIJ1MK?=
 =?us-ascii?Q?aNqvBuwt5zF9o7pPtFegUrEURx9URhi3asWoxNfZZOHnxL+n9MRHVxSApdnW?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 606d6bf1-5bff-4411-0eee-08ddb45c5323
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 02:51:18.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkComtnlblT0KTg6G5aVH9F85vOxcxbrtEZ2HSWx9hK/NvRkxOV547736FvgKMloLfOrTePtjYsb2Jvq6DvilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:

commit: 74191212ddb1a82ed54ddd75fcd820f3df79abef ("[PATCH] ACPI / sysfs: Replace deprecated and unsafe functions with sysfs_emit")
url: https://github.com/intel-lab-lkp/linux/commits/Brahmajit-Das/ACPI-sysfs-Replace-deprecated-and-unsafe-functions-with-sysfs_emit/20250624-213919
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20250624133739.25215-1-listout@listout.xyz/
patch subject: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions with sysfs_emit

in testcase: boot

config: x86_64-rhel-9.4
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------+------------+------------+
|                                        | 3cd1e195f0 | 74191212dd |
+----------------------------------------+------------+------------+
| WARNING:at_fs/sysfs/file.c:#sysfs_emit | 0          | 18         |
| RIP:sysfs_emit                         | 0          | 18         |
+----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506261036.895ef959-lkp@intel.com


[    0.410439][    T1] ------------[ cut here ]------------
[    0.410995][    T1] invalid sysfs_emit: buf:(____ptrval____)
[ 0.411411][ T1] WARNING: CPU: 0 PID: 1 at fs/sysfs/file.c:767 sysfs_emit (fs/sysfs/file.c:767) 
[    0.412230][    T1] Modules linked in:
[    0.412660][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc3-00031-g74191212ddb1 #1 VOLUNTARY
[    0.413504][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.414499][ T1] RIP: 0010:sysfs_emit (fs/sysfs/file.c:767) 
[ 0.415012][ T1] Code: 10 e8 d5 8e b4 00 48 8b 54 24 18 65 48 2b 15 40 f5 69 02 75 1b c9 e9 d0 7c b6 00 48 89 fe 48 c7 c7 d9 be b6 ae e8 71 86 b3 ff <0f> 0b 31 c0 eb d6 e8 a6 88 b5 00 66 66 2e 0f 1f 84 00 00 00 00 00
All code
========
   0:	10 e8                	adc    %ch,%al
   2:	d5                   	(bad)
   3:	8e b4 00 48 8b 54 24 	mov    0x24548b48(%rax,%rax,1),%?
   a:	18 65 48             	sbb    %ah,0x48(%rbp)
   d:	2b 15 40 f5 69 02    	sub    0x269f540(%rip),%edx        # 0x269f553
  13:	75 1b                	jne    0x30
  15:	c9                   	leave
  16:	e9 d0 7c b6 00       	jmp    0xb67ceb
  1b:	48 89 fe             	mov    %rdi,%rsi
  1e:	48 c7 c7 d9 be b6 ae 	mov    $0xffffffffaeb6bed9,%rdi
  25:	e8 71 86 b3 ff       	call   0xffffffffffb3869b
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb d6                	jmp    0x6
  30:	e8 a6 88 b5 00       	call   0xb588db
  35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  3c:	00 00 00 00 

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb d6                	jmp    0xffffffffffffffdc
   6:	e8 a6 88 b5 00       	call   0xb588b1
   b:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  12:	00 00 00 00 
[    0.415674][    T1] RSP: 0000:ffffcdc1c0013cb8 EFLAGS: 00010282
[    0.416230][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: c0000000ffff7fff
[    0.417231][    T1] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: ffffffffaee63ba0
[    0.418233][    T1] RBP: ffffcdc1c0013d08 R08: 0000000000000000 R09: 0000000000000003
[    0.419233][    T1] R10: ffffcdc1c0013b58 R11: ffffffffaf1e3be8 R12: ffff8c28408940a0
[    0.420232][    T1] R13: ffffffffadb37cd0 R14: 00000000000004e5 R15: 0000000000000000
[    0.421234][    T1] FS:  0000000000000000(0000) GS:ffff8c2bbfdce000(0000) knlGS:0000000000000000
[    0.422237][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.423179][    T1] CR2: ffff8c2b7ffff000 CR3: 000000010f024000 CR4: 00000000000406f0
[    0.423631][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.424609][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.425613][    T1] Call Trace:
[    0.426168][    T1]  <TASK>
[ 0.426431][ T1] acpi_irq_stats_init (drivers/acpi/sysfs.c:887) 
[ 0.427234][ T1] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:1320) 
[ 0.428079][ T1] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:329) 
[ 0.428478][ T1] acpi_os_install_interrupt_handler (drivers/acpi/osl.c:568) 
[ 0.429235][ T1] ? __pfx_acpi_init (drivers/acpi/bus.c:1440) 
[ 0.429990][ T1] acpi_ev_install_xrupt_handlers (drivers/acpi/acpica/evevent.c:95) 
[ 0.430500][ T1] ? __pfx_acpi_init (drivers/acpi/bus.c:1440) 
[ 0.431233][ T1] acpi_bus_init (drivers/acpi/bus.c:1362) 
[ 0.431971][ T1] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:329) 
[ 0.432485][ T1] ? acpi_install_address_space_handler_internal+0x64/0xb0 
[ 0.433605][ T1] ? __pfx_acpi_init (drivers/acpi/bus.c:1440) 
[ 0.434234][ T1] ? __pfx_acpi_init (drivers/acpi/bus.c:1440) 
[ 0.434989][ T1] acpi_init (drivers/acpi/bus.c:1456) 
[ 0.435382][ T1] ? __pfx_scan_for_dmi_ipmi (drivers/char/ipmi/ipmi_dmi.c:215) 
[ 0.435948][ T1] ? __pfx_acpi_init (drivers/acpi/bus.c:1440) 
[ 0.436380][ T1] do_one_initcall (init/main.c:1274) 
[ 0.436875][ T1] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 0.437233][ T1] kernel_init_freeable (init/main.c:1588) 
[ 0.437770][ T1] ? __pfx_kernel_init (init/main.c:1466) 
[ 0.438231][ T1] kernel_init (init/main.c:1476) 
[ 0.438714][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 0.439203][ T1] ? __pfx_kernel_init (init/main.c:1466) 
[ 0.439386][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[    0.439885][    T1]  </TASK>
[    0.440230][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250626/202506261036.895ef959-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


