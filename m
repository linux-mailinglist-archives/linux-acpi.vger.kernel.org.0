Return-Path: <linux-acpi+bounces-4308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046287A2D0
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 07:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43857B21A37
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF212E73;
	Wed, 13 Mar 2024 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKEepV5x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD812E4E;
	Wed, 13 Mar 2024 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309667; cv=fail; b=CreuA1Kfv6GiYMF8j75O1oF1uIHbNNgczZhQQBOZkPJSYSRg3gEDU+8Fhbr6JRVQErnZ+6g5RdgP1vrKP+0RR8edslE7PCsShnwucLAog5aFyXm7I54kiHbz0F9+Sa1TmW8LJXUkYGb41osw4CYUgO029/j4k9yqUqbISOGTIHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309667; c=relaxed/simple;
	bh=uql42LWRo6ZDFC7P3KpeptL4B1e0uPcslUM5WjqRf2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kzqy62MNDZSJvHlr/ZbLZjjlBf0RTeC8dKC30J9WjLZ6B2PWd8//CyFUkAaj+QKx+ZYMZn/+yXv0s2zS86Ork654At+1vfKC+868aBWmWJGWglsPfgq1xqfeekVg4Lacst9NVJ2khyzN+BY0VkVqclCqC8sz8BuFu6Hq/t8K8aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKEepV5x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710309666; x=1741845666;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uql42LWRo6ZDFC7P3KpeptL4B1e0uPcslUM5WjqRf2U=;
  b=RKEepV5xTF042g91Wk7aLDTL5LgGzTaSKH3XuWn77HH8Fr0XHk6vKbXd
   J93eOPzymDMAxM2bsJE//MdhYEDLILi+mlROr7GgpJ1jFkkL4dM1GMHmJ
   VPI9ZiwJlDTxKnnDJVPXCWShsjmJPEf0SrLVWsmS/UaC8AGHUOD/KphB7
   lPLzATAhBTkznfpQOe7l2PyLBAYsOKMXSe/EBomyr2egnZQmKdS1B/TdU
   2ETPjCqA0S1ggFVk8xtb3JJg33snBxrr/7CAK7of+24OOAL2yIqqNsvHy
   D2xck+qTKx/Yho3bwS6Eo1ke8kg35tOx+Abr3cUF6udh0kITMBwnkPUS1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5224454"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5224454"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 23:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16279371"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 23:01:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 23:01:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 23:01:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 23:01:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 23:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpvm6kVCfESX8X129cp5cC2Zbjnybia7uQ9lfJSOI4iH6xxDPUWwCZN0AGF3AJqKHOjZbk+3wTyT2YAOyvDm4P3+Ab/eQq2SDq01Q7BdHxWZ0bIWZy6ktyuK+2c6dnr9JZBNrzhgjcL07xtzvhgm7oakxTH/wli0Z7C5NIAjq8kiv6BzVMS0hBET1IIZXaQkf2agl9LJAPWkAwjH3W3hPXDoFWhieVsBJL/vCmPFaz9bi75N0+JE3Mjn5o+mlm4CRCWJS2knbK/tU1EjNwMC3vvj7qrsACNxhcxX+FMxyeG/Dy9JfWKGj6fqrjsI0by9IYy7pHeM7Oqjwp1iF2r8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgraV8nMqDk5W6fOraG3/BOBv5egK0iAlP15xgAXYAA=;
 b=mqtxC0zAeAbQV8JFvfyaz1rCOfBMtQLnJlLIBVtzkprRionJB0F+/GAmDahyRyVzbCwCuy/hdC4c7WKehbtzu3xUydvBr+mSwHLZS4UCHOn4WDZWi4rVLBjCnh7qO0UOK4DM9uJ809Suo+uIGP+mkZojD0Bl+/IaOkL3I7Rbf+5d1VIKbPUwjsoXVfTPrDeFOlqOy3ENbnMc3KIsOwTY40LQ9bhuG56mY2QMGd+x5sLq6Bd1tZ4egG8ZDFNK+f7vsQopcBlEB1mGkmorOVFMWkqCZp+nr68SMcFsn4igPCg6D9REPdMQwaNfA190o9qHmzrwFu+v/L5D8NmkVZM8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 06:01:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 06:01:01 +0000
