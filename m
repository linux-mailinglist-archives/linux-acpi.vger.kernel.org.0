Return-Path: <linux-acpi+bounces-2601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4085981D0B9
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 01:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80431F234E1
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995218A;
	Sat, 23 Dec 2023 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvaMC8F0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B217EE;
	Sat, 23 Dec 2023 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703290362; x=1734826362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H15xCqY/fkJirWbagXmNbirYxPmnjITP5ElOMJCHYo0=;
  b=NvaMC8F0l86vDGHdIliOrDtK1v1xr7Kq+A5aRX8WJV5Hx35kfeJd1lp8
   JfSdpBgpOVwYAGS5Yn96KBTtqkMH4fECjnOBEHDVZLMfWrquuYzos/miB
   M3J61NwM1AOBigIhVPxBXupiw+wxKW9u1pC5WeMXSjv0fcBVgTIV5PgN0
   nPz9UDqNFM5h5wX9yVXarO58ADTMmy1p93LHZwCAMkPLnWWmxgZkZi68S
   jnxhZBj1B8GPZ4psmS6PIVWZygs+r+Yhemzx8jykxZBnMTw/eT1hD9kUO
   PfiKQa0ILG/zgChaxbaMmasUC/4zkBhBZ3ofbaqSNQzCmeq6/dGL4/0rZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427333217"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="427333217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="847641672"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="847641672"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 16:12:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 16:12:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 16:12:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 16:12:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh/wRTk/kSZ8qjgr3cC5YjiwmOfLQa6cCqPCfiU9yTQuAehOinqkIYDOJLcuzJbODf5r1Y0QvU0cVpm1QTL2L0HXCrqWXc5GVQFUu+LoXUh76iT9VIBKMMXciACQslBjgoj5lZ+7AFInse2HOYaaE42Gv6OjyEHyo4c8zpZSr6FqfghqHHquEuWO0Sb1UQPfCuU7zbwdG2xFOjGiQ1F6TD+3rp9ysPTuaJawiAWy0yFXe8hRxKCftR2GPkBINhnLwMY/Z9eXZmjhYoMeaxRNQCc1+a5ce/rqx41MxPxAehXYOoFo8zUCN8GEgFGWcCpCvEA1ETxcsz/2tTM1m5zVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HmzyzF9dLqZH1Wj+jnq82VMEekqnXI0u9optY4H93c=;
 b=Oo4QdGnUTdt4IMW7X64Ic4A0hSzyIyzDFEA/itV2OVEV9xWaCLUYmpRjS6SO7Z0WIoVIDex1RjqADA45U+PfnbounlPzoobGOF3snUHuvOv9yIquogi3Lamj2S62c8CGGF2i+sSVl0TRTBZp5E6IwvMa7ehtHGSVmRg/F61joi8X/UoJ944W4WVm8AtpybpukYp7vbHeqepcxGSEuzboVq31j9SNNhJFctJxo0vKCW8xHLiGWSQJKmpA6kq5dKIMxfUxlR40aaSxbaP8LqnrYwE8jT9zU2trsBVtTks5DvMGw3dOKIVQyQobYJqsIqL2Pz/mIkBnADHbgmL9k8ywkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Sat, 23 Dec
 2023 00:12:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 00:12:38 +0000
