Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EC7598C7
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jul 2023 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGSOrt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jul 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSOrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2023 10:47:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF4C7
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689778068; x=1721314068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0iJqwCsDdUnPPum6sCOst3SKPgnSuFIyk3sf10PmSTo=;
  b=Ke4Tog9+W0b+reYCuIv9u6lkwYpni9KORfS7843CfvzeMIHzLeDBv+LV
   +bw9RntvIsxBB9l+EjgfF4aJ14cYUNgICJWxM/1Bckl9g9TXiWqEqbykX
   lxk0StytufG7M+8HPQxg1suLx1rzuyU3VkI94DGuWikJCF1yrAt2zgcFH
   9XqkJrTsnkI1d6Me4y5UJBc+bi8xJr/nbhYGPnPPVxpq55cv2kpE9ZE0J
   VOqaFTcmjseLwdB4onjlh9KQ6AEtccqOiC4GPapYMMo9ui3zsBPSTSZr+
   AtyDdUT2RWfeyVT9fXk09PiUim87g7LR+31AURaPfC2gQP1IUdvruRybk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346789990"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346789990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 07:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867505771"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2023 07:47:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:47:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 07:47:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 07:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+d6YeOle7MdHyfAvnl0WsmsSU3Y/R5C688NeI6y/p+dyUlcYNHMrOPOF43abbD5G1oqUOKOtMad2fsXgllWWjpZsMI/J7pQvggLE5ISHL+bD23sAAYcL8+setCIPvLNEIKaaWWeEvc5Tyc5Bmg3A8LrF6w2sAS01sw2/+4Q/tQzp60Kzgk/qTvu7W41gDWqLXw3Ip38XMyNcXrvWuZmRF97l6WdNW77l6XCIM+2ND8jQpxJ4xB2hIg5ggPvfFFoIv9g+qa1vwlPFKG4C04xnzs3noMpL/YwcjW89YHoT8IfEkjZAwtdK8sC77TwtTnMG8fyTCCwsesGgUmgVfNasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQF7dcuUhytHI27xtD7pX1Hd1X0Cygo0dELGT44jcuA=;
 b=LmJ1/RyHjf3CS/zKwvbNyLej1evRXIahWfpc8u/QTNwQQ9difhwlSGbgKcnbRvGOzk+mllZkr5pNH6qzAtaXScAGQcperZLz66Uu3LO3R3yvP2cceGiXKp6jve6+H7EHaUatRjGy1AQK1BeGwKBY9FV/KypBlgB9Ed+b7QKAbcr2ItS0DODmqXNncCe1x9M7tXuFStp3VLcikPbZApicPE7BLSEGycNDIcIxIaikdQZakuxZkZsDnucKvJczZXZXRVsmLdKa1WFbd9Y5IBzMhFud054abnbiPZ+IIaJ4O45iZPOAxz47Z0QeHNv6bIPDt2QCf3nvU3eQgnqqtIv6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Wed, 19 Jul 2023 14:47:37 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Wed, 19 Jul 2023
 14:47:37 +0000