Date: Tue, 12 Mar 2024 23:00:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v15 3/4] cxl/core: Add CXL EINJ debugfs files
Message-ID: <65f1411a184fe_a9b42948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311142508.31717-4-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: ee37fda7-6d07-401e-baab-08dc4322f59c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Efo0dn/urmxX3Ukes8/+Q2KhRoeTDpURlQKJ3mirIPSEx147PiCAVSHIE9NT8lFcDYhFkLLCvYnVyGBEVGyng/mo2aTdDY2Aq8vGgqQ9J5zKFMgkGKIVHp8G/njCBcYMu+XyI0r5DX5bEYtLR8ErqCh5/EtQhccdtaMcDh2eRo1bduHeIsrnKw1YiLc1w2y7b4pVwq4ghs4AoVzdfNBf3jhLtaXKppGZZVS8w3BkWgS3At/ZEdfISELco1lREh6FqCidKOpnjM+OtZbwfm/vHNzCUErfluKCORZreEV7fRMujx9ByNt1pGUseVGHSAXKFfx3VxHgCKDBnphBoLemd4DR9i0Jw0yyzcaNFMgkxz34JrIMBtEMVNIYipmRXxs0IYXyXYkY2WBcVoh2blvfD/Lu4sCHcCzUW4uMFZja6Rcotbi/YgUTGt8H4l3t4ytG0aAALpPvQ6xKMx7MDHarZpJIJMSgvkWuyNV1ipnnS9T5jT435rfymJ1qcW3n/6yV4+OzXzrlrlOgxsYtrJuMrVoG/VsEFMN4CDiM3m92pdqUlAfHBt3if2sNMKNtNT6WtLsQDmilDyleq/svcEZYYFrdUdUYzYcimUIV6DEdzsHpf5hXU7ZIhbcgQuLovHRDOS5TpOYo0WV4CugROvHCLhBJRAbCbBk6LmjaKth/Vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xG8UFqY3kjtlzLL/yK+NOLqaPCdRgHcSYMD2m7DOoBy6F4KOjJRdIYNrs0yc?=
 =?us-ascii?Q?y/rJonit1EL6OsRiydQsSORewf5bLYwdfNfma/34h7xvkdCMn8B+4gydpQOH?=
 =?us-ascii?Q?jr0wIuiVyn1l0GEjLLzHDXpUq0PUC9Knc5LC1eAXiLDVx7pjZ4ZT2xfogjMn?=
 =?us-ascii?Q?uEybgV2MIQspgaKK9KEwEegVeloLI+l1w/Nh1FaHbnB++bfTpEa26jl2UVqy?=
 =?us-ascii?Q?VAaRfbK7gPmWvSecMs33OdhyRDqbFxGlzjcw1DMdPzv9VILsoIBzo3EIh6q+?=
 =?us-ascii?Q?PsscpAogg7BJtL+k3mblaWZO+v3GGIKUOrRVu0dO1Cg1s3d7ombZnMiM9REE?=
 =?us-ascii?Q?XUeT80NL2pGSlTyQC8JdkE1haIXAmLP0qSRzeoSoqNSZ+C7Cw6C5E/gcUSGf?=
 =?us-ascii?Q?n/dWr10rwOFzlwl0ays5oPZSsr09ZZvOd4cng0i95KPCNfaPvAXO73KtlHC8?=
 =?us-ascii?Q?9W35IIotRf0+RkUoi8hQR8AvZ9tXej2pqj1dOT/le7d6grHLoPhvdKaLud+n?=
 =?us-ascii?Q?ZRGViznyVXWoii0DGyE1Byl49fu1Qch4+G5OfPjBzxihLrfgvAvLw+420OsX?=
 =?us-ascii?Q?9pgF6cKchGrC3WokTPqrL4TGIO9j1Zg9z1iPuyjg9Op4pFK0yKpDXjovqFm4?=
 =?us-ascii?Q?XRxdLsEQ4/uEvFimOXbB6S+SqbMbOgzxvU3Cl2bwn5Z86CGT5zMQvQTn6H/o?=
 =?us-ascii?Q?to3JoC62fxTxH3m/T4MmrnrFiVqYZrrsSEnrab2GndpB6PO3EOsXtxMWZA45?=
 =?us-ascii?Q?MI3c3RDA4VOksk+Q2avUv6DwF/vEiDC8J6DNTZ4rpyYhlvlzU5NoaRpgBNWU?=
 =?us-ascii?Q?jdgVjwzOmfKxCi44Q5RyWUMu0jrG9FQw0WFgdgT26fu0l+X3l5yqqNYJSMVP?=
 =?us-ascii?Q?0iGfBb1ZIMpFwa/gPPGhNxEySB6bKM7FWwoK1N1ezm3peLN9tGBgaxv7Z+bl?=
 =?us-ascii?Q?bt1FLSstZsTLjsuTEqyAMAJ004EzFD54yNq3q4aaclxSqWxEGnEFAACItvSf?=
 =?us-ascii?Q?8gK+aRcF89l+cz95HyAtmCQTArstBBp9JiJJZHHP4eETxK/ba2KfwlBGFDg+?=
 =?us-ascii?Q?QRv5bUSI52XyUR6lFBB5Qv/x0LPsc8YXD8TRKJ9wtT/sPT5PphoO8ovi0AVh?=
 =?us-ascii?Q?PF2+InXlBWgRFBTKeyvSoVTMdA+XVY14K9EoL1cLl1Lv/e/ITKyz/9+kXBNE?=
 =?us-ascii?Q?/+2yad50FcYOdDThXOI+udEZ2VzEgOlBOu3xQzzkKDy3UH7bqxTt8i0q+z/+?=
 =?us-ascii?Q?mnnGFQggEEIWJ8Q7gVwOl0LNo2WxhWW4yuu+yq5QfyLSbsgI0nVqbLCJZ97R?=
 =?us-ascii?Q?AUmXTWJw4HzqjVSd/LoVUrK3esjdt82Ueu6HwQ+t9LXqTiMHeiqzKmwE688x?=
 =?us-ascii?Q?J6HlJXTRVoPsKw7maAOqLXQrf0gY8wUGygoS0OJnXbw7goZf9KmqTTmwTkU8?=
 =?us-ascii?Q?IhKSJqw46MalK2sCGK98YSgmfGPA94tBWkMFAtpF8/GQsSMugYHmqeF1qzQQ?=
 =?us-ascii?Q?On+ae4pAlfGNjTItMIwoXYbZuXL0mh2jja8e8PYmXqVqSj02h3u7pwLo0njC?=
 =?us-ascii?Q?30YdlX1x+UIISwGub1hDt3GRpjRKjCJQ1bQdjKb2vnavD5Y/RPimnVgux/p/?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee37fda7-6d07-401e-baab-08dc4322f59c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 06:01:00.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQeosIuTNy0H+i2A7pO3dOZ5KcTAcxVO4e9Z8ySKsnMwMX++DFUUMBl7UPylkB0GTFUg1upLWyruO4Bk/9SvkZ37ZbvwWvVMMqrB8U7C3fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Export CXL helper functions in einj-cxl.c for getting/injecting
> available CXL protocol error types to sysfs under kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the einj module. The
> kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
> as the error_type and error_inject files provided by the EINJ module,
> i.e.: writing an error type into $dport_dev/einj_inject will inject
> said error type into the CXL dport represented by $dport_dev.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
[..]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..eeeb6e53fdc4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
[..]
> @@ -2221,6 +2258,11 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> +	if (einj_cxl_is_initialized()) {
> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> +				    &einj_cxl_available_error_type_fops);
> +	}

Checkpatch was ok with this, but went ahead and cleaned up these
unnecessary braces as well.

