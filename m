Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1EA68FA1D
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjBHWMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBHWL7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 17:11:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61D2705;
        Wed,  8 Feb 2023 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675894317; x=1707430317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4cKiJvfRfYfZF32YooNjZUYVZWVc86I3Fz6d89tzLc8=;
  b=CTt9ubSSVhsffD1sh3DpC5QWdnWD7LwWXK5/hxQ6yGa/Xfjct8W+vz7e
   XhsQvJMv42ag58jIl88LbrGss4cEevWE/jJfJTn4DNPpaYEgf6tix4CGp
   9jLkx+vKzY7KsZzVZtJLD/UDeLKFHhrI/8M/uCEP4Qk9RrCF+O3dTIJGp
   OqQTKOHYdum5DWaasTswm/rQ4dD03UsQeKxa2jnM32oCh2z2NSFozx4ZV
   d2CFjxETgPCRDG5aQVmf7zXhpwFqhPpjaTmPDJrc3KqcGhWWxMHRd4VHA
   d5G4Tg+e7mYMhYh14l/K0PlRickgOcUg9TF3ZVVZfJc6eTwCJXD80ChPp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394532778"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394532778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756189820"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756189820"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Feb 2023 14:11:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 14:11:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 14:11:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 14:11:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBl61CJ4NcwlP7wCTo7Km8JOQkfDCWpnK6J4RKVp26YkL9KQwAKa8FsXUupIvE2EFQUCo1UyXLzGMraZZZQEwD/BS2ngcvIInFBp/Jxu4UGTLFUddrr7JXSgx0fc7DvTIwyjvY1z9EfDYAL8BskHGIUQK3eCmxA87LL2jK08rrYj0lc3nGutxLWZlrUfUre8hz3TjvHFCae81mjc4ftB5FBM0P9IKOHrzJiTINqdtkuZOR4uYjUKQUyiOKIbwl2EWlaukJbBfJ34V6NiAho/sHG+xS1qzwC2uMb7qNoC7z5XGEv6VtoYPZ2fR0ieKW8pU/s7E21Oehf+78YiU0KeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFqOa7SCEpNebDUzoZvoxzB7opdu0TNvwZqqnjiC+hk=;
 b=DaXBBuTS1+31HoIj+kf7WGUkh3clvVY4ebicVqwY2rkXAn88ACBpt4XPUMtJJekLYgVKit4L9uJqJC5OpwOhohehsPeFrT6DEusUHOCqMVvUd9WunKFcGT/06rvzai3q0zVWIYdhvh+ln6bEpzz9ezEomHUV6bmP0w3XZLzBiOkBbB5vvaPGzOE4GLWzuhA8sT384aTORVaZUBQauSYohkMbgFvDJTdBFv6rLUIV8UGBBIiHy1CcUpWtSZCoTWfViPNMZ3vwCNtoasxQVwOxpt6C+xWJxsODDqPXfdE8w8klAe5gtyUy63Z3RMW/NgvE5JbILtEW/c7t4+k1v3NnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB5700.namprd11.prod.outlook.com (2603:10b6:208:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 22:11:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 22:11:48 +0000
Date:   Wed, 8 Feb 2023 14:11:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH] ACPICA: Fix typo in CDAT DSMAS struct definition
Message-ID: <63e41e20735c0_11f3dc29460@iweiny-mobl.notmuch>
References: <1bebe2a62539988a1b5fd26665ab5221a7eddbb2.1675835625.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bebe2a62539988a1b5fd26665ab5221a7eddbb2.1675835625.git.lukas@wunner.de>
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd5054b-b498-4f80-d066-08db0a2178c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TejJfiRIlet1mhUvi7BMkELn8PFbsmWqc1zBOAWRxxFVrg5NRdlbscLMCRKFaIsvzwNG51FHAOJa3apxNr0Vd1V+lYHU7hR8ntZFA2UM8pfgpwBA8XzplCUTQExAQs3BsKnN4SxPxYi2jEInNMwTJb12Ts6B6fNoTfHMQ0NRvjrJMcU3K+GEEpSkDZEBvBBOjSO1AkWExVL9KpvNu+DYXb0ITUKGJ67lBiY6GG4JE48ASvOlnB43oQUNG3/zIDeZ1jy+q06w7od4Zuoa2pv/WUBqsa+1kMLl0yupIv1l2quX4NjZn7TlKKX5nsglpOujE4xNCEJdaCRAL4Adwtejj5V0q6iVYHKxw9ngxd404Tv3nCpGvzvBdKi4a39ARFBXxbsfN+a96IIbQksI4ij4LwdMVMcslMY6sioG5V1/M6gZtAQoRbGU7mH3/ETpDMVg3jCHQdXcG/ZHpJ/EoD0P1OtfhwHh9ZjqZXCy/JAigRYYtH26aAvrx9evpzyhnpfVwJv1IAK9vjcMNeqegj0JuiRwhvsPkdkjboOGFKBX3VDzN/BI2PiqPzFEDVhIX7Wl+P190o9OwwJ5CF6lbz6yHWRhR2mMZ1T8ohffZoFz8jKdnhl/jS+pAlj/KxOwNwCEUcPEyWgLklzI/Xr1wxrTe6Guc2F4Ci0k1AANYXFkRPw/CMx/hp+14De+jSFVNKvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(83380400001)(6486002)(966005)(2906002)(82960400001)(110136005)(38100700002)(54906003)(6636002)(107886003)(8676002)(66476007)(66556008)(26005)(186003)(6506007)(66946007)(6666004)(478600001)(9686003)(6512007)(8936002)(41300700001)(316002)(4326008)(86362001)(5660300002)(44832011)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeEFFkulqQFtOTNqq3wn4ifDtekRmTvbbW2VvEdaw2u5lfi/X7rmOIhWf74O?=
 =?us-ascii?Q?cNuV5DJT2QLKYB5Njl1FrB/Bu69b+wGmK+kX8ZguJStWzEVZ4bUL27/8fxYf?=
 =?us-ascii?Q?/XvFJRIdc+LQvFA0IyzpBu5jo89pwlD7sg2OkcC3bkvXKLkJbZh/XhZuBerE?=
 =?us-ascii?Q?6f+WUvelVS7Wkyy/Ll9cQdgdWdIo9mL4mDBK4SmpPEApafvhJP/ulaAKZ+TR?=
 =?us-ascii?Q?H4r0XQpqA5dhGSndrXk8Tmd21KH2iHu6uNvE0x3RlfUbJj6fkV6lSfTQPhr9?=
 =?us-ascii?Q?2B9h0Wn85+FmsvbVwCpQv04SakoqWs4v9MqaBIrI/p/0YdxXUPsZQvDy/5sP?=
 =?us-ascii?Q?WYnGItB/mAv1NG2HMzI3TvtSJXQJLTtzxdEGsIq31n4qIFk0YOHPbNTSU5TY?=
 =?us-ascii?Q?6nyCTImGykUr07fjDhuULYnhMJE1Kua98hw3hC26puGvxCBWXdYQjXKbhqBe?=
 =?us-ascii?Q?X9ZxltUhox9xQ4bJazl51D0+0xbsdtbbbiXtEC084SfgnwgEaXmtz9xn8dMc?=
 =?us-ascii?Q?RsBrOCrFOMJYCob5wDDnPLSw6CmnUncRZOUPkMR0182UNbsHlW7BSW4rmvtE?=
 =?us-ascii?Q?WxJ9ycj1+023PBstPWBgrJ/69r6EY9R3F16R5S92PXDRNsAK0iDqueKCjaX8?=
 =?us-ascii?Q?mUn1qsSkBIqPnawHSJ2YKxJqSIqUJ2XSwfpdwPQVJynktjBv0yu5JOe08ftE?=
 =?us-ascii?Q?o3Kf59gsGUr6gBa1jhzW+h1dLkF3rKbQ6AhVMTjYizbOBmxinD/GLvkeIItn?=
 =?us-ascii?Q?TGJxqdmoljCEumEsF8fq/nGFqeqNJ0PsN3QYYQWPvYiRU+xQ3d8cPj2OfBdd?=
 =?us-ascii?Q?bTcPMdlQ+42NuGQrbZHpg6uQY8Q8YbNJVE0jS5hp7YwYlTuW6Y7GDJ5WQBHu?=
 =?us-ascii?Q?P1CTSNvfZjtoFELAGDu/sd9kAMpwLMEC1WVQ+LyRJQTLhefeHokcFYhXapFv?=
 =?us-ascii?Q?ShTv8zypvsf5NWjZQnbcTR7zq8B3gZnjhtiuXgOv9uOFMXacfSE84xp0Q0Ea?=
 =?us-ascii?Q?feLK/SDbM53vJvqG2OV3FkTIkr0X6yVdiCQsRb8+MjEkFV8OsMagGAe4oGzM?=
 =?us-ascii?Q?SEh3SxNclOLa+zb9KrJHqLuYyihLQYr5i8XDdFnscK5FpOHltRwo8qL+59Yu?=
 =?us-ascii?Q?sd8fK3G9e46F6SzPGqQxrhio6f5Az22GV6peLkui4LgB+TAkJLPYz5N2CSOr?=
 =?us-ascii?Q?McW77noW/btq8McbSbe22+toESLrLKYXqruvz9Ds6e/5ab67XXa3qds9BMaM?=
 =?us-ascii?Q?SUGH7u1hqrvDbdaMpj9VpSdcUveEadsEGK4pF4b+VC7nYhchESLrDwS9j7IA?=
 =?us-ascii?Q?cwlrlTiy20y2PVEm6CqyhSfpnHi5PRt7RcJU0Kv9YHjqXr99dRzZiftzg53X?=
 =?us-ascii?Q?0+qpsFUxzNdDS7u7VTxs/Ux/xK4TLt/Hm9UlPi35imJTd9Ly5NRbkfQtfnUY?=
 =?us-ascii?Q?iCxXPWI1MV6ZTUCQOSAjPXd/wArav8+EiE3PEOc7uRJEKOy82fSXZtW0BzW1?=
 =?us-ascii?Q?AVD2KhCD7zJuKr4zPckym58Xlu0im0Cuj9XcU0U16PfqrT/6+pPu1FDvv2+3?=
 =?us-ascii?Q?5If1hc6/iLwr/wsBuEFecKLSCyjVoxUZoA2JFBoPKXAhjpuFzvNCOXi9kkjo?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd5054b-b498-4f80-d066-08db0a2178c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 22:11:48.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR3F07/86kE5ircyN8Z4+IOaUpGdikwnIm985SXHfHnw96K9QfSl39+coZOkwZ5PHVky8hJpfDiZdVQsE5CuBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5700
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Lukas Wunner wrote:
> ACPICA commit 9d8bd58d5f3495ce76d1b9767ec0b92251cbc366
> 
> Link: https://github.com/acpica/acpica/commit/9d8bd58d5f34
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  include/acpi/actbl1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 72884ef..cdedccc 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -346,7 +346,7 @@ enum acpi_cdat_type {
>  
>  /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
>  
> -struct acpi_cadt_dsmas {
> +struct acpi_cdat_dsmas {
>  	u8 dsmad_handle;
>  	u8 flags;
>  	u16 reserved;
> -- 
> 2.39.1
> 


