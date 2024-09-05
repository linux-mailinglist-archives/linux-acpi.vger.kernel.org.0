Return-Path: <linux-acpi+bounces-8169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1296DC2C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F9B28482F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A80175AB;
	Thu,  5 Sep 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z2TRi63S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A417BA0;
	Thu,  5 Sep 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547380; cv=fail; b=UB2vcxKbBSF3egFZLqeqqA2VFDYL4dI7LtTKwFlSb38iMqwOs8T5uNLLSvBqqc2St8HTCn6FyUpylMXRMvYcGz6XU9r9+NsEXctiWF44IUVao/RZgh3EhFaWa9/slD5LhpVllvK6uXgMMsSWTU6Lcypp7peMy8e58pwA8iDbSGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547380; c=relaxed/simple;
	bh=HYXfI30TLRK3QQIHHs3B+mhN9UrzGt64e7AP5sfMiL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRGOcEGtzornBJPWey8gtFwVBkosdyrfcS0rLa7apLaO+1AeF5xJskcMxY5/SvJEC70S5Sh8K4Up+zjcO3ym6ICvAP4OatctkQcOqhuGYj4m5S4awcDYFgEO+8FVUkGt6EJtp4gVOgjBrObbqWWmJ+bQouV301y9DGNyZp5vIUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z2TRi63S; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuUw8+9MDQk/xvQqgNXfcI0PT8mYbg+61Ktz5WJMobGTVZQZ6eKKxRHo/gs0VJiAh/QbO5aUEGtAaozjI5FmsPxm7NBIY8Ho9hIIscCnpnzW+7QMVzOZl9CJXG5vQoLIOEHauWeCeBoJpYECITIEJ3OdX9wUpWv5YVXyqH6kYVhP6Ae0wz6sbGop7kC0VZQeq8CDDoZcy3KrEck5r7rFFDKUn6j90lpue5uCNEoQkRuRV/AoHuKeoQ6G6hi4jw4jIrhUC1yuP/pruiLV8zS3VaeRhk9AsdScl7wJjkNlrZjrJb1YJ2Z5rdInYlfSt/hcy0NdWdFylhKNNQblmOILTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX32UCFKV24uymXnhN5tFkP+6auhdrNt3oms72miQlk=;
 b=YfqPzE5eh2EQ/P/xD0HbPY2Qr1a6SI7nbaFdGU5cB55ui1iqqKQNIqLy1qGMPzfy/47AuNbrgFyJ0DReA/UFYpeew4OGlRVYDXD1XrmEsnF5UX+xcd6nWXiV0p3yTSrCPYM7gpYn+WVEqFQhL/eleIuRnQrhv9b4xS2FrNy5712tYFBAVVGNnvE/ClRm7nS17S6L9WGJ9fNCe3tYXT49obvg/hkPIkduR+lThJn3UqqRwvPT8RW+GU3DLfm5/4lQf5CxVnUY7urMY980fsnAvoCInS9YHQLZ3bGsjdvaZztX1UC/TfLCcCazQ9VpbSJwFWrW/i7HHtCLIfaK8bzoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX32UCFKV24uymXnhN5tFkP+6auhdrNt3oms72miQlk=;
 b=Z2TRi63SEKF1H2pAgNXDamLpq1ZyndvfeA65epQFarX4rzKkNiDA0BnNsGmcQWL3ISof99p4dvzAN3iKl1repSc//H5hpwWCxDhGZbCUKRRJdKpU6Sk82qA6c/yXBK7wXbOqobo1+Vno7ns8QVO8RFHIDxEy14Dhs3mFZc6Oego=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 14:42:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:42:55 +0000
Date: Thu, 5 Sep 2024 20:12:47 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 03/11] x86/amd: Rename amd_get_highest_perf() to
 amd_get_boost_ratio_numerator()
