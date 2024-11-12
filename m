Return-Path: <linux-acpi+bounces-9511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E66FA9C63E3
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B655DB28945
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC1219E5F;
	Tue, 12 Nov 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0V5mVQS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F152170DD;
	Tue, 12 Nov 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446893; cv=fail; b=NVRXvQ4bqxVnIR0ME6oz2CC6gfUcxAuDyC1zfK2ucvlKSTI252bYGxp77Stm1gFUUt6vEBNW6twCFqELjSQZVzVUcCkE28SxFq0r5uMASUQ46PfT9cxc3w8bt9SfQ+0HBYM3J2y2qrVlgp0ztxKKf1zD2LyGkYEFqdHwXU4/D+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446893; c=relaxed/simple;
	bh=VX4hFP3eBaLMLYvMMGCCfYLSzMcpq5r0S8OTPb/BVjo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQDiocxuLj3d3a536F1wL62RZW2iwiEEmNMI1S/janSbBviTfZptvyUq9RFZMN8ZuIsgyAc+fQQonDbyTLRuyNayoxbsoeiu72q/k8zKHoVFoEYeSBx4wcuBE35tpDO+vqwaUNp/xtFF1/xheuAUNBIP2emYUu3OA/TSl0/PR3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0V5mVQS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731446892; x=1762982892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VX4hFP3eBaLMLYvMMGCCfYLSzMcpq5r0S8OTPb/BVjo=;
  b=j0V5mVQSeNIF2yisBWzagb6qaK99D68QamoTYZoC9UJah+Fr78X0rm7w
   Tk9JOCiy45DsvirsDKs1QNOtpQ5We9pG+laYSZjpkaHKRfAgIxM/Lkzlz
   eEY6tmlTDMBBgUFhc8wPYvCe0noH22M7shNtFRfPSHdkXTJqbHEDP9IN5
   YXSKuZDH2oTLeq0BuZP9u6+6wNchPM5nC53jvqTc7FYwGVhuqhDhKwxRd
   QSNn/cDVSSN62RuQdP5R9OGDMnlQH+LvM4y2YMiGbFFlRkX1GneMIEywv
   MKd8kIZjdmBs0GicICMDZv+emdHWakQn56M32h7cC0/nq154ft/UW0B+K
   A==;
X-CSE-ConnectionGUID: dDelJz8xQhCkg2Fh1nM+Fw==
X-CSE-MsgGUID: 1j3BNckFTlCW3ojK9zU1SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42414314"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42414314"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 13:28:11 -0800
X-CSE-ConnectionGUID: QSayiAaSSzKkB1+i06JBBA==
X-CSE-MsgGUID: Rx8pJjLmS/aaIM1HkVj4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="118484845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 13:28:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 13:28:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 13:28:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 13:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcC7gucwRQ0YsWZS0RQe7w2jvnakgylnnU7OIjpI1B2WIyd16swHpDR9Pn5Bke9lBGme1lWpZo9zNJmnQfxZM7TQj20SIzj3ALmayH+IinCfKmyqOS4UdUPg+P9rtNAI+MBT50nIhE32yMZ60088SjU89QRSVfyhDu9t6ptZUSOeJ4zcsEx/EXs6OzPTJDsF/mXHYTdhxEyEG9QveC2o0WPyBtbVO85hQOrbed4pe24jGMGwUU/ChtYMVfL54feIuBBBKRbf4zyrOELR6cDqkqbhSRJvtBrksh1uzuswKkSYCUE559k9vH+KusGLQDEJapxy8gVPou7/tTzrVz4sOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cNviGAGFhW2ZsERNMVub88sX3rQBYtU4o5WnqPE7wA=;
 b=zRyTUKbjYVwbv9AIKBweSAaJRFRgFdS+27x/tHVaisqCyME5bcJHvvgK34f+FdQ5bVPulJ3MUEd1WNQzioiWoq/agF2VXRVL8JGE2YLsF6VfdfWMy1TGWD3LsrsmcLpPc9X+2MJ21Z801VaFUWrAhVY9l+68AnH/N6vOcKhu+1hroSlwRpTlsDi4qjB9X4kj3StjT8lJqO90BctkvFeRWOyg9HxbPRTkaYFvOJ8oOEHwl0aNFT6ciI/ocXeGeQzpw0o6U4Soq+K28FWgySYS9C3iGcWsPlsDoRt+o5TCmtfQEizD46h7NT5HKOs2rAdYQ98pBKt0xtfR8Wx0euxd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 21:28:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 21:28:07 +0000
