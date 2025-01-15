Return-Path: <linux-acpi+bounces-10688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB8FA12683
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B4E3A6506
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1E86320;
	Wed, 15 Jan 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZI9zp/RT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856024A7FF;
	Wed, 15 Jan 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952685; cv=fail; b=AlW7oujEEmOAkMc33MaVTys1SHKudZl7AMUW2a5IVuJ1MGgL1ILK8a19Slhm0xfCv6sXVwAQr7a/aL90o9fNUvGXYi3nigQGW3RPVwjnf1/dw5OHXqXj1tFrHceoBYsyTQ0HOM6KmTf5/jSGVKLPScJwnhmDibRK2j4KdpiEslI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952685; c=relaxed/simple;
	bh=avK0XXhc63NfnwPjvDlR/uB8BlcpTO1iDdR04pJS7ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HoQUCm5nzIraJr5pYRdPmH4fN6jdpIOOXUypa3Q1qBiqMHmUOJnFM6R0GhwciYRANjN2yvBHKAyS05C1JZhRMN9+Mo94OzBcHy5MfIzq1IhPON10a2rjFGTku+x/1LdghAGvBcY1uEkQG/x0jT9tKxbCSNn3wygRyxPj2Ldn4kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZI9zp/RT; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRZnslxgGEs3P2lyCVIQVpuYj5cjfbRRiTYq03ZnJYDM32z/C8RDqVAQKBS7YsQ9/LtB5vx/sQh3ER5HXN9ZJP4KoQMiZBRcJ1Fxk3iNAbNaLbCvBTPdNx0RZTeZNPyr8H8yydUCjwYXpu1vqnOBYOnprtQPFvyE7bAmXm++GB+urCMMoORXVBijWynBNwks7IOixWKKy/VUz2ZI8GbuRXO2+MQNxc/BEGP+4l64A3XzuFtn/06jz1DkhVbSJu3vaKHJTVm6pC2SclN8SgQzt4vIw0sKzWm/0/XtqHC0YWPL4piOcZSmZWrp2ZOZh3ixZapmeTZOna1pG2+BhXSumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7LKdisDX0rn+OiUBwXBWISMjP6fY7UoNZKuhilliog=;
 b=mUMPi7F1cZ0BGprzOr1r/TatACgFF07qbXYcpVPTS+xpUyZKhpIw/qAbAblwiVQa/0Cw/ggW3ATUggUL6FfiApPxDY8b0hTW3qXfVQjE1aSrPEaOBKpPFa4BoHX8ALVDh7lxHRfjAmL0RT9ualkzXPcLlv44A5tYulNV7Xyl7SPIJuZn7cwzdAf9vl2jBi8sykRJrJGIgKXEPrMHWTYNgY6vkm1ANCxcoPpHCfSEZOFTiT4v350+5Odtu8/dF7av30zx5eVBnKDyf+JRw50BItZUn1FjSphphSKYL2OmR34OrFqtKTb8MD1bfS5MkPEOdcJB2OSEv56Pd47o19lTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7LKdisDX0rn+OiUBwXBWISMjP6fY7UoNZKuhilliog=;
 b=ZI9zp/RT9jAjlT++HM4nm2J3nE5a+4s/495Z3gKRbu6bGF26jWpu71K9EVChJOpXaIle9rHYpfpNYX+3oYTK00zIArNU0VN1qUB9mtZzkNbxnb/Rew/CTSTeG3LwQhL037zHoE5RFQSRGckY+XwQEAiPsc/7IskTNdsKKwApQJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 14:51:22 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:51:22 +0000
Date: Wed, 15 Jan 2025 20:21:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	viresh.kumar@linaro.org, mario.limonciello@amd.com,
	ray.huang@amd.com, pierre.gondois@arm.com,
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection
 in cppc_cpufreq
