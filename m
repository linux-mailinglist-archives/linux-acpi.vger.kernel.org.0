Return-Path: <linux-acpi+bounces-3789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DBB85E4E5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 18:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF88C2854C5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443784038;
	Wed, 21 Feb 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtZz9kYd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0487BB00;
	Wed, 21 Feb 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537729; cv=fail; b=N1blzb5rKSuS/hsHZ4RoVe8pO0RU749Bj72eZ2g2DtV/Ifst3pA7GN1aDLPq4lTF+VAbxEI8qd3ZHwMrkGTXvyIRrLAJHR/6dJvD9rs0JXQJd3PXVWmOXjGObmWSRQufwFe4aF4ZJrtgjl53xl11mGps4/Zr4WrwRX1dZ1HnRyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537729; c=relaxed/simple;
	bh=RKAuc2HJwUdDDIStcANHGJ+CzmevSAAfkwzijlL8Mrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYaKO07eyNcuXXdFLFoJqoGeKMPJ6jcyr/57a9iTFyGA64D7ay+rmbSEtJQ0ccAPdgVA4+QHG8O+nOnZKjFhqaYuslLRSTxJ0y4iVEC2KBYmoJc8prVbNPIO5owT+mrvurBug9Yh/JfSPVlebf94LmsATpBEOESRbJNS7neonHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtZz9kYd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708537727; x=1740073727;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RKAuc2HJwUdDDIStcANHGJ+CzmevSAAfkwzijlL8Mrg=;
  b=CtZz9kYdHAuU5aH37olorlfU3RP2/r0xUKGiERA7A5KhB4/S2SU9iV2l
   CYmNsBdUVRmuCLz1/90ykbq30TxxpWXkjXBLXT3+UWoviTFYgIbWJBSQA
   Zm+cNYKstHTM++pyFeTMaLS9sV3/U/GXKUyTR/ilYEArUg88XQbWmgGCN
   +2173jwtspU66wrDejp+LYP6W4aqh8PrqcuxO4HrzElpPiq0wYoljP7BL
   xuZy1l/lSvITW1hxaO/wjByAU5dKlZ9jlLGMQS5nR/JMC/S77Mync2I2U
   WaqAuEKiYTYtH9lbZhlFbFTRruNN2qtyXciOE1pMSU6ECcbqHDUqeFgyE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14137898"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="14137898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9770744"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 09:48:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 09:48:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 09:48:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 09:48:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVoqNvad/AVKwmieXPsLtZ9sUd5Ay7Wbn3DFwp7addUOxsNOVUb75SjmyFDbla5cT6IIteoojw6OZkjrW0IGjljWplNF/kF4MFdSo6YNANAzFRmmiipJY6dPiq+e6+Vn66uVI5IzH/SPBl9iQfafG2i7nZuJP1XBwWOM4EU7L9bqGXriU0BbJjJyozSq9ELay8eZIFKENxp9dI9egCtWkfNmE85G7QBHhcN8WP1fshs8roNal6jWi6OILcftaroKTZ+BNX48WPTa0U6FKa9/xGR+RuTuV/BQDjSJklGVrQF3y5DyfopmRWL24sUCMyfSByQUNIRUazkTzLL/i08QJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Wk4wuODdlEjIxEWDJO6VZxam+S4LEtpvDLw9TmAOw=;
 b=TxMCLQ82ufzoVP/ZzhUQ9ZXzUzAgYyUc9vbsY6otgOIOpiTP8WzWAKRTVWQuqISNNBdRsA0kZ3v+HrlK4WhyshQFePPSTIbo2mhlJxt2qH2Wi2cL8ouDwB4f1E6bI19M/aAIqW3HRg5Z0qwIzF9pivn+NxyDOlsz5kmTjeQuyUdZVghsX+IdjNwxDDY2eM2aKimaPy7TjWgGhfZoYeJhgxlJPGweMvYSy0fKnXTbCjhPC2HWOwQXPsdiUqDhKVcdn0nUGJUigPixIH4RW1vvOaQpO+tJ8FW6/EpxE32siwum3mAJh0ySKlUTCheV5gU9rIxMch2lhxP5XZ75WeOECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 17:48:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:48:42 +0000