Date: Tue, 12 Nov 2024 13:28:03 -0800
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
Subject: Re: [PATCH v6 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <6733c86390c40_10bc62945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-2-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106155847.7985-2-gourry@gourry.net>
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: af038abe-761a-4129-c822-08dd0360e653
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FUs7Xmef2UPtoFgCLRhGVTcv3OZWKZli6/JU5X2aNnxxR9enHP/tzKT4+qBM?=
 =?us-ascii?Q?lxHTd4uzZ401hPX3pHovU3N+GIS8R2AkrtZa7pC+BrLG0Tdwrb5h52XoDHiF?=
 =?us-ascii?Q?/AjJsji1L9yRP5FeVcGAkv67sck2uhJhhmKOr1O+Niuztam8/mnVoa9jGJkc?=
 =?us-ascii?Q?S3fbEHk3rSrjBLl07qYHQgA2D7QzDx0nax5rCpR2xy39+BKnLSn4YH3Jl29i?=
 =?us-ascii?Q?lZiI91zAQgMWdJuKAcl6jk0LP7nBC8adG6tYrrXh+u2SBSpvSzsy28T2kbhC?=
 =?us-ascii?Q?AOYUlgBKDv00ZYufEpPNTX+dePTja1IgbRx72Q9EChXyhc2y3yq+50HJURyK?=
 =?us-ascii?Q?nIi1ixAv79k1nJZO85qfnHYlMqPzk9+f8Mo4/O3hkwo/L3rlqylJ1Dq7jjkC?=
 =?us-ascii?Q?csk8deM8A6GZxR20cCjSQFiMbB5L3mPxmE0Q7iKRVIbFy6YjPio+zk09Wx36?=
 =?us-ascii?Q?/TYCEf8xZwg4VLJFM0YtafPwAVPS2AslPPb+EiE2YrskFtw60bNyr9jUa6Pc?=
 =?us-ascii?Q?Rx/BsgvrUdkvbz7FxbbnS68ks2YC+vWPbRVYn1ccpGM7iMG2XAE8N5HFK06G?=
 =?us-ascii?Q?I31yD00uEb77mxp3gR/9ikXL7NLwvNHA3AuHJgsStmDvUKQyLfoBy3V0DXrh?=
 =?us-ascii?Q?A8TLMPMXJbeZQcGfDhmJ9I/BnJTQPA6mEpRJJVAtcKTdz61QWyo3uNI5TbdR?=
 =?us-ascii?Q?UwqoBc+YYM7rdCyPbxtfVikIPBpBABEmrLpTVaQTVtOOkB4cTvOCI6aMDGhy?=
 =?us-ascii?Q?vTmA91qlwYolTgbpPnsdtAO9uDq3g7STXt4j6O9yjV1QKCo9Y/VAaF0j+KFt?=
 =?us-ascii?Q?TcYd7oy0cvgDdCTbaHN5hCwI2LKCbMlB7qpHz+uG1iOPhoUGMn1chfZRfXaY?=
 =?us-ascii?Q?+5rWbreI1idZbbl2xNGnXNfzv9A9GPPpPf/owluoBe1gJkR8urU0G4LeFEf+?=
 =?us-ascii?Q?HFKaA5GtGCoNPnOn1KHvYWG80cNDLOUh/cMe1O4UjveOdd1VDUktpVy7Vzz5?=
 =?us-ascii?Q?tT9bHw5NCitYlphWqCGv+Yn6HYTNfKcP0l9b2prcPiS/ePFG7XbQAW+rOS/q?=
 =?us-ascii?Q?p/zs7oslPxC4zzFUU04pwZ8vJLbGIgMNAy6q/yJlfqQxkKEc9siNyPSD6QrT?=
 =?us-ascii?Q?hWSNL/Tffb1XVb/cxiRE4OLnGUjnOhGZenX7346wh6F4JXTlgrLTbYn0gTLb?=
 =?us-ascii?Q?eYyl/RCDPRkvu1OIz1gJCnsz8BQQ+/RBRmlNIRwCn8bc2a6J4/EXgKl38f92?=
 =?us-ascii?Q?Vs2G8SDF2Eb6Q9ukSa2ZggwKE+Fzl/qhAmvjzjpM2gy0bfZRXvD99JgvewFf?=
 =?us-ascii?Q?Xmk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbtFioTD4RZmaY3W1m2UgYNWvUklKAwrB6Qxoj8GpexprIgPDVYKvYz0hBOR?=
 =?us-ascii?Q?5naGaGoCc3lLgvqfRu9IgO89BJLp4tzUFLnwL2YxEGKL68bPtJ23iUSeTNK0?=
 =?us-ascii?Q?VoIJcJs09yL2RFcw5FwnUfNEUfEL6FLgLanjlwNrdovLjNfe+qgrafrsjG34?=
 =?us-ascii?Q?IoTdRLRDoRuAwqpUIfYmH6L+kuSTvbOcMFTJjQWkXskRHorXNw13d8Ix+RPp?=
 =?us-ascii?Q?5y+2jgkrM4qzryXeSUjA4uHyg+TN7uWCuu4KnmobBLIpbuSGiq0jX27s4ybU?=
 =?us-ascii?Q?4YRE27mUBQSB4T1kUnbg8b6Q8r3drm0uNZuq9FsvADO2ZuBadWaakroWfIpZ?=
 =?us-ascii?Q?NPXmVnIJ86ufGlNUapllT0gFTU+bHG0c31AveBMDZoMsLVCrxMrtftaqzW5e?=
 =?us-ascii?Q?bgvFiptX/5DvhF8KEO7Szfaf3CbLap1b+utcbw7uLeiPKw4XXZQgCFkq1htt?=
 =?us-ascii?Q?xtlFA1nqgit+XMVIceqBJXl6lYt/Jz1anGo/vaZe37PjbcuqSH1F6+MLkkTn?=
 =?us-ascii?Q?PjZJ8ugLRlVPoBpVHWlbnIp5Z3mND3RYaNjoFsftbW1quWUMl4Pi9MWhFrI1?=
 =?us-ascii?Q?pgQv2XMZ8N+3mHV2hImMNQTN8M+FOeKzOu79rawz0Q7MrAZr1VGBWVHys/js?=
 =?us-ascii?Q?+wDbE7HE0SV8+mlf6UB+EIedZU3Hhc45Xqpbu0mCzEPlFF8pZkglhWllmYPm?=
 =?us-ascii?Q?MDlTHK/6k8fg2clk4IemtvSv0AT4f8nIPgZz4sQaxNBujnK/mNeZ0pNNnRA4?=
 =?us-ascii?Q?KS1B/OBTWyrYkN6YdAKWZK+7S72wIftlCXB+2q8HM8NFASfBixfCnjf/GM+3?=
 =?us-ascii?Q?1r4C3WknyB0C5PzKwHthVXysrE6zTvrZSIutFsOriQ1Gv+J5+77xQQoOMcFJ?=
 =?us-ascii?Q?IdT+6q+FRaI5bWWnx2AlQ00Tbnv2uXevWUU+z+ee+rJ0RQH5g5M+JpSGEeZ3?=
 =?us-ascii?Q?/BuXX7nJIFK/kNtAKL29aKox1/n6tVUR5Feuf7JPdZ7bVhV7jndtDeuYnYR5?=
 =?us-ascii?Q?4ezvynFnByEt9lP4Vazn35WP6pqyjKn1I1Jy4dcrO7tD5gwKWNldSP7W/+9n?=
 =?us-ascii?Q?OUTqHWuDEHUnQjeMfPUiCQwx6nfumg44SL01PymXdpDymOsVkWqQngKe1KlM?=
 =?us-ascii?Q?taSVfusyxmuLYjN36myJJxtN9rrWOIsMDUNlZrpylC5Rajb4ZtdBm3CRw0Bw?=
 =?us-ascii?Q?9N3utxXWiUffNXKn411CWqyFc2gGpl6eW/7wDpfhacc+DwlCcRWYKSinGJgj?=
 =?us-ascii?Q?VZcnazJKh+kaRyP7KTPo+2ZnusilK8C1FhLTxbBeLSA9HQlXerJisdWAb0L7?=
 =?us-ascii?Q?GV92RK39s+nsPl3tVL9d5swNWZTlj67KxqKWbTKkFAweT1+wriUMeM6WfExl?=
 =?us-ascii?Q?wSompXYzB/ym5tH2sYWBH4zZrJFej4OrYQzN7J7ck7rUTYBrRzPJ8ai3FsiJ?=
 =?us-ascii?Q?mMt8Ych9zjxrWByktTKX4kAixvvDOHo/pVG5QT8ziqzWNoQUyoxLtZgQC53y?=
 =?us-ascii?Q?ij1zebCg46oc8TDg/9aNnSi/5kgqwaskcD6IeozwykdLfM1bL/UWIMriKOjO?=
 =?us-ascii?Q?qLSoRFtNFN/LQWlZg8UTaHuYFZALfBB00nWXBo+UDMM4Blwpj3Ml5kDlN213?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af038abe-761a-4129-c822-08dd0360e653
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:28:07.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwMikE3sph9iCPQIKrA+puPOPRRqBfuMB2WH6H6QRtrhv8Y6dn9oXttXk+4QctNjXY4PwmhmaS8CMdL1GO5j9JktcvpInQyDqU89sp5Y0xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be 256MB with a matching alignment. If this size/alignment
> is smaller than the block size, it can result in stranded capacity.
> 
> Implement memory_block_advise_max_size for use prior to allocator init,
> for software to advise the system on the max block size.
> 
> Implement memory_block_probe_max_size for use by arch init code to
> calculate the best block size. Use of advice is architecture defined.
> 
> The probe value can never change after first probe. Calls to advise
> after probe will return -EBUSY to aid debugging.
> 
> On systems without hotplug, always return -ENODEV and 0 respectively.

Should the advice just succeed when the result does not matter?

Otherwise, it depends on the caller to not care based on config.

I do not feel that strongly about it, so either way:

Acked-by: Dan Williams <dan.j.williams@intel.com>

