Return-Path: <linux-acpi+bounces-8553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A019098FCA2
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 06:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2E8283586
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 04:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153704962E;
	Fri,  4 Oct 2024 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GucDaDoD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F042067
	for <linux-acpi@vger.kernel.org>; Fri,  4 Oct 2024 04:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014818; cv=fail; b=jIwLc74rJKx0P5Mppj3Bh7mIViTslPmz3PmLMXiSCWdp+kxZW7qlVndN1OVo7p0rVFzaGXT74MsBVu5oi16RUKRbeV+23+24lrZMR+Pjh/Wk8n53Yi0vnWqtWYSEjTbKGPWxIw6SItz0h1oI/2GtDTtyKn8cBoKAQPUwY8io5iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014818; c=relaxed/simple;
	bh=YF7z8n3vgPMTRLtP6/RCOV44ZVYruFw88M7cLke0sFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UQXUdJqz99UL1lppAtjHafdcjSNkRLPIsDXM7YKZAeOVBQVriDgq/xVlDIAJgjnAJWHjsNCOwRI1iPBW73Ky8fpzygzA1IBSpkLF/TEZFrbBrQB0ScdH5GBxtFMyNEPnB6ylPe8rWdh/nNmGqL4IPnMXh0s2yzwwL5KPxYiJan8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GucDaDoD; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COUpe2jIN58QX3dVmb9vilg6JsdndnpAB0KEQTxPmVyK32GmP0BlHiMcpdOzZPebw9B7sySj9QBHEtzyP0ZI5jZ/o4SitXByWXBe8rbag/GP4S0Gec7LxGcYibTcW7GWhaz8Qu35jmcS/Lt9e34EPFto/+3oMRfY9wAmEr+4iB3hlNDjTCDFY9slUkCcgJBmN6NAJefAEnenXY2t4n+wPOWaKYHaHtdC5asr+6lOg4rg222xalLjDrG6yoJGaBh5TYY04jvk601LxNDXgNp4HIr7igu64skFgL9uWL794li+id08Vr48LOaKKn2MBdnNTHub7ejDxP2TgVJ3hoQHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SJPMIzOPRdziLN+bY+Kwg7EDpoIi7GXh2G9X2/6ozc=;
 b=q7m7T7zx0r+ry1HxgVeT74ptnNkIrh9eT1lMJGDHQW8EfyIZbjJFXk/cJe+NfyV4ZNncpSBR4bayrGYHpKw/UXzhp/J3VRXkbqR9Sl5l534jwzd+QKoUCRZFycY9TXgfW6n5ZdF9PhzSiiyWMeX/47MVtR0UU703mejcZRB1viNz8Fcdy76X8tIkWzXngPME2EQ2Xs7pb1oUHsk5jtCKCSkLrONCeI953dkH661tgUzb+d2LA23GJGpXwvlkib/GAkhMBBnmvl171lgc3q77KVRS3rw9jSUFDYLuCnauKyaCwL7/0ULGgDyjxUxx4zYmXGxxg5DxNyni2kUHK+enpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SJPMIzOPRdziLN+bY+Kwg7EDpoIi7GXh2G9X2/6ozc=;
 b=GucDaDoDJg2CuCOg37AHzEQCy5UulAXVXpWBEOhk5Yc0EoI0RjGdBwFAsVIExwK23jbsTHgQqnnfSfpQKGWKw3Vq2OvmXaDI6RCUtk+99+3pT+7fTWCS7/zo1VeR7o9WlEvjP5SfbVzGwy+sq7i0DYJwKbHE6Qm6/LYhIxj5Vxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Fri, 4 Oct 2024 04:06:53 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 04:06:53 +0000
