Return-Path: <linux-acpi+bounces-15641-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8860B24BCE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 16:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098291B6537E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9592ECEAE;
	Wed, 13 Aug 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS+KisVj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64222B8D9;
	Wed, 13 Aug 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095134; cv=fail; b=puYw1TJ24EsuUbteTHaPm3vXvHT0jsZvxgGYZlHZCBnaTg/YxfLQORDF8VaP8dPaqAgFygHLTaBYPOjXbZhe9RaJRfif3M0OBM1DE1NeCQbHrCENdMjy1NbFiGvW9bEXAqbMhrVevZiFhH02FTBK44cuFbX5+UY7JeQ1XwZoOw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095134; c=relaxed/simple;
	bh=/Mo2uCHYsaK0v0r8LhmT5NEPoTaxccXZd0Uaw/4laEg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FzTQPi+nJprWNpFXwelRW1eEHNVDMFoGNIrHZ4bbDQTUXl6uTOf6KdH7kR7+209TFizrCFaRnuIlPDVLaNBUYBwlH9LnmZJnKMr+aZIauf/gMIpJJrEvHsy3QqveKSiPnEryzCXG+FOsLPy+qzj7sak03Qz3R42ME7ucMZi/RRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS+KisVj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755095133; x=1786631133;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=/Mo2uCHYsaK0v0r8LhmT5NEPoTaxccXZd0Uaw/4laEg=;
  b=kS+KisVj4bGHL7mRXCSx9PyBmwOpdhQy1W0RmwoevyEdPsbQL1AM2z5E
   V1EdAq6+vGQf4d6PLP4/pvzf2awNLkiG6lQPAPnJ5tO3/21EaW1jnCOwM
   jyVSClJuW2hQjbSVGR9MCqT55jumskPb7rPttvrCejLANJlwqh1hwtpbA
   bbQffSpaoPqF/1+dVzmuzGu0kYQG2XBoHempiiF9CRyHnEZf/FOeyTSQn
   Z2PAVgsTmn5Xa34es11xq4K6a34BNCwZUL5tghCZlNd3kJGx3C/alGzMq
   GcpoPVmP5tglb0Q/KM8uRyrn+JXQ5WyztpD4r9rOmHxx/IK98G0SUfPO5
   w==;
X-CSE-ConnectionGUID: j5g8vYTnS9q95+x62UrImg==
X-CSE-MsgGUID: pike/5ZgQnKk9pjZLgUBvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61195949"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="61195949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:25:32 -0700
X-CSE-ConnectionGUID: 79RdCOzyScWdQPM9E8Hjwg==
X-CSE-MsgGUID: VCVM4pKNQBmDjJAfG2afBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203658557"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:25:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 07:25:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 07:25:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 07:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBbdhNBhMzndZNU0ooLaimKHmfQJRuC/mF5H0TuYJ/9Mpk9tqV9L9Wc4JQGUpE9AFc6eh/4tfRjpgpDj8ndtH9GXPGGly/7NdVBFVhiS9Sdb2s3w+PG6+rVfYk5KNwwPye3L+/c3/X5+8bA63h0nGo6uFYBlBi/66SMqiUAMqprskinLcMZWppTYU4YvH3SPIuAYjiKJ9z7ClnphxP4zrZ3TT7hmQYCRc/AcEqzPaIe6w319WbRwesemwzl3F5QZVtEzjx6QHne085BoK1yvBkU2BBq4PEV/1H0nkjIIv6906U1G1e+DU1gOdEv5CwEmsvWJ4Y2CuzAYaaZLlmKuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TS5AY+BGs8DWWP/43tAZarj7vpkmgVPjAL/zP+RFVQ=;
 b=wXoL0mvusv+Fjq1ZF1CoyPwaVBopKJp0/HJDpe4pcBsXR+SNWMIAs/uDFA4TN/bNDuggyXpUxGJN5E+yJ0AatoEN7TAE6bfFOFByV5aTw2WVVjApN1eIM2rJDj4Da1iY6aDnLZN/a67ks0xU6Q6MXsftSwax4p1uew7Xo7xdhxXdLRVkWl3+YUnJb+4QitxvoKjSaGrrVHRUxZcvl/NjQPnm76JYdS/NWbxqEbIQbUkLuIT1+zJ5hzhB6gJcTBied3pjJnRG4+3Y3Vg3cQ+ouZOvhKopoq2mKUhSF8BW16MQO+3h56Xw55dYQLldLZ0dXYwIBvUqTwgY5vtU+Kg5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:25:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 14:25:23 +0000
