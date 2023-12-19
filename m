Return-Path: <linux-acpi+bounces-2539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C58180AD
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 05:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB990B20D5C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C50129EE6;
	Tue, 19 Dec 2023 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcbFWjHA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EA10E4;
	Tue, 19 Dec 2023 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702961231; x=1734497231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JJdwh1iVLFXMmU8ymsQG54zV5q9wp+7ls+Sfz1fvyfw=;
  b=IcbFWjHAOrjBe4c/YBF+9SNYWT8d0pN8f6dy2L4HcQFNFeNO0GVlntFv
   e+m/l1HwO5iLknexYcADZ77iTL9TEAifEqWPAN/G4Syq3/KVqEaRqV5la
   s5ItefcTRBdAUJSpBM1h+mz8SfckRdCzYiEU79uNWu2GUuZ1Qt2gUiBeQ
   tKyQo0SXfZ1ICugxLDN7ic6Dw70XsPJbN8TiTs32AMUyaEQDNdkTVUNQ+
   0GN1tmqDPc3Gg9JkSQ0wgQaydB2n+IjFvJmQqOYU6OGo1W1o03FL1oVsc
   SXaPW4p5OP+soxFM9XXsDgfVs1Dhi/wiBWyKvQWLpCJ1Ev6xSShTki0mn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="399441178"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="399441178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107217784"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1107217784"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 20:47:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 20:47:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 20:47:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 20:47:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GymGmeYpM0dVayg1J8F9X2WQEbr3S8USh1Fk/Hq8swFXt2ZtwqQEHUJPLVGvhOdTHhmDV7vIhKWKbNSKO80sU8u6kvqL9+m1Nm+8DIZ4O7vZ7EBN+cSr9hjRD1Oz7f2kUUeAEtVW3sG29hYpUyIaXvIvtTY+LOC7auJavoIL7Rx86v1sakxhHfxy1YZZvHalauHZB1T+dxD9jKAXjFJe4oubbWat0dZykj1gfvVTaWuvr7FEni/Xyn/HuG89DypM6ouH9ecbrB1YTZVZb0GAKkV/8auHVe7QTzzedvoqdUitvu2tci+O0D2IaV/S8xk1w+UzX/AOhLkQ/qi0PP7VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isefB9Cn7IKHbY2n5GoowPIhoWkwbb7UZaeRqr2/blc=;
 b=QhgQIzaSOaVltrK4mLlQFjFKsGncy5KR1jlLGwVh7JM0LosPdoR+JEiHVsGEU5a5E7xmrLl5leBKcudLV3tBRKDaGMNjTNK6U87hnt9Ma7FqfIcZOIq6j+TT4DtEjOzAijdSZ5COuDG/uhr4G/R0Wc1dgyMK+ruv2Bfcuu8+Hl1vbNqB+bc1Txp3gRS43x/FsIRsFSTFoDaTV8Bx8ZZr2Vc76ZbmaQ0pFmrebXUUP9MMg915v2jH7Rw0C9FGPt38+7LbSa+rJCVOCC0CFv2uUknOzTIJBijXtiXWzXymyVoYl9DBpZug97CXjLVW0T72TpLR+1+tTA84zM7Duu76aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:47:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 04:47:05 +0000
Date: Mon, 18 Dec 2023 20:47:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v8 4/5] cxl/core, EINJ: Add CXL debugfs files and EINJ
 functions
