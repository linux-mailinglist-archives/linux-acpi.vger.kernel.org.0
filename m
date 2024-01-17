Return-Path: <linux-acpi+bounces-2923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921E830DB6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B821C1F22285
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1A24B5E;
	Wed, 17 Jan 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5Zpxt7k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5F24B4E;
	Wed, 17 Jan 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521946; cv=fail; b=al4lVJt9l9NmFTtRuUYyKv62Z6lk5MH/+ltHFk0nCTbI+bO2voJDqvWWQ7TM31KO/yce/wxvFKL++qlRoJyAnFq5jznIiYylHroA7jy7dprE6WjBJzkU0+O/qn8Iolrlgoh78PxoGWtG7xyPRq2RCXkz2m+zbvZWIZxU/PyPOgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521946; c=relaxed/simple;
	bh=qdY0XTqMhzooYHiQEBasLAiA/ZKM8EpNLej7//GiO7I=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=sCUA6yxYOqvQquGz03rl1b2Kt1RCWrk7g7zd/O4rk63EH5/fiXZXqp4/of71FfbZ3BrIEE0w10eZrMLs0XC7O6AWwTKVf9ivPVNwaE36j/gEJT/ivv+d2yVerCTrF40b4mqZPNWVNKMNIwmA7hsvD5WVz+yX3H8qc0BuowlxOFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5Zpxt7k; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705521944; x=1737057944;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qdY0XTqMhzooYHiQEBasLAiA/ZKM8EpNLej7//GiO7I=;
  b=D5Zpxt7kG4dq6WspufR2FNNhvKQBqpyNMGUvLBGm2mRCcBe3l0RSQmqc
   WjpLGd60pcp3ra3QwNKCzAV/bmP5ZUWVb1D+2YECZff1Y7etI3jP+lLqb
   IMedZJrZGK86wpuu0pNGSTZ4cW1GAQRgr03B2xuNMbpbLnDMVveNMDTRz
   fx6+IuCraVb8iYflP7pDIB8Y8FjjZZmy4sQS0INlIVJcbLV7+9u5t5IG6
   aM3C+vxYZqUaE34m6mvBQ+tDj+OsUEksXu8uAqEH+KlOvgJXWLPo586AT
   M7lqMn/IaqZetmGv5/J56Hgx+b0EFQ+bhbtzs/wHuzK8tmSjT28GwPZXU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7652926"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7652926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 12:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="111727"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 12:05:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 12:05:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 12:05:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 12:05:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHV1TotYF838WhEKq4ks6KzNnwykxUnby8YFEeXb/425LACm8XOw635ukPzLBzOquCFrTkq0zuluV0+cKg0VjsXh/+jxkdfUYOMkERu+ECbeCYkzwAX1NQDJ7BjhHQsGZIAL0a09o1qP23MBVatyR8R/H8Ev1XBGb56SubD0Kqc1RfiUnXSIz78gDTeZNsrxwyAVoQlx/6abGVwHBLpJo5+66iwDzqTewel38WTt/u086F9aIo4wbQr0oSGv0OblP95gPSF276LUzNaccnh5nEWQNRL6cca75zwhMvJtAKAgtlvXGeO9i6I2yR1u4hIFGtC/fhjDTtaGY2NpjVVWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIuODxrfx2qkx7/DKGFdU26yQFVOOePEhJ0lPPllIiM=;
 b=VKziTAljLnOxTuWsOYuBoNZRqepyOfuBUq8+f7Xkagrk3k7wZJXyVG5hNCDdnDrDkrPi1qmUQLK7Pl1BMlRGVB5qTnCFd2K/+AyjsG+Po4TbNWuxfFYEvdlrLHR7yLYqKja6YHqvhG6cOiGtcJ7IoORSB2VcBAgQNeqPg/rPvBa6m/QhnHg+x555CTXfhjCVB1bVW+NG4Sodh39wTqcpcDtjZMTD9GyJSeIISt5pBuGvZqGYjozbFGzxkDXYvAnUJLfM366jwIs/B2i+QCUPa/NbW7tdzr9d6fU6v02skirapHLZ1dk20zFgsnD8bAXIEWqEuRhTq9I0xdKHxpjB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 20:05:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 20:05:40 +0000
