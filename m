Return-Path: <linux-acpi+bounces-7889-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D39614A9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC291C241B4
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09A1CDFCE;
	Tue, 27 Aug 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j0dabkXV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77843AD9;
	Tue, 27 Aug 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777585; cv=fail; b=sxlc99m5H/Dgeoyc3MX1IJdnja15aptf0Q12nynT19BNl8dWPa5eAGCpoQEiZxYDIiVbilrqBEc+KOrdeuWR96pRkEQ2iGJjqVayc2X91l+mOSvKAIPK04BhLa8SYBBhpLkvvP1eDI4ZjxftpknerqLFHITfb7s+3twJFEUT1k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777585; c=relaxed/simple;
	bh=W+O+nwA0XeiGJ0U9vM8dxem/q8vX0hXWRUMgJknocqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKMposJjkxV0CR4hGqqD3ajC3Uzo38VQoduPtOediWpofO1vBSEQw6UGIgS6lI8uOkZ1FcL2iVlyQbNYYgIU0mcfzn0Kb6IYbpAy7jrHMtQhHmWA4y0KOFxZin3dfWgT0N21Sy+IVfXf+efyNnC/SYYxAhKaSFV5ouMe5IgVJGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j0dabkXV; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naQpViT7YmBv21G0IekirFKhs5Iba17TFVPHQTNrk0p2R2fHmVRQNeH8YJpTJ/y6OrlbJjN/l62vl+mbkKfwY5ukG52BBDYotfdFrn8KZ7ZPrDo6LRKbKiFSwFOzKDch3IqZBQNHQaBAKRr4X0ip7VJ6J8LArqPdUhcFJQvBNGggwmnzH/p2itX8AG3GySGUA0u6zGgSpyosgXR2ndFIBHxJBxAITWMHMFsnkt5xFxcNpEVigcfIkOKWYFar4dzkS/QDddbd7ggAhkq9rTEdo63T4CT4mSk0HBt5jONxYr75R0x6ABZUFJ4qY2tYbpL+xI4ZcnqFg2KTaUAii5TCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVIQkGjKbsdi1TYf51fMoBe59cxe70G+UFQUF287KfY=;
 b=OdU3WsOdOL6uqKamts9/gLJXfv5oDh5S0xx5kYiLhisUZJEMI6gpMTznyjHpZA/hitIcPtFW+l+psCPTsLaoKgCxvrTix/UfR7xa88SVHFx6U7OsTnWdlDJWmQ+NafYdT6LtqJVtgX4zIgYjMwmQ7HhyXz57kEYl8Nka9yp46OZ3E+co2ELmCKcYK2e5g4Hr0Q+BUUITPVu9t4jmS7OSw2Q+Eh3Xnnxupo21SJlCwsb2IMhlp0tH8XswAfwayyfwm9+I9JQZlVwsh1vxX8nqx2Oz2CbsXXVF1J+068RBPPilgv52irVA0pnSP+/kktKr08eBAPOB27hFLPDDHODP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVIQkGjKbsdi1TYf51fMoBe59cxe70G+UFQUF287KfY=;
 b=j0dabkXVTE7xbVSpweaGbnLAv7ChoEkXxuuQ2ehnIG1saaTixdt8J2gZdfY59DPtsHiVXXQZWupGaqFF04muIovCNYqWPZ/rWZQ/YbVAvuq7OQG/LIPLNyDoySYmXj9oQMT2tZW5clA0GvkeiJrT0pj8cSGIxX2xOajuRSeig7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:52:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 16:52:55 +0000
