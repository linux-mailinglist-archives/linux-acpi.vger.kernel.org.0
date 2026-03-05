Return-Path: <linux-acpi+bounces-21389-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBJ1OocTqWlz1AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21389-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:24:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE020AFCC
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5991E3085C30
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 05:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96692566E9;
	Thu,  5 Mar 2026 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAzSBqhe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8502853F8;
	Thu,  5 Mar 2026 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772688133; cv=fail; b=aCzggvptW8mrX4Bz7s9WWOcxuoHIroMDbu0xKmsz4A42RI15KP3aECWsSAwVJuae5N2kRYGn5WPzk/Eh6LHXVqtuXz08D4FBUrp7Iqc1FFCaoYk6f8CPEw33t1hPk4kveNGZZuIds5gY9ICAbZba0Ohw6/hp2jbf8QtWEJlAO3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772688133; c=relaxed/simple;
	bh=bh32dXGjPEWhBozn9GCcJtB6VCN9xBzmOm/XGg5WIYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEsBDqZPBTGZPmYDpp+nFKoSEE8iQ8iAumxhefKuCYKvrdj1Ld7GiJfOmLd+dTnwCoCZ2pKkBwdOkBlWS+ELvRVacgNUcLZK9c9O3Y09iNUCjeXB6P2Xj3Qis7I8MgN6T/gn2EAC1dr8YfllpDaocV5NIBcXrKD2dlkhNbt54OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAzSBqhe; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0/kfwLQrol0VN/uVOKjJM6Crx6KKV5ofyiKcngMY99w1kVIRtliztSq03C0fse4BwZ5utBj8qO0hgQkeucfGUfjKI1aCHSL7k2Bl3zb4LRIijd9KR2hxNOwlC1dTF2rGTZPE69NpymMXzfYv2wAJxTG5rXH4bG/JmVh9Om3brq5Zp2JWId21UKqljfkHmW7UJGP1eM2QVX8CSeZ66QN2WfjxEiDlSd2E3a1gi7uyYxvo+g8UnFoQEryf2og5qekOcffOtqYAw2Fj2ipOfrrjmFLpI8Dt7/8gbDKR6D2jQgeEyuBZw/aPeRX2JlXHMDL51mb0MaTukBDSBn+h2ymHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxMuxiDczSb3OpLj4w14joC17x7U5ue3KuL/gAuIzwE=;
 b=N3F/jKA0zwGRWRjWoFHIBQOsrk+X5a4k/88YfAPiA0CnYjd4Mahx9NPqi3gJzSiy/fHVi9Ax3j321BENADdC1gXupkJYH/WlwqGto8/tiSqBaTxNBgTYCrPvTs2pI2Wu7Sivgd2up9AjlhRI/c0iQl4dASsOaMIvMp5M2wlEFEfZws0FiK2coMoHfqmOjRx8BeAxUbntYPLnIahbnXb5Jt6ubnwF/lplpKLZoKzpzJ5H2MYxq6sbDVWBOodWTb+zh8YOCxwSeMcZVL9n5R2BcTxIDVc04gq9X6esDzRfD1uScTaIqWjOSCKYTs4Ds+bo2jIQSi4r3A/M4CSvgBovhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxMuxiDczSb3OpLj4w14joC17x7U5ue3KuL/gAuIzwE=;
 b=YAzSBqhe5hoV9AMh5GwnooLQgzWhUiHbhi+L7DekIaBHxXqdn8zdBoDvOK6DKrc2r3fCHRqkaufM93plcTToIqGcawjVF+7/2+2n1tJgh+CtUJ83E/wFLeO/ry5/QVUkrvwOcKdtzgXr+3LIUqhwlFRUo3Y7a2Fm4MmOR7OxFfOGs6y7dKULve+7f6ng/Byz05vWE9/YneLVJ0LaRdxpoWzKFwIEsmdB6QBHUKXH8Jv/OTjO3M2o1lVi64rYCy7t8zTIpArWok6PuJj+VtDCoOFyTkdBVFIdO3vZKNwBudv9V/RG1Zu0Wl8qb2PwvKoVNWOjmL1eqaiaOS4oxAKCYw==
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 05:22:05 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::38) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Thu,
 5 Mar 2026 05:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 05:22:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 21:21:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Mar 2026 21:21:54 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 21:21:53 -0800
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
Subject: [PATCH v1 1/2] iommu: Do not call pci_dev_reset_iommu_done() unless reset succeeds
Date: Wed, 4 Mar 2026 21:21:41 -0800
Message-ID: <58e6266a89ad7855ef0658b2a2bb1f4ee4119e23.1772686998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772686998.git.nicolinc@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: f6490c58-961e-409e-3aba-08de7a7723ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	bDCfTox6UxiiWxtucZ4gn0/IO/DrAYKepyCFEXI0YGVVqI4nLolRISkL9I2i7XkaBHQ5WHbuz0bmaFCG/tXREu1a1XjgoK9VxoqjLYS5jk+WlCLonojdcC7nmnUUIZj8o16TnadrfOyrQiKLCzY7JzTfDrjyg1kKZZIZYcRJpKpWYACo1SRl3qLmWW8yC0jStPf7lYRGG4LFpqzoL4xuK0dT5HQpJ+LcIQGdoHVpIo+fk2uGUUUN9ahT+l9ibfatL0b2O4xcIR6YakZb8dmKOTe+gEpHxVLajE0xscc2jQwO6yP54sJdENAOXbdaLYuXB0T5qzN/BliwdxutVIkHgjRbIVnB/ep3VOMNQ4n12GPbtY9CHMcDM96lfOm4MzokIoWeW7x+4YEhQ1u8u/JFng6EoikXBZruTwQqJhWwgNBXD0tpFeTCFNcfxCS+VSbKYaTOnbAo4vTJzB8qR3NoV8BRiROOWAgMobHC35d6AyBggsU6n0PEekMzrhlE8Duf7ZwxKrBR1g+9y1THv5R4EWm1YYvA/GmoZqNrh8OHqlaTSNQLhf9b0crH+46Zw/YeSFUY8VcBGGNybL558syQ7o+cVNlCK0M4C8oUrCFUHYO60V8MW73wrKpHItiQwYbrf7B/w1JehKFCbyJ9WbXZ/pJ5PzPlg+e/Oo+zEot2gzxSSk+wmzTr+eBnuI7DZ/IZM7CkYByVaO7054j4TpYZybWdxQJPWiqgPUo+ITIjntPavsL0L0YEh1gl+br9XZAYSE+J1Tp0oTYi7rAS/JJ64A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hG29MThI3zxjLJodcbUbBX5qiQJiNRzXuj7xicSGKNwTt4eH/hXhhElRaT3vfbwbHyEANs11V2EbI80h/iQNwfIIQiAGtxJD1J9U45XeJlzJsGZSf4EKP9F1QwuDO7AGUlkgPz/A2r6qjkBdOhqshriKy4tmuNyc8JYeiPlp7QOVDmSJQN1ESqOAsl4KTSjjit9En6EGKlRsb7AM2EFx+wK2Y78Myp7eNOiCWHJysHgX6WbjbgB8pSmFsLThCZPMYdWaqj4rzMYE5QlFdatsa+hqEsDNOToZRnsxZ7jaf5syRfROx6BKLfzKOPy2OYwgv6I5N/yHRckJeGpalfl5v0p5olmOH/4tOG42vJXVL/p3csNxcFf0el4eUAr/MH/xhLxf/WwT0gBoKG3mWZlu1Xpy4tT30EMu/mzLKTr25/B3Mj/ZfaquWi8prEjDoksi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:22:05.3132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6490c58-961e-409e-3aba-08de7a7723ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
X-Rspamd-Queue-Id: 7FCE020AFCC
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
	TAGGED_FROM(0.00)[bounces-21389-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
errors (e.g., ATC invalidation request timeout), which are typically sent
to the driver's ISR. To recover from such errors, the driver would need to
initiate a device reset procedure (I/O waiting) in an asynchronous thread.

If somehow the reset procedure fails, the ATC will be out of sync with the
OS, since the memory is already unmmaped and could be even re-assigned. In
this case, the device must be kept in the resetting domain, to prevent any
memory corruption.

Yet, currently pci_dev_reset_iommu_done() is called unconditionally:
    IOMMU recovery thread():
        pci_reset_function():
            pci_dev_reset_iommu_prepare(); // Block RID/ATS
	    __reset(); // Failed (ATC is still stale)
            pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)

