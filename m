Return-Path: <linux-acpi+bounces-8174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1096DF45
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B291B21DE0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226519F495;
	Thu,  5 Sep 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BzZ+RA3o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A82101DE;
	Thu,  5 Sep 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552680; cv=fail; b=m7VFjV+TwAXyJ1VqQEG1uhHOdwYrh/VTu4OixySwRV0t//tByA5/krJYPfeqg45xZUbG4vQG+894JuYaDdKH6QmmnJg/TDG48oVvYbdO0YrlTtVdxDtNwKqvKPyB/PulifYut+18bQ11ZCBsTSobaaQd7venB9m4l3RPApSV82Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552680; c=relaxed/simple;
	bh=wtu0Gq4iqMxV7H9ePxUJCpel0Ye63q2DSPaU7w01KrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNTmUpHgZ95Ob3U2lOZhnVHvj32sgBwuCfdrbPTaRwKkjlGZ9l3vqY+OGydgbm5jlrRflWpZIk2l/CehevTRdmCUps5J2GiDowqjIOI0WbHUh0146svU2sdUVOTzJ6BNNuGlTrqQmkUXXvToFXv0CuVXkV1qwI2b4Tj7SdrQZpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BzZ+RA3o; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLIzHN0oiXZapH4ZfQnDgEUTO9ZoK4tcG9tvhS4P3PHrRhoKoxmFBPo7q73Cxeg8yr7oqpBfR/UqpGx+H+cUHTno1FAxEBpXxaDFVbO6sC4OZoxtEy2XVBrDZIEwBfirN9AqXsdWqeYLgx8ba80iDrZ6S+VQDEnB/7M5XiDxQs/2VJrUthtOqfxVfZymkzsQstZsfDjtm3ntBT1cbRxH95qZxyCF9Ql6DLs106n0wK54vKn9CMCRSLtvvWSmJyie13Hb1L5cstEeTM+GOzIXeQDVXsNDewCR1tAmjhyA588ajifxZ7BV8ueHA2SrrTk0rhfnsfbLmtVQBTe7jJpigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXoxbMoE1FPjhzowstzAZltAJ7HjPaxsV6xmZq6sR4k=;
 b=FRTgU1Fte7ngT8B2SnwXY32W42w0eJKvDtc15E/8MghXGpx/8j31PWAGCyvpd9Tj/vhQtCWl2fH9RYCvNweHUC9ovYcsqjStQNqyyLc9itKdiAYvASZ5JkhkroW9mxi50mY5uoygRybJh0GNwXeJePg3Dw+DEhIGCinw3ur2PQ259EZndAQRindwPXA3xmX3/xZutsg5TqNv49mPnG0UrAlIipkV5OHQAVbnQDqM0Wq/qcrDkjHUrr82RxxUybVeVeXjZISzUuVX04fGQ6EJido7yYXvNawwFsqhJz+dSRWSW12Fqn5yQb5VrZtlE74D27DnVKLIkk6AtvEb8tIVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXoxbMoE1FPjhzowstzAZltAJ7HjPaxsV6xmZq6sR4k=;
 b=BzZ+RA3oYY9GbQ8h8Ysg0vlu9BKDM1nqD3/n07ihnwqa8K9Rb6+aFzuAFShiktDLcaHeQAHAt7Q4ZHRnH/sffEORqLRxJa9qS6faA1FzXNRI3hflqmPfii7z0PS77qblDls9eQXhbTXJOgmhwtC0BZ5avBTThvHb2DhJSohsuvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:11:15 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:11:15 +0000
Date: Thu, 5 Sep 2024 21:41:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 11/11] amd-pstate: Add missing documentation for
 `amd_pstate_prefcore_ranking`
