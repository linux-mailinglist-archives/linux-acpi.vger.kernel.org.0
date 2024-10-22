Return-Path: <linux-acpi+bounces-8899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891819A9E54
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9C280CF8
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14E175D35;
	Tue, 22 Oct 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QntxSMF9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEB12D75C;
	Tue, 22 Oct 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588870; cv=fail; b=dAR/yK2+wx03vPdeyza4yuHfi/SOul8FMY9z3sqhU+ZAhz5npGHk1QheCdDIIm0rgG3FcvuJSD0NLt6Ak1zPZslGXI9W2nI/e+gKuAqj7EyxCwHamJuQNBX+3i21/EguS+oVrl++Ds6A0CdCmZzcqZ0nRKAE9hnu0L7dHZb/54E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588870; c=relaxed/simple;
	bh=TCZiT3dwjROijwdfrNZF1gSdl/HP3Hcizl0UfFf2rG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M7X12Jh1iDxxDZGLGrXqK+7IMRfGBt8rw6sl/uKUPjGNpi3jcl4d4ACVEl4EVQUMJ+16PoAb1bfBPi/8CnSpaOblGVz/TO06/tE6KTRbYc4PnVtA0pIXRlyQJUHEu0QnYVKXMUtTpRLZWP4opVOIllkzWSAIT9WEruamrv3a5EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QntxSMF9; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm9nt5XbYfM1ftBRtxdQHBNs5mzPOMMPlQhVKx3RZxdjGzOAW7HdA8Vmm1CakhGFYMdCkdOtoZH8XuHHSrf55d5Vi5uMsyszodXk52G+JVHBYt370SRu/Gc2dy0fjv5R2OjbzrGbuFnt0ZHjWMqZK+1+EAykK+9ZOv/2Nun53beq5qqcb+FxHGsgW642GHaLTA9qDOwOHYfIi4wY20bgp9gosVElHKcs32o/ezDpCJcm9shkkmdJpYpDv8Wl/R65umYn/0rMumAvYIMTl+rnpmRzUdM3Rr4XphkyYjZnH39VakPKu5tqenkMSjmNsKjOosHfONOAkfJF0WjUzixVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxLwhBLIxYbDMZlxsJd5SWIRCzwgPT3Jt1Buwt9VCAA=;
 b=hPoJTz0FkLNrdD6a7mczWoIjrfc2EVpYu+PRIFJK1XH2crkaAoMo1XhUEHrzHIt5OtVH6j8qd9GfyFrBHQ/XiidePiQmKWq4uVIIgUwMqPkwBWxiMaC/fBtIS7TA0/H9dWjo5E3h6hoc3h9KQ6Jb5/X4W7cYblPV5+5AMU2irlnb5xu2F4QmvnlmCGyYW5iTBzj/P2+9d/hGqumY62jc3gPpTofhM5ve+JlKIhhKu71s0lS7Fc7lKjjv6j2AosolfDApqSDGjSxhbujwaPDQFN7yNKDI7LQqaQS6WRifOPbyEr5HOZy315RzoHWvHZ856LhSGY5G7Yqvt2SoVwaZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxLwhBLIxYbDMZlxsJd5SWIRCzwgPT3Jt1Buwt9VCAA=;
 b=QntxSMF9Ed1ZDEV3Uq8xXMcltjvAczl/g9IlYA3zHDtk55kAYA5HI+c1LK1OzniOGQqKDen3cxqHIHDyw3y2bkFjBAjxKjrrWzyVRGyBxn+jJnzn7KglWcz20STG+kbtAQKTyLdfMnR8VT/GuEb8V3hMFF+4oreKB9yQyK5tNJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 22 Oct
 2024 09:21:05 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:21:04 +0000
Date: Tue, 22 Oct 2024 14:50:54 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v2 3/5] x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on
 AMD Processors
