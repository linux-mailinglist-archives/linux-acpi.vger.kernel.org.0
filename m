Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEF3A1CE1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhFISmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 14:42:23 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:35052
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhFISmW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Jun 2021 14:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtd7DLSZjCI9O87unTVZ/iIbk+RLvc2IRXwe3L0niic8KvFQH/lUUXfW522lTcr2ozOzmC9QGSvYMUqC4Blxngu5Zbd3GAWA6+BmXKPFVGnk1nwvoBAXjWvUHCgr+c5GDB0Ymm43AawJB04XLJGXKF0K0sd8ePu4pfDTUMSaMkbSJgpwCaHWVSYpsEne0d1mSD4dXFRwEKpoWF3CBHadiy05e1EbBHx2zQTfY0cTiHwTrTuPAVjFoGl1CZhZGCujuz074VQZTijWPaglNIAVASoUUUzGKlpiQULBhy97k3EhJCk245+P9vDdmQwDO+R8s8glmbqN5MtVNosbtvWPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypvCnyUd5RBQKL9dZApil9tzBsSW1lIFZ6RG94ym65I=;
 b=I+Vi9WtvuOXV5ymcG6Z8V1IvLMAXoollHEuyrpf+RwKihPonzF6oACKRdv25byk07TRICJ7R1PxoNoSg04A7/a1IauYPFwVq+EK5UX8/+KAOAoXNTTum1NI4MTX228293qPVKrm6zyOjZ8PXAijry7IE4bjzM4IaOk5edUgtXuBgAtZ2Z86L0hOFlsFd6ht6Qu56cefOysMdN+Uwhv9tEw1MPxHD6QEw5LoIifcl/QVeFDB8OgcjrA8cJZ3A7feu5SsLc4rU06TlIn2tKnHkB5CU6G2Gbm43AeHB4Gas+AKqCKwbuzG+8M6A6rueuBebp3801qTlYgY+KQanaT2rfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypvCnyUd5RBQKL9dZApil9tzBsSW1lIFZ6RG94ym65I=;
 b=zNSjkvByrVAz4XiWM+tJb3oI3qNnG6sNpmFxM4py4B8cDzQ6UCpKVDbPDSnZBQ9p5hjKf1sjP41VuOAuYJ78ZN3ApxIy1iYrMzfPXfY/+cJmVyoNA3htcTNbwMRB3wBBx/Rm57U0IkjHFQmdKAqmp3mXxzMAzK2prX3nFecci2Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 18:40:25 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 18:40:25 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v8 1/2] ACPI: Check StorageD3Enable _DSD property in ACPI code
