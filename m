Return-Path: <linux-acpi+bounces-9660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542A9D2797
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A9D1F2143A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F61CCB41;
	Tue, 19 Nov 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHIFpR9+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2901CC166;
	Tue, 19 Nov 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025092; cv=fail; b=aTMsOtRfyJQSksuaY4yR8hPymnsE8DfR+pR26Rl8AvInls5MOJiB7URETT2avs9v0/e2Ec7YUWzm1IVzxJrulJk0pttiHbTEOeIc1/JENdnnitZreCF1HWgV3rVjWurQN1209WXj75n72WCKJowzKzKCypLIuGprzhPPknpCGDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025092; c=relaxed/simple;
	bh=CrE+A8E53QIPhiE4hVdmxRNMqg6iIhdcBDfDtXTPncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sj3BmLLuOEicV84wCjv29CXWBNAaH/7uK7Z69ERAwLTNBe3NxhFORFvOb+qeyBvgd6aReTcz3OHDYpume8LUWFLStRdVoa0MpA29ul8pGP3CXyklxxDSF6xVVZUkNPJ9Ar07+Tl0+b5RnU9VNVGPa8JWxbAbbyvQUD02PuulJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHIFpR9+; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdDR0XJgNTDoSbQagxptyyyu8PREDcb0s1HKWXK7G2BkvMbTx8f7tnW5nr8YugvvFHXdTjkcoKbRZ4sVo8PNDR9AiuNg/xBVpNAsYfsV/WCWWeeUzPjojqYTb5A5qmkGnQIgSA2YFrOIt3mcr3gjYgpj1YI26QRl5QuopXKkz9wdwGr6sR8uCBXpySQzV15S0+CH29ZJ2Zn34MlfLJJd/hAqjH4Da03UrGkcZi0nA1rI3bE0gGRe8wcyJOIFrn1lFv+VKbGeAWudJz3OdmMAnjV24D85lXAODhwVDWi4XYKjlhFQ6aFwlrqs6tlaUnyLpQI2cn0sZlJTwqDGhUkz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD3ZZuyNwKfDzEHtDGVS1eYfT0KP8gUhILt8GJIGe28=;
 b=sOHwcfXBUuAAWDWUrE3d0dDdqvFe2kB+x4zS8KC0VqJCj4BlxVZnpNiPBHlDrZimt2fJCHE4hpbZa6URa3VtAuEVTZKhEGrzTKLxakfVfrCnbkLWxMQm5MdiITxUmdPjGj2EPeSsAAPj2Xg/ul2rfm1aqM+3mmaBE+DX2pHTwNGCZT3bAArTDYQ9IV67L3kcV7gRryI/2djnH7zEvzhSbRqS5/ON4X5F++JBOsbgQpnrGurNMFIiK/2pi2X02QtKuwxGXpEKfohuG96TU9jaNrACJfgnZ4aQrMgwQ0rR73Y7ySdvWZ7tNNdqHQeaekK4cxv1fa0Kw/jN7zhixk5QKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD3ZZuyNwKfDzEHtDGVS1eYfT0KP8gUhILt8GJIGe28=;
 b=YHIFpR9+A3JEMKPpu1uvfzswhEFowWbi9+wrsHqxmgqFvjHIjFMmgV1fgb96PQ0xjTR5PbIOWz1f9Gax34NfBSi/FG6n0aDIGGHtS/MBrAb7WKtV2Pf7b61UqZ2wttuC1dUn9K3lYtJDSVBLekajpwoAzxsuJo/oUr2wjtji4wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 14:04:48 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 14:04:48 +0000
Date: Tue, 19 Nov 2024 19:34:40 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cpuidle: Do not return from cpuidle_play_dead()
 on callback failures
