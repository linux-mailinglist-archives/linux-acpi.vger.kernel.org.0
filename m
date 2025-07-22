Return-Path: <linux-acpi+bounces-15281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B9B0E084
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D218C7A9291
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711327702E;
	Tue, 22 Jul 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpOCdtZ9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532832036FA;
	Tue, 22 Jul 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198287; cv=fail; b=JLoDzpSRZ6PxLvdTLAQFekPeoFEUN2vemNJ6QbxmGQfE+Xm656w8bBUQyNr4kPOQbBjUDRECSqrctSuY8kBudMJ/2jdONOA/l7OqqEWdt0tL7O2VrTKRghlvHqPgxxIq1bMILekipr4cJISDtZ2I/bTnbXEEaQkzqbyPlWRlvJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198287; c=relaxed/simple;
	bh=jL/8eSijhBmczE7Pa6s9MzqR7SqLEBML1y3pPM9/8Ok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0/TS/D8k0ZPqJ9Zz/iF7LsiJVKmZkPxrrUpvtdO1530/3EobQiEvnijQ9Cjtv0I0+x53Xq8b6/G8eDym57r+bz5WJYlKi9PN1sLZCPjE1raHGj/JUjP5RwdxqveSfb8Nl/r5MKs4ah/y3MsB6xwtjtGKqKwFIldtz317xG9e20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpOCdtZ9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753198285; x=1784734285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jL/8eSijhBmczE7Pa6s9MzqR7SqLEBML1y3pPM9/8Ok=;
  b=PpOCdtZ96ROxeMGPOq8gmMpsxb09+afXgixJNRxsVSp8Y+Am2RNFmVVD
   wPAoKmWBjmUSWnG+7aKb5Oq2XsCxEopE+KyAJumKUfDW71auctGG9UY6M
   Bgv8lLzMhd+YKNkX97B/OYWCBiKKn1teqQNIJeuWDTW7tjeDn8drBm7K2
   TWn93kyoe9NlhSezOYiwFs31XCHB8e2ftNuAPza5fZTCHsZalYh6PsYr0
   N+4yGH4FUsyA28tMRHK11lPlhb843SojYfBkHWYZFGXbrHTJSra+C3oBq
   5lC08YowE9A8rQEGknZ8uuy03YLgPVXMZCOqlgHU4aPR63Q749a+YEIJf
   w==;
X-CSE-ConnectionGUID: I2MxWpXcTCi/jsFg8JuMUg==
X-CSE-MsgGUID: vR7J2DgrRA6cpGqLWNTlqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66141773"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="66141773"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:28:22 -0700
X-CSE-ConnectionGUID: lrcpsCtHROyLYRrh5GNfyw==
X-CSE-MsgGUID: xGbD+vRHS5ucJPe8hoT5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158476983"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:28:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:28:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:28:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXvwFh15X2ShxcLBqX4KN/tLluZeeAIoaCJwYDkCo4jYGaVi05f1qRQbNJWP3sIeCAhFs55kUPfy99sxG37KE1hCYqQWnf3z5ibK8jtevPcvKqqbpB7J5l+W3vC6KOUYEfEy0YgO+/KIuLisSMp9Fv3tVVF92Xw/ebYG84egP0Uv0lXpXXGTY2kaS18KSW4NPtfa4qtdjc0PciZ7L3sKO/Uei2IiIrNEU6vOyJuTK53ZETsezoKcSgN4pHerXP2QOzOvrXoyQrWa6gPpe30h1iRs92ft+ccxUyx9mgNx4aHLzHt2eFw0F6f0roWYCVu6gIawrVRNwcTa3jyrr4XYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8ITy/HNiKd5Zr6PEDxdA5FiRnE3LCL1OyEGyLfnLHw=;
 b=cRo0qHY5QQF9+pkdf7pVx8G7LERvHwlvscxMq7pgFZ3wHlIBhWRw3UzNeQMV/d9CprnDez+uvQgU+bHNOf6ni3O3AODZhHKXaOqYkiRTRCB9HglkI78YpuRWi6hzDcCuRtirwbu+XIOVU1L8vwxEyawlYjsoY8E+hkGASwnwfmek3MdcJLBddHhCiMEVF4HEaOChi6aHRGFABkHRZc5oKCbJhPbb9FBoZoSTaeLMZV2M0asPPK7NeGFb8LP/zGXMAn5Wotim5avaibuBLO7UJYILdnyrugMcYtA+MC8kvQJPGWryRzfRk+Hrpm/6vsfl/EAC1rAC7145qzAoDqw/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Tue, 22 Jul 2025 15:27:51 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 15:27:50 +0000
