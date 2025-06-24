Return-Path: <linux-acpi+bounces-14577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A799AE7149
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 23:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5698E3A6594
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE538241668;
	Tue, 24 Jun 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9bctNLC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E023074B5;
	Tue, 24 Jun 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799356; cv=fail; b=kG5fpR9HzvS+G92TV2bk2gXN4QSv4wuMj1VqUXySLWjUee/TdiBYq683PPh2gwNuBjdou9PP+jXmjWVBw+C2TqugC2xRGOCX4faZg95k+Phve2fxSAwsejV19NdItqn5Ya/rKnCP8UPMJTs8EPS4KnTMcUj2NHDKIEbnQY8OJ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799356; c=relaxed/simple;
	bh=2FcqEXWkLACfwSGnZxkJOGO28dDDBLp8Fs6kPuuMzY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAZ/wMbtEcZyKEzPueZ4wB+8YcGZrkGC9MloKE7r4gI8yyWqQ0fYYiV9YeUCkvSfLolEFeSv174BPRffht3bEKoAeAhHP5mnP0Vs2lTkcWYNjYr1VEXlsURgPdbBWFNOZxLFLrFqGOfR5cwoNkqaX7a5CYxYzpTr8IQ8fd9XF/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9bctNLC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750799355; x=1782335355;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2FcqEXWkLACfwSGnZxkJOGO28dDDBLp8Fs6kPuuMzY0=;
  b=Y9bctNLCAiGGlCiMb0tqVdRYkPYSKLjDkbaTbG1qtgUIngvjWnuLOaEb
   w3GSq6J2WPmntCb2hh+5+kYStL5bMIeLhMBqUKhaXyI5AVtkNlVy2on7W
   mGcJrEJC1APer0LZVIIiK4XF7jabNEjpOogXB53S5nCCHdf9S7toJReaE
   j3XO2KrFjJ3prDW8WHi5UyW1DtJdooRBgzEe+enFOIqSQM8D+nzCzWHZn
   IMRci0EbX7k+a+I97EGMBYLr25GD69b7mfKfA7VVKVDUogbPUF9w8IED4
   NEiy/xyEQBJHowHCRC2VVv0XtUsPFnYsntYaSR7vkVh4PKYOS2a2Tce71
   g==;