Message-ID: <Zzya+PIRDlKrd9Ed@BLRRASHENOY1.amd.com>
References: <13636465.uLZWGnKmhe@rjwysocki.net>
 <3318440.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3318440.aeNJFYEL58@rjwysocki.net>
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0480a08c-26df-4427-014d-08dd08a320e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbcH+DZsZsVsYeE5I+HuijbCewtKM0KcKMz3K6x5LaHFJM1bRg05ay02Wzqw?=
 =?us-ascii?Q?l53M0sjjeIAj8DSYnRJiUZntbJ+xwl82lWazKnAFaLa1Cr1xXJHX2mmCq+0+?=
 =?us-ascii?Q?r50m6fePk+tXPb6grGLanK8EUz8+YuIlJoPvpZoiaYKOJKYcyS97QzssLwM3?=
 =?us-ascii?Q?piXOiELCk+TUnlfjaw2wyqRXxd5Bnryz/DU9wBDfZDH3s04t9unrUhvofzaL?=
 =?us-ascii?Q?UV6ETPYw7d1Rub6NP62DuY6WrWTgPiTjEN64X01EOQYr06nAnkCPIUsZBrbV?=
 =?us-ascii?Q?gi+r41ud0cwPLrU94dYcxkGpsIfKMpgeDpvAUDcEEJ74PXSbjJc49U8pdma7?=
 =?us-ascii?Q?PeeM/vnlwFMcI4AFtgq6AmynqQs7V3PdDLzmH3iQgGnmRVQ9Fzw+l/LtDHnl?=
 =?us-ascii?Q?ZV9rO5FD56fFhPJNDbCDepnYXBbnION7hr9nvQgHRoH3j6dqqo7G7xgL/DYp?=
 =?us-ascii?Q?rSS1kYPJc2gwPCzsdq+aE7kuJRY03wxNlt4ZyIFz/PA9nw62BXz62e9MLl03?=
 =?us-ascii?Q?dK8+U8BZlE4pNapBobgcASMNLwLzq+FsPUamnVdzY6sQoDddBGdem9yfGEyb?=
 =?us-ascii?Q?UXRCswYX6LQN2Q9InoXUEivO4peOi2lqbZ33/wI5hBqhCxyKJzRAasx+9cDi?=
 =?us-ascii?Q?Om6MGXB4K8f4RcqhmQYHXZmHg+jVNSLUTDzv4igGmSCr4hId7e2ndXartBNl?=
 =?us-ascii?Q?btVZp4dK736/5vHHbk2+dmTi8tegipuCCOn3oW62q1XWnDEn2V6TWk/g6nhs?=
 =?us-ascii?Q?9j4O5dLmRJTAw3UkQjrCxGgoe9egrsD8g/V0Q18Juq73+WoIGSU63NtmpERK?=
 =?us-ascii?Q?khnZ8w8a03iSTVQS9b0ZMD2plS4mLnmCRrk94dMK+eVlDKY/5Ut0UmzQMipz?=
 =?us-ascii?Q?/kyO0DXcah9/oQftk60u+Q097WZB9A87dD6NyiBag7VLHeU+dMctxs6XdazJ?=
 =?us-ascii?Q?/1uaKKQYNV18VaihTGF8ip4iSE6jbMZFoQSJh+uEngyLHaKLfRQ+BZMhdy0Z?=
 =?us-ascii?Q?Ihh34lG9WPq5BisQBZPp54i6M375BCGAPVrqxcA6y0modRIbnAnOSmzkM+wH?=
 =?us-ascii?Q?GX3kiQEGxIyT9VM99sptXX60F72fQQPCBeoMzdbmKI6Bgp+UoNg8pAjWUUyi?=
 =?us-ascii?Q?J/S4aBSBdQvr4k7RtXYVWbbjvSNgq1wEoLMO8Rtj/3TpaMQEqCERUnZf1kHe?=
 =?us-ascii?Q?8vxXY0uzwAmQRAwCAnsQo+QSvFvlD+E15EenTivQIVQl0UGIJtmuPXB2yiwu?=
 =?us-ascii?Q?CJiINuc+NuYm8BB+stCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Nx2/a3yPlN8o5u475UbuWpF680LvwUNRr+lDd9gqz2cifYe2JzsRpP6YTCW?=
 =?us-ascii?Q?ZStPEfsI23Udyg8+uFCIWLwWefrrmEPf9hiKeQ5I/6D/NkkqW15AVQ7wEem4?=
 =?us-ascii?Q?rPn18kVedV3yB37BCZSffBNjykNqXU+TD3G5smBqrOHky64tWCnbUY8h09QH?=
 =?us-ascii?Q?3yLyNdFYnd4mc6ap0BhopycPcMBHWmYmx93yMqp/PU8t/oetTYJj5WM6ruaU?=
 =?us-ascii?Q?tYiKKbn8Vcdu/t3duN6GlwcQIqUCf1Mi1Eu35u8s3AtH2YP0hk9h5p0+mk8k?=
 =?us-ascii?Q?NwRhgeVRSZcAgg08QT9qQPBYlf2WrtH8RU0u6/1aT/xvP60wGX8wyDJJmXAF?=
 =?us-ascii?Q?a2GTdc13OxXWhYciddrullfcUUhHx0PdMmGzneeS6ByYCPPL0j+6b5LU1LuB?=
 =?us-ascii?Q?exAMz5Bl0YMtDtWFE5iImxf95jejiX/duXIPodhN7Eou1LNjz3JIuZrkNQ5J?=
 =?us-ascii?Q?Q7J3po3ZtjZt9slDSSjuYgBXyvg+wUxsiwOyUCHqZQzeeSHjOhhBxBV1aHhB?=
 =?us-ascii?Q?v/4AVi0NLRhKjNaBfWQodSpwLvjJZz1LqH3AncopCvzk1ZvRF81ywqLhUa+c?=
 =?us-ascii?Q?aKwQGZiJNHV1zuZJo0xz91Dpg9htSJ0yNN/I5T7541pVaVYXdrLxMXkuyeMl?=
 =?us-ascii?Q?UZxvz6euVvljjy2yCRHRG7mxmdM8z+GVhYmmsSzuEcbL4pWn42z/GL6cP8AH?=
 =?us-ascii?Q?bhnqzhGTARQwewrS5AHQdokkS/yPhK/7tFVBptBfntymLHbRGQPj5t3unqWg?=
 =?us-ascii?Q?zr2nmm63ruioi3YafzPd3wCVESGV1AbRrmdmdQFzvOH1TUtzQJsXvlNs+4CU?=
 =?us-ascii?Q?fBzbAR8jaPu04IgweFGTIFe7lyH1iEod35II6RFX1XF12n89j/gKU7p4PI4Q?=
 =?us-ascii?Q?NQt7DesiNKvarH/PqFtlUCmFegcM0gA71xViVutZJrzRsztWpzf4V5H61d5I?=
 =?us-ascii?Q?PEN0PYcuqecHmzhL89QjxvJC1vR+qqL9x8Ll93QiLo5ZUvKjemZE8Wxk0STu?=
 =?us-ascii?Q?UwKPbiElkvvYX8uD3z2JpGrLMVgTL4hvjwca/YKXekte29n0IjeDM2TRBPWN?=
 =?us-ascii?Q?EMI81BuFRbKd/I1syx8YMG4HCYSekPh6J/UnSf9kWFdOZNtKosPW5dU6ndQN?=
 =?us-ascii?Q?f+5N9qGCq7bptfj0f5mJ6l1eN4hn50Ct/qwmE4ZIpPQjzRqjUm9PROLwZnQy?=
 =?us-ascii?Q?bG8Lw1EipphDpaOWip/o3mLSynQkQBdeOT6zn7ZRdW/vTcfYN80NcERQhdOm?=
 =?us-ascii?Q?5+WsYtC4qQbPv0UyKQDqaeuhw5jNkN58JGOqdOcQVQ3YgjmF6ikDg4iD1x39?=
 =?us-ascii?Q?7WTPxqCjhFsFrZsqFUiApZWgOa058X7gCIwDuFSr/r2i/+pvsE+5wzfUUShx?=
 =?us-ascii?Q?bln4Ua6wY43E4uEC3j4m9ywNUrkdDesQI5B9APyXgTSBW1+S9pfFOuyLyMV4?=
 =?us-ascii?Q?zQAb8I8A/NsSFLwYETK2fLfetbUkCMmmba9iWhqE3ekl/YndqmbJYwCNaSJj?=
 =?us-ascii?Q?lJdhAXL1aYgYPcxPRPLzLI3Yp/mFzVCdyRF6r2uwCqTklmK77sMPBjL1xnDv?=
 =?us-ascii?Q?8w6YGlQrUY0pRG7ma5e1ZuBHU6/IfjVUpA5DypXG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0480a08c-26df-4427-014d-08dd08a320e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:04:48.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvV/t+Wxd+6YOMrsHXQSIUe8hxA0CLd6QSWrfncF1ruJLPr6p8Y6ph14ikWpb9pkCJqLuMckeE8d+MDtzug6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

