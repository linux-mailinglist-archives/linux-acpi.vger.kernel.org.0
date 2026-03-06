Return-Path: <linux-acpi+bounces-21501-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBBbHDcpq2luaQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21501-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:21:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E5227020
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 370E6301584E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6C36D4FC;
	Fri,  6 Mar 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n6P9Tpfv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE909211A05;
	Fri,  6 Mar 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824867; cv=fail; b=hrgiuu9RbxHw3SI/eSqFhk7M7fbBlOymfCTVBGEXffRUxWpnmPNqZhx1nShfbRkZd7BnJF8Hm9geYVmzFacbnUAcGR+Y5YR+GN9bWITulxxIT4NekT1ZYtwqDN2csRib7efKG692tpp9ndSTymV1i+rhzsmthkGDXlXclIv6E8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824867; c=relaxed/simple;
	bh=38VEECLnHNoc6OczyhvA8qeCPWTSn5r8nhEJksv+KFI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw2qO8kLv48TOv1of0ztxjzNeG951KDhFzRLIlEvLTYqL6JTi80lJvzDAcQnnn95hrT7VxeaDClEaZiqjjwG4iKoOxHFt4NqecjMoo8gZKriaVV1HnyrmLrdSMWmMvdnOXe71Z6YUz4lW+uOjeP1vMafgvtZq56mPv2qS1XNUek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n6P9Tpfv; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyNem4bQuxD8imfpbSn2nTrQknGVMQIb73q3tL0ew7pQ6VIy8F5N5zXe4eB8RhPyZHYot8NCmZnU3vAdbxikX8xL03aihEy+3ggNHnGTyn2ud6QmcJWmfk1ZK58lw5FoJnA0g5Wy7GYDj0FV4whnvRJPYQo1tJlg1TU8bslItpAo2JTWmD6/QbhxKFTM+Q9WW3WuwyWWVHBUhI4mebQA9dWn26KsOXmN3l4QJVHtKbPNu6SsKwPj9nW09sg2ow0dZ+h/tpgnjRHBelejv4Ntyu/jYvKfdqcSyDAOZq40/qAF9HGuveTt3V5Uw2O7czUF5j0G3RsfHj969P+gG94uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd2QqtBJUMuXDJ00PPlEy9z3t/POpanr8AY2N7dfdo8=;
 b=lcrzqr60Zo6awTVQ7Us/NT6xqcjRJuKLy1gLU+kzTQgMHvw77QTdNFHBxrN0zXeXMjqNxZe5D740OQoaiomtXbADu6MjwaKC14FuEsfVDi/a3ngJNDnrn/h4Ol/rqyW81a+D+rV24msIOd+lrRUJt7vMyb1T9dAw9vJzu8wwtPzL0x0mUyqNdYxjX3QGcV/GCRNe75OJRJZm4SbJ/32k0zUav4Axe2gIM6zQgZ8Kx50PH7dlZrZMTKUMGf9R9njb58iQEqcv7CTEVPuuAOQOPC3fWKXyNJ4dxXoKNAABjCOU4rFSyQW51JDOffIUbkeKrJ+3RvNyZ3gt8MZsjMVV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd2QqtBJUMuXDJ00PPlEy9z3t/POpanr8AY2N7dfdo8=;
 b=n6P9TpfvERyKs1X4gq1VrU/iE062RsqhmNSs+cSO84h762Wq24FGmjvJkPo59XOJJ80Gxj0IUGTHJkyap7p4pN4fQyZL2k4qk9cbV8myKOmPRB4g+i7mzy72iUQVyAvjDNvKAbIBQL92ipL37bqZkpVg1uGTkVaHRdWeqMVkE9VCRDZleGM5quGtwRtFK1yt7up/JVgAoI3WfySgm9M6Ga/pKeCL2u817g80Kgfm3fM2/2BP19kR2DrL7RHroHHSrcO+T4hilx1l6c/A72yHyL8Ci/l5mY8g6RDC2E60W2kAQEpO5Mldrxn3pKyqH518TeAFD5vptVUEHaQQMcdQXA==
