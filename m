Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021C718CA9
	for <lists+linux-acpi@lfdr.de>; Wed, 31 May 2023 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEaVdv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 May 2023 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjEaVc4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 May 2023 17:32:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173710F2;
        Wed, 31 May 2023 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685568725; x=1717104725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=glOP7HVnv8x71jnJ4dHlLCHgBjR+spKKC9uR74wbYNo=;
  b=fh3w8ylX6Jt0pVBZyKLBsX+myLwzVXMza0Ooa4l/+iV15ve9jPyvruNV
   VRVwGrjQYJlkOukJkg4sgz4dZ3nxFfSsbc5yMNHrnVoyJVxS5EuGoXj4J
   nRnpKOBFZQ7yGsHKDjVzNhfnBA2IgGx4e1TTfykutKdlSwV/kw4EcG8pg
   d39gF+rHRMqlhm0zKUDHdenOi8nxZQKznj9oZ2IVwL4ldUomSjj3t3amf
   LNieD0QMD/1dC9xK3ZcHFhy8Ylrbz4z1XO8PTNwzBn2ZUIwIaRS8N4QHj
   PT77E/fyyERgtgyAvK3WJuWTSidLjfg194PuXtCJJ/IWrutGvKOTZ2jAW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="358641643"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="358641643"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 14:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="657512174"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="657512174"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2023 14:31:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:31:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:31:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 14:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iinLuiL+hrcPN0Ve0ELlRtrI7yyElJsKMoC7n6upNxJSe13DtZAK4hVAfT+ZVZLQnFO9bOPqw2xM7bsXMOl1QukOOqcWHcTGby6/SrW/XsLDNmYESwrTe3CjZuVEtu2OK9FRPGY9AbkRFV0buTbQxpqUMUujDxmTiOC0IVT681pEkaE9bDLfaWY8Dczjy80ch2P2u6eSE7WIKvD6A6nVItcM1Xu/X20mcemVEHsX96suxUz9WCDtOxyL5/UGIihhZS4HgDgy+/10nB8Kgp6FmrTu1iPKOC9OJ6tEVz8bZ8JiEQqlAlDIEscUfVx3XlBQBTlyGjzuZvJHRTQDPGM2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwdxS0V8kw3wI5iIKgEqE4a25wNhp9G7GQ9fyy/tw3Y=;
 b=N8KAt3OA9pFYpTz4Sk+32YJgMpSLMVAu9SfpwvULI1TPJ4rpq/in3r47UzqdSIfHb+GWarFdYnRvUL5Cf5iVdlEUwSSm43tY9rA8g20gDFY4zbaWPB24gPnMvcAy/1YHyNN5bzg+uHTKer/nswCW/OhDvnmWJwrD61P9Jn6YOkLMxNdaIQhohApB2lfKrIVoQCOJSo1Xh54auoH6N2Az2QcerkfKQ8+loAamOjqiOiFImFUuAug1f6g7M87l8KJmj4OStltzBqu71/izVNffuPSAv21ClXB9IXPsLIab3jetlTJV4t5kPgPy5sR6RDovIxhjr0HTz5E5ucy1ciYJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 21:31:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 21:31:46 +0000
Date:   Wed, 31 May 2023 14:31:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>, <rafael@kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
CC:     <yazen.ghannam@amd.com>, <benjamin.cheatham@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for
 CXL error types
