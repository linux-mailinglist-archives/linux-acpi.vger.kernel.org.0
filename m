Return-Path: <linux-acpi+bounces-21509-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s9OeBrQ2q2mBbAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21509-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:19:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADEC227705
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24D630474FC
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED53A7F69;
	Fri,  6 Mar 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6QEx1Q4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE17259C84;
	Fri,  6 Mar 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828336; cv=fail; b=CED/40sj6zAsGp9wDg0agI+Mp6EZXamPUHnAXgBoogytC6qWB6BbsgO3SEBVyy2ahQaK+eoeVVVi8kIVytOSDjWXFpSX4S6qg0EGHZIWz/5Z1mrZVsG/psMXzK/wLcb7CnFxiDKiuJNMCz7DdVj3Yd3M0wgQfn83K9wSDG6uLmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828336; c=relaxed/simple;
	bh=X+2aIw/WQ47/BEBk/Sha6dZODVlQw7vue4eEUxYLA3M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQXnYhCkp331MBqY/3T4Ufx/mimZWKiNgKgmhEQKCttjQ8+8PyJ8CwV19hMt+77mfZwBIK+edmStGujumLCH4buQPXBFXZy6L5T11VBX+/6E1M1Gh73deB2C2499ZVUKIQzvOq6kRcChK/HsaotMbZ2hvz+j27E6Pkps8xLahyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6QEx1Q4; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIDJtyeFXlMbtX30BxMLI+733IP6U8nv6ipCRDMRvFXbwlPZVLLuyg0hH2J/sstmJ3n0I3FuPM+C+LZX6sjye1PaRWj0VlZTeee5DsXrk3WVRYzLNzRcsGRceZcWVtOlJg25qBqsGz5nyaWzdttxogBjzM3JtK9/nVgwfyQt8mkvSZo3AB/KsAQJpMSjRzOhjr0VKvVT9MaOJwyiET3LR5CshuGYIJjDl3J9rDqnw1G54F9omurv7htr1BxY9PcTuZSV9FWs2/CHmOrlXWeUXgZgP+MQl8FO/gSiPK+AnnKmnYQu0cmRKQRG6mjtj76HbsaZK+9OjF1kBsGh8jMsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wQRgVzOHKbSno0+gTSSZ1eLOZzfc5dxI+Csjpl5omQ=;
 b=ABeTufe38vF1G+laoujnr+PYUEH9uVF8iYoMF5tJd9x+uUoIw5meqFnr5sZuRDOMYxvULQXfK9dJJCcQw79PcvOHE4cMhzDymQkFE+DJXIw7W6zEOsmRwY2F9Aee0wk5hbvN+8Akty6+NRr3/iYYSHKF48C74Jpv/MMIvgUxEM189ztwd5RnV04o+2iJwQbMWPR05Vs6df1jMWT5ojAzSIEocUFhRelzejfm97ufKM6JYHh6RZV9uWRAKCDFqcVUvDliqoDrjtkroEVAKqqMPQ+imISpxBpi7M775duIOvLyfGGNej/gRbG1DA5xlaNI3Tq+G83e3wgZnQHQnlwMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wQRgVzOHKbSno0+gTSSZ1eLOZzfc5dxI+Csjpl5omQ=;
 b=L6QEx1Q4WMETqK4J+WPkbXDdDFu6bv4C2RbkY5F7pINoKVGHi+Mp7lPpi2UeU+rrydhZTblRw3wmSx6n7wV2OvSLnFR79LmglepWnXxUXGfhEiJ7BRLW7G0dkUknVeoxuJLMeG6IVZoivqp0b55d8+AulExcesgCisAWJYo/zyijIYUyudk1dAPhsa9kDeHCfUFu0w2HxwEES7l7iy9xy4GR9NyZ5wya+w/jd6FRdVQABHC+wYdbbavZ299crZ4S4ikd5Hr0a6e0eeIggzs10y23fxBezVpw871I9lkx0VwlaNdbBmxVJaTIry24uUU9xikjpT+fGHp0NAv0KaXIOQ==
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 20:18:48 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::dc) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 20:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 20:18:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 12:18:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 12:18:26 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 12:18:25 -0800
Date: Fri, 6 Mar 2026 12:18:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<praan@google.com>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <Alexander.Grest@microsoft.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aas2kHcjJPYFbKSD@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
 <20260306140115.GH1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306140115.GH1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d62d8b-bf8c-4e84-14b2-08de7bbd9315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	9ZBg86uxa+qzYxOFgFi/iX02Z2CB/snhBlTAk5CZkojXZgYzRhGTgIAwcQ44xYZKQpzoIyBoV4XOCbGau2iL2O8/beT5pSYvKw2hkOPMz2ADnb7Y/O+nOhwTWg5MR7R5vFZLbnEMNccAZFfLvqDrsuYU1Rc7VeOLW+7Jyz808mxlTWNjsuXF7jCGudHpa/vbhk0xgsODHKNU064YSYNXQYpYYA8811KadKOy103p4UvkktBg5bPW0QrxJ2z/GRjPbns6fZLf9kZXTXWIxCgfR8SMOfPyBQFY4i2+EvcRS4ApkIwvA2U10b6ln9AqIX3w+YpqWfbqw6e0Oeqd3tSDP28Zzhey8hZ3dXFjWCVEvOZKmT9I3LeO4kpdO8k6Guff2G3NpFiQP6bBOBg2nKko8v/4J/W+xAbq3Mt6uIlCBflb+5Cz1kjGskCFgnhDGb10rl9V6j+t6eEKqBIhag53aFIXi/lJj/taHEdvIaFwht2laAFRCMLr5SGP+ZqZVXEUrNrWkxAu+o/7ybc7lENorGJ371W3qflHgmhWCnl8kotRHHeBDp8Ye3oTsDxq3mvO9xNh+pwmKzgBj6AMmX5YDT3r3rDsN79utecczgLdg+Gy6865cVyj4t6oRgr8FTFH5xVQYywy2lnoVERkunZfGsLOcY6pJGnQIW6F6/QB/EiTs+P+S1cYo2/0hjq60PWex4bdUtf4Q1BYj7i0fu6L4j4eP3IQ4mcDNJr6tMTqAp7werX5CUFmK54pqR2ObsVf65jiXH3t9KVJYGcAoO6NZw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uWEm9Fw9p3E8tGgi1yaPJHl4SnAd02EwdNKbbdTrjXtQ5QGUJh+2qjIbCXI6sONF69q5epdZnhXuq2hQ8KohDXGYzh6cVpWratTlAyuEdY+noYXQbtB0Sb5wr+hmznPVdE+pAOlFQ2Th5w8tEBjdadBrrsp4vEqxhn6u4eah/ZLS1LwPYE9doqYV7uQuBxNo/HUrny99MtFuw+OJQMb7a4jBgZ3QulK06hErTUCZLHUNHIXzoXNIh51HsbHy4ZmQQPW0DabwHdIoP6TXJon+iZ+Nhxqbsqg77ZMsWNd6dtWSVNTMmrhTAsNjgwk+iYni4N13qfi20i6L3hdmlar32NTpwdCXIY0QVyX+bhpnMSh8TV5MnJkSkgHiEpdjegkAdigqhcy1aeSvljbIcR4MA8rFE2FP8WKq8qEiX12rCeoMlHsuZEUas4vIqN535zgK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 20:18:47.7864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d62d8b-bf8c-4e84-14b2-08de7bbd9315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160