Message-ID: <65812045c086b_71549294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:303:6b::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 66577796-9726-4499-898d-08dc004d8c57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KB6nj3+wsVI0suV1/+Zm/H6mvIUA8oPBQcQUvvW7Dz/qSyOe8DWE8XH4hH0BU10YZyvPPwqSIsZeJIQ6HUlEybOMSHRQOIZcGlmF/CTOH6GQStkqTY94d5nXEZZPXD/c0BBccoNJWRsFbU65AI5IWF2zGmPh1fp7u+CO1HfrqwQ0id3fVMG9X6Ma6EaZ4G7Uopyx6MclGx53XLsWeprdiQBYxtWAPwj3+fG99Y9MiJ68a7Gstzc85X74BJYtDGdxtON+OrHbu2k0HfEL8U26sH1DDlGOe4pzTF8rUJ9IEzfJ2hRpKuir2UIMJbMbpybe0lD2vqsHB0+LWyzv5hC4zPqgEz9q+sHryTK4a5XclArlzKtEjORq8Of5Oyii+QdMV63mOsrpgPZp3evRwiXR292QnXYvqT75L+cXcPmVcsJ3iLFA9czVmzfThmwJ1JVt5gBL0LRLmZIMcBtUA76RFDh4YJDQCp4O55+v8x9jai6bLiLxAy8+5Li//0rV8/shgodUJpLe8732C6ol0DOQoQDlwZvSwgddOWoxijwCRGkaE3P9WJGHCvslhd1n7Th
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(82960400001)(86362001)(38100700002)(30864003)(5660300002)(6512007)(83380400001)(9686003)(66946007)(8936002)(8676002)(316002)(66556008)(6486002)(4326008)(66476007)(2906002)(6666004)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRLZyNgpZjt3p54lj20rRiaEny0vIny9p5nU8t7OHJxOyxdzzL4fZv4MbKYY?=
 =?us-ascii?Q?dolpi5l23n6GptehwmFUNZT3Dht1U04Ud57pQ1Q3cRY149Kx3A+Qq8H8g3vZ?=
 =?us-ascii?Q?oEhRbhNk6cV9+K9aufmx/+5X/YAmvkcaTFsByuaQMp4OUF9vZb7sjlno7uYa?=
 =?us-ascii?Q?dol/gNgt1XdnXjOs1oUoW7Md2LcKYxdidQJoj9xjDbY1Tzciegr9AZmNgf1Y?=
 =?us-ascii?Q?vJh/dC+aA3Z0GGLEFc/OcidQ1p4/hzP7uzj16r+l3kzD4u+sjopQnc1fM7z+?=
 =?us-ascii?Q?/zZXgZDySF+80p1sc8OYldBTpQHdq4bf+WOBzg29TQ8r/bKRtC8/9pKruHEV?=
 =?us-ascii?Q?tu+1gxfz7LkrEa++S0FeGvZp+SHSVbJegXstzuSO+ktBKx6F+tunuoLrMnUe?=
 =?us-ascii?Q?EzKeEtpRdpyDMJd3UCDcozwlq1rJu9IM2DkHp2DsVUDFEFilgTkze07mDvW1?=
 =?us-ascii?Q?I38DFOg7ZzS/SiDtb2Hqdt34N6DqkcS5EdL8YkXwZHv900OmY7WHaDMgSUnS?=
 =?us-ascii?Q?ojdHu5QA/Rw8bkn/go9Iwp431J3/85RlVb1jIhErfLlRGGmtOtO9+OBzMb4w?=
 =?us-ascii?Q?MorVf6VblhtAk+Ki/YKGhNMk2OwxVEys5kmnUsDvrz3lWrPwYBTtSQe4ORHK?=
 =?us-ascii?Q?3Tsjzt4QfEPOA6Cqv7b41kL5a2tlzwjKb1ijZuHz1S8+cW2lw9tPskqa4Bk/?=
 =?us-ascii?Q?jVso3d1RZXoxWk89IH35tiPEBuRe7hrP7/jwbjoSncy6BnnaNgrrmR5S2pqz?=
 =?us-ascii?Q?6tDDOCGYloaDJFhaPKBArFl94qznwMceSiAY4VXPg82L8w5ItjS2iCl8rgcF?=
 =?us-ascii?Q?bmopzC0tL98fqOr2ET7vh/hNvLLqRQivYYvZi7A7mFIVRjdcJsD4Gl3T8gX4?=
 =?us-ascii?Q?9jAuT/Mrw2itanVz3HmKBznGMfP2BijfamFDgC70g8B0iMZY+hKeCXC2+b5F?=
 =?us-ascii?Q?rXuh+i69rlr4eWBj648tiVr1u2UN+Epf41ikc/Cg6zztw1mxCcXSe+trwaRo?=
 =?us-ascii?Q?3PcGK7Q/Tmtb26c2sMqgkXyRluyuSQAGMhzWGjEho7jmf5wfSPSnF03KArlG?=
 =?us-ascii?Q?9Mcj8ytD6XrbBvMcdzrgm6yhBG9m/7LDHCvxLRu/pAddR4/DR34C3eSyQz/J?=
 =?us-ascii?Q?Eg6pA3/l1hzaO9Qpc3C9YCA7HC/jL0sgvYb+xJ1gxQZejcIbS9HfjjB3dg03?=
 =?us-ascii?Q?ZP/g9RKTot+pm7cWy3yXAWJzY3j//2zv8Z3CAQubjvhV4m8mZYmHNsrtt5H3?=
 =?us-ascii?Q?fU0YVJDuj74WqErqnFpsDHHwmKIIcqUxMPSCreZA9wpcrp23st0pxFJsGVWJ?=
 =?us-ascii?Q?aUe9e2FHOxi4stO/XH6CFVKJCwR5ZT9qxtODZuwTUNqypobmKJGw46JZtIPm?=
 =?us-ascii?Q?ZN0ivhOobl3iUl74N2uCYuo1cA5KzEqHR10pzU3JqyzVSa6Gu5cHDj44FhBd?=
 =?us-ascii?Q?SBTftP7n2562WmY6DF0vs1Z+GZawJvI1vL2HFpJkoWCHKQQZyCjOpsJyXyO7?=
 =?us-ascii?Q?SxhGAIwvfkrtpTSRsyosaWlKayM0dOvRlFukfBD8iRUPGJXP1JdOLXTuO/fC?=
 =?us-ascii?Q?K3CNIiGdAVH4AZzOoWtnceBgM4ODE3orFMktIrvAsk+d2C5kawogK7vQQYLP?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66577796-9726-4499-898d-08dc004d8c57
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:47:04.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEXsJgsnBy4ubjd7SZMBIgxDV80SQsj0X+EYvE2uJUFzesbWA07J+M0f78IEO43MqyM/KEq9p0oCiAGOz48mblIhne/rrhTkidhgDW6uWsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Implement CXL helper functions in the EINJ module for getting the
> available CXL protocol error types and injecting CXL errors and export
> them to sysfs under kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl |  23 ++++
>  drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
>  drivers/cxl/core/port.c               |  33 ++++++
>  drivers/cxl/einj.h                    |  58 +++++++++++
>  4 files changed, 248 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/cxl/einj.h
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..97a8684bad84 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,26 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/einj_types
> +Date:		November, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into a chosen dport. This file is only visible if
> +		CONFIG_CXL_EINJ is enabled.

