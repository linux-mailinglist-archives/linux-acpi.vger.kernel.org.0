Return-Path: <linux-acpi+bounces-7890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C79614BE
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E40D1C20EF9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB91CC150;
	Tue, 27 Aug 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eybZ86UL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577211C27;
	Tue, 27 Aug 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777847; cv=fail; b=qOs6E8yDqSdWFs5q3QeoChgLcpg6khhO4Ps99WTQ3/YS8cub45r9Vo+GAjJAB3Zn42W/dDVQlqORzH5yBFo5oG62SyD1QRRPDrw5NkEihu9szCysRBBphQ/AosiNw6dnUr4CeEM7cp9GgMKBTg3H0RLw5vYMxariz/9sZRdzi8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777847; c=relaxed/simple;
	bh=TeauqlAP4V2yQlIqSdjLtKfgdvpVCWle1hQVgLO9NSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqYpg/VgxQGltYmhUoqshHl5tKSFZyS7Wv2u452T5w4UVNpdr4TnE0dfgb1YV5TZ+bLbn3j1V0PFglDbKRgo2B7WNiGdEA/GZarxIGGuPAlzvtyg51TNd09kg+LzVNdxHFhKMoK+lGswwaDUQIC38xM6qF0YuxUh+t9QdYt7nW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eybZ86UL; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRAGNiz1fVFLimA8JHGHQ8R511pZRne4m7eIyEEZ+UJ8ImniFDiVOKYiFi0FzYF/XUrv8YkaMf4Os8GKABQJuF4NcBUtAaJvFXoOXmuBYorMyke1oxmTvNfNEtkVJPYCi7zDvL2Zz48FNplcFnD6hvBjeE0PDV0EU31mvJ40r8pdZd5OUKE+qRM/zipCV1Yn8H7DFgulr+Gqefg7hHZxjskXY5evXj1tHUBq2PbFeS4boHYKrpZH/uo1IAQqTSHCzEmu9UAfpESIcy+Tn/KM2W8Wf8EhXWZ/sZf1q4ZOYghjuzATRGThGXCZzgeVLYLBev3Muoqf237w918T4VQA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNqOV6YvHZbXjeISDn1x1Ip9JiKzjo/efumx6AoICf4=;
 b=IkMC9gO0YlQIV3mZjOzQ2Suli7jOQVuulFO42PDTrY3b+l8iBDv2ZS1XPR5uSkcfqfldpEelBKDZGlXr+cHRjxVROUbn07VsDOteMLC93p9AMaZ/VH28iekPw69MAYh74abdT38BPr1akrE6QgtGEn4uq92vpwYEn4w/GgMblxPF7Dcal+8LEK67JZz9B0dIjcQoLoAX4anIX6x2JcxIl4UhTcM8oIBQqr1I+TwctHSmraqzdsnSb+xqMlpX9qHFeJ5WtNoIaBmSebaxmhlQqG7bEhc8E+MMLSp88xq+2aTf/VoX1hvc+rv/LA3pQtusJUGyrNwVoE8/l58P9HLhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNqOV6YvHZbXjeISDn1x1Ip9JiKzjo/efumx6AoICf4=;
 b=eybZ86ULEOdTF5TH0UlGeXBJ/WT5k0pFMHPUp81IICeDwpRVIOWEGX2Mz8EeHp7fRPGcj9wFo9FiEIZlLvF4JGE2CtdlcbdopzFuItWQYgqr/YjEWsTXBDqqRRRRmaay5UutlYWgZfvyh5WJHtfi8I+gXyD+1OmGPKtJ87KZTvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 16:57:23 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 16:57:23 +0000
Date: Tue, 27 Aug 2024 22:27:13 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 7/8] cpufreq: amd-pstate: Optimize
 amd_pstate_update_limits()
