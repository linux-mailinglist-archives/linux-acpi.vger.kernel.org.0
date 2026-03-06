Return-Path: <linux-acpi+bounces-21468-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC3hKQkuqmkyMwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21468-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 02:29:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57221A3D8
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 02:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEDBB3022991
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063F313E3B;
	Fri,  6 Mar 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="plHNX8iu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A526ED33;
	Fri,  6 Mar 2026 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760583; cv=fail; b=WU/+BzCL1JUfOz1/7ulXKbSsq5OmdXSi/fgIuTEgnFjqOUAiQ2ionQG1mTvrgnMFDGUHmhT62OmkKLTL9zQFsprxttvT4rcfR+VsOtpiANCuQ8xm4RKDIvqh+bl4HuadBicDNNZ5Fdl2uvSo5/xiJzKqrzGs0VQlz9L3ejvIdjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760583; c=relaxed/simple;
	bh=Em5Nc3ElXKORdjxMPHGzYza+7TyfUvx67LY9LgKrvBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8Us9DnbVIjveUdcou5vdc0ql3EMd/5S0W9Qrhsorp+8sUf3FpHjdIWPhdl8VejS2HA90OVpPxg3cyWAm0q09oOO6jaTXasYO9BC/B1/rLLcoGHRF8sx0uq+em02zZnQj+pmW/oEuUC2fqCQELToYaMrxxoHV9I2YflGyZpqsps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=plHNX8iu; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tylPmc9d5cH4oQVuCg0WBblWnO3dUpAtSEOSYv8RwVRMUsXRIGvfbe2NVHEx65IqVYI1EEIIABlzj9a+BKWNdSGq5A85h/FLEQqh6cP3WYqdc071I9o3ClC16ZNzkqYhha330aRuo8+p3Er3hJAXC5ZOgjuBzJ+euYQz1S0m1wlUx8W262NiTtPwzvNsQloe9/FFEs1edhBQ8SwVwxrRxiAitWpHmLJbDfYDHuytZPUsyDtg8IIGWoxi6l2jPrMpOA+nid0xqEwtDHjntQocAQd3XSmvSiayhWkpYuxX20BfXXv10g2Rucc2PakJuYh1c5MQmoasPma9M0HATYz5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfPLjVRO2nOOwLUUjvDT6W/Je5YmZ9lTARccIVlkByw=;
 b=lYpadOKoxr1TjHNicLlq/r4SmcsDlWS8up6GBtO3B9hxs93oXflP5YECEZwj6bgextp2YD1Jik/tmEl/czCPLkUTvrC4tZHVJMEw+OTYNL91deRo3S8eiygSdua8zBxRevDrWXTZO2xDtmxrH1C5cw9bz8oLdt/G5aRUCXuco5WWlbFIvDUNYEYVMzWxrWW5XSFS1204at5ir1DNTs3iA9fh5b52CvGhmu/2hBS4e9ZM9QDvfGMrryOtvF02uUYzflFdJGmjC/CHftPC5ZO3RXwBGlf40gzmJ5FDkWsGd37sRa1cV3pG/rCUuoBUzP0E7N/cpv/Gvl2b6JGFsUE2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfPLjVRO2nOOwLUUjvDT6W/Je5YmZ9lTARccIVlkByw=;
 b=plHNX8iu1n/fSpcyomHzoogbrAiY7quzzf/I4S5e2HhP6/8nGiOpPQPupMIBRqCNmUrvkub7yty3mbdDHTbhXxkMQWN559BxLd74C+xs4pAnYb+n1Dn9paY8STP5mIQKS98haTgCEKFH4K5Ffb3IbVNXu6q8B+ePlX3r6kHxzdcr3kjkb5/MGaQHCDCJsSRn9RC8d3vXIGJrvNfgPbgLfpyxh7j+VHBMvl2stvRpAOgjcfPZu4LfR4nJP7ZFAULV0PMQNnxyXLMogf3j7GpEqMwhNfI6c7lNVNavGp4JQiEgEqClAysU4ITeojYK0maCgpTRt3qzhqvuRj2gBr9rpw==
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 01:29:33 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::e5) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 01:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 01:29:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 17:29:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 17:29:24 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 17:29:23 -0800
Date: Thu, 5 Mar 2026 17:29:22 -0800
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
Message-ID: <aaot8uRsli5jNPzH@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305234158.GB1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f609f6-2b92-4399-ea05-08de7b1fd1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	WjOJnqwyaZodK7fcL+MGhWT4ok304Z5Sf5Umj7s/FpZRImTLMRnwrpNcP42+LExVHdgIObxEVAh9rNTM1OhLuhWVBIgCJrFcdwvLkcFPQYjHtCRMrrsq3x3TKodG4mcZyyb2PIS2aH5+RLVOeoXsuntDJvpCuJxjU1S0fI/+xIEXFlGGMtK0WOnrmntVxSLeXNZt+uEOwuzGRAnTlTgoH5GAv4yqyBBntOzO05bBu1mwBzGaP3CHeJCNxbzGQXKA/1k7SvBXdMUMmNfuizSLrXpruty3MlI6Hrg/hKj7q/DLGSv0t0GOuCjTRmjuqgorMOvc8CUt1n8tApx7GnrryKytisF81273T9vD/Axc8zeci8K/qaStKxMHHwvJ0nDnkGDOJmG2bilye4szni5R1RtgTS/oqbL1Gg6CNs9iDfcrYAgFQYR2Lh2JyARo6lta3clK4uB29O7bB1bAeqMmL+R7FXoq1Lt/UMtsGkJmOUqop4XQ8J0A9jEUi7Wpfw8TaVeiOHc9fxbAYbzU5OPnF9RzDLSrVXwMF+9y1zs7D3s79nqOz5uoUx+tWIOyk93LmN4f2/4/kBLiHON3qkXC+N9KfaKoo7u+H0HSIcTigum/c3ND7JJHcCAo/J1mipJp2VzdL6H//ih/dy0kak7xshPebtcBIumev3gBAUHaERH/rhD+mO9ooFrunuQj0QJiJvJXxf0NVD2yRehgnsQ1dtz0/qn+Q1TbSW3JuoI6nNQXuKiss4y4K58vVjgdgcuHMxo0y8Nxqq7EK6gwZCBz5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DKD49Z4+NLxoODy2CbYeI2mjj0zAqIpm9cv+SZRM8iBbNSMTLMc2nUZo9Qoz5N1+qGwuPMtWhW0aPBvLHxdb3eYvr51kWC5DvDgj+SRnauw0vtC/f02JS0DNElWG6jHwomrfcD3ZQM6y+pvIdBb3RARkbguCfZ4Sylj7yBv4/E7ALYVKxGk6YoG3nOVWTx9SaBRMMuX5NqhuU9LP5b9E3mf9nPb0UR2YZ7xhSO9KknRQKqRP2bZtN5fBJyZwz33HTtjCDr1Px6/0jSy2Ow6+uEJNLkgsN2HPfR5Dqn36ngPfai+rCNGGJPF8fMAwQ+14B14fAbE5eMY9oaKIXBpM7uhLHoqObnegD4zW2ZZmn2QgZuuRgcl2FOTvciUONjjiuh8+zERB9ljI611ZYS7D3jc9BgzoH7NH15aqoyNKrpAboapVQWTM2VT65rpZJRdj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 01:29:32.8345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f609f6-2b92-4399-ea05-08de7b1fd1f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
X-Rspamd-Queue-Id: 4A57221A3D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21468-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 07:41:58PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 01:15:45PM -0800, Nicolin Chen wrote:
> 
> > You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
> > out ATC command?
> 
> Yes, it was my off hand thought.
>
> > So my test case was to trigger a device fault followed by an ATC
> > command. But, I found that the ATC command submission returned 0
> > while only the ISR received:
> >     CMDQ error (cons 0x03000003): ATC invalidate timeout
> >     arm_smmu_debugfs_atc_write: ATC_INV ret=0
> > 
> > It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
> > thread?
> 
> I didn't look, but I thought the CMDQ stops on the ATC invalidation,
> flags the error and the ISR NOP's the failing CMDQ entry and restarts
> it to resume the thread? Is that something else?
> 
> If so you could insert the STE flush instead of a NOP

Yea, we could do a surgical STE update/flush in the ISR, bypassing
the arm_smmu_ste_writer that has dependency on "master" vs "smmu".

> Otherwise the arm_smmu_cmdq_issue_cmdlist() can just push another CMD
> to the queue and sync, it is obviously in a context that can do that.

It was actually a good idea and would make things cleaner..

But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
CMD. In my case where ATC_INV irq occurs, the return value from the
arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
are also matched. Actually, at this point that NOP ISR has already
finished.

Thanks
Nicolin