Message-ID: <b3c72614-3d96-486a-90f7-dc1f817ab700@intel.com>
Date: Tue, 22 Jul 2025 23:27:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: pfr_update: Fix the driver update version check
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@foxmail.com>,
	"Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
References: <20250722143233.3970607-1-yu.c.chen@intel.com>
 <CAJZ5v0hskeS3fKU3OPow=i8Nh4NojsUrJJrW=oNJAb7tP9P6=g@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CAJZ5v0hskeS3fKU3OPow=i8Nh4NojsUrJJrW=oNJAb7tP9P6=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fdc903-7c5e-469b-6003-08ddc9345060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3BQT29uTkszdXAxUFFTMjBQNTN0Um41VnZqVnZmaHhTMS9vL1JiYmFldm1N?=
 =?utf-8?B?M0lpOFJ0aG92emJiZzE2ZGM3UTJiT0MzL1R1TktTaldlUjJOS3p2M09IaXhl?=
 =?utf-8?B?K2tub21PVWRzZFI0Y0xZdWZqNldQY3FQNkgxeTN0aFVxTi9sa2tUd2VubE5j?=
 =?utf-8?B?bzVUWFJvM2QvRXUrYVdUN0MrUEE5cGN6d09Gcm9MRUlRY3kzNHIvUXRBVG1B?=
 =?utf-8?B?RnR6ZHVDN3dhcGRpNzBIRHJRVWF5bGNxNy9zYXRkZ0pTSW5jLzMzb1poVmpM?=
 =?utf-8?B?M011SkFQWFhOaWcwYnFyUXV1U1Y1RVU3amVWakRuUWVsMHBORW92MXJzWG1B?=
 =?utf-8?B?MVUrcWZmS3p3aXZnSEFtRHBtOEUvVGVrMGdKUnV6TEVkZE5MNEc3UW10emN5?=
 =?utf-8?B?WitadnV2TlMrQ0pUeHplWVhQTG8yZXlMZ2ZUMVNLRWxIa3lXd2dxRWZMeDhp?=
 =?utf-8?B?enM1c3NjL0Z5K0JOazNxekdiU2gzYVM1Q3o5dklmTXIxaHRwTFZKRlNHUC9F?=
 =?utf-8?B?VlV0U2hsUEhXeXpsemFWeVgvZHhKcHNPTS9Va2ZNUzJya1hyZ1pBUnFpZWxr?=
 =?utf-8?B?RFppRTRMeTZMRW5lQjVwWFhHYnk4dkhMS1ZTZFJFQWN3bFRGTHA1RHJsWk9l?=
 =?utf-8?B?OXE0UlY5QXMxUXQrR21FcjdMQXU5NW9EU2ZlcWFsRk8yc1BvZmZsU0Y2RUI3?=
 =?utf-8?B?MzMvYXUvMHJYcit3eGozcklveFoxRjBEcEZzRjFWaFh3TG1XY2VVbDlPUUtH?=
 =?utf-8?B?b1Era2hSUXdMVWg5NE9DdUF2Sy9jaldWSVBueW95Yk01cG9ZQTBQU00venlR?=
 =?utf-8?B?emIxeWo5SWQ2T3plakNadmtVTnFhUklXMVhZY1hqcHZLN1MvSWVnU0c2MFZo?=
 =?utf-8?B?N1RDSzlhQ1JNMXRvYjlkZ0lZM2JxTEQ0L2VJQ21MS25BdE5kRC9veGh5UUxX?=
 =?utf-8?B?YUphZE9MK2RtdjAvNmJ5MHJPMFJ0UDQvZ1J0SmRQVCtlNlFiK3Y5Wkl6VVVE?=
 =?utf-8?B?Mmxjb211RXh4a0UzdTNRaTF6YUhpTEpNcW1yNDRRMDBTbFoweUpNR0x2d3gx?=
 =?utf-8?B?ZXc0RXE0REwyalN6clNuV25HRHU2d2ZBWjJHRkEvZ0JSMjQ1MUV2RnA5aHV0?=
 =?utf-8?B?ZnVKRzJ5VVQ4NDUyakdjT0tSa1JUc1k1QVRsUFhjV1U5c0lsTTRHR0pWS01s?=
 =?utf-8?B?anRGaDNtM29YMHZMVHIvejUzY3NlcmhQT0x3WklEWnh1TTBHUTF2QkFYYm5N?=
 =?utf-8?B?TVVMcXhzdExXUGJoOVlneUFqc3VIbXgyNjJaVzNSWisxL2R5bGJ5ZmlqVEMy?=
 =?utf-8?B?ZldjVC9XOHEvbzdaVGJJZEpIZ08xcGQ0V0xKYzMxdGxMQXdKSDJHOWs1UEM2?=
 =?utf-8?B?NktNUEFIVHBrT0FnU3NSU3FISXpidDFMcmRPeW5ZMjBualRpNHBkV0txMjdu?=
 =?utf-8?B?MUxuS2VNUFZNcXh5UnlPRUQyZUhVcjdrclp1UGc1K3FUOUlsWGhwZ1I5ZDI3?=
 =?utf-8?B?QnRhc2FTczdhWEhpbGRFWmpOVHhDam41aldlVDl4V0dhcnNaNitDbWRlSExr?=
 =?utf-8?B?dTl4RGVzaEVVTTJQaEQrZDFaZks4S1I4RklWSzBWY2psNVlwZGZLMFFkMVN5?=
 =?utf-8?B?cER4RVZKTWg5dkhwQitNUFpMK2x1dGlNSlF1UU03TDJpc3kxb2xadFBtZ2Zp?=
 =?utf-8?B?YVNsQ2pZS0g2STZodnplQ1VsMEFCb1QwWG1VdnFjL3ZEUm5peGVPQkQvblM3?=
 =?utf-8?B?T2dQbHZSZWI0c3h0Zm9pQzR0dkxzdGF6Snk5M3lsK2FPb3BpamZHL3J3aCsz?=
 =?utf-8?B?WkRnbDJmaExjL0tCc3JYSjZITUxaYjlaaXJrTXJ0em9SZjRTZU56S3BmOWor?=
 =?utf-8?B?ZGwzTGlET3VXVWJQSE5HYzhMYks5OTMvWnIrR2JreExscXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndvSkhHZTVodWdVeVRGUStQb2RsanFWVmhjQUd0U3htUDlYZysyaXhxbnI4?=
 =?utf-8?B?SHFxY2lkRzhGT1VYNVB1K2ZkZlBINUg2RmNydC9UaDJUVDlSdWFiTW1hUWxL?=
 =?utf-8?B?UWdHVVhLNTBVV3NLTXkzd3Y2K1NncjNPc1d5MHQ1RnZBb2U4U0JRVmwrSG83?=
 =?utf-8?B?UG5SWTE4ZVhVMFVNRjBsRnp3T1g3c1JyRWhhdElkejdlSnREK2VHMld1bmJ3?=
 =?utf-8?B?c2RNbFlEM2VFdXk3Q0FBYzBOU1d4cVIwSy9RMlhvbyt1YzNvcE5vcHI4Q2F0?=
 =?utf-8?B?NzNkSTVuSUFvUmxvbEVXRyt0c2JOVlJROGJsa0F0TVRvSjNXUVFnZDRrd0FX?=
 =?utf-8?B?eDU4RzBpaFN5V0ZHa20yYzRDK2JjYWlzSk1EU1VDQURUc2Z1NFZxTHNtOHkv?=
 =?utf-8?B?OExMTU1xYUFvOHpaYkNPTmk1cDAxRjQzSDlXNU1qQnFoRDZxQ3QzaXU2QkJa?=
 =?utf-8?B?NVhoanF0MXVSSThtMlI5Zkc4czQyZVE4Q284alhCZ1JSTVVzVTJMNDVXL3hY?=
 =?utf-8?B?N3pOUUxGRlFRd0ljeDJMNUFsdlQ4NExUblp3VmhocVZscjlpRTJQMkZMdkx6?=
 =?utf-8?B?Rm9YYkN0eGRFa3dudWNkQTZtdkxhck1mNzMyRlVRM1JVZHNrMi9OcWZGRkpt?=
 =?utf-8?B?OXg3aTlTVWQreXRzU3Nrb0lMWVU0NkV4Q0FPZ3VoSGx3WGhwRGFlTmp4MXBs?=
 =?utf-8?B?VFJsZ2VSSFZybU1nMVdmMVpmamNYbDRxV3JjbzBCMzFTVVFSdEJ3MVh6cFc4?=
 =?utf-8?B?b1M3S29iK1MyZEJpc1B6QS95R0RPWXh0Y0x4RTlOUWVYMlJ1bVZmM0FUUHFS?=
 =?utf-8?B?UHR6cVcwbVQwMXVnejhqZmxKQ3ExK2N5d3B5dGh4L1VySjlnKzhqTDhkZ3gv?=
 =?utf-8?B?VXBtcG9KUkJ2MmNuZDZtcmRxVHg5VVZ5L0kyc2tWWE1CZW9RSHl4OW5PYkJy?=
 =?utf-8?B?RUkzM1VlUFQrNjU3S3RPWkFzYS9TV3ZqTVNyMTBmeWFweUx0aWFaYkoyMURi?=
 =?utf-8?B?TjJCUkRvanVBSjhQRGp6eFBkb0EySGFGYTBmaGJLR2t4MVpBZnZjRmE1eGtl?=
 =?utf-8?B?RkJyNWtVeWQxdUhBNXFMSGQyYlA3a3JUSlNTWDdhWjhTZDlDZFZOVWxQT1Iw?=
 =?utf-8?B?OEtaalFJUWgvcTNMbmxEbEcwNmxwcWptTjJUUk9wTVVFWWxqelJBdnRrY0pa?=
 =?utf-8?B?SXFIa2dwR0xHaGYrT3RaSlNONWhRUTlaV2lhL010VHRYeWZDRU4yWHJSd3U4?=
 =?utf-8?B?bkJIblpnbnlYOVZsYnh1cWdGZjA2TUJyVWVOd0J6eFU5T0kzaUNqenp5NUZ4?=
 =?utf-8?B?ZElSelBBaXhGVkJOSnZ2OHFOR3FxSy8vQ1Z2eDVSNWFCeENlSk1FQWtHTmY0?=
 =?utf-8?B?SFVsQzZyY1JJOWYzdlg2VzBMMGZxT2x2Nk4zS0Q5UHd0Y1FuZnZrUFVaTEE1?=
 =?utf-8?B?ZENsSWNnU1hXdVA4MXVpR2tORFcxOFQ2b2ZoRjlLV0Nzb2ZOdFdJZStvcHdp?=
 =?utf-8?B?dVZxWTMvRGhvNFRXTEhvY1pJdWkvdUE3eWNiSVNSN2JzR2w3dnZja01JK0ZX?=
 =?utf-8?B?cjBNMnNvYUtXQXZzQ2JtcWMyQXhFRjFGN2JjUURzSjhFVUk3dzJhOTQzL1Ex?=
 =?utf-8?B?R082dEExKzZaaEJhRCtuVWNXU3RtMCt6MFNDVGVhTUtYRWU4citRSmlLUVhS?=
 =?utf-8?B?TUZXU1dFNWwveWhMVzRkR3pOT2NXc1NtemoxMmlBaEZyNktnN0VTNVhDQ24y?=
 =?utf-8?B?eHRwbDBLNldTM1JyRTRYQ0Q2R0VIU2lrTUQ3RlNtcUNsejNiYVErVTMzOVBW?=
 =?utf-8?B?dEFEYjBvdlRxaHdHaWovQVIyR1d5cXIrK0JpMWo1OWpUbFM4VEF1NG9wTENv?=
 =?utf-8?B?RE9PZy96c2s3ODZIUTJDdUk4bys4RDNGMS9pUCtzRG1pa1NPZzIxeE9JYVZU?=
 =?utf-8?B?YmJjcDl0ellob2VwVXFSc1R4d2xGV2JJZVFTZWx3K2tUSm1iOE9CUXFWZGZZ?=
 =?utf-8?B?ZlV1QUVIdmJURXF0eVBuYUdQR1BwdkRCNjFtWW9qdzhucEFURVNEMHc1SWJD?=
 =?utf-8?B?TGc1dkQ2LzVnVG01OEFiOTVWS1orV3RqbEp6ZEI1NmI2MFgvZ2ZWSmozRkll?=
 =?utf-8?Q?LZ609+WadgB7m6YL6KaHuwMD0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fdc903-7c5e-469b-6003-08ddc9345060
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:27:49.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0dJKfjWKAlJ7Xg6HEvvq8rPg2H/kfMEXkE1DOUOtiZr6fwcMVcu6mN9nQO2Pl0NQeDJxe2vQ66Ka+ArfsjCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com