Date: Tue, 27 Aug 2024 22:22:43 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6/8] cpufreq: amd-pstate: Merge
 amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Message-ID: <Zs4EW7s3Z32UAFNI@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-7-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-7-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b97b90-fec5-41fd-37a4-08dcc6b8b250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GabTFJxaN91yGPNfSFF1QHH7QjWZzJ3MQdM0vgbJr2yrZz7buCbtspYHl/gX?=
 =?us-ascii?Q?A8CmA1+BKwrMmgVqfSl+DA4pJLL1kOHOqQn2DoFkUYJ5/Cd346dtm4PWcVr+?=
 =?us-ascii?Q?5VKJjpboKDqPAW0tyrFc0Q71AjNA7WdQrajrlDXZhlkMOf0EeTtq167NC+Ad?=
 =?us-ascii?Q?EP61N+bf3ZVO9aYl/WkXy/+MTaTrsu0WDxJcqv30oF4yedYLJmnUFMNPWvMx?=
 =?us-ascii?Q?EdUGgrvHlgP3ujiTrWNMMPSAazC+eUIkcPn5fCssK/5d5bIbQD1ldiMNwnCe?=
 =?us-ascii?Q?36GdfzSdb3CW1brdraFl8e4zC8stD7nGMCrq44xiS5aHykZUfunaod+jaesN?=
 =?us-ascii?Q?XSdCep426dfXfavMwJmoj1wdtXBDxTSPuzYuuKIgGeFGdQ+WEpaEyL/9ieYH?=
 =?us-ascii?Q?czWUZ1Wz0ialLoTS+XYvMFaHjLK4HL7OPyFb7c4ShIvPLNja1ueIpOBhXuNH?=
 =?us-ascii?Q?a6b2sc6Zmab4ax0tAofdKuMNBEjAPGkpRdr7NbVvhFwWE6qm3W3r0I4RkUng?=
 =?us-ascii?Q?1TPNx72UMKLnnA7VhOTiUnwksf4nESV045iQUmsjpgdUhyDOwzizkSC7QBUI?=
 =?us-ascii?Q?NxhjnFrXHRYpL5lddXw8B5I/VrTpAHQjurhpwfXx4Ab0ut/4fPgGjPokUeAE?=
 =?us-ascii?Q?JzwOQ2ssx6nnNi+mEnksSnOvpsD1gcNa/wq1dLgictH17QVwds3x2VnVpIPE?=
 =?us-ascii?Q?M4TdPxaOBKjyMn+jo8Qz4XTioMLd8ACatAvHcA4gx0bZzWTn4cb/O8uDP9bg?=
 =?us-ascii?Q?OcJtfbKkXbOfLMQw51W4k6JjSqijs7Bfrvntvr0e1rtuGbHD8FgtXrzE5Dtm?=
 =?us-ascii?Q?r/o4Ws6vzXyr9YxQu4U1Qh/MNBOdmT7TKf9vER6QRMmk4FwfDGwDaBrvpSfL?=
 =?us-ascii?Q?ZnrmZJUcRLUVXH4LHJr7j5lQip5lkKPMNrbwHauKVM1FlwTB8+z3lYYlv9eJ?=
 =?us-ascii?Q?zfXyzB3QcRf5yj02wfCZ2eC6CTsSG8IG4XEPJGr0EQMhY0VkI1ImYKppGdgD?=
 =?us-ascii?Q?dQncZ0fMAeTn+y71k1w4SPUcyEoeU9giXiWCfqLVfR73TNVqOWSQjjK4h9ZN?=
 =?us-ascii?Q?nYBxMYJ7f9rCN7hhshlMteJ8SAqtH2RnqBmk6HqayvJ1R8Rr4h4qyo2SpnTp?=
 =?us-ascii?Q?LF80VWOljW9uS8Fhabq2yIMjb0FaNmRtlaFiOjttmE9NYTj8UpCsXi5eW1wT?=
 =?us-ascii?Q?K53YnW8qRAsjdf6vFKV4ULXyIjwcYd25UQjk+Hy3ZVmKhItlqNz/epvRYRZl?=
 =?us-ascii?Q?YqvVUtMU2N7HDoAwS43npMZaadrzTXfgRuTaiXwVPkauhOI3WMEE1QXFs8Bm?=
 =?us-ascii?Q?H1lmNqeJmylcUzfdXy43C3Epw/dViGaw76tLO44E1X4p6n4BEyV9CVL5UaW1?=
 =?us-ascii?Q?MwJhoTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/ktO0kiIXKv7j06Zpo484jLhd7wkBH2HpJDGlgkBQwJ7f9LLbVoLKfUDVvm?=
 =?us-ascii?Q?M7sVLegq96AEo1rbtJ7avpELN0Q5upqgpPm5pVpqw1drT+7P7VH763Quce07?=
 =?us-ascii?Q?yyI7yvmGueOzYF6h1L0xJ/pnzJibr/yEcTEbpv3PHImzr2Luq0dIUvP2WRLk?=
 =?us-ascii?Q?osFlK7QsqdTqEzDjNB387/H5CtZW8XsHSQu28bCY6bd/03FHs6mEEWV/Ql81?=
 =?us-ascii?Q?oY2X7kGJPtN7itspug1LO5f4zipZGflqQMILVtqrtYJeoNMb/Z9yvvII7zU1?=
 =?us-ascii?Q?3fTo9v/XJXMgIBJhP01zZJOD3IVsdq6z8VftKtoHc/KhKTMf6o3HUK6EZEJp?=
 =?us-ascii?Q?wokRJArfC7tVWD1pQg8L6GsIDQQwEcHqP1o19T+AIxa0sM892XyOQF01ErYL?=
 =?us-ascii?Q?WOU05Yq9ZoX6pCny7bgcmmjBd7kwauFdEJ0n+4jcnyWFmKI5O6ar2K6qSf81?=
 =?us-ascii?Q?4RLBaj8h3TS63J0mR2VyQX8tsRi7+xyNMWmnasTFaAU9oBPXUuEbu83qKWjl?=
 =?us-ascii?Q?q/AlNAgjoLPskRWll4m2Ev7vrNHtuSh27juJ1Qa2x2eYIvuKzQhWuPKGlcXu?=
 =?us-ascii?Q?VYF3XzruyCxpjvFoRB2LLsaJtlGAUx5s6u+zHdEpc5G6jI5xzL68ABqVDSDG?=
 =?us-ascii?Q?3J/QfIKa4JJJH7L9439xt17qK1BufYzd602EDxTpirgz43c9MdGvG8ZyVSgw?=
 =?us-ascii?Q?bDKaMp2e8whOpjXOFJne4r34/jkm2251beEIqjpi7O3ZHG/sn9R90zcGARQP?=
 =?us-ascii?Q?VtVRB7FT1UJKywLYAbB2eW6PpXv0p651YpIbd2vX+LHuNQboTr7o84ROT9Cz?=
 =?us-ascii?Q?9bW8T3ENqUr+Y45YzzEJVKTfaQxygm/QHJJn0PBhLrVHJ+ZeUu2fGw6D3Y0O?=
 =?us-ascii?Q?IYnmc3OYMQ3Xvh8dAGz4MpG7XowStHeUqCsda5L/7yB0mVMYBw8oG9u7pES6?=
 =?us-ascii?Q?8nHacUUV1okCyKutRc93C1GwlZacrDpbsugRmc24xB9LwU9XJ7CokELMj0q1?=
 =?us-ascii?Q?1bhlPPiEiiB77X2+z+F/ItOuoH2c7rGgVYYYQjlNlqx+L473VykBHHnsxvpe?=
 =?us-ascii?Q?oSLWKY/bWFl0G0ZJ/COvOjtwr9XbrNvbp998n2TP7EEbz4FflpIvpORXD4IQ?=
 =?us-ascii?Q?abtQrn1wS04fFOX6zdUeFCN37J04Xh0Sj0gwb+u6mirBVVKr82L9Affhxaju?=
 =?us-ascii?Q?8as7pbiTmcYs8HaHMOx5Fv5wYZkbFMyXYHuYWhwQTwi+xoi1Jwsh+o4wnfY9?=
 =?us-ascii?Q?N3PSW6CZamRiJT0NjrV4Hv8U1ALR/DZi9Sq8oHmlTeoXGEEgo17ZmqqafOIi?=
 =?us-ascii?Q?Qw4b4lrJVZS3HvYdIWruonnQf4MR9Qn7/7Mad+AsH5bGq59vJhD931DlsJxn?=
 =?us-ascii?Q?zC6ZsbrPJfz4RcJf7s1KzPOMeslmJPKDIkPGTFZlCRo+wklMmKKIC4UZL2uV?=
 =?us-ascii?Q?h9mGnM6bd68PNHSYSY9K/fWkNkSV+gtOrAB9jEDAfSXO+Ybzd+O2z9WVXbKa?=
 =?us-ascii?Q?voIkT44+hQ8DVdt8GvjcmqgPMT/o0pDTWicMi5yJpymyusUvUcApJio5TJJK?=
 =?us-ascii?Q?Bab8DqFZ7YPkdQhN4oTBDBY3u3SiI8cGxdc3KL7a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b97b90-fec5-41fd-37a4-08dcc6b8b250
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:52:55.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs6Lu+WGl0ejXAbsa3/7TBznJMYRzU9bKuDT6K9/7MSccuPqwABS8hixH/wLYwezTjjvfhVPdsaC5etH2fmCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Hello Mario,


