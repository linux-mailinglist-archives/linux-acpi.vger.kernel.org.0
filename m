Return-Path: <linux-acpi+bounces-8172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE396DF03
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C420285662
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A219DF82;
	Thu,  5 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbnBNt11"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295017C9B;
	Thu,  5 Sep 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551981; cv=fail; b=fsygM3kJlbtZ2IfCFJXH9/AnYWz6vCzWvUCLFKUuDm6dt60Xeup9lLSKOJiAgUMjwhYbeonAtKePlZO7LG8vIt3B1L1qeu3Pb1d5ACWXjzr37MjNZb/gw65Zs7b1Lpse80lUN1CNgtoxuY6BwMzQp9koIIK7iTL9PYGjPUeMAhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551981; c=relaxed/simple;
	bh=1VJJ+5Cz3Ask4DH1lHnOfaj0zpUamS9ehGXCSICjW3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZzGIsjeOhr+THfHsFgaPBJqeI7ZM4qsi5EcIw2lTASA+3U+1ztpuTIU3hATYFzT/kAbw7njyqHEUgsf21VTGPNYcwx35ER//eVOdyR7fRLtKo/ajjpKapdl4Mm8eA9mcGe2xB43ro5Bo++WsbZD28K3Lm4zNIbJKwfh64/DEYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbnBNt11; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv/rLOkwvnLW/Fam7kGcpb6fbIklG6qY//lE3ADTuDyAzeq3DaP3SkX8WIoW5ONpkMvAldbHRgNlcnrXEEo9OXPtXrr2J6J4yr93WXcfKIyhV877pIyRUr3t3pXLFknIMQh8X+PvQcowhFZp96LZj+Hxp6FNauCKAAozfRhe9zvl67b7U7+oT6fa9mAvPJxrqxrGRFCWX6hl2l2OpwYpNQtz3mxPPfgI/bMjzVcGEq9qC919EvDIjd+y9PL4Zi01ikiivBjKFn5ROfz9jGKAHuDQy9/mVkcnVMf2djjRCWuAUwZXWmcIZGVhYSyjx0O2L1Gt9eRWahEoofb/bFoTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10K55bYSV2vGKXdhp0mwQCZVhYzmibmz9biJnyEbYNQ=;
 b=YUvEhdB/+/9jnsv52WKQCdiLSame0+7AbbiOvVjpMz7mbOGxiqaN0o5d3dkQpTVghCqzZr7NtSznhe6ZXaZ87TOAmaopMnSDhJ82fDeRW1guHgrBKy2wcXsEtV1VA/Y4rG7KyBp5odLQ4BxJs/9G+FSHrlBeDXPHR3UAZS4t9q/q6Y/xFV9gW6OFtG60MSqajSA8rKKKHYZrJPzGaEDqZ/z+91RYesQtvGmcCRHo+4vP4N+CmiMy/pIPZWdVZKttngNPdQL4Mxv7RkKHmyQIo6g54WAZJylQEwYMJoEEShMowAuIhltsKgN+S/FkIAI0lVNlzYjKM/PXIiMpUq9S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10K55bYSV2vGKXdhp0mwQCZVhYzmibmz9biJnyEbYNQ=;
 b=HbnBNt11Ds7unK1wCXeAyZJeRffE3pIcIiKobr38i8oLximE0Xq/Wl7VCLNfjxW2d7CWgL6XLU0VvQUAsdhKSGbSAiGX3ayC7wCTM5wZAlr9BLR+87Ue7tOrQ7ZmNCFeH6o3wUYDqdN/eypztXdp1TD0M66Jgn2sx4VjBkIDKdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 15:59:35 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:59:34 +0000