Date: Wed, 21 Feb 2024 09:48:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: RE: [PATCH v13 3/4] cxl/core: Add CXL EINJ debugfs files
Message-ID: <65d6377778823_5e9bf294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-4-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: a56e4c3c-e63d-4b60-0ec2-08dc330557d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzFG3B3ktd+ynKBghu9meB1/PW2TPdvoZOAoeP8tEhfF1nrtMgjUZIuMDX09lU3dueczx/jnmZuWPTNPGRdMDDIk5Zdpn1wN+XUJsA0zk7jlzbBhnFw3Pdsm1pLZOugvOPh+LmyAp63TjSGxWTEPb/6qIsigTROe11zUxeTLUHiswO6gyyLWU1l/pzuUW3+Y/P1aCxEoF1YVpmnMHKZCvOWBe0NrTam7bnd4pQ2whhEVt4GINllX49qiYIoitlILEvt2qAWiUoqobLMooigunlWfYkXWpHOWaNiuWH390dhKfaU5Eb1h5vO0Vk5I4yepVoJci6MNwtUP7LYQYXDsVRmJMRhVHk/WfYKYZfL6U3fAIKZBrgwU0nxMwtWnsssPmKzeJJFdp6qzHKSuwaZwypoqEQmKyDF20qBWtZN/5apvpVU4FVoO7yaPAlr2Y5TY9GNgWSNaru+3Jm9pJRBC7xfceXGd4owvcNOGFC8VPwuuaZIteWaCTgH5N1OAHbbsAVV0ClLKTyy+HFCZ62U33kkjCdPlfMI7uxLIINgZ88E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCxGPLhdRHWUrD3gM8uKHsWbCm3QZPeO0WzUFLoVYJkFsb4B9PnS4NB9U28I?=
 =?us-ascii?Q?XOutbJ21Uh9nMVxy5lYCUfsyNEl8mr8tHtkfFgLeoLIFyqDCduvJuKPsUIaM?=
 =?us-ascii?Q?u1Q+FJJOAkAirkRLq+gCPHOR5cDSO6/Cl92/wd3lcvZih4pXttrjy5ai/cRj?=
 =?us-ascii?Q?PurOmeWRlrxOGbwsv/Dvdjs/H26EZh0ARnCVZTplm0aN+sn6gsOSc2jKgt9p?=
 =?us-ascii?Q?iBN+VfbWNMbRe/hCcoegPTXcZafnLpQoFUTAKbUCYU1ns63ozBSaVl0Ojo0U?=
 =?us-ascii?Q?NbtkDnkm2ClpCgFD6FuKjCA6ThmbvDc3MCzP5fcynmm4c6SUDFdcbiZ06zca?=
 =?us-ascii?Q?fQi4v3xBgZW8AvITbkuBRqNKADqg+pxS020SDs+PI1ksYWT0Ou7zCx77kcv5?=
 =?us-ascii?Q?cXQAIzPQcDrKXc3y6pz7IMUeF8XFngt++dw2vPYPlu0Zig6mtGQeJ7ydnESE?=
 =?us-ascii?Q?Mh7J8ULgZWw05WphmS1M018Vs+38v0S1r6oS18/esDa3X+qAov0tyMydovOX?=
 =?us-ascii?Q?W9uUg5f4zM4RR0p5Y8WJrU+X8OPgDABg/Ln0gjbPe8AcUVYzWqIJLvZof0y4?=
 =?us-ascii?Q?SDPyypR0aXCx2YGxEgubfKPuaMkaD1Y5OUbY2tEuPx+ICeVar3TFgieE2jX0?=
 =?us-ascii?Q?2WfZ/0xNkREMCoQfpgw95BA1itlu44yxJbIkHZsCxxFx5IPNi034df2tOkDd?=
 =?us-ascii?Q?YcTbe3MH8uXM01SRV7aWS8vwkYf9DLqtnmYP5JJgTJWOYQ5lX5xTb1GVNK3n?=
 =?us-ascii?Q?fWfIjvY+nCjY4LI5hmYUDRlPXddpI2azf8jzUi2z+cpJlD+m2Up2HSW5GlJ9?=
 =?us-ascii?Q?ywlwqlpS7szeB8KeId3qO37JHVN4rtCQXF6bxLrLnNI2L8AE9BPXne8pDG+7?=
 =?us-ascii?Q?nKa/eoZAqDdLm7r/GvwnHdLofPqKzVlGxGNz+l8tDOLRdqxO1eRngNNZFbhv?=
 =?us-ascii?Q?O3OolAvj+QpSIHBUiDQA4EUB6DJvQa/6hLCPTKvYvRn5FGIKihZMuY0/GVB3?=
 =?us-ascii?Q?/3bPo5J6fI+UDhmC9D9QOgYqH6YX0kM6Ws+KsqKF9FDZawkO7JKyu6ZRPSZy?=
 =?us-ascii?Q?VXxE5uyefS1aGntKhrCIgcGqkvVKRMUNSSlZDbEDZ/BwL9wCGe+xhspUeIU4?=
 =?us-ascii?Q?MB3FCnMLC4wYbAK1cGkSuClqzmVxqRV7GR4/mrNK/F7xpEopkBjNu8KqEATK?=
 =?us-ascii?Q?34nMkWGc8eJC+1Wsp/Ev4L3ekYvfeycyrNL3Jo58Cy8PYNyVRIICKFjdyUWx?=
 =?us-ascii?Q?Q5J10A+KdWZ6WLSfu0L44gG1Z9G2SnmxxeY95ity3lkZZbrV8oOeTOjKSZj1?=
 =?us-ascii?Q?q/I+Re4i8XytfdxcqD+pnGF7mQExXzBH5lpl+Wb3qfF72AdbNtKy+ZBvw0MF?=
 =?us-ascii?Q?BKaL4p5WKuVJtzg+qAx6MtnMs9tXi3uXF0+/8aArAIxbTFr7iseKT5YoGC0Q?=
 =?us-ascii?Q?7mrWhsTn/qygd2pbSNbxZZ+D3lEqwCh9EIINnBNU/OTRxBCugF95cjPHP3ou?=
 =?us-ascii?Q?DsKUwNGOBuk9KYyBgON48BdRKjmfFVIxalTr2VqEu32GyjTEJX5KblkrzYxe?=
 =?us-ascii?Q?hl2WT9A3G2653c7ofQagxpqIkugBSGiowv4JaGD8U6a52Bi3VVGMqq/rCIMY?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e4c3c-e63d-4b60-0ec2-08dc330557d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:48:42.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpfsM4DLoZ395VOWJKtHvV98HuDQpBHFdHW0gowx7a2rkOSzvdBcs5eiwkCjWAzUo7Dar+RB7XFCrDKOHHbQuXZrkOsLApF3aJT0reHpwrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Export CXL helper functions in the einj_cxl module for getting/injecting
