Return-Path: <linux-acpi+bounces-7927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26553962AEB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B8BB2169B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1718DF8A;
	Wed, 28 Aug 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nh2vnKTH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04352868B;
	Wed, 28 Aug 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857081; cv=fail; b=Ksm6clBGD+wkWOlYKtML7sso8UjTD/Z1Ov2GaBHKmMbunRG3k1dCiCObfgwCc9bDLmGfYhKpWGQOj3Jo8C21dWE577mPOACP+d9Tahr1Gro5/kPSOYP7mG/drRyLNaM+A037nA4Cdm0BiSNK91SuElDMtJXHsjf4bAUzO0c3YVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857081; c=relaxed/simple;
	bh=NV/Bcr/Rq3XerId6L3q0NeMOa7qOMwIJvI1R4CtpSvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYCXR/u4YgR6oNVIe79MnBodIGg1IUYFdXsWQLKJZ96WGSbubakxlKudA8FD08UBk9JfKS9XwvKg1DNk9zRQt20YVelCd9KMofLrRX1mNL/b8Pn4GiL1lXlDFJcUpO2oRW24fuL+Nb78ZT3BuuIZj13QxPe1rK4j6c/s02Peuis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nh2vnKTH; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS5ZkCyICV2KgC+xiHqmRC+X9+1MC8/LslJjnm+EBWuhGc2uBEgvXOyzH8vow7kD1GUbktuQ82OgY6wSDOzTjvzsjhUUKkHwvrb35sC1ea5lkQWRlJBpM6byWVtpAjOC/26i+XVG/cJ2w46qYLH35+Espw1xomLjpNUQ3IReVOLogtUOvm9BExX3TzA70gOY7pnfM44TPZjk8HftZuwy48mNTX6EOgxKm6+X2cRMFnqVZcAozsILAQWRt75sUC0dtjBX5FFtQITdZX+GoDfffpUW+WMMlGgc8TTHbFYaNVahGxNH6qKDuv/bncHRpP4ABDI5/j7ebBf833tRpYU4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzSGQBG9E/canutsc6ozDYDgw1eV8Fw70IEU9fZ+w2Q=;
 b=RK+VegrzWpyZBxcKR/d/tIgIrRONHRNfYIpR5xgnDHLDq14m2rWW3DTvYl/T1NFJBMtUHQnCr8ngU58PyMe8wyOoLCstb9e2Sjlo7oDDMkkcXrH/4Owo/zpPNw9/WhOSNl7h1fM3P95vPRex4sFWpcLoA3Otu8xNwLJxIyMJL3oKizMS28zqyA6MbwgaVftlV0e4/g7ojAiWc4aPIwFyRXlBsmQCZBjKRpfYFLrf6f16rzO6RU2qz4Amwx8liqd+LIqR/X7NbwUyeNSaXBbrbH0IoAfJoY+R5WL8pGpctgyRbpH8l1q4eO4dLFD9ZzcrW5X/ER9HcXhJNUIYFankUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzSGQBG9E/canutsc6ozDYDgw1eV8Fw70IEU9fZ+w2Q=;
 b=Nh2vnKTHi5PZSLMduaJcs2aUE1cWwPdbT1xZRl3V2yFrnNScfuV1Pe6YnW59P6feCKvuRK6xv0O+1U41fyBIc2bFEmjEUgIIxdekGuu1qmpno1OqX1tLN71TOgqzD1zByE0awwo2wzTv1s8sQMxrrcZ/CCoD5vJZzgr/h/834NU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 14:57:56 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 14:57:56 +0000
