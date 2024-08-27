Return-Path: <linux-acpi+bounces-7877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E759960FC0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8885EB24F6B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B01C4EEF;
	Tue, 27 Aug 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vWkfQoX+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B52FB2;
	Tue, 27 Aug 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770894; cv=fail; b=M0pj6ilc2KG04WG6hQrn3tfEcZ5jtQf/WdQAzNNxgXpt+jMIlQii3EXQXqFsm8j+H8mIvieUrUWozGl376D0ielRsCphXW5fg57T6XPTTKfUOwAJAfd6r3tAwZ0jRTgVF8SCtUDcMj+R9O/9eUV7tJOG2Bnrj88poUgFuaewmuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770894; c=relaxed/simple;
	bh=vXW7hK1yKOiOfM7jl5RRODbICKWY7juo/A4NM47o7cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ac7FY9EwKkSJSHPfmSDV09G2CYYBRgkj6Chl1wS4jfVT7CibdwRojTDM9vlVe80NVu3eJqD+2txyHoO86vCSKKjeMsaN58fpwClvKEtM6/A6QX9n7rCHfOixYyGfx7QL8PXW9ZZt8KWedkTdbucRS58Kg0n6rSbtRtLFk+Oblzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vWkfQoX+; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMZ3TmplJsYiW3R0YKtpoD5dty5I9YPYW77h6W39zSAuslYze/OAK66tvJAOCBlQxWgeMLYKlvgHJaJzqcjECVh+Hge7pZN6H/3m6HOsnf0lpmjwhB1zSF1nEo8c6ElBLT4TpDafa2A/TAWhwpcF0iMnMTZy6Sz9DMHnhby7hGQZjsrZ0QzpICmgEI47lD03wpt/6mEfFIjnjukslDLmIrLo9Ufv8AFjRTx82FTm/HiDfM/k41GOc+LtPMBI5jO3EFs5bPn9wd33Aq7lvLt5DRoAT94+tGWbqHxIU4k1wS8DerGmIl6QVZ9/0BAg6nIXqG7REVUwQn2faDeDMYqeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFpZI41EqucKSS1VOt1W2kShYGfc8tFnXCgNAJ4tw/M=;
 b=GNtzLaPlBA4olAzyEzssue+c72LPx0tx/AceYNzSabOitNPIB8L8/bUGZAE6nd+4iXczhnP3tj/urQHYk7z2Vir31XHw1aLl9/OY4TDrvajkWrR3rp0JbUHcXpa08cbnt5fKI+Ag8D4cnqhEpjQSdXAf68xcZNlwe0fuI09EjPJgLT1fP74ut+V+FDR4vFEF8ZH/xDPxZshvt0EAzkYSsOfvzy3Fp4wkPxt3DEi/9XmUP3mDo0T3kcwTV73I621zfqppgUPdjVRPKtv3khXl8hxcuAPjaCPdZtp6gLtj5yWY6qXhq59OIG/A8D1/54oDwBg4v+Y9bt5wd5+24KKwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFpZI41EqucKSS1VOt1W2kShYGfc8tFnXCgNAJ4tw/M=;
 b=vWkfQoX+IbJCJofFsJd5A/6wZ96loE1m+a9VDJvqBoeg+aFt32X6q3hpuqzidGCiDySKNr2LsIsnB7GB8wt2bHLasHZPVQNMichfzU5wd8r/M+mtitWdyWw0P8vwebDr/PrxuTnf6f3CbvBh4Jdcl+MZYkV7HhIEu9fIlKOd4Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 15:01:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:01:27 +0000
Date: Tue, 27 Aug 2024 20:31:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 4/8] x86/amd: Move amd_get_highest_perf() out of
 amd-pstate
