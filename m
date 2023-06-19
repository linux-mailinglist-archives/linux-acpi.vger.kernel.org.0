Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8329373569F
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jun 2023 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFSMW3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jun 2023 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFSMW2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jun 2023 08:22:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EBDDB;
        Mon, 19 Jun 2023 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687177346; x=1718713346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N8Yr++W29UwgRGHD/oN38Pu/9f0vsFvP7BJICiyRhTc=;
  b=LIUBsUSR7E2lNkLR7BS+vRPiB2p4Tza2azJXR1gr4sFcgux2PtmnWIxy
   hi7q2sq9vC0gJSi1JRfVS/Cwz2+1KPI4WMTWNQqjrJCsY/aLBUTbP1FfP
   jPkCVbV2ws6TUn4IOOTTIp23cm1SO6regaBLMX+cGEVTQGFj1/gWbUgxH
   fsSgBfaI49DL/n7xa07Cy84zAwNXMRWx7CBNsO1NOxwCL14Fc8W667S6q
   xTSFceZALiE5N53ice2rRpFdSoc/elWksehWdnUvKREEA8VQ4Kiw08zNj
   9b6DnlsDaz7Yqvm6CVgamSTReAse33HQWSc6na7RKgxrf8+draU/ld9pJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="423280376"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="423280376"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 05:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="713653818"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="713653818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2023 05:22:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 05:22:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 05:22:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 05:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4/kh1TzIlGjj1T/kk88wdNHVUzOAwHOLOx92YSAT2B6GW64egsRwemgLlOO4LPKRPScg28Te5xShWWypAolESykRNeEpEjuuQWNSrEjYqjedb1Gra9z0kBUUsW0AJVgWUTazsm1icUJozNIZlj0KFXvey5+GMG+07TYQEBhOUkkAzhzHZDz8qjKw+lkAIyTqzjuZih+X3IfcmZrx3slkb9wTegRALvuqh8CGGYmaiwlOlEaUj0GWOH+Gpt0+nL3KSpMAH1Jnotq+JlEsArOhuLaYOenQH4g0ZHM74QV7jD9WI27OQSkM9we9JbLtZSoT+8aziiA0+x+QYK3EjhzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as7OBjlpKUa/9aels74zYCrs6t9dYnq0bDTAX/nqmfM=;
 b=G4HZpdkwuVZEbXfPvNuIBiSXFpq10PVNsaJO4VE5038tiqO7qbSALovBd0oAxasuSL3D7J+WSQfbTbCoq7gyBiaihDlEQGj0sXGwp0XSjfKejXKs9gkM8vSrzDTTuyMOdl4YOL8kiQAjhhPEbfuYaMQZLjBPf5c05uFjlekhdk9fUlvKyEk0Xw5g1V8Xr722KCP9m+3A6f1oy+pjzLsEiBmTsHcQ9JMCrHMN9kH7d5RwC2Vmn/gqYW1+VDc8zqk035wtXg+xqs6pc/iLsnrFX3kHpXzqrz7A4adPA3kzbZpi1CAflKYkauxDYzOzysigpcsRBce0dPUHgpJI/VlbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 12:22:18 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 12:22:18 +0000
