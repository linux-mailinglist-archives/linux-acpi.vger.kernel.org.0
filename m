Return-Path: <linux-acpi+bounces-7916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05249961EFB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F261F24E78
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACF155345;
	Wed, 28 Aug 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="azkuUEy5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5B1547DD;
	Wed, 28 Aug 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824803; cv=fail; b=NSNomvCqozeJVjfNqNuFrn5xcj07b78NNOG6Z7DCiop1hAKnfE8B2DYX2Q1iwukqTDolULw9Cib2Gn5VLvUt1weUd1EvTghJ86NBdV+mwXChrXc+AdADn+yxz3sbeiVZTZwxhyVuxsNo6spV7lkt67DgnLOTRyXyjiMpcQVk95Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824803; c=relaxed/simple;
	bh=Lt6jMfQVKUREOHzH//JIPzJe03bS+OL9nFH30vMF1Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VR7OAYoD8jExTdEAyf1KaGCeCQcs1nUDPZoLBmTl+e66p98Yu8jbLYrcK4QFT3HousL7SMRNRdqJLdgwrO9FkqRPTWZzNFwG9E3TmTHxvVbMJ8crI+fi5WxICZlPh6JUtWzout2EcbRVELBIlGOiiSDQqPBn1DJBr0MXNoOOt6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=azkuUEy5; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTdVfwx7lIHh4TqSW2w5pZbZibMjRO4XWjTgjWX5Ob7sgkRlQTQ9PuCSuLfEbSm+ixyctrU/Dt2nkP3vc87Xxuxu/UDXWCfUHD5RyOSoMQWG1sx6Uf4aOAiLovMixo3OlaJuOVgrW22j1azsPFzTV6CTgdi4oz6F+Dl1DiZFkNcCiDTzW5ldRX/Luj1EiuA1GOh64KH9UnwunRgm4OgkyY4bZZXiCgfkkq1YVkfssizRq9mhIBkUvwrp6kjr5U+d9hvuYoHn1P/DWJIhqMBI203RA/gKLw+eZ/xHLs3mTNSphrN0KAh6aMXnPdItzAaB3397CkPQh55RQnWA7oLFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBQ+7mCUYDnQrzfZptUOA/cnwuN/+fJQy4jUblNtB70=;
 b=EQtnKMSiuEhMcpE/JdTNdnSzxZFn5YuV5uqrRJziGIYZjVA/DweXXtt+kpX0+WOx4RnfSzjHOlTyHq1qHivrnkXV9v27Shn1KggAnKtmHU6IHW76k+NhPMKObNiCK0MOKpNsEMO+XKt/o9oQrh87wZmhmbnXpnKnK79URa1HrCNuenKf1vEsmU09JpW3MX9mQTjEID+OPsBfFN8bmSn3v/lCcRchqex1jDSe1VqUtFqJw2arHKTCAzfcjUVi8bHZwPbtWEItrCbjmy4/09lrXZmzvCl43ZNaE6v1Y8RiaPPaclskApKwVWIF8kW45AAvWZ0KnVkZqzwXjCDPx/uYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBQ+7mCUYDnQrzfZptUOA/cnwuN/+fJQy4jUblNtB70=;
 b=azkuUEy5BDuT83FrvkUWDJYs8elR1Qa7js1G+iCkLVYWIiGV97UhUiJbjOHIAs33cDeCPX2PYT5VAcBeh3ff2QcWBvxwSfnHdRHLbF5J6/ltnRVvfVtNJP8yX0pBe+U5pGc1jWwpkTykNqNAedahofY6Q3CFPgGghebvWPdfPY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.27; Wed, 28 Aug 2024 05:59:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:59:59 +0000