Date: Fri, 4 Oct 2024 09:36:44 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <Zv9p1MVWa90pxkyb@BLRRASHENOY1.amd.com>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003213759.3038862-2-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: e97b1500-6cb7-4091-8794-08dce429faa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLzsyP9+ZMAZHsWRixKp8rBcO8cxRskMJqiCpcuQO9xByV/VfELWyvspR3EO?=
 =?us-ascii?Q?XZcopsr2BJhhuQ6FKLF2mrPVo9VdPh39mmxLLtENbgPqG31kupjXCnH8VE2i?=
 =?us-ascii?Q?W7bZgZv11lih8jvfNOIymEtDG0jmwGKHgbSEnIBvJLLqiU2LzPyb8rInQxlV?=
 =?us-ascii?Q?N0nTVDhP61W4kZeXgPyWjdEpFTZ8m3FBU638TewLYEYF1SuQIScVld8fZWDP?=
 =?us-ascii?Q?N29ynoUjSbduAofd2UnVx3HOcbqOHFkyEavjYmXhC7QO7a2mpp610J1bqcZU?=
 =?us-ascii?Q?Yx1Kojsm5uJbPkyEUfYhB7Dw+nQERxdhbc14biV1BFrgqvcCy/XU/38gB/VN?=
 =?us-ascii?Q?PvYWRM6gHhZVe3DQbUhVfG/HNcYgxjpgSj5LNyIOTNlqBmikzwrEGzFNTxUh?=
 =?us-ascii?Q?Jwvq3Fm1vDuABMgrIzwySEvu35Sb+dBczyTm9nKrAzVzWQTImGp1/Z8+D0tX?=
 =?us-ascii?Q?woCTn6TBak3TchMC2jVVIQ16bIpSjEtlZRGlmnCbji13a5CWt39c+6cZyhii?=
 =?us-ascii?Q?w6kAQr8NR75cRxh/b6Ix95eDIwP45fMjD+UY2xkRzlQ7u3b9Okg+DFDK5HWY?=
 =?us-ascii?Q?ZoNzSpqpNY6qa0IA9G8Srhh5DLveLO/5tq212CIQOKDRFYXJq3X7rROzHT9r?=
 =?us-ascii?Q?buaYIU2eyZwIq4BHEUjEQMDjS5jMnHZiHKCiPlF9WAUjJ1XDLJtuDOuqUfWu?=
 =?us-ascii?Q?tE77VhznCBGbK28iWx7/VDN5aY+YpOsE40TUGNtjOCbtlNZcVrCV4szF77Xu?=
 =?us-ascii?Q?etiQGaWKPW66QfDw4iZnsW6sdVVvsvrZoiR2JsgheCZR3IMIJMNgJYthhdj7?=
 =?us-ascii?Q?Mw452FXRz7n2KrD8iNTJar0iLW4S03jWvNmXfp46iaDsk4eIGXremWvsBPeB?=
 =?us-ascii?Q?1HuGwuonuic1oWkj29r4vXkxFhL1hyl85yaFxjwQweEF/bLXphemxBOIN0Fm?=
 =?us-ascii?Q?AIwgmpDGgJtYJOTPpsRobGAC24ofs0PctbqvT/t8/C5RD2yzjuE9ryQLPo47?=
 =?us-ascii?Q?hvocqIxNwRpSFZwHe6f9xl7nH9DifjwBct4BXCztK6a72LDeUpW+GD5GWWuR?=
 =?us-ascii?Q?dcT3FErxBgBJMgIXrYg7SM+QIvQoHYRyEH1tAiOMAu2Elk2sAzPyfUMtaAFA?=
 =?us-ascii?Q?kuYVNM4VXq2aKEcvzRzLK30EjBFOyXAZwVPc7k1lZRdUlKN+UbrgAnYFdRHz?=
 =?us-ascii?Q?TPihvmLef89kASatmv5Ld2m1uuCwoxOR0QYtT14HOHnIKdt278DIrjHksT+B?=
 =?us-ascii?Q?pB7eU7NvkBk0zWN8rmsdEJUZzRoxjgzi/pPSsCGgqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRhKeJ76A8FZp5A8M4bRzEi4QY/AZxzd6ZLDBEDEHa/gHF8cKWOiZBzKs6YO?=
 =?us-ascii?Q?mH4ZM+KNl8/ghjqIJqBNsQe4XNi/Gg2omdXpbWbCoZFikci63XGu317SCYpG?=
 =?us-ascii?Q?wpUrMhrJoyTfmEXrgueM2ouV/Qpp0ylJxHFeJoqs2aD9YmBzonJaDV5bv0G9?=
 =?us-ascii?Q?o6LmiOCBFpYGHomxQMWf6wPy72YSo3IenF9Oxhv4QmrGMm93rFynewmVDrL0?=
 =?us-ascii?Q?Xrjs3dk74Ze8gnL9PcPAFruj85bCMS+hqs6jtdaFvbBVFm1IQux5noUJZ1E+?=
 =?us-ascii?Q?DCF/Zcof09oTYUObDgG7cHHwesQKQlOlO0PhWda4BpHpfP80WmhQfs3F00VQ?=
 =?us-ascii?Q?X1JDFCwdWcwplOGfF8iC8tb2YXB4lAvdqnucrA5AD+72GNn+qlieewVirz0o?=
 =?us-ascii?Q?EnziTGvI7uP+oblMZOaCN+Xkk4SRExmK4TQencdcTkfxZmESJjevkuHL5ewP?=
 =?us-ascii?Q?ckmqhBb3st49LDqKTXGACCfdxe6Tg1wQI9s69zg1n+JyKuv4it2xNhb6E+cz?=
 =?us-ascii?Q?jYzID+q0SF00cnVbp/1eKQg0c6lBzyo2GYLOALKglybH0w05z22g7NZJXIz2?=
 =?us-ascii?Q?JmzdblNUsVq/SiGfh4t+y+Tf7AOoSnONBCoqbyWzhsEyPQb2wjEhc27ZXKmv?=
 =?us-ascii?Q?pC9M6HarEajnb01nM6NLviKWN5J78FTxsU2ITINWywRyI0U49vBQB+hKayKK?=
 =?us-ascii?Q?ZGKmTu/D3dwX5/6sfJ8QcZ9CrXC8RODDyytxS6lFAHaBnKGd2mT/Z/udKvZK?=
 =?us-ascii?Q?O9jojzZg2eUls7EwU80OspVDe0t4IxSsXzkQ+UcCS29DKt2AWiBmBcEb5cVs?=
 =?us-ascii?Q?F/ogaKScTL+S3LgkWBA7t/teHlh+PX0M1XVFasu9+IhmdmTeC1BlCjDRQP/h?=
 =?us-ascii?Q?h7PKQwwgGFwXeqysY19Ygu398m0LAEohCoEFc+YrvOWo9uM01giGAl71OpOk?=
 =?us-ascii?Q?D2i/JUinWBuiJ44s/U88bOgCc8BNDID8INOpe4fLTpL6Pm/ztiMmyiTUFjDd?=
 =?us-ascii?Q?aaPDIHRBICu9YeqnpWksy1SlSIIGYUCwK92BWvXF9TcQNd6De2/tqFFwpFaV?=
 =?us-ascii?Q?lECjuhlbaFu38A1GdZQcF8gAfRop7C66D0KS6nfNGm3kFRwSljqXoDRojB8l?=
 =?us-ascii?Q?zXPSVSSuS8CKwf8wDyKLFN15YdtGxhoeVATmvNMO8YuWrrVgUVuF3gDX3Tcz?=
 =?us-ascii?Q?Bq/tcatRGFJJCfm2jCc25yzlsaV0LM1DM6k1en+9geL8MnGQxnozCYpeu+Fa?=
 =?us-ascii?Q?el4IWJk7YFma73oN7F56eIKPeVmcsEbtmc5f6QCObKNTJ+WwjIwhGmuaog1+?=
 =?us-ascii?Q?Y8b6u8Qp5YbOWrFxRTWtguxfViGxkAPtUNnddXles0jBdu+aaipk/xe0G+Lh?=
 =?us-ascii?Q?8jLrCb69rvMhCeDOzHDyEhv3vFyNtdYQ6K/dZ4Tia8JHB41fhKMT5ne2idp1?=
 =?us-ascii?Q?Ws8gQmfpYmELeoX2WmylvOQNYVv9nnRAE0Lh5OwLVT4ju2VB+EjKjmdsrOYm?=
 =?us-ascii?Q?DaB/NCmvNUZYGPfbQmsAi+bg/i2LyQLnQV0WSSncqzeaFuMns8GSOpyPEZVH?=
 =?us-ascii?Q?A99TZ+o5g5N6BXQhAEpdh+MWiooFZZedPWBIAWJM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97b1500-6cb7-4091-8794-08dce429faa2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 04:06:53.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4S4l148OF4SlTmcidI4gO+AAKIHkIRt8EgmCPaLzNYLftFmlsLN4iDqcdLvUszLvGhV7o9s6tQ5BG1TgiqqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

On Thu, Oct 03, 2024 at 04:37:58PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> CPUID leaf 0x80000026 advertises core types with different efficiency
> rankings.
> 
> Bit 30 indicates the heterogeneous core topology feature, if the bit
> set, it means not all instances at the current hierarchical level have
> the same core topology.
> 
> This is described in the AMD64 Architecture Programmers Manual Volume
> 2 and 3, doc ID #25493 and #25494.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd4682857c12..cea1ed82aeb4 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -473,6 +473,7 @@
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
> +#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index c84c30188fdf..3bba55323163 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
>  
> -- 
> 2.43.0
> 

