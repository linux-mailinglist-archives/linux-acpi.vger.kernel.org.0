Return-Path: <linux-acpi+bounces-2907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDB82FDDC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 00:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979451F22437
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jan 2024 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3D67C6E;
	Tue, 16 Jan 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaHc9hRC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255567C60;
	Tue, 16 Jan 2024 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705449510; cv=fail; b=qN0b819mF93Vq/nGRX/Fo8X/76aGyGnSLU4/qqeQcwkhT88rG/VUV04XfVPaM5+iEIddZxwjVagnGydoErh3ocBEUPDxmtRh+kCHQ+4cyBk1PVA5jwlH5durEWuDwmwk1CLDpSoOE0+FEcEFYe2mJ50ErIe00GHIPAZ3/FhuvbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705449510; c=relaxed/simple;
	bh=16iMPfTVv6Tveu8JKmhcg8YMPBynaSjTghUkRft7eag=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
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
	b=EgqUfW5R8biEgub22Hu3Ya7HgaitnpcxF/hq5Id9r/PJCVEW8Yk/BqJZFJYo6GHXCwgl/+jGr4IwAqhyxWmWKmFCetJx9t30gmrQxOuZndLOfoWvdBDgU1i4lbhfVQU2euc3mdwB3NeEsLytj+kVxpsHWpsblWER/GlpqvNOl2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaHc9hRC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705449509; x=1736985509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=16iMPfTVv6Tveu8JKmhcg8YMPBynaSjTghUkRft7eag=;
  b=gaHc9hRC2QJmk4A+XBJo3Kjal6bObkAFHIMJRc//oWSmpR3/CyxT86/o
   WpVCwmP7Z9NNbgWpNLlvNldmLonwRPPoP+b3KWJsVQFkWrbQvCkK6jbyL
   oEDMm4xnoh4+CSuAiWasnuj+2h5QDtx0XQLD14+xG8Yf7wzuM1LawUxJF
   EZKvmz3tX3vyzR2dChGnzCPoibtj88Zwsbg2wkDEhPckti7hIdcja9IYv
   DtIHYv09XQhPaFBTcMDsV2pyKuCRcPxitun26JN5znqEmMRdqAIzdXT+U
   Z0LHX1Yn2BGHcxOLAWL2TkByi9s3uCXgjGqu9MKvQnqfZO0zIGs0xKfyf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21502752"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="21502752"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 15:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907547129"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907547129"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 15:58:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 15:58:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 15:58:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 15:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9Ced1dZ1v/WPC+k39+L/R/HYFJoD6rbcVQXI6WOWoY0RJiBOeF3eAfAddWnFQUCoIt1jhwiD7PUDxEWPP4GEJ2dtqH+RmjsZtE72mQm9yD3JDrqoyf/S9d3C1zJ0pUeqGxKschrdxwYm1coNOzqS6ONAukMujaftdno+dxK0xZtPshqiUSer0JmRLl64M6JsH3YhVVYbhrYY5Qvc1tJFiFUi90Y3UzzC5vXgxbhZUq09MUajNw94JPpArP1xrqHvlSpyXjiiS1DbY5B+lzFm3F8ttK4YuzeFo10HWPrQyESJJwo/GMRgbSwJMY9GdjClRzcsuEm2KUAiRUedNATdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX1+TsrXyjupysfET22bUHgTip+nAj1ZOO1gJXRpsUc=;
 b=Q55wCslWVtP3slKTxpjX5WmQWj9QwRUp7wjZzs34lu6mvKFmAQ+EbRdn3mSBCKI4BRuo25wjQHcMoRHsfPMNJAERzY/LFS0abo5rXBY6iQ2FoFd95mltqnI68UAf6FINyGjAyOtVxmoRxaZf0/IwzXSGO0IpI5gqvpDUtTSTSrAnd3TxCUdfJ0NKWcjN24yeWZRrA6foDpD2XYXnk9L4UJt7jn14fvxGI0AdMjrIJolPRHB6vGQQqHAL1/DguK6VC4UXpTL3wpt+HEWKuG+M+KpAcVupk16eYAzA6Sf0PkowXw+5RXLgFwXjpYO/7qLkIi7ebwM8j47vMo7rMNdgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 23:58:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 23:58:23 +0000