On Mon, Aug 26, 2024 at 04:13:56PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The special case in amd_pstate_highest_perf_set() is the value used
> for calculating the boost numerator.  Merge this into
> amd_get_boost_ratio_numerator() and then use that to calculate boost
> ratio.
> 
> This allows dropping more special casing of the highest perf value.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c  | 16 ++++++++++++
>  drivers/cpufreq/amd-pstate.c | 49 +++++++-----------------------------
>  2 files changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 729b35e84f5eb..44b13a4e28740 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -9,6 +9,7 @@
>  #include <asm/processor.h>
>  #include <asm/topology.h>
>  
> +#define CPPC_HIGHEST_PERF_PERFORMANCE	196
>  #define CPPC_HIGHEST_PERF_PREFCORE	166
>  
>  enum amd_pref_core {
> @@ -244,6 +245,21 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  		*numerator = boost_numerator;
>  		return 0;
>  	}
> +
> +	/*
> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> +	 * the highest performance level is set to 196.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +		switch (boot_cpu_data.x86_model) {
> +		case 0x70 ... 0x7f:
> +			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	}
>  	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
>  
>  	return 0;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ec32c830abc1d..75568d0f84623 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -52,8 +52,6 @@
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
>  #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> -#define CPPC_HIGHEST_PERF_DEFAULT	166
>  
>  #define AMD_CPPC_EPP_PERFORMANCE		0x00
>  #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> @@ -372,43 +370,17 @@ static inline int amd_pstate_enable(bool enable)
>  	return static_call(amd_pstate_enable)(enable);
>  }
>  
> -static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> -{
> -	struct cpuinfo_x86 *c = &cpu_data(0);
> -
> -	/*
> -	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> -	 * the highest performance level is set to 196.
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> -	 */
> -	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
> -		return CPPC_HIGHEST_PERF_PERFORMANCE;
> -
> -	return CPPC_HIGHEST_PERF_DEFAULT;
> -}
> -
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> -	u32 highest_perf;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
>  	if (ret)
>  		return ret;
>  
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> -	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> +	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));


So henceforth, cpudata->highest_perf is expected to cache the value of
CPPC.highest_perf and not the boost_ratio_numerator. There are couple
of user-visible changes due to this.


1.  On platforms where preferred-core is supported, previously the
    sysfs file
    /sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_highest_perf would
    report the boost_ratio_numerator. Henceforth it will report
    CPPC.highest_perf.

    I hope there are no userspace tools that compute the boost_ratio
    using the syfs amd_pstate_highest_perf/amd_pstate_nominal_perf.

2. The amd_pstate_prefcore_ranking and amd_pstate_highest_perf will
   show the same values on all platforms, and henceforth are
   redundant.


Shouldn't this be documented?

The rest of the patch looks good to me.



--
Thanks and Regards
gautham.


