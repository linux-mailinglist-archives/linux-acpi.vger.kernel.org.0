Return-Path: <linux-acpi+bounces-9880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDCA9E08DF
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1016A85D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F341925BC;
	Mon,  2 Dec 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1DNrfWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172918D634;
	Mon,  2 Dec 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156788; cv=fail; b=spPVJoYVJZhb8PAvVxyJsfERp5n65MHTUnCVjkfP6TFPyoSZiK0CPzbjgYEUy1oo9iVAw33ZOuOJUX0YJvGaBkBe2AXysVJP5X0ovoYXe6inWtcjVZ37UjUELobD+j3ONPd2lIC4jmINnC+mtspnbPyhS9M/13aQGGg/MDzPnts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156788; c=relaxed/simple;
	bh=gg1Lx/mMMkf9yQQbXK4MLl40VZoHOCYrtDymE0CtRWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UMxoPOAIVP5ujwWzDo9yNFO6rHKsYxwlY4rH1O83U7AUVeIkNjtlNuY7H0ZzkXwz0e0jv6Ka8SJZE101eL5WoP9RmjyZFfGsrm9FbUtQw//6lBz3gwcjSS9JVOeJ85/Uz3dOOUrd3t+HbK2KCiYS78XOtl4N6H9ja5lwKwxVgNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1DNrfWR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733156786; x=1764692786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gg1Lx/mMMkf9yQQbXK4MLl40VZoHOCYrtDymE0CtRWs=;
  b=U1DNrfWRyGW7SrqZX0HxiZsHQXxcUhho+vefBGu+jYbmU5g8igXrx91w
   OoimurcmQBe2LAa6af4Iaz8sFv1lK/Nw/Z+lRboOJ8xGSjVS55QzEFDbq
   6GIYNbItTR/alAEbH9Iu1I3IQ3np9rxWbUWePVPxITYte+ZiJxIVHRkLn
   /MfU4AkeTuiq1lBqs1M2f0+oY/Q84L+LbH47CGWmbYS9ND2weZwmMCMl7
   Syikkw2A6HqXD8ZFqlNP6ufBHwiFalLAnXb56QyVPkdDs+f2GuktFuiyE
   MFrpxts/Zl4ZNqnFykDXiqnbbu+ynXY+kuX2i1lWl3WVPouPLNpV9bHvt
   A==;
X-CSE-ConnectionGUID: /mUOZLkrR026HkgRp9C7Mg==
X-CSE-MsgGUID: O3BNovpqRvaE/nTaopxTeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32689615"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="32689615"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 08:26:25 -0800
X-CSE-ConnectionGUID: YEL7IH/uRiKpQ0Eb08IeMw==
X-CSE-MsgGUID: 3V4WMAsHToyNxSElkv+ImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93055748"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 08:26:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 08:26:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 08:26:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 08:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKp3SA+VgXIhvZoGKD8dQKjowQCR+d44D5E+pmFoq+82FuMFfqXWFuxH6SFTtGQ1jDCjZLj5FG4SCdGnJaAggydmHZ7huHxwMzM8YTesz7+mR8h5yUvliyvWJ889tR0vxjQpgJd/gEUwvdJlsKJGK2+wJ3RYTjOR1vtNp9q5HuNMoV8O1aARqOrjohuRmrNl7RdpqJ7bZYFya3WlKCcHuX+PXjiZTw6FD3X8zBPeupKilyWO88EibWT4mWdL8oCsmTpHvE6ihj6luTZecnAfUiqoDnQ6QahioHzAoYN+e0JyrF2TvkxWvoHeZUfFDjopa3nxTx1HiUkmwNSrSbb23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCfqxlO6EG/rcm7WZvmJ/mMw4ZVFlIvwwrk5Wfserjo=;
 b=XxDYw/WYF05ij/KyEI8bYezuuc64Gsj7L7/3+OfYee7qcbgnt5+MbzAfupESK1cF0wOsjyj2KCGmht/2U891uC8+pcn/3MPF7+k9VQHc9LliKswTK2rcH/zkmL0G7zSEs3RZBFIb71mPuZlox3VzT0MgkfCIVBkw9ryzEb0cLuj9ist7iTEZ11iWhr8+JOY4rxwwFd5iyz72hi2YhYc0JNCPYlrjuHYNUtHG3iIspfv/d/2hEf6K2SFwnudl8FTx0TSyZrY6w9hnQGh7E/DT3ZIkkS2Ss87tuzo+MygiXQjd5UieFaPx7K3eOb9KVtixKC65Llj8QmK5ywK1xOLhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 16:26:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 16:26:21 +0000