Date: Fri, 22 Dec 2023 16:12:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>
Subject: RE: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
Message-ID: <658625f3129c9_2581a294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231223000025.1401076-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231223000025.1401076-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de6daf8-6c0b-4b2a-542a-08dc034bdee8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpuEYY5fbIu2RhmmvC2oA3bGsKPaec1DWogVysR21eLJm+6OPq2xUIIToz3cyLx+kNMlJkiwXEovjNHsi0ooByQwWrNoSGNmrGV84j7kt1g1316CFdZEVhk709HzLAXocu1NzlZi4MVFDj4zX4V+3agMPr1w27Aq4dACGufc1JqHME1nuGAt0eKZEYwZL50bmSl7uRhmNDeoVfXrz0P8ZJWg/KFGVlThhC0WxRZ9d6KOXWGh/NjUvRLJmKVKaVUA1HMsIkl08mFMNEh5Jc+kV5qVR8RUqNKntQsEYpLNkHV+wXaLhaZLCjzEurW/+uSFwEpSfg1TfwENSDlCF/YQlRnhC+/JPjKlxiYsGsS5M2xUbnluxun3Pis4t6RQNrDpxHt5n8G3UBE3ksb5pipqZBif7V2XMch4moj1np1NudGI5VV7nKn0ZODInz541Pn7Hxrseu9UYeY/i45zqRVA8xKmdveKV1AkJd505f3OtborJ1KnBXi/Gdmp27HaIe+CC2UuO8FKQicDdJxicpmnflHqTDbjwmcAwbHo6E1dyIHljU+wjhpQD7iTslteq6fd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(82960400001)(5660300002)(86362001)(41300700001)(478600001)(6666004)(9686003)(6506007)(6512007)(83380400001)(26005)(6486002)(38100700002)(316002)(110136005)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oa4CDHCBJXzC0s4guXDDBxnE81qOXWwt/kCsMDhNDkxAo7h7v/01XIRx6GgL?=
 =?us-ascii?Q?ygUlWtVv59nqpID+LyMgvTy4uunNGgycHq081yH9vkKatceEwpEAATTdooAe?=
 =?us-ascii?Q?s9Dfm05/zegisbkw1sCaiVRPr2fSPs1JgZHobp6mX5ZbVcdki4k1MBb1Tpf6?=
 =?us-ascii?Q?Z/j3UatKzHGY9M5ywkIqp/YCxBdFLakzra+l6R0oHjoQeVIZT3nAbN4yQjQA?=
 =?us-ascii?Q?p+hDxB0RjvHAvGErNucOOgAWCVrhpDhPOlz8+eXhFhu/yUQNAbWKZJdZ8biC?=
 =?us-ascii?Q?8BT9jChWxITxyTtM/aB3qtxRep2bJ1RLVuMSY7tdPwidScnISQ7wSa0NiXWf?=
 =?us-ascii?Q?2VnPcaF3aroyI/z692jk2jThO4FYke6Q5hUUJkQhI78pVByA/zYLUk9oWbRm?=
 =?us-ascii?Q?Mu7I7PhMYnNG1YMrX//PrddDkz2upJW6uem5qTCFDwR/gK84mxRstdnBIIPN?=
 =?us-ascii?Q?CMsGwCk14HGvrgMh8MNDbnX/zdhe3OoyyAGoZt+c5mEhEl5YajT2VkcPxm/8?=
 =?us-ascii?Q?90umheRyALdmVawz0K8eUcDr9MlKWbpMUvzUUq9sNqvd6l2vUEcdNS9epYK0?=
 =?us-ascii?Q?1fTqOxQQaaXg4DY9d17XoI6yMcOyKIOOpSLqp8j6aQkVTL7dPzx+w1rRaKNV?=
 =?us-ascii?Q?JsClisNxlwmVUfqwO8RoXmcoPu4r65L/30Sv+L8xweVk9ZNgGNBHv+N/ppD5?=
 =?us-ascii?Q?ZZ2spOMvn3yLDwmBMiFJjUY10C5UDEbE4EBS1pNnEIedxAr+ljNcwIkmIXLr?=
 =?us-ascii?Q?8X8XUHSmIsFccssx5swsN4kbMbCBVJrC5AZdEZG15CCybr4VRsHXUYIlkVF5?=
 =?us-ascii?Q?qtXYDuBoM2A7zd1QzMkwwN0EtP0LLxYahxx34XskGlRx8qd2w7YhOm16rjtT?=
 =?us-ascii?Q?H/HalzU43ZtO4C/zk3y7URVKHJ2oDYNYh6z22D8k8ta1BX9rtTEGsGsz73bW?=
 =?us-ascii?Q?+Il4+aGImcl2rWTY8wE1SioP5Lv9rcCz4TV8/SThKTsgzZKz+UeWQZ1bsxq7?=
 =?us-ascii?Q?wvlFqwolue4LiMjWIMZK7iqfMOwMoPKK0MVjIYblHxcGxo2fj4+967UOe4yd?=
 =?us-ascii?Q?4Mb3ZnvIezoAvJakqblNwk5n2Tvi2pxtt7M1lNfVJTR/xu/qbukAcqgh9LzH?=
 =?us-ascii?Q?kjNYFURwMbu2IJSUnztBw2JcLAVt0ccaQbla1b5bEIiSieeJ6lXwJdCBcyBC?=
 =?us-ascii?Q?OQxEbl7BtKMSUrRGSVpdGIVW5mUEK7bfQhVzshvup4jE6Md9iWZSG3w5ZSKk?=
 =?us-ascii?Q?avKtG90hBnmdgzjOaF9ZpdjFHfxnlC5mg4gAqaESRDFwL7W4r5SJcKwfPUgj?=
 =?us-ascii?Q?kU+JE0RxU50PUfLe9vclj+ljaov3Ly35QLhqNkv0e1wAvsKTU+Ogha5yv/ie?=
 =?us-ascii?Q?QrAMUFKeez2/0aIvD+fGkYNoGgakasc0o1wTuoxIcsO2ID//d7jlKl1neekY?=
 =?us-ascii?Q?0N6niqltWZVuLy2BEV4Ij+x3Ucs+7WOCgqM7BJVzmR80nwHOk1AqS/4+ymtp?=
 =?us-ascii?Q?aDIEANSrEpclsSN6P6SdFhMm+gXmEbstEPsGP+sgICI3ELSnwpOIiTUN0NQi?=
 =?us-ascii?Q?000haV8c6Uf7OcpFA7n4ApIlAUCyyAQRFWVriQOJVDP3FmXfsbt769V4lMmB?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de6daf8-6c0b-4b2a-542a-08dc034bdee8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 00:12:37.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG8ESwkDtYUZ5qQ2nxLjHXLcytg/9EbROdGbrtN7bDFD3s7n3m8QVx15Z9q4320OGuEx5tXBjP0+mI6YbfGYd6oeUm+1eNwhRavrqM0nFbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com

[ add Rafael and linux-acpi for their awareness ]

Rafael, since the issue came in through cxl development I will take the fix
through the cxl tree unless you have an objection.

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the BIOS only partially describes a CFMWS Window in the SRAT
> the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> to fill the entire CFMWS Window, thereby applying the proximity domain
> to the entire CFMWS.
> 
> The calculation of the memblks to fill has an off-by-one error, that
> causes numa_init to fail when it sees the overlap:
> 
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> 
> Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..b99062f7c412 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	end = cfmws->base_hpa + cfmws->window_size - 1;
>  
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.37.3
> 



