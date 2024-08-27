Return-Path: <linux-acpi+bounces-7872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A13960D30
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399B61C22F87
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF111C6F53;
	Tue, 27 Aug 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NqKzDhwd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620C1C4603;
	Tue, 27 Aug 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767707; cv=fail; b=LU+736vix6F0GuYZ5HebEfxmWt0sOngr/HU0zXIotfjFlMx3FE+Nds3zxWIg+39MjLlvGTYrnW3MaSy4vsu7TDshgoZGCRK40fglrRBFTEZT71PsJhaoOowzgZDSmvJI5nrsPVS8mozd8F90oKkAD0w+egcUT59pl/VvjhORMKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767707; c=relaxed/simple;
	bh=SEw5sOagwpRBk1rR8JAkA6LuQe5U22gkK+rmQL9Rbeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbCX3FQeXsMMi4V+amtR6QwBqS91au7gDgN3n2TuEOm2/gcwzBUAWQNOC9h2pBjHglFVQjC8fxbJstCs3PoT6GUF+84AuWl3QmRN3LfpJ4xZSRtJYXmMoV0E0yO/3bfWTjhCWIojPUEZtOPnM5byJ8nZyQrPgHRET2xJ9nP06vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NqKzDhwd; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fhr0fjjC5nXWg3rl/AA/t6UkB3XqKuwgtDma/E00WnTPaS+b6QFoz7ubJfmCi6sq3STAx9ah6MNHVaiGKtuO5iW1w7HK0iTb7l8oNn1ljmn7y8GEh6TdyxORx34XXRi4zdHlq/f7OVtbe+5YwANV/GIVnBEUFZh7UHTHwAMIqLhIZKmxjy9BUEHw9I8AoZ57pSiL+miZTG4cdKUqlei5Mczibklv7rgKwP/MTBIeWiJafeSZuRbGtgAE+7QXJq5sosv2tavYJNJgO1D8YhkxeQLhktZ+kZeebFmeAK3Ls02SS9mlwjRn3TuVOmZ1ez9g+CiZrv61IKJN2wVw8BspHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DMplxYT3OyuPu1qmfKzEsw8NhlPH4qxxlxeBVRZ+OM=;
 b=p99ctTjTGbcwbWvACbDXZQhBjWwfHHuDH9RgCXqT43pEdLbEzfa5tRhyrLenHnSxdOTDdnv+L6rVdfVJyXnQdoE+NYO5VUbZ7HOT4dFrEDA1pYqQL3vSZ8aXh3AG3bTxIuR2b4R+Pxt3MJXEhESa71uPedMZUFpnvLUaCkRXakt2JbxbnBABlj/oznKbk2zKALAe0wMHawlrYVN7XA690oTQ2iMb7Wrqn/NZHdAcH96KpQ3tfJVnbYSq6iNfkZduvmg/529ykuH6BHOBsh8Sz9X3ZYj40f+oUDB8gE9oVbDXxNIV/RvHXLOCQ5CCLqrHisTJW+2pmOBCAgEd2VXb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DMplxYT3OyuPu1qmfKzEsw8NhlPH4qxxlxeBVRZ+OM=;
 b=NqKzDhwd9p8Zn1YI2xELvk0A3l2dn4tuLNMTSKvuP8wMA8kx1tmTgEDgUBJU3nfLkTMC3EfkFOlqTn1sFefIXfDdF5Ez9FOnTwJdLrgrqxdXyPJb0krIiqnV7KSPu7H7lhuLi1j43vs9xEgF9uF5DMsFm7azYrNcMXeIzeGG830=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 14:08:22 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:08:22 +0000
Date: Tue, 27 Aug 2024 19:38:13 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to
 cppc.c