Message-ID: <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
Date:   Wed, 19 Jul 2023 16:47:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Content-Language: en-US
To:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <robert.moore@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20230717150047.15196-3-cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b95b95e-e782-4ceb-916b-08db88671880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3meG9sXXSNDUPHES5NaWDHJr4uxtbMqehqJlSVXoTjRfAiI0/hHF5sbVOeuZRixkHatwShuBhv/ckBUFZ+8sBp8cxCchxstuqjmRiD0IbOy7y9lMl+rBeITl5tGY5T9jv90Nk644FmaksP0zoqUSamPsr/xDB4Z1HHOHIuKNZ+v2iwn5TV9/G2pf72Fn/2ilYliAgW0KuJw7Xe4NRnW02LYIiBR4vkq4aknwwHzzw8JHy1DOLMePT+/RQSnbkcYM/JTyNOsokGruz008FSyZMHfMh5B4tvNtA1HENL56qsOWae1Cb9X80OVI86YEvdSPmHGjwc3eYKK90cri4z4S4K2uWqNp3zWjzrvUDIBvY8+GbIhaeef16VAQrr1lsn3cGqZFzElL1NRQhike7BcoKi33xSfFdX//BzStN6nBj3AW77RBDRV1oVYOmvPIsMoScBguWBO7jVXD9I3TrarBVB2zW/qJcHg0tYMPI8XYocUUISFLHxnXz6wrbcVSnTjp6F3D7nGh7pT3x6ClNQFgoQN66fh6ayAsI0ZhayWZoGkhTYB90uMI1EJoZFYbi18o3D7YhdJsjiN2MXenMKFV3wIFOQFNLUep2diHRk32hmEU/MsG0fLJ5Q92dsAbFvrzSSZoUEURN8P1wavAF+CHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(26005)(2616005)(316002)(53546011)(41300700001)(6506007)(6512007)(186003)(83380400001)(31686004)(6486002)(82960400001)(478600001)(6666004)(4326008)(44832011)(66946007)(66476007)(66556008)(38100700002)(5660300002)(31696002)(86362001)(8936002)(36756003)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJOUENwU3gxYlhMVlFOd3BZQmpncUNTRUZrWWdRWHhYenJYWmllelNsWUF6?=
 =?utf-8?B?Y3ZXaFZLd0p4UlVMS1ZLenhwTTZjNHVJYXNmSHJqTE9vS1ppWmR3V1lQYS9T?=
 =?utf-8?B?SFpjNEdtMEVpMFQwQlcwN2pWNU9mSkkrQXhyWkRsejlSSUgydXRLelhFdkll?=
 =?utf-8?B?RTBTWUNtUHZNbldrVnhVT2VGaW5HYWFKdFNYQWJiY2s4azN2TUNoNDF4WDNq?=
 =?utf-8?B?L2xUdzBnMEN4UDAvMHZCL3JZNEMxVGZJVGVqMWgyQXZTcGlhb244a1p2cVIz?=
 =?utf-8?B?YWZCSWhTU2JhMUZnazhFSDVHakRTK0JyUGdBVjU2YmZiZDhSOTVWT0NoMC9q?=
 =?utf-8?B?eVVPTjI0T3FkSFBjN0pyVVlGVjlmQkM1UUp5S0ZLQ3gxc0J3dy9wc3lQNGww?=
 =?utf-8?B?WW1HKzVhS1JKMXFvTk04Mld4MTUxTi91QnBRTWR5b09Ld2ZkWm8vOTlFL2Rv?=
 =?utf-8?B?ZmpSa3A3elJxL1VWMkR3WTVTUUFUSkJVL0Qwc3FpSVlnNUxuZmJkb2V0V1gv?=
 =?utf-8?B?UUJLdnUvMTVrYit1dG42L1Jqa0NQN21mc0tiQ1VZc0VmeDB2OTBIZ284REtZ?=
 =?utf-8?B?Y0Y5K25nd0EyMU1GWWx2bWlTOGNQcXF3OUJDdGtrUTZzemQxeFhWVVh6SzM5?=
 =?utf-8?B?KzJ3L0dwNzFMQWN1QVYwc3pyL1FHQS9sS0ZLV1dWUFFvUDJSS3NpanhpaFRk?=
 =?utf-8?B?OWM0ek96OGpQdzVISEtTdGkvNHpGdmtDVFJGNzZrMFN5aVgrSUZrcnZZVWhl?=
 =?utf-8?B?aFVmZUVjbDJwak5FVDJzYVdEc1dxRytMQzV1Nk40dWpEYXd2enNPV2gwY1Rn?=
 =?utf-8?B?aDBCVTZ4ZUtDRHNCYVVxTWw5ZE9hSGFEeDc0YUpVRXNJQmNQWmxtVEFKUTlj?=
 =?utf-8?B?NFBjTlladGxwNk1haHdobkxPd2pKNVJxTzkranlsZW1WSGNEcFJVRktkdXJa?=
 =?utf-8?B?R0VVeHVMR2FFQXM5Q1hSbVZQQ3V2blJDdnQ0QWVBUTdVeVI5TFZldkdtREJV?=
 =?utf-8?B?T0h2cEd1T1VRZDFpbHV5dFZ3a2xYaFdhYVFxeFcxdHpwT1dDcEUxb2h6MDJ3?=
 =?utf-8?B?NVJEWDkvOUJwSlE0UkZXZU5Bb2VjbEpKTDhkOHNxOUJVZVN6RGJRbk93L2VC?=
 =?utf-8?B?MzRqK2w3V2FiTmxDdk1zNXhIS252TVpwcjBGUkdvTlViaDBCckFBU2Z3NDl4?=
 =?utf-8?B?NzYwMVFoZTdSbVV5cEVvUk1RdVAyd3dWV2ZoN1BDajZMMjdrVnRmVTZQWDB4?=
 =?utf-8?B?RW9ZeGQvWno1MXNMVXhRcGFBWnFZZS8xOVNlVXg4TlFDdUNyTHlpWFJmYjJM?=
 =?utf-8?B?TmdrTUN5RnhRb2FHSFQ2OU9ad1luN2JlTFQ4WUR0S244ZXBQeFBsUG5VV0VP?=
 =?utf-8?B?NGN5aXFsa2pTdmkwZHNYc1kreTgvR1F6eTRwWTAzMDlGWVY4bUtCdWVNUktw?=
 =?utf-8?B?RUZ1ajhGa2tEZXpxYk9kd05tVWNrQXpVTDF1MU05NXlOU0JncDdkUGg5VUVV?=
 =?utf-8?B?eHJyaTU4d1NIdW9sNUpscnBrSUpaaXllbjVYcmV2MjJxSWJJM3BNVlZWd1cy?=
 =?utf-8?B?VXMrMTRuMlpmTEdPMHJJayt3N0lKSkFCN3dhVklvRUp2QXVpc2N4cU4zemhl?=
 =?utf-8?B?TWl5OGMva0ZnOTJzZkI4amlpamYzM2JQYTNXWWNCdGR1RzRZYWJjcnZvaWRi?=
 =?utf-8?B?MjRaZ3VUMDJwb2hhSHBPNmNoc2EvYW5uVzZlOExydDByUzNKdVB1bW03K0pa?=
 =?utf-8?B?TTg0SkNJNE04ODU3Z1p2M2p5em1BbjE2MjlRTHlTOTg2TjFpUVkrV1IzQTgx?=
 =?utf-8?B?MFhBRDZHblA0SmZrR01MWDExdGduSlVzSTVHckdnVjJhSWJJVi90VTNvQUJM?=
 =?utf-8?B?ZGlGWnRWZ085T3pSY0RVTjdjM1BxOWpLL2ZQRDZPd1BDQitTK1ZLOEthWEJo?=
 =?utf-8?B?QnBnUzdXMnM0VElGb1hrNEp4OXBZOWZCa3Y2ZGlubW5pWkhINkV0N0dDTU9N?=
 =?utf-8?B?SGExaElKdEN1d0U3ZXlCdk9WbmM2QzVwcndqQURPNm1JUjNNQnlMVnM2VDRM?=
 =?utf-8?B?S2RmaG5VMXExRXk5MElsOStPZ0lqOGVocmE1bnlDSjVvbkg5RjhmOGptdmFH?=
 =?utf-8?B?N0I0K0dseGhpSHAyNnFMZFcwTm5qeHB2RXh0UEVaT0FQRFRkOTRXdGFGeUhP?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b95b95e-e782-4ceb-916b-08db88671880
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:47:37.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6c6wiU9Ah63tLNauEm40/b4wVF1fqw7xDL2aU4/miH+d/wh+lBXLl10zIFLo8IeDR2y0b0POvH6Jogn5qoBs+TDrYpd36EeEkQ5s4bOIUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-17 5:00 PM, Cezary Rojewski wrote:
> While there is no strict limit to amount of NHLT tables present, usually
> just the first one is utilized. To simplify implementation of sound
> drivers, provide publicly accessible pointer. Accessing it after calling
> acpi_nhlt_get_gbl_table() yields the first NHLT table met during the
> scan.

