Return-Path: <linux-acpi+bounces-9662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1019D2940
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B58D1F215D4
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83C1CFEA9;
	Tue, 19 Nov 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8Ow2FRj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605731CEAB5;
	Tue, 19 Nov 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028994; cv=fail; b=i4m83l510GFbhsquEg2DE9ZUanyreZ4RylC6U1MzyMXoYRHvFuzAWRP2hGPiD4Yfojsq+qc+2KDg8iERoxY9ZVUt5hHPTIbfSMFmfmJt5v0qGSpZ6Yn5WQdTszVWHhitqq5zGBIBvm1f1zuRu5isfcw9ALPgaDl31246Ad/shIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028994; c=relaxed/simple;
	bh=juivS6fWv4Dq3c1mraIz2J//A6knXV6PLO1AE3dHrsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9a0Z0Mm0NEtAgOxWeneYWJ9v3IKDJ6ETTpwB28UICXdgpPfAhBVNKze2us4UWwPAqBn/Zq4hhDoEFdqMoM/2CF94jKg+kUCL0LiTsVRCOzk2FK6tZttYaO4y9blhHT6eyd0NkWwVhTCvNm6PRXOzUDCeexUv74TwvrJZxEzk0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8Ow2FRj; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkMUPDRH7O56TSpojaxp0xZ0kNs/HIEDNGjVFfe6fNaAoRyQHDxVQl74iCPWWTxY8I/tpVIQqVVy19UUJJf3uO68Nv0oS+bvce5EcMVpjePnwjC2cTUmkG4buU+QgsWECvicj3qID2zl765aBSyKsaRKGMnRLlUNgEQB1RLZzaKKavwuNnfvRyGTHRsJvod4LYVb77b1xlgvJwsR5VD+Z2vlCXwCP2tEDTDJQskH/K4C+PynrDMFIg9yHVKLek86hTzIFD4m3erXIoPebxeNrVc/PiUWprlMXiDjTHSdj1PB6Gr5EMxdYlRBQgFmwlPLHuReAxDdpeS0qc+JOloeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkIQDQDI+BD9avGMe7XEDEDNl35ycAOHxdLR14hnKIg=;
 b=kcvZ+MIA0gqN4McEG2MRMwLi0LNP1Ew9FMtg+ExCbBeq6LH3AxqFYhffm0LKA01XoRblb9xQAzoegquGXQd8fORw8Jk/jr2sX/PG/FIvRb85B1nr/iiaLH2H2Pxn5TRXqvvdXba4D5gZf+pC1YikLgyHR3UDlh3YNt5dCkVc22LLDn+sERdsCymUqmweQuoHuarTpKu8kZUFfbwDq7o9xBSOAeCT/Hj2QOFi/bY0a2F4saB5R9GEq7evtGByzyDnIDR4mWS2GqOrG0rPt+NEm0rsCJwyFD/xcWRu8QTFfwor4mJueHD8axLmmh9ZC4mrBOxDij9o7ZtXkOtUhMzCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkIQDQDI+BD9avGMe7XEDEDNl35ycAOHxdLR14hnKIg=;
 b=E8Ow2FRjeBVl59J5MKpw15UoepfaFZCo56e4KAKle2+mHto4A3DXYaIMsq1cWLSWvL17REoNmFLa8UdT92L1nZe6N/Vx3vtdKdAumIZS94BWoWLC6b0I74lu8B+RWSwPg6kmwb5ALwWFCMljEYBPM6UDUkhKSsIm+MXl/6SHbXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 15:09:49 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 15:09:48 +0000
Date: Tue, 19 Nov 2024 20:39:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cpuidle: Change :enter_dead() driver callback
 return type to void