Message-ID: <ZtnDZ+b5A9Mfao6v@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-4-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4587e7a2-d7b5-4375-a4f0-08dccdb90735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4Jz/0lZ/I90jw7jBh4cfb5LtxzFOiEkZtq+GYnkLe4Q8rm7sLnRATZbPV0B?=
 =?us-ascii?Q?ABL8JkKt29IBti/GSt/7XO8ZiNRrrJc1+RXMxEoZgFTnH+0A4qsHF8vKiNRx?=
 =?us-ascii?Q?hX0naQdFyQXtB5uMt5L2IiTPkoypJ7Elxylp3goOzN0LxkX1DbPyhh3WiUlv?=
 =?us-ascii?Q?JiILffmfqx/6kzWhU/uGRwxegMPvc0DTW/Hf42WSVsji5Ex6WVDcquG4VcdZ?=
 =?us-ascii?Q?acuCeU1h/IceL1smCBO2mlPep4M46WLWbUqF+3Xi25qVgN+zmikJ+JCezfB1?=
 =?us-ascii?Q?zLb3lhgmjyUqA0oXsX2KHvZT9UfDda862Gz95KVUYfyivF4BsaO/XtegZtzb?=
 =?us-ascii?Q?tla0Wgfi+d2N8KgZ3x1Uw+jRjh0qdHs+XhLVHs0hKlnDmN0P+s3pclBgvFlF?=
 =?us-ascii?Q?ThZyo0NyBkUx7R2dsOvir6xCePEkfGj9v2UNgitABkgVjK/4x1J8N+8kpV0H?=
 =?us-ascii?Q?M6+6/Gy9lN6Izi/D3WgoI03nXDgR6LgE03fhEztDe4ozCmHIQGWgnfGXOKCI?=
 =?us-ascii?Q?QJmKhL/c6spl0P0jXzgWsIZIzBapaj0pls7FtdFzac+nOjYsts+i7dcwv7NO?=
 =?us-ascii?Q?/x92U48putyKVUUstaUkLkEIhYm+y56cTZ+SJxbLNtlJHk5vV36szZsjtkC/?=
 =?us-ascii?Q?5lMZ2miHJHqE/LO3kJ7C6BvkqvfcvRKD12NHIs+IOOaXLS88gGfFEUirgbpj?=
 =?us-ascii?Q?RJJ5jDZYwjbohYy12J1NkG+in1S00RGV+x5CbYnsZ+yE5gx2K7vDzlWt+1PD?=
 =?us-ascii?Q?ag/cNd6olIGPBmroB0X5zA0xHUyy2Xmf8YGNOwQNwkL2jdZXWb20FV+SsX9W?=
 =?us-ascii?Q?cjQwIukD1v0yws3XhOe4PWHUEYpqAGwRFu+JiPOl3MPqU7pchR/cpRlmdL5l?=
 =?us-ascii?Q?Vwoj4mOLXqMYevj4pmnUPx341Y7zg/gkosEaQBNA0gIb/nS5QeEK0e8/ltJ7?=
 =?us-ascii?Q?laFfbEC2zU/wHBM5bumFvlQc16WK1D/OSQWeqHc9JaAOmYYTWvBLDjhbG7sI?=
 =?us-ascii?Q?/F1Kobt0vOLe6zp6DRkCg5e7jRqq6IySoar/fEZp7mrpjfwwAiOK5JnQR3M3?=
 =?us-ascii?Q?zIiq/HsgumXV0U7LWLf66aEN+PYFlmOFhmTwB3Q64pa8HQZ6qf5eSIlIwIIC?=
 =?us-ascii?Q?iFcINaZ8tpJRfkoOxVN/L4FeLo2Och3lfU3yrunDytF2Cg74rR0GwD9eClxv?=
 =?us-ascii?Q?Ai63NXQkvZuy+JFOL6WBmmbR/P/g04MBoS4FmV/vVYrLuVeXswV1Su20OkU3?=
 =?us-ascii?Q?wFO3RXehyBeV1qEzv9eBrcDZEeodkea7Xw4vR28yj28kSHIfRXJsZaJmJEAb?=
 =?us-ascii?Q?cNvxgRcHkTdjn7539MqS1uIXY0Svl0L2LA+jxPldSDMRHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s022lQ11U0Lr/kRiNcfJrTViegXCimKVzMAjfvnURtTPoGoY+4B2PbZpJa/H?=
 =?us-ascii?Q?LM3xDfP/KNiMfmYtIzMVHmfQ6HbjVNGvgymGKbOAMnhuhjR27SvyBHo/a1gU?=
 =?us-ascii?Q?eHv6NEBD6GitiqHp/RZ6EZTZoLv1Th+zKWuWa8iKTBHyFXzqUVWcFeVS2s0M?=
 =?us-ascii?Q?llycZ/MiaP4qHnpT3cmmIZN4xyJDC0Q65eEXQhpPBgJWkUl6ei9XUh78NGey?=
 =?us-ascii?Q?Nz+NiPHJOf+2N5Bm+VLyCDkDnlLIuapsHlnX3pD6S3C8a2gLb64FAqOYvKA+?=
 =?us-ascii?Q?08x686UXcaimWB8h0Puu6KMo4Yo3W8XuuvgcDuuIs/+sJwOqWqBkOeM2Cu8b?=
 =?us-ascii?Q?zzB9uSomrXrU7H5lBX0lgOiYBVY+8bvguPL7bo59GjaYYU/W1R3A6YC/ecVL?=
 =?us-ascii?Q?ds1tQETSn/FSwgMYcT4lhxGoLmPjLYV1Sz+aIVL1s5/Bc5FEKrD3LdXffIPI?=
 =?us-ascii?Q?VEuTlMUIFWvhvigExaiNpaIuv8/He2hoqoCxGX/4iSXEdUoZilYH86Q++CC/?=
 =?us-ascii?Q?ZOjwh3VEprUKyKsylGDJEDE6VzAPR0d6uJH+YXGuDYeL3C0bSSdU9sAfAsaW?=
 =?us-ascii?Q?MIkoKyJrZF+lE3vyLxJEUWHLhjYchsN4iH4wpMAvl19DjgkAz2dd6UprNNkK?=
 =?us-ascii?Q?iRCVx3NyVqiGGHpWylVCqHlXLbhB61NjD9l63xRSi0yHEaVKEWhqAFChXEok?=
 =?us-ascii?Q?RKTG/HXztnD6x23RV4WxNMGp/cWuDvnYLfGQBagbOpkgdpera+If76u2HkZV?=
 =?us-ascii?Q?xLzsDJ+10qNSfj3Kz/J3SAf0wEpMvuGFQVzxMoIGMN0TLdIHM7kKIPBLTrf3?=
 =?us-ascii?Q?34zWoSJafLglrRQ+6pTR2W0X036gQNB8Hfjs/fUeY2F//YR67T6Ji+/aAd8/?=
 =?us-ascii?Q?dz9aUvpbhFfralEBZt5CFbdt0LimIjXX/J54VNXk720HBReiNIQPQMtXzO3J?=
 =?us-ascii?Q?yXTUNS7oHVpADPZpW4rZ65buVRc90LOzBnZWtqaErc9aVgBvE2dsDyWXVXbO?=
 =?us-ascii?Q?VAlzirsAO5YGNL9Gz7kAmaYqKFRHddmNhQ6VKzIKNqVOENsC1FW8vns416Zy?=
 =?us-ascii?Q?AFlFgooWYYIA/QBogaAn/l7VFeNJEQFCEwimIX/pDhjPJ+jdnmCuWOb9q8yn?=
 =?us-ascii?Q?uKnTMCpvcZOvkRqRLH4RZv0g+Brk15YN5IwUH2A8ClAjLV/TLn1woW5t3mhm?=
 =?us-ascii?Q?Rz6gXsw04eexy04x8gT/p87o3D3dpsFWGp9pCkGZ/X5kmvn6ufvu/FPfRD6r?=
 =?us-ascii?Q?C5EFxDUSSOgDe6OKrpwNuv2Xr1lcGlouOg0QylBhdWjFqLRThBpHSP1aEVdX?=
 =?us-ascii?Q?9IEY/Nj7hVsea3kguS/qLmLAcwf7ggzpVmJNA7bEIJGXBUVwJvRkFH3JLqHZ?=
 =?us-ascii?Q?IlkuxkYBPwZBTgtTs6Zfl9W13mnhLj3mA3JflmwxwZzpyzone3C6hTE8IRRD?=
 =?us-ascii?Q?dAsncE3Nz5NDPSPHFw29Zcga+NnvTxweBst2Q/Sitn0NeGjUklewDtxKoPa+?=
 =?us-ascii?Q?WqD60dm9lGA+e0vX0j+g/OWWrWmDH7WpgFEuBVRWu7SlnqJWfbylHrGcLwgt?=
 =?us-ascii?Q?Ur5JL+tVRMnRRrBtZaBjBL97sZg5Kgn1ZbVn0pY1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4587e7a2-d7b5-4375-a4f0-08dccdb90735
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:42:55.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLlBKEFOeZBdd4G35XKaLTkx3leanK4n+Vi3IAHaX9SH9PgKohSGwrcroTBvXa9qIJ3m4nFoUOXQ+BiJJ1S97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

