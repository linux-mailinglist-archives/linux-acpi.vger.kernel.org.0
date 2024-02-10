Return-Path: <linux-acpi+bounces-3345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657F8502C3
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0941C22BD5
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 06:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3523751;
	Sat, 10 Feb 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMZs3HzV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4116439;
	Sat, 10 Feb 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707546672; cv=fail; b=fKhoppGkl8PlRvuSQ3b3eMXEWeTfigQNJBTtVQ/2Y+RBRDuDcKHlraXSLAsXJ9k+QrGgl/lKL7DCAmNhX24V3Vmfv25IsczhdPmS5prXDJqplVhcP7iZZY7EQ46SSna2J62+11iEWCQ8M4HUajQxBQnzqip16bXen2fPCMoMePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707546672; c=relaxed/simple;
	bh=JPBhxYVKnoSUdbubDQQB56wY0VZ7DdLO0R/B5UDEUMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMHlj0Ntqu4Og8Fe2CNbsQvx9nmG3ee801ov3mg6008Ekl2eu34qz6/1jOhiQgnyvl39HyQsZu3wFv3MxsLejOTIyqtPUPDPiq1o8v7eSRK++v1bwH482nhKha/FnuGDeuiU0/ZcKnB4R8HS5//wVNqcyO5Jw/nKUCAAwpLtIts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMZs3HzV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707546670; x=1739082670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JPBhxYVKnoSUdbubDQQB56wY0VZ7DdLO0R/B5UDEUMs=;
  b=UMZs3HzVOZ0nPOY6i0rRuAVscx/gKLzSkaXRf1Cef+jQ+u/mI+EVQNL7
   qth23dZW63c4477eM3U709yDXaDjVjbmG1cbp+SAgz3if1806JqozRHpn
   SyWidwpOyl1Qv0yz0tGTuzQjSR+3iFII/ciNScNtwFy1lgY/N/SrQxvEk
   NkSemb1znNsicpeNQtbqnzedtkFVoixSI091NtH/y3zgybhJ1ofl7XAKH
   iMWKqEBeVJ6QhUp2I3k9BPEERtM+5ePoVUOL9LGbIlodf9j4CdJTAVZ6D
   SRn7UdvwrOeKnReKZb3TkHiG5ebU1KB9OMUqj8t6QcSOI3H69bCaoreLo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1433829"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1433829"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 22:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2502854"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 22:31:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:31:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:31:08 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:31:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng7OVWsvz/OiaqnV0I1oWFkWCkrV7UE1HWbmWUcIwb234CCLCbLRMOx1+3Ywj5QUx85mp4SKJmbpRseqCGYmHLoELnT2OF6laSMlVbZNorOkseKQ2cBd5rw8hAqdDa2ZF3YfhVvl+ggpq8BWxO77nyAgnTnHvT6o0g1k5fyahkrh7zyz8wx5LcCjgy2HX+lMT4AxGxo/UbIqDrxtptWnofTCq7hmKFGr6TNgsCZYl+Mju/zoXQVyGwxkn/CTzp6y5Rg0C7o4SMy8W9FGPNhaSgzQUtMir52xwR1F0uHnyE6GhA32BpzOyCPVsmFw7XnBQpOB0Fn0tLYq1wvHrpa2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IanGiNVDEOas2pwN5JLiYdsq4CHd7PhVprgolKNCKcI=;
 b=NuooZ/EX8iWCmkcfdNYLXCGb6deEHU/OPKPGfLNGUe1fijz4GcqvhviBG4I9UqCsUJhBMe5jalLZ1kRpvdWeQGher1t8IfulbxtuonsgKgsv5quFvqTcS6hMXQtv1uoQDpacPiSiF5rG5epyT7ZqXsdRkfZIcFrwYxbBnDmzCyW8h7SSvgX1Hmkg3DG1Z0qE5F+YSWb9fT7KrpiwxaAkwwr8CVanemJkv2nvTJ3+EGsdkMomT+uf7JJvlL9lAb+tD9+BKfJrIkzV0bIKSsGhclIjRS6Wa0VZ5/WG9XVSjAcNFSDYhWSdtmza/rxt+esqXoG6z7D2KNiMboeFo5KD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sat, 10 Feb
 2024 06:31:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:31:06 +0000