I don't think the Kconfig dependency needs to be mentioned here.

> +
> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> +Date:		November, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into $dport_dev (integer to type mapping is
> +		available by reading from einj_types). 

Maybe mention that $dport_dev is a device name from /sys/bus/pci/devices?

> +		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected. This file is only visible if
> +		CONFIG_CXL_EINJ is enabled.

Same "drop the Kconfig mention" here.

> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 26a887d2a5cd..1a2195779b52 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -24,6 +24,7 @@
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> +#include "../../cxl/einj.h"

I thought this was going to move to a top-level header?

>  
>  #undef pr_fmt
>  #define pr_fmt(fmt) "EINJ: " fmt
> @@ -36,6 +37,12 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_FATAL)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -590,6 +600,9 @@ static const char * const einj_error_type_string[] = {
>  	"0x00000200\tPlatform Correctable\n",
>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>  	"0x00000800\tPlatform Uncorrectable fatal\n",
> +};
> +
> +static const char * const einj_cxl_error_type_string[] = {
>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> @@ -617,29 +630,44 @@ DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
>  static bool einj_initialized;
>  
> -static int error_type_get(void *data, u64 *val)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)

Oh nice an einj_cxl_ prefix in the global namespace, looks appropriate. I
mention this here because I don't think a later cxl_einj_ wrapper makes
sense, see below.