X-CSE-ConnectionGUID: Qr1mzJ8HT6SwvLb0k7WjeA==
X-CSE-MsgGUID: trzQFGAxT2eiqbsAxMq40A==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53153203"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="53153203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 14:09:15 -0700
X-CSE-ConnectionGUID: s91U8Ni+TXuUiKaMgXy0qg==
X-CSE-MsgGUID: 6If8nSMoQ6iS3cGlkHXYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152545802"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 14:09:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 14:09:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 14:09:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 14:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ4QNNxvcZ5E6jCWe66y1KbXvwPVZwNIDgeEJjAKFTc53iljPB14IXMXQElgZIoaGB/pKmnSPHJqeK+FktgiW+he6Ui/+O/reOFdT5SkvtdUl6S0j/1qclFcnIdv0oyWLuIhZA+G6L4ERziDjcJ8H6EPE7UWlfvYIqh3nkXsU+oltJXFfAU3wP+NF5rJfNIRItdN8Jj1gDzi6QW+RTMBwQjZPfIBvgCZixkJ6d2jFn1N2oJwCv44AbL0hdkYUB15xGLup1Ggn54iBis4gnxOEYm7a0O7tpcr6jV0gMiazHkQNNMaQQ404PMwHLBu4dOMVZFGTgIuy3qF85FQC4bPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK7VbjnDNzdnpBpRgrlx7S001h3cgbz8lQjICwzjPnc=;
 b=hIdb+HI5mXSpypjehUDGcgA6fNd47KzkCpgylZLeuYrko1VbxVqpVte2IACT6XoTkzVEi/a0/nlUeZZzRSd/oL7va0qQUXcsPbyGaamB2ptk8ZiL8ALPyUuw9QO/yzvj786phftCYduS3UicFTtKadHajBvLRZVgwi6NEE/ryMgYqVqqUH9FYoywqu7V5lxMzctYZ2HRUQThWOj2Qvnb/KsUj2X/VF9dD3ErOaDTwVZLDlJf8/rumpMrU3KJ8459KW6Fn4EeCXRwz23X8ISrnmKY3gcnYOoBk4hmwSaxzm7Kz7xYHKwzfCFJF+iOc7arOXc8DCYPw7e79N1+ur5oMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA3PR11MB8917.namprd11.prod.outlook.com
 (2603:10b6:208:57d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 21:08:44 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Tue, 24 Jun 2025
 21:08:44 +0000
Date: Tue, 24 Jun 2025 16:10:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Zaid Alali <zaidal@os.amperecomputing.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix less than zero comparison on
 a size_t variable
Message-ID: <685b142c66165_2bbf0029417@iweiny-mobl.notmuch>
References: <20250624201032.522168-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624201032.522168-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA3PR11MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c1c038-f7cf-4762-b1a7-08ddb3634da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Zq7uzdQIGXnDttyXpKGZmzazGLZORDTBGe7v/eu18cBZVnzE5hudjZ/06ug?=
 =?us-ascii?Q?FDisKfWASaZrJ9d0DOkM4lzjHdREdsEVOc7DOhM4tkiFl1GUhjKajzmQjPAB?=
 =?us-ascii?Q?I8htuCBWVucX4Vb1cEOpK28yc1j0z92+VQa2ojBQ4cpgZZ64lhX/qJzt/eol?=
 =?us-ascii?Q?FOJk/5Rcu1cSyDC+jxDaiMbx4pjkipIbWjPb25UeOVHEJDxtsSYMKD7joPPo?=
 =?us-ascii?Q?FSffH6CdFxPyTIrtchmm87ssnORF0QXQlhvXMzm5+jRVVnINWNgZl4mg78oX?=
 =?us-ascii?Q?EHj2GzaSYiLxBjJ5IE25fXcEULGm2R57ByTBVtQ6/m+7mzCbCLl+QE3WVe88?=
 =?us-ascii?Q?6dC9a/z/94sBmEpfb06pHFEthLOk6TB3Exjct4eEM3SXfN+jgCBnQwg+MBiw?=
 =?us-ascii?Q?cx7M4B7rSFONITzdKklJX+e21ji4ZlJmP+yPbrvrl0E7rSBc77zNRm+/lALu?=
 =?us-ascii?Q?p3g6H6I16LNJSQyjCpWVzm3/FMK1L76v3dXbTcVnydRyxBUXBlKkY/6K/pyO?=
 =?us-ascii?Q?gwGEQ/7ZPqptRBIOtxQxuiv9VT2f08k1iAoQxitoPM4fgbmvO+WpttWaCe3j?=
 =?us-ascii?Q?/ccy465RIu5mJzoU7VpH29kzeZ/z8WnPXd5Fj/Juj2KP3dW3Jg9hYupg3RRv?=
 =?us-ascii?Q?xcL2n006wItV0nx2s57AclNQwPhTxOHIr760LXnYgun+fQVOJsPaG6ebvta1?=
 =?us-ascii?Q?o46PgjNvYS/QOWYyc7vt0LxlGy4dw/LzLVmN2Ens/HqfNwSBBNl1U5Qsa3Pe?=
 =?us-ascii?Q?+rs6xbeh8pDrhfKCWgerTZnS4TOZeqdQh/3V8n/qHkQGRbAgAoqsGnAaryuB?=
 =?us-ascii?Q?rmsYgbNMW66KHiXe9MEN5P+2rOYywVA/VCC6IG+I3zIVUjXcuIbJKGh6uvdN?=
 =?us-ascii?Q?tKCJoQKoVP7DNTa1MX1VjEPNXbOAwDDr3/1x9bZ05ennbg48uU2LZt8CV17F?=
 =?us-ascii?Q?P6uIMVFojwxGjQg7aqnLMGmMef+Kwrrv7ziy6tmtFrawBVY/E1nKpey2rYzk?=
 =?us-ascii?Q?EX0rGFLCfTcRFuxSrGLnVY4W6SewTQZVasLdJ0V0+ZhNrlFE2PbNGIomb+6V?=
 =?us-ascii?Q?Vw2qyM3f6+n17jcgZZyuVuNEGpM8gh+XtntgzDnSTV+cyG9EMNHehxvNT91h?=
 =?us-ascii?Q?gj8g1yZESsY3NGZc1UiBWTl26GLVLe+TKNRr1LqPiNb9J5zgnY/bsznhiSDd?=
 =?us-ascii?Q?fSCIygAa6EkqgB2MMEtCb3DZ1PpMToNQeQpUzhDep/NtlDQrC4jc3Ovf5M1r?=
 =?us-ascii?Q?YNn6fOL2hwZc4FXKluYjSfy4atsP0xf1BTjXt8jCvelG8QeudzUnfnT+Ctqx?=
 =?us-ascii?Q?ituj83PPQhA2VnRO5Bp1klKhH55Rk/EEaLCZR9KYcDLnw4FzWuVrQL4QuirR?=
 =?us-ascii?Q?oUOmqrxQ6MNmFSVEmJca4OhybW4de2RRSrlFJavXyAJ6BjDUIGdni3xKp6/N?=
 =?us-ascii?Q?DlcvkCklcXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zgp6l9gXNy78txh88F52NGV3V6p0rBsLZWOVXyvlBiK4ut2i4ag+hlXZWQsK?=
 =?us-ascii?Q?yQLFHLAEJQY4JdTMdh0ucKDGrc/C4SRiCdS504ewCQtMq5WmiWtXcq+G7Zy4?=
 =?us-ascii?Q?q0BkxnNb9FG7ngyRgDra7M1z8Jyq7MhWKpzi+7QbKm5yXHrKwbwFM0vUNQ8t?=
 =?us-ascii?Q?TVzIMT4wEJRf4N49JRkcsDjS/0lbkQ5bjYISurGBbnWVmnbsxuEdCZ4sPGhd?=
 =?us-ascii?Q?BmGB489D75zQ9d/F5+m0xgLJ0WFeBPzvh2HHkMfbzoECqlFH5I/pTZFSxavJ?=
 =?us-ascii?Q?Lc/mM1B+o61gg7z3isWSskUcsmsh7rm8qKKakvP3uciCW0e/DtEptc/mR8vH?=
 =?us-ascii?Q?WzHQDxcuFAefLM8McOHu99kaJovZ9EjiGNZdda8/XfT0fJYeS3Hf57mSm6rE?=
 =?us-ascii?Q?/87tYdWnHes3Ftvphd3Rykqt+4GuU0a/v7w1CRpK5NuyADZRvk/JVU4i0B3Y?=
 =?us-ascii?Q?+KMwIaXAzC6Sii+1c1MMN0qmiNmbVZCJYKDRwfRVI3aU4TqXuR+0sIZg4SNx?=
 =?us-ascii?Q?Tpg5qvgrZJ/wfFo1ypR8fh8n7umq9W6frpIIWs46GZcghOHkWS7AVHMWHMDz?=
 =?us-ascii?Q?5myTt/TxyWFfmw2DgYiHPE7Boi74V+GkBAOVjpPK2PPTPHW/V6B7bcULLPBc?=
 =?us-ascii?Q?buygJJHY+VFyuUGk6xxOn+Ex/mUFM++F7o/HuRgTp+tskAPzrBuFEZy6++uX?=
 =?us-ascii?Q?Q3V1XU+4aKgWvtbR6LRWoIWRq6y3BynMeJzyORndAnP9MQjTqqar6kzxoux3?=
 =?us-ascii?Q?T8Ln8D1wRTFxFES8GGBkpKly9mY6uxUrCr4mACaMi5KUxb1QULIGMhDGyiBJ?=
 =?us-ascii?Q?sNRlIKFHjnDUbfJ0TjH+mKjpaL0R5i7AXrxpLnUfemue7MzgUYa3VQUxl2PY?=
 =?us-ascii?Q?0Iywt6jBGXmSKFePenJW1JC55xg4PSrEuUm0aPZ46wNRjioGio+lEMgoymHs?=
 =?us-ascii?Q?WbkCL8t8eRxlAZSXNSxC/FmmDFN6AEZILtOavIOcEo2dwn6SBrpZrg2oCinK?=
 =?us-ascii?Q?jFaeWybPU+7FIK3MHlxQOI+Bt+/zjE9l4dRe0MTSPevNmmXoexhj3sVGMzA2?=
 =?us-ascii?Q?0qJcEY3Rqh/9nEIeySJ9X52fXS0XN8rRs226p1i17ltpxA0EbQyi9/iGymWM?=
 =?us-ascii?Q?tujjzWkodNUguYej7JGYuF25ABdXu1eSh/1PnM8QoNT/S8rfPAIY5yEMQcNL?=
 =?us-ascii?Q?af4ZIUkkcuWp8sWxDG1XILS0VMyTY3PLf5446VH0l8iPZ3nMC91aNy5jrtJN?=
 =?us-ascii?Q?19srtH47G3D/V1o7V33NFZy9emeZtvDZGJfQrOrKHyMWJ8At9vaWx9pTzf7r?=
 =?us-ascii?Q?Lwj+6nQM6lRb4NFbvpV3mdsiHIzbg4x4wPkheb3kiu1SvS8/hwJenlcDo0/A?=
 =?us-ascii?Q?e60/TgJH78hFUout3AnKjssZMI2jFnA53OO3EewVu7PBRTZU8TUBmhpmVIL7?=
 =?us-ascii?Q?+6Cuwi9ZwWrXtXZTz+ipYp11+kAaZCmuLpTPQ1vHaVNsWLGYdYz75ZD9zmHe?=
 =?us-ascii?Q?Vtc+m+k1aMQQgUWxNLk/n5cy4afb3WLoXppZtZeHANvfTgZmsSAJ74UrRBS4?=
 =?us-ascii?Q?xmt0TZ7sPcr/mecL8xXMl7yk7p0B1npYrFTGQMm9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1c038-f7cf-4762-b1a7-08ddb3634da0
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 21:08:44.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDGEkhc3QSvKaqcRz18fBa3aK74uEklRt2c4zXhTahcwntNhrrEjS0FW8RfsL3dQWjQVp2ABvz7muwUNsVHNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8917
X-OriginatorOrg: intel.com

Colin Ian King wrote:
> The check for c < 0 is always false because variable c is a size_t which
> is not a signed type. Fix this by making c a ssize_t.
> 
> Fixes: 90711f7bdf76 ("ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

