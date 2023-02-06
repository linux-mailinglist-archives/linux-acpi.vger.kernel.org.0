Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2827568C69E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBFTRX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjBFTRT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:17:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310582F785;
        Mon,  6 Feb 2023 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711021; x=1707247021;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zD4NA5M68CSKJHlo4Abokdb9aF9OdoyqTGG5kHrHwPE=;
  b=OEkEsB3S2gj3VIjPkvgUSa8fhZnRbfdc7FMBiJ+Z19nLJFNFy3f7K2+Q
   7pqzE9hd8c4Gijm/1BJbINlJv5HqvPdTk0EzpPb7VKkc64DM/2Vl511eY
   XId//dQGU3P8h5tfcHqHBArxq+pHfnvA7OBkqeGy4uGl4TuBjgUyRNEVK
   b0nwKydDfBrEumH6nEtXIKt33NrsWsOf1yMgpiT4hpghwNUoD3MFW1Mex
   DivPOmMCJi/BO2A2UhM4Lv39+GhM4iwQBErYKy7fIqU1xjC8qZA4SlpZE
   1YBvGQzrGqnXbIUhNg9fi+mOXx+uCJYKxKVF8QLwouNDbT6XyBJPcU26E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="326978630"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="326978630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666582804"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666582804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 11:15:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:15:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:15:52 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OutvO5jA0CdK/aWUD6zaL+nJdGHYehBW6EL0T2p8H6alvzZYBsq+qP6n+1O1iLBsIXm1HCW04JqYJCJgBEJ2Tb2PAfNIyUXuKm4tuduxb3IllbfFLr7COLDQYi+ofa/WJU3RsRvsKee85Wp375pLQjtIoZRMQaNGGRfCchQ34PPO3rPYuPaJqG8/I1GHuKBzpdARLCEKdNocJPQWFozq0rzIJlCXHK7OKG/Te8P9lVrOvwtZE1p8HtyU7gykFqmZmCa1/eWCGaBatEeLYo3BApPXpXKhiIYf19WzdLzZoDv8LdUh8/AJ5IirvSWTyzdQPJIyB57O1GrpQWd517G37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7iBBADZfhsKP7ON7nyq/gWhtGufSCM6Z8jWooswcZM=;
 b=KDroAjyFAuU56PIj+qQrnbm9qBVj7RQ1p/LGCAub3GcsLZm0ixmqrotyUeeAVr5NCEBR/CIsN3C1ZVRPJVvy5r4nac/8sp6bPA1Bb5vFqXpGghrBloAgh+GPEZV5RjEXNN3chuxBHhcnO966RSLApS2NOgteOfAeSWjKZJHQEFjvAgFdzFwmt0dC+b3XDEmPox6Uz5/DHl+VKlNcEDQw3f+IKSmFsznXi/nQ03pbN34/qIxTJ1ANRso5XxNE6Nu6EPNRjM14YmqwgApf3ToIrqZXkcbP17PARfxjxRibg7WFOeDK241s/HVByGc5X5ls4gTMZrtOOQC0LvbBf7Gsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:15:49 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:15:49 +0000
Date:   Mon, 6 Feb 2023 11:15:45 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 01/18] cxl/Documentation: Update references to attributes
 added in v6.0