>  {
> -	*val = error_type;
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> +
> +		if (available_error_type & cxl_err)
> +			seq_puts(m, einj_cxl_error_type_string[pos]);
> +	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>  
> -static int error_type_set(void *data, u64 val)
> +static int validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & 0x7fffffff;
>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -648,9 +676,105 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +{
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	pbus = dport_dev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		seg = bridge->domain_nr << 24;
> +
> +	bus = pbus->number << 16;
> +	*sbdf = seg | bus | dport_dev->devfn;
> +
> +	return 0;
> +}
> +
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	param1 = (u64) rcrb;
> +	param2 = 0xfffffffffffff000;
> +	flags = 0x2;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> +
> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dport_get_sbdf(dport, &param4);
> +	if (rc)
> +		return rc;
> +
> +	flags = 0x4;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> +
> +static int error_type_get(void *data, u64 *val)
> +{
> +	*val = error_type;
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..4ed4a24138c3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -11,6 +11,7 @@
>  #include <linux/idr.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> +#include <einj.h>
>  #include <cxl.h>
>  #include "core.h"
>  
> @@ -783,6 +784,32 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	return rc;
>  }
>  
> +DEFINE_SHOW_ATTRIBUTE(cxl_einj_available_error_type);
> +
> +static int cxl_einj_inject(void *data, u64 type)
> +{
> +	struct cxl_dport *dport = data;
> +
> +	if (dport->rch)
> +		return cxl_einj_inject_rch_error(dport->rcrb.base, type);
> +
> +	if (!dev_is_pci(dport->dport_dev))
> +		return -EINVAL;
> +
> +	return cxl_einj_inject_error(to_pci_dev(dport->dport_dev), type);
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> +
> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> +{
> +	struct dentry *dir;

I think an "IS_ENABLED(CONFIG_CXL_EINJ)" is warranted here.

> +
> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> +
> +	debugfs_create_file("einj_inject", 0200, dir, dport,
> +			    &cxl_einj_inject_fops);

I will note that I am little bit uneasy about this ACPI'ism escaping
into the common core, but he mitigation for me is that if some other
platform firmware invented a platform-firmware method for error inject
it would simply need to reuse the einj_cxl_ namespace to make it common.


> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport_dev,
>  					    resource_size_t component_reg_phys,
> @@ -1136,6 +1163,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	} else {
>  		dev_dbg(dport_dev, "dport added to %s\n",
>  			dev_name(&port->dev));
> +
> +		cxl_debugfs_create_dport_dir(dport);
>  	}
>  
>  	return dport;
> @@ -1170,6 +1199,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  	} else {
>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>  			dev_name(&port->dev));
> +
> +		cxl_debugfs_create_dport_dir(dport);
>  	}

Move the above 2 invocations into 1 common call from
__devm_cxl_add_dport().

>  
>  	return dport;
> @@ -2109,6 +2140,8 @@ static __init int cxl_core_init(void)
>  	int rc;
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> +	debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> +			    &cxl_einj_available_error_type_fops);

This should be gated by "IS_ENABLED(CONFIG_CXL_EINJ)"

>  
>  	cxl_mbox_init();
>  
> diff --git a/drivers/cxl/einj.h b/drivers/cxl/einj.h
> new file mode 100644
> index 000000000000..b913763c3238
> --- /dev/null
> +++ b/drivers/cxl/einj.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CXL protocol Error INJection support.
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#ifndef CXL_EINJ_H
> +#define CXL_EINJ_H
> +#include <linux/pci.h>
> +
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);

See below, these should be within the ifdef guard.

> +
> +#if IS_ENABLED(CONFIG_CXL_EINJ)

This should be

#ifdef CONFIG_ACPI_APEI_EINJ

...because that is the module defining the exported public interface.

> +static inline int cxl_einj_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return einj_cxl_available_error_type_show(m, v);
> +}
> +
> +static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return einj_cxl_inject_error(dport_dev, type);
> +}
> +
> +static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return einj_cxl_inject_rch_error(rcrb, type);
> +}

Above 3 static inlines can be deleted, this section of the ifdef would
just be:

int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
int einj_cxl_inject_rch_error(u64 rcrb, u64 type);

> +
> +#else
> +static inline int cxl_einj_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int cxl_einj_type_show(struct seq_file *m, void *data)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +#endif

Rename these to their einj_cxl_ equivalent.

