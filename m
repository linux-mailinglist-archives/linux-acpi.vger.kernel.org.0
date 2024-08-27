Return-Path: <linux-acpi+bounces-7874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E613960DEC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E8C282AB6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C151C4EFC;
	Tue, 27 Aug 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bl7XoDXz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BA1C57B3;
	Tue, 27 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769786; cv=fail; b=MEGlk825nnCfA1JRI9VqCMtqu1ZgX39VInu9ON9gnhVVMT5YgOEKPgEV48hWHDSlOIJoxJURcpxTkgNe7UBloi6rlVQJjqucyO2XQGbgpZODlMhTiqmtXraUpzI9YlOjMjX3u8LU02o/ZMMRMG/P/wlx0dYNsVorCvDfKLujTpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769786; c=relaxed/simple;
	bh=UPHUABIdWVIa7j0RbNyGalKmiK8WIqml7zsdYar5Aeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4nZZiq7j/PJPdINCLfbfUCfnyA7NAKoQwTZkFFC6tWxD06s1jAoaX/bhZlzBSv3drSGeXoXYHwJUwcuKPsdc8Rn2xri4NAquQ7PLZp39LmDuv839n3OjNTGyoLKpQkPNwtkoUjuVpFiV7P8wsl847OvjrT/FlkkXKFRK59fbdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bl7XoDXz; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chXc2gY4uNboX9T+1lJpK901ILFjOVzcpTkScIfnvHsQsgiRQKO2QqsY+yH6pICjdJVoTJj1vqUeAGX/gps/Fs7JwviFgOzuIUFA0pPKhEhBCEvBUKitaXWCWSPR+qiIiLaDvKNNPm2yApPYvQJgtEsarNM8Kju4f/oHZdXuq05z+q/SinkpuoNpYaOtitSG+n3J12vTaQcuMOPiMYLD3aBsiWZvhXOY0jvbFHfqBNI5fDyQAv05f1EyQEj3A/s3sy2yUC5Qsh8NoekQWegA+gpqBIcXzwQmVQmTEVYy3fvIot03lLJ4tadkVQ1BhyuiFgQkzrPiK5urFbg21V00ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNN0i0GiM0AqaKQVeEjCXla44OqHNbv7vOa3cGpDxyw=;
 b=cdDYrb0BhwCVqa7+tizUDlRAX2qiMMABn0K83mPJOyygGF/4CXYNiC7zqGgvcwvqcJWMYjNey0IZ/pRI7S/F8otX20+ytkrZBMJ3Ein5uZdWS9f2xB7VPk+fVwaXYW49ldRV9GwgUllFZ9Yc3ua9RjGjAeHuefj8dT6Mt7VTjNfrRb+HfOSOeLlij6Q52l47cZpgYYgehGH2WR3UAO3kOHbC/qHAEdIoE6Dz8bt6vQgWJjsEul/DSNEIxIUfL+1o2jJq3QQkuDZ3ijh4ahxc5RAZKuFa0DRUaXx2cwHGrWbdT92Xt98e/fW/glj7P8QyLwezjqkIJKBqGuHc2JdHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNN0i0GiM0AqaKQVeEjCXla44OqHNbv7vOa3cGpDxyw=;
 b=Bl7XoDXztV4brtqOEgvb/yam7M8XUEUy/em+3NNLjMkWyVsKnL+FDHTw3GxKBmQNtznvgRpdxQOzcbXiwO9vVRl6mrPc2OcQsvmNczYyELu6Ud3+16pwtajXeMmuqZtuCZkSOZRs8maWZFvHDa4GPZ/2sIWs8bYEzOg648c8M0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 14:43:01 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:43:01 +0000
Date: Tue, 27 Aug 2024 20:12:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/8] x86/amd: Rename amd_get_highest_perf() to
 amd_get_boost_ratio_numerator()
