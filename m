Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FF7A4BC6
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjIRPWH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjIRPWG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 11:22:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEDBE5E;
        Mon, 18 Sep 2023 08:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9SkpCdO2HI6r5tQ33w/AvG7IuJqkbFflfaTssptXdG6cgL4jXzEpRpS9dLuNhnIMQl0oAiQtYD21w09aZ/mPZ5Knx7zAHnD94htmDb5KgBl5i9k7zCbb/+4Y+zX1YCT23v/cvn+kI4gzI+pgJheVjyWIgikFmqQ9IJZE9Td/aCH1nVN4/7ytkf8rmys6SjukQd4bfvj4KFjMjlUoYeiAOkYDEG46u3x7Z+vwSBNt0MG+05RBm+pO4M1GcoxN9FA9QH/teF48bqoBT/70Dv+glOqSrQ1phftARI/5GkGIxChHhpjMVtouuZN3HDGQv4XntQjD3jqppCO/5w5UboyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtjzNiSlJZNmrgdhhseOAOZvDt1qpMnHbheSkRktZk0=;
 b=QueWtp1jAMQvK067vViCVmyda3ecuU17MabBRO4fbh9ObddyrVQUZ+km/0crFi/Xn5j/ZuKqbeuPYPsFwl20S/0ovo49ZcQbmklyjreIFHtrIQmZM/rpTWUOhHONTwYkUFCJFzryNRp7HpCatJb079qTXIwux8GTSSjxh8bAAxuqgIoqcfpMp6IFvWqakQYLpnXCw5RcM7/0nmd5+s/n8KI9BLcvjhDoYeYd7tNccJ3pDjXF0MYLsYrMcYF1qq4Uo1/LDhMEoDSNPL4q63L/qWRj7RgfQXq/YGT9OzxWF8epvlbjnQ/cMVbIQmfVUoY/2qIe6Tb75Oh0OX7bhp+8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtjzNiSlJZNmrgdhhseOAOZvDt1qpMnHbheSkRktZk0=;
 b=Tj3Xfc2fRpmgyXKxE598IoOuQIweFa98clQZT8zOZkcznhPCR0QhoA73HSLYFprTXwOHN3SErNkAyfk4OlnM3i2y9Eljj/lWA7PIfJWEDXtThzJeqodhiU8HiwzfO37dG0pFdFGKKxtRLsd6NetrwdplA4mfddNvxZiYrMPHuuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 13:04:19 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:04:19 +0000
