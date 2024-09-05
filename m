Return-Path: <linux-acpi+bounces-8170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53296DD15
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6FE1C235FD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9219B5A7;
	Thu,  5 Sep 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eAnKvm3v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8613C8F0;
	Thu,  5 Sep 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548443; cv=fail; b=eDGdifhC3YeqgZXrN58BGsjfGcmYbFFQh0oSCiRnPIUGdbsUSQXUStw6pKkcmW4d4cvNtdPsYs356EjHnA+lsaEh2bhLDVnjWIGnVseyZGHr3oRJyYh+ttHPFZn4/ucC2ml1i/d6ogmZ5nyC4URgmLkEpIW8NycpP06TQx8w5Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548443; c=relaxed/simple;
	bh=GtuyLHJcMDRFNUBe4q67WPalhNZJRZvDEZdHoD7oxrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VrM5jXHuxkeQegwfzk4VEO/Q/HVMSTbPvmWmy3jl9H+uSZVh35kTFP6pTzpr82/RU3mFopDi1hhapCCd3/ht+9Mg6FFAIp9u7+T4AeSUY+KKoldNfp9CpzFGOoFqzX0Zaa/O2Hr0JaQ9GUuzP1fC/BGsqu4MvwhSRTbi8Ki6ye8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eAnKvm3v; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwVWZCU5iBmZ7CGR//5iMkgxfP/PS5EsgoobzXf7nQpkGHFtEAC8pU+21ZWXjgH8inbZueanTSQeeQ6cDUauXsKSm455L7wNK70icv5NEDAtiWLzro+9mOWWWXC7FYoIbNTMg0LYI+rR5vhrMzC6dDtbOrUmv7Ts82HfdBfnJWpbXBVzGU9BqjSdKCptTz/2uOZLirdpWH6jqh0g0FXsI53gkBYh8d55Wbv3OWiB6+gdv+uq08gIPcHSoZSOdN3hySZlFHACDPiB/6NwMwfyG+UxPdSMSziGFOTL5XI1PZ/bTKmHBkd7wa7hgvwbiaogxvjBilbhLf7mECfcttNFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTmj0uf5qWdyyEl8LSSEs1N3mDhw3bjsgvvlvr3AnzY=;
 b=fxsyKyEhcoPDScJIiimLDtjq/p0KMXPa70Jvzd04gNxG14YArNiciNfckQCI5fH+M1SAsnBq9Ny67lrl3/a6vKCasusnl8Lkg723vvyKGzedytdAz8Swtoano9jd3jDaZWh6/TB3suabieWIebivsf7BPgQhhrGAwpY7FZxZxf+PXsWYCxASlreoEZs0NpUdRnhd+C4Tvi/p5TkxQEZ7J+D2UfLuZ1GSkDugrDtsM2d+2q7/FBlBIuzM04GBs0YuCvL4E/ZVzeOV0tRo6uqEvveaXAdtVRebjIeXUZQDJDMHb7/J0OeG7QBLHtk9i7tamlgVAwwjd9MAOY5wVco6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTmj0uf5qWdyyEl8LSSEs1N3mDhw3bjsgvvlvr3AnzY=;
 b=eAnKvm3vLqjr4F6ZbddVYENcuGaoUQkuh+4rPlSF42Zhecdoo0YqoUoo5nOm0mSuBxvZ1j7Xe9ZkgArtsdT8nANTX4rDjeym1DAchpPwjXAwJJsjNZLa0AuctAcvMa+9HozKfaCkTp2+G28Nq0PoHSaLTl7LiZ6EqV3Xq+hkqV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:00:34 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:00:34 +0000
