Return-Path: <linux-acpi+bounces-4172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA1875B60
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 01:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10144B21554
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D7184;
	Fri,  8 Mar 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8Jz3ZYY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB527366;
	Fri,  8 Mar 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856112; cv=fail; b=lvtR0uYPUkQCl5clXgBu0YMgIVhQaxOCCczsi02h5+UcfrUedqbxatvqS4fcs/VDwAmjLTHo9wyesfE4jF7iddxSu7al3wwB4DUw+biPR2WIph7NpbfPZ3JuRwl4A2kC422mk5ZyMKDjrRVnEIkMT3+GZ7kNp0MtcEOGw+CV9Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856112; c=relaxed/simple;
	bh=ZASltNDsDTgEA29hGAtWq6xzEgM6NX3jcsG0z+pOlN8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PWxMISC2cEzkcPJHeceCfWs50Mzs+H5iYeGq/VjmR7IQUhCIonrgFM5GKNIuYUWv9RH6GrJJnsPyaZP2xvSYeIIXNYePCsDOSJfz4Fw46+BElZm0eZlX9gd/B4PUhMv7NnBRUVSPXKP3UR6nQ4/uHjmqYoGCWJGuXebetmDxMu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8Jz3ZYY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709856110; x=1741392110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZASltNDsDTgEA29hGAtWq6xzEgM6NX3jcsG0z+pOlN8=;
  b=J8Jz3ZYYe9IlPFytyAtWW6D2zA0AFeQLUq0VZgJNY2/i/rKJSWYoINfO
   FCbgFFpSDkmcP4AeHtUw+CnczyB1dlYUyPELkXuxFZXJd+KNs96E1QqEN
   bZ4/9o0Eh9a034/f972f5fIfst+k51sWiA9RvDml5r4lqkeh/6MZ+fxiG
   q8XvkUpIKoG7fYw65uRQrQG9O8zoOQG82vVA7TeGWO0e0/BEr0Zz33Rq6
   6pB0jCAL9JVHdStpuFu6HI6Fhe6/CWfP/7/tEynwsDPbu4U4yiTJ+6y7b
   Z2G9KNX3ZwBS+sHSfPGdejNnCMa8xmHY4cb7htM/9vsJCWYsjxDrjzOSC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4439005"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4439005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 16:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10169562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 16:01:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 16:01:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 16:01:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 16:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRFFg6S2aA3iP1HtGSdiv+0DafYDZm9X4qh43bcDTrMGdC7Spo4ivuMiiNV1xBu11SslMtSqtbph1HT1/sd5QLWInb03piy/gFbJw51V2bSNxX01TFP9dUd1w6L4BPT3Yb/FQM5rw5Btj1uR/WWChnWMaY/3zvFlPZVuj8TUFvPWa0xSaGwbACX/hI3wvIOh9zKmeNbLRiIVI7MOBJ3jXYS4Vv54mTZk56NDaexQpHTJlSo4xNDlDfMgK1b1TBL+NUJQFC+Z2SCIAZe6yLgSnfE3zKp1UlHsstkJsIV8O1kI3yAoucK4QZKL0QyyW54IvL4dkB7p/sALxqU9UxXQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXx+tGAYbqfBn/loDqWTZgCNRqiWXUllXdqBUCSZbOs=;
 b=bAY5ybFRLIS5z+SJXB7yMiWq+GoVhhnTq6koz1INr3VBu45OnCxTTdO/eU+Jw7NzhZokEyce8iS5d1aiSZ3QV6CD8BtjLDX4CQ3m9vihJ+ngvQNY4YNHX7Ff3et6ep7P0cdTnZzosfnzn4Sv4XkWoRT7bSB71TXFsJjpiVLhYvxcuWE//nXg5OV6YwKgLV87RL1086nTyzUiz6byXwZjPYobtUaRSMyCojNg7rgkVzlyIDcmMon1gMGsXAWIHcyaDpejXCwBNvKHf4Q9y2Zui3EqhkSUA8esygYMwr/5/fujqAjAqs5AgAz9qCFpI7j19bB3WP007UH9JNXf05nk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 00:01:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 00:01:46 +0000
Date: Thu, 7 Mar 2024 16:01:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
	<ying.huang@intel.com>
Subject: Re: [PATCH v6 11/12] cxl/region: Add memory hotplug notifier for cxl
 region