> available CXL protocol error types to sysfs under kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the einj_cxl module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl | 30 ++++++++++++++++++++
>  drivers/cxl/Kconfig                   |  1 +
>  drivers/cxl/core/port.c               | 41 +++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..4c0f62f881ca 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,33 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/einj_types
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The possible error types are (as of ACPI v6.5):
> +			0x1000	CXL.cache Protocol Correctable
> +			0x2000	CXL.cache Protocol Uncorrectable non-fatal
> +			0x4000	CXL.cache Protocol Uncorrectable fatal
> +			0x8000	CXL.mem Protocol Correctable
> +			0x10000	CXL.mem Protocol Uncorrectable non-fatal
> +			0x20000	CXL.mem Protocol Uncorrectable fatal
> +
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into a chosen dport.
> +
> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into $dport_dev ($dport_dev will be a device
> +		name from /sys/bus/pci/devices). The integer to type mapping for
> +		injection can be found by reading from einj_types. If the dport
> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected.
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..c86ae4c65c03 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig CXL_BUS
>  	tristate "CXL (Compute Express Link) Devices Support"
>  	depends on PCI
> +	depends on ACPI_APEI_EINJ_CXL || !ACPI_APEI_EINJ_CXL

This statement is always true "x || !x"

I mentioned in the other patch that ACPI_APEI_EINJ_CXL needs to have a
dependency on CXL_BUS.

