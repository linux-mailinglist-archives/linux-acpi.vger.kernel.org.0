Return-Path: <linux-acpi+bounces-21497-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJxVFKTeqmlqXwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21497-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 15:03:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0822223F7
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 15:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 039293026DA2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8503ACA5E;
	Fri,  6 Mar 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvrgNUXO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A33A961F;
	Fri,  6 Mar 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805703; cv=fail; b=MiRpUAn6Mol/bZmhGQY7LIVP5Xox+gYl74uztuHX+XElwbZMYKwN5P8PfO9u6AJ8Uiu/M1dHPKldYIgGIgIey/R0UnQAptfOfJ25lmYB6XYE1yWAX34IU23dFflrWca6Z0Q86532CcXebSTMcgKBO716tuzgwQF6BXN6YMPYYvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805703; c=relaxed/simple;
	bh=pigJHXIa1cxgwZJCIK1aY9LoQKEwK3LIyTGVhE3UsOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQ68EMMqZSb+/NsBhvm8ha8jVznyzvX7AYBtLAXv2zXqbEcw/k2He9VvbuzXKTD/I/H/89+dIQBQue4KYn9xxv+E71NW+Bn0iTOgUJ8Dahw6KVqBXAbgieMZixfdixYemx8lf2vTnLoxcqpImeEJQawXRhgjcvmLQXrM9pzd/eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvrgNUXO; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4V7Ru1/Im8ug8SEebPmeeKyTi1OCDFPsvf6C9teqEygtfFTBw01pU57uGQLuAFv/Q7Rpon4kVPf6LvJ4k7YPwcRRCzUALhStvdKGrdVSOFPRlHYM1bv7DKrNz6nuBL9ucC/XZSZhftIjx3aoQDLUf1F2XVYGQa8rT6Phjg56DJh6yDUWOakWmj47xWBCQAjhSd3YRpjQ9uYoQUjcC75cDfkkCLAPbS2QM3dZUlzW/gc/in49ZGCBr4wAdDDksxKxWa3RatolOjxL1IJtvnAFyiC/o58WuziaTusPtACrB6/ZVGxDmwwoRDFWvDc9YKo/rCbSB4wPD4jja7r9LIgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oVv3YZB41KlIY6PYSj33RWtbiRB/XxsFCI7VErY72k=;
 b=e3mWhH2ZlC2vXcYRpnjNvdw80L4xGE+2hLkn6UjzwnQPoNwoousoxtJRBsQEUnF9uOo6xXZ0mqgn9iX5noPelIIWJ6jYNtAvHE6NfbJd9+hlE4WdAQ8m8et4u7LdoQtZ95xDBNfcsjef0hS4kzJjeY3U/kr6394I535v5XAbZVdBUeibn/XIT1cG4nvfJqD0Z/KHHbzfZifomclml/JimrJ9nECspZTKXVp9xkBru5nD5XJA7ci8Ho49ZJhMpc3Gij7IT4g2GINBJcV+GRbB/kfK9+QoQ4qbuTfPNvjblbnxLRMfzhxvnPUplthdOA0ahnI4vxcb7HfhJJEtaMyYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oVv3YZB41KlIY6PYSj33RWtbiRB/XxsFCI7VErY72k=;
 b=OvrgNUXOBKOSuc2VQ+7Ran0fWi12FhlDrl4X9fbr8+KSaQmvAGlCl8VR7DY2IWgQ7eivhsrVSj5jjehaAQiH3OEJyMbcx60f+rJf2Agbq18eER6uZjmo9WBdoGYJnDIB3z4l/MaE+KhMaASmHoN/pUHaq5WqQYBBIHz2tAsPnIcQ3GSDJQ5L6IvUvN29Nrwnn7+4qFGmCMGS+rk4iizkazYcouyJ1Ecrdhb+LlBtUvmLtLg53zbZfDq6GJyLUBz+smjRwz19upSmM4POUpbikDJi+V7Jae0WUjULRWVy1A2VClaOISQJ/3oUr7Mi7TjdreDDOLxs77VFoiuz3bLU8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 14:01:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 14:01:18 +0000