Hello Rafael,

On Fri, Nov 15, 2024 at 09:58:31PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the :enter_dead() idle state callback fails for a certain state,
> there may be still a shallower state for which it will work.
> 
> Because the only caller of cpuidle_play_dead(), native_play_dead(),
> falls back to hlt_play_dead() if it returns an error, it should
> better try all of the idle states for which :enter_dead() is present
> before failing, so change it accordingly.
> 
> Also notice that the :enter_dead() state callback is not expected
> to return on success (the CPU should be "dead" then), so make
> cpuidle_play_dead() ignore its return value.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7

Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
> ---
> 
> v1 -> v2:
>    * Make cpuidle_play_dead() never return 0.
>    * Add tags from Mario (I have added them because the change of the patch
>      should not make a practical difference, but if you want them to be
>      dropped, please let me know).
> 
> ---
>  drivers/cpuidle/cpuidle.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -69,11 +69,15 @@ int cpuidle_play_dead(void)
>  	if (!drv)
>  		return -ENODEV;
>  
> -	/* Find lowest-power state that supports long-term idle */
> -	for (i = drv->state_count - 1; i >= 0; i--)
> +	for (i = drv->state_count - 1; i >= 0; i--) {
>  		if (drv->states[i].enter_dead)
> -			return drv->states[i].enter_dead(dev, i);
> +			drv->states[i].enter_dead(dev, i);
> +	}
>  
> +	/*
> +	 * If :enter_dead() is successful, it will never return, so reaching
> +	 * here means that all of them failed above or were not present.
> +	 */
>  	return -ENODEV;
>  }
>  
> 
> 
> 