Message-ID: <Zs3qOxud6Ny7nCcH@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-5-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc9a65a-013f-4569-56ba-08dcc6a91fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ixt/VlPBScQiJuBGRvo0mW+sgZrm3kxPFbtOMq9Lasbbwa6JVCulIMJGnsUJ?=
 =?us-ascii?Q?Jp4rn9147QK41CeegEur93tqPPc/48UIc32cm8dYwhSEv0ezUvGXqQ3H6XqF?=
 =?us-ascii?Q?LSwNSSjxTz5+eOf82ZTYfoADAmZU7QIvf7uIj1hRjFZIaoAtUvaZ/sHbKUmC?=
 =?us-ascii?Q?RQEvB01/iCnXi1zYo5yw4D6nvkqu7+Td81JTJAxS24S4QnqgLYpA5zwuMB4X?=
 =?us-ascii?Q?JpSKlDn1OYk91v1frBMEN0TKsyDS44nBBlqbVdC53gMKkuEMVqDIfndkdP45?=
 =?us-ascii?Q?LgnYN9NKPYLKc28hg5rm+C00zvkJwOFlPSnaUnJLI12A6+dRz1oLHzgErG4q?=
 =?us-ascii?Q?K04HKHoS5QtAN+wVqaG3nFqPwhKCQm3Gg0HX0VmIvwkNqNj2WkQVC0j6VroS?=
 =?us-ascii?Q?HnycxBJEO8BdYnKO0Y/daRBZATjezkmHHoFpRhO9IQC70YzFwdIKiYMP33iK?=
 =?us-ascii?Q?RzoFNRM7Rs2SBwlyYmAgEpu73LxYRtvr7bkgzMkKHjvb8SQg+DMmIv4pi8XW?=
 =?us-ascii?Q?htJZpHDtZxghsfYjh5vMj+JyZIyVVTBnRWO98fRR/IOwT8Kx8bTn9uLoATo4?=
 =?us-ascii?Q?HBN8MaJWwJvk0NXdw4SnRK5hPqIHhP/8afz2DR3B6LIEUNfjxtfW1QwnbKry?=
 =?us-ascii?Q?BaqnegeML8NAkdjzCAPZKvBRRXN6sWKC1eSK5kXMygtYCuB5tqSWNLHKcxaJ?=
 =?us-ascii?Q?kX79bFLVnr9kJGh3qgHmrxVG82TA32WhJEvCfpJe/xUntgqiX1k1+qHyOkzj?=
 =?us-ascii?Q?67uZ/dIddCOnayUafexZ3U+Ds00hR6cqFUbPlz0Fdvq5qPcOJtslh89kWVaD?=
 =?us-ascii?Q?FACUrSfXfSGO5lnUagQnpmss5RTsViK62yD1AasA2Q71O6r3YcoI9k08vBVy?=
 =?us-ascii?Q?COoLfVLk8iX1qcRofqPL9nklkYlmLABEpAzsgL/BHGdP9SfT00y+EH3Dxyk6?=
 =?us-ascii?Q?ixgTu1jIXtw5XE4kXiuApwBEfmi77NsQmmLW4prgIXFtaWc+9+Gyw0IwIH4i?=
 =?us-ascii?Q?RbZugw52vp+TpuRJAY1af1nuFjxgjYO52VZsHc48GAYFbLu0QCdBGeXoQqzC?=
 =?us-ascii?Q?y+2V40huHonYbQz3hVMMhdJjOIMafiXLu9EWWHkyax9xwTR/Ag92en1AIdPz?=
 =?us-ascii?Q?vQ/FOH4cm6gmlmkFN6WZ/6oOaIrRQdUI2AOm+oD4ELUtMEIjwmYCFdG0uTfQ?=
 =?us-ascii?Q?IgfrcbVXLxO+ytB12KXMY8V5n/HMBIXJ4FcceUiabdS89ZFICRswORju8pfi?=
 =?us-ascii?Q?UCIha5u+QEaDPFoBh35jkx+b7Q+G8kb90Twv8iblDk9jg6z3c4EumooBfdpU?=
 =?us-ascii?Q?CUe86gC6qLtnaEIl0yXZuFzTMY9GQpQ/qJM2S4qtZ4AOMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WoGPcYx7kxoJLDiIfjDR6qzzpso0IX+O53NBlNwJtYl+EqWd5NnVP9wnydPH?=
 =?us-ascii?Q?tB+39/ILFoc4WFHn2G/sXEru49sRhlN9NoamzG8OuOeIObqkuJ2jOGZD7Vvg?=
 =?us-ascii?Q?o3n+X5ScGoX6gtlDbZBHl3FfXgQof5M/m0OKVVWe5NQKiqRupVmu5FDrwWGH?=
 =?us-ascii?Q?pCm6PNaCSkKew03riD5vcOGLo8dbGseOd0KBBZakUxpUXIpKlS8VCp8441Zm?=
 =?us-ascii?Q?BGKpCuW+6Y1BTA3bMaEEI6Q9y+ZEb6PAJ035/FCMVcZQA+0SJvPoEjvoei/r?=
 =?us-ascii?Q?GwUtua2q4w+OEUX9XxTm6v6TRl2cZZc6UYGPWgbTzKcUY7AJBtgSLt2wpuTL?=
 =?us-ascii?Q?AmNSrlZC7bCKAFHFT7DyPFJB2ksoT44JthSmED6rBmRU0/pPft67UCwNRicL?=
 =?us-ascii?Q?D/XRv3QBi5W5GZgtkl8MNhUsoBHzeSRkDtQLdK+1z4AN/jsJaTi1lgz4HT2k?=
 =?us-ascii?Q?Pfi1EdPiCkOQTBudmVW+SBMXHjAWEiMdA5jDJk6wOuXw6Uiu1W0b9quAiOdm?=
 =?us-ascii?Q?/Z6MdRB9DfVruzaNdDHl2IXoyAplyhuqubsmMF+nmlUMUrN8Z5GOFHYfYkat?=
 =?us-ascii?Q?EjtLlnm79qeHk8K5CA5w58lP/iWsl9Uu88QoqOLybIcMfv5vT7nnnYZIeMJt?=
 =?us-ascii?Q?bmX0pkfMFDJy8A2vvd75IavjA97Vql4zuWTxL9X3pHzqbQCXRyiPs1cyJmps?=
 =?us-ascii?Q?PkDe1+QcwPrPQP93fmr/pq5QpML7qfj7/sScZrDk1XgVswdqwj9zhQPRLtgJ?=
 =?us-ascii?Q?51TBjEANwW1egXkpr8KNmqZz466SyT+x0KvPzW3qjjaVywDVJWLHeP+5z2eh?=
 =?us-ascii?Q?dBw7kN3aa5R0x+uYcHgZu0XE10coyvoYKbZLKHI19rM8h5FD/zmzHOym5u+j?=
 =?us-ascii?Q?/CjVMKiIiuxfSZrFdhRbyrscysa/Dr3aXX0uUlQjwkLHSFOgD76CVUrAQm3E?=
 =?us-ascii?Q?NyXSfWfblusv1y1OzgifEMsFona99YjzsiPZePn4Y5p2Cs7Dy1xuHFWkd4b0?=
 =?us-ascii?Q?tG1HpdBxNF74XwwqPd9d6Hfo0+je3jknlpiYs2oLm9DoBoiWB/9cIQLKIXsD?=
 =?us-ascii?Q?fKhAkuXzlReOLqWa8NK/EAtzZ74PHp9IC0P1w3U5aUeVfNCoYznYXlzHLT/A?=
 =?us-ascii?Q?AOOsGoKkAQXKByxxoYglhaaNhs1u8fYI37INBLpt8TQtc5MqhsRAO80qwt5A?=
 =?us-ascii?Q?POi4o7Zf/1aEPl5JUC+Gw2G3rEz9as2tJ0dWGHtUmJASwkaKDmMumS6uw37/?=
 =?us-ascii?Q?UdLjdIRqBGFAToamIHZv1ldDNma5CyLB5a15X9Y+mTOSHX+f9gM1FlAp2uUO?=
 =?us-ascii?Q?TWXE0w5S7NhliaCT+qLzUNsM3T4nB2MVpD1uKnOX51HLUilsE9NVGQK+Nv3O?=
 =?us-ascii?Q?l10lnfGc5tq/58Zi0WJbus/2gT7PjaD5gSxleLzOvqrpr7OFxI01iW1WuC1i?=
 =?us-ascii?Q?g/iYWkqiE/8ydPp5gknmbFXekP0luraB/szZerEhDXprYu2pRUZjg/26up48?=
 =?us-ascii?Q?LsbJhjxaxXfQL1ZigKn/9YaYdK+SPlSXlGc8bD6IfTlU4uFub+aKRQmeizpt?=
 =?us-ascii?Q?/08jRLOhtYN8zit4GzhwWEZ2nxtHdFHGKiLVcxeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc9a65a-013f-4569-56ba-08dcc6a91fd3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:01:26.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75Z53Fs/LtxTURVTxhKW6n4Fb8djJZ797PeQpg5VKTDSa6oY7ZWyEwHi3bb1Oh9yHVS8WZr6CSNU5XkAJ2cFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201