Hi Rafael,

thank you for taking a look,

On 7/22/2025 11:03 PM, Rafael J. Wysocki wrote:
> On Tue, Jul 22, 2025 at 4:39 PM Chen Yu <yu.c.chen@intel.com> wrote:
>>
>> The security-version-number check should be used rather
>> than the runtime version check for driver update. Otherwise
>> the firmware update would fail when the update binary
>> has a lower number of the runtime version than the
>> current one.
>>
>> Reported-by: "Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> A Fixes: tag, please?
> 

OK,
Fixes: commit 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime 
Update device driver")

> Also, this is unlikely to get into 6.17-rc1, but I can make it into
> 6.17-rc2 if it is urgent enough, so how urgent is it?
>

It is not urgent because the internal tree has merged this patch and did 
not block
the testing. However, considering that this might prevent users from 
rolling back
versions in the production environment, fixing it earlier might be helpful.

thanks,
Chenyu
>> ---
>>   drivers/acpi/pfr_update.c  | 2 +-
>>   include/uapi/linux/pfrut.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
>> index 031d1ba81b86..08b9b2bc2d97 100644
>> --- a/drivers/acpi/pfr_update.c
>> +++ b/drivers/acpi/pfr_update.c
>> @@ -310,7 +310,7 @@ static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
>>          if (type == PFRU_CODE_INJECT_TYPE)
>>                  return payload_hdr->rt_ver >= cap->code_rt_version;
>>
>> -       return payload_hdr->rt_ver >= cap->drv_rt_version;
>> +       return payload_hdr->svn_ver >= cap->drv_svn;
>>   }
>>
>>   static void print_update_debug_info(struct pfru_updated_result *result,
>> diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
>> index 42fa15f8310d..b77d5c210c26 100644
>> --- a/include/uapi/linux/pfrut.h
>> +++ b/include/uapi/linux/pfrut.h
>> @@ -89,6 +89,7 @@ struct pfru_payload_hdr {
>>          __u32 hw_ver;
>>          __u32 rt_ver;
>>          __u8 platform_id[16];
>> +       __u32 svn_ver;
>>   };
>>
>>   enum pfru_dsm_status {
>> --
>> 2.25.1
>>