Date: Wed, 28 Aug 2024 11:29:47 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6/8] cpufreq: amd-pstate: Merge
 amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Message-ID: <Zs680zAnW/C2go7K@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-7-superm1@kernel.org>
 <Zs4EW7s3Z32UAFNI@BLRRASHENOY1.amd.com>
 <2091c274-00b7-40ed-a27a-83850130df46@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2091c274-00b7-40ed-a27a-83850130df46@amd.com>
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a9911-33bd-421a-c082-08dcc726a5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aq2Wltlmbv3VWCAQIPm2Xk+nCPcC6alIXi++C+HDio+KGAb3Ob6r0Wm0WCiS?=
 =?us-ascii?Q?+VCyMMqOmbb1TFkmWOX5jIPMYxVV9u9yv5t6XlW6SHtxPQnrNyjc3X/she0X?=
 =?us-ascii?Q?46Md9Iy2cTbwDtfaqDtzsndOwiz8v/ujq6spN7afCXvuZuooHhbPdr08/+nu?=
 =?us-ascii?Q?0CvgsISzvUscfhk/Sq9mJhaKju8nfY84tP0HPDUqfA9oGkwOaRg4FEaajnzq?=
 =?us-ascii?Q?ucqzYNGDfxkBYR2iuaZ7jZ6RxXVBycM7LXkJXVO3vftku1CMeeToMkU0+KYz?=
 =?us-ascii?Q?+fOqkKsRKq8RJ/3zy1xjVHReHWqKuKeWtrOtOS3RTngdNeNulfATZMwJZ2I8?=
 =?us-ascii?Q?DxGOSNhYUA6VZTpPMqKZAeWPRT/WRE5PyOrfE67AFxS1dWqZavzn9LscYwx9?=
 =?us-ascii?Q?g/QTi82qDZSGQ1/zfGo9Zb+3DJkLDDKg69QT+tAFsH15Nv0XehN0J36ZZqRd?=
 =?us-ascii?Q?Onw52/6oRij/LTaPvnRLqmiMkhCzQMRb4yyqxobRPanaPhamTHbZ3W+JFl1k?=
 =?us-ascii?Q?NCE4p0CpK+Img04pFGA8QbTYJqXx3CIOyguJ4P3Jg/hyYADo0I9srTsdEhE7?=
 =?us-ascii?Q?MLzlA/gePFisyn+UvBFlO0Zys5PJjR/Sz9T4rzyUndVnP4qASo+Zi1O3laOt?=
 =?us-ascii?Q?iPl0pri9k2fmS4NKFTRnlJny+cHNs4XsESo5xSmYq+jk3Zq/n/slx+707W5T?=
 =?us-ascii?Q?ADIs907IyRkArTjvQX6PFh4kg+Hj+RGTSCSAMDvmDtNRMecPeCvf6MTZgC/Q?=
 =?us-ascii?Q?DdNPp1XBinCg0AQCpdhpQqx7S1J4f9hbtIyBSMwN85FE8QV4oRT+ZJaWZApQ?=
 =?us-ascii?Q?bNfmG5sgC9bGdjAP8iae4Tjsj5lcTTWS+QnGPP8cAMBcy4KpztSYcINtqkSC?=
 =?us-ascii?Q?Az9VTKVbUSX1zNGBrJOgNhpRjZhGjTF477d2ZsMVLyDKjRPj7ALtYomxDCAx?=
 =?us-ascii?Q?qZG0afduDEEQ/BTUPfgXn2aBQSaWB0vnsNxuxUVN1F+wYeC7g4RZ2v3NaXn0?=
 =?us-ascii?Q?7XAURx2/MQk5MsbtA7vx1aqxRxEu2GWXDXgRrZbBbMa0O0b1jN5vqAvNHMzm?=
 =?us-ascii?Q?/fDGukKKW0ztoMeXLP02ETmRQd9ghVxS7SKhAhvnHOszxsgAT7YzOwbvO2uG?=
 =?us-ascii?Q?+eZ+IZDJfbhSeghGiGosqv+zTnS4Z1X7nvo9fza6YGluWSC+ICQ14RTldiPS?=
 =?us-ascii?Q?Rw3jFh6SQljvd6kZBYTKHAveIX3oBVsMMuW/Wa6T4X897JMxHxxMlu7+m4Zx?=
 =?us-ascii?Q?ApARzbBRXeED1qJ/Rpnz6E3Y8yRgLypdWlFBVu1LT+Q0siaVwlJu8AiTjn1g?=
 =?us-ascii?Q?Lr8rdwCXziNhK1ho7DamX+f7mKee1Ne2JZAbXHAZi+3K1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVcji3AjYemah8dpb/i8i+moTfJ5MfKK7CMrZwFZ2DQ37nxM5iEY6YL+jH50?=
 =?us-ascii?Q?G0Hkn2+xWj9okMexCPddQENx0UDGcyQwdRItf1IOXABdrPRqsT36NKbJzoSk?=
 =?us-ascii?Q?XGAVq5CJwXAO2LjHBXl36a6XUyusaeyFFvE5v+9R7CIsrpKPjmB0GPO1uMl4?=
 =?us-ascii?Q?Esza1J2ASnmjtuZTkO7Kp1YVQQoVX/27mbrFomFBYQcWDe3kqwTKnTA3HAAV?=
 =?us-ascii?Q?QwSmmIC01OTj9JTOHOIznszlqoR0ypdRx1SnoQUGAfgXzJJx8cRue2oT2IRO?=
 =?us-ascii?Q?Gq6UGhCgx41+SpLth1/2Pdvjzpb32HMYWNIkJmGyvVN9Bc1ClfaOkCNelQS5?=
 =?us-ascii?Q?6vjBPNXkcCufkjEhiQ/ZkzFr2Zhs4iR2FL42I7yjZj3QT7DpqkX/fQ/hkr8k?=
 =?us-ascii?Q?oewdKKlcDZILNMnYSRRX8vx6B54YEo0btwI+zNZp8cOb1k1oSZD1RbeUvdek?=
 =?us-ascii?Q?P2NUNTHLcpvWPwF2BmGCfXwymQEMbVGCcQlJKiff/otcItHGhzIgBRv6JJHC?=
 =?us-ascii?Q?csQfs4723dhzVnZK4D3gIfzFBmiTJwudPdI6L3/Y8aUBcg7KmlvIDsdCxBgE?=
 =?us-ascii?Q?0zMlG5plTYxcHZgYTkqMz0TFJLlTdvkHdp84AeDWYU3ly4ZTEJdpRIdaJQYj?=
 =?us-ascii?Q?/Ps3Inx/iigpM0cn8uAQktZo06oAFx1HbSsC2d/+eB9c2oGeYOTKzVBx23Jo?=
 =?us-ascii?Q?31YZUiZHpUHQSNTU7Y7NIWkuBPHq+fU66jnfwuKqD2EszoEs+IMe6X0t0NAI?=
 =?us-ascii?Q?VWEDYcLJhqI8rcMQfPWeW+2umVI5OrOolvthVYd9Et0wEf2g2BPR1+tdbIVv?=
 =?us-ascii?Q?KbLmeIJDg1IMu70mnVCKyzCR3OBzJZ9OsqEDYzmCpWulexdqF5eQKwvtqtQS?=
 =?us-ascii?Q?brUK/VOW1VaJ8fAFI9ZsivHK0fjsvWWCp+yPo3PDDsmIy+1h4/RakfnWIIJH?=
 =?us-ascii?Q?xOqSahONd6ntxoXD4DDrHLzaKPT3VNCenC2AMR7EzuEOXEaEk6DOXdZ0BvwY?=
 =?us-ascii?Q?kCpUdEGfVi0ob4z4gsTvjK/52eu2am0BjsegviJa6pxgQT8NWAiaFKo+9+Gg?=
 =?us-ascii?Q?wnz5QtLOTG6m/1F9ZF7W3cqqbFnIBFKfeXvRksJAmTL8TkLWapaA9n7ZgRAm?=
 =?us-ascii?Q?mrxjJeSjEwoF8tGfreJ2KIFbdjZ1eg/FFRkCqMiJl68V/DV5KQ6C7HA5Td1Q?=
 =?us-ascii?Q?NxOzBH4nLHcXziWKzDpVGdALXaLmHF+DjRsARHFuM5kgYfelaoDMwCoiNFk/?=
 =?us-ascii?Q?dQzSuyclWDUiFMAgNOjuDLDtP0R4Tcr7R8ekcMoKsdT9TFSYtyNJ4fPWBTwJ?=
 =?us-ascii?Q?GFYnqE/CuC/ZOjTqGss5pl4vhe+fjqbucX6FIHIWWH66vTJJHJd3WvBLSd+L?=
 =?us-ascii?Q?IxyEWId9pjT+whjjCuJ2AsfiwEdcpLgFi71ci0i24bezspPt9tMqRdOqd/eJ?=
 =?us-ascii?Q?H9Ae5w4YHKKIdrTSk5szOPqoZcnVZM9dmDcYsMRpcl1bj+n5omA2VcURPSVT?=
 =?us-ascii?Q?F6trDLjVDHvFYf3XvbxxfzeoVtj9ZRrwv8CdAliiKnLXEiIAFI1vXUM6lhBJ?=
 =?us-ascii?Q?KZHIeDQ02ywU+LgCodBve1/GNnMRyh0FFWcWjXUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a9911-33bd-421a-c082-08dcc726a5ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:59:59.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HU7osWktoQep2YR+XbXXCTyQALtcc9vwH0TgZzs/mWxyRcpRJ7ZjE8v3ouRJpiStizx2JuwE6Qwhng2Cy59fPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

