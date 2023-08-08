Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0277448E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHHSWV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHHSVl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:21:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFAB21E55;
        Tue,  8 Aug 2023 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515931; x=1723051931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D707Zh3iKIb2pILe/0bTHkM5QeG8X4yU/fagxylO3/8=;
  b=ltHlt2H4zxWAJR5Eb9puJo9fC3gDs3gDc4+68o0F/44lVjygo7PoPK59
   9ziW6yAzumIMrjWwDBznvD5JHxPerm79Y/+3VF6+HxYh2LApiYMsx99/T
   +KS8L+EFSAi7QN3ExoHptMfUWRCWHJm2yeKFvHE/xYhMFyA8ynRB1bp+V
   Q2oYthMLKWGtqRpj9hA5iVOKOORcn2H3BSvlouCTTyGwKF88LB8Yn6Q6v
   9ireA+OL8cUxgo+ng1Rm8YN5JvaZ8WDg+b7ro0rrFGSz29hHTz6DMU0ZO
   /ipcfbWaeTgkuShk6+HGtLtc1kXVcky4MIJT4fTAY7dDY8njd3mPFoaVA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434722751"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="434722751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760958235"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="760958235"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 09:19:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 09:19:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 09:19:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 09:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhMZLwRvF5TXQRARL/9IHGDxRvu1A4DoBFSLY5CmLI+RLY5ZfnZo8ncp/Yj1tz/JdiQ0YJASkyBThzoVPfJ683q3ch0lH8mZQy9aWgGFo7HGyo7OQTQTbaGMCDh4YKowYtRgXNvOso7bgZBbMxbgDeuPgyVCiJ4eoyBsxckdV790K4YlmDcNVbRZAe0/lYNcbkayMqIJC/xxn0b1LJQPalwvpL4poy+U5HOzEytMBamT3OJArQaBKcWIyckUUK26TCmAcX0Ro1jhWeJ7N7LhbKFoCJdjSeQ0U2cqbxjaLxF/9k2PqmB9h10ECwF/wVYkYlZFFqumsWof8/lmVH+/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ucxFEyJ8W36nENXXXCtYQinp5ep6dhbIoxQWWFaLR0=;
 b=YrvTN90p9Zk5iCMJfYusra4fSi08jhlAFtu8OBt1adnwW99HV9PNBJOx8mQFh2/jvOY+s+7gzDx9qwcoQ3PZDkn7H4pSFhPcNAg3czyjL3Ec/C/dgcQwBe5VC2DdJu69RS7ColFmLml0arXiAnz/CXtrb3Onc7JdfNcFYKcqS7hmSLagt6zVPVEGbsla8D1Zyt2WpFF6l4C+b7hrXyXc+I0ZmNEYZnJYtAXF/6wF6CsYIAwN3CDIM2JiYRp3TOTOCW3P4S56RTbzUcO4wmSEiR7Mo6gAYZEVuFZGQcA7R3xpY8+Xe5DM6WG/ySHd1rRUcA5PXiNre4NeVedSuQr4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 16:19:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:19:08 +0000
Date:   Tue, 8 Aug 2023 09:19:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/6] ACPICA: Add a define for size of
 acpi_srat_generic_affinity DeviceHandle