Date: Wed, 28 Aug 2024 20:27:44 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	changwoo@igalia.com, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Message-ID: <Zs866Myvbs0ByoAK@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
 <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
 <Zs7Bwh6T3HCGlR9C@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7Bwh6T3HCGlR9C@gpd3>
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: c80d3466-4ad5-4f29-e433-08dcc771ccf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVoPo6L4LESt2a8AQMT7MjfZSfxdiy0uCKB1df7tjvO9ROAdSdTxyfpNQrLJ?=
 =?us-ascii?Q?ZVtrXytdAtU2ZXlLZkfLtXTjeakAP+UDsndMRaVZLaq5Np7PAU1BPq6lm9zS?=
 =?us-ascii?Q?mBnjpsqDZbjAKz8hiPVHQBIl9suNq/Wc3xZuu/aEw7rsws2wHJp0gjzvuPqT?=
 =?us-ascii?Q?xRfRxUdhgNM7JX3QpSl3/isoTmcMqMl+lEsym4vHiDxq6m77fi93kwlbZlFJ?=
 =?us-ascii?Q?rA6hdERG58uf3ZpmuDwKY+AXc1nBagOTMI5ArjqN2wGU1NU/eVbndNuTYzq6?=
 =?us-ascii?Q?RKYyoe32o3Yocc8WhGvQNPrLWqcEyQQ1bgDEUoTUSR/S8hXa1LyBnxs1Tcus?=
 =?us-ascii?Q?bwdR9DAwGFtOX95ETEu4VVJiOSUhTGDAoQwNAljkTAxDxOYVeeSdH2gkxazz?=
 =?us-ascii?Q?9SiHAYHecA8AAeC3Y7cauMBmFKi18N8kTuV/g52NpSN/fBSA7ItB1SEaeVgt?=
 =?us-ascii?Q?8n2vt9lda+RkayMa1bPrTN0dbkinVnSyu7k51FaPZO977J0ppir2sngytI1t?=
 =?us-ascii?Q?szshX4lZnujhvxZYZuqnXTx/kzOPebsaqrpV6aBKaSFXp26ID8Yq3j17gCre?=
 =?us-ascii?Q?kO1LyixmEnDCZlKV9oY7g0hEvgpOaMs9OUZGL2d7l3MYxrxC7JfbpO6iAOhb?=
 =?us-ascii?Q?MRMzWbXEij2gN8y8tMv4wxJw6ZsHsLjotFTpb4V6Xqjl2Vb01Ozs2f+/p61z?=
 =?us-ascii?Q?QwxYlL1mQ8gHIKDwxQlSesoVh0n9j4SE5ELL0HmlR3zJvmIvLTVyfUfSGODW?=
 =?us-ascii?Q?QLBxkoJGGmIz1/fsbixH5qS9d173nPQipdJRyhqS2tKUPF1u5MdBguOH8JmE?=
 =?us-ascii?Q?UCY7iSk6XAdCQdj8QLf8N0Q7SmXxT7AkHVKdyu/MrxMw7lintztmRFegim+T?=
 =?us-ascii?Q?SJjzGI8tk2IcyH5Eu7/q7APwnPaykVz4FPWmr3qZj4iXtuz0/pOrPuEIo33e?=
 =?us-ascii?Q?7SVr3KYCwl4LbMg2c5AY8jap/fBkwrejmnxmwwHmzLXtxj3B/q5DsKrUjecZ?=
 =?us-ascii?Q?iyaLM9nQVOev8GFg5ODO5E0EgfGO06JmzItDoTDte1r725x6vtdE86azyZcE?=
 =?us-ascii?Q?sQOOvZ9ZBa99dW2bIOzJ12w0GRSSWxxdfZFb8levXPrrYh7VzyPCWrGbIXsq?=
 =?us-ascii?Q?XS3Gxs3fdiKwQzYAl3mAZZscpnbltYpykAeLArLzjU5VB0eBzQcQJ3I1l5bH?=
 =?us-ascii?Q?uZuCVun+5YlNkDGrB9gsSaYTHQdnRsMFko3S4jIOA9ArSNj689tX0oUCQHXs?=
 =?us-ascii?Q?NshnI5/wcJmYdNCztIpLfR7+zDsNDUnLnGlOWlYPHVoUMzMXhZSGlFMPANIy?=
 =?us-ascii?Q?NTh61wzsj0obyMLEs0kZfwCjZboNIdLctJLfvYf7FspVNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9KKnYnoMXg+x2wTs3fk8wyIs4o9Vbyrm3l+RC0a/K66YcXHPSaiXtzj/aut?=
 =?us-ascii?Q?I9j2qd7ZDL/h0ndkXWMPvaPQ1z0+WGYQoKUUo03U099jolsSpUq/FkWlqP1C?=
 =?us-ascii?Q?su8Hb1bzlSFGYt2WqgCYALrLggjKwe7tW2QtXGiPJ2Qo6eonFZrs1HuehvYD?=
 =?us-ascii?Q?zk+abQqwIF/ZtPqZKELU0Ur7nlQUxmpZ7IJWVyydLfyGcM4eYTb4uPeq8dTK?=
 =?us-ascii?Q?BpO5jMnx184vZN0rGWFp2Swo7uI4PCGEKCSTyW2hwZNKbHlqKQlr66fwzIj0?=
 =?us-ascii?Q?am1xnm+uC3R1m56UxCXN7dolLgWzLG2jeRkjQDc7sE+9MXd+NF1WiLc4ZZv+?=
 =?us-ascii?Q?TkhkFtwOJHqF2Bd9cs4QoMzMbus3zS3WVu1Zblw9ZZXa32yB7rreEYO5ORUO?=
 =?us-ascii?Q?c89erBt5ptb64yltLyhFJwVY8Uj/i+DxIBdyk487sXxU2IJyTSYkft+zfydp?=
 =?us-ascii?Q?wYKMMLU2Qi3Ao2AxoctRe8BvSkQg7ri9+ejzTCVAZIokRobEMqGVJ5BIXLS6?=
 =?us-ascii?Q?WYVRmA9L7D7rCIGJbq1Qj5szVAVv8qwzfJfxtU/fVY3dRVn5LIX0m8odohAH?=
 =?us-ascii?Q?MUBjq7buzQpD1Luc89q/jyEBzRQ+h0tNWjZnk0R6xhIhsGPkG520CvVxFVJI?=
 =?us-ascii?Q?McXQNKzKob21TchTl5gW8LE1jjTc5IYaV6q5j5kJBRYyW/Pv2wRvqwiDd0PB?=
 =?us-ascii?Q?0ovDQcB7VSSg6ZnUNXaoV2spRBgWKBamvNIdvyGrdjMtC55zWTONXrB70uSE?=
 =?us-ascii?Q?bhHQCILy8b+HZB0vfb15sYbkhUC+217UJkZOd0jk5gL+AgMLFalLK8FsN5eE?=
 =?us-ascii?Q?yzJUffisKprf2k1iyh1k9to5VrhsGPW88To5MUjZK/nd80yhqW3FuQE6+k8c?=
 =?us-ascii?Q?eK3B6LrFiHRQKXYb6iU4tx5dtje9cxsDLJP4l3WQJANDW0YLsQs8ncHv1AW1?=
 =?us-ascii?Q?cOXtax5Z3kYZ7MT7n3AEddt0beyC3akZ0DZqnM5Ni4AVHOqBxjzJpafXTXew?=
 =?us-ascii?Q?Kmsfj+BGBNKYRPn7z1bhqfSBQ+EXSsFOBFmmUNVgPBzic+wmj+bwNJW19TS6?=
 =?us-ascii?Q?Wp6JsUX9WwZlxCoEZEn2SKMisdBudXCToWKKUls0kUIDi2XKLqLS450jr5iJ?=
 =?us-ascii?Q?Fgbhw0VWHSZau570fW9y9ZY82kumP9iKMKIabtNBuZ/YeCNTDzQ4ftroeJXD?=
 =?us-ascii?Q?VhM4SWus4ZfAL56ZzgKqx5Q0uepHbGWSbpBIZkfaBloF+nQpnUhhJHGwTppc?=
 =?us-ascii?Q?FnggNCw/J5sTWMCZBQnd0DZncPwnyoNYx56PiXO8f6o5BwqA42ZOK+aldJB8?=
 =?us-ascii?Q?ow+TPrqpzK6kX9W/ChcXigKWOfycKCk6+td5/ETC/J2//WfUoiPwaXjsHFH+?=
 =?us-ascii?Q?fEq8+BnmGBXI5ZXGDrF5uogQb6x4yspESh4NWjhkdVaZgLYIYgE6iAq46OoV?=
 =?us-ascii?Q?5PIQh/xqfuoZDbM41+CXXtkCkS9QmnWue0BPfJDMD5nPg43VVV5Xu3kDhZLN?=
 =?us-ascii?Q?cJWyseZjkg3a9tPauFR9kdz7YqwnJDMrH/2/zvytHaqYeruZpXkhFzqU/lsd?=
 =?us-ascii?Q?MaXSSArySaRd81lw7oWoAJK3qBWEaYVuSIGUDQVB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80d3466-4ad5-4f29-e433-08dcc771ccf2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 14:57:56.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9kIoE3fyy4Mb/BWq9k36FT/ejGfQQG+nKdlhKpoQrHKmXZL0KDF3JEYZ/D+DrST0tTANxDF/jtNsKX9Rttaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Hello Andrea,