...

> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -594,6 +594,9 @@ config ACPI_PRMT
>   	  substantially increase computational overhead related to the
>   	  initialization of some server systems.
>   
> +config ACPI_NHLT
> +	bool
> +
>   endif	# ACPI
>   
>   config X86_PM_TIMER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index feb36c0b9446..8de34970e7db 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_ACPI)		+= container.o
>   obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
>   obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
>   obj-$(CONFIG_ACPI_NFIT)		+= nfit/
> +obj-$(CONFIG_ACPI_NHLT)		+= nhlt.o
>   obj-$(CONFIG_ACPI_NUMA)		+= numa/
>   obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
>   obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
> diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
> new file mode 100644
> index 000000000000..90d74d0d803e
> --- /dev/null
> +++ b/drivers/acpi/nhlt.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright(c) 2023 Intel Corporation. All rights reserved.
> +//
> +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
> +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
> +//
> +
> +#include <linux/export.h>
> +#include <acpi/nhlt.h>
> +
> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);

This approach generates a problem with undefined symbol "acpi_gbl_NHLT" 
when ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is 
disabled, symbol is never defined.

Proposed solution - modify drivers/acpi/tables.c with:

+#include <acpi/nhlt.h>
+
+struct acpi_table_nhlt *acpi_gbl_NHLT;
+EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);

as tables.c is always built the symbol is always there.
The only other option I see is:

-obj-$(CONFIG_ACPI_NHLT)	+= nhlt.o
+obj-y				+= nhlt.o

and modifying nhlt.c so it's essentially split in half with:
#if IS_ENABLED(CONFIG_ACPI_NHLT)

but such solutions stinks. I prefer the first approach.
What to you find guys?

> diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
> index af3ec45ba4f9..a2b93b08218f 100644
> --- a/include/acpi/nhlt.h
> +++ b/include/acpi/nhlt.h
> @@ -13,6 +13,24 @@
>   #include <linux/overflow.h>
>   #include <linux/types.h>
>   
> +/* System-wide pointer to the first NHLT table. */
> +extern struct acpi_table_nhlt *acpi_gbl_NHLT;
> +
> +/*
> + * A sound driver may utilize the two below on its initialization and removal
> + * respectively to avoid excessive mapping and unmapping of the memory
> + * occupied by the table between streaming operations.
> + */
> +static inline acpi_status acpi_nhlt_get_gbl_table(void)
> +{
> +	return acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header **)(&acpi_gbl_NHLT));
> +}
> +
> +static inline void acpi_nhlt_put_gbl_table(void)
> +{
> +	acpi_put_table((struct acpi_table_header *)acpi_gbl_NHLT);
> +}
> +
>   #define __acpi_nhlt_endpoint_cfg(ep)	((void *)((ep) + 1))
>   
>   /*