Message-ID: <c05323a8-5cda-5355-b701-e4acdae99f53@intel.com>
Date:   Mon, 19 Jun 2023 14:22:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3 v2] Documentation/arm64: Update ARM and arch reference
Content-Language: en-US
To:     Jose Marinho <jose.marinho@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
 <20230606093528.1494344-2-jose.marinho@arm.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20230606093528.1494344-2-jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc4af48-2201-4f79-696e-08db70bfd303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3HsBK85Fq3wj9nR5P97qIhLkn50FC70jiDilHeufPGurszVdB/evdXSt1Twm/7x5UxJhtoSQBIzpJTMIBtoJ9YRpegA5FvSq39D7Gs3U54BZy7s7VlLdbV7C57tF2r2roJQ7x4Y3wNlQ3tfkOnbfghvclF0XKyT/jl80dyEWxUsKZTYp+6Klqf/eCIRNx5ODLhUEcbAB/nyjwOAt4w12/2nA1a/gICfhFvMoAOeuGrMxOxHqa4gEa6Ym8pLBrq1XgMuSbutfhd+wUHbIkoHg1zdDl3A1cNKZM9xySUfYsUDqKxtgZjmNABRhMeoYgh0qiVZ6PGz2t6ULMmGkuRgeNcoYGfhNgEAU5Osifnm+X35BczQP7WPX1k+NSWLgo9Esxc/Lx7WOvL/sLKOYgYv8ETpuV/BesiAuavP75JRJPDsjSYzL1mbBXiE0CuJbEFzPmTBySm9D2HPOR//Ls8bZTWIlgMWQB0H0jOhAp5xo76idOjpEjfuYoS24sWPJwAQuAJwogjPDdL9PUuZiZdy6E4yQh91QpR/WEqUpddUrvbAkijHZAfHNrCRxX6R/rYU28xx4qoyV7fyXf5IgP5sFXRpvrn/Gs4+1PYisi/YCitVAn6lgeZTSBVJonDRP5QZZZf7/VTUITRTUZWE5TwrRqKWfO63BeowaBoo5rH5p48ZzohWflvM85HHF309bAlj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(478600001)(31696002)(2906002)(966005)(54906003)(6666004)(6486002)(2616005)(86362001)(36756003)(26005)(186003)(6506007)(6512007)(53546011)(8936002)(8676002)(66476007)(66556008)(7416002)(66946007)(5660300002)(38100700002)(316002)(6916009)(4326008)(83380400001)(31686004)(82960400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0F5SlBTVFN6Q1pWd3Q1TnhRRVlCUUdnTm9MK2t5NE9UOUx2ZHBoOThQczc5?=
 =?utf-8?B?Yll3M1Y0VEU0ZlV0UERPVlkrN0Z0ekNjU0Q3MW5YSkt3L01TcDI1cmVBcDRO?=
 =?utf-8?B?TDFIc0ZpdTdta0cyQjBnd1k1TnRUTDBwYXhZRVM1dTQvR0EwNXFTZzhnTTEy?=
 =?utf-8?B?dkducWFNY3VoREZRRTFtZEpFSnBGQVdUOTRqcndUZHcyZzh4eGE4by9pZzA2?=
 =?utf-8?B?RHp1QUJxL0pkQlo1U0szczZOa3I5WUw5UFdYcE9JU2pVRERUUko1VkNZNEZa?=
 =?utf-8?B?cTBRT1NTeTdTYTdnN0h4WUdnOThxUzh5STN2c3gzOFlPK2lJbldlb2FDTnVZ?=
 =?utf-8?B?cEdhVzVxb2hsaFNGRUM5R0pwVFQwSkNMYk92bXdPdXVJckxHY0NCYUI2N09L?=
 =?utf-8?B?bDh2UkFZVU5Od1g4Rng5VThyZlBWYTV3bUg0WU9oOG1sOVEwOFc2b01TN0Fs?=
 =?utf-8?B?b2lURFBrSHpLdTZSRmlXOHJxRGphQ1dDc3VyWkFuV3lLZTUxcEloZU9YTDY3?=
 =?utf-8?B?WXR2eURLLzdBNTZUbW10V3RUYTlJWDNnZ1dDNWxDa1h0Ylo4R00wQ25uN2hG?=
 =?utf-8?B?QWU3STR3Ujd1TEVMTk1hcWtqYnB0cDllbUVHencybGxnTkd0ZG5ySUpUaTdI?=
 =?utf-8?B?aUxDWlRmbXM0UnAvVWt1WVlhTkJlNU9NTVRJeWgwREttQVN2ejQwZktXTEs0?=
 =?utf-8?B?VUxVM2Z0TzRIeFM2dzEyR3NPYzdaNHc2Mjg5RE1pSHg5bVJUcmFPZ2hPS3dB?=
 =?utf-8?B?cDBYcG1YbXF2OUFLMWd1QUpHK1FMWGJKeCs4aUR5VUtvNEIzbnd1Mk9CTDRW?=
 =?utf-8?B?MytCd2pQaDlxSkFFUFVBQVk4bFpnTFlEWXh0c0c0elplWFRmb0lIdDdQSjRC?=
 =?utf-8?B?UFArRmsrV3RoekxkUGh0aVEvenpnYk10YWt5WmJ2T2Z3aWxjTEgvTEpEL2FC?=
 =?utf-8?B?bi9QSEYzSDVrdkF0Q1NzVjZqcUdIRjZETXhIaUFibnVodEQ1OTNvSHkwU3c0?=
 =?utf-8?B?ZzRaMkRIeWdkcmR3SE5vZlBzdXk0dk83TlExc3NDWWRDbk1Qc2sxNUZmc09N?=
 =?utf-8?B?Vjk0RGVmbm9oc3NWODUva1RGNHI0RUZTNURCVDUrY092dVYxc1pRYmdYTCtk?=
 =?utf-8?B?d0xNRU02Y1lBVkhzelE4N2dZdEJmNTl0cEpDTmQ5eVBOdFVQRUluRkgwTU1u?=
 =?utf-8?B?cXZIY0JvbTR2WjkxNi9XRDAvMzN3TXJGMFNpeTM5WjJyYU01ZmU1cThweU13?=
 =?utf-8?B?dXVHeXplKzdLbGFiZGRxTHRCckl1ZHJJamlWbkZUNG02T3Q4REhEMXdSSlho?=
 =?utf-8?B?NE1Sdm55ZmpZdnlIRTd3MlhUM2VlVzIxU2JFamt0NklVeWtNN0pPN2p2bisx?=
 =?utf-8?B?dEFyeVVDR0sxT3krbGZ6dTh2RUlud0YxUjlQdTBNMmpWRjVVVGFLbDZkLysr?=
 =?utf-8?B?M081TWlsTXp0VUhkdm1jbnFFY2tBaW9Va29pbUdqMStUWkZqanNYQ3FsdWFv?=
 =?utf-8?B?ZVFOUzJJa25lWWJUYklnaUJqQ1hDcTFhSzU1ZzdySEVtOEI0SXpJb2NBWW9o?=
 =?utf-8?B?MFpERzlhazFPUEdxMkxQcklOcDI2VjlXSmtXOGVaSnBqRW5oYUVNdGQ3M2hW?=
 =?utf-8?B?Lzc3L2xNQjBBdUp3ZGhNNE9mRGwwYzJIclJZK2xVMWxHNm9zWm56MGd6R2Zm?=
 =?utf-8?B?QU5wSmlLOGhRMC9NaUIrMS9iU04rZ0luM0J5bVJOR096dE9FSGFvazcrM3dX?=
 =?utf-8?B?UHVtdFBFSVc0NFNwOWp1QU9mWnRNZjVsNnR5RDMxazdtazFOTi9tQ2M0VGhU?=
 =?utf-8?B?dnU3cHQzVnM5OTNhUEZSN3NxbGJtL2lsUUtWNE90S1FnRDJMTk5oT2I0NEgz?=
 =?utf-8?B?SW5wSzZuczllSGZNNUs3andZdCt6M3ZQMWhsaURsdlc2b1dnVE9iWVIyd21h?=
 =?utf-8?B?dFp2Z2tXblk0bHU5UjdnQlhKbXRUL09mN0FSMGZIY0JHT2NyNmhNalRVRWl0?=
 =?utf-8?B?NTFjUHF4Q2FKbGxQTU1icFBLbFRlb0ptbmlGZFBKZUVSTFF4RExDa2RWbE54?=
 =?utf-8?B?SG9WbVcybkhIYXZFZFUvZ1BvZW1ucHlZaThSYkVUOFJWVlduMGRTVmNWWkha?=
 =?utf-8?B?VXBlWlQ3MXdNK0lHdkFvUndic1EwU1hKWjlENldaZzc5U2VIU1hFQ0NwcWxH?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc4af48-2201-4f79-696e-08db70bfd303
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:22:18.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NiOuhGZw80TKwk3Jaq/dukysp05Bk/3F/HYo90unsndtF42PJdh8Vk7thWwkh3pc/DGuXJj9qXcyMED8LR4Cjxdt7HSrPLu9TJ5xkhD1kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/6/2023 11:35 AM, Jose Marinho wrote:
> This patch clarifies that both Armv8 and v9 are in scope, not
> just Armv8 systems.
> Also, ARM is re-written as Arm.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <Jeremy.Linton@arm.com>
> Cc: James Morse <James.Morse@arm.com>
> Cc: Rob Herring <Rob.Herring@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
>
> Signed-off-by: Jose Marinho <jose.marinho@arm.com>
> Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
> ---
>  Documentation/arm64/arm-acpi.rst | 41 ++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> index 47ecb9930dde..1cafe38fc7f9 100644
> --- a/Documentation/arm64/arm-acpi.rst
> +++ b/Documentation/arm64/arm-acpi.rst
> @@ -1,40 +1,41 @@
> -=====================
> -ACPI on ARMv8 Servers
> -=====================
> +===================
> +ACPI on Arm systems
> +===================
>  
> -ACPI can be used for ARMv8 general purpose servers designed to follow
> -the ARM SBSA (Server Base System Architecture) [0] and SBBR (Server
> +ACPI can be used for Armv8 and Armv9 systems designed to follow
> +the Arm SBSA (Server Base System Architecture) [0] and SBBR (Server
>  Base Boot Requirements) [1] specifications.  Please note that the SBBR
>  can be retrieved simply by visiting [1], but the SBSA is currently only
>  available to those with an ARM login due to ARM IP licensing concerns.
>  
> -The ARMv8 kernel implements the reduced hardware model of ACPI version
> +
> +The Arm kernel implements the reduced hardware model of ACPI version
>  5.1 or later.  Links to the specification and all external documents
>  it refers to are managed by the UEFI Forum.  The specification is
>  available at http://www.uefi.org/specifications and documents referenced
>  by the specification can be found via http://www.uefi.org/acpi.
>  
> -If an ARMv8 system does not meet the requirements of the SBSA and SBBR,
> +If an Arm system does not meet the requirements of the BSA and BBR,
>  or cannot be described using the mechanisms defined in the required ACPI
>  specifications, then ACPI may not be a good fit for the hardware.
>  
>  While the documents mentioned above set out the requirements for building
> -industry-standard ARMv8 servers, they also apply to more than one operating
> +industry-standard Arm systems, they also apply to more than one operating
>  system.  The purpose of this document is to describe the interaction between
> -ACPI and Linux only, on an ARMv8 system -- that is, what Linux expects of
> +ACPI and Linux only, on an Arm system -- that is, what Linux expects of
>  ACPI and what ACPI can expect of Linux.
>  
>  
> -Why ACPI on ARM?
> +Why ACPI on Arm?
>  ----------------
>  Before examining the details of the interface between ACPI and Linux, it is
>  useful to understand why ACPI is being used.  Several technologies already
>  exist in Linux for describing non-enumerable hardware, after all.  In this
>  section we summarize a blog post [2] from Grant Likely that outlines the
> -reasoning behind ACPI on ARMv8 servers.  Actually, we snitch a good portion
> +reasoning behind ACPI on Arm systems.  Actually, we snitch a good portion
>  of the summary text almost directly, to be honest.
>  
> -The short form of the rationale for ACPI on ARM is:
> +The short form of the rationale for ACPI on Arm is:
>  
>  -  ACPI’s byte code (AML) allows the platform to encode hardware behavior,
>     while DT explicitly does not support this.  For hardware vendors, being
> @@ -47,7 +48,7 @@ The short form of the rationale for ACPI on ARM is:
>  
>  -  In the enterprise server environment, ACPI has established bindings (such
>     as for RAS) which are currently used in production systems.  DT does not.
> -   Such bindings could be defined in DT at some point, but doing so means ARM
> +   Such bindings could be defined in DT at some point, but doing so means Arm
>     and x86 would end up using completely different code paths in both firmware
>     and the kernel.
>  
> @@ -108,7 +109,7 @@ recent version of the kernel.
>  
>  Relationship with Device Tree
>  -----------------------------
> -ACPI support in drivers and subsystems for ARMv8 should never be mutually
> +ACPI support in drivers and subsystems for Arm should never be mutually
>  exclusive with DT support at compile time.
>  
>  At boot time the kernel will only use one description method depending on
> @@ -121,11 +122,11 @@ time).
>  
>  Booting using ACPI tables
>  -------------------------
> -The only defined method for passing ACPI tables to the kernel on ARMv8
> +The only defined method for passing ACPI tables to the kernel on Arm
>  is via the UEFI system configuration table.  Just so it is explicit, this
>  means that ACPI is only supported on platforms that boot via UEFI.
>  
> -When an ARMv8 system boots, it can either have DT information, ACPI tables,
> +When an Arm system boots, it can either have DT information, ACPI tables,
>  or in some very unusual cases, both.  If no command line parameters are used,
>  the kernel will try to use DT for device enumeration; if there is no DT
>  present, the kernel will try to use ACPI tables, but only if they are present.
> @@ -448,7 +449,7 @@ ASWG
>  ----
>  The ACPI specification changes regularly.  During the year 2014, for instance,
>  version 5.1 was released and version 6.0 substantially completed, with most of
> -the changes being driven by ARM-specific requirements.  Proposed changes are
> +the changes being driven by Arm-specific requirements.  Proposed changes are
>  presented and discussed in the ASWG (ACPI Specification Working Group) which
>  is a part of the UEFI Forum.  The current version of the ACPI specification
>  is 6.1 release in January 2016.
> @@ -456,7 +457,7 @@ is 6.1 release in January 2016.
>  Participation in this group is open to all UEFI members.  Please see
>  http://www.uefi.org/workinggroup for details on group membership.

Not part of this patch, but while at it maybe fix the  http://www.uefi.org/workinggroup
that doesn't work - it returns 404.


>  
> -It is the intent of the ARMv8 ACPI kernel code to follow the ACPI specification
> +It is the intent of the Arm ACPI kernel code to follow the ACPI specification
>  as closely as possible, and to only implement functionality that complies with
>  the released standards from UEFI ASWG.  As a practical matter, there will be
>  vendors that provide bad ACPI tables or violate the standards in some way.
> @@ -470,12 +471,12 @@ likely be willing to assist in submitting ECRs.
>  
>  Linux Code
>  ----------
> -Individual items specific to Linux on ARM, contained in the Linux
> +Individual items specific to Linux on Arm, contained in the Linux
>  source code, are in the list that follows:
>  
>  ACPI_OS_NAME
>                         This macro defines the string to be returned when
> -                       an ACPI method invokes the _OS method.  On ARM64
> +                       an ACPI method invokes the _OS method.  On Arm64
>                         systems, this macro will be "Linux" by default.
>                         The command line parameter acpi_os=<string>
>                         can be used to set it to some other value.  The