Date: Wed, 13 Aug 2025 22:25:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shaobo Huang
	<huangshaobo2075@phytium.com.cn>, Yinfeng Wang <wangyinfeng@phytium.com.cn>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yaxiong Tian <tianyaxiong@kylinos.cn>, "Xu
 Wang" <wangxu@phytium.com.cn>, <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Replace single idle driver
 with per-CPU model for better hybrid CPU support
Message-ID: <202508131628.5bcb2ed6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811072723.762608-1-tianyaxiong@kylinos.cn>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: caf70e24-bf7c-4cb1-082e-08ddda753d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EIkXymAwoXMJXwUCAZIOU+gd8qQ0w3FfwFFv54SjYfg4wNlR0El6/5ZxRHtE?=
 =?us-ascii?Q?Wk7YndBkwvGkpWcBTOqG0ajZzLn9j6qIZhC1CWD5k6RHpWPqOcRL9fSMexC1?=
 =?us-ascii?Q?jJH8ID0XZM7kpjx87QXYdiTrZaAf5IP9QbFzK1lDq6Q/DTo6DgB+vMfWbJny?=
 =?us-ascii?Q?Xh49SCynR7I7j/WLB/W1JBlPiB67/SzktTqqi3OlzJL5i9b0Tuj69oxPYRop?=
 =?us-ascii?Q?3PAw0UHtPte6FPZkbqMaKwY9lYD+rdrtOqoUlrrFPBDdguHHDoJe+4sAoXuH?=
 =?us-ascii?Q?kgJonpGE8IrGGyhUPpopr/2lGeEqdvAT+QquJB8p3+qW29P68J9nmF9KTsp0?=
 =?us-ascii?Q?Lto2Z6X6ZKu/1dX/uGzkMspavT9CXHvSpJzylscGE8VvpRlkvZscO/m7cR7e?=
 =?us-ascii?Q?U+DgzQQ0tM8PC8sKXggiMOWfzgQyoxPQi883D6hVJMEMBSQxwBb4ofc+iiyX?=
 =?us-ascii?Q?WdcCPHUKeasjONldDF7uwVxgipUI9WZwR05wCuFo+BYgihuv2Lvffs8s8VU2?=
 =?us-ascii?Q?W7J1OihwZ0AxhBhXiK6riB62aLJBH8eW7MvxdAWgFh//wpjKZejIl3ERBHg6?=
 =?us-ascii?Q?7o5Ph/5NDlFqHVTwbF3tJsv7ZET4pQfDDd+Nu+zckcx/d1Yl+NIHcsUubAVD?=
 =?us-ascii?Q?9XX1K0rd9bbqjWRBHTCoQrGaIycBsfe5hATHcDHNcniV9FqpuZtoR/w6MkAT?=
 =?us-ascii?Q?Ii+IcmoeNY5DUNa4cF/i+jK9KW1wDAhlYJpShDA4/wCq/qappxlHmhkEeOyD?=
 =?us-ascii?Q?qApwrCNkcq/IDH4NyHY5ud8yfBGgRx7c00D0AJdAl8esXcagAzE8czSEcXdK?=
 =?us-ascii?Q?fBxEsh6tEA9/xVkERjkg6y+tc3xJwm+ZxJf+rMFBetBOFvvUkssDcBU/F0hJ?=
 =?us-ascii?Q?CwLhj2eRU9yaTcN22A6w3ohiqNvLGIRl2Zj0cQMpNGi88onvb44vXe1zbKXa?=
 =?us-ascii?Q?zJy/ahvO3FsDDpHhC6afy1t/+CTvYiUBuPqQbIFej6V6i/8wB2CawlA2OpvS?=
 =?us-ascii?Q?/D2TQ6v0OJECkFvSUiqGLyrNxvHS0j3B7HmD8kO313gzdqOE3kkKdYWT9BX3?=
 =?us-ascii?Q?eQdkTir4iviU7BRQQ+ALP7XQd4oFTjzcZY9yumsKiu2XWkZ3u8eYJqSz/qBK?=
 =?us-ascii?Q?I3imr9azQ9OCj+I5SHb0OmZCo/0qA2BqyNbqygHXdE42Ubq+s1UDIRyBHGiL?=
 =?us-ascii?Q?9wC7uXRLGQNqoGyAa0hse/NKnfCGeDqjgoJD3HvOm7AYenm4I7Vg0JzD0G9p?=
 =?us-ascii?Q?gYznmZL2rLLORPq7ikyP3RPUxdTCZDLbqaMCg6giZoVbVPsiMY8tgUnjZLMv?=
 =?us-ascii?Q?zP/8QvlfRm7TzSXToUqjySo4gUAoj3vvmhgSKpc47Svq9n6M8YrnePrTETtq?=
 =?us-ascii?Q?IJVVJMe3czljnxrhtLPf6QhFU6vv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwaclN5+KZkEtuWbcpKG5OoSaZbsPuPY4dAn6AOxfPI/Ffx+DbewqtiQkxJ/?=
 =?us-ascii?Q?7yU+CXQ6/upugg1I3qPReQehswRJkR4IjzTJF/YdW3dhv5aFkDpAgGEH5QaC?=
 =?us-ascii?Q?XJmQ6R89eKCA0dSQL7xMofyq1G5lzVGSJqvvJ4l/WsJ7M74p6HU+GCD9Hz6c?=
 =?us-ascii?Q?4CTxc7kJ4SaskPtNL1Kzsfesmub5K/mcmxuLuhN+jWyTM8IGQM4xK2OlcCPi?=
 =?us-ascii?Q?FkXgV/qan3o2ytJm++WhFS2ADI6EHJ7/7Wml+XubhbudXU/ToWv+sPGMIBER?=
 =?us-ascii?Q?s0Spb6gQvRHvR2/9lq5Ma95okQIvh19DHrfrRqUluO6RhTIRjiopK5JWmlUG?=
 =?us-ascii?Q?3akGbU5w/PNluguVt8emJiTc5t1lH1h5WM9HludFoUAjSHHY6klpTbIFrUGX?=
 =?us-ascii?Q?sFWswtVEopcBdgBKMP0VV9jHpWl7BnYzV5jNWxvvjj4+eonGvVTLmEXnqMcG?=
 =?us-ascii?Q?ZEjkLPTYK7ee166T2UcJ4bIx7MO+22+/SU0c38JR0Fm3IcEEb7Rb1qwLGUvc?=
 =?us-ascii?Q?za4P+DU4FRrNdu03LkgcHNIcA2DH6r1ONa8Q4J5sjjlfOQc/5uZ0IkM/g6wo?=
 =?us-ascii?Q?0EGtZdi47DRxL81hrEtmffyHWyX8/uHNrzNuGmbAMFLZPn86VOxUhO101vJD?=
 =?us-ascii?Q?C5sY8wsT8TjUbRUnYbzykJ7dCpw3Dq1FCFBpVfWoU+9i9u4HI80AD4Cky6/t?=
 =?us-ascii?Q?BuNJsa2w+w7x/oCzVlP3OJeNMj92WQwopfqP4PXS/QELHZvuwfFvDOTCPndw?=
 =?us-ascii?Q?xEZfzsReun+eWHP56yJIz79yJCqB04tWkR91VLnNVdka4QqTJ9W5kM9JbJQl?=
 =?us-ascii?Q?sa1c1oavTqHJScbunSoYfl5JUFOyAfRDmdO0oAEcZgSsf9urcTLJfo+LrhFO?=
 =?us-ascii?Q?7QVRh3bUN1AurvUQUcafo2la+L96/My4BuHhAnNZ+f0K0dsc2A8yLL9j6bcy?=
 =?us-ascii?Q?v0LlUwbPcy2/8TjWD9oG7m6tvsnlOos6LpO+WJmLEujPsvJbeBuQlAtrYfqi?=
 =?us-ascii?Q?ACZHjInaawKOC8pJ9aZLavW23+WFLcH1e5u5LsB5Hw4A5Ux1J+W3ragNwZoq?=
 =?us-ascii?Q?4q64zoMkAr/DK3Pw6Urmx2gtjUnq29GxU0Ai7AxRT2S2mZA2dnYIwVFemOCb?=
 =?us-ascii?Q?AtIzU+t8CXayZ0Fo1X6R8mLVLHmTC38oTPZ3exDuYVoxEt+L5nWOidOJ77p+?=
 =?us-ascii?Q?N8Axndym6Jyll93meIULkT1wdPMfYenabJh8I6LxuY19yiVmB9IJwaileUOl?=
 =?us-ascii?Q?FWp3dMvTNpkHY2Ifj3Py9dmiLemj4yi+TRfxUF+YCCscrZ3s+mpMZnOyG5xS?=
 =?us-ascii?Q?ba1RmFCCVCJqeCjo9nok0Vo/1AQ6MgOHLrM7LeQQfcLr8qXFdOmX2NoZGZc9?=
 =?us-ascii?Q?IMzO1ss+yyMOChr2NcYoZzoiJtZHzz7IZbWkRQqYkIUmUwYrQvIWT3yI8Urw?=
 =?us-ascii?Q?Sw0y/2dB0WPp9BfIBbXNg4BFxsT1K8TDebCh5Kkoz0s2doox99RWfDafjvXj?=
 =?us-ascii?Q?SYUg0v8UIqIilNKYOSEX7c38Uj8N27FwRRbzw3zK9oBy4B7QbA33Bwq1AMBi?=
 =?us-ascii?Q?+DXol6FGQbpKJL7Cg/OAeHgl6Fi+tz+ff5VHOwJ4QjLaU+vxjlwlLs9Kf5PG?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf70e24-bf7c-4cb1-082e-08ddda753d74
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:25:23.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c1wMKW8hy1sMUUaNYulaQR4TJjQqDwvd5RK4wwVdkaQ/LWQ9U2lsGNvUcSDZKzmq5+Jo64bYqY6pojCajtriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 91c8bbe586854e1485070da49806a93599f7636f ("[PATCH 2/2] ACPI: processor: idle: Replace single idle driver with per-CPU model for better hybrid CPU support")
url: https://github.com/intel-lab-lkp/linux/commits/Yaxiong-Tian/cpuidle-Add-interface-to-get-cpuidle_driver-by-CPU-ID/20250811-153002
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20250811072723.762608-1-tianyaxiong@kylinos.cn/
patch subject: [PATCH 2/2] ACPI: processor: idle: Replace single idle driver with per-CPU model for better hybrid CPU support

