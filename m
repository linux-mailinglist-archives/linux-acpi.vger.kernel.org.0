Return-Path: <linux-acpi+bounces-18613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE7C3E756
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 05:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677CB1888F5F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308C19F12D;
	Fri,  7 Nov 2025 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eeG5gZ7E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC62208D0;
	Fri,  7 Nov 2025 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490599; cv=fail; b=cGS6XroKxnZwuKgzYmpew03rfENU20cIxkkDy7URYaO5aWqhhQZ4OOSaH+tkWmdW83EqCyvtb1wJCMKSTMdxpG1HDt16oArSv+G/SExlt2Uoop4Ph+M81hol9zz80CYCC5d/vO7alIMtdjcYS73b24TYAEaOUgBvR2TJgxX2K+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490599; c=relaxed/simple;
	bh=DFSWKVDvYdxIaClqFHfdrTax2V6Lf+elkUx2slo8bCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwxtw2p4x/rLWVwadw1wiQcMZtWSi4BOlYBLd+RkaOCSDzsnRJdD2cqzTFpgfXhlhBVhP4IG2P42TXtHmXJ0fQDJjdtlnDy6S830OcHWnwWA1ock4r1V+FQ2pviwC1vFpUwO24QngCB5obF35G8jpBXH4iNwlNA8hEngNTvx8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eeG5gZ7E; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+vRAgZywrglLXwOPq644QdFBnyN1PYRy893CME+rDD99ryaHatsy0NIXdiSEEbmGC8i7w4m5o7/WYs6QLfqMERydAPbNVBLrgiTkqS2M2lGXsBXt5khUYjDwNVXcJBszBw4GZLIQuEqfLtBz2Bn2UyskabcvMdR7GHXHIgJlOx8bcNuP/Rg9H3mDI/ygocZhprW9xeMJvswBMf7EgfGtPS+qd+l0FlVC81uReAno8ABrRs0ErERckrf14LqkrGvAOym+cIZCHFL3N47dwoXvYqZXh2iermMquW6amuvtyA74xdOEChCnsx2xagl0dDlV98+F1C17kmrcPaEyoGS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoO6xKjH5Tte8FFUxmIS7MiyfjlffmYhQowWZZ6O+tk=;
 b=am0KpLfzUaPplU98tlst5AYlj4WYdroGr/ia6PbBZy6Nl/gnFoujEs49kDBxlo9vNMj+vDRgPhmQ9ErYGr7jl4ByoFiVWQGJMrmTA9za2EMJNhzFGDvgbJsZMvzI+FrhH9Cwv7+XSSZ/1FTw3ZjHm9JshS4o/9DEUPyZE5xUF03oDVYGOGU3Wu80vRNp68h2xxgjSsSXplaoWIqEYiI7uxe6xfYQ/IwplRlVxTE7soxw1zxg8gtBeX/Nu1BSgp01xZjgohv90ScQSj6jnOd2gTwjIcMJ22qy7n0QhYiQ3hHKyJaOWmb2g79nn25s2sEvbUAUoxg8xWlsN9uLaWOr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoO6xKjH5Tte8FFUxmIS7MiyfjlffmYhQowWZZ6O+tk=;
 b=eeG5gZ7EoOmzbuj30NjhoIVW+2MOjC5LKAH9vLn7cfbUcUxeB3XfM6bV8Du9Ik8231mpMfOT9lqCtpXJS8OmNSRrNZeAQF6xJPGUgajUYDa3R5tN3q4TS2dT1ri7ADUY0e8D00m7B5RXZrUGjTVCPc5UjFy3u57eZuZYApOiq70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 04:43:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 04:43:13 +0000
