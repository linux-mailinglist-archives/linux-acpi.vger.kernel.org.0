Return-Path: <linux-acpi+bounces-21477-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L8rG/BgqmmxQQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21477-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 06:06:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109CC21BA1C
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 06:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77A2F3016705
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 05:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A836CE08;
	Fri,  6 Mar 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSyMr2tl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F162EC0B5;
	Fri,  6 Mar 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773612; cv=fail; b=S1nuN71DncinWLjQmG4PU8Rr43rTiOwybxIHwMVkt0XHA63eskXia2LPxzsGC5K2yQreePUBn/mHNjEor19XVf3FmbBd2wZ/m48dVds+I/umUO2Z58C5uO6fZbGwv774utgdWlMMmRKLMkOQ/gMRZrUrFErUwc8Zisj02SfXMG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773612; c=relaxed/simple;
	bh=5tnEfUc8+JkuRT+4OVMiKzmlMjwQvKeuF5emy0uZvpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GezeuxMNOVNtGlEuLZpGZj2pwd+8r4TtNTXexYsXBl6hPRZiR7SkIvlvJ77ad/BpEwxIkLsLT+ZlubgywXaaRbm4vmIzB+oC98YTj4hwhi1GyEG0ZyXG6gESfJWFf0zIUsFWIlpQXnFST/yKCO6xaLbQtuCQzsnzeRm8gFTzR2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSyMr2tl; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVFXwGi/SPe4v7rM7MLd0137eME+XSu3JaHFSTE+apW23hqQ/FSNzHM1cS9Ogo//toonKOQAMna4W044PqMOBMyPASkvoxo59DKZQ7AVpqHxvAdeO7bAY6m5FIXRNmM8RJEvLvIuYKDaEm3O+3bh3/eDqqL31bRlMp8RDCtWyQB/AmJnf26wgDO4/c5iapUL7GwDmdjo+EcgFz8SNTUNaryj1cgk7Voas/QaPnBbmkC7xaBpm67brj1/xMbAnpT2amE0RKA4Xrqn+0oKaCWzHtdVCEssciNadhsVb5bBleDUYAtX7T4QAr3zvGCLudXBy2qQe7We9HxZ4Vp+n5PiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJiF6BmglK0AeTwjDbUxxQND8SoI8hUjkKHETrw/fmU=;
 b=qy/4t6vTUfHnXVthVeeVZSKKSlyO8CxD/ALtjCodo6mtwJ7N550DL3w+xsxR7OWoVwHrfm9R51wGc38jeNwDED3dQIi5ojvFzmTTWuEKiAsCGtiiK0VMir4L9yBj0XxVu+keDOAA6JiV3gPIwD9bjEjFpfNbwbgB77uJ33y8df2oQHpYP29eyfrrbvJ7OPqzRA13u2UiSKo2lPGNkvVvN5rR2dflvWxHgs+5tuUk0lC/Rs0Jrvf0buYbHMBvNxxnO4F8bkLZEr3JA4pCy6vGJDD5o8fORtNUDX7jmnf4mtR87T+6Lwg6hZ4Tqg7Vov8jiacG80XDTdwt1Y301NSUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJiF6BmglK0AeTwjDbUxxQND8SoI8hUjkKHETrw/fmU=;
 b=sSyMr2tl1HVeAh0PBYr9Imp/7NiBkUO0ZFjvF9Uln2SaRpXzqc66tt2HulKvclbP6qbV8xMKgGOBlKZR+2wYhxdKWwQE9GoOYOmDQHFq7RY+Xi+K9XzSRMFQFoXG+OuPs6sNKgYg1EPvOcB4rkRX0CpvGeNgzhvl+YskyBwXMOnMSqjpDoePM9Iqw1PoNKcoMgLmBOL7BwRCnn407vHDAbHShCdttf2MRwwm3Qi5ILb2Nu1Hj8se/ARQzaRpNlVQVv4pPOpYIUvXR1oCsF4U614J8qJhSfYNzzln8NnRrGpfRfEHLwg77pj+a3p95gBDp+r8c2a/5ShYLshSvKbaeQ==
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 05:06:45 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::1a) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 05:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 05:06:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 21:06:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 21:06:20 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 21:06:19 -0800
Date: Thu, 5 Mar 2026 21:06:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<praan@google.com>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <Alexander.Grest@microsoft.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aapgyXadT1TEz29u@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306013347.GD1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bec189-2798-469f-e428-08de7b3e29f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	ZRT9IG6o6SsaFE4LrMUccnG+hcw0lQMbIKF+3pSGxfaQ1L7N1QTdR0AN8VfgCEpQwq18+i/oKPAdWkX7BeYEcx8E29BfExtifjQf+yva8pt7cm+z64HpMjKYpnjA4Xy60W8lWF4qGp8RuOpnxAZv9qlAmkR2xXaS56TGSFyJs+pH9mCpvkBhmqjBQVbsINkP36S4IxwFl5wYJKxAC4+CupovYrDE99CgAcbkIXnTNqIGVIh8HQH57w/C6cL2v7FdyZtZqpjDZmbXicdThazhUf/D6RlS2P7dPpIKTQ5o2G/+fukCH0b1Fq7Bq4/t31mCYLe5rf7t/j9FQLhNxy+8ph4+NEUa7HeXIAPIMbIG6f1GhNpxFhRe9FDzJyOAKukQsUNEXXJYCWRIda+jFE2m8dZqWZYezALCZZneNAjDrcupy59W2HNGaq/efkj8PzI/I1WthNEedfg1sqK9biR8Fgx2N2tpylSotQq/ctuqOCUROqDuFXlxDT5xQ+d77g6Tq4hFnWq3+Kut2rid8FSKTMfZaYqarLh7pneHcMErNHdPOyUaYDEQqgXGkmpwhsRHCT9l0FvmKzQGncpXRtUTIJ3fLxjXtuxBhR+Ku17smRIjtvj5OCeJXGYgkRZfX8U5yv/rGJgXyqvq1fqshODenOit2+fAES1EI4TsFV2x5tEljsv/wlbJllivZgND5ejmSmVu8eOYhc9rTAPpyFtax5t3I0hoZQClW8RPcT+3n/PSkyG/43yXpnUxnFfTyUoCooaLSQa1jmg+Q6IV6dIYaw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+dnWQc1Uhzag1LQdoDThz5TAr7VU12ghebGoupo6LvbWuB8kaPOtdj3RSm0gLvnRRnEBVORi0t9Cnd9uyZLr1itUZS8zQTJxANpHxxN5f5xXjDg28DgJGMtwzs2YYYMvZ76zRjsWeiUR+6zkPg7ZEPKJhI7Nhbpi9nrs3xELdSQ1ZsmTzKyQyPkNVhbllf7dQkZVzAWTvnDwjyC4LjON/RkBlri4NyGbU54cDhbE8IutU1E7Pc2qiPl6SYuIdgqpmCjJ+Lf3tfQ/VKICKaZ830nbsRyQdco10urQ1OLfRraw2Mhk3/wvf4JGvwzj5M3CRXaj8FnaMJ897pb982akV03qpkRZgmwmmjOC5/ov6ww36U1ObqfPLBCL9dI1RvhacGW1qlCZSFGHlDLecDWv3zJrOD/scxAZvcETopAs2MheHv32RwH4KR8WKbQqhoMa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:06:45.2597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bec189-2798-469f-e428-08de7b3e29f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
X-Rspamd-Queue-Id: 109CC21BA1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21477-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> 
> > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > CMD. In my case where ATC_INV irq occurs, the return value from the
> > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > are also matched. Actually, at this point that NOP ISR has already
> > finished.
> 
> Yes, you'd need a sneaky way to convay the error from the ISR to the
> cmdlist code that didn't harm performance. Maybe we could come up with
> something, but if it works replacing the NOP with flush sounds fairly
> appealing - though can you do a single WORD edit to the STE that will
> block translated requests? Zero EATS?

Yea. I can give that a try.

> Also, will the SMMU start spamming with blocked translation events or
> something that will need suppression too?

CD.R=0 can suppress fault records, but we would need to override
that in every CD of the device.

Thanks
Nicolin

