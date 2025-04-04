Return-Path: <linux-acpi+bounces-12755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C6A7BF16
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4343B059A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8321F3B8C;
	Fri,  4 Apr 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpnsPlE3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DD1A238C;
	Fri,  4 Apr 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776643; cv=fail; b=cNVgzkhzUE6J//e4v2qTkGPx0QhnCUStlSaOvUr65MczrXjEUMYvSlKvu7uCD4qps+iqC7Q9eSoBsAkqFZe85UzX2zPq3RUNkK30tR5RHd9Tm7Xm4DkLat8HSYRej7F7KuW9/bfmoavcJZ1xalg1COtsFjK1Mi0d+IDzubiKvsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776643; c=relaxed/simple;
	bh=IchGoTpLrUZU+mHsfQSbjLTXT9wI62aAuausB1LS1U4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rvLhmR+w5/CV5gCrZD7VQKSLDipkNAfxNdLnzuObwBDQpl0x72T7txjmlX+N0C84TpQnhsEICWm80iptqOrjIAPgE5TA21K8ioJS0TDgCUjnWE3V15prsi08n0j5WWB5SIndaJkpBZbkgr8Na+CUNBpxgI72paDAYT6EhtGWw5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpnsPlE3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743776641; x=1775312641;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=IchGoTpLrUZU+mHsfQSbjLTXT9wI62aAuausB1LS1U4=;
  b=mpnsPlE37Bi6ug2YMZuM+ZzeaHMqmi3+iGrzfk30XwJc26bfAYodn1FK
   XbvJtdM+IR9TUceuBQyQfsu0KJsGUtuXJR99uAW1vf191ef6MzdBQrSM/
   9HO8pgcc1Aq5/DaQgz8O9fsDpINh0riB335/zDRA/psdJgRB3nyeLmHRX
   zkFfxwFGD8yBmqzLf1/ptQMHwJqiqcULNpTL+x/jMkhe4tVRte6313C3p
   H13ltNOItLoQ8SbtnuBpAWlutzIIxV67nS3DcRayrTwxq3ZBoPGtq97m4
   ImoPuwzt0sMdyKmuwCo3oU/Y3UgM+3yeNSZ+e6kBgN8hIvaVDo0oaJIoU
   w==;
X-CSE-ConnectionGUID: G4qaZs2gT1WXYmRY33j+ug==
X-CSE-MsgGUID: i0YcE4NqQDubbvGf4ERNAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="47930374"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="47930374"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:24:00 -0700
X-CSE-ConnectionGUID: 5idimrC7TPidfK+D2OMhCA==
X-CSE-MsgGUID: aIQnOBPVRgamHv16cDP/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127140280"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:24:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 07:23:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 07:23:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 07:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnc+zmIIg3kPMsuJGPdPH+C3KLGyr06XFUEOoT/C+oTxN8QV0i73ShBPm6u3pP7sRXUBEleSGhPlvz3FpSgxQX8cI/obgJrE2PCHkKiuscq6Y85lBv+PNNHD+/Thlj5JULc8Doe0WqS+02ljxnKMbkhVr+9bC8z3Hd0D1tPnBUqgib0yttK0wlmx0++ZybTMikW1pPpCYGKIYJDyP1FaRLj3uWqqeD1S7cVhM5xXaxbNjbGk8N0zgCAMjMSoDDQ144ox32yw7aEd63t7kNj93XrNUiS/Kc9DZiWv7g8AUTSK+pva3XBQzGGDlDXGzQ4+HSnsiWgWjg6TRrgawE5CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9n5z+N1Ghusl8wjZXS9Cpa1Bbmvgb3wsls81zv/NB0=;
 b=lk9qhVGjZMeIzW273qj47o8crI+AaPAWbtl33fh/1loXWPN8UGcavyzS2YyKzMqPnmNHCQa9QnkxHj7fydTxWlCdsLDgqjlKdxB2qtnnWM+xgsDRw5qqRBbP++43qdCjCAd8ZYwg7fLrlU17uvt66vtH17EpZ//6LQVyL/KAOPSumvTErTyV8ooOrRKc/JNh9GgHqgqD+Ec721AA7vm5X46MreovgzCWXqwb/C5CZ31QQ7Qvz9ATR6vLlLo7gUvIlYvnYhGzfd308iSTP1TEbIr49YxUuenAxxZiND3wuEJ3zmgE4DAmnOMWWFg/hDhwzUWMKhCaNqPdpwLn1bLTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 14:23:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 14:23:55 +0000