Date: Wed, 17 Jan 2024 12:05:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: RE: [PATCH v10 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error
 types
Message-ID: <65a83311c3c7_3b8e29463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 394ba874-6521-445c-03bf-08dc1797ad92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnRjul5+pSFJAQFormB09UgnwXh7qY2AmXgfPEilQopyXtdkA7PDTrv26BU6CyPbfWKX/bippazPqtPwuaVj/19NQS871mXlywIX1R9QsBj7HP4u7SYe3HsMNCyPqSVeldGqmF4Ww41LzuTUyi82csj61oL8A+qc+fuADGcbLf2AKbvzRNvq9YsDeWn3Uncs/9g1K0ztlaLkqk8Bn6P+yg0/8B/7mvbqKIPbMICnPpG00fMHpcrW0mU5LakDsP76ZmRSvcCGhX/4aP2NTmNEbIJbphAPm31uECm4nCejgsiRfagaFP/J0eWPuDEJbTESPbd0CteVE7doAHOj/tSjNeth7QuF1W0XLUS+gRLH0u5aVCu0HVZ2vOa11ja9mnvtMMYJNXg9CFrQ1G7Ew2M3aGy0DwAk+7V8WgG7bKHAy0R5V1J7Iydmk3rx4f1x5pwHKJ2Ulv7gb2YcXtOXIYQDYJdBoPYpGrSH3Qg8JoJN7ZNiKzHve268B2I3Oe9mt1KcGIvm1wy0zXMPq29Anr6ZsAj8MrT9kktviHpSG8AFhUL0NrD4xJIP7zb49pt039K8ZIfutvW2WQXWDtpJCOXjqAEfRsYt57SWOjVso1MObIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(6666004)(83380400001)(6512007)(9686003)(38100700002)(5660300002)(4326008)(8676002)(15650500001)(41300700001)(2906002)(8936002)(6486002)(478600001)(316002)(66946007)(66476007)(66556008)(921011)(86362001)(82960400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdCNMjuA5xfVXcURfoSn/bHQgc3y2bptfXeUdGoJT1rDfmvYNqQv8nad/a3D?=
 =?us-ascii?Q?nkfxa/1oB7lSLzh/WiXtse4eHEODxV2jDbmjWI6oAuDOi4bAGA0cLyaCQPa5?=
 =?us-ascii?Q?dSxwe0TJs2+EWWUM4OOmL5tmP/7MEhNp1VE7AQWkffteCStBytcQ91UOQ/FO?=
 =?us-ascii?Q?sK4q6wLF0JJ16HS4pn1g6IEt5R9eaIpUlOe9dAeS8gkDUfxQDsjlexzQMUpE?=
 =?us-ascii?Q?P5PkSwNY2QXTNPM9dx9wmA7Jf84eb/BU6Td4e+m8bGbkyOU1lqAyU/OzM7z6?=
 =?us-ascii?Q?BN4WWVCWim71ODV4r7BOhfdRk0zSyds9wPJSLFuxX9qNe3bwR2EXDyZIyhlJ?=
 =?us-ascii?Q?+PU3Lb1bdf7cL84QjipCYYj9X6FYpgvDNkTZP2CLuiLfjlEuaQh0CBsUS/cR?=
 =?us-ascii?Q?8cmyw86h5PJpApdAVkvJIEkJJ3wIh1MTB9KIDVAHmVC/vQZlLPu21ppoHzg3?=
 =?us-ascii?Q?zQMX18ZkU95vrITrHDs9UCLgS2F4zmXxHzMIUlU+wMLGeL2PyaW5VvV8bT6b?=
 =?us-ascii?Q?vSkS0momtpnxRCwqogH8fU6Uh6+tt8goMbv5KJZkQRGI6sctd1ADgZONoPWj?=
 =?us-ascii?Q?g2Dpe5bi9Cr3LltWvJY+RsWGJfDDhKUx8A7/OyDQFQsLMNrIVlZpcbfq3Hfr?=
 =?us-ascii?Q?ArAoZIPgLfzMUhFN0Do/xIQGBM/0izjgmrXsX2ZSw3o1PX7A4eunHejW4kBb?=
 =?us-ascii?Q?8GUw2asTYGSclTLxPp7G5MGaQJixNUj5HRQJ4/+Q3GdyMIP4mCkff8b6g9io?=
 =?us-ascii?Q?v7PEIhf+PQjhVnf6ku74DmU0Ad4PKl3eYa/KSYRA8yYs1qFqkv4DzxiTRQG2?=
 =?us-ascii?Q?7+AkNU1RgFAsp0n1r9aesOUwZdK28WxHT0fsAZfiEQ6Tojdq26oOzLaEVKIR?=
 =?us-ascii?Q?X2UtyOXuWFXSlP5NYPIJvrFxIPyIH+IOrtpbuNWCNrkNeysySjPW4CTN3ipm?=
 =?us-ascii?Q?RGmHsDw5mJLK6YgtHSmsU64HOV180qOntq0OMSZdopRgmOr1e5vJYOUnU3gM?=
 =?us-ascii?Q?VePVDukeA4JF6aJjQ9PT/YWp1FnWls4j61UbJK24V9cNX2xfpe1ScYlK6Suy?=
 =?us-ascii?Q?9ok+xMIdB+uYcpMSIcmD6q5CBDQrpAlf14Uz9Lu6dX76cYge9vuYhDSYPKfq?=
 =?us-ascii?Q?uJtjRkXnhDsm4v8+NdOFAJIDehyutj0haohmZ+u+arL9IPRKw/HjJMVzfVKE?=
 =?us-ascii?Q?O01XxiKd39hGXB4oygOGfgb2hME3+ieNJkT2MIovLB8F76GYLITYlr2nRmvy?=
 =?us-ascii?Q?Jr8U795IoWkT/45M+Q0YOO41La+CRxFGCto8TKegMH7TN6pd1YkTDd/Qa1BE?=
 =?us-ascii?Q?Xn56GCR0pT6HBxlEcwrlfDZIytZ0I9b9EQ4yAl0rrHEtXO5z7IlQtN4quoKs?=
 =?us-ascii?Q?5ORO16IsOfg72lkPNaujif+gvpRLWpoTnZcWRHbEnZ/0OJQ6wB9ZTBJCZrKK?=
 =?us-ascii?Q?Kfp9uv5wGp16V4fMCg3xgVohdzKTroLpkmk/oqb7pjg9Lbxbxaft4eY69+/Z?=
 =?us-ascii?Q?3mLUzT2xIFryBFIs+RkqUU38pFu4byh5obBm3yOQ2tiyc6cWK+91kS7mtmRl?=
 =?us-ascii?Q?gPs3LCs/e6/A8L4Jk1DNZRuA0vIz5OluJS5Kh3QrhsAYvt5mEbZsJ/x8tvu+?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 394ba874-6521-445c-03bf-08dc1797ad92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:05:40.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwhXYYEzFmCp18KhWhIwAUkjNJn2yt8koCLlfp6ubzU8bbAwhyiiT3WaPLBF207pI9fmxDLx1JavTtVmDI/GKaLQtWnsCBS6OddzKp7pWjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6912
X-OriginatorOrg: intel.com

[ add ACPI APEI reviewers ]

Ben Cheatham wrote:
> v10 Changes:
> 	- Fixups in EINJ module initializtion (Dan)
> 	- Add include/linux/einj-cxl.h to MAINTAINERS under CXL subsystem
> 	  (Dan)
> 	- Replace usages of IS_ENABLED(CONFIG_CXL_EINJ) with new
> 	  einj_is_initialized() function in cxl/core/port.c (Dan)
> 	- Fix typo in EINJ documentation (Dan)
> 
> v9 Changes:
> 	- Remove wrapper __init function in EINJ module and use a platform
> 	  driver instead (Dan & Jonathan)
> 	- Move cxl/einj.h to include/linux/einj-cxl.h (Dan)
> 		- Rework header file to remove cxl_einj_* functions (Dan)
> 	- Add IS_ENABLED() guards around EINJ debugfs functionality in
> 	  cxl/core/port.c (Dan)
> 	- Rework cxl/Kconfig to be more concise (Dan)
> 	- Small fixups to cxl-debugfs documentation (Dan)
> 	- Add check to not add einj files to CXL 2.0+ dports that aren't
> 	  represented by a pci_dev
> 	- Bump version number in debugfs-cxl documentation
> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped downstream port. The value of the memory address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> Instead, make the error types available under /sys/kernel/debug/cxl.
> This allows for validating the MMIO address for a CXL 1.1 error type
> while also not making the user responsible for finding it.
> 
> Ben Cheatham (5):
>   cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
>   ACPI: Add CXL protocol error defines
>   EINJ: Migrate to a platform driver
>   cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
>   EINJ, Documentation: Update EINJ kernel doc
> 
>  Documentation/ABI/testing/debugfs-cxl         |  22 ++
>  .../firmware-guide/acpi/apei/einj.rst         |  19 ++
>  MAINTAINERS                                   |   1 +
>  drivers/acpi/apei/einj.c                      | 194 ++++++++++++++++--
>  drivers/cxl/Kconfig                           |  12 ++
>  drivers/cxl/core/port.c                       |  39 ++++
>  include/acpi/actbl1.h                         |   6 +
>  include/linux/einj-cxl.h                      |  45 ++++
>  8 files changed, 326 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h

Looks good to me, for the series:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Next steps are for the ACPICA process to pull in the protocol error
definitions so that patch2 can be dropped, and for one of the APEI
reviewers to ack the einj.c changes.

As for merging, the balance of the changes are in drivers/acpi/, so I am
happy if this goes through acpi.git, but otherwise circle back in a
couple weeks after the merge window completes to track this into
linux-next. Thanks for all the updates, Ben!