Date: Fri, 7 Nov 2025 10:12:55 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christopher Harris <chris.harris79@gmail.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] ACPI: CPPC: Fixes to limit actions to online CPUs
Message-ID: <aQ14z1P0I3WLYnEi@BLRRASHENOY1.amd.com>
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
 <1f6c7144-9b4e-4252-b62e-71c348f11827@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6c7144-9b4e-4252-b62e-71c348f11827@kernel.org>
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 808d38f8-67df-422d-9bcb-08de1db828ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djfVkJrDxUP1KmsX66AJhHDneJJxOpzZkEL5/g2Dbo+wSBZvaX1Mr9qPms8v?=
 =?us-ascii?Q?/t4wZq3MiCQNgRZPLHbyFWdHPBKpWWlXK/iRTa8y5wEQ/4weogIBzYO0Lrep?=
 =?us-ascii?Q?/2LGcV4dEvpL01UZk0Ie7abd8DL6BM8s/a/CXZ3YHAUbq9CQuiF4GXt5hssc?=
 =?us-ascii?Q?CaXUjo79r5KtCLpSzTspJgJUm2my/KpZE8frEx8adqChvwivWF6lXqTeakBy?=
 =?us-ascii?Q?g/3RZjkfPethKYju8L4GGSy20hkIpcpbyHKZhRMX4DyDstvHBIt9sicjHEJQ?=
 =?us-ascii?Q?7NkVuKG5KpufRlyvdJ+N1Wdv0w66YbqTFPktEeI/9KbKjdRlYwJlOxRjDADA?=
 =?us-ascii?Q?BrmYJjMrG5Knyz0IpMzt3BHNHY8V5cjbkzrzyXEZVZcPbFLHWWSUsTdcC6P6?=
 =?us-ascii?Q?ZjlWLhh/BIvt/hUOWT8sZO5Gub7Zmk6n0uQ3qOFJu2K99TbZGNshTCJEeYmv?=
 =?us-ascii?Q?yFjZlL3ok1BVm2/MnnWekuQ7l9Mv0AG+l+upCvyUBYKk6JxtmYkqKovFIjyw?=
 =?us-ascii?Q?1TrEGcVBTcIvKS/+yKOXvWloAuzkME8jo8XgGSrvUP8EmMgTcfef1BGuaaoe?=
 =?us-ascii?Q?2qhGgMTpvUJpnGDzdFgMnpkXMFGYJ4kRhXv8D/dRSyFqEXV/FZbD44gbLzp/?=
 =?us-ascii?Q?9HkKLfFHneS1VUarfH4zlRNHWXWvpVCGDWUmLKLKISgF8L/zlsnyf3Z2FUqT?=
 =?us-ascii?Q?/hFnd0bpHaz14fdHVFDKpd1MRJiZY3dRrxFzgLQUwqwQKK9VFoHQGnQrNYUK?=
 =?us-ascii?Q?9fZBDb7EG+2HVW2vovzLoyPYGhgMwR9gJ4xz/K53iWuLdq9dOoTPCGPetPdB?=
 =?us-ascii?Q?XFYTB8pFWFPkMTWuFbrp/Xhe4QiT6aCsdhYlezPyykz3AvyWGll1eiunXsMW?=
 =?us-ascii?Q?iTSBuA6ysjH4s471gaeo6n7cAW77QlCZ4c+jAUgjEe/Yk1xuznJ+4hUsHYw1?=
 =?us-ascii?Q?pY8wFodg7MfW8q48QUZuHKfrldzDKsRlKsdgpifqwVOt601Zzk1e9WCzCxiE?=
 =?us-ascii?Q?CQ78AY5CSUNnT73G6gd999HnXQWugYlxXLQ4OiZXnuG5EC/TmmUAQWXL/3Ra?=
 =?us-ascii?Q?y/Rpd+POj5BHsDuDaIFbIuKlJ4M9ZvMvtqFi+H8c0R0d8CMZYEPzUFdMcfge?=
 =?us-ascii?Q?ixgg0RiK5qIIIQg3noNUbtwzSTiJyUWXIO92kXKdHPpfayg8dryo+5r7snMt?=
 =?us-ascii?Q?StwQSixKsi5YOlPwMkV6V1s8Xlom3TfKkT19JRvlBBmwDgvSPd1iTnYTiDfe?=
 =?us-ascii?Q?3iLx9GHlokOOsLggaIPI0rtmkG7DXa/gr8g6xMwwgl08CoC0q9LsNxpZWWhU?=
 =?us-ascii?Q?fb//XY1Ksm7V1F2pLo5jve4C5DOxIGroQH6H7lifm4NLOTszGPa2NYVDiNGf?=
 =?us-ascii?Q?Ksd9beoc7Mx6p6hfvb5gapR4tggGLDn7xsZAZ0IW5bHEAxQaggEa8jeymbmb?=
 =?us-ascii?Q?bB9Agxjh1n3BC4GuY976NE2Fu/fXTZG1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNfmnpnW8KkH3x7xAkKyATeIx2bxAwQ1QbwMMI7JC9V7DxDQyQREQTbr3Zpq?=
 =?us-ascii?Q?xun4WU+77Uf0RH6Wz5ZNoyhqvGGzX8+/D7Xkei4eVZqRmpoR8m0jdt8g/gXq?=
 =?us-ascii?Q?cbQbxriI4wgaiAX8mg1lkfjzEMI2nwu8Y9MDMBNZLViVcGiO9QL6J6T0bnED?=
 =?us-ascii?Q?BVDpS8kT7DnBadzWv9GkjJ+CVLAI1BMZ4HONu6GDfpFX7HPLoDDgLgRCmNcJ?=
 =?us-ascii?Q?m26ZGk/Cakewjvvqzh25OjKGzIg5vh9MZVYSXKLXKXfWcCTyTSbX1Akv/mrT?=
 =?us-ascii?Q?RCC+TJSlmr+hESkWAT8IP/1Gq0LWNtCphbXy+GEQz7jXTjNK8qwG0lUnn0DZ?=
 =?us-ascii?Q?GL4Mj9ep1xm5NlS0z16MRYhr7eT5HaKIpjmxjjCKai0b9b2j5Lk3eHzhOKO7?=
 =?us-ascii?Q?eUcI58qG3vUhnvWWPzZDtobCqPuqCam1fsoXVe++BP4N4hgHIuu+fhpYPtUE?=
 =?us-ascii?Q?2UTbeglHDhm6ylY5h7eEczVDDk25QH54rJbqrFQ7sc7hmx+0rxaK3Bdx1ago?=
 =?us-ascii?Q?q5gL2rZnvovUOOa/lNNpiZY6pSlHE8N3KSicTWRpMrqGcjit8EoGk4bq+Mm8?=
 =?us-ascii?Q?ZVzyvDsFT3JLwLHpBLruWUKTdTwqMUomNfwXPWAcjudUSNuyfd0GFEgGkAdT?=
 =?us-ascii?Q?sBD0stYIGMwm/+W16RX1skLDi/ON48MlVCAaApwB/m86LsRoMz7YN8Uvjl5a?=
 =?us-ascii?Q?iI4MFEblS/gbpu37WFL+onBhjld1AdfLvtJLG6GflKIIFiyiYb2tErG9bxy5?=
 =?us-ascii?Q?t+FS9/ZOEpu9zrpmoEsNwUaiJeyo/64nxMmlJ+4e1kAb93h61Hn9oBGwy8zA?=
 =?us-ascii?Q?nTpwbxzC4Pm93nR+yWL6yqlvQTdxGGa3hwaXo4C9AFXu5rGGxxCYMQ9JYRpK?=
 =?us-ascii?Q?dMzlcoyi0y5GiPx7mybvESjHy77htLdhGUUeMsZVdof09usrVhnRZeLK/w0b?=
 =?us-ascii?Q?FCuMC3V+Ff0ayMZSeRrv/PdKZzhGRnR36pRsUemrqyWrCQW5K91APAhYtO2p?=
 =?us-ascii?Q?3IwPnr4WKCCCS70UwQ3+wruAYpGooCQ452UBIfRCSY2XdZ1hEBgKZATJO0uG?=
 =?us-ascii?Q?eLB/1fIur27aFVLAkc/v7jq0brjFc5H5vHCGX8pLasIzGelNQZ0pRQr/A0x0?=
 =?us-ascii?Q?Mh68G4eGXK0xo4IxQpezeuk+7ZI3Ux957l67qLwPvZSSK/K9XUPvrNtjsau7?=
 =?us-ascii?Q?ziX2QyPR3Fmc59D4iXLrnfQq3XD+9N3vevySiJ7vADPbun+vdW1u2SNCmdRd?=
 =?us-ascii?Q?6j+2USW4TzO0dmm+piTUE8eC/VZnzQ+CHBr6pS4oZ5sjT5nFzF8FRg0Hy6mx?=
 =?us-ascii?Q?7tQ2z80fZJn75++B/TmAylQm9Aw8xaFBnfaYdKl+5mba7IgOKDNJ5g8OZ54j?=
 =?us-ascii?Q?e1xyjiiOwho+eaoujGSkN4bdc5+Tvh1e6MIAwol9N04k5S4Z51P0EsJg644B?=
 =?us-ascii?Q?INssNaYwXe2xniUXyYrf7bXQgZ/t/L1DNW7pyFgTTsNuie0Jb72HkKcV/kJo?=
 =?us-ascii?Q?BCQ0ryXoKmr7hlczGajTL5cDb+NPekVvr0E6Hv3JVvH3IGaBOOtvL1gPV2OQ?=
 =?us-ascii?Q?lEY+8aQwgWN8GZ/jN71lO35J38M3kQ5shy5MjixM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d38f8-67df-422d-9bcb-08de1db828ef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:43:13.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyP3uBt8qvMQXIFN22igFoKODXtHQP5wtFwt1gE/qmCQbmHYtgm0ksZwBc+diF4sSa5rDtqq7+BJkwPjzrg7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

On Wed, Nov 05, 2025 at 10:00:25AM -0600, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> > 
> 
> The series looks good to me.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Thank you!

> 
> But I would say I noticed we are also using for_each_present_cpu() in
> amd-pstate with amd_pstate_change_mode_without_dvr_change().
> 
> Should that also get a similar change?

Good catch! Yes, that too needs to be fixed to for_each_online_cpu().

I will spin a v2 to include that patch and pick up your Reviewed-by
tag for the earlier ones, and also Chris's Tested-by tag for the first
two patches.

-- 
Thanks and Regards
gautham.