Date: Tue, 16 Jan 2024 15:58:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: RE: [PATCH v9 4/5] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65a7181ca92a9_3b8e29419@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 97152fc5-8cfc-4f97-1bf3-08dc16ef05b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5SUnwMRRMj16GJxcvsf+rBjn4hl8V33QknxAk0OLJJKBJL3i6wlUXMGLd5JKC4ZVE6Kh3avbVOpny6SHnPeawr4khNX7D25OaqeXgB0fa75Nd2RTLGZrJ9a4afnJZuW4j++HzM+d+V8zIWx4tR5ldj7/K2sPZaeIVsMeEzkyfwBet9puDbEELHRSB+FCr09grlmaJ9J4VgdJOFhm78ulz0HdYNF2ZwMmJ/9YaYFR8dbocAmnQ3EgrYOh9aysWHdHmzndo0Zj1RgiI65q+H+04zogqd/rlMrbs/EJNj2pPkKrlV90tQTKacC0QgkRGzfKQ0+0mGIRm3mvAmime3vwrXgaRK4jcCoZHVCbltmcIMLP/jyC0KCS2RZ0K139RC28/r4DoV5Xx57lTuwxCwQL5wyJDqS3CU2zAzNgCz1jMfxxfypzI+HVUfOX/K20QqjC2mDlhS2ADVK+i70FBwU4upMbQWkdz0oucYJVAMTGwNkY/lnEyx/rRtR/tIgJXMak28ZAvBnqK1TFFG3JTTA8gEUsr3groYpvEiDawWLjCE/2ty95ZKdQo/du7kNNT4B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(38100700002)(316002)(8676002)(66476007)(66556008)(9686003)(5660300002)(6506007)(6512007)(8936002)(6486002)(2906002)(478600001)(66946007)(82960400001)(86362001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzOR5G7iv/+uZRdJBwxKFPCypHndmM/ZImoAGJKdo1srKRpMBvDqr5b2zD/d?=
 =?us-ascii?Q?ca3RjSURknCDdDMWJtaj1do0qbDR61mnBoWQaJaDE1W4KK7BYeiBSU0Q3Bdn?=
 =?us-ascii?Q?LPFxUCz70maQtA6ZqAuGWa7XBwvFoioQF5NGK0LLljsdTy0m9xFy7BTYQt6S?=
 =?us-ascii?Q?tFGxbxsvZ0lUlBFvReIGkY6i9+TWXTmMAVeYCTvRRvJ1yip9ufgngrJ/hKIS?=
 =?us-ascii?Q?ITSiIMUAIfICmMj37XBoioyd8epwS9XXbd9THddUuXIIRohDIy9zqa3C987a?=
 =?us-ascii?Q?BgBK/01SEe/UOJPioHEYEIHcxAGYjC7tdPvuDegHRIgq1QwnnruQ77qYpBA7?=
 =?us-ascii?Q?hfmWde15n8sgElvh28ErGs/9AIl9J+K6NQspfCUB7kX4osPnJdJ48mKyDTxP?=
 =?us-ascii?Q?W3TDZ1gWawLUQqvbg/EFEefB9PCDEL+OqUbSc5zNXyCloVsRpkbVUPglp/nu?=
 =?us-ascii?Q?BeQUnz4xuefPJhv2wbduskzGpw8UbZ5fl8Gf3q8j0avJZXya7Q56rEvlwIlD?=
 =?us-ascii?Q?rJcCP/YW+FLUwfPiUvrX1AcBUMffTESeWI3tmHJ8eC6l2yc+Z2cwpNXnbIzC?=
 =?us-ascii?Q?+0DHTUU05gkQ2Hb41IvXXyNsTg1XCq78XIQ6IjQ0iJIMYhbDs9A31BXX/umd?=
 =?us-ascii?Q?k5POo6v4KPyQiHTXgCcz0CHTx9T6Q0Xer3jfLs57vjlFRY45WLGqaP3i/qZQ?=
 =?us-ascii?Q?JPmku0KIoPiZ1+ZDL5pmA5NkxO7/wUGrJHrpJoKJOfUcgJC3sJh2Xx0/GlI1?=
 =?us-ascii?Q?PooxyojEsqPChicyt+4WNWtGhq/4mR9V/8rEjP78rYzKkSvbLbvoSj0007Sn?=
 =?us-ascii?Q?gDFHOsdidnmgOpQCsgfG8bufZSBM/znwNiL9VKpkgfnmmVlqmXZtKaWKWpk6?=
 =?us-ascii?Q?wjj9Nzo/PA2cSjwmVck4TwcvcdSjK0LY0DeqpjfuHzzSq3pG6FjyMzO4JBzQ?=
 =?us-ascii?Q?bp7s67Kdl6X/0gFCfyZsrHifsrNcUPm2o6jlj5/H5C5Uq8lbGcxpTu7SpqFG?=
 =?us-ascii?Q?FdyKOjD+KT27yAR8CrgUCJJtkq5Aj7q1GGuVlTYTD6O2R4HRHSEjwG729ND8?=
 =?us-ascii?Q?o6XERP2IvLkFSKh7EDfNm6FZNj5heM+N9MA64E2cwAS811+PMTlrcolFUAJa?=
 =?us-ascii?Q?V2aZCPUsWNMFSmuCP2SczD1ZOxNQ4jmKbTNsVyQTJaxHf9dlul+2LYB4I4Nl?=
 =?us-ascii?Q?mmGZoZJywxG1WGuwJ8T8TwcCv5VbRhlhWiQu7CPADO+8JX9xRjsTDKVdctJC?=
 =?us-ascii?Q?VULjNihmxYQfWjaIQQZRcVwZJ1mMR1MRJOIlL12XPBKYPQd6HJypY1x//WYg?=
 =?us-ascii?Q?AUJ1wRcWEnEij0Dg1uLo5MM7HWzVdC7kEUM/Ew8JE8Rvj7jpRoMQa5KMn/ty?=
 =?us-ascii?Q?WVObw9d3eIBCpy5bu0pA4OthV2PTeL+1EO3cLH6EnAeQHQwiiAo36gJTpBr5?=
 =?us-ascii?Q?57QhGK/9dScgARVAWKXkNccVN6yfiUY3Kbsqu+mcgGwVdT2XWuiiQ6DJuC5z?=
 =?us-ascii?Q?9+3xvrHMVKFu4ylE/BHw0FML5kznfzx2o9BYXsxK4tEmRSxomufKycQjcvQi?=
 =?us-ascii?Q?kOYapOxIsQJKeRxRajKxH0r2ZNIaY2df5bF761zaUClNPjnLQ1Gg4wLjS4o2?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97152fc5-8cfc-4f97-1bf3-08dc16ef05b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 23:58:22.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xjz1yifGVHlFt2Rrt9+B9lUmXuSUr4ssu5fJYQi0truiiN8g0CzUKizBM1rwS4zkoOLboR3/uLLYbssnc/sZVHjItiGL5/1QUGkkdCTulc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>  drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
>  drivers/cxl/core/port.c               |  39 +++++++
>  include/linux/einj-cxl.h              |  42 ++++++++
>  4 files changed, 237 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h

Checkpatch notes that this file likely wants to be accounted for in
MAINTAINERS. Just add it to the CXL subsystem file list.