Message-ID: <ZtnYGFNzMTOEBtH3@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-12-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-12-superm1@kernel.org>
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 21634a86-67f3-42d4-85b6-08dccdc55e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PgAGQiZ8bO/utAsL7HOTu4iF7IHQ2DW71bfgtNNs34/U+6dKPHNYpDK2Lu+?=
 =?us-ascii?Q?HJnLAGo2X4kC1w5qlzdVuYTQMxv1e12j8UY8emC0b3fSWmm505d++DF0OM2s?=
 =?us-ascii?Q?5C6TfS34fn0Y46mdmvjFvqaTWilNqLz7Trc/oI3nq8BDPsh0Qcpek0nCw8nF?=
 =?us-ascii?Q?CIb5uIfZLWhEuEN70h/s/QD4/uMvuBiFNkdwxoDqrsXIvslt9j2v7UUuFNsw?=
 =?us-ascii?Q?PPvy0OyRlOE+AnLOJfnSW3YzYscAM66QiO4dMuHhR0CcsNHA9A686FLhJJU3?=
 =?us-ascii?Q?Dp/JvVmut45Te7Pf8DhQ98Ofm+gPjIAPw9/lkcqDothyxdi41Z1vvQqyfZxX?=
 =?us-ascii?Q?39A0uUCeWFbZwvSeMqv/Jd0pzz1yXm6cB03zgE5QvtnFo8ZvDjcmaF3Gesph?=
 =?us-ascii?Q?7GHX6jMafKyKmtUq4psnvGN9z/wtpPxG+O+ekzAXBW8v6ypxEen6NYiFs2Wl?=
 =?us-ascii?Q?OGZIS8ySTA6Qpt6vbnkCYXKyxr3JxlKnuCVhrY8e46r5PE4LazB2szhbIiBX?=
 =?us-ascii?Q?mSqEK7QoylaMeX9bRc1OFUluYLMVpe36R6y2fgPGJmVnYB+oULLm07iw+5KZ?=
 =?us-ascii?Q?PsKLd6qBh4DgSAWf7zo06hoTnA20sBuA9HkgDotOV9w4tRAGNi2ugtqwNWtl?=
 =?us-ascii?Q?I5/8z+8DwKs4hJg1HvyfnYpt9nzatWnRFOfLpdHtTXk74ITnOjOgBnVLKeJj?=
 =?us-ascii?Q?I6h3TA9nb2T1HlfAxwLiWDtj/PCn3vlSFu0f0SulPn9kDmTUvkz4t4Nyb46B?=
 =?us-ascii?Q?oCoeJZbiMsRv79ptZb7hqkkLUN3e4/pLjueiLuyALBr3ex1svPjE7lfnWSaj?=
 =?us-ascii?Q?1JxM9urFYUjJ6Pbrla9ee1tsg39JHjMT3B4mImtQE8nqXASYu8T9MCtljbGV?=
 =?us-ascii?Q?2o6hWcvEOlgO++boPWKu0dqOrC9UTmqJwVloMgIWDbo6rm5JgHmraaRCpUfT?=
 =?us-ascii?Q?Cw3DuIQEIAOICgm1xv92lJ/VpWLFJ27xmz8pn/ezo5fR8YMWBiTvnlCo3Hyo?=
 =?us-ascii?Q?oWeAnd7NUZjWfTeq5k5i9bcpUs1AhJHRjXlf69A6GQ50BSvQm3Ws2k8zfpZx?=
 =?us-ascii?Q?IMpFvwml9khz+tVxPqkpqaV7UrYOI0mQBRZ/1jhbwfddPPgkm3IZvWWLPK/x?=
 =?us-ascii?Q?jykzzQOcyYoZiDxnQnlrczQZRiPYCLfcwNkykcjdTwMcpJ9x3DIH3vFd+sX4?=
 =?us-ascii?Q?6uulwDqlJ5qe8zj8cpnzI0kq42wHwnXslhq6xTtcM+JwB/45pKnrUoLwUbOC?=
 =?us-ascii?Q?u/VtD7mQU4/qI+CuxD641WSwWSc+tmNDXU+IWc/MwzZUQbTFvTDjlwmUSsxj?=
 =?us-ascii?Q?S8jP5FcKKm3CGPaZeHxqsdtSXp8FIaHIt8pR9M+1dbIkfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJwotzFsd197MuisjPlr17J08M8BBdfuTKHA/P4dHS7S9lyMptmGrMJcc3Sl?=
 =?us-ascii?Q?kJ2f4G82cmSwsjPQgvtKU+jxpUvmKadvrnp7C1npnq8wzjyFQ7MWFd/lJzYF?=
 =?us-ascii?Q?005+qO6Ir1dMZm2/n4hUX0A3jMCawzcOHQPiDd1gv0f+6gisALBPWeHKUiv0?=
 =?us-ascii?Q?lKD2n9RUG7o6Y2yx/4b0dW3m5miMvug7mINsgz+xFcUAHWhuFAjnzxJvb5nl?=
 =?us-ascii?Q?JeFtQS41Ww7ZRTYOoS2gzutzB7WzQwD3ybkIMHfsEQX/ZW7DeBND23Z0bAx0?=
 =?us-ascii?Q?RQGkpB8s9r6TjsD1rxQD5H9Txn/Kc45tj8hC5cB4U3dmhkqYclv6umCQBNdK?=
 =?us-ascii?Q?HfGf2tn089sDSaL+Y71nSRQhokoUm/9aeavfqd/YNvk0JeETfCf/7rQaAJvP?=
 =?us-ascii?Q?+zXGgZdNabZD9I7Sb3X5X+bpDWfVzpXTlYLyE8Oxp6e0j/PeIIWzVP1g1h8x?=
 =?us-ascii?Q?fYYm1n0ZbdzEg3XYSCbAuGzNK89DRU4ocdSGXTrSxowQ5vFpvxrXL2KjiHiB?=
 =?us-ascii?Q?ggCW/Ed6/xWjG0H+XSS/We/cEQrz0+y2L9co+Sx2KMGWJBjz1BJZrt+e+aeO?=
 =?us-ascii?Q?Ruo4wDD+Ov3DfvCl/Z5HsPzhsgpiaTvPjNFsXIU+va3a4iN3APbfQE/D10SS?=
 =?us-ascii?Q?oTcG1Qmj10mNnZ+SeJXXAfGrSvrP2Yr52g+bfbTaiHTuSI6ZGThmIWTs3Wd3?=
 =?us-ascii?Q?L8lBScbpO196sHCm6vDRK8D0o/knm3j8wwNxnnv2dHi57cgZRDF5m4Fm8qf2?=
 =?us-ascii?Q?cMrT4xFslgy26kP4er7ZL8tKb5yw70H32eDSF/pK5pnwhkug3V7JbX5Mxr1y?=
 =?us-ascii?Q?CIGlwVeWqponDxqocSdGfOfQOMlqhVLsF7gRf3HcY0XxAVAiK00bYXXVktnC?=
 =?us-ascii?Q?BqPuLRbn1vCL+fNsy09evFMJZXYQDKiO/dmIv4AcTMi/HW8c0NNpy9XTUT6A?=
 =?us-ascii?Q?vmTeaIj/sxDCQceakTQXXbB1Go+kUFj2ui3pOCWJo4+bQDP2EDpPrSIxajxC?=
 =?us-ascii?Q?YNXgXJUq78ud7JlINdGCc+9wjSRVhtVxXRvaaOd5rv3DK7oJHXK+xcCnylp9?=
 =?us-ascii?Q?okKwonf2zxnu+FdKLE7eYlgy+6VDFGHx0Hg/rgWyWJnPoTfkEBWa2xXs5Miq?=
 =?us-ascii?Q?MjBTkzJONkivk2Ukm+DDVSzSi0dX55ZoCcv2A5etVhhrhh65ToAY2R1RMPwm?=
 =?us-ascii?Q?YkW7fx5A3BOQh+DnUM8x5rKEuj0OOT1+jLrcod0ij0BxEddUedsL0EOBKNzy?=
 =?us-ascii?Q?cS/fLkNulvtMzaG4xsuYH040S4tMNsD2Q4wLGiHZJfs13hdxjUpyHXI5p4RU?=
 =?us-ascii?Q?2zjIIF+YZxoKfeJ/h1XpFs5JkzMycFSaGtlFMC2OQCyhxfQPjqpPbhtXyA9U?=
 =?us-ascii?Q?vrqpqInmDfTDkGGQqq3/11nRx5F0nN7drlsHI3b65crYzFB9BgOJbZwbF2ZX?=
 =?us-ascii?Q?oPQOXRL8Rcf0BJVluwYXnTgSaJQ7riLzLkJiU399BPxAbmsiIpu4jyewl64n?=
 =?us-ascii?Q?6VHKdkaCmjPGAtkasdFp3r9kkBPyRcwtuEga5i/464w9p/x3ybIAkL19Awrw?=
 =?us-ascii?Q?DVSKtcT57NGwJdao4fdE4qUr4RLotW2e1Svz59Dr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21634a86-67f3-42d4-85b6-08dccdc55e3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:11:15.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cus3PdLd+MLXBBLHt1RqcARM+6aOc6pxHDc7ypMoDWmxDT4Y/x6bXoDumsQ1G+vH9j/Y0llpniszFI84DQUv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134

