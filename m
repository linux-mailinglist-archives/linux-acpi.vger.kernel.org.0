Return-Path: <linux-acpi+bounces-8554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C698FCB3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5B2B21A14
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC64DA04;
	Fri,  4 Oct 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bw6w3zyT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933A4174C
	for <linux-acpi@vger.kernel.org>; Fri,  4 Oct 2024 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015303; cv=fail; b=nCAYsItcM7+Y18cxuaIHQPoqkjsr9EqeYre9q9xoyZ//F2X6tEMWtcytxyyLn9zNr+eipE0h4ynk6mey4PU1mDKpzoesCQ3idUI3I0Ht5ThaoqeTQKtwhJY6Yal7fDJ8Gp5mjmQsWBvjtZ/i0b6x1Qv69GFu9f/JgQpwZdvBECs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015303; c=relaxed/simple;
	bh=Qotf7y6kc/Lj4Vn4fHALXN/POT9aBxiWUbD0YoU6GO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivHo/LaBnDr0fwRI/AqBwG1RVE46gjbBUZjmjAfLWNHoyO1m8Li++A3qQ3YoNg3qZk0TeraR5ls1Sv8gIFBYLu7p8Nq4h7N7CobkQVZwuMWDCaFhBIyW897zWiw252QpNZCs1ESW0dvtaHfknCPTvkH1oMl4BSzAxSJ3TuKIHAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bw6w3zyT; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWF/ZdD826QRv9PoZ44j36uGDWmiUhVJkpyYjLcaemGwwzAlXgjhhzdT/+51x3LWMEToBI3R8M3if8kFg3Atxsmatgi82w+b8bVSu09f7wPkCbbmclUHp7Bfhtt4SAU6Gnikb7jw9Lfk8aOvNKOSkuvvIYXT9XPJlB0h3Sl6ShVINW7QDfH9hBsArgqf89+rVQJD9h2PCWM0mHqu5+m7C+KPumSm0j3K43qJ/0u23vDzxFEss99am70MsB1RWONePJILtmOkc1SKIM4dZSR2UzC1OFg5hcFi1Krg1S9ANwFrksKL/TY5ynNpFkAXKPYXTGhssCPrYrOYQSX+FcC0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpNxLQd08NHI3uSjKicBdWFRp/bMtN1qNZCTVKVn8GU=;
 b=XkykwHpMhW0qd2sRGbh89nqjugNP0W4jegt+8aG3gUMTEQZYTpXPwD7WK2RpU+/of40/Z0rT3pl5yVW7zc7Dm/ySIQABP8Nwas4q1avNaCJDRPmaob1IZrStOSwJ/i2ZY2vm2pgGjYX9O0ssxN7fjhvPeDGj8do7fFoTIuoozVWwjjgM+od2v7be8TH8LW/btR0Q6rsj1iepnV28jEeVLdUqAsPq9T2JIGEG+fu+gZZL9tMjCeGRPVhPYddBrusm9B4+n1o9KJBB8CwWnhoU5UJuiYIGClPmbx/XYdrc8wyhK5qMa+zGe8OcleC3/gkVZn0QQJaY5F2DUTuv0+vzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpNxLQd08NHI3uSjKicBdWFRp/bMtN1qNZCTVKVn8GU=;
 b=Bw6w3zyT+Al9hyGAiOJTqc7LyzsJul9CSlceKE+O/EedATdje92RwgnedPsY68dEaqry/oSr4XCdm7uwCgGpxR5fg2f8NSAPRTXpHHMtxb6u+FVCwrOhgHypcyWxXrpWqZ//RNxM2rf3U+ZUUaRMIkCDwIP+7isfXcaAzlPUIAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Fri, 4 Oct 2024 04:14:58 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 04:14:58 +0000
Date: Fri, 4 Oct 2024 09:44:49 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] CPPC: Use heterogeneous core topology for
 identifying boost numerator