The simplest fix is to use pci_dev_reset_iommu_done() only on a successful
reset:
    IOMMU recovery thread():
        pci_reset_function():
            pci_dev_reset_iommu_prepare(); // Block RID/ATS
	    if (!__reset())
                pci_dev_reset_iommu_done(); // Unblock RID/ATS
            else
                // keep the device blocked by IOMMU

However, this breaks the symmetric requirement of these reset APIs so that
we have to allow a re-entry to pass a second reset attempt:
    IOMMU recovery thread():
        pci_reset_function():
            pci_dev_reset_iommu_prepare(); // Block RID/ATS
	    __reset(); // Failed (ATC is still stale)
            // Keep the device blocked by IOMMU
    ...
    Another thread():
        pci_reset_function():
            pci_dev_reset_iommu_prepare(); // Re-entry (!)

Update the function kdocs and all the existing callers to only unblock ATS
when the reset succeeds. Drop the WARN_ON in pci_dev_reset_iommu_prepare()
to allow re-entries.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c  | 16 +++++++++-----
 drivers/pci/pci-acpi.c | 11 +++++++++-
 drivers/pci/pci.c      | 50 +++++++++++++++++++++++++++++++++++++-----
 drivers/pci/quirks.c   | 11 +++++++++-
 4 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..40a15c9360bd1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3938,8 +3938,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * IOMMU activity while leaving the group->domain pointer intact. Later when the
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
- * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to unset the resetting_domain.
+ * Caller must use pci_dev_reset_iommu_done() after a successful PCI-level reset
+ * to unset the resetting_domain. If the reset fails, caller can choose to keep
+ * the device in the resetting_domain to protect system memory using IOMMU from
+ * any bad ATS.
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -3961,9 +3963,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
-		return -EBUSY;
+	/* Already prepared */
+	if (group->resetting_domain)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
@@ -4001,7 +4003,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * re-attaching all RID/PASID of the device's back to the domains retained in
  * the core-level structure.
  *
- * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
+ * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller should
+ * use it on a successful PCI-level reset. Otherwise, it's suggested for caller
+ * to keep the device in the resetting_domain to protect system memory.
  *
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695b..f1a918938242c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -16,6 +16,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ats.h>
 #include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
@@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1..80c5cf6eeebdc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4358,7 +4358,15 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4436,7 +4444,15 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
@@ -4490,7 +4506,15 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
@@ -4933,7 +4957,15 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!rc || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return rc;
 }
 
@@ -4978,7 +5010,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!rc || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..d9a03a7772916 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -30,6 +30,7 @@
 #include <linux/ktime.h>
 #include <linux/mm.h>
 #include <linux/nvme.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -4269,7 +4270,15 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
-- 
2.43.0