Date: Thu, 5 Sep 2024 21:29:22 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 08/11] cpufreq: amd-pstate: Merge
 amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Message-ID: <ZtnVWrGdyotGDA7J@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-9-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-9-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: a87c94f5-79bc-49c6-2e1c-08dccdc3bc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUR41no8BDtJ8DAlDqaeZep1tA5JAoPmhwG3pU+rEkVnidSz6o497E7n0pmB?=
 =?us-ascii?Q?ifiwsetiir2gTpIKcDmTPoT9iZJszlrvKKAb164e0IQvOdMBrIpKxLrwf9xq?=
 =?us-ascii?Q?32yI9Y3lemWQIwoMseuzB4GxPSbCWmGu10Y54td1vxGMpS57O4oLrhZ3TfMD?=
 =?us-ascii?Q?0Xed5wrIvWOj4YENWhZU5HVkeF5aG79Tj0+/CopsNGMdeOHEmF9chJfGIatl?=
 =?us-ascii?Q?AvKY8S+WOQJ+xFNmlyX5JQDupm0bnn+bROr++lmVyfALw42ayLCzvIejQD5m?=
 =?us-ascii?Q?bIsWvkZZuS61kAt2uZkvhnSpv7JMQmFmTDot7A8yFjgRyDiAFhqXPYoThQ15?=
 =?us-ascii?Q?7I+bEECW3XNqPoECwUHFd1A8/WYM2YKo9xg9CUlL8bbqupHjnznBgA0jYbpe?=
 =?us-ascii?Q?xW9nGHOUv56O8HyAcT2R/zn+gSZQYM/WbVJ279+F6miClmjBeCHkMEf1H0Zs?=
 =?us-ascii?Q?1M9yqqqpKa/mQ51cnXMCc/9EuUclw80zlm3nF47q/pTFpfMwJNPFXiScbU3r?=
 =?us-ascii?Q?MUWZbzFAlk0YsmSF0obHV+SgJVTopNsSD9H1CpPcvJrhzJ0NQbPlD/DrNl10?=
 =?us-ascii?Q?9NBLiGL0Onnz2N3/6M6vogLx458eASPKGBme1+ioFTled3hYUksF+bN4fHmc?=
 =?us-ascii?Q?QFjO8n/K05DZgd5aAc46spOgBwGpOx3yhMlcEfC1hZgp9dy9XDvSaequ2bpX?=
 =?us-ascii?Q?FRI4qu3P/DcKryp6CapakRiGgVD1g/LE84SdwoU2uo1Zaw4uNJvp1Op8yBSr?=
 =?us-ascii?Q?/ywi1Geo9lPXGwgNB7ZY8EkOITpB+FKU9pHOzIUx5s25AIzasaapz7SmAB7/?=
 =?us-ascii?Q?7p3AWfAIJSs4TJLVgBv3fD0qQJgK5fa87SkklMlb2iy/gqn9s738YSiMGUM4?=
 =?us-ascii?Q?YqlmI7aXpuouNE9abvL6Oc2WVXPBEmviYtS75Ubq0e8dJNQT/gtnC8Aa2d/k?=
 =?us-ascii?Q?wlK3laNgxxnnfMdP6JHJzCndloKTNDO0htypNKjxHoi0YLP3tR71HiHUNevh?=
 =?us-ascii?Q?GnZ3qAnKv7jX4DJoQ0dZSx9BNyy9IoQsZSZUEjeyTeUSzZgLOvV2ODglAFcp?=
 =?us-ascii?Q?wzK7cRM1nJLmr/kRoe5XOvtetBwe+ulGZQuKEeHGw//bLS8JivNsk2c2XzPd?=
 =?us-ascii?Q?4hwNC5kp2MPw1iuoU/kjqRL3R1cLmzeU2bRCOtoWSTex9cVZfzLz2Mgg137a?=
 =?us-ascii?Q?dJFXUCEU1H/4gvs1d1PwcLertTEFE9ItsFUGDiGD0padTshjIeQjlOaqXWxl?=
 =?us-ascii?Q?Kh7ZObvJOnzu0kSBVaIE+hH41wBAszokmgm2BTfJLTRM5sODcEkPY3kFW4sW?=
 =?us-ascii?Q?FZHST2eWSj2qUAAGDwE7LVLXfIjoPDU5S2OufLCiIyLBSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pqq2b8W61uo3XWrcXMH9t6XBib1t3iogDix/DyHrptyoyD4IHroSqt5rzGfD?=
 =?us-ascii?Q?mbEIUwxxX+8DvQMkZxGgIEwRzhk8ShTLg1AHM+4689Sz9vbyeGJaocjatDKu?=
 =?us-ascii?Q?J2oXFWI+5c1MyC8h8FFdoRkOlPVDgIId7V7k2WkPKqOX+ZPOrgLBPrXmB6VQ?=
 =?us-ascii?Q?HL4JfvimSk1pIAEi1yXCyi3NyzvN8DZQ4dXwyrzaruLxVRFHOTWBzY9rIiMH?=
 =?us-ascii?Q?PGXVXm8tKS/qak9U1j4XFpLoXlaeCDhYOtUSbyf68IQ15nd1jImvrIal8dQG?=
 =?us-ascii?Q?Goe0w1XrYYiQxMDBfwr1XtJgIFNYfdGQW/xpeLekVcDRO2G4GBBSVyKOAO+P?=
 =?us-ascii?Q?xJ9EGyaFJTyOMOhT3IcynVTjL176SoPwb4w25nmynkvWISw3T0Q0U9BI5fzb?=
 =?us-ascii?Q?fnFQ004tbJvTdVF+QmTaYfFjXVPROkf7+dKegT34XMATzQtd2A3svaUzO5+W?=
 =?us-ascii?Q?OE+gbf8d15VDWHD95jRbiaI6Fu8lmqZF6Vr/1eA36UkrmIgbu3C/oGzRU6bC?=
 =?us-ascii?Q?s0OUujOGZU9xScpIly4OpJvKHErH60qafkcmKjiXNvGiHo78gdxKdBOkUnQr?=
 =?us-ascii?Q?MXs5nyz164D1DBn6gG/5Ko58iSBZtEo1cE1iIPpDM9C+jMCGuAZk24iwPB7h?=
 =?us-ascii?Q?3FOxbnJYBplkHulbAA+gyuxJzqtZMQ1l9PY1rEqPSYFMP7cdD8GAPEe1lFNx?=
 =?us-ascii?Q?CTAFqfYF0uBZcc6bymNgA8kyQ8SHLQeEbROODT7mTeob3ErZuEL/IkviM5VV?=
 =?us-ascii?Q?2B8L1toD75Nbhb3cbETt4BjYoqm948k2cJOXSqXG+dLv048fBqCDniwcOfMY?=
 =?us-ascii?Q?aK5NpE6dunbbLk2YuxoVmrH2tlgSluXAuSYloN+hEFV4OVrkVyiGyOOcnwGi?=
 =?us-ascii?Q?TYnQ0sDxrghSFIpyECoHN2QE0uTXihUTYqBeRejnpws3t5aMo+GkwGy3REJZ?=
 =?us-ascii?Q?AdOTjSeBKQc/5LhFY3HRmQboVHwwijWeCA0N3qCWa4F8nu9O3bBMEZT9xvkK?=
 =?us-ascii?Q?7kxheGGHcMFoC/laWCi+aZsQX9DdV9EgqfZo1ti4RVMCY06APi8eLv8tzprg?=
 =?us-ascii?Q?LheTbKHfiJJc7BvXdij4WjR68pUYJ2pwV/C23/SKQ86dxFesCO0OEfBn8kOA?=
 =?us-ascii?Q?5Z/XHsIMDwhvjXITE69bCC4vDG3eT3yh96xmpHGoW8ee1ZMUCe9jQKS0AIr7?=
 =?us-ascii?Q?pkT57bIF/2emDjeFbhSdAA2E1dlKXiQPVmGoG8M5WuvIe6rUTEiHIcZOzsuF?=
 =?us-ascii?Q?IOooeWaWyg/VLfHiF/cVaxbGY7PNumgF3hIxQ5uqUfwrBuTv/biTZKgsL0ql?=
 =?us-ascii?Q?EXb7Cf3tWWgO9MglvO68KAMbLJRvWaWm1YC6f2F6AnEzkw0ioZwbgOzHkahC?=
 =?us-ascii?Q?na5IhtAyL8lhq409YaThqlLAr/iYgrVlod3JrKak7SzoD/P5TbaoGmTakNNe?=
 =?us-ascii?Q?dRg53RzS+n4reLPulO8PLfIPJaFBrg+qq+E02lKC2ouE6QQSz6I1KC4GAaA9?=
 =?us-ascii?Q?ng5d4xlh+g1pss2lLCH+X8iuks1liHx2Wx8CSm8KFerptFC+mg2wozNuJBR1?=
 =?us-ascii?Q?d7aN4jjWqV5aFz49M6m0oBtc4i71fRszG9IQosPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87c94f5-79bc-49c6-2e1c-08dccdc3bc7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:59:34.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie/ld5OtX1Ih1ezaNbwkz7y2ZkK+idWwxn6HLUSa9M2cBQJvCvEVu7bWFo9AyknbzsNm3yulwFO4pjvVgnOyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On Tue, Sep 03, 2024 at 03:36:58PM -0500, Mario Limonciello wrote:
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
> v1->v2:
>  * Document that preferred cores will have different values for highest
>    perf.
>  * Fix an uninitialized variable caused by merge
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  3 +-
>  arch/x86/kernel/acpi/cppc.c                 | 16 +++++++
>  drivers/cpufreq/amd-pstate.c                | 52 ++++-----------------
>  3 files changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index d0324d44f5482..e13915c540648 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -251,7 +251,8 @@ performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
>  In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
>  table, so we need to expose it to sysfs. If boost is not active, but
>  still supported, this maximum frequency will be larger than the one in
> -``cpuinfo``.
> +``cpuinfo``. On systems that support preferred core, the driver will have
> +different values for some cores than others.

Thanks for documenting this.

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


--
Thanks and Regards
gautham.

>  This attribute is read-only.
>  
>  ``amd_pstate_lowest_nonlinear_freq``
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index df367bc359308..956984054bf30 100644
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
> @@ -245,6 +246,21 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
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
> index c29cdf2d3882c..3ae41af6f041e 100644
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
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> @@ -420,19 +392,13 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> +	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
> +	WRITE_ONCE(cpudata->max_limit_perf, cppc_perf.highest_perf);
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
> @@ -905,8 +871,8 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
> -	u32 min_freq;
> -	u32 highest_perf, max_freq;
> +	u32 min_freq, max_freq;
> +	u64 numerator;
>  	u32 nominal_perf, nominal_freq;
>  	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>  	u32 boost_ratio, lowest_nonlinear_ratio;
> @@ -928,8 +894,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> +	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> +	if (ret)
> +		return ret;
> +	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
>  	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
>  
>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> -- 
> 2.43.0
> 