Date: Fri, 4 Apr 2025 09:24:15 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <robert.moore@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <67efeb8f99528_974f1294cd@iweiny-mobl.notmuch>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-6-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403231339.23708-6-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3862dd-fc7d-4595-beb2-08dd738454fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|10070799003|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJVzshCKDZGqVnOJGTLLeCxTloaAtIchZKrNonW4Y9hB6quEW8nl5McwHiKw?=
 =?us-ascii?Q?uEFj3d2MBaUqU+jCkcCwIW/HbZQyDxkTU2UWVTzO8w/6ND/Clqe5x6yfxJej?=
 =?us-ascii?Q?/PUWW70/n3HAT5gW6zllP4s8J7OGJU5B5/kqpMgEDfDkhUWZy071A1I+lqAY?=
 =?us-ascii?Q?B8rO1CohAWadTazge0t7rYhOG0tbSPqrOlR9TfLzWXMALE11DTMjXNjWvAdP?=
 =?us-ascii?Q?im2H2o9U7JtOYtwCdZbME+sjwdow6b/wlJt3NSyy+6EVBwp6ibV98lx2w8A1?=
 =?us-ascii?Q?xUb7n2WdlxJjJ1CIqaqDiGT20fFofTxsqQSFTkD23SG8J1irjisDEACAZWiY?=
 =?us-ascii?Q?3DbX3DqPfwYg//HpA6CWu/44XOX2VqwYzVhmPm2lrVOEDuDGVFjCPfcLRN8K?=
 =?us-ascii?Q?Nq2hSvEF88gGq39YTi1tJmWlOY848GN6AlnNZCNMIvPm2kJXDdi+1eHLq4Eg?=
 =?us-ascii?Q?ugI92om9LtbES1koo34H/iaAeL+jp84UGhF6Mib+4GSyy+nsQTQ/dIMpnq2/?=
 =?us-ascii?Q?YZD7c96FCes632k+wM6EPxHnP9GRScGXrV1kBxKOv97dKudRIFUQE2ULn5Hx?=
 =?us-ascii?Q?Qh2ZqY8HDB40oWuFlNw5VHd2yY+OXRBi6Ls0desPo1Z45kcKc2ws2quQy0ot?=
 =?us-ascii?Q?TDb0UJbVpAzsYWQWRVZ0TqkGIpAnz/FD/imRd/NXqlaxSYuLh0OFkjDT2eYP?=
 =?us-ascii?Q?PhS4F+W5H9bnvObuZ8DCpS1+BAzqa9Vqbb9cwWRNJAE2uF64NDBwP0TQV2+j?=
 =?us-ascii?Q?zhkvrQpTfdrxVmwgDq+HwyLNWsNzVBREvBwgRKlay3LHTrySNQXu0MTHDk7q?=
 =?us-ascii?Q?XlbzV4o6Mj0RaJjE5hsUK4jlNM3rsvroNNzYhr+77abnzcZNavZdogsJMEAQ?=
 =?us-ascii?Q?H69pJDzdpjU7NrLbK/fEtFQYj6n+JtVfCBoya2a8pgsjDvXO4znhMYuLnmSB?=
 =?us-ascii?Q?26KggdlebzQuT0yBi/Kz8NLFjINwVKzs7Tw1FpJ7ibwUn17z+Xj7gxOlBuEx?=
 =?us-ascii?Q?ChoJbKMhJ4FXkxfY35XLePhn7Q7LeVj/5YUAb5pw29FcHtcXwcMX3DQjNw3l?=
 =?us-ascii?Q?ugYeVenuk8PKagcCc/QZiQ2J+4n1TgERyX9DZN4BwWcF7VqIoiOwXl7vRcsn?=
 =?us-ascii?Q?yMNGt67aX94R/KqtA//zLdF8j1K6Z55eCtI8p78VQcKvyF/phSaJJpaBnJtX?=
 =?us-ascii?Q?OO5SbVistskCWKlU62x1Nlh7WybP1gV9YHDItMJO4hrgEZ8l4TCQOkt1g+ru?=
 =?us-ascii?Q?6qmP8SzH45aIQ1V1lN2Twam6uiMP/mjua1TQ+x1fsaxdGw9tFJekQFxOB5gV?=
 =?us-ascii?Q?KKobkq4SoIPf01MMdXeWkR/QgelZ7n3Zjw0k8YDZA4fw7/qNzMM8qISEUfS9?=
 =?us-ascii?Q?8WalRpVlkDOlWYd8WZtcX6KFFdPHMegKIdedHNFie/F0hcjGyIzGfjoaTPop?=
 =?us-ascii?Q?XzgLveBooac=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9SE0qddimlzrJQVrEcg4nzpcP1qliIgS8/K9X4PP76Mc5xe08JR0QwL031Y?=
 =?us-ascii?Q?lZJl+xCjqe6TRqs/JuxVjKCxHPDmqN+cMhAb6X2Ur81Y8Ge7+A+9Ge2IgDW+?=
 =?us-ascii?Q?J0HSzSU+BHo2B/tT6MAvcOfsmptQu23CkldH2TtUE8KXVnjnUKtZ6LDkX+yF?=
 =?us-ascii?Q?bDDFRQ6b+TEpvX6J205eBF5+v+74aM9FLsp21OMUGttSawU0JpDN7kxC8NQm?=
 =?us-ascii?Q?cWh8CjRTHzdovuFSgHcGECExPXP32puG8koT4RL4K8zRTTMtqZz1orVl+3is?=
 =?us-ascii?Q?IG+IDgUeLDW8A6/plDK3JQdzdt7vPJFqeSVXX72eF8Jwld/lVmgjK9EwUzLG?=
 =?us-ascii?Q?/BnzlUT/m/MPCIX1ZvE1HrpuyBg/qfKw6b06GST+DsOn0zwplCjHl1Ok354j?=
 =?us-ascii?Q?XJ1etd+h/y1Enk8ANasSq8JfF0lVGZlLFiVCjUZ75bSqDIebgxr6y3O875bt?=
 =?us-ascii?Q?7nPLpP+nW9ChdAZpSumpQTyPC0zw8ubzCxvHVBd1dEa/k6Hp+Yn0yxuOxCCZ?=
 =?us-ascii?Q?fpj4xuHjwVH0QEIvSdfnWqRL1hKhXNigMeLuhqWjUG09rMs9ntK8TWIvx1lA?=
 =?us-ascii?Q?JBl+qszHdrSBliM06WasJoHuwnrM599QkvW/0ekptg0UB/8OpE2ZxL0PP7jP?=
 =?us-ascii?Q?0K1LpU1sEkfSg0LrIqiiNMVj2IsqvLKfDfvRXNLk87AVJ+/zlCTilimHNBdm?=
 =?us-ascii?Q?NlchlxNxU5wdZBziPQHEWrXTEojld8GiCGce7NSWnwhvLtKBDzyXDkVH0icu?=
 =?us-ascii?Q?H3Hd7jUIYUNFnQnQ+LeHRZGiQXdG4VEpNKAXkt0XUDCLiPn0PyNOy5e429zQ?=
 =?us-ascii?Q?0FppCnzd4HE88YWXhVDN+WrFBeGhgdNRHAhkzqtuFd/7DRO4ZcusaECwDQFR?=
 =?us-ascii?Q?tr9JwEVI0xRRcNIR+6Mxg4ceF+Azcg1vTPyReW+6jSQ6XvKuP/E4w/Wkq7f1?=
 =?us-ascii?Q?gsQ3vGfjngC0pnQEa6opfIJSoDa1qC7h47R2bo7Jjroz+eOgV72XIjqULwzl?=
 =?us-ascii?Q?z3Y8FPU/Mqk2bApryUdDm13aRy5lDFBETUwGBTlewsbSLgsu115lcnMwgqvk?=
 =?us-ascii?Q?v+3dd/a7UueYUiUUrcq0uYlgrBNnwz3m8w+cA+XAVylX/PPy7HvAYWDzcs9z?=
 =?us-ascii?Q?lgb19MLOaOvv/LKxYTZK658C3HHWSv3mRbBuC9eFybg6tKA5iT1pQiX3dk3M?=
 =?us-ascii?Q?7LPUbu47ezB3wCmDXqXVx0kHDodR/JtgtDuxE2ZXPGFcOoPNG/RGWss74Q2B?=
 =?us-ascii?Q?4FqLzCWkM4UKOouQXAnUsZ3C2oBRjog/Actzpyx/VCMYTR6OvSPaIJW8KIYY?=
 =?us-ascii?Q?d8oHgwv0JPtu2zxbdIos430yZaBmencMqPIeJS5q2oEWeG7O+OowoKS7JFoD?=
 =?us-ascii?Q?GfBGaTvUOLOHeh9MH7r8Z+k5583TLSetbrE5q5FbuKhGaraLC18UF9zqiXzY?=
 =?us-ascii?Q?RrvzdBqgx2Srm7A8Md0CQhAZB7ravMgSWF0QsrA8Y2PoQyHLetNhbEX4djc3?=
 =?us-ascii?Q?UoHKKnfdry0kojH1jtiYBd3kRoYtKW2vKKyetOwJfML0BpY9LWhf0kPtjCn0?=
 =?us-ascii?Q?mO7yhUrRmxXyaQTQ9eM4Atil0R69AVHc9/nocW2+XYoR/ksPqDhwu+47sdw3?=
 =?us-ascii?Q?xCR+t/WbW6f8VN3hB0WC+YSSFbZYKkC/YqQsUbeP0YLS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3862dd-fc7d-4595-beb2-08dd738454fd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:23:55.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esh/97GA9Lxxbv1xLDg2cKfTw6R33qgOeeY8SRRmEF1H85wDqYrPJsVYvuYQyYa8O1gGGgFZtCllfHQ7LgJWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

[snip]

> @@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type, int einj_action)

Why require two separate calls to get each error mask?

IOW Why not:

int einj_get_available_error_type(u32 *type, u32 *type2)

And have the query determine if type2 is supported?

Ira

[snip]