Message-ID: <ZzyqMmzMaCHqE+9m@BLRRASHENOY1.amd.com>
References: <13636465.uLZWGnKmhe@rjwysocki.net>
 <2285569.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2285569.iZASKD2KPV@rjwysocki.net>
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dae20c2-8c6a-4237-9563-08dd08ac35aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54QhkZxzp5XGIyAfP6rdxREnhqYEBc9Vio5yWh0/48WI/Ub92Hg1h65yuk3h?=
 =?us-ascii?Q?SqngdXExIDC2cWNPkzdNrTbs6pEI3SKPxgplpL3zjWss3ZzzEbXnrAm7LJeM?=
 =?us-ascii?Q?LGB1YGjDMWHeOtbf2Jbnmb7fxG1JOh2LoKXnkEN7pJmjLIqVAEPGL+gkGiLF?=
 =?us-ascii?Q?0t7XFytjbk5Y9putBGresIFZB22VeTWs5mvp9x8kGp7Ci6XA+GaK9jCdIOtf?=
 =?us-ascii?Q?Ltyipv9C8NFpbiycKz6OOYRRFiRdWqxfr1CaRoi0vjz0CAa4j1sQ/oxHvAR8?=
 =?us-ascii?Q?Lr19AH3h0AHATmmJXNLwpEUPzfMNxyEq0C3R7989wrzJqfD3aZVRoTvYHoC0?=
 =?us-ascii?Q?acaTrLuebFXaYBiayNX16oXruQmiVh4/wCi/KA86w0i9R82yVDSMMNwXdR6o?=
 =?us-ascii?Q?4A9B+7p+swXfkZneoe3tzj5cA1tXSoe9HC5FMgvR22hvmNPV8pVlV9QY0dKs?=
 =?us-ascii?Q?s7avqChW6eTv9S6lt0yFfwA3MV+BFLCTMai078XDY7hzDph8SVWLsJTLbVm1?=
 =?us-ascii?Q?DGUDforhd/n2ShTDMbN8vgaVM64V7IyU8KhTVfTU0ACXfvvuC3JQnxw28Rf6?=
 =?us-ascii?Q?975uqhqOIA8xFq/So1sS9CYW+l1vxX6z1D7t/MU2vHs3Ifb02DGGei3YWdHC?=
 =?us-ascii?Q?gLmODLejER33z18fQlG1V0uFJC3bPR1hPETLb5J/wOH7p98bV611AVkQThDi?=
 =?us-ascii?Q?PGGCPCF/3r2leIvqS+CsIJswf+cWsL8nkoht36KI7mXtMo+qTIqNtKcg6WrX?=
 =?us-ascii?Q?Pba2k/G75ih4tK+gVDt9NP7xRH6GFf3OAHVjlEZCIkBe4zgdYIeEXs76WOVp?=
 =?us-ascii?Q?BXR/tmd1QinxZWePVly6RsNWWWgz3zKWjmG6yZzjFf1DZur+MN7SvXNBLd+H?=
 =?us-ascii?Q?N2EbhIAX/soSfze39UlSMWAFePdFM4P1HLEytI7unCFEx8CAiF4O4tadXFye?=
 =?us-ascii?Q?uhZgW/NWaiFRKY458ArcnEV1iu2mL+BfhAyBYurtg8r0Zgw0Fv7rxXzG88w1?=
 =?us-ascii?Q?t0fFRtwFfj9gBceiuSFPJuraeYp+HH9P1EgoVVagGwt8MofIzdIrPlebA4v/?=
 =?us-ascii?Q?82AkvkXzL23ozLB/2Oibe1V8x++mr+UFxrFNz7eljrXI+Ef3tYyUVBasEwCQ?=
 =?us-ascii?Q?t3s0UOSWYm+K17zSrl766GJc8vKRfpXB78EieyMF4AFeLCs9ruDM/xAHH+RD?=
 =?us-ascii?Q?cXcA2j0VAAfJ6SeuOltJKXYyJnWgHH/p7OjmnhlQD30Vr4BZYtOcLZXjnn0Z?=
 =?us-ascii?Q?ITb3zeu+bndduvEh6jNa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEt1mUjlZKiSW+5Fr3W9P1oFqYS5Pl/VRMEL7B+9Gvuaf39Kj9YoTINR46Cc?=
 =?us-ascii?Q?1xEP9JvyezYzjO5GEOwmXMK+T3YgRwPnVZlpAlOe7cfgOCoPj3eP57fOZgj1?=
 =?us-ascii?Q?NCXC1E08JmLCHdMh2QWkxoxOO5dB+QSyvD9HksccEAJI69yN6ze2hWzPDfoj?=
 =?us-ascii?Q?q+KDuD9neTGBlgA7GuJ9klLnpQ18SG2+iC9xnbnbgkCeyYf/EezpqcYMNSjN?=
 =?us-ascii?Q?TWPWljMGk+qfkpI4ry0r+VElfTE6ZdBS0Lbt9Ax6L4rGYCxosDLjd/+mwV3d?=
 =?us-ascii?Q?X8E68ZdJN+nBGn1RRBHYvXiS7IHYvuwhgczpbX+H76Jcyt8ofNzqvSURvNrp?=
 =?us-ascii?Q?v+MlJTB2qw0XcOIPSyB9ppcafvwOUMIbUyYLceyy0dy5znpeTREb49mjJ/H8?=
 =?us-ascii?Q?aja+rxvMIy2xbmbjrK9cXyG/9cujvwEFm3J5p47Q3mcSu0SW6n/bbOnJR0Ij?=
 =?us-ascii?Q?o9RNyDKXLCVu/a0uYy+YLCoKiIliRSKu+Fgz+B1WPOVxD/Bp85wdRByWtaPG?=
 =?us-ascii?Q?s9JeXGhPFUOAvk3cxAGjE7boomaatmgYxaQ6Sy33DMAf9V60085doVSdpu6N?=
 =?us-ascii?Q?Uk3GupXgSf3+X8QJnOXEIuE6yRu/i9dmleQDOHrWykhopm5URqzVXr3mQHNh?=
 =?us-ascii?Q?S56J9g/cwqkJBAFzfyUH0T3sPBbVAiXQa8s0ZKKWl0BcWG8nYgiT6djuytn4?=
 =?us-ascii?Q?gzgCFe38zzJaQxngm791VHFJ8cXjlCDmgQAWpM9X1tZJ9/y/4WK2lqDmMV3I?=
 =?us-ascii?Q?yUZ5kkCQY1XrhXMcKDyTnxjzgKWQFSSWFeNuVSf+oNp1h0NyQQ78ud+zE0jX?=
 =?us-ascii?Q?t/aMKM6LTb9f5pBsOT2RtbPx0ktsZxTsjz3mpVWOhQPOB33NvBeykJn6zct5?=
 =?us-ascii?Q?oe5AiWj0Ajs1tjNPrePhWMgHpqlRq5cT8Gqhihwnr8okHCsXZEmpgmKQRxfH?=
 =?us-ascii?Q?VZX8cklprWDDyGyudOdRtSN0uPaFJLGVsSI+7dwW7mcebjLHx6+x5MyU4r34?=
 =?us-ascii?Q?lOHEUSQpAjDDXjPBu9HKRrwWyxULMebctWuA2xS58UKutqa5lsYnxEAJva4u?=
 =?us-ascii?Q?x3vFwLCge+EOvpOw25C21MtqxpBbUxSxSRXCvOjTZ6JtNlptRGiLVRtlKgKy?=
 =?us-ascii?Q?AFUizxJ10tugNadLeOfasBGfnMrSJ4GtXflXYaRb7JXyIGBlxlDFChClH3md?=
 =?us-ascii?Q?TwdhFBd78MuGTir2rpgX8o+HGOZcUK5NRzmngylbpDsN/3bDemA5ui7Ty3KT?=
 =?us-ascii?Q?K/kYRQHuooLpWpztAgRFSlEXuaSICZnQXFU5YOsWsP0SByc/A17seVowNFZw?=
 =?us-ascii?Q?c9AHhvskFYJ8rrcXkYFTLASnyAfaLfgEC9C+vtIMuWJxG/llpsQG0Ti4RtRy?=
 =?us-ascii?Q?i32FLM8n6qkmwbTOe6n2gXz9XbyYY5ghqoe8J1ZcPgiTcTQjH2bcdtCvJcwh?=
 =?us-ascii?Q?9Y9ehMMcrqm4pRhZnknMvi9O/+R5drKcU2HJkea39krNKj+Baxl3LTbexsGL?=
 =?us-ascii?Q?eudOW5zyJU1Xipej/sU2agcAol6W8GS5n8R8PqK6vIkYdBZ3kKxbRtLViSh7?=
 =?us-ascii?Q?xZ2SV5yosBFE9xQDfwtbtAYlSeMUI5170Mf0MOq7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae20c2-8c6a-4237-9563-08dd08ac35aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:09:48.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: przol9TTeznq2S5mm28gto1Rl8gKCGUPQWCjdnia9E609vd4YZUNVtvP0SYIsjmlWA/QukV4Bj0q7RWKDDq/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

