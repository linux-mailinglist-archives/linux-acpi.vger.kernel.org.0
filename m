Return-Path: <linux-acpi+bounces-14209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49704AD0B23
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 05:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ECC168536
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 03:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84C192D97;
	Sat,  7 Jun 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/sTNhuO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEE17BA5;
	Sat,  7 Jun 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749267164; cv=fail; b=vEyzgN7gxDBGiXABU5RlNalUatoCQlwPiNOqmnoAx+6cLDupiJFG/WAtfpTIyfjG/ntLf0RWtGN1n9VFGFKCClQmIAhB0ivlmlwMA0rUaqGlC9syNEGklxEV63FdWUKeNIEWxTZhsWVRZNoAYo4Byonc5S9hoL2gqJ58JylpkJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749267164; c=relaxed/simple;
	bh=GMsO/c9jcIEi8z9oe4s0y49Eb3gmvB7EtrwaEgjVsv4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g6extr/b+E0zQarw0itgqmH5wVb1q6duvf23sashHMkZQ05+JKQ+gKJ6q3FBUEurcinwMYSq5ibkWhyiUBe2uE5IC0SGscbpaHgu40ECLk2iyUtkixFnGOIuV2KARk2NyD/u8sgonz4T75cCsh7yyCMAQhEe2YlLlr8KXBqYpNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/sTNhuO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749267163; x=1780803163;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GMsO/c9jcIEi8z9oe4s0y49Eb3gmvB7EtrwaEgjVsv4=;
  b=j/sTNhuOp6YPFiFdwme8XF9+e0gp5ScjanD47xytSfelrZAVesIEV7iX
   KUGIG8o7bA4xhYlj4fvNK2EIkhYk3IpDAfnFM4lMRWmW6jkNY6cytEriS
   E/Din2OUleCxohjFrSGwI45IxeEE/00b9EABdfpoggPjb1MxNeTI0fcAC
   oZRRxdk8Sr0efk+XTdvqZZpX5h/4BXsyIDa/kZHWBSuie18pLsTVo+Pv5
   nxkCN8K5B746dHLPbz2cdbfGLVPduf1DF3NW6ddoTntGxUkYXCL7NEqPp
   odqFg231hUKxIgbPa3VblfTY60nVxDOx21uGiP/f1NxJUnhPthzJXQdvt
   g==;
X-CSE-ConnectionGUID: Q2mwKjFER+y+1wURKMYhFA==
X-CSE-MsgGUID: 0cwswX6UQ4C4CejVl4Eb2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51326384"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51326384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:42 -0700
X-CSE-ConnectionGUID: vtJ3/OUIRpOyuJE3Eqs87w==
X-CSE-MsgGUID: CUvyPM/eR/WK8ZG3956GKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="176879233"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 20:32:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 20:32:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 20:32:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIXmOV98Afa42FKR48tQKxwo4Ptv1BCYlbHuEvDYjm20THe3s/zdN3TTyAcuDz+ls77b/UpckWbkUJ2JFYZFxah8n2H2VAhcRFLMvg43ADh2jH5DPB5Isoo+cnPfyHdQg4cT31PPxC4aDp08gEgagR/0roVP9Jo0YBDZxJR1gcmJ33DhMcruFGSmsx6eg6uVq49ZAFHHYMAxXmdUZJUD+AItW7pQTr51UipEa/oR5nIrGWx6kahW7v7p0E40edxuNfs1PymKfJHCFyOBSoAOXJqiHhUD+VsclF9G9Z9xixLtq6PkM4f95i+GwbOrHEGaHlwdZO19ih+JxUP/MV3+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ft7mP53aV3uJJ3lGxnP8SObJQoiCIrpWc6p21gboQQ=;
 b=sO1ygM4HZ9ATbAOkG+nZ07sFTNNndtjqoqzW41e+PrSeCVMzdagq794l81Ln0R89ifsGiTe/qsxNbAzliT0R/LHUMhRnJ504O7Zb6bsmdd9juM5O9lLaza4S8XgtiI1r6SyTwK0XP8ge8wTpUOSzYhSjSRYymD9OgnNoT2x+HycWxdkt1yhR2BZ8qSw4h0aqqoP8bYgp3elOAl6Gl+nGXETOztuGGVjZ7s0yePZsMMcTv0cZRHXjJ/xV3WnL5QNStpNtyWc8J+q3DjSQ5I07A/RTatDpSpj+JEcMLs0isowekR8zm7LPOuPbGcIxDUToAPnGmL6pDwuvgTRWOkuNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 7 Jun
 2025 03:32:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 03:32:31 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load regression