Message-ID: <Zs3dzaUO/H+klIGM@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-2-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 009094bf-93c0-48e8-7e85-08dcc6a1b5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfxMTzpjV7rnU21h1KpBWpIU50/husw8soQowCGJ/zyyIbuV+966ouxtXuwe?=
 =?us-ascii?Q?f0B4vhoDY++pgsrnPTjBWQSfM2bTDq4KiSADoenVdhditpDrJbN59NtRdJ6J?=
 =?us-ascii?Q?6e7jnVILa6FxtLkbS+v8K3EXbwA6TgIkU9EbcYb/O+GlOjpR7aPLj5YVwZ7N?=
 =?us-ascii?Q?jAiIW9wRQV6f1/Z9SSBgWMyhAkbduY6waxkrAS9B65vqUNqgZPsRCGcWKv5T?=
 =?us-ascii?Q?wfGBHmg7N/a4ZfofSaV9GfFTxHXy7obkDB5bHVpor+SLJM6XQbBn7Z9TQ2SZ?=
 =?us-ascii?Q?VFdt9OIxGEjsxDMij8tSxlcEC75BewGv1k8LEFQBV64zAK7oQtB0PyHHUR6K?=
 =?us-ascii?Q?8x+EiuvHx3qoj2bhzVnuFDAAZyRvurVAPGaGKFhukZeAgM+WYnmcA26jCdyp?=
 =?us-ascii?Q?x4aUhlkhjYJde3H3moRuLDkp7VMg1QJqTh7qnaQZKhpErj7URHCSAcmYV3oe?=
 =?us-ascii?Q?TlXQ5OAstA1u1tDaNzkKjKFI4mzHLY9EWG1fTc4PhxpLnxOsxztagjUK6S2T?=
 =?us-ascii?Q?2ACgYdfi+wqVOR4U33Lofa+xhRMaVMqcCqLmI1IYUpsPFE1L1pW/QRH4W+bH?=
 =?us-ascii?Q?39rB+Y0DwfFF8+AnP4uAc2UPCcOcqRZKiRCRI1aJYUJLV2qbGUshEztF4KNJ?=
 =?us-ascii?Q?X5nfeZwVYQ2GlSB8DfadGPwbm+BapyCT9Ixeamh9l+D7T7fsui9eFYihtUPn?=
 =?us-ascii?Q?S3Q6wlU6u3OhUCKMKGAPOdUI0gLH2AfpjFx5lSAAeQx3kEBgJgszjAnsf5Dg?=
 =?us-ascii?Q?Rl6GE2+Ojno3c7lEieP3tWv/NJVxAxH1YqaXt8wPrPtpULJ/KImP4W38i2Vb?=
 =?us-ascii?Q?Ghrplz8d9XA/Z4lgsAnfH8x3nQuvZMjsLF+/yVUNSeTN81evcsAhjj70GnrV?=
 =?us-ascii?Q?9Wn8LfOhj5eVVwv2+g1PH/j5GquCxBBggeYNc0W0oQA3fRdLgmsYWGTe3wKb?=
 =?us-ascii?Q?qXZF+QcvOHfQ6IA8C3VkYCXUG04ylqnxo3RZCZFlr3fZ9RzJC9sOjNgrErMO?=
 =?us-ascii?Q?cUP1tT5tpeMWjVBNxCzpPI70BVx2tCGiyvQO/gJTV1N4T8wA4bCh0pBmeQso?=
 =?us-ascii?Q?gWP/xbTIW3VdRswWfzOvK+PyR+r8uYzKBD7d0QtuLRXlUiE6H6d22J8Y0eVr?=
 =?us-ascii?Q?mqdhuQcxU1D+osAFJfheWu8zU3W6EmsFzUpvmtSXu7xsreTpKWk9ZvWM4wsl?=
 =?us-ascii?Q?mJI4uI73BJkFs2+j8pD1+fm/Joj+O+/h7Ow2H+B1hzNDkTEnQyL5D5UwdNk0?=
 =?us-ascii?Q?s8NyEF+pVht+wflIa0i0qyCiKG5O9CyRft3qaQk2d6hEcRgTBGbD21tCULMw?=
 =?us-ascii?Q?t9UYW/Q8kMrrUnIuy27NHOaJkPSoaNBlWs3ph5l0y/Li+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJRiOhncJyvaYe0wLPzBuaclCiluoAzNuI63bqFaDtPF2fFu/triEReORlQL?=
 =?us-ascii?Q?ZOZNavV6XIBf0lpE/Fn6HDcy3fg+xYsdO1SAjgnG8uvYv6g5dKVmic9gxfyf?=
 =?us-ascii?Q?9KmPiv+AA4sMp5QnLBofTwQ3CMzgSwdF5x0ctiXpYYEgn5LqSgZT7E+ErSWc?=
 =?us-ascii?Q?FmVGyErDRA7YmO4kRgOpr6lgl5ZgEIaLRqe2zFAyJiluQlkmFpgt8gEWV/Xa?=
 =?us-ascii?Q?emntAEIZPf6vIUJhJg2+dQ5fqIqLygsmDXMpoiz8Fwhno7tC/+jgUWGAXCOk?=
 =?us-ascii?Q?agv0B4gsp+hpuTYsMHALw6jKZXa6fJDR25Biyia+zYrei0IdgMVFNP1NsA73?=
 =?us-ascii?Q?Uo/S2FwdB9v0nok4C+iHRCKUUtYybmlLP6O4otpFVob/kD1gwJXol0YI7guw?=
 =?us-ascii?Q?IignZJCMPlEel9EkCCmF8bRJRRzPV5VtvonZrKskEaqxuzQPeX7MIghtwVVY?=
 =?us-ascii?Q?mk5VVWrNHdrmWC1jz7lqLMKtpC21/rOTBvnt+YXYV8a6NVBWQQGwZpnk69rc?=
 =?us-ascii?Q?jYXrIO7o9347x9B/pR/c9XhqZzNMkP3BtvbaV6IGckVxHc2xRKT7CTjRuLUm?=
 =?us-ascii?Q?+4jvbGwU200QtGYcVocyfGHd9lji0oq0umS4ChTB64c9R4+SALhhyvXUAxU0?=
 =?us-ascii?Q?o1sGMKaQ/nwwC+dKmNQPO8aVlMokNrWVXb+TI6wp0KJrrp6zrjGEQMgMQdMN?=
 =?us-ascii?Q?0P2YSskdDYzOLNWA7BaHCyEaOBvqgnyVYr9+oqpJAwmQg07ZXtVhxB+/9NiP?=
 =?us-ascii?Q?teEz7Rl89hfau15Kq1A1spAC2cP80M2i9QDOgN1eLtVeObP4y5kCZBIOwslc?=
 =?us-ascii?Q?LbGjP/b3eVwq9hc2ZHuhRaWBEdto/NR4iVEWE74U9SAa2cyca5/g5EURDGXb?=
 =?us-ascii?Q?MYHu0FEogJkWW7Z6XBRvySVZObcm/YUr3m0bd6MSLC0q9S0Ac71cyti9d/Xe?=
 =?us-ascii?Q?QXChNir6jhd1NLMom/o3NcFVJGApdlHZirm9xHA/F3wWqnQh4JY/xQahjYpF?=
 =?us-ascii?Q?4tnbYShOQuhMdW7DrkCjVcRAhZwetdLD4XXiuiXCoqgzY15EQx4Zhxd9uXbo?=
 =?us-ascii?Q?myCarN7gZ6XTSPejJjyzIhfdCPoZsJo/5k5X/Q7N6PkvGafLkpwYfaAx42z0?=
 =?us-ascii?Q?CaI+XiRihGOuvbT3Q6AUIteA6A/nT7e1yED+navqqBJY16EndOVyz/9tueoJ?=
 =?us-ascii?Q?pXuZShdNLodI3EyGGULMLvJ5J6fNkewCEamNrOsFMH3kFjaDltCi505euuzQ?=
 =?us-ascii?Q?/xhBFi56XTeLEupU6Lv/vA4OdSVNm3Bs4YwrfFcgY4WF0vxHMv32IPnIV7FN?=
 =?us-ascii?Q?tPirmSjp1UK1HNUWkbdQ45HXmaCpA2o+mYb9VBgk8XDBCZnR7pXcrmMgeUWN?=
 =?us-ascii?Q?1Jrcf0hdvsQA4++Wh0lEE9FS6Cse8FEYUsMYf0LGOLtBF3ymqvIfKlVjtulE?=
 =?us-ascii?Q?pwys03qtImQxLyAmQ93Ef8WhvaiD9u9zzd5I9ZukqfcQEJCwjaQ4RbQqX/7m?=
 =?us-ascii?Q?sAEopOMwRBM7FG+z4SQ0XTmhuTEA0sB1erxWFhrx4OYLnsY2k+xS414FmUhN?=
 =?us-ascii?Q?JnDFu6VrOGGjP+SovxpqSNeKLeiorBuglsliTw/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009094bf-93c0-48e8-7e85-08dcc6a1b5a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:08:22.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA/WbERrLPEwISWa61v/IO4uDr9y44OnA/+i7R4spTe3dUoqjBo20y3rGoypLmbewgomgi8NdEKWCIRiiEoGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