Date: Mon, 2 Dec 2024 10:26:14 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>, <dan.j.williams@intel.com>
CC: <vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
Subject: Re: [PATCH v6] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <674ddfa6abc4d_3cb8e0294cf@iweiny-mobl.notmuch>
References: <20241118162609.29063-1-surajsonawane0215@gmail.com>
 <1813d5d3-6413-4a44-b3dd-a1be4762f839@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1813d5d3-6413-4a44-b3dd-a1be4762f839@gmail.com>
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e9dc63-7bb2-4d9b-c212-08dd12ee0e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CGkvV+RBHhs0FqevhHfQF0q1d7cHQC6eCEuVL8ZjC2OdegdF8AkKka27/jDu?=
 =?us-ascii?Q?CitCCDqLpv/3nsDRuCTlwfhIsL2fK/4O1EJ3WBfQjIRPGRX945ojfsRcenEB?=
 =?us-ascii?Q?rk5fQ82S4Xe2JaPrjxKBvDw1ta3izZd/OkISrg7bUFjfcuE/e0DXeUrIAdGK?=
 =?us-ascii?Q?E2YCX+OVj26lKllHKlOZoWv7E4IvcRVAH66MIpik+E0dcoUXKiOuIhy4Ti/J?=
 =?us-ascii?Q?cZfPu2NAhO0uzfdCALCa8a6XCU7hik2Z5rGZQISQc2uEWfLYx7DoTRzY1Qoy?=
 =?us-ascii?Q?iPPcsVy1YQ9+GrH4zKJD8/XyS3woJdHFPYmAPFLba2Pl0stUBcsi56OBs66V?=
 =?us-ascii?Q?mKQfjaZOCIjS49kXy0UL8LhJIdoAJxHoOpMDiTcTQfaLj4rfKGIoNSAcyUo4?=
 =?us-ascii?Q?PD0ixdC1QbTpmhbLNKfw+9hxRH6NmNlvNroePZcpxnQs8XMy+RltM1DlsF0y?=
 =?us-ascii?Q?Qj2gcNx0IpJ9c6wVUU9crJ6JEkweuHOeZUpnSAWMeygPnl0XOw/SfZnJfvuv?=
 =?us-ascii?Q?MQpx0R4zJxmB2mQrR8+h6ecLcjCMTUsm2Aj0HPV49ERe4niTpOx5oaVwRbLk?=
 =?us-ascii?Q?2xMGflEjESi5PM7+9MKt2HmFdkCRMO0nxYN2rQp/Lykb0hSIvkXrin08APdE?=
 =?us-ascii?Q?v7Ygp1KGmk009nfgQAtH5e9xMCkAbyrITRGZR3iEtRQqAchr8TuLuh7MATfv?=
 =?us-ascii?Q?lNEP8exv9BxWI6nPEm3wevQGoRfnVcIr/irNjXIUuubA2kBIFU0ZH5Izgs6S?=
 =?us-ascii?Q?HUfa+IGTHiHBCq6NQdwg3PlvMIVa5H++yiMwlyuVSV4ZurSge4CT6AShna6X?=
 =?us-ascii?Q?98ABOLzWZ/qR1V7DyxAOWSRtuyM2T86wuNFJyAKjIrnrgniu2MJxGAGBhHru?=
 =?us-ascii?Q?qqrvC2rjMEXkbyI+9iPw39ARGInlq6bxY3sU78ueO/t5WpIdB9/tprZF1P4c?=
 =?us-ascii?Q?ObXbza2MDtgrzt9RnAMgFeQt65EPck3AF3ydsH25B0rbma5zZNxeuxbCOHKW?=
 =?us-ascii?Q?xNj6o9kEF8DN1rqQnYy5bume8f7TT2ta4UHMugxfPC59OdumhjoHFltl3BpD?=
 =?us-ascii?Q?+zefq3XRlrxjUHhTW+yWa7JJMplNAQ6M/rvUd2cEecROh9IpO6zyRC02R3Xg?=
 =?us-ascii?Q?xAq9X+1Q5hPIggO841PblGPBdymBSpdf6vNOUJFuS0I8iPx/X3kJHVNKH9Eo?=
 =?us-ascii?Q?m11UzHCBnkaTjXRHWLV0wmJ1uRSzcQHtaA6OBxQd4P1lnx/LJIYnSB5gs3kT?=
 =?us-ascii?Q?x1sK2sIE4lOZHk8gEtMoKuUCGiMmep6Di0fbbxCmc6pLK9RyhRbcSpPYZvfW?=
 =?us-ascii?Q?uCOwQd7A22z9idDl7xZgPEVS74VOyBDh+faGoiglUPpyYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRDEiGiMVmNE6Z1tlJENp62CKkTft8CyuBzcddSN0m3PLz/nJVpIt8BhlvwQ?=
 =?us-ascii?Q?xjIyNZAZgi5j1W9wnkldNe4fFo4aSYEwYogU6h5i6jS85eqVYuOeGKM3Zq2F?=
 =?us-ascii?Q?sJ0oigZZGWh/v7qRtVfcf7pYfmQcMX8VLOCLhsH1e6+GxzIpXfsLBmEii6mY?=
 =?us-ascii?Q?24HVvGKHcIBHpyp9lMbRAP1/4ZMJ6c2/cugRYIh8GIKeYzefJ3u5K/lUHDGy?=
 =?us-ascii?Q?tTVOacyMlM4OaGed/ePr6xapVeziTY7jbU7B/EAjasA9Jpka7VaVG5UZ+oLA?=
 =?us-ascii?Q?ye1sPWj7b1I+kH8LpuyVgBCyx8HZ2JcbeLGSkjLxRj4YaHS8fW/cDVN4TRU6?=
 =?us-ascii?Q?lxdp1KKJeA10DY/x0ZDts6vaYUftHWP8kwPyfD1gPpvlH0ji84lC6HFrKwT0?=
 =?us-ascii?Q?8YUhm0FOV3uKoHfJ425ppaMSM0acnpM4KsDqZp06nXQOuvXmtDnKgmrhN+kS?=
 =?us-ascii?Q?+TsF4GVFxfPHIarPLdOPRhwwD1f8JZS3BXD21o8+Li0eRMGjwvmDJHmuOve8?=
 =?us-ascii?Q?YhskPHslQmUleXaZVOz8NtjK21OOhOZYh+8aICUe8snJdSp6o/jf/CRvS1I3?=
 =?us-ascii?Q?cLLnocmh8GFIFYnRkrZ+KaoTWU5zeJAOYSknRArzU4QEH/pBqUtiPVnEUl4a?=
 =?us-ascii?Q?2b4vD73ozL6LNaMRr/CMAkF7OSD6F3yClJjC6i7x4n8cje6x/Ek5rwflNvJ5?=
 =?us-ascii?Q?Ws+OSVZxKK1icobFd/iE480BJVWVD10Yus1E8U9Cj6LBnwT1ErBaLXoKgJi5?=
 =?us-ascii?Q?dyHSY8uiWen1w0QugpC8ykFiYvOrbxFo88YHx5WhzU6DZF9Gt/3DY+s3TB1+?=
 =?us-ascii?Q?1GWlbkon2eKMZM8Kl2UdX3HVZQQIPvd5TOpUFjgjguHk9c0Z7sXVo6ZIXcHV?=
 =?us-ascii?Q?XpzTIrOrV4WwJ5PYScmTa9CNdsX5HDoPWzjqnDUl7cRYTkdYFyv122yf8ady?=
 =?us-ascii?Q?RMqV1ckkckRpjY8BXX1pEesDiO+UVRjh2XdPUTJNLGFfLBoIkeF43GCm4a6a?=
 =?us-ascii?Q?Dlid4HIJQiZA/fLHW50WDHge/9O7mmqftfq18XN/WZ+n8PKglQJjNWWpDzav?=
 =?us-ascii?Q?9soa/3evkgbPAUnYuMJzYdPWLmGop2WgHizXBZAaZH1am65eZW1idCYm5yaW?=
 =?us-ascii?Q?+hkmOa7w0QCI6xR8nhUyJfitX/Yu1FxAJCuULW1aj53zrS3DS4aHNnoq0A+x?=
 =?us-ascii?Q?aPVn6jodPfIgLzy0UgIzf3GYU4WmZ65Y3oVno1hJeQz92dj3yFZdEfHsThUH?=
 =?us-ascii?Q?R+nyuwvAmCoALQHdNL6D2M2aUxBvu1jQ4DViNElNGr/K1hJrwztDmx7scxP1?=
 =?us-ascii?Q?bzXfeXiW0LlHWlmhYJfqSRQDXutg91DFjIq8XgTMo3NqPV7x028c16+cWmo7?=
 =?us-ascii?Q?7bdhXn4+V+7k8wxn3yNPUkYoS3HvsI/1kiI55ZpM5QRfXiwj/H4GxTTOVmpo?=
 =?us-ascii?Q?WTjgyMObEI+7cfBn2vbsfTBLmNpiGN2gu4iQhI9avprbaFPmKM5mEo9XU25h?=
 =?us-ascii?Q?Wl81wllxp4tAKvL6SyHHGJ+4huZBDgFIOjHSFvtQxU9P9DXBdhD54OMKfwbL?=
 =?us-ascii?Q?/S9g1+regadQFBJOpZnffTZW80LmHkCZrje8wO6C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e9dc63-7bb2-4d9b-c212-08dd12ee0e48
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:26:21.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjiN9DOZrubGcv8BFdohE0Q9cDuS2nEPebs7CdXTcGKXjqU1UzgYsbyWPAySVw4wibh7Z2Kd+YlQGYt++9gYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com

Suraj Sonawane wrote:
> On 11/18/24 21:56, Suraj Sonawane wrote:

[snip]

> > 
> >   drivers/acpi/nfit/core.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 5429ec9ef..a5d47819b 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
> >   	if (cmd_rc)
> >   		*cmd_rc = -EINVAL;
> >   
> > -	if (cmd == ND_CMD_CALL)
> > +	if (cmd == ND_CMD_CALL) {
> > +		if (!buf || buf_len < sizeof(*call_pkg))
> > +			return -EINVAL;
> > +
> >   		call_pkg = buf;
> > +	}
> > +
> >   	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
> >   	if (func < 0)
> >   		return func;
> 
> Hello!
> 
> I wanted to follow up on the patch I submitted. I have incorporated all 
> the suggested changes up to v6. I was wondering if you had a chance to 
> review it and if there are any comments or feedback.

It just missed the soak period for the merge.  But I'll be looking at it
for an rc pull request.

Thanks for sticking with it,
Ira

[snip]