in testcase: boot

config: i386-randconfig-004-20250812
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 664e805e14 | 91c8bbe586 |
+--------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508131628.5bcb2ed6-lkp@intel.com


[    9.129755][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[ 9.131211][ T1] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    9.132199][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc7-00167-g91c8bbe58685 #1 PREEMPTLAZY  2350dfb9c96e1334949e3e2979039571c1c27191
[    9.132205][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.132208][    T1] Call Trace:
[ 9.132212][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
[ 9.132218][ T1] dump_stack (lib/dump_stack.c:130) 
[ 9.132224][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 9.132233][ T1] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 9.132237][ T1] acpi_idle_rescan_dead_smt_siblings (drivers/acpi/processor_idle.c:59) 
[ 9.132246][ T1] acpi_processor_driver_init (drivers/acpi/processor_driver.c:286) 
[ 9.132252][ T1] ? acpi_processor_stop (drivers/acpi/processor_driver.c:132) 
[ 9.132259][ T1] do_one_initcall (init/main.c:1274) 
[ 9.132263][ T1] ? acpi_fan_driver_init (drivers/acpi/processor_driver.c:251) 
[ 9.132287][ T1] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 9.132297][ T1] kernel_init_freeable (init/main.c:1588) 
[ 9.132299][ T1] ? rest_init (init/main.c:1466) 
[ 9.132302][ T1] kernel_init (init/main.c:1476) 
[ 9.132305][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 9.132309][ T1] ? rest_init (init/main.c:1466) 
[ 9.132315][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.132319][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250813/202508131628.5bcb2ed6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