Message-ID: <Zv9rucmgxfSjU2v+@BLRRASHENOY1.amd.com>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003213759.3038862-3-superm1@kernel.org>
X-ClientProxiedBy: PNYP287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: c52b4695-ae1b-4791-3b7b-08dce42b1bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGUo4dSnsD2R2AeyypZIMVddvddqKO1rY0NwPbaar66ylK3YEonNzVrlZwfq?=
 =?us-ascii?Q?lHyT6B9tz4EHdem8WpDyO1SQWVES9pCniE2O7tzg8dC/MZiFhO4pd88deuPb?=
 =?us-ascii?Q?x0Gtk2iADzIv9FWDcDaKLU6KVRqyUzndnHEdY8vuXRHSY1FJQNtilnaWIx63?=
 =?us-ascii?Q?ycJkNl9iu85OefJR2RbWph3gCSRxLtl2UmNypky0+os8qWBn99W/vcPWTZIM?=
 =?us-ascii?Q?+dCpNHPnSQ1VHR5MOvQfgqf6Ds968giTFW5bf1PS5t7EjceEvYszr3UD7nf6?=
 =?us-ascii?Q?dEJCqGstOXq9wbI7oMrfIY4Q6ZZ3xmHSKe8BY/8R7RcGavWrO8JHSEF4I/68?=
 =?us-ascii?Q?0xPyM8h8mpjTTbvqUGuo2FF1pZXztTwpYuWuell/h0MKhWfQ5r1K6cyeubo0?=
 =?us-ascii?Q?xH+RlezhcwVmM73kszGhy/Hezltp1IXOgWgvb2Nh0g9FuAnGs3bMAlzlJTIv?=
 =?us-ascii?Q?lOFhWXnis6r+tA03/atUJSH+RwWSgtAEq+vAcfFqsXFVQetq21wzGn/OHgN1?=
 =?us-ascii?Q?13MBP1PVSKshF54y5ZdLgODqpNsPpusFv2WptqxGGWOUW57kOUgCwAoz5un3?=
 =?us-ascii?Q?I8t7OzW00pKUZMAbM6EQtbxPDdKjUU1ktdGlX+N4xBTLXo+3uu/g1DRZ+cY0?=
 =?us-ascii?Q?X+WkJo8OcwODXgblWKuvY6Fb2+YobGddIGgu7uiV37AY+gFe9BCNrJ/JkLjE?=
 =?us-ascii?Q?e5DEIngWxOpvJyPyjUArU8Y5zFf25/VqoOvzHRPYvfpxfQoYXl0CvnEbG2yF?=
 =?us-ascii?Q?tbMzP/OynX56sbqu1yvX6hEBYe9BpNTRQgt29z+8luU6Yub9avqnAvROCv88?=
 =?us-ascii?Q?X4GCAKH9AOLOl2V7bWbexezCwcBrlk0KdjkXQTXVLZsBWvU8ujdj5qhtUZ9D?=
 =?us-ascii?Q?zQu3aIecZ1ifog0w0bY2EIO0bS1Cywjx+gUrlAlF+1zdfSseX9cQ0zB4OHqe?=
 =?us-ascii?Q?Q/K8kDBFduG1gAiE3NT8SgagXSoaMKK8tNwc3e2zJjuueVfk8gZBdC0dydZV?=
 =?us-ascii?Q?YjnkLJaoCr9bBBSSg9SXnBKAISbUat4shNmH0hBodssJbVvaaJYSX3uEAVNL?=
 =?us-ascii?Q?eaQDArwvabBzjWV2Rq/OnZF9ADFavSsLeBZMLWi7BNNAlvsvv5Yx8nddzy09?=
 =?us-ascii?Q?kdY1HQO+q8zdC0kcczSGTDmgh/ZB+tlBzF3w+Yy2paKMmCvVT9l2Xvphainl?=
 =?us-ascii?Q?Ozg12LaoV/FrP7MUyJZX5lMauDdu9JPhHRz9kv0xaNdT/wCImK8PzeNSV0nX?=
 =?us-ascii?Q?z0OTYLAYxSMNaA8ONbn98eSA6cjVht4NtH8nKTW98w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/todS8fXGcztqsIde3wehWGGFL/AgbgNcCScImTYHdLk6zjVHU2WVz6zwgbQ?=
 =?us-ascii?Q?8pCBABCuDD9Hi0xFI5WRx92mOPYyd7/AU0t72fCT5woCb9J8zr85UINgsNHX?=
 =?us-ascii?Q?mclvfFcg5PwJPbe6Q54/Hi2U/jwxPT/oHLHb93+t2sBQ0O7lA58Guvofn62s?=
 =?us-ascii?Q?Nhi3BMrlrjJ7FNvOSIHOVv0bEZW3ipJXKMHzoHhY6TMdntMFhaLwBtVHG1Dl?=
 =?us-ascii?Q?pA23n9d9hJKKVDEkN8pIgL+LGUvDMXm3llxjTgGzY3dEBRZtoZTVHLLl1/6i?=
 =?us-ascii?Q?p1HuHMnD8N1JHzOjGjwMVhXZTRw38VSr7RADVnoU5zXHEAgLe9/gGgU+Zlmu?=
 =?us-ascii?Q?AOMLUVR3dc//bw8gthussKbO/8xFxZQoFCxLuPnWYit70Nro5pTZypkah+Ht?=
 =?us-ascii?Q?FRXtMpDGXMqhIyho399EtT8/1kW9zpNQs5eC2p9iZ+F1F+XLpTtl4ixZhGQN?=
 =?us-ascii?Q?zOIQZjIQ7oIf7FB/7R55Gn6bnn6VNK1Nje0mvNlmf4d5XhbD29iCUISO7rmp?=
 =?us-ascii?Q?pHfUbVhWEcGSsEpznXh8K7tQYq0UwQV8AU4UH5BlcCN/qsmUXlZ3z9GtXhA3?=
 =?us-ascii?Q?ffd7R3KRzHDZYZY5qS9n5bUzUQCDlQrKjKjVST0iMXB5OVGTTsC/POyU2FAi?=
 =?us-ascii?Q?E2n6MmIfSmZnY+JLdgQbPhuzimqK+t/pSiUUz1U41/pNQxqlO+97eSU5Qw8i?=
 =?us-ascii?Q?O3Dlu9M5Dar9EAMeQ8m5NGkqPrDi72GbQPDrGq63v09oa+35EssiSK/8yPBg?=
 =?us-ascii?Q?eskkF00GPek438Hel1t140ZYKzk8xYiTcDP1Mqx5umgZgGlKvgABtRa4SKb9?=
 =?us-ascii?Q?J0GMHkEa8Rt5fhm9RwaAyfRT2QsbXgUVhRt9tpZRocUIDzAehWIOyEWhE/FZ?=
 =?us-ascii?Q?5/zZQt9OiHfMu0afNUi4JQN2PwBTMwIg96/9CGKGP+4qcI1GqtQRnZp8AWSK?=
 =?us-ascii?Q?9zm6lY6ZyXIpnqwC9MTtAgc/iTMiQNM0ijOKKujZufB/5MOyoPKkgZtKHs1C?=
 =?us-ascii?Q?RCf8QAcSERLuzlOvE5b3t7Olvs4nHCvlc6XAsA8Na1tSUnrpDli4jt8Yi2KM?=
 =?us-ascii?Q?bBAwBzsIEQEQoPrd4W04bO+JSpiQMcAW3TuMJ8XKCgn8rm8SC8SG/r/eN2P3?=
 =?us-ascii?Q?cqAUqeXij/z9aJCBNIVOdAFeUu6cqIyJAax2+mo8qmDqGKt4Jc7JZzIQiW4+?=
 =?us-ascii?Q?PxjbsMpUhlFIe4C8lYJbdTjmmaUUnm9stWttnq7p6vJT9+47L7kRY5rEW5Vg?=
 =?us-ascii?Q?LX88m/5gay4BiyO8rsZeRWnbakxdyTcXKYnqfysXrn1x3xjL2++2BmFPC+E4?=
 =?us-ascii?Q?Ouy89TFBd9RyXyyt2Ns1c/02DV+B8dPyGshJDv8fa+uZuGSKBuPMy0vonN+t?=
 =?us-ascii?Q?jxbCY89dHLAl4HxCAS7o6KB5KvPWEReMunohzD9iufN9XAeOS/Xhm3XOs5Vx?=
 =?us-ascii?Q?UEim0WC5NQr7oDv9QkWVGJAOLESZEJvSlTl7yHCDiBbe1/BCgrZxC08UrhCZ?=
 =?us-ascii?Q?W2tsztoufkSd2d/A46wennngSf0GUG0X5ypIAXrDusJ/cLFBDnPM5vBIWtyc?=
 =?us-ascii?Q?uV5ULyGGBh/2gQW0hbLm2EmLkjLdoT6Uh02d5WE2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52b4695-ae1b-4791-3b7b-08dce42b1bc0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 04:14:58.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qyh1QohidLCDr9Iz9F00/FC9AItt4oikm0Kw5tPw3DT15FNEcvvsPDESrCshQ1Od35g0lmTYejgqOJbb+J50OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Hello Mario,

