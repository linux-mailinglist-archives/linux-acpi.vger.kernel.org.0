Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7839FB12
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHPpV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 11:45:21 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:27087
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231192AbhFHPpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 11:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STHakTLJFTpXsuiQF49q06DP0bwcW6+fyxgxRJel7Ejtfbf/SlaiA8gA8Ro0cNuyqtZo3cK99bIVI90C1RU/MTlCmYwGQF2h6M32F+0hdAuESz8unYrkuM8pgGnPvRalWgVeutvh+FRHABJyk3zUNAS8i5bScAndofV/6gAazoCyfi79VTxDNR+/O3y1mWjyfqCMxfVVCtzY8DX3MwlYFRjMRU2pN7W0qYa2rsOwvjDOcPAW/Qb2Y5gRfclYevCt+o9ss+5TxsozT16CWjNVqxwcbjkJ290SGT+jIc6+MFCSkjXgAhxju9ZGtqyukf5hceXMdrsRnr0FH+2F4RvteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzfPVorCkeSgU1msvO3JoSkWOp0y74wtXR8NKCXSfs4=;
 b=AopdCXwVLpx+ZazXf7OTpK/o6H4Xg76r5ZFMDexhbycFtezfBjRZfzKg2xlRfBCXd4LC7dWaoOIDgqASmkuux44JIF4H7o2jvdKn8hz1tbwxJVXAbic1lYNHmYqeMHScJprophmpNmAx/OLaimJWAjOn/xzXze/wApEvMaGH2oz3LHdrkXNFyqpbeywCxIESPMF6Kx+iTpKzpQcNFL0p//T/8qxKzRO4TDWZ7lE82Rs5S4IOUwrMzEeK/RnrLmB7XYR55F4omHtT+Ma/nsEamRGyxfDZMAKp0P0JR52D3/2j8Ym4+kbBl3/qvZ8ajbY8atYSIAY6KGkVKVUYm/ntRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzfPVorCkeSgU1msvO3JoSkWOp0y74wtXR8NKCXSfs4=;
 b=e2LPvU81AEEFF/918v7sutK13e0hXVGNrsJJ9A3dxbtPCg5GZj7V3y6rHswB2JQHqcqvZSiowF8IAKCA2wwpULeF2elq3XmXfY6OSx8z9QUryVOHTKjhNFyel3zpK0Z9FRsJsUZ7AWwGnAHH0Ab3z3mI5upWDWxXulHmXDPKmrA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 15:43:24 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:43:24 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 1/2] ACPI: Move check for _DSD StorageD3Enable property to acpi