Date: Fri, 6 Mar 2026 10:01:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306140115.GH1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 892e27ff-9d55-48f0-44a4-08de7b88d697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	8Du7+7w2emJxT9XWLkUHX+W/MmZC87azB0nTchCnlrmlPPPdOudOo1qs/S9TH49TyAHHcx8zQc19pZxJpY6FTmv6QBYBkvHMBXeo7DOK/QCeOBxh1WhR1X/Qff3HAwyZ/uhNQHv62WYBcUyHz1lGy9fGAubblH+/23BK9nJlrStkD3i82Bm4SrYfJyfocbFTzUhzT99rhh8HmcPVH9KX/l+9R8CFmUsKI3mj/ScqceCDt6aB9B6lhgvMY03dUarSo77UXdGR27NaXr4Bw59y/OcQLLYFmHLhgPYKEvzAJbekJiu8tp1Jkel85AtSWuDsZAdhPoARHOizIsciD2qWh8lcrPoamqhtOvMAApUYxshWcAI5ZKDb1q/qyP0OPoBF8lYoQWLppIaqJrXfI8yCPw+2fwqD6ztg5bw6u308QGYnRNMyJhub9tJu28sNBKbKtTiBJPYRLDeL2+8zC+UsWeB9W4Cmm5wA6gwGRGUJ4qYcbaDviZwLOml89I1fNiwpcguw1ykLvG+im/LjiBULe/JepWdq3ZmdVDhfzs2UY6lWCWkRLOkzGhxERL7RFBbcItv5YqkRKKIqQ+9IjSenh236MVS0SGtGPor+grKrgUQFTI1sh5C63QYSm2lCGk8uD/TBNNEjeCAOpnMVr2+Y4CrbrvuMuoygaxQlpRE7gOMBP+8/ZhhoSZevoryLqnR8OijkmGtFCZNmm3KpHsvHFJ9kkPrJlYpky9CCztM5tmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPBAlpD87y7rvGtzjiFPryyb5i2jZqT2ejLd84N+BvlcqsFlWc9kUQix2Git?=
 =?us-ascii?Q?dOYuGf+QJtQmDbbaG21Cbvg5VsRZaK1xGRayc3Uyflykao1EzGGctdaSn5bs?=
 =?us-ascii?Q?RBIJJC36Bv4uihdx59YY13I9O8itPUppdME6kmLYHuyzWLuwz0GvLoXuvNq+?=
 =?us-ascii?Q?0+X8ge8JFMsRrVOA6RSQVPJiE4VeEXP1AezESPoBFw0gJluPY2k99TNu3rJ6?=
 =?us-ascii?Q?x+1PMa7W5BBgDXNmhnk/TA7r6BAHu8i5pfE6XYc2ai030YwKcomfLYfkagf0?=
 =?us-ascii?Q?J2uhkX8m6RpC/RcWZyX7psE+34akS+quksO4O+UvZJU+cY02Gi2QBmgCzlsE?=
 =?us-ascii?Q?Lvck0pAZGgQmkpoIMpMzJbnKnXi2SPOp8a49LDPhWNFjj2YSiE5gsdGbPUwI?=
 =?us-ascii?Q?GQw/Vs9hX8LOVqtJVKTf3iux6cbfBI1GO0BvUFZzeYqIFY7RAnH7/gdei/Yv?=
 =?us-ascii?Q?XI5lp4iNwxsy01u5W5KoTicYrHABQV77ctYtrNl8egePA6/nOD2G2exSFN2q?=
 =?us-ascii?Q?SS3yuCwY0hqMbFi9JQhmIcCC7S9gq7iECrQfxo8UY5hRZpHGqPxXY75otM0j?=
 =?us-ascii?Q?h+RT60q0cAG59s2RKqBDiuPl5uMOH5ULRRqUma+f2YCgIwXWq2LerzC2rQoq?=
 =?us-ascii?Q?pCAW9y1lOlBIByDGlEEDw3p452VM2DePLGH2M4rXs5qaKTLrGgvib5aN11+D?=
 =?us-ascii?Q?ojSwT8QRQVp862WnfWrLOsdiNqB4iRM62g0bqiok3wZf5VZs2WvD/pWToeyg?=
 =?us-ascii?Q?zru5sy42PXTk7lleE65Y6l4GcWJE+1TszY2mQygbi4GtN6CC4deg0dFutvXn?=
 =?us-ascii?Q?zwOSvNSvS7Xjy1BAwBTbWjyCrr62janrCyWGFVQqu512UHu3nJ1JoYqJLYbB?=
 =?us-ascii?Q?PUF5MRIkPWP6LmD8s1stufMJR5kV3Z+3BeNuwKKU4Ir5sTZlwG3eoAoSnpU1?=
 =?us-ascii?Q?pwFjVRFRiwMXRIkezqnZ/rOPXxFdc0PNmgTSTQsLYnYkVrWWKTqefsiGGQtk?=
 =?us-ascii?Q?hrJfrXTyahxRawU2EWxTmLjLqdgT7K0wvMbUF6xNp0VIa0US80J9AU9WVBgr?=
 =?us-ascii?Q?STR08FYouwe5BhdTisfULcQt94wYWK/hARmB4uGEq3Joh9DA5j3dlUklYjMt?=
 =?us-ascii?Q?ZUJ6Uied466z0iwmvNoR6aE9L6xKyYNHW3GJD+zIBcWBM2UtVLcK7P8zXsXC?=
 =?us-ascii?Q?XBUTejnj0OfQLSrwxD9XU8rXqLmQ+n1B1tx07tYcxDFhQXXRA5nnPA4Rf/gF?=
 =?us-ascii?Q?TGo1FaYH90SHIZdquE1WrHHvT754a3sSxC1tNIMPxiqlAqFEmwLeaoUkBJbx?=
 =?us-ascii?Q?tqlcwGeC7DlkWcKiPJE2MXCFtowW9Tn12Fk7tc/LqfsHZL5nfCG4j1aAOVfF?=
 =?us-ascii?Q?2wRIg0kkjtFDCLca7JyM4IX7MtwX1sf1nNQ6lc6CCAq0Ee0yvNfW5Rzrggwb?=
 =?us-ascii?Q?5XESrEkznTHnaUyvxHjvt4tPEpq1+ASRTBXKhQYsZsZRKz9zhKTjhprpmNXs?=
 =?us-ascii?Q?JXBnDin0hBXtXS8sdaWn6Omf1BQyBkXasaOisITbIqjaK/9fUBFExt13KTwm?=
 =?us-ascii?Q?LFW78yybju/GPdWvG2EayLWOItv8/PE3iaci9Q+eJa2aOta0MVqawYp/pa0u?=
 =?us-ascii?Q?WSNXMPK6xzNFyFFH+D3Cbtb6llVBMwlo/aWUjI3TKwXn0+12DMoy2JFpzM/9?=
 =?us-ascii?Q?uyTNdUi1KwEdiLOECMFFjX2HCwe9RL4SjPm/4ZpPYIiu1QQUx42LvT+dbe3W?=
 =?us-ascii?Q?NcEAcg/z0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892e27ff-9d55-48f0-44a4-08de7b88d697
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:01:18.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/xC+YtF5FJWlH5g2JUbSWWJTVii20/kIEoxNSiIih+j3XlZCUdsacFWFGGpdpGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
X-Rspamd-Queue-Id: 7A0822223F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21497-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:22:11PM +0000, Robin Murphy wrote:
> On 2026-03-05 11:41 pm, Jason Gunthorpe wrote:
> > On Thu, Mar 05, 2026 at 01:15:45PM -0800, Nicolin Chen wrote:
> > 
> > > You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
> > > out ATC command?
> > 
> > Yes, it was my off hand thought.
> > 
> > > So my test case was to trigger a device fault followed by an ATC
> > > command. But, I found that the ATC command submission returned 0
> > > while only the ISR received:
> > >      CMDQ error (cons 0x03000003): ATC invalidate timeout
> > >      arm_smmu_debugfs_atc_write: ATC_INV ret=0
> > > 
> > > It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
> > > thread?
> > 
> > I didn't look, but I thought the CMDQ stops on the ATC invalidation,
> > flags the error and the ISR NOP's the failing CMDQ entry and restarts
> > it to resume the thread? Is that something else?
> > 
> > If so you could insert the STE flush instead of a NOP
> 
> Nope, sadly the timeout is asynchronous, and CERROR_ATC_INV_SYNC is only
> reported on the *next* CMD_SYNC - it can't even tell us which CMD_ATC_INV(s)
> had a problem.

!! That's a good point! The new invalidation code runs many ATC
invalidations under one sync to optimize for SVA performance so we
have no idea what devices need to be reset :(

So we really do need to signal to the issuing thread and it will have
to go back and check how many ATC invalidations are under this sync
and re-issue one by one to isolate the error then issue the STE change
and sync. Nothing from an ISR then..

> Also there is no NOP; currently the only command rewriting we
> do is for CERROR_ILL, where we turn the illegal command into a CMD_SYNC.

Oh, OK thats what I was half remembering then..

Jason