Message-ID: <57fb0391-dd90-4a1c-b67f-b24fe544f6e6@amd.com>
Date:   Mon, 18 Sep 2023 08:04:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [V11 1/8] ACPI: Add support for AMD ACPI based Wifi band RFI
 mitigation feature
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Evan Quan <evan.quan@amd.com>, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com
References: <20230831062031.1014799-1-evan.quan@amd.com>
 <20230831062031.1014799-2-evan.quan@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230831062031.1014799-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0039.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::12) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f5c89f-0914-4110-62a7-08dbb847c4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5Jc2V3l1WwzkCGee6eHNs0O7tyFeyqnWcuCgQXvccifw8MPxOBRAoBVKsCQLp1/P78Uvmgaqv4/XDQ8hW9piziDkAhA/oJ/pKlw4ZpuoaYnQ9w09onUIZOhLwQo3OBHtHtCAi4uYjDK/1C4a9IG63eA/jZgPLOxF2aR0O+3aB6o4T0q3sS32+VfvH3z0PiHVmZ9upve0NLBrPpvkXDLdbfK2/9XXlZcjP5ZrhvrAaE1D4xUbymY7nBVWQon7yO3dTsst7s/rj0FL211l4rSZ/yLtQKKb7EXLMAX/X49NkSGyW+u/XpFQ6GJBkpZRSis3UGai2fXGBUl68p6tn1HxheZ7yT8NOr0IGzq5yETYkNyd5J0s6N6jdl3S+dSH0nbkvIQmdh1XYJJAbOy2AAvLlNk8VCRoIUozFQMGeiKBiY5yfcWGrU57AFzeY7cht+mZq93Br19bizNyc16C86Udstzb9NLM+YtIx7bkfeWKjXsXP69Ue5DAY8u4ENHmWDb7PzLLJXQEmKB4oY30FX0AiwWGPsm4SsRZqj+SD5+gbQj4porBFu5wTHmfe5VhXv8F2GzJdS9hwfj2GVLZ72UG0lYwGe58sXKX2+B0I7skfLo7Ft3PCv0Y8hanRETJmykXU+UxYOajFIlVaYSB526CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(38100700002)(36756003)(86362001)(31696002)(478600001)(66946007)(66556008)(66476007)(6916009)(30864003)(2906002)(6512007)(6666004)(53546011)(6506007)(6486002)(8676002)(8936002)(4326008)(5660300002)(44832011)(31686004)(41300700001)(7416002)(316002)(26005)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBKQ24wT3Q2d0xqS3ZuS2Mwa2NYQkRqcFZFbCtlckVQMUlLdUNoeE5CTG8x?=
 =?utf-8?B?NE0zcGxPdTZIQ1pNS0tQWGQ3TmExMWhwOVBCVzI4MVp4WDdTekNSeHBEQVd4?=
 =?utf-8?B?UGhnRExzam5YcWFzUnlyTlU5Yks2Vng4Z0t6ZVVsQmFvaVpiblR5cUcxZjNC?=
 =?utf-8?B?Znk4V3pIckZtTFVkbm9iQnljZzh3OTUvbzA0MHhYRlVncm1EeWVBWHNWRi9U?=
 =?utf-8?B?MGduNmJkeEdGUWdrTWNzWmpqcGU5d0xlaFNHQXkrQUhmY2RSZXZXNWtjYTlV?=
 =?utf-8?B?ZlB3VzFCa1ZIWVpKMS9vWjhuTXFHVzVkblJRcWlkQW1jeDd6aUFzdHlQejhh?=
 =?utf-8?B?ZUlJTEVwblgwUEUyZFN3Q09XVDRSRVc1YlV6ZVBJM3Z2cVZPQ3kvTnJFYzFs?=
 =?utf-8?B?TUxoaUNyR2NNQm1vdmYxUmpXY29SVjBNdkVlTEM5b0hqUGFQcTBBdUdUcDU1?=
 =?utf-8?B?YUZ2UWM2UGRBd09KVHZrK0U0TUNFOS9DUVR0c3ZkdlovVFNYZG5lZ2xscWs5?=
 =?utf-8?B?U3ZKYWQrclAvL0FJUVBYRHEvTnFvTVFCaTJIU3cvNytpYnd0S0pVWXpoNUZC?=
 =?utf-8?B?VXhGYjlwT2lHSHc3ckxTWVdwQlM1K0ptMXZhVGVnNUorR2NQekI2cWJiMkN4?=
 =?utf-8?B?T2NvYWlOaGtLRURoZ0o3RGtHYU1oa2xHMlRKVjFlOVlqcGdtOTlLVFg4bWR0?=
 =?utf-8?B?K1RpZlZubzhraVBsaVJnVlg5Kzl0ZGp0MWxLMlpVQnFhWTlmaFFLcWt5eDY1?=
 =?utf-8?B?ckpxQWs5dk1pV2pheXhMODQ3a3ZOd1ZxbW5Zei9pWEoza2VJcFFOTUZ1Wk9h?=
 =?utf-8?B?Q3I0Yk1HT1BJVVR1dERtakZuTUJFeXprOVRPWjJ3aVhPeGVHR0FzUXUwYWlV?=
 =?utf-8?B?UWVwZVFEYnNlejA4UjV6eGVoUFMvbktycEl6clh1RU0weUFxY1B2RmFUNmNi?=
 =?utf-8?B?SEtGWUgwVFI3eEVib0ZWRnBIY29jeXF0WllIZ0t6eTBLUWlid2U4dFpwa3Jl?=
 =?utf-8?B?SW12UUNERjhZZURPTXdnZS8yYlF2aGRoWDFnMDRFR0tJQ3JHM0E1ZWRwNXJr?=
 =?utf-8?B?NU5POFhSQ0hSZEFIbElxUENyOU1zaTRuNzU1VUZ5VTFKbFFCRmIyMGduU0pM?=
 =?utf-8?B?RUp6L28xZGF0VWtQdHlUSDZvcDBwOG9pcUQ2UGNoc0ZzSEN3TjNmNVFqY1NH?=
 =?utf-8?B?cGJqanAyT2IvTXRpQWp6Z0tFcTlQak55aEpkdHAyWElVNXNLOCsxRUV4Tjh5?=
 =?utf-8?B?dEt6dXZXZ3RtbnBmRXExUWU4OFE1cFVmWmhxUWpkWWZuZjFoUkY4VWFTb2RN?=
 =?utf-8?B?VGtta2tjenJXU25hMTZ4eGR5Uk0xRXZYZnBHWW1mVzNvMjBoYU5iQTFxelc5?=
 =?utf-8?B?VWxVQjgyQmsvOTl5SXlLU3FxaGNhRzZOMSt5VXY4UGpXNFpuSjdNRC9NeDd0?=
 =?utf-8?B?SCsyNmZIWlQ4N002T3B0RlNLR1NyRzRHZU9Wd1NLTDVkNytza0g4SSs4OHhh?=
 =?utf-8?B?Ylp0bzE0RFNZdCtWMFkyOHVHeXk5cnpBQ1Z6WVR0U0tySXk0YU85SVRMU1pT?=
 =?utf-8?B?VzhwTTFPNkMyaERmU0Qyc2cyMk4vNmlRM25Pd2N5RVk2aDYvRXFzTmViRUZm?=
 =?utf-8?B?UEljblZudGVWNFA1ZW9SSHVEM05Lbk1ZOVpiMit1dGpsbkZ0VGdLeVZEUmV1?=
 =?utf-8?B?elppR1ovNlBZQ0xlSmU4cE5LZkUybEd2THV5bEhYQjlGd2U5Tk1NT2dGRFhp?=
 =?utf-8?B?dUg5Tzh3alYwWVNHNWZEcGZIcXpoZEFZV3ZsSVpNd2h6UFVTbkNYc3Rrb3ZC?=
 =?utf-8?B?UnZMU05VcEgxb0F2TDluOXYwVk9kaFVac0ZsTzVEY1dvVys2eDd4RTNvTkFT?=
 =?utf-8?B?Ky90TitIaU9FRWxBcU5BUG5XeGphZzBSMGUvVlFSaEpWWFdkRmUwekFEZkJt?=
 =?utf-8?B?QmszNkRIVTByOGsyUU5rUnBxNW41SFd0RGY0LzJRRFhWWVIvN3F6cURUVEp4?=
 =?utf-8?B?TklZUEFlZG1nNTdPa1EwdUFZbWFmOXFZN3JjZkR3dTV4YS9JTUV6Vi95WjR3?=
 =?utf-8?B?Q09sY2FFOW05c1BOenpBSUg3c1FLaDdxWEN2WnVuZmJmZ1RQeUZ1TzVvN01y?=
 =?utf-8?Q?cc2R7FmBqiHsCMMeXZIJbaOS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f5c89f-0914-4110-62a7-08dbb847c4ef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:04:19.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgP6zacAV1D54UYwYaQFVOOnqn6C+c/E3hPMZfskSoHoyJqBmJ/ScI9Y9czbiP7hXUn3bN/1vZgMuVim4WfpZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/31/2023 01:20, Evan Quan wrote:
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced a mechanism that devices can use to
> notify active use of particular frequencies so that other devices can make
> relative internal adjustments as necessary to avoid this resonance.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v10->v11:
>    - fix typo(Simon)

