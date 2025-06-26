Return-Path: <linux-acpi+bounces-14692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB18AEA083
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E1B3B0F61
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D12E336A;
	Thu, 26 Jun 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbKY+OV5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01C1AAA1B;
	Thu, 26 Jun 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948125; cv=fail; b=AKwLSFZJQfcZeKISRAeUouol1E/ykE4fEyHUBJqmt45k19JLgBcWgEqJiTUluFoNfcaShVG980KTwRDQ2m2M9urH5whWHJss9IUegT2X5s47TMl48qEqKCp99ZBdEwk27QuxZEgHReoLd+2FGG1ydXoTNH4blrlBRdDaSL1vjbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948125; c=relaxed/simple;
	bh=ZjUfuvuyJBCS9bBduZbyGAFmyhq8vyZdCGWbxRBM4WM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uC4UoD/mGLxiLle7aaZrxHR8pW5eFCnvJBj3KEYgU5t1/kuvTX1PgCGYlKAVJWcDgx0m9M5ExW6EGdVRNfHmlCRWg1cahv+r6PazFyChaKx/W44eb7xmvb0SrwhyBKPEqsXajJfz1bfnA0qx3Wy8j2iRCi2N013TV2kJ0v+LZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbKY+OV5; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948124; x=1782484124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZjUfuvuyJBCS9bBduZbyGAFmyhq8vyZdCGWbxRBM4WM=;
  b=cbKY+OV53rNbzjVIcnwtouBkAymRysv2iBSgsKBpiBo6D3a6hturyg1h
   1kbwY53yIr5UeTbU08437zEWDutSD8yRG6lr4fu/uFDLs1LBHZ5WRn41F
   +O/m4N6b5blYWY7TcMjDCl0dab4lfT+rJFB7Blw4X9/dJgGuiNVIQwsOV
   ou1jGYCrwYguBzaixCp2XD73+OcRTkSDSLg0ewuyYTVLynI3nLYI6dxSm
   NukhuO28Vj+T4erMULSQK2iycf0CKq7jnE9JH0RHWqZkHbmIZK84Z/kwS
   Vhyam9eop1q9pIgrlQYQNazfx+curloD9X0jdQPSsQgyZ15odVV1o7UyW
   w==;
