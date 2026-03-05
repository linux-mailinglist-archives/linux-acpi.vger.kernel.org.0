Return-Path: <linux-acpi+bounces-21388-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M2XMG4TqWlz1AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21388-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:23:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012520AFB5
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A54C306BD14
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3F238C15;
	Thu,  5 Mar 2026 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4unAH41"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8D1E5702;
	Thu,  5 Mar 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772688131; cv=fail; b=kXlts5rDdgNRwxvyHUKR+T0f8HHYmPCba5X47PWlGHsQj8S0xY3HLV1tQvsYDDkfYa5kRK9CSxSMOQmmiivIVSIvUsa06XJP4WIDnUE0h6558Ew19My3oORbPNK3pzOV2STkDHlwiGt+ziLvvyMaontWzsjYjs3+6tpW2TbeuLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772688131; c=relaxed/simple;
	bh=VRWLvZNRZEcqsRBWEW9Kh4yuEmAapULWRK9aYXzWqtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVA87jspzIuHYSmWC2LItB28VAqpJaRcTRYU0zrJa6uLIjNrhR1M/NbiT8Wy5CzwW8YmlntDkMp11ZquffMmROd0sKRh/bv2ChJI0wbE6vhzaAC3DVq2b9TaYdWa9yBeTZMzob0gF1KLlSk5bdnBhA/E32nCTOe8wyUeCN6ewsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4unAH41; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzpOEhyyqwMfQ9w1nIQ/nKOdfZsOg2AEmEVWGfX4XpHXBPXMFRasr4G65qwH1vuFYKOANXe3/z6+rt+0POilK7m8Aw8t+WMQbUXIcmL2ZklCdyj+CUhzcE1OjZpbduvbRzSrvNfgIpkOTj83TqmgR62uJLj4Vi0OHxCtYCFGcBQ0ADDqWmo4QddCMBMj1ofSUebJSF43fHFScdcNP1VLxoVNHtljyUvMQfQz7NE7hGdl7yP4g8agaaKQT9Ykg3Bvl6zhhGSPd7EZ1PaIXJBtFNBsXy5vWS+ixpEGqZKRn+CVkQEZzMcEZtf/An1FaxmVv1CpmZ6x2scVoKkwsgio9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y70xyM5tXA5BYDzHXr8NorW9AN9vXnKx4U/1Km81XMQ=;
 b=myPRt+mc9NhcKNhOlgT46i2Z91ndo+eC5SGIT+FN6c3GSEkK2uZzt27vukawgCi6pxbPjpxOlWlbJmEa3HKiMq9w1uYdEHCiqXZqXxUOBf9TYvNd6WjRaIYqmZDz1I8+TpGiH4LTuG8zWDY6pc+mbPwk67kz4WTqiYHmFyFltdky0pdGsgO2bPnOmhptjZnTUJigPyrxUHx/qCAN5M4fNSQQMywkH1QqvlDcoM2qO5x5ytRldon6ECpvVb9OzL6B6DPkOXG46DC07oDq5T8JIA+4Fru0LbXdb//kZyDsHTnF9IXsQFdy+vLFuKXpND2GIO+JsZT1HYA+3Xj+5tOFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y70xyM5tXA5BYDzHXr8NorW9AN9vXnKx4U/1Km81XMQ=;
 b=k4unAH414jnltBqNBYn2XGIb9hjzX5yW2TZGfXo1hl724Kv5lR4i+XmlJmNSGqAyt1wM0w39heuGqED+73ZMRnV0WkI3fiIGlvNtMA9KAQe70y3AygWim9vIKeyh4YM7A0RAIC0l7QhaWNjG16F5/AigoWyfoCCK0q43lfEe2oX99F+F8z9p5mOVKxJ836pcFfxPbSMPwW/GMsHNtrKsUdcxMEv0xZSkkXei1M2/3JK5SqUJ34hvTV4/ScFBZXlRdhshzmV5Nht4cMRfTu2HWFmnDCb1e0q4pC0pn2GL/Kn6WOz/Vv7ORdrejAdfytIe8MTUfHSNTTrmley+IxHUUw==
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 05:22:02 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c9) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 05:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 05:22:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 21:21:53 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Mar 2026 21:21:53 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 21:21:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<kees@kernel.org>, <baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<Alexander.Grest@microsoft.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v1 0/2] iommu/arm-smmu-v3: Reset PCI device upon ATC invalidate timeout
Date: Wed, 4 Mar 2026 21:21:40 -0800
Message-ID: <cover.1772686998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 88257ebc-303b-4548-d1aa-08de7a7721d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	B+O/CNL8vvpi9AczZCSTSUpXK0qZpbHFmravMw9M4Al84hHYYx2Tw+hfmoec7g4+pR7xog6INNDzdrS0+x72Bvj6TK55GcwlQeL1bEuzQa3WdH92fZK5t/6LBFk5g5Feugokq7A00C10U13FjqnEsmeOTIRYDdN6dxz0qc0w+08YeNl6yvtntovI0BKhKRvqmRTCeCujP/dCp3RfznS1zt95wQ8RT+crJUaZGokq8FtOgx+pVbKuHhYPvF45+XJ3ZwfVC3rvBbk+cn/BW2xaFqW5D0xHPhHFy3uySWHLpgOMQUrruLFTD1Kqw92nG5aigIegORsHffdLBWVl+0RkA/Kv1ZsJRO39gmG4dfxvwAm2dNzDQnw1GUeUy57dtJv5fwT28bsTn3+86KdJRxs1N8pQttrM79934CuGzm9tmSsHQBaOtUDlFfFvxtZaqCP6pakVvS3POsIX6t9KFWiVlfCpTCNRa9p0+Y3EipmhCRBqkE91ndpwgSOx4BBKQwqKtt6Tn3ouo37lUXoUfRy3Qj54Gln6neSWXP5E/3IyAAJ7b9PBK5Zvk8Q7A3RzgfF5Ssca+gwCUN55UyjQrb7fU8wAFpt1j2NFGp1EdWzlby8RLlWsdLV1+Y/Lmz24xbH6Iskrkkg4ROxHuJC/oi3Rk9D9NeMCyI2naS1+la2cU+MvmZNUfgGVvQgquvWpmDwNkSE5kfnKndvm23FCjBZ2uFdSY1JfCfz3KABk07V+aqzi2RRyXBuXsLJdyavv85CQrBDgt8sxQbtXWRjoOQ7hbA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oy2kY0ysyi1ZBEtdLbSR2BIq1oTZAZj4I3N+Juj7DLdgFP6+mau2uCDoK7ysNOKQnf8Wdft/ncc+TjRLXlIZv9wpFVCc6HyjxTjkUNVjftLk7JNvl6Fg8CbvXQ1rDrBtp06Na1TcWIiwvYj+q5vmOHuckT3Odu1dGTKgn4J8gUmjE9QUZq7B4ndbykKyfSqMQOWIw87imEBGDlveNjNB9r8r47/L7cy/1cJaD2EqL7OORRe2rcppVn0KmMNg7V2vGo+4Yh17O/c35QaReasqYB1rSrwJTCsNmXqaR5uxLfVv207Ij7xneumW2vDq/tabLDFTG83IHLDwbFMbcVbps341eeNibtLUBg2DEDEitfwKLkYCN4Yeb2sqy90qtNzgyOpJNgX3mzb2rgFxXWbcKYhQPxX4fmryTBNuLgZ/AfwMNAke9XcRYTg+jbWMcB3n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:22:02.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88257ebc-303b-4548-d1aa-08de7a7721d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Rspamd-Queue-Id: 5012520AFB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21388-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This is a small series to handle ATC invalidate timeout in the CMDQ Error
handler. When the ATC is out of sync, the device might corrupt the memory
due to the stale cache entries. The safest way is to reset the device for
a recovery that wipes out the ATC as well.

On the other hand, a reset attempt in the ATC recovery thread might fail,
which leaves the IOMMU driver no choice but to isolate the device.

pci_dev_reset_iommu_prepare() was introduced previously to fence the ATS
and ATC during a PCI reset. It's easy to use yet doesn't allow a re-entry
nor support the recovery very well.

In this series,
   - loosen the re-entry and block ATS if reset fails
   - add a reset routine in SMMUv3 driver

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout

Nicolin Chen (2):
  iommu: Do not call pci_dev_reset_iommu_done() unless reset succeeds
  iommu/arm-smmu-v3: Recover ATC invalidate timeouts

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   5 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 131 +++++++++++++++++++-
 drivers/iommu/iommu.c                       |  16 ++-
 drivers/pci/pci-acpi.c                      |  11 +-
 drivers/pci/pci.c                           |  50 +++++++-
 drivers/pci/quirks.c                        |  11 +-
 6 files changed, 207 insertions(+), 17 deletions(-)

-- 
2.43.0