Message-ID: <Z4fLXPgMvwGur+pz@BLRRASHENOY1.amd.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113122104.3870673-7-zhenglifeng1@huawei.com>
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: c3df96ba-5aad-4cac-f885-08dd3574139e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMRjpwJjjZt6uwdzE9O3/VanHneiVFgJAA8ZrdvxMMBXLtxIyoeleQS3bc+f?=
 =?us-ascii?Q?ZVZDzv607y3r80YIIkfTAx5SUbRjOYgtczYFeImeFKfkLvsGhIuFS9n1v0Ux?=
 =?us-ascii?Q?yFTvzLJs8uMEA/lrykUMjjdM8V9oAm46TipmwHDuMNU4ZU+TQlEKHXtcSk1n?=
 =?us-ascii?Q?1uw3xt1GXrwcevOuh3lUJJeaesOkzFWwlghSY28/A2BLBFVO545tVYkG1ZOG?=
 =?us-ascii?Q?rKOr9K92hyiqZlLgoZYJXp8z4NCf9i6qq2J6GYqWzsgkU7SGmAZRX6Trad9a?=
 =?us-ascii?Q?746bmAlnIG5H/yyx1iSElS4qomhZQvBQxm2nY+br0oXarmX7rbnR/981lWAY?=
 =?us-ascii?Q?J/28qlke9nMhx1Wmzsnej40lRoJQZtzo0mk9SKAqwAvcIt0mGvmhFM2IhwhA?=
 =?us-ascii?Q?T/ZnBscHunmQuBs0kQbywYSx9+yVGRPB1Q6p2z/sAtXsfxUudc+NtltkTdp5?=
 =?us-ascii?Q?/5VCu9uJZKRgNVHOi1Oye556oIZ6it5r0gTjF+WPVBJPxjnHOp1i3PF3IG9P?=
 =?us-ascii?Q?5UGi07xkgVHoY3P+1YSuXr3HMuY24LiHJmBBs1hCpQjvC3XVFlfyOM1+zpus?=
 =?us-ascii?Q?SYz3hpwC+FAVUJGefnw5h94tl8ffHYrkufTP3gcw5reqZoEK1TiP/0W/2gFE?=
 =?us-ascii?Q?5CU/9i9tDhU2lMGVVGCmdFhZ26vGjvau9qhTxyGXrV9cXFGxK3kyN3DthKzO?=
 =?us-ascii?Q?ZejKlRn5Fu8S137C85VcdOS4edtWoK84p+lZa6vKo5CWGnmNK+vnkcv7v9Dr?=
 =?us-ascii?Q?YLt4InD84x42Be0yUM1GUKtmb5+kYZntoseopKLQuxD4Wxt4LJf3zjGWge7c?=
 =?us-ascii?Q?cuMxOG8FAXnWQv2TVXoRC7NQIXi6FgBKnleZcz7midPpvtDcZCi6FE3jRM5x?=
 =?us-ascii?Q?S7utK4Wvrz8tD4Tri9vz4n/Ca5h8FHzLBkvTbi7KG10+gwElpzkrwvzN4LyS?=
 =?us-ascii?Q?RdPTN+GgFQIcq5VdVMAN6oJ9TIBLDyJGjtqEauhsjH+kUcr9U0AHPpmBsyyx?=
 =?us-ascii?Q?+RjVq8y9o3A0ZD/cWWpfAqyaeBSJD/kw1rVWpbbyRiyQ1/hjBij/75UE7pgT?=
 =?us-ascii?Q?aGgADFNPb/Pp3YtpXjtBaZAeTO5sBbb6OFffVIanMJxBKmUFqYU7OH2NN4Us?=
 =?us-ascii?Q?Sf9rSHqD2q1W1MduEu+CgxdMOCl+s+YFcyrACJ9g8c+EClig/U3v8omGsPNr?=
 =?us-ascii?Q?FSFHf8D1Kzx1QXZyDYBOhEpjLTp4W42TLAeq3yvDAUq4wEiJ3lES/56eKtYg?=
 =?us-ascii?Q?i4W5Sarh35luXq7IuhH/PL0osYCBcmh3xQQEbBixYjU4WQ/twHaoGE+XXoXD?=
 =?us-ascii?Q?6dmv0dgvPbe4Q3izyNgd7qMvpm99yec0oSv/88D4TK/In9SVNKBd3fj5bMMS?=
 =?us-ascii?Q?H2zWXn54GpdlHBCVN8GSiDDHBNr9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6e6zTPaGsdlGUkdXlQVyWsvmdG/SZoca6F0Jwunxqygp7ToDEFMtME2ympED?=
 =?us-ascii?Q?I21BsdO7qXZWwh8gn55Aq8cqZAxyYuD0x209020ry2+rJ2qdEY0nj4wnB2Ax?=
 =?us-ascii?Q?PHOI6XUn0AVYSBvMfYlD0lHNYzHp3X6YXHCLKedvFbsRKvyIPXoxfoGFW5t+?=
 =?us-ascii?Q?C2XW8HGbWJwOj7fyeocGSJza9LDZoXKuHnjOsR9zMCCiEdYKFoMPlbS+4TiG?=
 =?us-ascii?Q?xOSTe5UQPNRzI/jLWKrXyJpUGhaKK4UYV4PgsaRJTbkTAnGqtjU1bDsp2aT9?=
 =?us-ascii?Q?napGexhMS/DivjoXSH7mFPnYkNAA+7+PxxAUqUJ3YdcH4ITxkUfja23ZXUZk?=
 =?us-ascii?Q?sWUXAm4RErI2mMyE1h0god9oYHkQT7Rg/s36pej5Wqy8tCwc7CXhJHFhTImx?=
 =?us-ascii?Q?/NRQ7RAb5Np8JWBy7fp1WJA5pym3R8rsLz3Z0B35WV+D3myvi3Ltri/Oj3kC?=
 =?us-ascii?Q?NB792E+T2oNSGl2jb17biQD7Y/MW3BNXJxNstTmQL0hOVgxPrzy57RO5Tm3M?=
 =?us-ascii?Q?jnHBJCQienRX+1xRA20NhCeLFX+OT1MNiiOc3P14QO1/QBbNKttjdcnkNgre?=
 =?us-ascii?Q?l1+Q1KNzOMc3khYr6hmnaOXiNRV26Wvf5x5WNofJSi+YRs8Bcvo8oLVj/xij?=
 =?us-ascii?Q?t9mnObH1omWjPDp23WC52AN1JigxqYKmhepOPw0qwof5hNvCq0guYdR7dTnd?=
 =?us-ascii?Q?qHMS7FtW24Q6zjUTCqfhNnZRXpJEvyISiXzfPEr+Vg3QYLFypWrYhvrRgYgc?=
 =?us-ascii?Q?X3ex46NfBawrvTc0g8mxoDK4v4SvhYRihKu27h3ewvEbX5Q89U8ADRrVl5F8?=
 =?us-ascii?Q?a+/ouSKOkIsijL3Nj/dEhyWKydv5K21C0fOJuAJ0/9mMPpuE6bDhoKtK5cLH?=
 =?us-ascii?Q?cq3nB6EgiulRjCJSfV+L9p2grOycsUklCLpTAe5u7+Jhco/4aihS883Ylw4J?=
 =?us-ascii?Q?ezDfXS9aBxteE6d0SX0o9G8q9Wz4MUPjlnu0bBTK36s41Trf6UvB/eMpjuO2?=
 =?us-ascii?Q?mcPdCX31Xi/Fr+XlIJu8KBaGrCpr32ABOfIXlezIIP2hgtzz0q8g/ytkGzCZ?=
 =?us-ascii?Q?t1RkkkrTOjOlwhAYLp+CG/Jcao5Y4z/3lX28qjNB8i9dSbwLZCFMQ6XKgQQx?=
 =?us-ascii?Q?uBO18Mv8mZO8+ek4AGALkrS/dhzzyrHpyG7T1msCsMtz8DrK7eKl7yj6cnHd?=
 =?us-ascii?Q?CMIsRTzsqAXdt6cW2TzyxOBFY0VPWdGIuCNOGABZ5RFqxanGJw+Y+B/P76W9?=
 =?us-ascii?Q?PVn8D+lFv48AQgDCO7JJACyTBGL4nlTY29Coil/Xu+w9zpSI42HR6se5xueL?=
 =?us-ascii?Q?WkkjPSYxKX+0dUFnV0/wKFONjeGrT+66mj7hmVT2bGtWHYkRROgZUQ8UpK3Z?=
 =?us-ascii?Q?LNo4jYmDhvV99+SI2MuuEEoSkFXSkJ2XhFKU6FIMWktgcJZZJGaQwhtLlLDh?=
 =?us-ascii?Q?P8DyPR034kjZ0LD6st/rE9sg5V1SoE1hK6U9dLIsi74e/g2N5x45Wr6JIH/D?=
 =?us-ascii?Q?c8sxNmYOnKcjekqfFvKBG9NDeoDDKhhmd+26Ru70fdGu7E1WwWyxuln35pzl?=
 =?us-ascii?Q?sOBl3C/Qkl6SHvlNLt2HM9WdCPdlnmnLkTYj4nbq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df96ba-5aad-4cac-f885-08dd3574139e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:51:22.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5opcZDCQN3Ak95RfhEfnCQXuvbclfj3A8ZCZ3fu5F77mgqSvLzgZfhb1oJz4MLAMyFdIKygiu25skuPQ1+mHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

Hello Lifeng,


On Mon, Jan 13, 2025 at 08:21:04PM +0800, Lifeng Zheng wrote:
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 

[..snip..]

> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bd8f75accfa0..ea6c6a5bbd8c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -814,10 +814,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  
>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>  }
> +
> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
> +{
> +	bool val;
> +	int ret;
> +
> +	ret = cppc_get_auto_sel(policy->cpu, &val);
> +
> +	/* show "<unsupported>" when this register is not supported by cpc */
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "%s\n", "<unsupported>");
> +
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
> +				 const char *buf, size_t count)
> +{
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_set_auto_sel(policy->cpu, val);

When the auto_select register is not supported, since
cppc_set_reg_val() doesn't have the !CPC_SUPPORTED(reg) check, that
function won't return an error, and thus this store function won't
return an error either. Should there be a !CPC_SUPPORTED(reg) check in
cppc_set_reg_val() as well? Or should the store function call
cppc_get_auto_sel() to figure out if the register is supported or not?

--
Thanks and Regards
gautham.