On Mon, Aug 26, 2024 at 04:13:54PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_get_highest_perf() is a helper used to get the highest perf

Nit: amd_pstate_get_highest_perf() is the existing helper, that is
being moved to the cppc handling code and being renamed as
amd_get_highest_perf().


> value on AMD systems.  It's used in amd-pstate as part of preferred
> core handling, but applicable for acpi-cpufreq as well.
> 
> Move it out to cppc handling code.

Otherwise, looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.



> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c  | 30 ++++++++++++++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c | 34 ++--------------------------------
>  include/acpi/cppc_acpi.h     |  2 ++
>  3 files changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index e94507110ca24..5a6c01a1b0d95 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -119,6 +119,36 @@ void init_freq_invariance_cppc(void)
>  	mutex_unlock(&freq_invariance_lock);
>  }
>  
> +/*
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address for highest performance value.
> + *
> + * Return: 0 for success, negative error code otherwise.
> + */
> +int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
> +{
> +	u64 val;
> +	int ret;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
> +		if (ret)
> +			goto out;
> +
> +		val = AMD_CPPC_HIGHEST_PERF(val);
> +	} else {
> +		ret = cppc_get_highest_perf(cpu, &val);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	WRITE_ONCE(*highest_perf, (u32)val);
> +out:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> +
>  /**
>   * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>   * @cpu: CPU to get numerator for.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 89bda7a2bb8d1..f470b5700db58 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -803,36 +803,6 @@ static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
>  }
>  static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
>  
> -/*
> - * Get the highest performance register value.
> - * @cpu: CPU from which to get highest performance.
> - * @highest_perf: Return address.
> - *
> - * Return: 0 for success, -EIO otherwise.
> - */
> -static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
> -{
> -	int ret;
> -
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		u64 cap1;
> -
> -		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> -	} else {
> -		u64 cppc_highest_perf;
> -
> -		ret = cppc_get_highest_perf(cpu, &cppc_highest_perf);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(*highest_perf, cppc_highest_perf);
> -	}
> -
> -	return (ret);
> -}
> -
>  #define CPPC_MAX_PERF	U8_MAX
>  
>  static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
> @@ -840,7 +810,7 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	int ret, prio;
>  	u32 highest_perf;
>  
> -	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> +	ret = amd_get_highest_perf(cpudata->cpu, &highest_perf);
>  	if (ret)
>  		return;
>  
> @@ -879,7 +849,7 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
>  		goto free_cpufreq_put;
>  
> -	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
> +	ret = amd_get_highest_perf(cpu, &cur_high);
>  	if (ret)
>  		goto free_cpufreq_put;
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index f25a881cd46dd..2246ce0630362 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,8 +137,10 @@ struct cppc_cpudata {
>  };
>  
>  #ifdef CONFIG_CPU_SUP_AMD
> +extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  #else /* !CONFIG_CPU_SUP_AMD */
> +static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf) { return -ENODEV; }
>  static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
>  #endif /* !CONFIG_CPU_SUP_AMD */
>  
> -- 
> 2.43.0
> 