Rafael,

Friendly ping on reviewing patch 1 from v11.

Thank you,

> ---
>   drivers/acpi/Kconfig          |  17 ++
>   drivers/acpi/Makefile         |   2 +
>   drivers/acpi/amd_wbrf.c       | 414 ++++++++++++++++++++++++++++++++++
>   include/linux/acpi_amd_wbrf.h | 140 ++++++++++++
>   4 files changed, 573 insertions(+)
>   create mode 100644 drivers/acpi/amd_wbrf.c
>   create mode 100644 include/linux/acpi_amd_wbrf.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00dd309b6682..a092ea72d152 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -594,6 +594,23 @@ config ACPI_PRMT
>   	  substantially increase computational overhead related to the
>   	  initialization of some server systems.
>   
> +config WBRF_AMD_ACPI
> +	bool "ACPI based WBRF mechanism introduced by AMD"
> +	depends on ACPI
> +	default n
> +	help
> +	  Wifi band RFI mitigation mechanism allows multiple drivers from
> +	  different domains to notify the frequencies in use so that hardware
> +	  can be reconfigured to avoid harmonic conflicts.
> +
> +	  AMD has introduced an ACPI based mechanism to support WBRF for some
> +	  platforms with AMD dGPU and WLAN. This needs support from BIOS equipped
> +	  with necessary AML implementations and dGPU firmwares.
> +
> +	  Before enabling this ACPI based mechanism, it is suggested to confirm
> +	  with the hardware designer/provider first whether your platform
> +	  equipped with necessary BIOS and firmwares.
> +
>   endif	# ACPI
>   
>   config X86_PM_TIMER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f17..a3d2f259d0a5 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -132,3 +132,5 @@ obj-$(CONFIG_ARM64)		+= arm64/
>   obj-$(CONFIG_ACPI_VIOT)		+= viot.o
>   
>   obj-$(CONFIG_RISCV)		+= riscv/
> +
> +obj-$(CONFIG_WBRF_AMD_ACPI)	+= amd_wbrf.o
> diff --git a/drivers/acpi/amd_wbrf.c b/drivers/acpi/amd_wbrf.c
> new file mode 100644
> index 000000000000..8ee0e2977a30
> --- /dev/null
> +++ b/drivers/acpi/amd_wbrf.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
> + * Copyright (C) 2023 Advanced Micro Devices
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_amd_wbrf.h>
> +
> +#define ACPI_AMD_WBRF_METHOD	"\\WBRF"
> +
> +/*
> + * Functions bit vector for WBRF method
> + *
> + * Bit 0: Supported for any functions other than function 0.
> + * Bit 1: Function 1 (Add / Remove frequency) is supported.
> + * Bit 2: Function 2 (Get frequency list) is supported.
> + */
> +#define WBRF_ENABLED				0x0
> +#define WBRF_RECORD				0x1
> +#define WBRF_RETRIEVE				0x2
> +
> +/* record actions */
> +#define WBRF_RECORD_ADD		0x0
> +#define WBRF_RECORD_REMOVE	0x1
> +
> +#define WBRF_REVISION		0x1
> +
> +/*
> + * The data structure used for WBRF_RETRIEVE is not naturally aligned.
> + * And unfortunately the design has been settled down.
> + */
> +struct amd_wbrf_ranges_out {
> +	u32			num_of_ranges;
> +	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
> +} __packed;
> +
> +static const guid_t wifi_acpi_dsm_guid =
> +	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
> +		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
> +
> +static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
> +
> +static int wbrf_dsm(struct acpi_device *adev,
> +		    u8 fn,
> +		    union acpi_object *argv4)
> +{
> +	union acpi_object *obj;
> +	int rc;
> +
> +	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +				WBRF_REVISION, fn, argv4);
> +	if (!obj)
> +		return -ENXIO;
> +
> +	switch (obj->type) {
> +	case ACPI_TYPE_INTEGER:
> +		rc = obj->integer.value ? -EINVAL : 0;
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +	}
> +
> +	ACPI_FREE(obj);
> +
> +	return rc;
> +}
> +
> +static int wbrf_record(struct acpi_device *adev, uint8_t action,
> +		       struct wbrf_ranges_in_out *in)
> +{
> +	union acpi_object argv4;
> +	union acpi_object *tmp;
> +	u32 num_of_ranges = 0;
> +	u32 num_of_elements;
> +	u32 arg_idx = 0;
> +	u32 loop_idx;
> +	int ret;
> +
> +	if (!in)
> +		return -EINVAL;
> +
> +	for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
> +	     loop_idx++)
> +		if (in->band_list[loop_idx].start &&
> +		    in->band_list[loop_idx].end)
> +			num_of_ranges++;
> +
> +	/*
> +	 * The valid entry counter does not match with this told.
> +	 * Something must went wrong.
> +	 */
> +	if (num_of_ranges != in->num_of_ranges)
> +		return -EINVAL;
> +
> +	/*
> +	 * Every input frequency band comes with two end points(start/end)
> +	 * and each is accounted as an element. Meanwhile the range count
> +	 * and action type are accounted as an element each.
> +	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
> +	 */
> +	num_of_elements = 2 * num_of_ranges + 1 + 1;
> +
> +	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	argv4.package.type = ACPI_TYPE_PACKAGE;
> +	argv4.package.count = num_of_elements;
> +	argv4.package.elements = tmp;
> +
> +	tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +	tmp[arg_idx++].integer.value = num_of_ranges;
> +	tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +	tmp[arg_idx++].integer.value = action;
> +
> +	for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
> +	     loop_idx++) {
> +		if (!in->band_list[loop_idx].start ||
> +		    !in->band_list[loop_idx].end)
> +			continue;
> +
> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +		tmp[arg_idx++].integer.value = in->band_list[loop_idx].start;
> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +		tmp[arg_idx++].integer.value = in->band_list[loop_idx].end;
> +	}
> +
> +	ret = wbrf_dsm(adev, WBRF_RECORD, &argv4);
> +
> +	kfree(tmp);
> +
> +	return ret;
> +}
> +
> +/**
> + * acpi_amd_wbrf_add_exclusion - broadcast the frequency band the device
> + *                               is using
> + *
> + * @dev: device pointer
> + * @in: input structure containing the frequency band the device is using
> + *
> + * Broadcast to other consumers the frequency band the device starts
> + * to use. Underneath the surface the information is cached into an
> + * internal buffer first. Then a notification is sent to all those
> + * registered consumers. So then they can retrieve that buffer to
> + * know the latest active frequency bands. The benefit with such design
> + * is for those consumers which have not been registered yet, they can
> + * still have a chance to retrieve such information later.
> + */
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +				struct wbrf_ranges_in_out *in)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	int ret;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = wbrf_record(adev, WBRF_RECORD_ADD, in);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&wbrf_chain_head,
> +				     WBRF_CHANGED,
> +				     NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_exclusion);
> +
> +/**
> + * acpi_amd_wbrf_remove_exclusion - broadcast the frequency band the device
> + *                                  is no longer using
> + *
> + * @dev: device pointer
> + * @in: input structure containing the frequency band which is not used
> + *      by the device any more
> + *
> + * Broadcast to other consumers the frequency band the device stops
> + * to use. The stored information paired with this will be dropped
> + * from the internal buffer. And then a notification is sent to
> + * all registered consumers.
> + */
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +				   struct wbrf_ranges_in_out *in)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	int ret;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = wbrf_record(adev, WBRF_RECORD_REMOVE, in);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&wbrf_chain_head,
> +				     WBRF_CHANGED,
> +				     NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_remove_exclusion);
> +
> +static bool acpi_amd_wbrf_supported_system(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
> +
> +	return ACPI_SUCCESS(status);
> +}
> +
> +/**
> + * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
> + *                                    for the device as a producer
> + *
> + * @dev: device pointer
> + *
> + * Determine if the platform equipped with necessary implementations to
> + * support WBRF for the device as a producer.
> + */
> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +	if (!adev)
> +		return false;
> +
> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +			      WBRF_REVISION,
> +			      BIT(WBRF_RECORD));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
> +
> +static union acpi_object *
> +acpi_evaluate_wbrf(acpi_handle handle, u64 rev, u64 func)
> +{
> +	acpi_status ret;
> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object params[4];
> +	struct acpi_object_list input = {
> +		.count = 4,
> +		.pointer = params,
> +	};
> +
> +	params[0].type = ACPI_TYPE_INTEGER;
> +	params[0].integer.value = rev;
> +	params[1].type = ACPI_TYPE_INTEGER;
> +	params[1].integer.value = func;
> +	params[2].type = ACPI_TYPE_PACKAGE;
> +	params[2].package.count = 0;
> +	params[2].package.elements = NULL;
> +	params[3].type = ACPI_TYPE_STRING;
> +	params[3].string.length = 0;
> +	params[3].string.pointer = NULL;
> +
> +	ret = acpi_evaluate_object(handle, "WBRF", &input, &buf);
> +	if (ACPI_FAILURE(ret))
> +		return NULL;
> +
> +	return buf.pointer;
> +}
> +
> +static bool check_acpi_wbrf(acpi_handle handle, u64 rev, u64 funcs)
> +{
> +	int i;
> +	u64 mask = 0;
> +	union acpi_object *obj;
> +
> +	if (funcs == 0)
> +		return false;
> +
> +	obj = acpi_evaluate_wbrf(handle, rev, 0);
> +	if (!obj)
> +		return false;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER)
> +		return false;
> +
> +	/*
> +	 * Bit vector providing supported functions information.
> +	 * Each bit marks support for one specific function of the WBRF method.
> +	 */
> +	for (i = 0; i < obj->buffer.length && i < 8; i++)
> +		mask |= (u64)obj->buffer.pointer[i] << i * 8;
> +
> +	ACPI_FREE(obj);
> +
> +	return mask & BIT(WBRF_ENABLED) && (mask & funcs) == funcs;
> +}
> +
> +/**
> + * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
> + *                                    for the device as a consumer
> + *
> + * @dev: device pointer
> + *
> + * Determine if the platform equipped with necessary implementations to
> + * support WBRF for the device as a consumer.
> + */
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +	if (!adev)
> +		return false;
> +
> +	return check_acpi_wbrf(adev->handle,
> +			       WBRF_REVISION,
> +			       BIT(WBRF_RETRIEVE));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
> +
> +/**
> + * acpi_amd_wbrf_retrieve_exclusions - retrieve current active frequency
> + *                                     bands
> + *
> + * @dev: device pointer
> + * @out: output structure containing all the active frequency bands
> + *
> + * Retrieve the current active frequency bands which were broadcasted
> + * by other producers. The consumer who calls this API should take
> + * proper actions if any of the frequency band may cause RFI with its
> + * own frequency band used.
> + */
> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +				      struct wbrf_ranges_in_out *out)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct amd_wbrf_ranges_out acpi_out = {0};
> +	union acpi_object *obj;
> +	int ret = 0;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	obj = acpi_evaluate_wbrf(adev->handle,
> +				 WBRF_REVISION,
> +				 WBRF_RETRIEVE);
> +	if (!obj)
> +		return -EINVAL;
> +
> +	/*
> +	 * The return buffer is with variable length and the format below:
> +	 * number_of_entries(1 DWORD):       Number of entries
> +	 * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
> +	 * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
> +	 * ...
> +	 * ...
> +	 * start_freq of the last entry(1 QWORD)
> +	 * end_freq of the last entry(1 QWORD)
> +	 *
> +	 * Thus the buffer length is determined by the number of entries.
> +	 * - For zero entry scenario, the buffer length will be 4 bytes.
> +	 * - For one entry scenario, the buffer length will be 20 bytes.
> +	 */
> +	if (obj->buffer.length > sizeof(acpi_out) ||
> +	    obj->buffer.length < 4) {
> +		dev_err(dev, "Wrong sized WBRT information");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
> +
> +	out->num_of_ranges = acpi_out.num_of_ranges;
> +	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
> +
> +out:
> +	ACPI_FREE(obj);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_retrieve_exclusions);
> +
> +/**
> + * acpi_amd_wbrf_register_notifier - register for notifications of frequency
> + *                                   band update
> + *
> + * @nb: driver notifier block
> + *
> + * The consumer should register itself via this API. So that it can get
> + * notified timely on the frequency band updates from other producers.
> + */
> +int acpi_amd_wbrf_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_register_notifier);
> +
> +/**
> + * acpi_amd_wbrf_unregister_notifier - unregister for notifications of
> + *                                     frequency band update
> + *
> + * @nb: driver notifier block
> + *
> + * The consumer should call this API when it is longer interested with
> + * the frequency band updates from other producers. Usually, this should
> + * be performed during driver cleanup.
> + */
> +int acpi_amd_wbrf_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_unregister_notifier);
> diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
> new file mode 100644
> index 000000000000..c2363d664641
> --- /dev/null
> +++ b/include/linux/acpi_amd_wbrf.h
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
> + * Copyright (C) 2023 Advanced Micro Devices
> + *
> + * Due to electrical and mechanical constraints in certain platform designs
> + * there may be likely interference of relatively high-powered harmonics of
> + * the (G-)DDR memory clocks with local radio module frequency bands used
> + * by Wifi 6/6e/7.
> + *
> + * To mitigate this, AMD has introduced an ACPI based mechanism to support
> + * WBRF(Wifi Band RFI mitigation Feature) for platforms with AMD dGPU + WLAN.
> + * This needs support from BIOS equipped with necessary AML implementations
> + * and dGPU firmwares.
> + *
> + * Some general terms:
> + * Producer: such component who can produce high-powered radio frequency
> + * Consumer: such component who can adjust its in-use frequency in
> + *           response to the radio frequencies of other components to
> + *           mitigate the possible RFI.
> + *
> + * To make the mechanism function, those producers should notify active use
> + * of their particular frequencies so that other consumers can make relative
> + * internal adjustments as necessary to avoid this resonance.
> + */
> +
> +#ifndef _ACPI_AMD_WBRF_H
> +#define _ACPI_AMD_WBRF_H
> +
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +
> +/*
> + * A wbrf range is defined as a frequency band with start and end
> + * frequency point specified(in Hz). And a vaild range should have
> + * its start and end frequency point filled with non-zero values.
> + * Meanwhile, the maximum number of wbrf ranges is limited as
> + * `MAX_NUM_OF_WBRF_RANGES`.
> + */
> +#define MAX_NUM_OF_WBRF_RANGES		11
> +
> +struct exclusion_range {
> +	u64		start;
> +	u64		end;
> +};
> +
> +struct wbrf_ranges_in_out {
> +	u64			num_of_ranges;
> +	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
> +};
> +
> +/*
> + * The notification types for the consumers are defined as below.
> + * The consumers may need to take different actions in response to
> + * different notifications.
> + * WBRF_CHANGED: there was some frequency band updates. The consumers
> + *               should retrieve the latest active frequency bands.
> + */
> +enum wbrf_notifier_actions {
> +	WBRF_CHANGED,
> +};
> +
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
> +/*
> + * The expected flow for the producers:
> + * 1) During probe, call `acpi_amd_wbrf_supported_producer` to check
> + *    if WBRF can be enabled for the device.
> + * 2) On using some frequency band, call `acpi_amd_wbrf_add_exclusion`
> + *    to get other consumers properly notified.
> + * 3) Or on stopping using some frequency band, call
> + *    `acpi_amd_wbrf_remove_exclusion` to get other consumers notified.
> + */
> +bool acpi_amd_wbrf_supported_producer(struct device *dev);
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +				   struct wbrf_ranges_in_out *in);
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +				struct wbrf_ranges_in_out *in);
> +
> +/*
> + * The expected flow for the consumers:
> + * 1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> + *    can be enabled for the device.
> + * 2) Call `acpi_amd_wbrf_register_notifier` to register for notification
> + *    of frequency band change(add or remove) from other producers.
> + * 3) Call the `acpi_amd_wbrf_retrieve_exclusions` intentionally to retrieve
> + *    current active frequency bands considering some producers may broadcast
> + *    such information before the consumer is up.
> + * 4) On receiving a notification for frequency band change, run
> + *    `acpi_amd_wbrf_retrieve_exclusions` again to retrieve the latest
> + *    active frequency bands.
> + * 5) During driver cleanup, call `acpi_amd_wbrf_unregister_notifier` to
> + *    unregister the notifier.
> + */
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev);
> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +				      struct wbrf_ranges_in_out *out);
> +int acpi_amd_wbrf_register_notifier(struct notifier_block *nb);
> +int acpi_amd_wbrf_unregister_notifier(struct notifier_block *nb);
> +#else
> +static inline
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +	return false;
> +}
> +static inline
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +				   struct wbrf_ranges_in_out *in)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +				struct wbrf_ranges_in_out *in)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +	return false;
> +}
> +static inline
> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +				      struct wbrf_ranges_in_out *out)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int acpi_amd_wbrf_register_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int acpi_amd_wbrf_unregister_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif /* _ACPI_AMD_WBRF_H */