On Mon, Aug 26, 2024 at 04:13:51PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> To prepare to let amd_get_highest_perf() detect preferred cores
> it will require CPPC functions. Move amd_get_highest_perf() to
> cppc.c to prepare for 'preferred core detection' rework.
> 
> No functional changes intended.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/kernel/acpi/cppc.c | 16 ++++++++++++++++
>  arch/x86/kernel/cpu/amd.c   | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index ff8f25faca3dd..7ec8f2ce859c8 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -116,3 +116,19 @@ void init_freq_invariance_cppc(void)
>  	init_done = true;
>  	mutex_unlock(&freq_invariance_lock);
>  }
> +
> +u32 amd_get_highest_perf(void)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> +		return 166;
> +
> +	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> +			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
> +		return 166;
> +
> +	return 255;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 1e0fe5f8ab84e..015971adadfc7 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1190,22 +1190,6 @@ unsigned long amd_get_dr_addr_mask(unsigned int dr)
>  }
>  EXPORT_SYMBOL_GPL(amd_get_dr_addr_mask);
>  
> -u32 amd_get_highest_perf(void)
> -{
> -	struct cpuinfo_x86 *c = &boot_cpu_data;
> -
> -	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> -		return 166;
> -
> -	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
> -		return 166;
> -
> -	return 255;
> -}
> -EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> -
>  static void zenbleed_check_cpu(void *unused)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
> -- 
> 2.43.0
> 