On Wed, Aug 28, 2024 at 08:20:50AM +0200, Andrea Righi wrote:
> On Wed, Aug 28, 2024 at 10:38:45AM +0530, Gautham R. Shenoy wrote:
> ...
> > > I had thought this was a malfunction in the behavior that it reflected the
> > > current status, not the hardware /capability/.
> > > 
> > > Which one makes more sense for userspace?  In my mind the most likely
> > > consumer of this information would be something a sched_ext based userspace
> > > scheduler.  They would need to know whether the scheduler was using
> > > preferred cores; not whether the hardware supported it.
> > 
> > The commandline parameter currently impacts only the fair sched-class
> > tasks since the preference information gets used only during
> > load-balancing.
> > 
> > IMO, the same should continue with sched-ext, i.e. if the user has
> > explicitly disabled prefcore support via commandline, the no sched-ext
> > scheduler should use the preference information to make task placement
> > decisions. However, I would like to see what the sched-ext folks have
> > to say. Adding some of them to the Cc list.
> 
> IMHO it makes more sense to reflect the real state of prefcore support
> from a "system" perspective, more than a "hardware" perspective, so if
> it's disabled via boot command line it should show disabled.
> 
> From a user-space scheduler perspective we should be fine either way, as
> long as the ABI is clearly documented, since we also have access to
> /proc/cmdline and we would be able to figure out if the user has
> disabled it via cmdline (however, the preference is still to report the
> actual system status).

Thank you for confirming this.

> 
> Question: having prefcore enabled affects also the value of
> scaling_max_freq? Like an `lscpu -e`, for example, would show a higher
> max frequency for the specific preferred cores? (this is another useful
> information from a sched_ext scheduler perspective).

Since the scaling_max_freq is computed based on the boost-numerator,
at least from this patchset, the numerator would be the same across
all kinds of cores, and thus the scaling_max_freq reported will be the
same across all the cores.

> 
> Thanks,
> -Andrea

--
Thanks and Regards
gautham.