Message-ID: <Zs4FaUoKzlKpoCDV@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-8-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-8-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: de6b8f8e-c9b6-4c4d-04cf-08dcc6b9522f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jis6Uoza+eFBWjLcuA9PfO7wOopb2Li2t09tfyizUwvuo8sdUpqd9Tzt66os?=
 =?us-ascii?Q?FFKbAg2vDaN2HgsV0Fxs2VQid0rvnKG2pD2I9xe56n8zz73jzUTyrfqTBrsj?=
 =?us-ascii?Q?6DZAd/dhb0qizZB81E3FnyOVi0xmCmcZbTyE0B6EYyh8agItTv05xXUVgaWP?=
 =?us-ascii?Q?yzfcq2gb+/06uH0Z3hTpO9UtxMAZg29OOIZcHGjJQ16lG+v3no/fvp5dIosl?=
 =?us-ascii?Q?GCNfp7TUb5+kwYxyuNvUgHR9ICzLeadeU9Kr18qBgJ9CblM6j6jndqQ7wGET?=
 =?us-ascii?Q?XR0QPx1Crto3RA4txBCz+3Z0WKkiV2NNsnYNpP8A2zMmlixxdPG4LybPsGPy?=
 =?us-ascii?Q?NS9mP7kKB4oF1xBz3VnMTRZIvkiUsXh7gv8lndcsk52zaVKCK11pBYQWMxyD?=
 =?us-ascii?Q?RsqCUVMHSiAL3lxhsjDtx2hVKparzRPHhA2a/ac9O2PG+m49qxr3j+qoLCYi?=
 =?us-ascii?Q?g58pKofYajLwC9Wwv30GYuh2Vp4Rbft+bv2ZDlSIzfdMtBBESUfipGGoSKOL?=
 =?us-ascii?Q?IkPetU3nZ5qzXEHaQGOIQB653IKHRTrsLbuk2yD4Mv1XKACdZyfhbkb0lgPF?=
 =?us-ascii?Q?1d5pT4TCHoPws6yAwMPw70tjkNne4mEbJc9n72piD58iVlz4Y+xamIW72ex5?=
 =?us-ascii?Q?IVlGDfmfgLgbaCYRH/EmUy+FwnV1GAPgLFH6gdgO2zX6l0x8RC/iv1DTU0H3?=
 =?us-ascii?Q?sN8eprz1wACQdJBup1ul76NR3ISVWU6tJnfx7WwPS8oMI5ct7qsjHG87O6qI?=
 =?us-ascii?Q?ttxK7iD17wJfkRn1d3FHOgbDvWM0trX8PvlbMmepKfmpkM5GHYZoeLOebs6e?=
 =?us-ascii?Q?p/PWhdUOsSwHRw813MyeTrHLcTdkHz1WqCKh5CFD273D3lr+tOKcWkfilvU2?=
 =?us-ascii?Q?KrA2HxyUZpxswvr/dqOH/J87uVeCutkaNYNbfoBzvtJ/PcTRzST+n8Y2hUnn?=
 =?us-ascii?Q?fKWWh29OeLMV6hC2W3tzNofL5zoZ2dQ41SnsLOG5rVSnuuScyRSgZg6fpry8?=
 =?us-ascii?Q?WQAABHzBvpp8WUcoeKZaZvUnshwXxNFrroW1gcRVy6yhEzveV4a3tIvbetOB?=
 =?us-ascii?Q?hIHcINMmv7i38GfJGlEX6cKYPPDQ/NstUWI03NrOjAE3z1wQ2EzEOKYBfT5c?=
 =?us-ascii?Q?AaZu4/fB0DriDU0AOnLtkpgAZYnnZFsuAUL9uY0RaT3yD0oUvZLWTOCM0Bz3?=
 =?us-ascii?Q?BWqAXeCua7w9X8R55opS3kbauFI6rPdq4KbG/6nu/vt/9ssTYdiA/Zw125OP?=
 =?us-ascii?Q?exp/4uug3Ec85UzS11tS63IuR+6LHQBi/N0ELgVJk9IF8vk3evjf7cgCME2o?=
 =?us-ascii?Q?MsJatuIwjX6EVpcHF2UhRSSBBHQJf7Ulo134IHeeKnl3FA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nV+9Cypsp6tzEKZSedpwzUpVuB++LwQ1dG5FfNuBOUa9b5o5UxRuQbhJZMpU?=
 =?us-ascii?Q?7k4ESW92X7DyzIG5ku8fC/iIeqjnr/FmYuOFxVEluJoJlckXeWWEghlh2mss?=
 =?us-ascii?Q?CPguKMF244MvUBF/J42+BMMg3TsJu6rvr3TwAkisEXliVrWKfNuSSqM2bXCa?=
 =?us-ascii?Q?Qmeqw6INaLTDhxjBXy6SHOJXO9V0oBig7OxAevdGdZjr7qJZP30hNOF6JIBL?=
 =?us-ascii?Q?4eku+7+qxXs56ie2IxEbvNJwKU9byZIpjf2WRwDyhPkHMZ3bsHSuEfNAGQLG?=
 =?us-ascii?Q?6jrZQmT2DxxiRAN0W7TCxJ+RiuCH5VIFkiMEHpM6yzA+qLV7C2ONuSSj3lsT?=
 =?us-ascii?Q?XCUdHVQ37QGUOaSVa7VaJHxWDVHcG3Ts9i/bbXIRTJxdwOeDcJw2J+5nLl/g?=
 =?us-ascii?Q?7Wf4E9zfXViicRZvddflNp40mUEdEMKJKUjS7w+kFXEG/dR/sLd0rcKl3yVY?=
 =?us-ascii?Q?wTDVHFjO53gaJOSXPF3DmWlH7JW7ofrtO5UahxZ71Ed3HdVMiw40VGJ75rn0?=
 =?us-ascii?Q?NsQuMsqmFr308tMtz7fzpEhEtgziDRg/UjO9s5nEph4TCrzFjO40hPAGW0zb?=
 =?us-ascii?Q?XYtHU/elFCbk7lPhGVswYwd43GVGs7PvowP8amAntpS/77ojEPWrOQZsZ1lw?=
 =?us-ascii?Q?qQthGmDcF3wrRwEeH+oBevBAHZyz+Qe9w7TZWQYPcsyheipCuwdlLXFlYF/X?=
 =?us-ascii?Q?uQnJzNnUiTbDBdIDpyJDQLKtlQSFTeFgtdsj+nIaXsvDyNUziDrQYdMLhl83?=
 =?us-ascii?Q?dyAm0fUYyTaGDiHbgQeDCBgyihgkn04Gqwy28KbdiKWSeSg4lA1+wD0b2SAg?=
 =?us-ascii?Q?IwOj6FBsUsoaTq/E0ow4vHbLXNZyQG3ytwL384McEPVSMjGfpt40sgm3/lvm?=
 =?us-ascii?Q?ymp251EfuYFTM7UkzCENnc/GGkqlwBq1MzdPf2ZlcUp5glrfi5KkCXEl5bHD?=
 =?us-ascii?Q?DG6KOnvmBmHn3DX6GAxFPp3yF/s4PNPsbki8U2qDm3Q2Snay8tofVk1kKjgf?=
 =?us-ascii?Q?OjeVMnHU7WLj3RTedE+vZ+yXntctc8qnZjTdEtK5vnZ7v6rPUsHAm9r5E6Vo?=
 =?us-ascii?Q?GqEzh169HboDGNK4Gbiv7r8irHgXKsqgrwCr1PnT0rzF/3vO+Ezm7Wn9mMl1?=
 =?us-ascii?Q?oJoZHMRpoLkKZUcytQtd9r7n2PUbYj6cY50V6PCYqOdNCbBzp1QCTwQDJ8UU?=
 =?us-ascii?Q?fVI0zO2z0JQlOqKFFs/H7yfmb35sb+1K+irE+37PhaZWz6wnDH8iEd1gG/DD?=
 =?us-ascii?Q?2/wAbyoNIr32n91zQP9TPYnQLoCdz8Hkt7VhTMmb0u77a4qIcKRbUXazhw9r?=
 =?us-ascii?Q?5A3hhR07EZ2rJw2P0vsxsIjnNSUTs53tFRGERqZWMplQDv9KAXFAFizhGJuj?=
 =?us-ascii?Q?yx2MKSbnq2Hy3CVSFMejiEAYE1tYSDwpIz488zwAhC8EiowDy0j68Zn9G3FX?=
 =?us-ascii?Q?FL+AUJqrMl4ZLeioggOXH0pOdab88rj8Ingb0qQlGOt9ZroP78147SAJvf6X?=
 =?us-ascii?Q?ZQZkfKJrHfIPeBvWdmszR6cVG0adYK3exSmTAgHDrII/UHL98TphkensaIr8?=
 =?us-ascii?Q?DD21oj0UkATdNaDKeX68qMRQLEntKhgWhQuGDk9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6b8f8e-c9b6-4c4d-04cf-08dcc6b9522f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:57:23.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk4fK9v1twGPdNBHTaRFE0WW+NxIczjWs/S4J+gfwOpUResCrdN8FkK3T7gxtrl4IO5C8j4PMWpul3Phg2OjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

On Mon, Aug 26, 2024 at 04:13:57PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Don't take and release the mutex when prefcore isn't present and
> avoid initialization of variables that will be initially set
> in the function.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 75568d0f84623..ed05d7a0add10 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -798,17 +798,17 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	int ret;
>  	bool highest_perf_changed = false;
>  
> -	mutex_lock(&amd_pstate_driver_lock);
> -	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
> -		goto free_cpufreq_put;
> +	if (!amd_pstate_prefcore)
> +		return;

Looks good to me.

Wondering if it is worth maintaining a static key for
amd_pstate_prefcore. Anyway it doesn't change after boot.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


--
Thanks and Regards
gautham.