Message-ID: <Zs3l6mry4qMavofM@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-3-superm1@kernel.org>
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: facf4918-ab0b-4691-73e0-08dcc6a68d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QX18hw458xD0f5H5zA1c0UCTPLD5mK5KWRV7l3fPHypOijh2jaQaPzyUDjBA?=
 =?us-ascii?Q?UT48tWpsnsvlUayuXqXcYwiYI/kmzYOm40aSCbuGbLj4gnGkl5FwSoZAv+bg?=
 =?us-ascii?Q?ulRTno+oEqTao9IjgDv93DSFfk8I4AdsHNVi/3kTSh24xyDnlipPrCL5rVsy?=
 =?us-ascii?Q?XOnb043fTJAcPzZ+c7xGqEarSujHfCCBHmffH0+jxDrESCFA+K36F45bdueq?=
 =?us-ascii?Q?OGzZWYI00jG6NuxQrYapQnkZ4iyNu+c21t8e4uC8ot7aQbm3TKlVwQmxO0Da?=
 =?us-ascii?Q?BRj8otSvGFLU7aPKED24ypZLPEnyG/5R4RrYxrMDQeeNXF240BZGI4aktZR+?=
 =?us-ascii?Q?MOe/8DI3XBrk4/qXpy0gJ0LmpRW8t8vm9JpVSgzAS++/rcYqX0jB8cfLLBPF?=
 =?us-ascii?Q?h0aLVFwheHJZe3DpW30mK9x2/m+q59DEpfGrr2RXeJsZ7xI8OY6Ixd0wkhND?=
 =?us-ascii?Q?bjLBoeXKtli07V36XO3eNss/pC+Ok80xJsmhHKxZSGmGgdSardmMgWl6zlJH?=
 =?us-ascii?Q?ReMUSyBk5ZX8YL570afIbNpyYM9/Tv3IOI+qKoIRVVLdOO8VwwrtmlRcCLb/?=
 =?us-ascii?Q?Qh0IMatUQKsso88lGsWTYpvM3f8MSzvgOk/zXw4C6nSzhxntG86Wg8huCUNy?=
 =?us-ascii?Q?1ayecskGo0iI2N9Id+fHZx5UHR0PfQqCOZyyuEnt8VgZuEp/ZPSrMgCk4PuZ?=
 =?us-ascii?Q?MEoO7D1S9t0Q5u11+9Ku5G/u8ZeCjP6SVIuY/pX8rq2ytURWqoZ01E4Grh07?=
 =?us-ascii?Q?baMQm6Gm3K1CqHvJZdEhV81cMvD9oxFwICdCoyKWFwvg1XoYu0ID1UjLoR4t?=
 =?us-ascii?Q?JghLrZA8s59RpYVsHvyvmt3NXK+rbJC19F9qZs82D6p5wPB0Yu0CJuIuPyTC?=
 =?us-ascii?Q?zpYHvyRRbuyvTPIxX3q+PGBdege4kdsKLgqYJs38SWxU6IBfyumAyB+nUUzW?=
 =?us-ascii?Q?hBjl2/64BbiOj+FI1OmglBDIBxEzrUXD+8VilCnYgbZsglnhkEffzvWOwLoa?=
 =?us-ascii?Q?uueSxTl/cBAC57B/y90U92Nk0SRcNB81ai5oy+i3beJE45N/tsvX1ea0vJFa?=
 =?us-ascii?Q?QAdvhXvNcLCZyhQA923pane0O1A7QMP+4rDZPz5QPuOi9RZfG3IRHDrpqiEt?=
 =?us-ascii?Q?6YQdOxh0Nc/vpwDC5vTVyxFoJrTzH19hsfp0O7yJ/JjppIpc/H7JqX0C/RPp?=
 =?us-ascii?Q?YxH0sahiskglnY/0DrHl7ildAeluH0oKRbH9vezbHXwtHJvbqEXjDg1YGCDK?=
 =?us-ascii?Q?mcUgsxh5XYVQKFkrrpYba8QZrU5bVii3HTHWFCJL34K+6E/WSLBKUuC290nQ?=
 =?us-ascii?Q?YF1X+BLqeFot18FVD0d+OMcL1WdJ2ABJevTPLcSl38fmwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9z5WeONjBcvDAsZa6iGdDaazbYSWsPrx66Z1aQC88vUipl0j/7PTHWDwG4YM?=
 =?us-ascii?Q?d0qfCdcld6uFMhOlihCreThBa3/d/ERkE2Ul65KUSNbJGeMqSJtmac2L/1YO?=
 =?us-ascii?Q?XnhW+sWDWRjksxfEux+EuBXsOhfh+QU0kNCyj5Y/ISTPTesKz4cKqvLHINEl?=
 =?us-ascii?Q?AJE0UyF6rzINLd3cOHLnJ02j+8kzZAs7RWmUzXsy7rpg1wM1+tzqQ1zazwtj?=
 =?us-ascii?Q?uyVAcf9uRmkrmXgslVlKmtexSgQWDWYkL9ujgA8ZKBPlS1MHalGJ5pC27KP6?=
 =?us-ascii?Q?45U5Q/Bz/m8vvXYE/L46hIwnlQqEQtZ+kEof7XpCFQnXT6CuIJFkqnXZN6sJ?=
 =?us-ascii?Q?vvKsqnpNtjuGDXwWhSwv98R+fLXzMerlNSANK3r1d2HbTntK9dxNW1pca0An?=
 =?us-ascii?Q?c6QtFMGiMcDRm38fJc7V8Ay+r2Sq1JHVzQIamoEAleSWXWuHizyptyjKQjIF?=
 =?us-ascii?Q?ux7UFDI37C6ZjtnunX+bZGRywrnEcOUgqf9Xw9t9rY/FwfxnxHlHdkhzH1rQ?=
 =?us-ascii?Q?FO6UWl5HnZQTa+XtzYbbVjF7XAEqc/Rv0y2MW5Gm2YEnvfhBtVYehitsdJQK?=
 =?us-ascii?Q?h5N1tQvLTe4kxmLWiHdmpwefa5IWa09+3hSfVcrcd4n4REkb/3LRCbHo+ReF?=
 =?us-ascii?Q?YSTF2bQljQAK7iApxldHNYQfULV0lJxuzq9UXRHnLmcDsGZeRLqHdMmdTS/K?=
 =?us-ascii?Q?Xssle8ToKDCsHdQzJmxTp3vWdDL47CuTdXTsEMhK3mrfUEpEb3MeXHBzx/H3?=
 =?us-ascii?Q?gWaTJuXIAqjHOiJUlXiIEK8eeTKdKDRGGHbEMN2dD0+mVtf/4gYAi3NNw8bS?=
 =?us-ascii?Q?2Qy2iOo2yodm66xvXt/ru0Wcy2yT+qV8Uj5nJD+j3Cwp0RjAPOb8vkdZIzTP?=
 =?us-ascii?Q?MBCddwzsYXrUaAcCqXON5jjjN43zCerGk4OrI2nZLcXSG8HjB/1/55SmAZ+H?=
 =?us-ascii?Q?2UQkjLvN94E7jtMWON10vhI7TEm9cNT9XJ3a3Xnm7QeQFJG176lQwJSnoAhM?=
 =?us-ascii?Q?6CdipCmvgmiSzq1xxhiHNtxg7vn5B2eTCqWiu9bB7EWdM2lOqo+VdYDVHa/Q?=
 =?us-ascii?Q?Wzif/vq2AekLZKveow1D9Wqvk2q6lCBgNaMj8ptB/yjjt52ekXdNP66KUM2u?=
 =?us-ascii?Q?G6jqXokvXMsEuwa/cotF+YbM3rQXYR0O0PgphWgg2s1AO+oBGTxKj4WREIWX?=
 =?us-ascii?Q?yqCEFatwzP6NdN3eXVbT+TBHolXg1mLqxQ8WqonnZe3hXZ/AXCd0UPKO40bA?=
 =?us-ascii?Q?3H0LycPZPsPgVIGcX8ZBrLkjozlEf04OcAvpc2zcFr1MeqED4QPtg9vHnYjA?=
 =?us-ascii?Q?BwRCvAdQX2+WYWxVRXiOaUkHbZ0NYYyc/5QDUXeiT2jj666H3aU5d6fTs8BE?=
 =?us-ascii?Q?lchggHFdik+F6S5nJNLKbwySqSaMmPuT1U6mkQYJ0jnI3zRhRpmhg2ocTEDU?=
 =?us-ascii?Q?jjVtllcT/yXh0ezzs7YBLoKStDwyGj08oCdA71cQEg4p3g93xoRV+xfX9i+Y?=
 =?us-ascii?Q?/uhu0n9iIPmoKCO2LdNRvjh4I2fLr6FmrKgJPykfwLD4qrezQFZQpqPlSfwp?=
 =?us-ascii?Q?9OZfrB+37ioY7n4W2cLfW2KY9XH9eD52ZiCtL9+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facf4918-ab0b-4691-73e0-08dcc6a68d39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:43:01.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ5cKpS7Wc/sC7bbH6TCxmWNySnhlG7KBwXEKtTg8f4B63VCArqPjLJyNZGMhYekMwrka9Bc+tGpflrSuY20Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798

