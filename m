Return-Path: <linux-acpi+bounces-13523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D9AAD560
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 07:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748B01BA00B4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128341E2858;
	Wed,  7 May 2025 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YefSLOMs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD31D88D7;
	Wed,  7 May 2025 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746596550; cv=fail; b=FnDEbBRHeh19JqmGl56rziuXzBS4Gm28tS3JAmCe4bSBkW4QWmnh9oekP4Ut+JxUbrvtHxhSrZjHhiZVlVmyHiAJ44J2TMxk7pZaqtGoF+XhEW2gFS2mGCcPkFfK7VbATdj9HIB50M50SCxQ2KWmhYl0Rx3XTnSmfHUmqyysxxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746596550; c=relaxed/simple;
	bh=IWPFunk2CfYBN0sYyJuMfJknXubPSPg4hOEt3KBiRCQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b562e+Eq36CmgrYkPCTrEIoDC4O+bs/uMzvvj0oCBkrYm67O95Macw+HTaqvbyG9mK8H3UU7Cd7nDputL83mahIFsfO+6A+vrp3NAf7/jGgqNInz/UlrryMGq4+k+OJSHth2W0mhr65QfPDXpIvicaJk05cJdI9VJyEtMh/vR/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YefSLOMs; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746596548; x=1778132548;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=IWPFunk2CfYBN0sYyJuMfJknXubPSPg4hOEt3KBiRCQ=;
  b=YefSLOMs9xtsDMuwqF7a3cngwk1aOI38qcwXXhyL1yNSd368hVaLnnp2
   RYSA2yTV0SHRpoV85FAmr6DFuL46ARRVQo5JLKvX6spYtLJ5WLNl3qZ+U
   XXbVCFKKZMCv/pQEac3U/58mLgUIZK1CiFKTuQwveoBa7kCpXKhrNaZwS
   NaqQng0ftRQApsKuqCMZ3qRAJKODa4Awm4ITpbcPMAMwITUuJLP67Ee5v
   eTcepHEvA+6JHhqhCbz7yx2L8YuKbjSaVmOSrqYgMbIr2vqTSeyWb14Ij
   0miDEE2lnsav60tw4RgNk80D8nCT0rCq7lNKZk8g01/74R4ksS/sWB0dp
   A==;
X-CSE-ConnectionGUID: eWjjP1enTyqwVaVHHDX4jA==
X-CSE-MsgGUID: ACcvREVJQcSMKWwv59nNaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50952803"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="50952803"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 22:42:27 -0700
X-CSE-ConnectionGUID: tQd5pFZSSUys49EEgECNNA==
X-CSE-MsgGUID: win4kis2RSiwOPukzm94MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="166891061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 22:42:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 22:42:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 22:42:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 22:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC1VVM9Yh9GYI3FO+g8/xKHS5H1SExCWgPnnUEZY7aWc5SoiP/j1J03s/rJ1h25bOzzi+I+wxQGR9OI0DRkdNAD0mmFuwC17GHRe28sb6SowK2BzO1yMFJdh09Xhg7SWtYFdUg4TmAI25sME623ZRlZWWk3LRC8MI/hWL/dPWd5CnGnV9L2qlxTBZsO9bKPr0aAafNscCHWFxTIz7qmn9OI3s4ebNlQWHvez4UQs6Y3uDFAQP+MI82EWeCTmurCGNqrGCU2fzggOrVZ/yhKrQRk0kFHrU0luMtzr8uWUbcp8L1cmotvRV21wok68do7sfnLVNYX3iUMjP2GhmTbabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U6yDi8GD1j+lRs2PTLsqQI6xVBXNXO0S3UpgYpQBvA=;
 b=VfWmOCu3Ew4wwwCHR2IDcERH7RRnhlv8YXIuDD8OvAbPGejLLmZdFaFEF2QGte1Em/ilZHAdk5KQI2CNXPmDLI4VIqIqO69VmHie/+16U6sVUrMSr6vXQBElWYtaRBK0qt8GEmelxP5owOpChG3/v9QmzjQxNbbVPyCDzAJscmt1xpvrbrbc/KAyq16dJkV2nEJRlecErN6iasEIhYBB43EDLLFSazkPSYY0tef7gtwr0f0Arl0RWuTwiPk9Mu+Ca2q2y4sw5E+58LYZOgINp63ZldOgTQvUbWkSnR74VNDvtkwN79/kdRB0llq2f8eJ2kWEKBAITKOjaXt7kDlkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 05:42:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 05:42:19 +0000