Message-ID: <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b3f3a7-0628-4abf-ad4f-08db621e6f3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXsXOpszTq4CkWRAVyqSkBjGKNiTCCcVdgTUoL7ahfVI2497OxdMF7o+NCxsGycgyF3TzGZZu+hdakHQ21FhZIpVASScIXimx0G8Fo4wZToldof4SOp+6AJe/6z/SASBad3raLnszCFhObRIVMATbCLUjXfgysdahtq+OrcLQssINVkfQd2TwhHM9lLb1tzn2/XaUnzbCk2S+uw/8yczjJ3w+8Kf62P877g3RRrlWrgRThJ+14f0uUF5hc23d6BZHhrj/0AwddOcbF3awMLnxv6gEYobpMVLy9/8yh4OCNbosQbvvMhPSmGZVAqKgpEIxgid6fvWdOHzTM1jFsuL7fN0j4f2RkVImmlfJwdwjPRNf+HUQkzYgtpxECCrs3rZJwFl7XlYDeRQww/c1eSZVFcpOqfgeLdB2FN4anr/hCV6Jm5eRJENPTRAESyaGqRCZmL5woR0ISsRFgFUsgEGmhWtLw1ox7vNhZIHEjNmG6cqYn4P0VI5+SDoR2mFDOpXhpoQQEnPO8NqF5YKO2GU25xhNUDuAwB13SObN+eElDphzwg4LyA3LlI0uEtuoLHqAFUQEo7CYMB9yuoo4X3zxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(26005)(9686003)(478600001)(8936002)(8676002)(82960400001)(38100700002)(66946007)(66476007)(66556008)(6636002)(6512007)(6506007)(4326008)(6666004)(316002)(5660300002)(186003)(6486002)(41300700001)(86362001)(83380400001)(966005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLSVjER60pHVqjeH9GzBRT0+sNp51FMwIUXErFiFR0AYFrn7dVX1VAKRi9xt?=
 =?us-ascii?Q?0VHs/9sE7QWpCg98GX7Wn65FKXzCv1yVxFBQ0XQnZVftVo4qJVXs9pRV5Fsb?=
 =?us-ascii?Q?tTFjq4bmQoAiey0sPoZd6I5jeqYl3dcPVp3iCjdtoBQlwvl9yJDzexC4h51N?=
 =?us-ascii?Q?bVs+ibZBPTOtUzUB13C9ErxIRlyYf9ZQeig7SxpwFxdMxi2w+3ztOoVBM46t?=
 =?us-ascii?Q?eMtqQ0EZSUcbJGVVyEEnpn+9Q3CnF+/p1UjHuzG+SidRo1TGd62v3AN1NUPD?=
 =?us-ascii?Q?A/aImZzkL0jK1Rn0UpEuq4OghdcwU2yO7cSPM5VQXUP8VIUEqaJa2k9wAtaq?=
 =?us-ascii?Q?371UWOsZH8RaqsbRLbo3kJiC4sWEyA+waySS4jrpKM/Jhvx8BQAABYDhD2S1?=
 =?us-ascii?Q?zJtuMEyva9rjHPxn2rtYMFGBd+8120XV4vOM8x5OgZhSjSGA+mRjSqY796i2?=
 =?us-ascii?Q?YbUsvcP21TdK5sImcgKtdVjIYIA1esekE2RbKTO0OHdzctnU7TI74e8IvE71?=
 =?us-ascii?Q?Z10Nc/C4wXMZsM5v4g18Bfq9lRf7d+WgnWKnvi0Xs0c/8r1C19kVcP5wgetr?=
 =?us-ascii?Q?Pqe/UhULHiAmZgw7Yy01z6UUzqdMZmBGP7gGXG9SSrxpEncesvezXpDUrPjZ?=
 =?us-ascii?Q?M3aFahb3fwtlqqcuFyhCm4CteXoHbpTY9oFoQmLLCd/bL+C6qDFmhKMe1ZpJ?=
 =?us-ascii?Q?b0WtcaVoxxOmrDFchOoIhjUWkqVWTltmhHn9gwvmE0uSy3/8li49qZOYGdE5?=
 =?us-ascii?Q?z0SHZUdt7Zq8PfCeNvkoIf12w32okM1tbp/JNeGVQ4VVtzYsAQNvQxYpqi5F?=
 =?us-ascii?Q?dJts5njmB2ep7WAlzZNvAsjvB4u0rxGejgy2wuT83PMW6LAKpidouQXXX1iV?=
 =?us-ascii?Q?plJJ1jg2OmD26dj9yumPCTX9U4u/S9x1ymUlZCt60z+gzq4ED7vLt0IrnLu9?=
 =?us-ascii?Q?P+HkQwN6Wq4TSVmExPhFX0hbZ6e11JHprlxLF5m0D2NUeHddRT8Aixo+7zw0?=
 =?us-ascii?Q?0VRnJDRqKtHYpKogdBPmrLP72s3PKuGk3nPufIVzkxDK+4UKenxldjblcEHU?=
 =?us-ascii?Q?wgpgI8Dg/QA8h0LApe+8l51Dx7vRlTaLU0TW9FBHnUmkAjETX6xFzXRrFida?=
 =?us-ascii?Q?FI2NNGGmbERRcf0XT91SSOSeJTbesnQnoGW2txwU0E6SKPBPEwXxV3A/nXKB?=
 =?us-ascii?Q?akoJqvgC6yc+lqBh/7ar881lNZYrZeQMf0HxrcIPloriD5z89KzIQB6I61Pc?=
 =?us-ascii?Q?uwjctojDn1VU9uj9W8wygNR+V1RGENh8gHu8oCFDRRaPYthitxjf7vwaKuqU?=
 =?us-ascii?Q?/YHIkUZWqN44WsN1ctiZL5dQliPLi1umqrbmFsV/W/Y9jsHBY6i5VLLSHBxZ?=
 =?us-ascii?Q?CdpETO73W2LOzYBVGgttIDIyNXRqR29KjkeY1qJptlLUqN2pX3+T09jbN1w2?=
 =?us-ascii?Q?+ZhwTNniKDaz4/nqaxeoH2BgxYWoFGOwQlylP45vFexmAFJoQINX5+YHhsKc?=
 =?us-ascii?Q?yJDgdFPrcjWM5B+ZtJBRYpW3dnkB7BMHGth868TvcxbV+0Bpo/wwVMKHarMP?=
 =?us-ascii?Q?8KCwZxyUkIk/dznxNpmFMh3ucSF+LTPnt1IXeBJSuyKoxlHmVrKkFipSI+5/?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b3f3a7-0628-4abf-ad4f-08db621e6f3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:31:45.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5pq40Gl0b5vFIVxxfY/676QAWaoDXB6y9W6Y1LYVFzemTuPcvTiLd3zlFzDx7cRe3fupsq0+6rLWkr7+NiKVxEYZJyXMxqKtIY2FDnCwXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

Ben Cheatham wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> V2 Changes:
>  - Added Link tags for links
>  - removed stray unused variable
> 
> This patch is a follow up to the discussion at [1], and builds on Tony's
> CXL error patch at [2].
> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped Downstream port. The value of the Memory Address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Allow error injection for CXL 1.1 systems by skipping memory range
> validation for CXL error injection types.

This just feels a bit too loose especially when the kernel has
the cxl_acpi driver to perform the enumeration of CXL root ports.

I know that Terry and Robert are teaching the PCI AER core how to
coordinate with RCRB information [1] (I still need to go dig in deeper
on that set). I would expect ACPI EINJ could benefit from similar
coordination and validate these addresses.

Now, is it any address in the downstream-port RCRB range that is valid,
or only the base?

Another minor comment below...

[1]: http://lore.kernel.org/r/20230523232214.55282-1-terry.bowman@amd.com

> 
> Output trying to inject CXL.mem error without patch:
> 
> -bash: echo: write error: Invalid argument
> 
> [1]:
> Link: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
> [2]:
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 12 +++++++++++-
>  include/acpi/actbl1.h    |  6 ++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 013eb621dc92..68a20326ed7c 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -37,6 +37,13 @@
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
>  
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE	| \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE	| \
> +				ACPI_EINJ_CXL_CACHE_FATAL		| \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE		| \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE		| \
> +				ACPI_EINJ_CXL_MEM_FATAL)
> +
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>   */
> @@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	} else if (type & CXL_ERROR_MASK) {
>  		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 81b9e794424d..c39837266414 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1044,6 +1044,12 @@ enum acpi_einj_command_status {
>  #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
>  #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
>  #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)

I expect these to come from the next ACPICA update just like the other
definitions. The change in style from (x<<N) to BIT(N) was a tip-off.
The process is to submit a pull request to the ACPICA project, for
example:

https://github.com/acpica/acpica/commit/e948142526c0