On Tue, Aug 27, 2024 at 01:36:47PM -0500, Mario Limonciello wrote:
> On 8/27/2024 11:52, Gautham R. Shenoy wrote:

[..snip..]

> > 
> > 
> > So henceforth, cpudata->highest_perf is expected to cache the value of
> > CPPC.highest_perf and not the boost_ratio_numerator. There are couple
> > of user-visible changes due to this.
> > 
> > 
> > 1.  On platforms where preferred-core is supported, previously the
> >      sysfs file
> >      /sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_highest_perf would
> >      report the boost_ratio_numerator. Henceforth it will report
> >      CPPC.highest_perf.

One other side effect is that the highest_perf sysfs file will now
reveal the differential highest_perf, even when "amd_prefcore=false",
while earlier all the cores would report CPPC_HIGHEST_PERF_DEFAULT.

I think we may be better off reporting the boost-numerator here, but
that's really not the highest_perf :(

> > 
> >      I hope there are no userspace tools that compute the boost_ratio
> >      using the syfs amd_pstate_highest_perf/amd_pstate_nominal_perf.
> > 
> > 2. The amd_pstate_prefcore_ranking and amd_pstate_highest_perf will
> >     show the same values on all platforms, and henceforth are
> >     redundant.
> > 
> 
> Good observations here.  I'm not aware of any tools trying to replicate this
> calculation.
> With the redundancy I would actually argue we should just drop the sysfs
> file 'amd_pstate_prefcore_ranking'.
> 
> Thoughts?

Looking at the code again, I realize that I was
wrong. cpudata->prefcore_ranking also gets updated in
amd_pstate_update_min_max_limits() and reflects the dynamic
preference.

While cpudata->highest_perf value indicates the initial boot-time
preference.

Hence it makes sense to amd_pstate_prefcore_ranking.

> 
> > 
> > Shouldn't this be documented?
> 
> I noticed amd_pstate_prefcore_ranking wasn't properly documented in
> amd-pstate.rst in the first place.  If the decision is not to drop the sysfs
> file, then I'll add a section for it.

Thanks.

> 
> > 
> > The rest of the patch looks good to me.
> > 
> > 
> > 
--
Thanks and Regards
gautham.