On Tue, Sep 03, 2024 at 03:37:01PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> `amd_pstate_prefcore_ranking` reflects the dynamic rankings of a CPU
> core based on platform conditions.  Explicitly include it in the
> documentation.

Thanks for adding this.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index d5c050ea390dc..210a808b74ec2 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -252,7 +252,8 @@ In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
>  table, so we need to expose it to sysfs. If boost is not active, but
>  still supported, this maximum frequency will be larger than the one in
>  ``cpuinfo``. On systems that support preferred core, the driver will have
> -different values for some cores than others.
> +different values for some cores than others and this will reflect the values
> +advertised by the platform at bootup.
>  This attribute is read-only.
>  
>  ``amd_pstate_lowest_nonlinear_freq``
> @@ -268,6 +269,12 @@ This attribute is read-only.
>  Whether the platform supports the preferred core feature and it has been
>  enabled. This attribute is read-only.
>  
> +``amd_pstate_prefcore_ranking``
> +
> +The performance ranking of the core. This number doesn't have any unit, but
> +larger numbers are preferred at the time of reading. This can change at
> +runtime based on platform conditions. This attribute is read-only.
> +
>  ``energy_performance_available_preferences``
>  
>  A list of all the supported EPP preferences that could be used for
> -- 
> 2.43.0
> 