Message-ID: <Zxdudu1tpCbNvm1d@BLRRASHENOY1.amd.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022034608.32396-4-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 17646253-b054-4d9b-b09b-08dcf27ada6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNsbSt8ZJa3M5doHQeU/bto5ttiRSrWuScfxnExprWvBMda/9ayYQHxoTA5z?=
 =?us-ascii?Q?thW90xR9PibvgFkdNkPJ06UZq+KVITpTK9tWNBv4z6l0f394dDOB2+qV0Vw3?=
 =?us-ascii?Q?u3d2cbg0oZ/r7bZxWBQfmW2Gi0c3wXuWi29xQNFTib1CVo8KhLAUukc/DSN/?=
 =?us-ascii?Q?qdpV1FMFl5VGmfkvRvtN2N75MmRMWQt4k8cRdykKv/29VPoKWKk1XIUAU829?=
 =?us-ascii?Q?l32wDPge5Pr4GjIWoS6WY3OVZKPKs2lq1oIVW3vxRe66k3jNUXOL9+/gUQOa?=
 =?us-ascii?Q?D4AiMxF1bciDOFMdcQpRDMuzCKRieIa2C4X3yyQn6oQFUPHulJWqxs/hEMeL?=
 =?us-ascii?Q?2NlmXWYp+ZTZ69phooUdAmdztDeOqGCBZd6PQP4tUHSG4DjywCGZl1HPi7kc?=
 =?us-ascii?Q?4Jxy2E7a+GMLSRTvTWYpdA8KqVbUjsbL/+tj2EknVQ+tkZCVS7WremzC+lZo?=
 =?us-ascii?Q?OJkqdCyn8QrYHHUEawEWbNQeCCD/hagcIWxzQY5iC2+lHpn3jpez8iQ8vGrP?=
 =?us-ascii?Q?iHfOsPmglS9GwQMaOsNHtfjY8l/oyxxexhM3bKQpc7s4K2BuqKi5eReqw+ai?=
 =?us-ascii?Q?IwDXdUsWUhUy2tP1jz8PIqYcBW0gF6FXB1AEMPNPVHh9eyIQRDb4ivM/3UB+?=
 =?us-ascii?Q?oDTqChdh2/dwabXDWawmZFvm67dS8vOUVa0hHxhRqIIE8bdEAZwZMt1++z8+?=
 =?us-ascii?Q?XKcau50vYlt9k6rCfMMg9d+0F/BsSC20+SYKoi7LfvFCtgAhG9q+HYLd2KQV?=
 =?us-ascii?Q?o9lap5Ni7bXBOnTLEf3stTJ5MmWPb60condzlAULijPOQK+vmBnayX9ePmwc?=
 =?us-ascii?Q?pmkvc0QVz1l7qmJ/IVb9xFJUOiHMMQmNhlJ9aENNPDF5Tf0QwJetMd803EG1?=
 =?us-ascii?Q?SV/2rRl6hsUIxm6abJVF7koSngTBfeLUAECGWjUEKy5jVoaPARVd8EPCaZB0?=
 =?us-ascii?Q?aaJOTjhutX2SJhHWArYD3R888xijWTdMUpiZCfSdM4e4hFsN44fEkJgHNz16?=
 =?us-ascii?Q?Yoqh1V/OZtQ8yHPNWYfzp5AF9nyfxDBT0O4A1YKi1M8B7cgmOEm6vefsm3Tw?=
 =?us-ascii?Q?STBwF/q5fHIvPon8nv8Ln45D5a1TPVKILGvWrbDQZAAcNYVE0WGIRKP9hMve?=
 =?us-ascii?Q?QHhvxLC/x3scSC6A+bILci9awrvi7Xa5WBR6lYVqeOqNr5QuqCjlIpJyMU9K?=
 =?us-ascii?Q?tK+yJmcGJjQTnGnJ7+rHXN3+9R76mth8QEAfdzyw7mJuvZij8X22BLNT0ofi?=
 =?us-ascii?Q?WfDmXujnbUdNdRP59DiX5asp+fawrUPlJIRcrlVvJvFqYQIhbViIf+ArNzsq?=
 =?us-ascii?Q?GdICTgbAudkrbiOiRGNjhSGN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfrZzJ3ewgy6rseXKM6OexeHg6pY5tjPGwVaDGY6lZ2Xn6+BNDJvv8N2Wyf1?=
 =?us-ascii?Q?2RJO5RTZoBMwexEKyw4nZfWIXmEO97gQ2e+Yxd+m/c0eyRT6TKKnAU7m5W0P?=
 =?us-ascii?Q?6sDfFVhllpskZY1io96DyPCPTg4lFS249wNKrPYeZGoGL7mGbLxFt+BxIPap?=
 =?us-ascii?Q?OagKK1Sqavbss9iOE1hA7Bx9nvpXPsc0Er1QAjplYA1KVomKkI6MFjRwzyyj?=
 =?us-ascii?Q?idcFfS6VpXf7043Wh+iwpP1kw8Za9C2VI9AsquWOHK555IWIlXPRRAaPryyn?=
 =?us-ascii?Q?Xfpr10+5mFrQomZYZ4kq7rVWs8hDc2bn0AxO7O+S+XtwV+a8fzSCEwC92rMX?=
 =?us-ascii?Q?fq53s+F3NTSnUtph7QfdXN21NZvmU9YQBRZt4pqNXtR2AFLMQxvxYlnHECUx?=
 =?us-ascii?Q?VV8+gdWxvSbA93//DZ4ETBGXEybpI4CCb1O5+YMBCAAPyb/B6B6lU1D9x3F0?=
 =?us-ascii?Q?UuT3mAPI/qIADqiO9gz0mZ/g3vyksTznFQ3MQqypqFsCSOvmFKcbtJn5nuMV?=
 =?us-ascii?Q?YHJbUVZoS7iF643krJCa0NS5WOJQYTtx/Cyd9A5KhtHKJ1X1cjKWn+palxeO?=
 =?us-ascii?Q?NtxFzHQPYioP+UUbMHIH17voqfrgHOrn4NuUOUUwY/zITIkso1NqJDBJKFeI?=
 =?us-ascii?Q?eJKRamPS2quJzvaqkZMPwLcYtNMEAvWmY1ps/NH5pUMoyUkxlqTjUAA1SFlA?=
 =?us-ascii?Q?BZTURZaRIM0kfHF7N27DtHacUMJ2gOTjSBo1Unf12Fgvj2bvKFTS0bqtzxXd?=
 =?us-ascii?Q?C+ttgaMHKoyfloxU1SAZu/7xP/q7pbHHNyON0zNcVXYyOsBCe3/+sg+8o5b7?=
 =?us-ascii?Q?KN4S28osdyO+LAopAsa5mdlexZ3TveBZ/8i/Ki+DlY8Nz54SbQM/NVoYVTtU?=
 =?us-ascii?Q?XsRuvRZ6BqZR+AvWvIKxuH90dMvjz+xsFh3jozuEwPnTnQC+wRChkZyliFvn?=
 =?us-ascii?Q?zJbt5EqodvQnt9s4tIeK/ATo//r9qBmOl1X372wP4Zq+vCrOUSB+2kI3KLbx?=
 =?us-ascii?Q?pcuOSWEV4aaUQYV6bY9vsg0ooNtqVDWi6OM7Mzpg0l06BzKxHoXbMopt8E/B?=
 =?us-ascii?Q?iAoP4+bazYH3kw3Se5BbggIt0FOtAGh8hI6UavfbDTQTG8mH84LbQPgubOkb?=
 =?us-ascii?Q?lfMH+xu4bIOugYddDevDtCq4U1GtXG8XBHMb9IXuBWBKnaLBjmA1WFOsdDpc?=
 =?us-ascii?Q?XPN9V1Bq/wqAHr7KLWjTYWlYLBWHkurKpVQAoKteylJTpxlblFx3Kb8lzCru?=
 =?us-ascii?Q?VH56FqpgE/SIbFFLzCWsXv9PPmcM2OqfWjkitEF8CC7hv2yj5WcNmI/Vd4ZQ?=
 =?us-ascii?Q?UjUiSdOpGohP3rrUuep0hxxlLEAYqAIIZiaG6jpVZqIzhC+ENK0o+7iDvLre?=
 =?us-ascii?Q?v5umcweUfDgBKYyc1noCasoXhUndoiCeZplQvGq3rkcyygbVpwJgq35/dLxr?=
 =?us-ascii?Q?KL6VCGkUZfzydMwfDzXpcQrx/JbAi9WlvmJ3gOCPS2cja3zrGz6QQb7yRLb0?=
 =?us-ascii?Q?hbf9yyQ3Ue/263F5f5zCQ/Vf0VHbQqkWQMCbnBAOyZqPSMAgS6SKbVSEd2C6?=
 =?us-ascii?Q?aWmudZ+SN+UvqH2DvIwRIN51mD0sALuohDDIsqFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17646253-b054-4d9b-b09b-08dcf27ada6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:21:04.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMHCl+nFrhCazSSmrWku8drdmGP9Hty9oaPtTvt+ShUEPweY/l9rGw0bAanuEcrmbmAxm+QQ1xidaFxcYgnPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

On Mon, Oct 21, 2024 at 10:46:06PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD
> heterogeneous processors.
> This flag is beneficial for processors with one or more CCDs and
> relies on x86_sched_itmt_flags().
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  arch/x86/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 766f092dab80b..b5a8f0891135b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
>  
>  static int x86_die_flags(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -	       return x86_sched_itmt_flags();
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
> +	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
> +		return x86_sched_itmt_flags();
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

