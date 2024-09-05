Return-Path: <linux-acpi+bounces-8168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429F96DC12
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC028A4AE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F917C69;
	Thu,  5 Sep 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckNbVAP+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A614A90;
	Thu,  5 Sep 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547062; cv=fail; b=NClPQUp+tNRr7X8j5fSK1VeglD4ba1/BaYbjeG84qhpDiUa0WBa4YFfE/crqPmbjxxvn+dwlJHVCeWCiMAyU1qtkXTF0jD4X6UaFN8T3PyF8xFFjiQ7rvx56DClPjqQClcS9uFk3dZZI4SG3voA3Aiw+8KG//Krwgpcbcm3Z2ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547062; c=relaxed/simple;
	bh=SnyosnGozQ3K9yT5CA0jqJVq65Y11SI3Kl47i/EQIr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TgcOhvE5imvK1J825TBzhrgg5Ng0zXS+Xkywa5TYprvTmw/mNwEu0ed8hpdgY27IgBlGNa7WY5Bo/bcWD7x5lBbWS1/SfGknTcj22MRyYYHWhLXuQ35omcRQtHRj9eXydG1PJcyfhizrHweMmMi/7g2VOCoa9/97SRQDF5HLDRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckNbVAP+; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgBaYdZlqo6zV+AbTZLwYSEh+PH+mxYbVe+3yrZcK6FIVf38kfUiRffsRcLHZfaycViL44r2Cp41/SCERhy8JWRI0Pg4f37/+sB2KH4i3EquqvpGvgQpYehIec2EQJCvuvHBlzP/dS9cs1YuB8jr00QUVO9FZmVM6hD0hNKrR0pI7EMfAqPdMusj6s+l3ob8hNI7wvOI33bJQncRx6CLJ/V2jShD7cSXvYYL6kbRSC0KS0wpPyN59L1WYNY6ASZrQMNG/Co1UUNhoWEc657ySOdz+/BPIaPgGc00J477RyH077+L2zHxHBkN0oXXd8DCd8SxT/Nb6nRFqD7x1O0epA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqLzuwxUTexe2jCPezrouRkb7NTy1IV6/b73I+s9wQM=;
 b=SajvsxPiKIxFNtgNDGzQyrMwpE+cClcfSvbwdYWwq4kI3qRzax2RCpz8o2jIRiuXHr+5nGN8LOXDLVcLco4AP/E8G/hOAMFycWffzxbqsvNJaFUgZ/bwmeXVH6TV/D5FwEc2gqtLfNtkPLZxLHOWrn+lMvftsOOaucsRKw/gQkkgcB042/U+tx+7D8cCz5obLeoQAtaauUSsSUrJw7hh2mqbJXm0gyRUuKzbhVSOQ7FzQVGzTIvJVkGkyR8WWvuC3yZCgveUD/JuP3jQ9fLiK0SJ34V8iaIao0K+LdW2AiZRlciC9FaD+VnBCKJLZGsfnmIVAGoAxxMxn6L9OMFjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqLzuwxUTexe2jCPezrouRkb7NTy1IV6/b73I+s9wQM=;
 b=ckNbVAP+j1X3xgtIVdar9bA/FKL3EzoYz/5ROcd/3cgmYC4zSF+EiO7GgwAMUUyN6WAhokZL2cVmG92AyjZSFXSgbudg8l/nZQy868txwif+ggAAUOOtzvjLSKWvvCHnHMae8Bg0Am9pYz1ews5aCxgw3dTGF5V6iyVoHuPl4XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Thu, 5 Sep 2024 14:37:38 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:37:38 +0000
Date: Thu, 5 Sep 2024 20:07:30 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 02/11] ACPI: CPPC: Adjust return code for inline
 functions in !CONFIG_ACPI_CPPC_LIB