Date: Wed, 7 May 2025 13:42:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, "Bob
 Moore" <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1 18/19] ACPICA: Replace strncpy() with memcpy()
Message-ID: <202505071055.2de34dd7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1910878.atdPhlSkOF@rjwysocki.net>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: c33be4f2-540b-4bab-4682-08dd8d29eeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m0JAK5q7l5AClolEx9stjjqEEKwgLlQtYOBj/abSlHCjnK8XVzuNtv4j31cx?=
 =?us-ascii?Q?lNZNz9sNRDu9iHP240OeJnaUL2ebof/0Y8Vesfkd0IJdAgLk4ugq3zEtmr5O?=
 =?us-ascii?Q?fOEIvHZo3Lc/yRvKhvu2wWqeBHrnbgLQERQHPOGIaf7/iEhNdaDy2FzNBuNe?=
 =?us-ascii?Q?3xZLJChKSU1SRQ9gUwihUf4FHBzZtBfG6UfGxyFGaizIzeSYmOHM7vsdTYBM?=
 =?us-ascii?Q?dzr8o4lMCnfA6vfApVbqPH7ZacMBtFRJwee0e68KvMa0p0C9aJjq0DSGX/9U?=
 =?us-ascii?Q?Qz64m39uBMQU8fr4/9F5bLlLgJTJ8nMc2cFLaMa4AjORnVK6v+fxTp2G8p4Y?=
 =?us-ascii?Q?CuNMxVxpgM8vaKLi70KVuIcFEScebuQoMclS4FF/MwQ4IjYt6zSV0FbDSRcr?=
 =?us-ascii?Q?AyQfuiRSm/Ty1UkpFJbO5c2GSJWUff+FLdxl/jCPk5pzJQCuBlNWavIzXQoR?=
 =?us-ascii?Q?glxgbfunCQb/vc4VqJOksaADakDxqpjwo83Bpv0EeDh7KABaOG0B1r2wrc0f?=
 =?us-ascii?Q?ZBkMko/hecw5/xa9AXAVQOZK238u9DrYtT/D9tKSnTWlgJOh4U3Tl/p4UDyw?=
 =?us-ascii?Q?3qYlOsaEuLoBB0YcbhFXib76dJYaPiDLjKXqv5SVg2U1hzvXq/G0MdoZxLQI?=
 =?us-ascii?Q?vkt7AmCH12fBSELuNXF45uBvfh+wlhnRzivT2LkXUcVq5PqpCwhhTILBgM0r?=
 =?us-ascii?Q?R8zGbGit1bF+hSmyZ6Vkbg6Uqhu59VH3I3Zq1ctCpkBA+VkRs1YHzino/9ff?=
 =?us-ascii?Q?rGJhWYIrHgnR2itvdl7ZtbSh6SRCqZMgPx+Ymfgtz9wTwVkAmjws8JUMowof?=
 =?us-ascii?Q?BRUnSxeuYxPgdNlT3Aco6c6Nnf1A4Ca8FOQbmffXZnXWwNN330ig9ECpdaCB?=
 =?us-ascii?Q?hsDYioa4zUnBitAK6xmjPmkJwm+B4M5wRBlpgTe9ChescFEqjYt+/HvRXjbg?=
 =?us-ascii?Q?2nwxESJZNgrEp9VY3fEuV8/Bk27gHVQsjiuQ3huY15RHJsJ+LH/PNpxNCGT7?=
 =?us-ascii?Q?TQQvYVAnw4jtGNMK22Fsq19BS9qANGuoUHxBF49nudfHsxMDMdYapwdI4RAG?=
 =?us-ascii?Q?kU4n2LRo9+H8alCvjeD7JsQDapD8YxD1khoiizgkE4xxJeAEGJzH2hioy9mG?=
 =?us-ascii?Q?xovjz1druQ3/XeZo7VApM6eNNgOa5kwbW5AdLY3y5o7CpVbgAPGk862O8cnj?=
 =?us-ascii?Q?IgpwZl9Od39Sg5RqHusLF7OmPZGwJYWWX+bShihCjU4Q7+MphQEqFJfPPayR?=
 =?us-ascii?Q?dhdnEVA8iOSYMxoc1FHgcBBc8zRw9flHB0U0rB/aq/cgzaYLMh0XzUChvO2K?=
 =?us-ascii?Q?1c+KNn9vuagA1SF52TlAxxvTUPUdZj6IDMoCgk+qN9JeEpp3trRpGHVA4AFO?=
 =?us-ascii?Q?CHsso+FTOxsyF7iw5l+zfz9PtDV4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzYiX6Rjpl8M+/idWTXagTvS5T8IsbpT3Ghqn18DrbdPRpHMIDDJPFzwOJNP?=
 =?us-ascii?Q?QM2OCx0yU7I+N43JLfsdGUHdRAcheYcvefJNv3VnqYzBdUCkZntDfJCkfv7Q?=
 =?us-ascii?Q?8mdv1/9f8NxpebsfWGlYrbS4ePF9t28XQoCJgmZsl8/k1vE4euaBM2qexb6e?=
 =?us-ascii?Q?7oC9usrxXsIQ/sxdYxjRKYqejRRP9jmP8qOKfq8VlnnC2Nb8TP9NMsDuFMYc?=
 =?us-ascii?Q?24SJ/haz5LNvwvwFTBHe7h8nX21vpR44IzPbeUqW/I+yYFyMf3LQcblyOGsB?=
 =?us-ascii?Q?10unqxOMGGK5aIW/QwJCAEUk3X9BO8752mghCwKqot/8PnSaKGeZEmbtbxtZ?=
 =?us-ascii?Q?BXi6pVIxPuBSZ65uCOHiEu6breNBYSoJwmYkrciuN+EgezPnKM4Owbx7hLWj?=
 =?us-ascii?Q?vb4/1jLLnsduIwLpXMzJzDlJxG0FHZ4C+jkPFvzdEVXCxXRJG6ed50dWT+n9?=
 =?us-ascii?Q?je6NlK6ocibdwoPUEuIe0Nsi6tYwHfrhSRilpyjLpBtiC8JGWFVuXd7nKQ/u?=
 =?us-ascii?Q?/DA34wJeYkEjm10TySu8xOEt7nmS3kZL6mVSTwrbBo7f+KRbYfBK6Qr32ym9?=
 =?us-ascii?Q?RIZAoJ4OKKrp2Z2MFHtnXcmFtw/1w6zZ9Ya00+kF1rC0YgYe3pPd5LSSXBOe?=
 =?us-ascii?Q?e91Cw0adBX3D5fO/2+dPyM/hORh3NmjDAMQ/I0qqnBMGUgzd219jQpz55HeA?=
 =?us-ascii?Q?PNoV7I6QrWX6i6vllziPcl25SNSaTLPihA2t3fIRvZDuAsOd/o3iOlU7SAUQ?=
 =?us-ascii?Q?gaiJRaRVrWeqNlCgDLw9xGV4WNm2VhDbhSBjYmIfCKa8nl4Wx5/DMBJV9qFq?=
 =?us-ascii?Q?pMJZmpvg7ASUU1UjCXP7Xfea4YidI2DkpVtYXMe/vpXZ+WUsCClwzO7IXCVK?=
 =?us-ascii?Q?Hzlx5vT6tsoiUDvIK+lKjD4iOpNf5V0Eu6oum36z8runKQMsKjF7JNqNjypF?=
 =?us-ascii?Q?iphGMYFfuhMW2S3wsU2hoqtsewRZn5xxQ0VlTW7k3Tly7LhWKhSVQE8DtvaN?=
 =?us-ascii?Q?3Fj9GkIWYI4dY7naDpLr6IKm6ZhDG8aG7F06I6ov11lsVZlwvvZf27gz7M4L?=
 =?us-ascii?Q?Vs8HaLgsoqY0GwZMGVH+jgPG/j6Tk0Lnz54s4k3qOzwyCivbSeGirJw/SrlH?=
 =?us-ascii?Q?D0H7vKuMrvt1+KWT7BTyaJDF9PRANNGMme1XICjQD2CJ592n1n2bVHhQqTQN?=
 =?us-ascii?Q?6NTs+qtAFofbm0J5qXIFkUxqsTvdgbzXcEVjpIWdlcBvMETbd/na/o7qAlPm?=
 =?us-ascii?Q?Jp+BGFw3l83ZUIf+QZj9pqX0WllEfXdGab5su2QALwobL1r96FwSOk4TqxMN?=
 =?us-ascii?Q?mvneUOz7KIS13QLenpVFXbsMoS0NjN+CyWNX0pqZltlN+cYf1VHV08qCNIMY?=
 =?us-ascii?Q?9M8IWrDEEFwZoinpeXOGfn+G/htJ5RFH8xEj+QFY46Lf1wRlrwfl1hNyJHMO?=
 =?us-ascii?Q?ejA4m+T4YSBUFJo121khijF7y8Y3VFy1HXZ+KOTfhl3165KkRWkVYMzlq4wt?=
 =?us-ascii?Q?VyG05gL2wZL0I5dxPkYjNM8ooe52hcZf3WIrZe0FpNmoMhCxpZhC1hOiQ2dh?=
 =?us-ascii?Q?nQhBezo7wOnJYg1xmzylFnUopZqFFwaGgnouOQhGN5XrJRgceP+d5I+1nQ0k?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c33be4f2-540b-4bab-4682-08dd8d29eeda
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 05:42:19.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hVv9Fk4uMf6/wMKQOZH5XJfhcaVFQciVY/PJW27I+1TcJLCsBLr9StCavbHiw1hXsPjMAm+LyHOobI2tS+SFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_acpi_ut_safe_strncpy" on:

commit: 42d0e849d2f0848ac665486c5b38b5321bce299e ("[PATCH v1 18/19] ACPICA: Replace strncpy() with memcpy()")
url: https://github.com/intel-lab-lkp/linux/commits/Rafael-J-Wysocki/ACPICA-Drop-stale-comment-about-the-header-file-content/20250426-034340
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/1910878.atdPhlSkOF@rjwysocki.net/
patch subject: [PATCH v1 18/19] ACPICA: Replace strncpy() with memcpy()

in testcase: boot

config: x86_64-randconfig-103-20250426
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 2d3714d918 | 42d0e849d2 |
+--------------------------------------------------------+------------+------------+
| BUG:KASAN:global-out-of-bounds_in_acpi_ut_safe_strncpy | 0          | 18         |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505071055.2de34dd7-lkp@intel.com


[ 11.237174][ T1] BUG: KASAN: global-out-of-bounds in acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utnonansi.c:172) 
[   11.237174][    T1] Read of size 16 at addr ffffffffb92c19e0 by task swapper/0/1
[   11.237174][    T1]
[   11.237174][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc3-00082-g42d0e849d2f0 #1 PREEMPTLAZY
[   11.237174][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   11.237174][    T1] Call Trace:
[   11.237174][    T1]  <TASK>
[ 11.237174][ T1] dump_stack_lvl (kbuild/obj/consumer/x86_64-randconfig-103-20250426/lib/dump_stack.c:123) 
[ 11.237174][ T1] print_address_description+0x33/0x3d0 
[ 11.237174][ T1] print_report (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/report.c:522) 
[ 11.237174][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utnonansi.c:172) 
[ 11.237174][ T1] ? kasan_addr_to_slab (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/common.c:37) 
[ 11.237174][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utnonansi.c:172) 
[ 11.237174][ T1] kasan_report (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/report.c:636) 
[ 11.237174][ T1] ? acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utnonansi.c:172) 
[ 11.237174][ T1] kasan_check_range (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/generic.c:183 kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/generic.c:189) 
[ 11.237174][ T1] __asan_memcpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/shadow.c:105) 
[ 11.237174][ T1] acpi_ut_safe_strncpy (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utnonansi.c:172) 
[ 11.237174][ T1] acpi_ps_alloc_op (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/psutils.c:122) 
[ 11.237174][ T1] acpi_ps_create_scope_op (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/psutils.c:34) 
[ 11.237174][ T1] acpi_ps_execute_table (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/psxface.c:249) 
[ 11.237174][ T1] ? acpi_ns_get_normalized_pathname (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/nsnames.c:321 (discriminator 1)) 
[ 11.237174][ T1] acpi_ns_execute_table (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/nsparse.c:120 (discriminator 5)) 
[ 11.237174][ T1] ? acpi_ns_get_attached_data (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/nsparse.c:45) 
[ 11.237174][ T1] ? acpi_ut_add_address_range (kbuild/obj/consumer/x86_64-randconfig-103-20250426/include/linux/sched.h:2268 kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utaddress.c:56) 
[ 11.237174][ T1] ? acpi_os_signal_semaphore (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/osl.c:1334) 
[ 11.237174][ T1] ? __sanitizer_cov_trace_const_cmp4 (kbuild/obj/consumer/x86_64-randconfig-103-20250426/kernel/kcov.c:316) 
[ 11.237174][ T1] ? acpi_ut_status_exit (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/utdebug.c:474) 
[ 11.237174][ T1] acpi_ns_parse_table (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/nsparse.c:270 (discriminator 5)) 
[ 11.237174][ T1] acpi_ns_load_table (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/nsload.c:72) 
[ 11.237174][ T1] acpi_tb_load_namespace (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/tbxfload.c:159) 
[ 11.237174][ T1] ? acpi_ev_install_region_handlers (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/evhandler.c:101 (discriminator 1)) 
[ 11.237174][ T1] acpi_load_tables (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/acpica/tbxfload.c:63) 
[ 11.237174][ T1] acpi_bus_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/bus.c:1344) 
[ 11.237174][ T1] ? acpi_sleep_proc_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/bus.c:1337) 
[ 11.237174][ T1] ? kset_create_and_add (kbuild/obj/consumer/x86_64-randconfig-103-20250426/lib/kobject.c:412) 
[ 11.237174][ T1] ? __kasan_kmalloc (kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/common.c:377 kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/kasan/common.c:394) 
[ 11.237174][ T1] ? __sanitizer_cov_trace_const_cmp4 (kbuild/obj/consumer/x86_64-randconfig-103-20250426/kernel/kcov.c:316) 
[ 11.237174][ T1] acpi_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/acpi/bus.c:1455) 
[ 11.237174][ T1] ? acpi_arch_init+0x20/0x20 
[ 11.237174][ T1] ? fb_console_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/drivers/video/fbdev/core/fbcon.c:3368) 
[ 11.237174][ T1] ? acpi_arch_init+0x20/0x20 
[ 11.237174][ T1] do_one_initcall (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1257) 
[ 11.237174][ T1] ? rdinit_setup (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1303) 
[ 11.237174][ T1] ? trace_event_raw_event_initcall_level (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1248) 
[ 11.237174][ T1] ? __kmalloc_noprof (kbuild/obj/consumer/x86_64-randconfig-103-20250426/include/trace/events/kmem.h:54 kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/slub.c:4342 kbuild/obj/consumer/x86_64-randconfig-103-20250426/mm/slub.c:4353) 
[ 11.237174][ T1] do_initcalls (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1318 kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1335) 
[ 11.237174][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1569) 
[ 11.237174][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1449) 
[ 11.237174][ T1] kernel_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1459) 
[ 11.237174][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1449) 
[ 11.237174][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-103-20250426/arch/x86/kernel/process.c:153) 
[ 11.237174][ T1] ? rest_init (kbuild/obj/consumer/x86_64-randconfig-103-20250426/init/main.c:1449) 
[ 11.237174][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-103-20250426/arch/x86/entry/entry_64.S:255) 
[   11.237174][    T1] RIP: 2e66:0x0
[ 11.237174][ T1] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[   11.237174][    T1] RSP: 0084:0000000000000000 EFLAGS: 841f0f2e660000 ORIG_RAX: 2e66000000000084
[   11.237174][    T1] RAX: 0000000000000000 RBX: 2e66000000000084 RCX: 0000000000841f0f
[   11.237174][    T1] RDX: 000000841f0f2e66 RSI: 00841f0f2e660000 RDI: 1f0f2e6600000000
[   11.237174][    T1] RBP: 1f0f2e6600000000 R08: 1f0f2e6600000000 R09: 00841f0f2e660000
[   11.237174][    T1] R10: 000000841f0f2e66 R11: 0000000000841f0f R12: 00841f0f2e660000
[   11.237174][    T1] R13: 000000841f0f2e66 R14: 0000000000841f0f R15: 2e66000000000084
[   11.237174][    T1]  </TASK>
[   11.237174][    T1]
[   11.237174][    T1] The buggy address belongs to the variable:
[ 11.237174][ T1] _acpi_module_name+0x240/0x20c0 
[   11.237174][    T1]
[   11.237174][    T1] The buggy address belongs to the physical page:
[   11.237174][    T1] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x890c1
[   11.237174][    T1] flags: 0x100000000002000(reserved|node=0|zone=1)
[   11.237174][    T1] raw: 0100000000002000 ffffea0002243048 ffffea0002243048 0000000000000000
[   11.237174][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   11.237174][    T1] page dumped because: kasan: bad access detected
[   11.237174][    T1] page_owner info is not present (never set?)
[   11.237174][    T1]
[   11.237174][    T1] Memory state around the buggy address:
[   11.237174][    T1]  ffffffffb92c1880: f9 f9 f9 f9 05 f9 f9 f9 f9 f9 f9 f9 00 02 f9 f9
[   11.237174][    T1]  ffffffffb92c1900: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 03 f9 f9
[   11.237174][    T1] >ffffffffb92c1980: f9 f9 f9 f9 07 f9 f9 f9 f9 f9 f9 f9 06 f9 f9 f9
[   11.237174][    T1]                                                        ^
[   11.237174][    T1]  ffffffffb92c1a00: f9 f9 f9 f9 07 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9
[   11.237174][    T1]  ffffffffb92c1a80: f9 f9 f9 f9 07 f9 f9 f9 f9 f9 f9 f9 07 f9 f9 f9
[   11.237174][    T1] ==================================================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250507/202505071055.2de34dd7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