Date:   Tue,  8 Jun 2021 10:42:54 -0500
Message-Id: <20210608154255.8693-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 15:43:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdfaeb91-24bc-417c-8ecb-08d92a942679
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447A05716893C554FFBF1A7E2379@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEuaiUc5ZRuQN/TLP17ycTuqjj5RiE5lyuWolWhqIarP5CqRvffDFllWX94jEZ9gpDqHyV02E6R4UBx3ekpd7a/lHmcfvYFYpbISV3s0bLVg/evMvXSnhqHwMCdC3NRD+kIv8b/c5Dosr4npE999L4mlLtAhaBqXchN4t3EAKcXEhTFa0CAS6MSJhJll8phWDsVin0YbvChC9zlsEga2sKWonlFQrIBEGQCPEX7im3kX274mzM0PUPYLU8eu1UYYn6ejBjQuuW3B4gJlneQan9C6g19C8L/nyTLGEuv9yw6+ysSJ51blBD/muLfIwS7RGv4eu+luaMReJ7ps9tFP8cj3S1DFQB1UJ6wZ6FZQ/Jv7VzoWXvhUzJg/SAYoyJ/A5kpugQaNOlYImWn4vB5QK0qBzDzQLRwTmLU4qyZIH+mIkW2jrkhu1R0Nf7KK1+kqTQzq7fV9bZd2u57VNJoVQYZ2JvyIFs7mX7kpHZuxXIzG0cFl8bKKZ+h1dbZgkN90aXJBdM/v1cPT3WLaobciryB8JYYeIFk/kD4iCJAIbGCIJrNcgHhxcaCSLhoGBEVcv7Wy/mYIicOqF/gCcZmrq6DSutzvDD6N0y6lPPcw2wGtloTn7rbmfXf89AfDGEThb+ptaokaE2QO98jgr9/IUgB+We52JlBlr9voN1c4hL2dkFra8oEyqf+oSQWwcy3nHtSfq1A29aKdDkm/TkSzwKfbtAnUJFY0u7UYuxhfhSj4qBD1XB75BbmjE7dhR+OYtlxnX+iar9DAYYp2/zJ3xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(66476007)(8936002)(6486002)(1076003)(66946007)(66556008)(8676002)(966005)(52116002)(7696005)(26005)(4326008)(16526019)(186003)(478600001)(316002)(5660300002)(38100700002)(86362001)(110136005)(38350700002)(44832011)(83380400001)(2906002)(956004)(2616005)(36756003)(6666004)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcOcvbigsmzJUWfK3O9rWNFZ7a1QHovOKZThQPJqBk0gkMObL/i/ObDrwuCs?=
 =?us-ascii?Q?Lfzwon+bEQeN1J19HMi/UsydISiLw8YCmljPbpAXpBS8XPqcpQN1fD0gTQej?=
 =?us-ascii?Q?MM0RQG/IhqwYdbTfpFPl5VVc6SnTdpVqy1Zr8Pd3rx/lwRcESghE3k5vWbgd?=
 =?us-ascii?Q?wQVRYuZ55gHU/tBY1SOB7OHWH7SpGh9w8l6uijfkcEudrpN6FuF0T0cIgqe1?=
 =?us-ascii?Q?W6BesYKu7+YVywa0jnekBAepfE8YDt71X7P96MUgq0N8OP0xUUNUBmXOHfGZ?=
 =?us-ascii?Q?uVtr9QSyPpwKNZlnpraXOcdIOBNyl4ob1DsPOOCvUkiErLkKvqVq7v+9Utt1?=
 =?us-ascii?Q?7Y+CyghsT0EqAliui6PzH0zF4nTYxNGGoylKCSvYUJ6E1b2kCom/X2CmLa3N?=
 =?us-ascii?Q?QggwHeY8GvVyyci97xzCWof2ZPhcDZ/FUuDQb9Dinx61h88y8QhWnEDTbV7i?=
 =?us-ascii?Q?NZ+wkClQmgvmvi1l8qy0wC/AbKFyG4ZFS9S9C23RSxoz/9EbPuOZoSKXF+QQ?=
 =?us-ascii?Q?rnI78QV1WjCyWRvR/W6fDcJJ6Z6IkyBExE/yHxx+nuqtLK7C5rQRlXZZ8abU?=
 =?us-ascii?Q?7SShSGNxRUZj19ncEBhCs8Q9dVcpSDCvigB6eY6VBCdYjtIxTiU0jm/MqgJo?=
 =?us-ascii?Q?XzDM3m4Eqp/Q7OdZXNPZsV2SRVZWxy+kPOsWaCZwnxpZgcPBsaBpE5BDuBnr?=
 =?us-ascii?Q?SK0slLVOBz9md0QXstIzKHChMEz6nk9bL1N3OMEi6C00I/UlFjiDq54WQkCj?=
 =?us-ascii?Q?/Yt4DAaZZjg7KG4gT0WW3i8IsxDh6y59GfWYLNrje3y4bmWX3zkDTNXcfTYn?=
 =?us-ascii?Q?fMB2ijpM4v5A8TYlSrbdjYvFlFKU5vp+PKnukAo9kprsmwHT1S+xx22/8qRu?=
 =?us-ascii?Q?Psqas7WFzIpHLXnhGRG0DiZp7+5KInV8vMKUsBi0dAC1jYrWep7vqPqkc0vC?=
 =?us-ascii?Q?GrEfcgRPHamE3WhOlqbK08i1GD+zQ5r86Vm+Sau+it033CU9kdDiEeHGR0M8?=
 =?us-ascii?Q?+QlLB8q+XeXh/2bGgTc0ouOsQQpeIT2NIjBAUnVLE/upQMbFsxP14aRnQvSl?=
 =?us-ascii?Q?tVRqRZCHuVmE9AjCXmGbVUgAtN4ctlAHN4ZVAh5gSNZ6i5atk2rfAyqCzGdM?=
 =?us-ascii?Q?DuIuWUBLeVXnPTOr2qFiY0SMmIMkimmRefoDte1fTzkF+OTAl2X7MKRlRhFl?=
 =?us-ascii?Q?ovX+OhwULe7HwGTf+noQkuKKCAaHRmX1HW+TaxBCb9dMkfybU4C87a9tpFNO?=
 =?us-ascii?Q?DozSUhlfPv/FBFa5SeHmAZsCIJLG4LHviEuZOFlf3DorkxrsPnycnOxV4R8O?=
 =?us-ascii?Q?8Jj7Ro8IMGKWGADM8y3LywS0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfaeb91-24bc-417c-8ecb-08d92a942679
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:43:24.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvw67UDzYIwurga8qrAYZYPs85iPN0+40KUx1te0lbpSbFeSh0qMsnoHwFijn1rHT7ZgEfUNVDbwK5Q9m9fARA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
---
 drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 31 insertions(+), 27 deletions(-)

Changes from v4->v5:
 * Correct extra "Link:" word in commit message
Changes from v5->v6:
 * Add in commit message tags from Raul, Rafael and Keith
Changes from v6->v7:
 * Update kerneldoc comments per suggestsions.
 * Drop all Acked/Reviewed tags

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..c45f2d76b67e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if a storage device should use D3 in the suspend path
+ * @dev: Device to check
+ *
+ * Return %true if the platform firmware wants @dev to be programmed
+ * into D3hot or D3cold (if supported) in the suspend path, or %false
+ * when there is no specific preference. On some platforms, if this
+ * hint is ignored, @dev may remain unresponsive after suspending the
+ * platform as a whole.
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