X-Rspamd-Queue-Id: 5ADEC227705
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21509-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 10:01:15AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2026 at 01:22:11PM +0000, Robin Murphy wrote:
> > On 2026-03-05 11:41 pm, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 01:15:45PM -0800, Nicolin Chen wrote:
> > > 
> > > > You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
> > > > out ATC command?
> > > 
> > > Yes, it was my off hand thought.
> > > 
> > > > So my test case was to trigger a device fault followed by an ATC
> > > > command. But, I found that the ATC command submission returned 0
> > > > while only the ISR received:
> > > >      CMDQ error (cons 0x03000003): ATC invalidate timeout
> > > >      arm_smmu_debugfs_atc_write: ATC_INV ret=0
> > > > 
> > > > It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
> > > > thread?
> > > 
> > > I didn't look, but I thought the CMDQ stops on the ATC invalidation,
> > > flags the error and the ISR NOP's the failing CMDQ entry and restarts
> > > it to resume the thread? Is that something else?
> > > 
> > > If so you could insert the STE flush instead of a NOP
> > 
> > Nope, sadly the timeout is asynchronous, and CERROR_ATC_INV_SYNC is only
> > reported on the *next* CMD_SYNC - it can't even tell us which CMD_ATC_INV(s)
> > had a problem.
> 
> !! That's a good point! The new invalidation code runs many ATC
> invalidations under one sync to optimize for SVA performance so we
> have no idea what devices need to be reset :(
> 
> So we really do need to signal to the issuing thread and it will have
> to go back and check how many ATC invalidations are under this sync
> and re-issue one by one to isolate the error then issue the STE change
> and sync. Nothing from an ISR then..

IIUIC, we would have two timeouts to identify the device(s), so we
wouldn't need to give away the optimization of batching ATCI cmds?

Will letting a faulty device time out once again give it a window
to corrupt the memory?

Thanks
Nicolin