On Thu, Oct 03, 2024 at 04:37:59PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> AMD heterogeneous designs include two types of cores:
>  * Performance
>  * Efficiency
> 
> Each core type has different highest performance values configured by the
> platform.  Drivers such as `amd_pstate` need to identify the type of
> core to correctly set an appropriate boost numerator to calculate the
> maximum frequency.
> 
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the SoC
> supports heterogeneous core type by reading CPUID leaf Fn_0x80000026.
> 
> On performance cores the scaling factor of 196 is used.  On efficiency
> cores the scaling factor is the value reported as the highest perf.
> Efficiency cores have the same preferred core rankings.
> 
> Suggested-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/processor.h | 13 +++++++++++++
>  arch/x86/kernel/acpi/cppc.c      | 30 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/amd.c        | 29 +++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..d81a6efa81bb 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -691,6 +691,14 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  	return per_cpu(cpu_info.topo.l2c_id, cpu);
>  }
>  
> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
> +enum amd_core_type {
> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
> +	CPU_CORE_TYPE_PERFORMANCE = 0,
> +	CPU_CORE_TYPE_EFFICIENCY = 1,
> +	CPU_CORE_TYPE_UNDEFINED = 2,
> +};
> +
>  #ifdef CONFIG_CPU_SUP_AMD
>  /*
>   * Issue a DIV 0/1 insn to clear any division data from previous DIV
> @@ -703,9 +711,14 @@ static __always_inline void amd_clear_divider(void)
>  }
>  
>  extern void amd_check_microcode(void);
> +extern enum amd_core_type amd_get_core_type(void);
>  #else
>  static inline void amd_clear_divider(void)		{ }
>  static inline void amd_check_microcode(void)		{ }
> +static inline enum amd_core_type amd_get_core_type(void)
> +{
> +	return CPU_CORE_TYPE_NO_HETERO_SUP;
> +}
>  #endif
>  
>  extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 956984054bf3..ca289e6ec82c 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -217,6 +217,12 @@ int amd_detect_prefcore(bool *detected)
>  }
>  EXPORT_SYMBOL_GPL(amd_detect_prefcore);
>  
> +static void amd_do_get_core_type(void *data)
> +{
> +	enum amd_core_type *core_type = data;
> +	*core_type = amd_get_core_type();
> +}
> +
>  /**
>   * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>   * @cpu: CPU to get numerator for.
> @@ -234,7 +240,9 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
>   */
>  int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  {
> +	enum amd_core_type core_type;
>  	bool prefcore;
> +	u32 tmp;
>  	int ret;
>  
>  	ret = amd_detect_prefcore(&prefcore);
> @@ -261,6 +269,28 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  			break;
>  		}
>  	}
> +
> +	/* detect if running on heterogeneous design */
> +	smp_call_function_single(cpu, amd_do_get_core_type, &core_type, 1);
> +	switch (core_type) {
> +	case CPU_CORE_TYPE_NO_HETERO_SUP:
> +		break;
> +	case CPU_CORE_TYPE_PERFORMANCE:
> +		/* use the max scale for performance cores */
> +		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
> +		return 0;
> +	case CPU_CORE_TYPE_EFFICIENCY:
> +		/* use the highest perf value for efficiency cores */
> +		ret = amd_get_highest_perf(cpu, &tmp);
> +		if (ret)
> +			return ret;
> +		*numerator = tmp;
> +		return 0;
> +	default:
> +		pr_warn("WARNING: Undefined core type %d found\n", core_type);
> +		break;
> +	}
> +
>  	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
>  
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 015971adadfc..8ad5f1385f0e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1204,3 +1204,32 @@ void amd_check_microcode(void)
>  
>  	on_each_cpu(zenbleed_check_cpu, NULL, 1);
>  }
> +
> +/**
> + * amd_get_core_type - Heterogeneous core type identification
> + *
> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> + * a CPU in the processor.
> + *
> + * If the processor has no core type support, returns
> + * CPU_CORE_TYPE_NO_HETERO_SUP.
> + */
> +enum amd_core_type amd_get_core_type(void)
> +{
> +	struct {
> +		u32  num_processors             :16,
> +		     power_efficiency_ranking   :8,
> +		     native_model_id            :4,
> +		     core_type                  :4;
> +	} props;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return CPU_CORE_TYPE_NO_HETERO_SUP;
> +
> +	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
> +	if (props.core_type >= CPU_CORE_TYPE_UNDEFINED)
> +		return CPU_CORE_TYPE_UNDEFINED;
> +
> +	return props.core_type;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_core_type);


LGTM,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