Hello Mario,

On Mon, Aug 26, 2024 at 04:13:52PM -0500, Mario Limonciello wrote:
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
[..snip..]

> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -79,11 +79,13 @@ static void amd_set_max_freq_ratio(void)
>  		return;
>  	}
>  
> -	highest_perf = amd_get_highest_perf();
> +	rc = amd_get_boost_ratio_numerator(0, &highest_perf);

The variable is still named highest_perf, here! I suppose that will
change in a subsequent patch?



> +	if (rc)
> +		pr_debug("Could not retrieve highest performance\n");

I understand that amd_get_boost_ratio_numerator() always returns a 0
in this patch and thus rc == 0, which means we never enter this "if"
condition.

However, when rc is non-zero, shouldn't this function return after
printing the debug message?

--
Thanks and Regards
gautham.




>  	nominal_perf = perf_caps.nominal_perf;
>  
> -	if (!highest_perf || !nominal_perf) {
> -		pr_debug("Could not retrieve highest or nominal performance\n");
> +	if (!nominal_perf) {
> +		pr_debug("Could not retrieve nominal performance\n");
>  		return;
>  	}
>  
> @@ -117,18 +119,34 @@ void init_freq_invariance_cppc(void)
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
> index 930b6afba6f4d..f25a881cd46dd 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -136,6 +136,12 @@ struct cppc_cpudata {
>  	cpumask_var_t shared_cpu_map;
>  };
>  
> +#ifdef CONFIG_CPU_SUP_AMD
> +extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
> +#else /* !CONFIG_CPU_SUP_AMD */
> +static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
> +#endif /* !CONFIG_CPU_SUP_AMD */
> +
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> -- 
> 2.43.0
> 