On Tue, Sep 03, 2024 at 03:36:53PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The function name is ambiguous because it returns an intermediate value
> for calculating maximum frequency rather than the CPPC 'Highest Perf'
> register.
> 
> Rename the function to clarify its use and allow the function to return
> errors. Adjust the consumer in acpi-cpufreq to catch errors.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
> v1->v2:
>  * Rename variable from `highest_perf` to `numerator`
>  * Fail when unable to return boost numerator
>  * Move prototype behind CONFIG_ACPI_CPPC_LIB (lkp robot)
> ---
>  arch/x86/include/asm/processor.h |  3 ---
>  arch/x86/kernel/acpi/cppc.c      | 44 +++++++++++++++++++++++---------
>  drivers/cpufreq/acpi-cpufreq.c   | 12 ++++++---
>  include/acpi/cppc_acpi.h         |  5 ++++
>  4 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a75a07f4931fd..775acbdea1a96 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -691,8 +691,6 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  }
>  
>  #ifdef CONFIG_CPU_SUP_AMD
> -extern u32 amd_get_highest_perf(void);
> -
>  /*
>   * Issue a DIV 0/1 insn to clear any division data from previous DIV
>   * operations.
> @@ -705,7 +703,6 @@ static __always_inline void amd_clear_divider(void)
>  
>  extern void amd_check_microcode(void);
>  #else
> -static inline u32 amd_get_highest_perf(void)		{ return 0; }
>  static inline void amd_clear_divider(void)		{ }
>  static inline void amd_check_microcode(void)		{ }
>  #endif
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 7ec8f2ce859c8..660cfeb6384ba 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -69,7 +69,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  static void amd_set_max_freq_ratio(void)
>  {
>  	struct cppc_perf_caps perf_caps;
> -	u64 highest_perf, nominal_perf;
> +	u64 numerator, nominal_perf;
>  	u64 perf_ratio;
>  	int rc;
>  
> @@ -79,15 +79,19 @@ static void amd_set_max_freq_ratio(void)
>  		return;
>  	}
>  
> -	highest_perf = amd_get_highest_perf();
> +	rc = amd_get_boost_ratio_numerator(0, &numerator);
> +	if (rc) {
> +		pr_debug("Could not retrieve highest performance (%d)\n", rc);
> +		return;
> +	}
>  	nominal_perf = perf_caps.nominal_perf;
>  
> -	if (!highest_perf || !nominal_perf) {
> -		pr_debug("Could not retrieve highest or nominal performance\n");
> +	if (!nominal_perf) {
> +		pr_debug("Could not retrieve nominal performance\n");
>  		return;
>  	}
>  
> -	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
> +	perf_ratio = div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf);
>  	/* midpoint between max_boost and max_P */
>  	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
>  	if (!perf_ratio) {
> @@ -117,18 +121,34 @@ void init_freq_invariance_cppc(void)
>  	mutex_unlock(&freq_invariance_lock);
>  }
>  
> -u32 amd_get_highest_perf(void)
> +/**
> + * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
> + * @cpu: CPU to get numerator for.
> + * @numerator: Output variable for numerator.
> + *
> + * Determine the numerator to use for calculating the boost ratio on
> + * a CPU. On systems that support preferred cores, this will be a hardcoded
> + * value. On other systems this will the highest performance register value.
> + *
> + * Return: 0 for success, negative error code otherwise.
> + */
> +int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
>  	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> -		return 166;
> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
> +		*numerator = 166;
> +		return 0;
> +	}
>  
>  	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
> -		return 166;
> +			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
> +		*numerator = 166;
> +		return 0;
> +	}
> +	*numerator = 255;
>  
> -	return 255;
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> +EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index a8ca625a98b89..0f04feb6cafaf 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -642,10 +642,16 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>  		return 0;
>  	}
>  
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> -		highest_perf = amd_get_highest_perf();
> -	else
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> +		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
> +		if (ret) {
> +			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
> +				 cpu, ret);
> +			return 0;
> +		}
> +	} else {
>  		highest_perf = perf_caps.highest_perf;
> +	}
>  
>  	nominal_perf = perf_caps.nominal_perf;
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 409a7190a4a86..97861abc5f5b8 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -159,6 +159,7 @@ extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>  extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> @@ -232,6 +233,10 @@ static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 2.43.0
> 