Hello Rafael,

On Fri, Nov 15, 2024 at 10:00:25PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After a previous change, cpuidle_play_dead(), which is the only caller
> of idle state :enter_dead() callbacks, ignores their return values, so
> they may as well be void.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
> v1 -> v2: New patch
> 
> Interestingly enough, the only user of :enter_dead() idle state callbacks
> in the current mainline turns out to be ACPI idle.

For that matter, the only user of cpuidle_play_dead() is the
native_play_dead(). Was that always the case? 

Some of the other architectures select the deepest available idle
state at boot time, and enter that state when a CPU is offlined.

In any case I am ok with this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.
> 
> ---
>  drivers/acpi/processor_idle.c |    7 ++-----
>  include/linux/cpuidle.h       |    2 +-
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -61,7 +61,7 @@ struct cpuidle_state {
>  			struct cpuidle_driver *drv,
>  			int index);
>  
> -	int (*enter_dead) (struct cpuidle_device *dev, int index);
> +	void (*enter_dead) (struct cpuidle_device *dev, int index);
>  
>  	/*
>  	 * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
> Index: linux-pm/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_idle.c
> +++ linux-pm/drivers/acpi/processor_idle.c
> @@ -578,7 +578,7 @@ static void __cpuidle acpi_idle_do_entry
>   * @dev: the target CPU
>   * @index: the index of suggested state
>   */
> -static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> +static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  {
>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>  
> @@ -591,11 +591,8 @@ static int acpi_idle_play_dead(struct cp
>  		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>  			io_idle(cx->address);
>  		} else
> -			return -ENODEV;
> +			return;
>  	}
> -
> -	/* Never reached */
> -	return 0;
>  }
>  
>  static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
> 
> 
> 

