Return-Path: <linux-acpi+bounces-7891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13596151B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A655C289DD2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A21DAC43;
	Tue, 27 Aug 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngIcb04d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAA1D2F78;
	Tue, 27 Aug 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778207; cv=fail; b=i7X1OXAsFARLhc8T2GAQYF0nm1iZdga4hIKFY6o880mst2JOrs2gT0PNcgHv91aOl0q+DfoDn9YItjl6Rl20JS/FXwGT82T8yWCElK2D1k8k+WHDFFK2LgmPvkuepppg6RqT0kV12av5WZP/mzfEFI46LzmUIZ7M/1F4Cg3zYMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778207; c=relaxed/simple;
	bh=BZ0tjdv2cE112q94EUSRd+2r6wUGyHkvQdGbF9yG03I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NKfVqyVdbNxtbLm+Qqcp9YR3nVnIEGid9GH0hiWnDvr5uE6TjRm3mj3fbYb/AjK2UAKp/9bej0BI5g5agcc5eJzd+WiEfAbBTfKc7KUoKczg2JnPgCG5WCrtFxF/QHZgtTSKV653DPxWSFJkW1Eeu6NzKxr34LdcPyvndSTQfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngIcb04d; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW2uTioQ4PBw0UyqbUOexMhoD4mbilZth3MD2NXKnIeu5PdG21HOjkCjw5NeWRQ1QFEx7CV2kAbBRAoCtWqhQH6h9yEBN8q/eZV4HOXH/WJ6AeZKXKtoIJhmkKYr1O13cE235EaVj/9l/0bQMaja7bHvaJNO16sdeUpcejfWuSJh4sZTKBwqjWyogpEN0i3/AOtp00mF4UosFwXcRlYNR0ITxoDXn+iL25pmVZzp7mM/4DVGbP6cMCrzMXon7kmgp6PoJxUPe3VBuwlZgaZnnGWYdRgIbt6kYaN9SIW9w02ndBWGr0GX4GhWsxjealGeHAVgJK6hp244UWZZg+/o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovXZJTcWSayR1xgfh5WHAKKbT1EMLmV0+uu3Grbvfdw=;
 b=HrpZVZTBSTJkGKZI73pnLefvbDobDSTChsxgy8dC23YnwGhxD62dFp+Cc2fP1tzkInOJYAY4Lw3kvosxmKMV9FcsQSmhKQNqEju38omSsjB98zWmeVA6XGhNGGgljUMvhB8PZsvjNZXrP4apb4QMsyXoqNdOAxssriTay0pM9ghO2hpb2WwrAFkiBMGI/zft8VgENLS9+KYgY6i8Rj0qquuaZvc2j7t2Xc+sHNIGl8Jn93whTraW5fe4HutKNOmigACzdMDaTbcOfYbuT5qwrZUWFwmoaSIaSJn+ajCFM1dDxPPOXCXjIcb8UhiDEdQA0zgcswndcBQYTQhbMh5uUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovXZJTcWSayR1xgfh5WHAKKbT1EMLmV0+uu3Grbvfdw=;
 b=ngIcb04d6diu2OMD+9hpqP1FiSElWCFxrZw5kwdsPATL7qUUyHqB/XRUqC5dDL1qQbAn2dEAKogR/99ttVgak7V4orNhX/rjbTDVL7kSfl63ipU9uMILTnHIVuttH621V93bF9bnffC1iNVptfqCStoGrC5sqN3NlFT1E76LeeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:03:23 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 17:03:23 +0000