Date:   Wed,  9 Jun 2021 13:40:17 -0500
Message-Id: <20210609184018.26017-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by SA9PR13CA0168.namprd13.prod.outlook.com (2603:10b6:806:28::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 9 Jun 2021 18:40:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78896174-605b-4a90-1b6b-08d92b760bcd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB251230D01E00C538EDC646C5E2369@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53S1OgzptM+UVoYJSU3AjPvcB2vEnzNHj0lfJ2EgsYfq4MswIUJ1c/65x5D5Kk4IAmflocWTEqXZ6jPNIdeksFTXStUBjagDV3SuaB5AlQnneKbzzViGaww5aksGlQJs9B45SGV+Pa9uap7gifhxAFfIebZh9jSRvVrkIsxuThQvj6ArXh24TYEpjXP6+lOkpoP9KbBn0H8ep0MyTRuHDrzfhyKEFCsDY+7w6cElN4ALI33DLTgrjzwgQhI7mT9RPIJ6W6tKIY0hC+V0obdWhRKuydY0a7994cv4CFs41fy+hf//2otUxhSBVt38GvRIgLQ2IufiFiNN1xYNd/viC/idDEdLMqgMHWtvFgG5Xr4JwwuAsqo37UJynmtYEganr43aeZhYkZBUjUggJRn15kPcBCJ8yemL0UIcGL5HpZloJOyY3KDva/KoucNd5o+4OYm4SjlT8MY2RZOTqebJIRqX9pOCs54lSUCvfgL7oh4a35OySZas+WoW1OsDHEBkLZ7yD44Hg3rESNqCMLYzj6wuxvH2B81OjAQqT4eUupKA3P4X3OeQLdQbNM4xoI1JW6WjLBcr71b1rr7x7IbDqmN9zavubs0L5zSrcZvIPU9x8q+jKae4hOuXtgHWYpEE9Ka9QkxZduAICvCyLDULEr0yvrEx498FaW2QZMg2hcLBHAYloxBaC9D/NtFdkQX06lSTeqFS2oZZ2lNDd9Ywqk7QPI1buHLqAdUhYFyzmnSUdZgjg7fU9XnR4Rm752NPbsM+boJlc0FAMfvTMvlFtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(66476007)(66556008)(66946007)(5660300002)(8676002)(54906003)(316002)(38100700002)(83380400001)(38350700002)(7696005)(6666004)(1076003)(8936002)(2616005)(52116002)(86362001)(45080400002)(956004)(6486002)(966005)(16526019)(26005)(7416002)(186003)(2906002)(4326008)(478600001)(44832011)(36756003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svyOqSJ+Kj4Mey57/WM4FJ0BCwT9wG/XBjgteff8NG4sHnMQdbezWmcCYgpH?=
 =?us-ascii?Q?evfo6hVzhD/JUiCEFqT2+rUIU5pzVcmrWqEK0VPQIFoSo882vxw6YmaIJ/FL?=
 =?us-ascii?Q?iklixIWUNzaBMYm4KqfDGdBcrUhlifnGlFINGKOQSY3ye/BfQimm/SpdwZ2b?=
 =?us-ascii?Q?r9onhaiZcHvOsNTe3KDbHE7nAI0caWr2Xv+DRf3D2+U2Dke4pD2blIvmOmnF?=
 =?us-ascii?Q?cdBfnryIBdvllmzUROBi0jvVhLFcF8pEwVLUIZpoYBx+8PfgjwW0ZMV/WbS5?=
 =?us-ascii?Q?ojwd8ryi5xkQFfDwSNFL6oqGgALLvM6NuAQRXMxKZF/CUHf7jJt8JTxJSl7u?=
 =?us-ascii?Q?GxB69xwIUtpBsKetU+1a87gLrm8elXUEpYismDH3rCRqeaX9FaTBANlVHtYw?=
 =?us-ascii?Q?SlJHN8wC+eVpNiYqiqVeqyADcsEb+o3U1P/qeGYVmggTix+C1UM2u8Vus4ba?=
 =?us-ascii?Q?xkUDB1hXxkQxllCyCMuo/RJF1LKZL03EcFays9JeAGWv1yWBrVjIZZGy5DRd?=
 =?us-ascii?Q?ptgqDBhTZIBBRZIXFjqV1NQv0WQbWu3wpMmfafpB9wQuPWLxl7r6NHpddIhy?=
 =?us-ascii?Q?XRQlo4vvkCXJ7RUfOZvAW8oxhMvUQZq2qD2+VPxbeYk8dBkl1TttCcUld9bD?=
 =?us-ascii?Q?tT2M+0mg5fwfko75sVjnwBrws+xJ47dxuB+/Q443khIwDhlYBluM25S7Fkxn?=
 =?us-ascii?Q?yBLdg8FiTQEf/mJW8SxQCS2Je3EGY5fOUhoX+ULfdzmJLC60jtHYkvF1vLV3?=
 =?us-ascii?Q?5c7Ou5PmZJaFhO5OmiWF5nUJLsXZG6l7wcNqoZfl2ohHnzbSu5cQ/4BDTNLl?=
 =?us-ascii?Q?WiA6FjRPQjzIv/0e/sxbEjV53/hgPTMQvDy5lFe51lGGmbD12FVwlYP53kQZ?=
 =?us-ascii?Q?n/WxXRzN0UBMfinZXpGDCNwHqlo0Cea0wnhV3SJrHVFAy8x0TB484jrIoYPh?=
 =?us-ascii?Q?8HjjLk0N9N9fpvmycJBqE45qy1wZji1km3slQaQroY3igKc0ir2H1QrooPOw?=
 =?us-ascii?Q?4R0Rf9KAZBBOyYhZnO1Asj9MBQ53eu25EpiCGhtvUUUcwrdCrZbWJWuDCYbT?=
 =?us-ascii?Q?MnPYD/dldMAPmTywKQ1WT8KK0n2I4D7lUBFd3J32DeVIWem9q4TgwnUJ4nYy?=
 =?us-ascii?Q?cm314LzjXn5W7QEpHNYIsDhTMfaS8xQp19V6vaVe3epz//uSQqce67owhvWI?=
 =?us-ascii?Q?AUMr5jd+xi/WqC9T/ANl0CabABipIe3rVAk5ADMmxShbG/0bDthtV8lZY2Ow?=
 =?us-ascii?Q?GQExAfmHrQANiRQPqJobL9IZchYNfk2/VU7PEYl714FM8PXwJ87KMbgEVRas?=
 =?us-ascii?Q?drxSaXs/FEkvH53YtxwYM75r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78896174-605b-4a90-1b6b-08d92b760bcd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 18:40:25.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgHO0E6nTt77JWIC7S/E/0xQEaWtZkKVe3+gcT1cuO/p0zk2FQZnf51r4ZKXqAlJ5EVlcaS98t5C7FX/DEDu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Although first implemented for NVME, this check may be usable by
other drivers as well. Microsoft's specification explicitly mentions
that is may be usable by SATA and AHCI devices.  Google also indicates
that they have used this with SDHCI in a downstream kernel tree that
a user can plug a storage device into.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Keith Busch <kbusch@kernel.org>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c | 29 +++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 35 insertions(+), 27 deletions(-)

Changes from v4->v5:
 * Correct extra "Link:" word in commit message
Changes from v5->v6:
 * Add in commit message tags from Raul, Rafael and Keith
Changes from v6->v7:
 * Update kerneldoc comments per suggestsions.
 * Drop all Acked/Reviewed tags
Changes from v7->v8
 * Add Rafael's tag and corrections for title and doc
 * Add in comment requested by Christoph for non-storage to kernel-doc
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..c8600978b283 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,33 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if D3 should be used in the suspend path
+ * @dev: Device to check
+ *
+ * Return %true if the platform firmware wants @dev to be programmed
+ * into D3hot or D3cold (if supported) in the suspend path, or %false
+ * when there is no specific preference. On some platforms, if this
+ * hint is ignored, @dev may remain unresponsive after suspending the
+ * platform as a whole.
+ *
+ * Although the property has storage in the name it actually is
+ * applied to the PCIe slot and plugging in a non-storage device the
+ * same platform restrictions will likely apply.
+ */
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..8fbc4c87a0d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..dd0dafd21e33 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.25.1