Date: Thu, 5 Sep 2024 20:30:22 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 04/11] ACPI: CPPC: Drop check for non zero perf ratio
Message-ID: <ZtnHhkyPmIC6WyfQ@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-5-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da6ba4a-eb2b-4cad-9a9d-08dccdbb7e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+vfaNjK3crQQXOwhKJFhCwoeuBXMIH/Bwn/CeSZJCm4Sl56XTvjzcciZO6sF?=
 =?us-ascii?Q?qDoMjiJzJKxzeSfvsiXC+zTqA+zma88k2FRNd3Ql3Tg8kyxqDKwpIY2G5uEd?=
 =?us-ascii?Q?usGBEtYj4P53eNRv/LgEN/rLa9bSu35l3ezWU+IvonaD7iQR2Y7xs0+xfqcb?=
 =?us-ascii?Q?XO1Xx4QhN2GWW4tsoHnmQlKXRi8Z3NqiS8xddSsZJ/BW1v9xwlaaFcy1DWGz?=
 =?us-ascii?Q?E/shBCxRiLSxgUxOwgZg035V/Bx0Hq0RW3chETUSh9tftEPPVEOPgM+HvH2R?=
 =?us-ascii?Q?dNhqby+l+ZWdg6dTHAEyf2EPV2A/3NsRRb/o0lV+hkfZHAUdz4lDF+ehp22F?=
 =?us-ascii?Q?QFGn9dvrknVZdILERNuoZOHOOH4tBlr93E1FqJcbyaRyxlqs5d9SC/kv1gd/?=
 =?us-ascii?Q?a2Ic3vE+EFTuUMiBpGHyRIfxiO2kPjmKcT0urtheWyuiFv6rqmKLoacOuHoE?=
 =?us-ascii?Q?DQ9zwCTOhtlHjJ2rUuHaisiS17HadcXm7Goh/gO3edvNC6b3VKnXxDocr7KN?=
 =?us-ascii?Q?ioh3AyZJBYUBjg1g+cLtRWGPVnr0hclGUlqJnTxon2RQTIG63KFyebIfTp5y?=
 =?us-ascii?Q?z2m6tlX2WOP25Msv5MrR8eKcUssacYib6F+IFLmaEKGBSe1pjrZ/M5XJ9h2q?=
 =?us-ascii?Q?mWgd6IHZygUzqtJSGDLnvJwqMizlwDBlbbFSnsrv/CfSII8s14j9FT8ljXlR?=
 =?us-ascii?Q?43pflCUsYrMSxpaigVCb34oX0UJuziTYSYmcpIurDwEjUclHaBM0191mn8v4?=
 =?us-ascii?Q?xxKAc7A1zAaI4GKL4PGZdh0WAovEWQhJxmtr7JQgtwJfBRYgF7J4SZECfIFk?=
 =?us-ascii?Q?MXxvzeLm1WY41Hwrcf481qGYEZWwjAGu9kF35L+i9nUBchtvJXqTx2fBSUIq?=
 =?us-ascii?Q?8+Y/XzwfGcF9HdbuQDmWp3DM+LzF81fFpFbmmfuiQQtTVIgTBoS+l34dW09i?=
 =?us-ascii?Q?EFKJ0LINSNsY+DKqAyvThFGUY2XSBGcyQXcqJ8P0otn21qX/k+UKaeQtCEOc?=
 =?us-ascii?Q?ZJ1FoctbOEmWZKESpKavMg7eCtPKcmYjgk1svrKYEhZZTAXy+l30U/R496I3?=
 =?us-ascii?Q?Qhs17yTk/XpYF7YtwTVnU6URJynSbH8dPwHYWRIJGUpbYN9a2gSJEqAfJ3ia?=
 =?us-ascii?Q?oxHCFqZFByYop/fI6SAQttedsJcN+NSSJxp1J0C9JfHkuEb8FhcS/ycTbyXW?=
 =?us-ascii?Q?miZMlPmqJj+6N8VIcNUZuN9O8VN/3pWQp1md+3Y6GRP2txni0JuPaPZ4HX8e?=
 =?us-ascii?Q?ZdDsbwbZ54c042eF3aweH+E3ah5AvV8Re0wwDVcnIBlm1KDtud1SHWLXYFYP?=
 =?us-ascii?Q?48FnwmOEWZzBGKPK7BYF2OkGx7SEsjxPNd15R4FyP0VQtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?raril6D0eO75M+fZ0ug6zghZHX0yMp50Q1z2j5qWcMUAW63IhpbkxkBsWng4?=
 =?us-ascii?Q?ld7gPUyi4zdmf61hmSjG1UFlM9oxtqLhjFdS4jM0RwmC8jz8K5bRvX6JX8Cm?=
 =?us-ascii?Q?ObR7YbpoAdctzKtOAVU/2ZHqKLUJRVZSS2TKGCS1y9cfcjahy0rNKU5pkiPK?=
 =?us-ascii?Q?z3UmbZGz49QCBmrVMedS/B+RjxGVQj2qnxelAvYaavttat6nolqTmGhrpygq?=
 =?us-ascii?Q?It0nL7CebmmjM8uvbLBDRsR+bzhoR7BJab0NxydCXZRIJWxsie8c2yNSErD8?=
 =?us-ascii?Q?DelA8hkg11549CVRdPDvLAJ/d7COVptD4tO7ipvrH4u9Fkbb1fQJBD4moLKk?=
 =?us-ascii?Q?UU/ojirPR8dGw1olI3DnjGuuYCN9/NrE6hrze7jgdgtWXFfpetYLFeRwGv+2?=
 =?us-ascii?Q?o4+ymybLHYTe8ZJl2SfB5LlfMkP1fV0jAhKImdwigkqSJFcn7EBnbgQd23aP?=
 =?us-ascii?Q?8l4KhFKe4CT2K3g5IgS6X8c9s1lf7aI5MCaXyN75Fnkx383I6t9zT4aXzvty?=
 =?us-ascii?Q?4J74epQZ5LDi7N5xvvJ21aOmpKmImrGVlHuav4fFXIvlJdfrzykKJLDL57Ey?=
 =?us-ascii?Q?DnlyHuZ8Z1gL+qQ2+FNvmnziGhuUsULK/E8C4UkcpEBvVXYYJKkIREwm8or2?=
 =?us-ascii?Q?Ugl1oVEOD+NIKHrHsP6podnA2PKzUY5GTs12gXXefx7G1RAZc85QD/29MMnh?=
 =?us-ascii?Q?PQnrHswRLGT+l4rN27HcGT0nE5CGp83BzbaMfktj1/Dm1wZFnxqrdUs1BUZA?=
 =?us-ascii?Q?ZNGr+xmVWKrKLnJKHJAkUzCZUxZvB9YBYjG7OGtnvUGAs2BzkCbh8elp0lwe?=
 =?us-ascii?Q?4uIDlfL3wpK9vcHQEVRpF2jug92MQAWA7PpxEhhVfaIXA6g7x97hg7b5yuV8?=
 =?us-ascii?Q?zkOJM+ApPwFTyKzOjO9gTUjvomeC94krhWkQY8txcK2DpFhPoWQM5fV9SScJ?=
 =?us-ascii?Q?ly7JHmg20/yofkXoITfnajMV4oBMrubcPgWarPSDFqTlgCEisC1lNt44Tofs?=
 =?us-ascii?Q?7QUmNxJ0CMZCrINoV509p0T7hTyepsWd5MWqjrr9kap4Gqiiprw8UIXG12aL?=
 =?us-ascii?Q?sWps0rzTYKOOG16/7QRQCxvpAzNZurnN6UNg8vEqbd109IOGoWMyPfJbbmJg?=
 =?us-ascii?Q?MNJR9kFmzBa9/jvChs9S6O1XofbpQp8ePxhKKzE+IEMWxhVtpE5H83x7n/LP?=
 =?us-ascii?Q?3bXs/jra9mwXRfv2qP47corKgF0KbFbsdnLeQUQK9yZZB0A2smUDw8kxzloT?=
 =?us-ascii?Q?HUPmYrJUrwxcyuncAtQ3hZwZcY61j4aRPWjSfHq7Lfb4W5eYq3BhmT0fGewI?=
 =?us-ascii?Q?e8L5CT+HA3moldgnKCbePusL3ZXZuiKINTQXH4LhkHe16mz2EihyZbLTVtfY?=
 =?us-ascii?Q?qYzz8HSSd49jBe8RNw3E7bxS+qcaymbSX7xEYVlDik4kVwvYtC7Ytx/cs6T7?=
 =?us-ascii?Q?M9VDC+gpVLUI5iYHPmN08iBLBYM0LUwF3MumCjiuPUWAOLWrILdtH0LwJxRm?=
 =?us-ascii?Q?0oCS3cgChZflv3KBSfLBE4fwxEHxDeXv4QLrvI5aAPmfHJOL6ZGzcdF2CgM/?=
 =?us-ascii?Q?vJDhlBe4jNqoASQrc4whTMe4mF057dq13+Nky2DY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6ba4a-eb2b-4cad-9a9d-08dccdbb7e40
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:00:34.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET/ZYSYW78uzI/WWtw0oCN9MDp/CYypRN9qrg5qhoXAT3F9qHEgUgoJ8uJmkBzhTENMcu8YPRQQjg2r4mROz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608

On Tue, Sep 03, 2024 at 03:36:54PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> perf_ratio is a u64 and SCHED_CAPACITY_SCALE is a larg number.

s/larg/large

> Shifting by one will never have a zero value.
> 
> Drop the check.
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Other than that, LGTM

Reviewed-by: Gautham R. Shenoy <gautham.sheoy@amd.com>

--
Thanks and Regards
gautham

> ---
>  arch/x86/kernel/acpi/cppc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 660cfeb6384ba..e65c77afab318 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -91,13 +91,8 @@ static void amd_set_max_freq_ratio(void)
>  		return;
>  	}
>  
> -	perf_ratio = div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf);
>  	/* midpoint between max_boost and max_P */
> -	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
> -	if (!perf_ratio) {
> -		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
> -		return;
> -	}
> +	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf) + SCHED_CAPACITY_SCALE) >> 1;
>  
>  	freq_invariance_set_perf_ratio(perf_ratio, false);
>  }
> -- 
> 2.43.0
> 