Message-ID: <65ea5567a5c59_1ecd2947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
 <20240220231402.3156281-12-dave.jiang@intel.com>
 <20240306145331.00003e54@Huawei.com>
 <1dfdec49-5d37-4117-96d6-3191cb12ee2d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1dfdec49-5d37-4117-96d6-3191cb12ee2d@intel.com>
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8ac950-d723-45e9-ea98-08dc3f02f203
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozmUlYP0OnmljSof95M/UZcTv1qXTxzlP/i7FYNVGpD5ihKCxxRnM3R51G5krSdPXvdcJc1Dl9Ymdzg7ts/z/vy0ogkwoBeRUAFKbKiHB4dPQTcoXKGFQa+KPbptI77Dq0bh6Btl/clX+2PnQ3FP9M9y6xnF0CvC+rrsyUDpv2QJ1dgVjsTT3ovBAoKSTu3LQFER0ZN0+bwzmNutAsnO7DkZXrSMFUwegBtMckRiQr1Dmd6sKyNnl2ABH6lB3eoOSwHy75ClWjnk8f/CPy7o+qtiFyMBl/yKTaMu512cHSK+C3uD6fLKhy2Hvw6tL0Q+pC2R78Lua26QmZmsVjlY2CLiFVitsqfamikwtPakPZEBgybmASP+Chz7nsGu4VooGoAR2V35x8hoeLsNrMW706H4/2x/5RwGyaO41t/DXeFXFAiRot9ln39RZ8VgYbMGX6fI35h6Vu/j5zYmFg+62krgxfvgxO8Y5erajtuvEMGqlniQcYu6TowdxjRcseLji3aHT9HUFzga97z16Lq6EH20fA6T5+7YwHn8OmrxFpkGtaq/Xjykk69h5CBpGKLv1gFY9gyhUb7KzgIdjL6JzB3EzqTHxpZP66+ajS7CtrEaBhSR85lFc7I75P8cDCbLusRQ8oNs0cR5uE+UMksFhdOaYm1qtAOApDltBKuIF0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWsSffkM4pTCG5g6QFrIgGnDkx42eRl9OvSPCpLEbgPAEjvNQ6IzYJ0k/erY?=
 =?us-ascii?Q?lj09DsFZRWxaqDq0RqaJgOE/zsWRV9TESnN7dhzCawq22rU+WJXE8fAweaI9?=
 =?us-ascii?Q?qnlnZE+lQLj7d/332kb6EcwSKRIRn7gGOKfFLApn6PyWaqBRd9XO6mYvBCha?=
 =?us-ascii?Q?JpEflXx35XMJvwDkG56jttCFwpszzBDQVTWDFEd1YiGmCN1eFD//OJUl/r/2?=
 =?us-ascii?Q?KD8ISeavZKrD5X7SIuQwywUjQkuBz/NAfmDWC5qmNAMX2Ta3f5dsZULcPcNp?=
 =?us-ascii?Q?Z5YlqFyYgOuMqMvAbfKRUm0sKtQcEBanZspI3JrXycbL1OL8nd62yPo068yF?=
 =?us-ascii?Q?XYjffuBINbcDEYNg2z6Cgr4jmFbwkK0/3V5W2M/EXK4r4ACRrBuo5WYaCX6B?=
 =?us-ascii?Q?qY+Ah72CkNq5ve1hrs+0b2znJtjyMq+SqS9TFjxJz0OlrNfxbiMVYQK+1di+?=
 =?us-ascii?Q?h17sjbR8ghfw696nvTevDYeKeilXu6utk8yL/d8r/NvR37+Xlyhufr6653hP?=
 =?us-ascii?Q?PMxTflEAT8CSB9TMOQdGJZgb7cmEOLV+70V0cqINgpqewIEkKMa+cX17KCmq?=
 =?us-ascii?Q?aqP7q4Lk9Egt2br3cacwJ1bBAETuGg+YDcKMTerCZiMAGmIa0dMaSCRSfWnc?=
 =?us-ascii?Q?ZCEWptaIwTo1EjJY6GXGpVxvfax0ewU1e9wFZDp9sEr1i86u81VXX6idTEDt?=
 =?us-ascii?Q?WclvuWG4TUc59QvqbUBmxTYyssu93U4XUNcAtQgddjwayVCLoUWEK91BDtFN?=
 =?us-ascii?Q?5PbWtuQXO/c1OR3bK5q9FBTSr5bkQVvUePDwqehZUUyFNIhRiEYLZn5EB5lC?=
 =?us-ascii?Q?H6qQu0ZppGieuu9gHLnymf8Sw8TedCe1i+3sTNsppg58QH+apP3nws8gAC4t?=
 =?us-ascii?Q?KDC6rY3/82fuTw9jps0OEhubDurnwwUEpKPeTfPc3XlOAp5cIt9PrIdc6nT2?=
 =?us-ascii?Q?Qk1c91iu7j1ycgNU24dPr/Sw2xjjMu/IJOjsD4wO3M07I6i8cU6vnaYOGW50?=
 =?us-ascii?Q?vY0V7uAivorHYhTEkPlpoeQhpyBzydoO5rsVJQHNg+Vhc2irHO3C38lSH6oU?=
 =?us-ascii?Q?MgQS8O77wJb08tPkfOhnaMDmaWjZ0MMcp+I99KZYEiZ8EK86hWqT0rmuCozd?=
 =?us-ascii?Q?7PNrNplnCEkbOJPdzimJDRWpnrad42u9csHyqZHIb9uGGD720AzHqVfrAhNn?=
 =?us-ascii?Q?p/v2OI9VHGQrSiPESE7GSvhKY/3LVt368g6n1OAgrtQ8D/Qd3SZBfvNs3h1j?=
 =?us-ascii?Q?QaCVyJBhLAZh9EeCYMLAhwXlMm0/LG6eWmIkqtbLJfW1Vod1+lV3PwNAjh3R?=
 =?us-ascii?Q?tZbB1NAINlLWhpBfAxlMCyOcSqqIQlTGIm4aUX+C4skX95TIoyy3vYncbHPi?=
 =?us-ascii?Q?Yf5I3FF9W22ZCbzN2BaujHYaj0mDGEasFtSbhf4UUI1SKGy1hLNoBxXwzmAX?=
 =?us-ascii?Q?rgvjp3Ug/iKZf6lJhJ0C7OGaSogVgWWLGfK1pBcfGcfGMH6WSiZDr9AXllIJ?=
 =?us-ascii?Q?WLlU1G2BYGJ+Wu4fxp2QZnQ1wTDSBccitJBlseZh7n9Rmi6FfUVtBTN1/NJw?=
 =?us-ascii?Q?exLEA5/vl1b7jVz6nzNEuAWWQ3+oC0lWtZrYWsnlzjBvuaeks9a7O7WCaoTU?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ac950-d723-45e9-ea98-08dc3f02f203
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 00:01:46.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6DWInFMn8z0WibDf6vLwxSfof/8YaHVeEbxkFoLVwU0B0H/OIHEqqwhnEk6uYyne1AMLKNi+l5XPgrxrf0yOwDeW4ajIgo8+681TwhUruA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/6/24 7:53 AM, Jonathan Cameron wrote:
> > On Tue, 20 Feb 2024 16:12:40 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> >> When the CXL region is formed, the driver would computed the performance
> >> data for the region. However this data is not available at the node data
> >> collection that has been populated by the HMAT during kernel
> >> initialization. Add a memory hotplug notifier to update the access
> >> coordinates to the 'struct memory_target' context kept by the
> >> HMAT_REPORTING code.
> >>
> >> Add CXL_CALLBACK_PRI for a memory hotplug callback priority. Set the
> >> priority number to be called before HMAT_CALLBACK_PRI. The CXL update must
> >> happen before hmat_callback().
> >>
> >> A new HMAT_REPORING helper hmat_update_target_coordinates() is added in
> > 
> > REPORTING
> > 
> >> order to allow CXL to update the memory_target access coordinates.
> >>
> >> A new ext_updated member is added to the memory_target to indicate that
> >> the access coordinates within the memory_target has been updated by an
> >> external agent such as CXL. This prevents data being overwritten by the
> >> hmat_update_target_attrs() triggered by hmat_callback().
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> >> +
> >>  static int cxl_region_probe(struct device *dev)
> >>  {
> >>  	struct cxl_region *cxlr = to_cxl_region(dev);
> >> @@ -3081,6 +3151,12 @@ static int cxl_region_probe(struct device *dev)
> >>  		goto out;
> >>  	}
> >>  
> >> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> >> +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> >> +	register_memory_notifier(&cxlr->memory_notifier);
> >> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier,
> >> +				      &cxlr->memory_notifier);
> >> +
> > 
> > Check rc?  Very unlikely to fail, but you never know..
> 
> It's actually checked a few lines down after cxl_region_sem gets released. Probably too far away for diff to include it.

Why does this need to be done late in cxl_region_probe() and not
something like devm_cxl_add_region() and unregistered in
unregister_region()?