Date: Fri, 6 Jun 2025 20:32:25 -0700
Message-ID: <20250607033228.1475625-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 19548424-ca0a-48d6-51d7-08dda573ef81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ESv3rfA7HBXU3EPZAxLpAdi3PV4JfCPrsGn5DXuSFmp0w/OIGN0dyFQPHzs?=
 =?us-ascii?Q?0tE/P36uJgLDrCzOyWpcHsvPR35s/ibSS7JMr1xdQSSjGoeu5hChXNTFQqTN?=
 =?us-ascii?Q?BM+4DzUshxDPNahWcB07vqKdXJXQSy0esOJf2eQLyzdrADJNrApTux5WS3jU?=
 =?us-ascii?Q?idqRSYEqlDu0y7DxbW4VdtH8UakI9QAjzfTYBJp1CvK/8umoN8t3TVnbYE8a?=
 =?us-ascii?Q?P2pN7kWNEu2Dan51a/aFQ/glimQjUvTXCSrTeBu+cbdyoWByPgunj/Orqx8j?=
 =?us-ascii?Q?cyoV1nlcEGL+TwFExyBF7bUpN8fKIJbesTO0R+ptvmgAD77i+3o+FSt5OE1b?=
 =?us-ascii?Q?UxLP5zB4uymY0YdaEMNXOGZta3ZKJfd9rkgz5OJKNsEyWWQtp1XRm3kjByeo?=
 =?us-ascii?Q?6l2Xap/bRZj8OriDyYW28rA5LJCLYb0Sj38cNzwRXP3NnL+Rnzd2CjSBohiz?=
 =?us-ascii?Q?HF3NlOKnnt9F/h1nVkv7GlfnqugaAEe4YQr44AeoZYu6vHgJLQYJPQfygH6n?=
 =?us-ascii?Q?GffH3prlutE4UK9LC8B64swt7NaC31HX9DHMJ2+hARnyXhuEG1Vk9HDlbhhV?=
 =?us-ascii?Q?EHSkrbiY9o9C2wEU1xtLPnXZM2vixtA8GYiezBte4Jeo4aMsJxqrlgCb3C2q?=
 =?us-ascii?Q?Sqp5m3LG0IxC2mVAdDZnKkzh0VYEMijDCftj+eeONq8cuNwPBktaQqKkCFQL?=
 =?us-ascii?Q?LbvHmUYDegWNG9oy/hUf8k/sDE3w3arDFCNvoD+AsY5A6NiFwHSqLhAhvEt8?=
 =?us-ascii?Q?fKLINdZzPLtc5JbjQcBhqees6FlfL02FiZT8zr2Ncbqwmngm3Gs7njponLCz?=
 =?us-ascii?Q?FZ01N5fnMIciZn+iUd3hnQO0KOguSuKS8544yuUNgvu2i41MiOgrMtmK2ZJj?=
 =?us-ascii?Q?773NW9Q2hkGqGtQuVzI7vBYdG4jDRO1U/zeH4tdB1SFVTF3AsiU2tpNmXEDu?=
 =?us-ascii?Q?FpcecA7wuA0HYQFM9tMmOwl/n4GCZIWhxd+4z/CUbox278p46Od2uBnVrYJN?=
 =?us-ascii?Q?msnkuQShj0CJaXR1WCwMdNmaTxd5AmoChrlYq9p2ww4dhJduOFxUqDYKI1Jl?=
 =?us-ascii?Q?IfNGKRjETtSs0d0Lr4u6rSp+1l3mVPwGZpVOFZKI07UCjEyVRVaEp9AcdH+0?=
 =?us-ascii?Q?QMHAAkR+eXhBe5X0OwXRZ23JIT5oMSSwFqHUuwUY0aEWKd1UBXdxGonlF6As?=
 =?us-ascii?Q?iIW3KuRi0WRM0X8xw53sASw9oD/jyw6xfjqs7TYSuazG1J1iaIXuq6tRZk7c?=
 =?us-ascii?Q?U12plGEDuGk2Nq6FCrsJiT3SvZye3H3QmbehTiEpkKXVQpJuVfnt6EEx1sg0?=
 =?us-ascii?Q?WPPBdyUfx6qjk9pJJD3N3Gdey6HtXeMAxD32hHau/s+bu3oPsolsrv7gOb8f?=
 =?us-ascii?Q?UvBUbZWX2NPZCic1h0PI7vcGFvOsVKkRtAfZ5Trw4xLlWpgrgcL7GFc1zvhu?=
 =?us-ascii?Q?nUEOTlLYKDQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NclfGoMb5CHp4F0DmzKn7mxuIIYgiN/jVVN2x2UH75MNCU2v9fzpa3kJBKWo?=
 =?us-ascii?Q?AP8vXKqBcb/5ejx0x578EQ9bI+qXA8zVuxX73U2JHxC2McN/BEUp2LH1pQ0+?=
 =?us-ascii?Q?vQSKNtkzmB01aULgiVFOsWLoMj/Y3yA8KsYBZvLxgfDhubmdXlhBRWpyPMFt?=
 =?us-ascii?Q?j/yxFmUx+vbk0bCywH3L+foibT/Q6GPhYH/TvpwK2g6XSVm7joRDb6HQFpNC?=
 =?us-ascii?Q?jPe10YwY8rh/+oPswJ5jmLRfbeqdYtkQtcN9K4Gbwq35StseCzDLI1sDfyDr?=
 =?us-ascii?Q?afKxC7W67dR1SI8l5TlnAMIyeZe+XEhWkBnzLMUrowK0sKvdkoKrEqVNLhd7?=
 =?us-ascii?Q?cYBuJvSK9L5EWjExbuzvEJZ+PPQvM80GyClA0sVa9mROmngR9T9ET1fKl/Dq?=
 =?us-ascii?Q?tOTxPmuRO/yjYfeMnz4wqlbAMpKWyAarT4ppEL6p0pK3MjVutHNGkZtkba/3?=
 =?us-ascii?Q?TgPn0wB69sFkc8NX1BLTNp8icE83rYytSqMB6aDC/A7DJprSyXPexNEOVAYk?=
 =?us-ascii?Q?1QEh6cvSwlAKKXm1TmQ1H6wrcD2K9S3Tynatsut3PizEVNGpGuFkMqkJA1mP?=
 =?us-ascii?Q?ZudyoSiWmv5INRjHj+sZsR2yebwXkDR2953Hn6xW0Cjo5tuu8E4UrmNPYhY1?=
 =?us-ascii?Q?yZH/qwCJTRCRvlVlFW8a+AsuoPHieIMUk3XH4xLsf2OOpF36+Uy9KbET5VwE?=
 =?us-ascii?Q?AbrphxzHf8bRT8rkv9GY6NCn/sYElgwY1tUPBPG2Z3P6+wsE5lpRfQDJCwRm?=
 =?us-ascii?Q?5pPJ+UZc6L95GSwaAVUbm3M3auyD6fpY4dyQ9P0ERNVZGivTU1+PtX1ym04i?=
 =?us-ascii?Q?Bzt8ONf87P+884cNWdWYII4W9524WH2J8VRzi2wfQMRikH9zWmihsZDl/TVQ?=
 =?us-ascii?Q?WvxmKoJ59vg7W9uopwuOdYlgpk/uRCP8ZtX/CtQild/OqXNBCCj8iGZLVgPr?=
 =?us-ascii?Q?7AOyAHAnqt19MXYM5P/rU8huGkd9RDFyyQJGUQz7E/e20JA0npPJE/uSc7Hu?=
 =?us-ascii?Q?tnvU0K/rh3wccKhmnb6acaIYfEfKm75O/7La8n3dsy6dkIl77XmKdKndRDSX?=
 =?us-ascii?Q?1wFsfCvMCgJ0X5jOnrcmpa0Y/R6ARawUPYURcUA9pX0djrNFJKOE+Z0T8sh7?=
 =?us-ascii?Q?2bTG7RYuPEKbTFLbzgjCipscU2PD/OpUz1Md1qPWBifjOVzGGhG6phqbRyx/?=
 =?us-ascii?Q?1lWEQ8EM+QGwahhPg8brYSzlKoRk3Io7kFR7k5s0hnU7SHQBcd23k8BZd6tk?=
 =?us-ascii?Q?tiCx1c2lvfEgyyiQCcjsCWd6frAkCCyjjZWLhkNFSeVKTPK6LoC9y3MTd05P?=
 =?us-ascii?Q?1+u00FNRFnnzRy5l9huqAMeeoxNvVdUS2AJx8zJFj+tIDPV3/Tl5Jal4IscU?=
 =?us-ascii?Q?GdXmxDd5HWiSZNzqACH6O74rn4ZbrubQhkBMxOJ7jHM55BLjcIYNT6NZJmfv?=
 =?us-ascii?Q?y+LKTHaPHWEUoAzpPZaQoGVKmUpSa8XTCJMsAq8kG87NDT4LDwXClcyFeK68?=
 =?us-ascii?Q?sKep9Yf++X4q5CZGKAVp6TU4Vs75RSOT5/5X5QGMqH3b8NoWnFtmxkVOel0X?=
 =?us-ascii?Q?2wwsXroJ3MNTUgoYCbDHEz6Fr9fOspRVye60degAQ+kLaOrb8v9N5rwu6no3?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19548424-ca0a-48d6-51d7-08dda573ef81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 03:32:31.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nm8mIMyMgfKX/NUzXRyNV+p7XG0DtOedS4Bm7DhgO36OEDdtKeGv1hOhpuIl4JM2AJGhatKlXOeD/4+K7fJBmwYHBRtMbd3ukV+TzvzzI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

git bisect flags:

6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")

...as the reason basic CXL unit tests are failing on latest mainline. In
addition to the fix to einj-core.c, this also needs some updates to
faux_device to make it behave more like platform_driver_probe(). Details
in the individual patches.

Dan Williams (3):
  driver core: faux: Suppress bind attributes
  driver core: faux: Quiet probe failures
  ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create()
    failure

 drivers/acpi/apei/einj-core.c | 9 +++------
 drivers/base/faux.c           | 3 ++-
 2 files changed, 5 insertions(+), 7 deletions(-)


base-commit: a9dfb7db96f7bc1f30feae673aab7fdbfbc94e9c
-- 
2.49.0