Date: Fri, 9 Feb 2024 22:31:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65c71827726ae_5a7f29434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
 <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a358ef-f0a8-4384-da4e-08dc2a01dc2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YrXibwdd+TFMddkl+69wdRcbmhuLzj5Boscc+MH/WfMOhbI9BPFlMgN8w5IAbH6EWhAYygi2PHGeUbdAIZk1iDDQtSAq02i5pFIit6GzGsC7HdC+vAOfH2mGSVx1lGisDQDCm8U8InwYH+tnqoWnb157uobNRMIN7LxK8PdBX5w4k+wBBQ7IiDPMzetUEVXWQEjhqdF5szesaUVGKKFOMTrMU4LI9vJTRcxh5Wz+j/mB4rVuWN6omefWSePsVR64F4AopHITWHRyIthijAz2phuE8+qQfERUwhY/CW59oiwMReYBUC22GlAgHFWhR6YNlmJsBTeCfyJ1JMeFYKD/FrRkuqnjt0LJHUDwwzCYSGw+YKO9qMxO81tEwqLspDBTHp4Sz2mC+AAfSz9isbJ1gsOrSizwKkAjRuJXYFXVaGCa4lbS8QkRi8zObWZyFW4PXk8zwsbwelvziRxZgQOZ2dlvMbY60gLODcp9vfd+s5OuyIIjlGIc4C5p8l1T+pdw2R0ZHdiNiWMnw6RW3WbvqeKSJ7KicYUf8ki2dFYxRuXi2ReHLGjV1+Cc0a1Iw+X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8936002)(8676002)(5660300002)(2906002)(30864003)(83380400001)(26005)(38100700002)(82960400001)(86362001)(110136005)(66946007)(66556008)(66476007)(316002)(6506007)(53546011)(6666004)(9686003)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEwCkprtqHZvQ6AtgICNHrc3GC+NEDqlzOnt1pzTrfVIgepPC0+1sqscFifp?=
 =?us-ascii?Q?K/I2kk3V4+yCfk1yr0+i4Aa/HkGZ7K/eGW8aSgWlswmjB6OO90lwQEeGTULh?=
 =?us-ascii?Q?u5vcT8pQtVq6hdp/Vwlh8KeuWhnKJl2sNOf82yi5IY4wtXEpPvuDe91T1hUO?=
 =?us-ascii?Q?lEkY5FSVKuLqmqB/eCyeTRxZb9MsZwRJZV9urtlr/aVFqFFl58Q69O/wrfRC?=
 =?us-ascii?Q?tJKtKV5e9t3RDrOHyqNFF+NiEZU7Va3mTnKEp+CYLCdQsj9wYNo33Hiw600l?=
 =?us-ascii?Q?GZEzkkt3ZGuiKnB/7GYPSImmeMBbWSehED2mV0C+fKu40C/Ipx9KaG0oD7fG?=
 =?us-ascii?Q?DSCAQyIE9Uzm9TRFKQe+E6TNeKE6tFbhiav8g6fS6w/FjWoeOTy3ATII9yhD?=
 =?us-ascii?Q?8TxnOR9DkSUUuT6go76OZWZAIwFxFw0MzIUpPWUPZ65kJWwFv//hlfMegNiN?=
 =?us-ascii?Q?0+1bl3Y0MEL8FNgEHef1pLpoBYm0bSC5q9mCVdyuuu4A7w3jvewaEaF8z4y2?=
 =?us-ascii?Q?h3PfASetsa/IjgFhEGNEv0hXphWygo79pTiHcZa5G/iJSlahtiTONO629Qct?=
 =?us-ascii?Q?WZcXBHm7clfBz2kLMt/4QizMspJIhEeuhmhDpaaGjGisvw/mWo7d1nuNL+HJ?=
 =?us-ascii?Q?he9wHi5+5yHpuuCEQ92NUmouZ9H2/mOtZYFiH+1Z1x/inqhZ0KDRJH8lcGvx?=
 =?us-ascii?Q?drMDmpR5FWUfvG8e4qvP4EKSpcIe+CCIkV1zn6I4y5OY5IBBUHDMKMG9NDGl?=
 =?us-ascii?Q?xne/rSoI+5VS4zXN2xb1V3sDYVv/U5+lmi0ToWPKknvDeGZgZySMf9f63pL4?=
 =?us-ascii?Q?ced1M+6lwhd1chm2V415hbeg/sDOTUPtPI/Oisg2ZStVe4lCxMUJBpJET11e?=
 =?us-ascii?Q?JFVni8JS01gSKUIVIvnBkUQ4ebWwcZgH/zvLEzxOlEpg+vcbuhmINsS3IvOw?=
 =?us-ascii?Q?uVqnf1FXhoOays1zTkoOCzkjs14Xz4L2cnK3ZeQdr3rcUpH9Nuw/Qua60bwF?=
 =?us-ascii?Q?ZTQ2TFsKQnUKSvzm8u/UqWIZvESB5qS+m0YT9Pak9v4Z9eD/u3kqzqXykarm?=
 =?us-ascii?Q?qqiTUmk0J8HmEyWPXU2LzmeNVE8kUJm5LX7GjD+qTzicVSbxVUR2OlH9K05W?=
 =?us-ascii?Q?xBvfriW8D6+oAjVT0z92aJcsbrKUQL5r/+nAXtrnl3Eg1I4ULo9mYXBYsGLv?=
 =?us-ascii?Q?W0OJdCBkLOWx/Lh4rOrL/zllDtfY4UckyidjzlzdHVXmyzD2uXHI8OM4DLC0?=
 =?us-ascii?Q?w9uKE4x66dRATX6WyUB+Yke8+wNNNtwZ3HfsLoa+KsQyEwbFnD8G4YZd2OsZ?=
 =?us-ascii?Q?GUEX2lQqL3jgSb6lxnxcf3uYUbmb7pSWK3NiNWQMqHWeeM5cBGuJBIZtLgi4?=
 =?us-ascii?Q?Mwi3jroQAQEUlti8xkD3li7u4TE1zcic70dXm6aBfuGosp2L750yfXOxpQue?=
 =?us-ascii?Q?wM1diCKR/Z+aHfHsZIoshKkV4emESRznI0e3eC9Yob99ESH55tKNvI+xBAGJ?=
 =?us-ascii?Q?3RnqHvWeqwbJ8PvkHCH63z52Slo4trKxDoKBngys1W+Oizq5UmoqCAz4mJ6K?=
 =?us-ascii?Q?JkbcRQTGezXZN0Gz8Bx4qn23DFr5fT9f7w8Kvd07VOergXrKgb5vcZJ/8SNL?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a358ef-f0a8-4384-da4e-08dc2a01dc2e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:31:05.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oWYbo8UIM/4kHLSilLU81kMDimRLn9cfJjfMPKvsTzkUGRLD4ZBeOljsKLg66KqVpShb+FQfCgl9rsdPLAyj0cICUbyJGzNJqk60wUxg3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ben Cheatham wrote:
> > 
> > 
> > On 2/8/24 2:00 PM, Ben Cheatham wrote:
> > > Implement CXL helper functions in the EINJ module for getting/injecting
> > > available CXL protocol error types and export them to sysfs under
> > > kernel/debug/cxl.
> > > 
> > > The kernel/debug/cxl/einj_types file will print the available CXL
> > > protocol errors in the same format as the available_error_types
> > > file provided by the EINJ module. The
> > > kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> > > error_type and error_inject files provided by the EINJ module, i.e.:
> > > writing an error type into $dport_dev/einj_inject will inject said error
> > > type into the CXL dport represented by $dport_dev.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > > ---
> > >  Documentation/ABI/testing/debugfs-cxl |  22 ++++
> > >  MAINTAINERS                           |   1 +
> > >  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
> > >  drivers/cxl/core/port.c               |  39 +++++++
> > >  include/linux/einj-cxl.h              |  45 ++++++++
> > >  5 files changed, 255 insertions(+), 10 deletions(-)
> > >  create mode 100644 include/linux/einj-cxl.h
> > > 
> > > diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> > > index fe61d372e3fa..bcd985cca66a 100644
> > > --- a/Documentation/ABI/testing/debugfs-cxl
> > > +++ b/Documentation/ABI/testing/debugfs-cxl
> > > @@ -33,3 +33,25 @@ Description:
> > >  		device cannot clear poison from the address, -ENXIO is returned.
> > >  		The clear_poison attribute is only visible for devices
> > >  		supporting the capability.
> > > +
> > > +What:		/sys/kernel/debug/cxl/einj_types
> > > +Date:		January, 2024
> > > +KernelVersion:	v6.9
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) Prints the CXL protocol error types made available by
> > > +		the platform in the format "0x<error number>	<error type>".
> > > +		The <error number> can be written to einj_inject to inject
> > > +		<error type> into a chosen dport.
> > > +
> > > +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> > > +Date:		January, 2024
> > > +KernelVersion:	v6.9
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(WO) Writing an integer to this file injects the corresponding
> > > +		CXL protocol error into $dport_dev ($dport_dev will be a device
> > > +		name from /sys/bus/pci/devices). The integer to type mapping for
> > > +		injection can be found by reading from einj_types. If the dport
> > > +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> > > +		a CXL 2.0 error is injected.
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9104430e148e..02d7feb2ed1f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
> > >  S:	Maintained
> > >  F:	drivers/cxl/
> > >  F:	include/uapi/linux/cxl_mem.h
> > > +F:  include/linux/einj-cxl.h
> > >  F:	tools/testing/cxl/
> > >  
> > >  COMPUTE EXPRESS LINK PMU (CPMU)
> > > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > > index 73dde21d3e89..9137cc01f791 100644
> > > --- a/drivers/acpi/apei/einj.c
> > > +++ b/drivers/acpi/apei/einj.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/nmi.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/mm.h>
> > > +#include <linux/einj-cxl.h>
> > >  #include <linux/platform_device.h>
> > >  #include <asm/unaligned.h>
> > >  
> > > @@ -37,6 +38,20 @@
> > >  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> > >  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> > >  				ACPI_EINJ_MEMORY_FATAL)
> > > +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> > > +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> > > +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> > > +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> > > +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> > > +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> > > +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> > > +#endif
> > > +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> > > +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> > > +				ACPI_EINJ_CXL_CACHE_FATAL | \
> > > +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> > > +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> > > +				ACPI_EINJ_CXL_MEM_FATAL)
> > >  
> > >  /*
> > >   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> > > @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> > >  	if (type & ACPI5_VENDOR_BIT) {
> > >  		if (vendor_flags != SETWA_FLAGS_MEM)
> > >  			goto inject;
> > > -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> > > +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
> > >  		goto inject;
> > > +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> > > +		goto inject;
> > > +	}
> > >  
> > >  	/*
> > >  	 * Disallow crazy address masks that give BIOS leeway to pick
> > > @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
> > >  	"0x00000200\tPlatform Correctable\n",
> > >  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
> > >  	"0x00000800\tPlatform Uncorrectable fatal\n",
> > > +};
> > > +
> > > +static const char * const einj_cxl_error_type_string[] = {
> > >  	"0x00001000\tCXL.cache Protocol Correctable\n",
> > >  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> > >  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> > > @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
> > >  
> > >  DEFINE_SHOW_ATTRIBUTE(available_error_type);
> > >  
> > > -static int error_type_get(void *data, u64 *val)
> > > +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> > >  {
> > > -	*val = error_type;
> > > +	int cxl_err, rc;
> > > +	u32 available_error_type = 0;
> > > +
> > > +	if (!einj_initialized)
> > > +		return -ENXIO;
> > > +
> > > +	rc = einj_get_available_error_type(&available_error_type);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> > > +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> > > +
> > > +		if (available_error_type & cxl_err)
> > > +			seq_puts(m, einj_cxl_error_type_string[pos]);
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
> > >  
> > > -static int error_type_set(void *data, u64 val)
> > > +static int validate_error_type(u64 type)
> > >  {
> > > +	u32 tval, vendor, available_error_type = 0;
> > >  	int rc;
> > > -	u32 available_error_type = 0;
> > > -	u32 tval, vendor;
> > >  
> > >  	/* Only low 32 bits for error type are valid */
> > > -	if (val & GENMASK_ULL(63, 32))
> > > +	if (type & GENMASK_ULL(63, 32))
> > >  		return -EINVAL;
> > >  
> > >  	/*
> > >  	 * Vendor defined types have 0x80000000 bit set, and
> > >  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
> > >  	 */
> > > -	vendor = val & ACPI5_VENDOR_BIT;
> > > -	tval = val & 0x7fffffff;
> > > +	vendor = type & ACPI5_VENDOR_BIT;
> > > +	tval = type & 0x7fffffff;
> > >  
> > >  	/* Only one error type can be specified */
> > >  	if (tval & (tval - 1))
> > > @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
> > >  		rc = einj_get_available_error_type(&available_error_type);
> > >  		if (rc)
> > >  			return rc;
> > > -		if (!(val & available_error_type))
> > > +		if (!(type & available_error_type))
> > >  			return -EINVAL;
> > >  	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> > > +{
> > > +	struct pci_bus *pbus;
> > > +	struct pci_host_bridge *bridge;
> > > +	u64 seg = 0, bus;
> > > +
> > > +	pbus = dport_dev->bus;
> > > +	bridge = pci_find_host_bridge(pbus);
> > > +
> > > +	if (!bridge)
> > > +		return -ENODEV;
> > > +
> > > +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> > > +		seg = bridge->domain_nr << 24;
> > > +
> > > +	bus = pbus->number << 16;
> > > +	*sbdf = seg | bus | dport_dev->devfn;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> > > +{
> > > +	u64 param1 = 0, param2 = 0, param4 = 0;
> > > +	u32 flags;
> > > +	int rc;
> > > +
> > > +	if (!einj_initialized)
> > > +		return -ENXIO;
> > > +
> > > +	/* Only CXL error types can be specified */
> > > +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> > > +		return -EINVAL;
> > > +
> > > +	rc = validate_error_type(type);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	param1 = (u64) rcrb;
> > > +	param2 = 0xfffffffffffff000;
> > > +	flags = 0x2;
> > > +
> > > +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> > > +
> > > +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> > > +{
> > > +	u64 param1 = 0, param2 = 0, param4 = 0;
> > > +	u32 flags;
> > > +	int rc;
> > > +
> > > +	if (!einj_initialized)
> > > +		return -ENXIO;
> > > +
> > > +	/* Only CXL error types can be specified */
> > > +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> > > +		return -EINVAL;
> > > +
> > > +	rc = validate_error_type(type);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = cxl_dport_get_sbdf(dport, &param4);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	flags = 0x4;
> > > +
> > > +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> > > +
> > > +static int error_type_get(void *data, u64 *val)
> > > +{
> > > +	*val = error_type;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int error_type_set(void *data, u64 val)
> > > +{
> > > +	int rc;
> > > +
> > > +	/* CXL error types have to be injected from cxl debugfs */
> > > +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> > > +		return -EINVAL;
> > > +
> > > +	rc = validate_error_type(val);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	error_type = val;
> > >  
> > >  	return 0;
> > > @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
> > >  	return 0;
> > >  }
> > >  
> > > +bool einj_is_initialized(void)
> > > +{
> > > +	return einj_initialized;
> > > +}
> > > +EXPORT_SYMBOL_GPL(einj_is_initialized);
> > > +
> > >  static int __init einj_probe(struct platform_device *pdev)
> > >  {
> > >  	int rc;
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 8c00fd6be730..c52c92222be5 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/memregion.h>
> > >  #include <linux/workqueue.h>
> > > +#include <linux/einj-cxl.h>
> > >  #include <linux/debugfs.h>
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> > >  	return rc;
> > >  }
> > >  
> > > +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> > > +
> > > +static int cxl_einj_inject(void *data, u64 type)
> > > +{
> > > +	struct cxl_dport *dport = data;
> > > +
> > > +	if (dport->rch)
> > > +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
> > > +
> > > +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> > > +
> > > +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> > > +{
> > > +	struct dentry *dir;
> > > +
> > > +	/*
> > > +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> > > +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> > > +	 */
> > > +	if (!einj_is_initialized() ||
> > > +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
> > > +		return;
> > > +
> > > +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> > > +
> > > +	debugfs_create_file("einj_inject", 0200, dir, dport,
> > > +			    &cxl_einj_inject_fops);
> > > +}
> > > +
> > >  static struct cxl_port *__devm_cxl_add_port(struct device *host,
> > >  					    struct device *uport_dev,
> > >  					    resource_size_t component_reg_phys,
> > > @@ -1144,6 +1176,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> > >  	if (dev_is_pci(dport_dev))
> > >  		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> > >  
> > > +	cxl_debugfs_create_dport_dir(dport);
> > > +
> > >  	return dport;
> > >  }
> > >  
> > > @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
> > >  
> > >  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> > >  
> > > +	if (einj_is_initialized()) {
> > > +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> > > +				    &einj_cxl_available_error_type_fops);
> > > +	}
> > > +
> > >  	cxl_mbox_init();
> > >  
> > >  	rc = cxl_memdev_init();
> > > diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> > > new file mode 100644
> > > index 000000000000..af57cc8580a6
> > > --- /dev/null
> > > +++ b/include/linux/einj-cxl.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * CXL protocol Error INJection support.
> > > + *
> > > + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> > > + * All Rights Reserved.
> > > + *
> > > + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> > > + */
> > > +#ifndef CXL_EINJ_H
> > > +#define CXL_EINJ_H
> > > +
> > > +#include <linux/pci.h>
> > > +
> > > +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> > 
> > I was testing some other work using this kernel and was getting a linker error
> > when I had CXL_BUS set to 'y' and ACPI_APEI_EINJ set to 'm'. I went ahead and
> > solved it by changing the line above to use IS_REACHABLE() instead. The change
> > shouldn't actually affect the functionality of the patch since this is in a build
> > configuration where the CXL driver isn't using the EINJ module since CONFIG_CXL_EINJ
> > is set to n due to Kconfig restraints.
> > 
> > I can submit another version of this series with this fix, but I don't think it
> > makes much sense for a 1 line change, so I've but a diff below with the change
> > for whoever ends up putting this in their tree:
> 
> I don't think this is the right fix. CONFIG_CXL_EINJ should be disabled when
> CONFIG_CXL_BUS is built-in. Looks like the polarity the dependency is
> backwards. The problem with IS_REACHABLE() is it removes the simple
> debug option of "send me your .config" to see why some functionality is
> not turned on.
> 
> Could you test out flipping the dependency from:
> 
>     depends on ACPI_APEI_EINJ >= CXL_BUS
> 
> ...to:
> 
>     depends on ACPI_APEI_EINJ <= CXL_BUS

Wait, no y == 2 and m == 1, so:

depends on ACPI_APEI_EINJ >= CXL_BUS

...is correct, but you need IS_ENABLED(CONFIG_CXL_EINJ), not
IS_REACHABLE to guard those exports.