Received: from PH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::26)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 19:21:01 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::9d) by PH0P220CA0015.outlook.office365.com
 (2603:10b6:510:d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 19:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 19:21:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 11:20:39 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 11:20:38 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 11:20:37 -0800
Date: Fri, 6 Mar 2026 11:20:35 -0800
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
Message-ID: <aaspAx9NiXmtRg11@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306130202.GG1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 602cadaa-9490-4b3d-8f4d-08de7bb58046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	tNoka7gthzsmEzhThlyw9lmPGms5a68FzeF8KiiIyDuthFnMKGLXAYOEwr7c0jGU+tMfXmZT/9/EQ9xhsbkq7j+H4BXpcKIcvVSEhuu/Gc2otC8P883byWPOYKy7YMZCiUbcySR0OT02ZFCJgb4qlPkWWXA4N22HpVcL4gi9Eymc+Vt7IFxzmh8zK1Wl2fnYLq4qJc+TRlk/381RpE1DTmcphomu4qIUlIstQHZyfTnaP/mdY465q/RVUyY2RyYHU6WaxbkAZ6hJTBk7exHlXlAR5DYNzW8LQljhT8uTDuUPvEVal47t0ufzdZOi22wfngsSrKvpYrGhnltbMGM01gJDZ16rhJWr+GAs2zIzP8NENQG25fwnebOoLl43E/9NSxuW0SzZtte05CTQ9XGRBgESlXR5COHZ+TsUXFGboQCOhg3Dh2DwIl9QqZhyxbf5vwOBDaUAEOHVhepUvulMO3ie35uqQ0rG7gsEB3lr0rc0lkSwZsUbkM4+N+yGodE5QnsC9YFP19DyMJcwxDZAamWXGK1X7+t/+wCI0abB2gQBJACUR44P19FZy/foyODmkjfMr/KL7X3zeJ5il+xjnojzZEM6XBYK3XE++FgGxCcIWaQuj83mxbaDroCJKrFoJNBOJMiNSWCAHa5Op/ZGmMUhEWDUFU4Q8JWz6aaPNfSmIfLc1K+o1C5kN4qI+xWpEMen9II1ASeCR4iGnoifsBT3E1dvcbc59hjOAjRFJP9gbEeGsqbYAJVMlHPRSKwtK/H3McZyvEXlDGBzwsG3XQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4pvoQ4n6p+EUYi73QiVl4W1DGiEFhM4I2T3JaqtgmQFAFH/4LLw9Hh7Ud6kuvPZxvRokxfxGHJ1Ko7JnH2cCd2Rt49g0rqM2XonDKqg/oWKWHm52UQkuDe16OtIl2s3ptBuykbz1WtUNg9njwaBfSR6xgyvkf4OR4i+UJa0HEyLQOwiDsA2YxbScGsAeDFGOV/v4sTEyw4X8MBtJwDSqd/MxdgyQpBTpDXc9Qb0j0gNiZZTX8wCda0V5qJCtOtNrbND+yW3AgJ4GYWCzJYI59to8KAJHtBnPS3iVAsBByJokisgt8IPB+CSR8RnPbvdSlL/mAxhEGVTdtEXRNbZmM/BJeLTcK0mvDfOkeEB98jSZeCknS1HdjPFPoDXvhFljFRNLGIs/FjzrbbiFVbm5D3OH6DFkxbdSbxokFCWPrWqEpMTwqTHueoIypzOF1Z1r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:21:00.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602cadaa-9490-4b3d-8f4d-08de7bb58046
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Rspamd-Queue-Id: 091E5227020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21501-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > 
> > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > are also matched. Actually, at this point that NOP ISR has already
> > > > finished.
> > > 
> > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > something, but if it works replacing the NOP with flush sounds fairly
> > > appealing - though can you do a single WORD edit to the STE that will
> > > block translated requests? Zero EATS?
> > 
> > Yea. I can give that a try.
> 
> This also really needs to go after the invalidation changes because it
> is feasible to also edit the lockless RCU invalidation list from the
> ISR and disable the ATC for the failed device too.

Yea, it is likely something that we have to do to deduplicate new
ATC timeouts triggering another reset.

In general, the maximum users count of an INV_TYPE_ATS would be 1.
So, an unref() would be sufficient to mute it, though it'd require
the unref() API to support a mismatched users counter, because the
PCI reset in the WQ would block ATS, which would try to unref the
removed command once again.

Thanks
Nicolin