Message-ID: <ZtnCKu/zOltj5mZb@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-3-superm1@kernel.org>
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: df6df161-ced2-4472-7266-08dccdb849ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kaRiMcc5NFH1cb/4wHMlGt2mx4jiT7BaAHxlOQ7IeifY7r+Q9qpafbvsOkrB?=
 =?us-ascii?Q?x5+rC8BtWdlh44u5pvpvUtMz6fSbSxFznIqD9mOI3j6HqE1dhxGkGcZ7aUa8?=
 =?us-ascii?Q?WVZVXmm0N88cf6OSBWFsd00/KtR2zBBJUN2onKZ2cnY16Xp+ru27/aPqgif/?=
 =?us-ascii?Q?lyoBlUgAS/rB5J7L44g8Gn9ILMtSTTOmwdAQbItDXPr4z7DuhdKxFMKYP8e+?=
 =?us-ascii?Q?7uL02xqJN3V4iOI2Se8XZOysNYpb8Lk3iDoy1dEK2wFmH5Td6ogLzIfPU8nW?=
 =?us-ascii?Q?psHqim1Dd6S2kyGUlqVRMbtnClOXqVY2qZJAjgJVrrnz56XAHjdEUC4dRLTW?=
 =?us-ascii?Q?7k9Liy8AhOKbrWvZgxH+jA5Lq8D2a3aTlZj7NuDn2C8ECiAMqzZ4VqvwKgbP?=
 =?us-ascii?Q?VTWlCs/nzfz0e00+ca+HyPByJh6BZiQzuFYK59214rf98f/CKeElSmL1lcot?=
 =?us-ascii?Q?GOKL020CW/vMDULpy/0Lt3ZtV9kWNyfVnpYgj5ULUqjBudi63wXU5mRpwrxT?=
 =?us-ascii?Q?XceEuxWuqFTCZskR9hncGyYrGFeHyJMV6klRdt++ln9JK3T/B025IexfTpma?=
 =?us-ascii?Q?bvL8wS4Tcb0gl8lr96O/RfKiouAenMd203iIsJcN6anS/59TsMCvB6h2wOp8?=
 =?us-ascii?Q?h5L+KJNEfYo5Z6fLuhlv4vvmuofNdUYOV+guyTLSnoOFRzh5vUds2SfB898O?=
 =?us-ascii?Q?To3ywt8/83m2EYUJayxW2lt9iJJaidrAWF5+0TFHFAdKI5Ix7A2UphLk9oZ1?=
 =?us-ascii?Q?7aYernE9zF2Gi04v569JQkd+8l5hyEZNUJppO0ugEkrc+CNt85aP4DLVWV14?=
 =?us-ascii?Q?/kd/1sWYDwKk/f1DEWWkLoihfJgI7eJcAb0uzD8LuB8TigNqI/dnoYI11G4x?=
 =?us-ascii?Q?4mdSgvUsE2COfGlexrdCpgF9Vx+UZFc7ASMzS3GU7zJ+yUQAC3Mto0eUugd2?=
 =?us-ascii?Q?GLxO+5iINzVyKoK2dNUL8Z7WWhQEoTVaF6AOIPjL5FxpnMhsW+MuoBAHVl7J?=
 =?us-ascii?Q?rDIDBQzRTPJvmK3y8oQVuIbBIssA6iPtsUfe10bfoa5Nk/3N519l140KZwdF?=
 =?us-ascii?Q?ZUtRY+rdxlpLAt2RYqQJjtwII5uqg1hWZY+1kRnhEOiFJ/1DmeDy+msHv+2W?=
 =?us-ascii?Q?bid9WZu62MSjf5vm5e0iyQTuNajG5vVCcrLWpPY/pV50h6KRmTUu8ns9Lo7t?=
 =?us-ascii?Q?KdYAG8nH3QWqx/xT3l8ff1wO6AwjV9qzj66sTWl0Vbd91x/GEak11qTZbA8e?=
 =?us-ascii?Q?3BjavRFqd3Am3b/yGFnF7ZFxmq52q5uyxwqZCICmeuYPr8/4zBWEJdRd3w42?=
 =?us-ascii?Q?5hLqBbAvD3eH5lsdImH9ag2zLU5elU+lk8vPSLpQbXhXmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nVcZRPxSJGZuW4TzZL5jvo7bF5uMZFt0/KYjhhpOTYXW1XMsKfN9H9RUjms?=
 =?us-ascii?Q?5C9VZTeLfPE7cQwwHeLqLYF6xiumPaSZ4UvyUwn9yB1Vq1g2pDgjRGjl9gWq?=
 =?us-ascii?Q?JdRWLXNcv4knYrt0TUbrO3FxWdjr2eSDrKLkkMJAj1+BoZmUjmtgfUd9q+Go?=
 =?us-ascii?Q?9QtVOmmbLfXFxyIQ9WpyMm6ex6djusdbSBpdagm+Zh+9DHBfwj7HVQKLvxoE?=
 =?us-ascii?Q?uuD68AEKJPUvrYm3pTSIpzWmYR8Lem3dHqQuEjwjBWo+7uMgDrey5oxllRbk?=
 =?us-ascii?Q?nXd5sguavTaGcZZJu2v2J5s6p9jALoBsnlUPU4ExA7e1rgHaRhYyiJNx/4+Q?=
 =?us-ascii?Q?cF2OtLVdGvFhcn5Tm7qHfQUHPeNhvcKiGk4te+05YaOZspDsV45tLM8M5NnV?=
 =?us-ascii?Q?mkywTTLKTUYWz1WwWrWeCf/ukfJ97haw8hHEWMg6Lqu7BNFiwncekwFPsNVY?=
 =?us-ascii?Q?ISgsHly/jcH1CDQk5vPMHywKIYOEpW/8//FNrwIa8guzLdEU2y2ukey8s1dZ?=
 =?us-ascii?Q?6T1/aHPwN/3jPLYrTDj/U0A9/CjAjZTzuLkt9un++i6Jqzbo1prEFucfYgAl?=
 =?us-ascii?Q?GydvjDf+UWkBI4+qJETaFL3SUfoVPh/UNgExuHPIqF9GWn9GiQ1Lr4YM9cew?=
 =?us-ascii?Q?hqHe8TE/H21t6bOIrip8ujcxfBc47kYylqQpVuoIV9FRYsgzYKrEpMWt5OYy?=
 =?us-ascii?Q?yo+JPKODwg4s7PUGcGo505txAr/LXfK2CIjN8RdxgYwnmQnoRKab1tJ/5vz3?=
 =?us-ascii?Q?gADtxE285Akig1rZD2U3T8q/evgvsgQuC2V+22zP2Mom35cwuF7S6lotO7MO?=
 =?us-ascii?Q?NpaTGCfYvsd0dym1taNf3WEnbVMu4h0ODSfOfvwmw/5naXdBp0yv3g1vyHJS?=
 =?us-ascii?Q?sWROfxg02SYKuP8hZwp85bVhlci7dkElMCMbTjWhOB0q2PScg4+L28B1z8LD?=
 =?us-ascii?Q?kAgZCHXO5Pk00OH4Ef3NSBMltGjglF+EcTGvl7fuBtMw7nAx563S0guj888f?=
 =?us-ascii?Q?pJcpkqGr1PIHKQYu/1WwjC1RnflRzMcDZy7CjlkDLVJ8S+H9hD0WtEN+ONvM?=
 =?us-ascii?Q?XFcOwzLfuf1TWpcHeQXcrvZW+uI+5fDGa6WqubmoAI/Hb/157UBH2o7OpbR2?=
 =?us-ascii?Q?Kac4feE0pXUbTKg+omI3GJuG9tP8o2EDRYLonr0OKtBiOkJo2O7s8i9N1GwY?=
 =?us-ascii?Q?ZOpmzKl1OV6dGupjheEQ2Wz91mQaafJOJIp6w3ZOaqmDMYe1G7gNhiXLnlTW?=
 =?us-ascii?Q?oD1XfrLxxMMKFb6zsLW6jYfxcDv3VDv6evIj+jPGQVltSYX5f84B1S354D47?=
 =?us-ascii?Q?vQBZ8VIf25/RSbsf2BGzftv8QEXD9lMq5NlE0B92yja+KSGUsSuA9u2C6oqM?=
 =?us-ascii?Q?50nDscS2mvmetTmTifZBuDPx+TMcyxwvykdBOYvnj0WuRaZJpi6v0SMxyVAp?=
 =?us-ascii?Q?15ZBiWC7iaGJk6zPtTLboxoi2H67UXUzGcLd95S8cfryswwySYqU4YEx4dSQ?=
 =?us-ascii?Q?8Eg2AeD8UGtREfTVVl3Be6zIotOdsn2ItbQkPBpJNTsfBzXFObxlSOwn1g4l?=
 =?us-ascii?Q?4df9hwD2wLKAFcmWBIzxgqS7McSz4JsIQN0Dw6nE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6df161-ced2-4472-7266-08dccdb849ec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:37:38.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHNjyYl0fuo+jyLoSGVmzvWzaRPRNAoQLDSkCx/6fnXRwQznGm0k3R053jo02/LNo+UX1JMo6lZQsWNDnFp77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593

On Tue, Sep 03, 2024 at 03:36:52PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Checkpath emits the following warning:
> ```
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> ```
> 
> Adjust the code accordingly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  include/acpi/cppc_acpi.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 930b6afba6f4d..409a7190a4a86 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -162,31 +162,31 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_set_enable(int cpu, bool enable)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline bool cppc_perf_ctrs_in_pcc(void)
>  {
> @@ -210,27 +210,27 @@ static inline bool cpc_ffh_supported(void)
>  }
>  static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_set_auto_sel(int cpu, bool enable)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
> -- 
> 2.43.0
> 

