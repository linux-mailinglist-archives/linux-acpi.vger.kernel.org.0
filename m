Return-Path: <linux-acpi+bounces-2540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69798180D1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 06:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFE4B224E1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89301129EE6;
	Tue, 19 Dec 2023 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XND4Wyrw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B25C97;
	Tue, 19 Dec 2023 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702962569; x=1734498569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w88w8awChqy1epo5Yx7tBepPb+WPVduUUBzdsdaWzIs=;
  b=XND4Wyrw/hPqOoN7Tdm7/pbtgmNxWHe6GyQxz/nE1W2Mja4m++6dMebT
   LYWtclsZp6CURsx+FmhIFGKswjl66e40PrnzokUrDReTD1mGr7y4ISFTh
   BKl/Gqugi5w92v9/wqfFrBgi3kRISnXxOQKfyWrIkMt1ogwZeFUvIN3hj
   meMbZcNONeOXyvStMMkOIpj4xVTPkQMpBEG7On5QAKyx8fohbeIsa4i20
   poaJ2ramWbaFLpUfUih7yzxj5YOUB0EWANy1ER1JW8KpBBkYHN8/eAptg
   CLq/R69FMY9I+pmAWTWFmL9uZ4BZXl3TXNlfdqhPgd5sJzPF4cZGzxJS8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14297145"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="14297145"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 21:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107222933"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1107222933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 21:09:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 21:09:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 21:09:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 21:09:26 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 21:09:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkQ8/HSe1RVLRBNgO85YN6glgIIi41ux91l/WjsPx6PL6PA9qKXT8wkbKbgUiERqLAmDGBY3PAYKhIBAZgeuHOIC3x54BEuemRPZC4xMafQ80lth2+OsDBdHl4t+wy2JS8CnJvZKWdWzBWN4Jlo32YvH+T3oQQKuyazqGghqqVXzese+Oy1qPIA7PUp1e9tmhYcLXWLlcG0oZRbXFge/LQRqg6lN6FiX4zwab8qhl3fPG1GWHfmPQgmAv1cldC/4oxcIhEN0JdpXZFE8/K0VwkPRMCy5wy3xw9ev/a82KamSk+UvOzVOB8oL1a6z0M9iiuUEmRt1XUotwPKDVwPC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udrc/i4BxS6XmdIDhFeZvK8tJXNFw2oZF1FZvXfrSZ0=;
 b=HNOLeayi6kqRz7NL032NMjjjmMaTeBgfwNOT5VdmHD26N4JOrmUegjHVl6MgzVYCiMcZQEY4+d8tZQ9Uio4xNam3KWvJu7JAQpWK5ALLxSC9cQqphRRXdkxy6vbwl2nlB183H8d0HsFPc6o+hzX6JbILOPgIZXG5/rWll1LtCGCaDfd3ce5o/UcGmFFJq9VyIiuOogf2TeBomezJS4oYuapBDJ9v5F4u47Wq9rKvgNmGFWFksNy65ivqtoTte6fx66rR4taH/IPfWU6vL7WmKpCJWz8aQ6sXHDf8rqof+YZe5ybMllnBsndhB3sX1A5ZHJEaPT9Xdval+vgHxzJqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:09:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 05:09:20 +0000