Message-ID: <63e151e18098e_fa3292941@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2963078f-6df2-4068-f9b6-08db08768e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeoOXuCvuBL1N07p+dBmXYflUGmX+AoF/7z1R9ImhSEWjDwTtRNC05ktC2w447pi/CAZCr1iy0PuhA8fPN1KoZdzjKPQOEBF68hlNz+cH5Yw9VjAe9o9xCgUskZ+O7NXjDye7Tnk6vv1DZCwbiI2wMRv30A7mj+tS/J1fWDaGAw8F4PNkcYP6QKFXOdqC54yUkLuBsSq4j/QY4Pa86qiyAUuLPuOp6WH+watVBpakttOESmTb4p6K5MLuhcYeUO5AcXclb6RP7B6MWLOAt2Ys/gZU34IqkI3yk/2vg4N2pjGDFlvLpUZiRaNx0PUSdQfP/z/x7RDz5id0WOCcLyH5APpx/YO8WboRrKg3q0MXTcFGh90AKzdh+aF8vXnsBukem/9v41WF6kE9e8Gqdfw4d2aozq5uewDf1immYfxyyf0KgjCiZZBh1VrGvfLsgVCEo87aNDI+hJf8ofBOF/5OuPpk94gL5K+AGzQRiMA9mq50YLH7/OQyD0J9VypM2l5YZT0gfLYs95bqFomPgSMTaZA8Kp4+JW1mGKUSNVS9dzzxPpGQhI89dRzEi5vVSp70FGW23q8YQUSrKQxvJZfVRC5lQTLqwd6vDasPZwhjRiyc3mVwHYvUwz9msVRebaYXxz3k8gRmX/InxyBbMxVLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(9686003)(6666004)(26005)(6512007)(6506007)(186003)(6486002)(478600001)(82960400001)(83380400001)(38100700002)(15650500001)(66556008)(86362001)(41300700001)(8936002)(66946007)(316002)(8676002)(4326008)(2906002)(5660300002)(44832011)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nr9X2oDYksCqi/5ljXzQLoqzGvLgsEJ5tDUg2iJQ3Scy4Ox83CeHqY993Ntm?=
 =?us-ascii?Q?clrRKTY71+iaw8tVVaaGiqpipa0O8TOkNiqgfhCRGsGOzX7ywHFsK83Y2KCe?=
 =?us-ascii?Q?VmNr1h+T6mKOyopdNgCy2APXDOdvTfSX/rgNy0pvcQ4Yu7snd0/oU/Aybelb?=
 =?us-ascii?Q?meatGgYSbiin+aD+wU4LgGvwI6KKaj00ONs8X43m19i82Qz1KQOq27xDeHCR?=
 =?us-ascii?Q?1uLxHNYscOL4soHgkCT7tpMTju6MSi1iufjIq4ZpZDbq6+gnL7ApnQZWaA+I?=
 =?us-ascii?Q?iNtXBbD2zPCBEwNfuHsYH0lUUaiC+h/AEeOudGnc88GQNqs8Szowk9soe1Hj?=
 =?us-ascii?Q?gnj91EZMJPXdPS1WbkYZYOFIqNWOBjSEe6reu3J0ger7vlACCm2moxrEzner?=
 =?us-ascii?Q?qSw9ZoEFMm/DzUV/XrsRAFtmWxIm/q9wAKi9LZ8m9fXkKh7K98Sj+U22QLKg?=
 =?us-ascii?Q?8U2b96eThWuKfyWiV6jiWpXqKxMqGnOQkOnras79mIfluOj5j8fuldPloXZb?=
 =?us-ascii?Q?j/13fPw9kKwgTRDvnkqRPEYcwTp08PwhR81zOqJuwOcN3gvpyfxBby5TF7CW?=
 =?us-ascii?Q?uN3msFsYtG221cXV2RJmub2+9xMILk3NECtnuQ7PbLVMgbpUXgtHz1VRaVLu?=
 =?us-ascii?Q?clHu67GXhMICVNOF/BofUFsOkdbA/SiJMm4i9S5u6ftDk6ifx9B8FEqPeFne?=
 =?us-ascii?Q?VJ30sVwLwu5uA0hXrHhsyt7KLDU4E/sNN3gwIVuwc0usZtv7w+uE02U+aY4+?=
 =?us-ascii?Q?MWGZg+yXfxwV11PRc0r708g29d633c0qZDCeD42y1beY/SvkhXHn3z+X2nKx?=
 =?us-ascii?Q?fESFBKUwx4IDtik0zY68f5eD9CSazf5UGdKeSxz4/Ro1kMqka+qJS4CaolyA?=
 =?us-ascii?Q?dlzMB5oAmIYfhb4COUyP1BYZsk01PaxGiZhXQ3P3M4nByZYL/2tOaght1/f4?=
 =?us-ascii?Q?sIO/uYmNJS3pwil/fPFAJfl8u5rG5bbXpd8vWy9kN5aHAfpJsu4x83+uYgGK?=
 =?us-ascii?Q?eEw5LKtxWVFpyaZjHp+3FZTleJyOpAMhMzs9w1dclAmQLA+7OuRzANhakWjU?=
 =?us-ascii?Q?24J8Hf2wUKcpUSXYtARgCfABBhtQH0d1i0lpgK1PRjY0gDeWEiftvhoBSvvD?=
 =?us-ascii?Q?8oH6Co21vCLYVLhB6OdITn+Pi3bscVtYTAV/NdzIQaQfG+N/c1QLg80deIy1?=
 =?us-ascii?Q?LTNSCHCMmGBtssmIZpixh+C+xCp6xF8KVSnPkp6Gc+8qW9urCus6ij7FG1/O?=
 =?us-ascii?Q?zYGhPTs4mSiVwxcyekh25uymF9uZ4hsHNK9fItx9BdVhZrQHe6FeTxUQrfnn?=
 =?us-ascii?Q?h3I+uDXSOgZSc5zrQX/ycifbpLl1RzbxaEbp2ERAMYTOeIYzfOiC2O1sqd2z?=
 =?us-ascii?Q?VpUsHdqfZfTGCQ53ALe2NKbcKnPZHe+bP3rlwg/n27dmFjug+4Xe47lVSqMm?=
 =?us-ascii?Q?IuAii0RW/VuYlsJkybzgxWxx1RtPdqTcZ9+qrCQhCT7UKTPCmLvlrX7utMcF?=
 =?us-ascii?Q?YAVa709yggsIMtbXezsy6e3QOZQUEcITL4SA2lS/5dfLdw3L/Yz+0dAz2EUm?=
 =?us-ascii?Q?obXuVLBWkyoRuneltFoNai1Vdxc5/1YePHE6UENe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963078f-6df2-4068-f9b6-08db08768e3d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:15:49.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLI7iHGxEyOBGN5NmtcIiu5Unhzz+coWHNKuHzHzAPnDpt9ME7bExX7zQGxKFE2d6YwBlwSoRnKEMBYljxmrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Prior to Linus deciding that the kernel that following v5.19 would be
> v6.0, the CXL ABI documentation already referenced v5.20. In preparation
> for updating these entries update the kernel version to v6.0.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 329a7e46c805..5be032313e29 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -198,7 +198,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/endpointX/CDAT
>  Date:		July, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) If this sysfs entry is not present no DOE mailbox was
> @@ -209,7 +209,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -229,7 +229,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
> @@ -240,7 +240,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -260,7 +260,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) The number of targets across which this decoder's host
> @@ -275,7 +275,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) The number of consecutive bytes of host physical address
> @@ -287,7 +287,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> @@ -303,7 +303,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(WO) Write a string in the form 'regionZ' to delete that region,
> @@ -312,7 +312,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/uuid
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a unique identifier for the region. This field must
> @@ -322,7 +322,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Set the number of consecutive bytes each device in the
> @@ -333,7 +333,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_ways
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Configures the number of devices participating in the
> @@ -343,7 +343,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/size
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) System physical address space to be consumed by the region.
> @@ -360,7 +360,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/resource
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) A region is a contiguous partition of a CXL root decoder
> @@ -372,7 +372,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/target[0..N]
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write an endpoint decoder object name to 'targetX' where X
> @@ -391,7 +391,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/commit
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a boolean 'true' string value to this attribute to
> 