X-CSE-ConnectionGUID: rwhNxiHrSee6w6dEvP6LqQ==
X-CSE-MsgGUID: DEGKRpfhQfKgQnLhRGfMEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53188471"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="53188471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:28:43 -0700
X-CSE-ConnectionGUID: TZR5gh+nRQyS7YGpLU+J1g==
X-CSE-MsgGUID: m0JCNkINQ9Kz5bdfi5JGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="156908163"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:28:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:28:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 07:28:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljorbs9NoEIV+rZZrusGJFe4qdO5dP+9DE0fT+oXMDCnAuaqDViJAKh4bRR8SKvrg5E0uieQ9pvn0EVKPakIaQ52osJ5ryZBlVIwakUvKSvFWNk9D1eZLp6nX3hKgw37aCWrY7Bx6hl9BcleiKYINdA+igqICEXTOd59AuPm/0rro59lUQoPZS2P58k9OBRKheBezvTHbsm2HQ0ugbUvjbulrMjXbaYknURX2JsgZC6r7yDF2djZWVp1Yr4hqQdT9PUTwzmrcOXfpRMngZpjeBI+jNNeeIasWctM+lzGPjhrNZPyW4pyR9+ggRF1yqk3vMwJIhNoKKrUa5SxsT6t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP3aNV9Sif0AQn6kPW+LNcrrwn0LtSRs3Mduq4E1HlI=;
 b=H8omYaf9lcvSnPfpW9hKADQ6X5w0AG+SBPwgfjcAeplg+AWQMnQHSvMYAeYrvqmbocY/1cfAPwQl7HvLrOtFgNwEptxwLY8tmaAwnsYkVpRTcNjwC6RIn9IeMs2fuVauNRqaj0zUueOqt5q7kK3D0z79iMTeFgX6C/sCgOJVdSvqxz16wnkYro/zLHqNz9dB55cs433mvQRPZu/wbsNHnFX6Pv/l6rR2OO+/c8Wj6jFEJvpAkLACi4AOjRcJFwAwX5Q9ThqiOVqtExECc+cbqLx2NZjhRnAl3SBMz2RlPHAn6PCrBCR8URokdwRg29roDAP3sQP7xTKFuLse2mxfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by LV8PR11MB8680.namprd11.prod.outlook.com
 (2603:10b6:408:208::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 26 Jun
 2025 14:28:39 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Thu, 26 Jun 2025
 14:28:39 +0000
Date: Thu, 26 Jun 2025 09:29:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<linux-acpi@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
Message-ID: <685d596656ea0_2cdd79294c9@iweiny-mobl.notmuch>
References: <20250624202937.523013-1-colin.i.king@gmail.com>
 <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>
 <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|LV8PR11MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb16b18-23b2-4df8-e7dc-08ddb4bdbe6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/ygReHDiEzrEJDNEL2VsF4Pp85CALc7NJge7QHL94OhogNlkGGUpc5ORrlG?=
 =?us-ascii?Q?X40Wc9FxB6DLgkF5Zhb6YlQ+TXxGES8Pc09DRX0UGJ9qSwaL8r+63Z9R7rLQ?=
 =?us-ascii?Q?hA04Mwd5KX2enFGW1orybGdtSLyR0tuMolpC8m0Tm4CkefGL2zd522kp3jCT?=
 =?us-ascii?Q?rPM/XyqOx2N49gIjRMrxct08RmfHCB2ARTLsVoQIfTEb2WF78BnfyfvFKSG9?=
 =?us-ascii?Q?xfB/F2OVCdWCeqsWbLTDfec06h9rFuA+xtLRgrzy5Jp1avntNMI+74vokTao?=
 =?us-ascii?Q?AC85mu84DBdcx2X34uOoEGexpoaM+RdZGAopcsnoW0oqOJ0PMW5iS7YXlhuS?=
 =?us-ascii?Q?vjsf9LtmDWPsi1e/5PMFCtBohjKEHwe0lfulu9xd6s7QNPYeWfYFwHqm6VE9?=
 =?us-ascii?Q?sgswn6M8KAYen9l8icEqk0IsWup9Cjq50cRBbGV7tMC3isFRQg6aG+zpQTYe?=
 =?us-ascii?Q?JUXRUmNf9PyP/GmWZQ8U9EIBqskzZPM5tFDSMZzV8QsWLiDYM5AZY9NGPd8u?=
 =?us-ascii?Q?4fVl6j4tfKsjXYSIuKCp++12D0x90mHiPA6rt62mx0HFq6DmIs5hPQP5P5km?=
 =?us-ascii?Q?i97qel0TNSA9qToX1Jt7HYN4NQtoYR+BnJdIy6LdRHR6ol6/1l4863ew0Cte?=
 =?us-ascii?Q?ysz2SRETKwOM3h6kkxxWwG2iNBFYwai6t0qqqJqTlv8HxaapWJdup716axn5?=
 =?us-ascii?Q?e94X8QfBOO3KnBeRkhtJERWdzMUhfyZYIftgaeGong6vNyhZJz+CcyUXTceZ?=
 =?us-ascii?Q?UkaT4sIgBv51QCY4XhvaXKpAYbhdGyQyp38ajHK0Vg21WynDrIYu9VALgEuG?=
 =?us-ascii?Q?bQ4E1vJDvYQdtraWOvYGgK3wwAmNExeNLPPGQnxjRyTEXnJbZTk1u7ZYnZL7?=
 =?us-ascii?Q?1UyA/cj1l3D+FB94MidPrOeG4y2edvEKtmsujdB0eDaBYHgkYmwfN+Y0jM+Z?=
 =?us-ascii?Q?6kRYPMS7rQUl62wRM5f3uBW4JLGZafhGm/+955JgdJXFhA6MZAnEI90YoDgy?=
 =?us-ascii?Q?az2uWXT9MYQmDrTFOqLuIUMEFjNrJMRCPZnx49qw7kpYc1VXIi2ijZ4JFckv?=
 =?us-ascii?Q?uXD20zOFOldb5IwMNKhYfFLHn8GQNDovDQlq8Ukw5Am/lYrL1Dn9JdWSa8qJ?=
 =?us-ascii?Q?3Ct7D60V1ixWEoeuyllfYHQWe6EIv/Zq3foxaX+3Nw0NylAvH7G+JjJqtkRM?=
 =?us-ascii?Q?rvAERf8iuAUvbxAidQWH0tWtKEih5jceHrbhFWASCBtJ9zXc4w/WhDRVxrYm?=
 =?us-ascii?Q?3eZUzSLaTWtXH74LQ/QBy4scH4NbBeVCWqiKyYyg13mjfZPN2vicVmvhLzrb?=
 =?us-ascii?Q?c8CTYu/EHLEWelK+trYbXwI49gH5/+fIeFWogYgH0dvpt6RCB9AUdE7pz+rY?=
 =?us-ascii?Q?WFtE8mTu+v1l9bk/h7NEcHpxtbplKCzEQox2+TvkaRjUrC6gP9bfGoLEs0jG?=
 =?us-ascii?Q?f3o4P02CLwU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02mLvX5lRSEkDk0GSF1223rzOqNIcyEY+NAGbjBHyFmHz6folOTw064hX3If?=
 =?us-ascii?Q?cfa6h+AoR/IGF37VZAxMGpKcbWCVP+53t/2GrHtz1SNEvvV/AkAKBX5e+XiN?=
 =?us-ascii?Q?LmOsDGnVyWrPS8CavzHdm6u+wW02mIYDNVzJDq7sgGuULwBv6wiPc4K/dqA1?=
 =?us-ascii?Q?pI3I61FTBsZj1O/u9gfn7qn/P+pDay4HKW0CFxaYe3YC+revTEOPbKrtjMN1?=
 =?us-ascii?Q?WbIoa0PLDqep2Ava/GP3aAdG9e0MLzJUjWs0DoIDogAiVAOsGyONE9q3Kqtz?=
 =?us-ascii?Q?E7MJt8mB4Nc5WJu8EQCSJyuQvhU4JGLbXLupwEdxTkfubiZAI8+0aLHnElJk?=
 =?us-ascii?Q?RAmfI2TqSYpzKe8r2Ir9J3Qym7umz9TKyC1CWR7TMK0AvPD1oOcTOC7skk11?=
 =?us-ascii?Q?JUaVDOQxzpbx3iqC3iqSyUksls0m6WrQfEdfvn1tjkQamTmkGKpIk49qEtWu?=
 =?us-ascii?Q?Zgq1J0Xf+DAn0yQ8vIp2a/GiMAKYIeKQQ2/GnX+XU8Op8N2EXsIcMEyPOu7v?=
 =?us-ascii?Q?+RT5kY6BJF6dol8XLZbspx1QEESfwpy8lK1BBMi9QkyAehwpHVt2Yby88oXP?=
 =?us-ascii?Q?YRcQE4rx1Y9mgX52Sh9LxH2y46ADIv+mtwuIscYgbRhsfF50QRPU+GSX0h2u?=
 =?us-ascii?Q?mdG8EcmZZJFWHrya4S9kwi0H4rbRH0Cqnk9GsjwlpSbdQR81oxgWXpSGNoaF?=
 =?us-ascii?Q?c+NdZ2BNTGcnRt184Ig6LdSkPOte3YtOEeEviFpHrFZOn8K+hYqMXfCw45kk?=
 =?us-ascii?Q?L9hORmHstWIYoQiN+ECHN7LKs8nqjyygcvPAAu6w4gq1UXNALaRlS96oG6hB?=
 =?us-ascii?Q?qzTOHXlcEL2lv22kH8oOdC/1u8+3ZzMU5i1FAO8zfwiFo4TFwY76+2YJ9+w0?=
 =?us-ascii?Q?lwq0RQVumrTiMo21N8BZFm5soWc90PUa7H5VJKoXpO+f1RNd7dfEnIX3Ymq9?=
 =?us-ascii?Q?u8nSLl84BXPxrXgjulTsikParw4nA6QAN2X+m99fDZ9aBQi3XNN2yTi0zSGu?=
 =?us-ascii?Q?ayPPRCaBhG4s6CRU2TdkT2h1/sJ87UMt+aq0bdYBNM5IlNNkhjrdr08HlPzA?=
 =?us-ascii?Q?pjLMWBEHVvKdd7e+QSUHCeXfJYXbcwXQp8v58qPcxHALyKvP7RAkBAVQi+iJ?=
 =?us-ascii?Q?nFl7Xi5IjIX4fCBcig+kPwyPeGIinWRSfde0bpy9VFRCqlhP2uj7gt6uFpQ2?=
 =?us-ascii?Q?JUEUQDkuqPjAf6JrFLkVqk1zTjJ+lea7ZT0fRz4Q9RdrEj6CViM+/YkKZAAd?=
 =?us-ascii?Q?1e+89a9qCAjajOlc7D26R0WBkHh91alXs8GUH5kyGeCyvFEPtEV9voPHOziM?=
 =?us-ascii?Q?UsFBmNA41xwWznhJVzoSh5GA2BuL/yG5KLHM2HB3+e54VIi/zA3Ajpz0Xr0V?=
 =?us-ascii?Q?b/hBKBpy3h0g0o3mH6jAHu4AF34tmkMJpcxXZR/jHEvEStHnlJewBQZ7nnvW?=
 =?us-ascii?Q?fne1lv/mVzFTLu4x9PhqZsxZEPut4hnIlBjRmt/7OGE31mO9M56LGWg9u8k4?=
 =?us-ascii?Q?x/RCwaImlQwhFbJAyMLQ6KiwgtuQ0b4xmlf7cLq+qf3odQ7VNIEJExbnJh6O?=
 =?us-ascii?Q?lZIOReaCP/dyq9KztQ4xVBM4E7x+MgRFOQy5phoa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb16b18-23b2-4df8-e7dc-08ddb4bdbe6d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:28:39.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyKI+24pa654DA4M15k/3h7u+WYsxIpAxNHHkYvfD9JuoQKxkMmEIyAUtaEZT/KJJ3oYKObpgfmuz+Hu/0TY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680
X-OriginatorOrg: intel.com

Colin King (gmail) wrote:
> On 25/06/2025 22:40, Ira Weiny wrote:
> > Colin Ian King wrote:
> >> In the case where a request_mem_region call fails and pointer r is null
> >> the error exit path via label 'out' will check for a non-null pointer
> >> p and try to iounmap it. However, pointer p has not been assigned a
> >> value at this point, so it may potentially contain any garbage value.
> >> Fix this by ensuring pointer p is initialized to NULL.
> >>
> >> Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
> >> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> >> ---
> >>   drivers/acpi/apei/einj-core.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> >> index 7930acd1d3f3..fc801587df8e 100644
> >> --- a/drivers/acpi/apei/einj-core.c
> >> +++ b/drivers/acpi/apei/einj-core.c
> >> @@ -401,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >>   	u32 table_size;
> >>   	int rc = -EIO;
> >>   	struct acpi_generic_address *trigger_param_region = NULL;
> >> -	struct acpi_einj_trigger __iomem *p;
> >> +	struct acpi_einj_trigger __iomem *p = NULL;
> > 
> > Apparently my review of these was pretty weak...  :-/
> > 
> > That said; Why not skip a goto as well?
> 
> Because the goto uses a shared return path and hence reduces the amount 
> of return epilogue used in the generated code.

Is that really important in a debugfs triggered code path?

I'm not seeing the benefit vs reducing the complexity of the code.

Frankly we probably aught to be using the new cleanup features in this
function but I refrained from requesting such a big change.

Ira

> 
> Colin
> 
> > 
> > Ira
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index d6d7e36e3647..fae01795e7f6 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -410,7 +410,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >                         (unsigned long long)trigger_paddr,
> >                         (unsigned long long)trigger_paddr +
> >                              sizeof(trigger_tab) - 1);
> > -               goto out;
> > +               return -EIO;
> >          }
> >          p = ioremap_cache(trigger_paddr, sizeof(*p));
> >          if (!p) {
> > @@ -502,7 +502,6 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >                             table_size - sizeof(trigger_tab));
> >   out_rel_header:
> >          release_mem_region(trigger_paddr, sizeof(trigger_tab));
> > -out:
> >          if (p)
> >                  iounmap(p);
> >   
> 