Date: Mon, 18 Dec 2023 21:09:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <rafael@kernel.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	<dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v8 3/5] ACPI: Add CXL protocol error defines
Message-ID: <6581257c852d7_7154929433@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213223702.543419-4-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e29697-55ac-4bc8-cda2-08dc0050a7fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WzC1f3Efj/1Liu0+cQMRmhGe8JlLiqad9QX0PYZa6jFAWFr2ocuTrXSIbZIDbMUlINlI9/nx5eOkb2v3iIJJAwlGXtOxqQ1/UvapEuKSa56IG31qhdJIAPgDiwliCGFLCbltshMOdhCijvlaLVq1+Mk7lYF0NfmkaJQX5tpV0J3gMDHmRpFTXatIcXcrMnuvbJ5ruN9B7ihWeX5r1QHn3AMUCkSzpF1IPRlPxgq0L/LWOxfvLr/FVbYLpLH/DcxO82kaTwTRZ7up6Kdit+m9sYJNkr3Tc8BigvI69B3gWKuUPVQ4fyrecW53Pvge4vTOaWZlY0sH9XbDBhQfxWhhuXAz+40A2TZV8p6+rld7lmj+S5YWjnFRprwqUU9iYH6ZRHtLlE6fcuWVzfDmttF5UVIb2w/FHsomTOSMr6iOWkIqmgHTNlzkUnAarXatt3meY1BYFAt4sg6KS/F45w+iQjLGL144BODyXwbSuG7OZglLFpXkJ9smfOYFIN+JRsNqzQ9xiYOG2IKPOVCxGevZU+penPlQxTKdLzmDK88IQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(9686003)(6512007)(26005)(38100700002)(4326008)(8676002)(8936002)(316002)(2906002)(5660300002)(966005)(6486002)(478600001)(6506007)(41300700001)(6666004)(6636002)(66476007)(66946007)(66556008)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnzEeh6NfF5KX5Gkf7mVTewNOZfNAD19KlI/5d86ApJmpuo1mQsxR55u+w3L?=
 =?us-ascii?Q?v0Wb7kAtY/LmjCrIHNcAHJoQWp8KdUg67lwZRswHPTWYQaP+TZ7fgKevhdiL?=
 =?us-ascii?Q?Y8wuGaJcz2+FIuxnl5+LQg1z72HKJdi6+iI729bQTLZNEOI/1GSDHOHcwwf8?=
 =?us-ascii?Q?W40nxzlRQSYwDOzxM+UmKAEnfOS0AcA0P9xp2toxc3hpzjx3ULB+Ue293mW1?=
 =?us-ascii?Q?+aYB41mH5ZzQUlOQDxdLy7+0JRcBcANNcT7ayCx1pZBY4LafGxJKqrMSJ89S?=
 =?us-ascii?Q?WEIh++gPpijo2Eu3o4XspOdYNzbLCap7JiQwOqstOR0SN3wSfwjGsM95czXT?=
 =?us-ascii?Q?C1a+fWCKOFHW04s30L2BFkNyRrafas6alDiQJhP4YbJjHZloslsq2eDJ4xOA?=
 =?us-ascii?Q?pualbuQLMtZ5LDZs2+TyDa3lWj65IMzIEReMGDptGOF8vQX3u8ZvQi1ym5+e?=
 =?us-ascii?Q?QTGco3J+o8LiVjaUu/s7/bBGJuk7KdDAIHFGwJ1kzpnOgjdmwSInBzbDEU/N?=
 =?us-ascii?Q?YjE8d0fbH2oorNRglHGAJxspDiG2aW6+iNa+pWWdpAkJHgmG48/Z9sBox/2g?=
 =?us-ascii?Q?13Tin0SNmX9rrtB1qsGzBlsY7wKyt6u2/ZL5rYFXGxi9gyGmoHdUrhXSInip?=
 =?us-ascii?Q?Zp0aSjJ/PWBfGnnRckhk7/nj5uW9i0bpLS/DNPrFq9yoDvp1vR4QUCKuKWND?=
 =?us-ascii?Q?AzVTT9cPBPKpZtFwk2bAspXp0PTeV9iCFGXTiorymSdal/3w/nEeQkkBV4ZU?=
 =?us-ascii?Q?Gu/IX0E5trWZHkyvUTkzr5AigJw1hFRTup7E6XanQe3azO9ASvW/8ZbVx29G?=
 =?us-ascii?Q?50BuZTrWltDdNYlKpU29EBAGzwy0+bub9qLIvoXCHhHVIg44PHbPt6QcCFAe?=
 =?us-ascii?Q?ed2KPlyu6Kw9hvvMtNEg+/nfbVO4YLU99AgSBQwO6yRpRoiQpm3i4IQu9llm?=
 =?us-ascii?Q?f1MY6hAa087XrJxQIYn5ruv+/q9mfjzMoJ+9AHDqRfsjBUREwKK56oSlpjwN?=
 =?us-ascii?Q?4vTlt3mZnQFZ90M/9TZUC6KaAHaUnePdyAxQ/TDRQcUSo9Vungjf4eZgooTN?=
 =?us-ascii?Q?wB8biZsxuXAWuKyE+bzKp33cx8Ba4xUK3hSYalRJ1obWkOCcfVIr95eIb1Ej?=
 =?us-ascii?Q?XNl5ary0WC7I053IctZFTldlLoswEmLaWUaI26KbxqayiBSkpv1Qj3bS0psH?=
 =?us-ascii?Q?IvLbk8HGZ3k4cCfopbC0mQqGsX/ZP02E3w6OnGFvdL2YTsNIhcgfmDfFvM7Q?=
 =?us-ascii?Q?qL2KSwrg8pWkGi8uvnMSF/DttbHjC3VD+lJP62KxDt7+pKBQShyYrYV+iWPw?=
 =?us-ascii?Q?lchi0Su20ZvPruwmKec3FYZs1RuhjBaRotk8QqxhZ09IxZIA0gIvhhaoWg/z?=
 =?us-ascii?Q?E7OEmY5xF6+du0L5mozISEaJi+RvUGQ4qV1sBe3/qGW1dNSHB62BkdWFiDGK?=
 =?us-ascii?Q?R9Gidewqokd7pqhkmIGj7kUb0LjQBGzkVW0LRmKAdtv3ovpFWeW89K8s6pns?=
 =?us-ascii?Q?Z5yhyKWmjSTDC4q9mQPVC7HQGn0t9qm8uMfTmgRzG6LUswuvfhNJwGc8744o?=
 =?us-ascii?Q?Q/HSdIZzPlv/na/CLz88XtKBrAgwmpQpdLulK3bHVgj3bhDprFyRwM8+fW4I?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e29697-55ac-4bc8-cda2-08dc0050a7fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:09:19.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE726JyNIHbv+dkVubxr7B3FhEnxO5n2xA3Lts0MVH/nbMugVF+IN9Zy/apbhmBlixE3qmC2WFukvCh/U7Ud1rCioycvH17AXeo5fS9kD9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add CXL protocol error defines to include/actbl1.h.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
> 
> I made a pull request for this support in the ACPICA project which has
> been accepted (link below), so this patch is temporary and I expect it
> to be dropped once the kernel updates from ACPICA.
> 
> [1]:
> Link: https://github.com/acpica/acpica/pull/884

Hi Rafael,

Might the kernel side of this ACPICA update hit a stable commit I can use to
land this topic branch in cxl.git for v6.8? Alternatively, if you want to take
the whole thing through your tree with my ack, just let me know.

> ---
>  include/acpi/actbl1.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index a33375e055ad..1f58c5d86869 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1096,6 +1096,12 @@ enum acpi_einj_command_status {
>  #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
>  #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
>  #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
>  #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
>  
>  /*******************************************************************************
> -- 
> 2.34.1
> 