Date: Tue, 27 Aug 2024 22:33:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Message-ID: <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-9-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 105acdf1-f100-4f31-0d75-08dcc6ba2901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fxzPlabXtXdJwHSnVGoDqqkfP7TDm4KRSnKYnIWJsTG3jdM8zgg+NhU10KD/?=
 =?us-ascii?Q?7bCIea3FYa1ZkuI+FR8PGjm/z84cQT3t/dU0nyzbhrjNHgu6OBqbjs4AaGYY?=
 =?us-ascii?Q?aD6rEaYE0tFuaWwmWSaZYiJ80RjrVMRLErrUlPlbdW/GEVqoW7D7getJnr4y?=
 =?us-ascii?Q?8K8KdGhckL1V0+JnmdEGqkxVOxlnY6B7Po5sAYuuSwgTvqwcTCkLLwn3D5AC?=
 =?us-ascii?Q?6vCgDXoczf0VW+w34QrJWaiZq+2d/AQWDwWGFdJ1EynRu+Js2/WtgdDwlfUI?=
 =?us-ascii?Q?8D1p+3p52XZoxaPY0geBjj6nRLG4feHZePRLYu4KbtFb8GMNmeKK12VnXd7q?=
 =?us-ascii?Q?qdhtje1Mb5gOkF8kT3GVac/Xn5vt3Viz7vzZrMmgQBHPxQ10mrgTDjCXr+AP?=
 =?us-ascii?Q?DcmkZDV1chAWR8ZmHkuS8tJFRDR34cAj+WZdP6lTLRkujK5SezIM8vsZF2na?=
 =?us-ascii?Q?LxHoWCHChyc3tcgBUTx5+/10WhPSuIMfioHJFElHZXTPu3LsKafmsrWANLO/?=
 =?us-ascii?Q?VFjeUoKCcadRbCkF3sioWN4EREakoyzu5pFEJHKMiXvXW8mf3mn9eDVQClXy?=
 =?us-ascii?Q?GSCEemznJHrrwf6yWzZG2oaGSfiEQGfFqYBd9pU9y62GIAmk0fGcwm1RH22M?=
 =?us-ascii?Q?taODkBCp25PLj/ogl8HYUaGpEG9vOuLpouuHNIky+M8vmQ0u4QnP63llEmW7?=
 =?us-ascii?Q?gTcW4DMYZytUgIXVGTiFpqD3HCbpGaA1WLEHBfOqfRP7SxaVk1TXWoVo5IgT?=
 =?us-ascii?Q?t0YhwwpWzyglI7gbzGAOstDX6D+DNJganviz0J9VYqfnZifjuTJSkOOB2V87?=
 =?us-ascii?Q?BQvnc8C13gUs4m/TSHpS0CvSbNclcHjN9PuszelwMZdHSauyJMQ/h8rDfLgZ?=
 =?us-ascii?Q?FQ7c+rwXLJJr35VsDIA/i2spDzDWlqTMyb8uUOIGRJU8nCx3Mo+3+2j8GolQ?=
 =?us-ascii?Q?Jzy9Cl4BbaxnqF4Hqvso21W5FhOOkzADH4OVbzNUDWgQMfABnif3DIwn520v?=
 =?us-ascii?Q?At4ktgSUxrqEfCtmKk8a/N0IRck4zPif+/OHps375olnwIx6kZlxom8vFad6?=
 =?us-ascii?Q?/9YNTiwiJuEkAewoBiVvQ4vyJ9uGoYju8RGNqXtdFDSPb9uQqnmUAhvWgeXP?=
 =?us-ascii?Q?w72rn0mRubc/0m1q+bJ9nocO+9rttBg1R7ljd+S103SgMGvfwZfzkckIYAQE?=
 =?us-ascii?Q?60OJrPv7FE0cvufQwpYmLxIlMquCUJfGoHqDRx4ijUkzUhL5wK8i0YKUO76Q?=
 =?us-ascii?Q?toEPxEKX4NRlDFU9Y1wVfaUrsXACWY1G/fnHGd4jd0PbxVojFRBzhEXW/UUH?=
 =?us-ascii?Q?pA3NdlBrPfX/7S8QyhuXtmAH+Gkcclh9tiwCbCYGJMNkiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+0P62U1qjR2qARZ3Kj9UjeIAoR9v3Fj1Wv3s+TPygkAPOFTIMeKR0jTOwf0?=
 =?us-ascii?Q?gxqpyk3c5ysPt+fv45U+Fye/cusbmqMZS3VSrCLhYyXMfBP1hcvr13AOl6Qc?=
 =?us-ascii?Q?VRnWhsyLjcDqwITqZe9xEpkj/iIlcOXlic46YJbpOp06BECzeh5L4jme7+vp?=
 =?us-ascii?Q?W9bT4lgBtkZNjffYbTc0jT3yxhFiEk0T5OoIUy3WcMcOYicr8Bm3Vzkv0qu9?=
 =?us-ascii?Q?+6f0jpCRy6FnIdT/c19L4W99JI/bwm037InyovjjHGzV+L/mKkdNqeDoiY0F?=
 =?us-ascii?Q?+kpFgzj/JShlfHgyN7B44zOz+qS0JGT3T462KhYs+EU+l4Hyprdulo9EYb8g?=
 =?us-ascii?Q?tdcTnst/uUs1v0WGLszxeg7HP4lxkVJ5x4thGdsXDIGOSrS/5T/TXAD6bMtR?=
 =?us-ascii?Q?V0s/ApjY1BkFOTTNQrENQxbm+TEze5vusbWAKB83eYrlS2jBaCEf7ZH9Gh21?=
 =?us-ascii?Q?moDSFNqz2c75Ij6aklCAnQGWhbtIXE3tHUBDUNeVxWbLgNSOE74fj+b2zSA8?=
 =?us-ascii?Q?NskFetd71VusJMbrAeK1PW2vpreK8QifsCrYsvxxp/CXkkFISorsfXN4/CCY?=
 =?us-ascii?Q?h92jSBJNtDohQDtSqHFF+JEF5Nh+f89sgqmOEd8hbIx+w5MLx0yqzVDhlH1O?=
 =?us-ascii?Q?fhk41V1K9+CkApogNGH0kPP3iL5OeIhgUA0L3GEn248rCWxzwao6p/5VT3zR?=
 =?us-ascii?Q?6VYC5yYfhpST7+9WZuHLJUE1A5G44913FHqA7b1N/40FAQt36M08zz+s78vq?=
 =?us-ascii?Q?aXApREo27dlatbe046eIJB9mg/NKaxDhTIsnDXwgGMtfjFtfK328CSb1mMyT?=
 =?us-ascii?Q?TAFn/lfSZ7k5+Ce2zkeoTa5CR7X+qd1X1Hicj9JLNzvi7qGJw8W/VtoT95fL?=
 =?us-ascii?Q?c2KZ5gAbrdlLklrpZIy8KPstheY6Zh/qA94ccAQUoQmoD66/ZpJ7f6WY2che?=
 =?us-ascii?Q?8x1Krk4fhT0TEeq/jSs2+sBsDvL5iZ7F45HLuDaHm52nE6zJ+5boT+8IEJde?=
 =?us-ascii?Q?zT9rdVjLCUZmefidrSY2PAgrdku9aLTaWEiYt61Qe0HLyXSSDfkrpkNiYW9m?=
 =?us-ascii?Q?n8lfD/6xR3hvtw4k7HFTNVrI9DQrZDFya2VbIGLu1FOS5XAP204qsbSGLWaU?=
 =?us-ascii?Q?blf9/cMmR7fCyadfHB0SfNUD1IevWWaU8RlTBk5bMd96ezg8Ubxs0jhGr+Q4?=
 =?us-ascii?Q?d7vDcSE721MEh6O1JLfIMT4+9p9u9ddCe12aasn4AX7YEF7pj7ZHzwI2Bx6s?=
 =?us-ascii?Q?hiZcJNYYKdchjrIgJzU9titJf7vSdN5oQXKFRGAFG/sv/xtSgiDD5Zt+Z1FP?=
 =?us-ascii?Q?4lRZgQmxMPD1RdDWE9dE0SI/iPw1aoBKeP1IhyOvI8zuxlJJ09bUf0aU5aC2?=
 =?us-ascii?Q?2IaVIFG5SXxVG0xo2xWv3FW//c06cqeaOoD90uaQYrLJOdPZeM5LyOG7MDpV?=
 =?us-ascii?Q?b1SEvHVRAf4R5Lu2sFsORe3teCx+gT+i2sIRPjvtsWB58eHuNR5w4jcJDFG/?=
 =?us-ascii?Q?5wnp/R/UXXQzaCffTY9R/di3LteHeg5a51wP5G2UfDL8tZkyi41ywhuI4uBg?=
 =?us-ascii?Q?f98nvGawG+sATfCVc2sm3Hv/h2U91fIUkmnk+naL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105acdf1-f100-4f31-0d75-08dcc6ba2901
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:03:23.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: antXNQqd+ugLq4BAmyZVEGpCQ7YdmWVIQy3DERrDQaOm9WlCpNRHMFzImjAKU5q+z61yDzOMOB0sYQxpkWnldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

On Mon, Aug 26, 2024 at 04:13:58PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As the global variable is cleared when preferred cores is not present
> the local variable use isn't needed in many functions.
> Drop it where possible.  No intended functional changes.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ed05d7a0add10..257e28e549bd1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1112,12 +1112,7 @@ static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
>  static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>  					   char *buf)
>  {
> -	bool hw_prefcore;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -
> -	hw_prefcore = READ_ONCE(cpudata->hw_prefcore);
> -
> -	return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));


If the user boots with "amd_prefcore=disable" on a system that
supports preferred-core, pror to this patchset, cpudata->hw_prefcore
would be true and thus, amd_pstate_hw_prefcore would show "enabled".

With this patchset, it would show "disabled". Or am I missing something?



>  }
>  
>  static ssize_t show_energy_performance_available_preferences(
> -- 
> 2.43.0
> 

--
Thanks and Regards
gautham.