Message-ID: <64d26af8bb49_16650c29418@iweiny-mobl.notmuch>
References: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
 <168746997931.4115467.47140094903948157.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168746997931.4115467.47140094903948157.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 222a9cb8-cf69-4972-c693-08db982b3175
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPX/Yvsb1bj5eDgQLK9Ebpu5RhS5LZXUENsRBmmebNhWHvcc5NBeLpGDyLsW/xC9IIv3Znb+w4U24RA1yZ4VQROljPV/j/Rfi7j1jLaln3QW+mDgvG4RBdZy2grGO+EOCrGjv4gJ4IR4k1PVyjKpBo3OTB3ctzS6I3k1wb79tm3CjUPQhqTrAyXaJRAl+KmURemVpRSxtHr/HEYeggmxSYfJ0qxexOYgkeV1yJXszQ1iQhg3MVjXO5RZZcg5sphqqEKcYNdS7EBWsL8V32uSTnoXKvabZbXVQadeM1EKJ95grwuAeKb83yLwKptHkbrMnNOrCkmQIivdsckm/hbu5bFx6RsoWNa4QJSSh9+86PeL5Bgtfwf8pBl4lROBdfCHSeovhuaFyU0/j6NxZtuWpKZ25QPVj3vES1vLhbjdnz892Py5cqfN8d8Wr9QjSR0+n1ry4DMWHwRMsHF6ePNYHirvI+dQlIQk5EkU33ACC/XVc6k6M0YmOmHej7k46pb7l9POceaKnZIeclg8sxkzTxpoQYFdkxwW6DuJcgxsCL25TtkAe8dKI7PBrpk08Qab8S2zyrcDNATAdQ+dB8YZAwcxD7MTOBmFsVgnC2MWml3txchsvOdBKDhvgs1lIuX+mGGRgrZvXgLwkNYMSc44Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(186006)(1800799003)(2906002)(83380400001)(5660300002)(6666004)(6486002)(66946007)(66476007)(66556008)(4326008)(966005)(6512007)(9686003)(82960400001)(38100700002)(316002)(41300700001)(86362001)(44832011)(8676002)(26005)(8936002)(6506007)(478600001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvZ9RIw4HlgdwA3tKbXHd5tHT5X9cyHBqfmKARiMgv6tDOVetWyoNvIUS7Ar?=
 =?us-ascii?Q?B5qYOst2umTmhoU3FGOoEPwFgmRRoWUYOhnmwEiuQ2hOdwj1s/qbbTnybops?=
 =?us-ascii?Q?Ea7yk3ChRUpg3IHhruIXhOovXK/TqpyNt8eiF5aFR5+IyzQsdv0ihFQtEBi+?=
 =?us-ascii?Q?fbfqtQEyT0JX8bjcGj6+/Y08pbO1OnmD+mcr3htphG+0LsApYjnp5Dn0cFbp?=
 =?us-ascii?Q?zLE7rAPJOnAyC+4PUgnNVoTP0H7tvKMzIczM6F1+iTdFDLomX+hYeLlfiC8Q?=
 =?us-ascii?Q?mS+Arn7W5avahIAm2OiKLuGEkGsKJk/ZNc+xPWkTuW8qORvj2VNiBNFDF5SI?=
 =?us-ascii?Q?6GbECKBZNXHGY9ZXwZzdWw67EIYf+XZAO9I9cVogY0Fb16NNN3w3/JqUAe/8?=
 =?us-ascii?Q?Ycue5/ZOlzAaZMoSoTOGdn1Lmz9hNXRLD7BRJFR+xiHrRNiqoeaeRbKHpxTA?=
 =?us-ascii?Q?3/cShuod7L+MAz6Sx1gdiZCg2m21S4j2klVn8s6wCfzYpjdgNJT0590PXBcS?=
 =?us-ascii?Q?TXTYReObHaXzg9c8+/2uT0AQDDAZWvVyD58cY28wjNeVpFjXQ4c7llJsTDXo?=
 =?us-ascii?Q?mAfuAWmTG53L3ccnMy8VtbrmrdzJPEuyNOVU7+6G60Uu868D6ZS2+ltktohy?=
 =?us-ascii?Q?d5VuvEhgEy+oUAo1+JQkI3EnNcmOc48xOPezC+LqBGhbizPSLenxf9CJhe82?=
 =?us-ascii?Q?vLrc2erBh4JhtC9XujERvQu4JQ13t3h38+Zy05vuOloil/bMcbbwaltaZWH0?=
 =?us-ascii?Q?7IzXjbY2QC/jun9E1DxMMgi2ni2Ahl1BMWYpanulonJmQKv96ADq2ijdDxSw?=
 =?us-ascii?Q?urqToFlsbbuZgAGMuteeVw6AZX5w54EBSTro9w1/o9WzGxHCLmkrZtGLAqfi?=
 =?us-ascii?Q?tSntW5KWWamjFrF8rxm/tR06fjK6ulsOhyySPbvr2m4cEqhRaSCzXmyvkizG?=
 =?us-ascii?Q?31Wuz85dp8aew/EA7FVQxz2pgg6TKsoqugTjciCBybg9sDS/M3BQl9HHA+yM?=
 =?us-ascii?Q?G9eO32DwSWqNDVJtriO9qP+9I0mGfIpFJCC/Ex2ZCIVKRZ3JdkDlmZJyYlgH?=
 =?us-ascii?Q?jFAGSswrUlUZZVFOVYchKW9A/sRFohGm4+N0pG6JVOyR1vc+0+D/dy0ic3TM?=
 =?us-ascii?Q?CLQhaMwJKCdxM5F8u8FZlsMzRG9h0Hd4OaHI3LAt04rb53z7+Jz0rqBU9Iv1?=
 =?us-ascii?Q?esWG9qo9tM6HtlEUqtK6e2JTELEzZya9aj8IgGm8ltaGTW/pMUcUJr5nEONQ?=
 =?us-ascii?Q?t/hSwH5uMwk0iGfaUGL1/mHFrVWq+p5P1PCd7zPXCTK+d91Mo4x6NW9ST+E+?=
 =?us-ascii?Q?/NbdCY0J8XDCrqiIHXah2WfYm8wJXvTozZ9SIy+eTgKSoHBVqDfLOvz/twRE?=
 =?us-ascii?Q?mbsFwVIPMYqoUh9JqSXJ9MtxmOk1PgwiLGXTt2dOXg+1PhomRe2dLCXaRHDu?=
 =?us-ascii?Q?9NFVpm9vi+t/LD28t3YsnIBFCfMiZ8WR2bsH5H6z69mGB+JpxybNYWvzdOX8?=
 =?us-ascii?Q?0cKgPEX0BjM7lLUaowmpY+9qtwpgY11JHw5Kxl6j/iRwiCA4CTMPokmOqRVc?=
 =?us-ascii?Q?5UHHf5qD2PJmm4E5vs6kAxnB/m+e9im8jKJacTzT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 222a9cb8-cf69-4972-c693-08db982b3175
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:19:08.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgglqmayMaRVp4Mf4VJWpS6exwYUViN9Qgef6sad4Ovsw6F1lQPom1gkvyWL5qjd2RpdaKcM1a7/aG1vbtVQGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> ACPICA commit be56820b03d8aeabfa6709c4d99bf1711afe7ef1
> 
> Replace magic number with a define. Linux kernel code will utilize this
> define.
> 
> Link: https://github.com/acpica/acpica/commit/be56820b
> Link: https://github.com/acpica/acpica/pull/876
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  include/acpi/actbl3.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index f51c46f4e3e4..1838e5cb313a 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -279,12 +279,14 @@ struct acpi_srat_gic_its_affinity {
>   * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
>   */
>  
> +#define ACPI_SRAT_DEVICE_HANDLE_SIZE	16
> +
>  struct acpi_srat_generic_affinity {
>  	struct acpi_subtable_header header;
>  	u8 reserved;
>  	u8 device_handle_type;
>  	u32 proximity_domain;
> -	u8 device_handle[16];
> +	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
>  	u32 flags;
>  	u32 reserved1;
>  };
> 
> 


