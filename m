Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9890239AAA9
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFCTJ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 15:09:56 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:51296
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhFCTJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Jun 2021 15:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5crY+LMv9/rn4e98wEFAfxxYXeHnnQ/VmK22zmHXtd9H8HJ4lONgie1UNC5s6NsFpSHnDY2GFxUXcVN9aK+mMYpslHTQgI7N7DQSoYv254kX4EhfFR5BXbif+3s3sYN6scU0cDKCTVdA1ke1sHWWs5ZIqDa2pX6orI1mYs0vhocWNQgxCWjJZ83tyil6np0X9cD+JscRwKIeiRwznc3rFW/R1ThzrjvgmjdRVSdsBED1pGkV6YZqpZobDBfkuFU2X07MoZuBpJMw4kjxjP9BTd6oNOmUW/TL3e+FI8fjGq4m23XwQC1yrMNSMpiVHHqXii4tMbXQQUbFR+0Njkr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE0dHPryWPoQJRzE/Rop5BaO7kjf/+dK8FWro51FsAc=;
 b=KeSuakAqrwUDKWkSCN925a2w4mqPKgvty9RbsIS5Qe0zw6sDcgUSUiXwJKFC12kC74PGa57V22vI0KbATSbcw1ew2QWCqsZOuayd/5dUlByEu5zkEvWrGTw48KxeKW1oDtd17bkqqDm5KkkJ4FNaWY2247eQiZ51+dDg0QbxTAfoicg0nKyIml5cT9wZr/ZbH80hkzeTfoe31jxzzEz6HKMVAUD/thveVC7YZH01BdKcaJYA417U5+rkatH14Cb4jWdumdmPzX2U/iRcO7rThXCHzlVWw1IFpA4ZKH6cMEjxy+QXZk21t8spxVUFNIcg9L6SbuhP9SEUAYM+nFQY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE0dHPryWPoQJRzE/Rop5BaO7kjf/+dK8FWro51FsAc=;
 b=plkuREne+0Uf7Tm/slfw5oltywFKHIct2sKwOnjsCV99uHdeaXOn3u2hQhVYRv6++EBXK+Xr6Wh92lNxM0qMZmIOkiEP6QLAHDhbrEpj/GLUcYjKJxhR7xUH3JZMnTfHA3oXMw7wFDbG29YhuHJESdeN/IE3jG6SKOz07+pvYyQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB3272.namprd12.prod.outlook.com (2603:10b6:a03:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 19:08:06 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 19:08:06 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to acpi
Date:   Thu,  3 Jun 2021 14:07:53 -0500
Message-Id: <20210603190753.5084-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 19:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0563f06-24b1-4d79-4ca6-08d926c2eb46
X-MS-TrafficTypeDiagnostic: BYAPR12MB3272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3272DD17D1740D5EB157AE4DE23C9@BYAPR12MB3272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srLCfLO9O7bL4r4eEAYZJC9U4guv+1TrxB3tCCXXVUT1p2yOlDiS4r6grvU/q9EO4Fr6z/redkaYC3SYwZNXaiCgPJYtDofNI7+FSuoLdUirm5M8T7CruilKhwRWuYMZPeGODuM71twXwAxawAmfd+8C6QniHIuw5jV/QP6h3l0uGtSIMBChvJKFSpHJcMqNOrFylC8kKI1KUNQHZyYVbpGt7gyOn2OER4mXRc/5WoxMMFzSWGezQ558fGzo1WQAJCnFsiJZNPMcJt2l1fQ0tqQujzPkh0v8o2VTj2U+oxBtEDrNLXIudbo1tzQ5tc8ISb7wsW6VR+z7jNA/EFmXPO1wVTMPLYVX8rcAvcov9Hx+Va4j1LLDTdO3RBO6Mt12sIRCRtkeGkZSZyoNCW1RVOGt+NDzT8SIC1l7XoEno8w+EUc7sKcfJWeBfrZm8ajZZP7K2ewav+3H6SN7MT7DMTDKv/bUyDsAZv1LvjTExeqEgyxBLVh+5gLPXukNgx3ZmsZ3XyoX3u4lmicx2QS0yRFfBhTQA5VuYq2gS3BbufNSKBZ0cdi1tqDnrfYxcVU2AHCFjOhLc5wemtbcQWz5DBN5asgR9TCB6dG3hMGno3QRrdQuoc0hcOHsgR2VeK3qVIssh2UdsiQJYs3x+IILP1M2N5RbIBWmfx34EHpi//fEWbeQUd7XtLZhRV2TLZQNR8XoD5CicdUDrFFw5e/LHorh/JMFThK7xOfSy+khnJBMXHja/J6Q1wgq1vDiat8icQEf2lpvP3N6RcZe+hSeBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(5660300002)(4326008)(66476007)(86362001)(66556008)(1076003)(966005)(38100700002)(66946007)(110136005)(8936002)(38350700002)(6666004)(83380400001)(26005)(6486002)(16526019)(478600001)(8676002)(186003)(2616005)(956004)(2906002)(7696005)(36756003)(316002)(45080400002)(44832011)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D7/3llAJPzaZAPuPzHqR6dbXcz7vxOCjUBYcTKseNpCBLcZmjyGzpXfsQBuc?=
 =?us-ascii?Q?zJdbbVDT1b5QYgT9yK+cSG7KfP1rs0hugyoHw+LJgg3+pgARl9dZYBxrfGpO?=
 =?us-ascii?Q?0o4+zmfo6A4K4rpU3ctscCt8LUjy2G8xo3B2LrX2khXSuUefT7iGy/QmcciG?=
 =?us-ascii?Q?8ifP8ROYFn3Dt1Nzfll7U3ooBHwItoxzFnyzoukq4c9nctR6npsCsf2ng2hL?=
 =?us-ascii?Q?gcOdU8y7UXvh2BQiOQP0vWpgyNAgFNEqlrmW4N9nQUk9+9Qmb67PPt/nfDjC?=
 =?us-ascii?Q?czg0gl9/zyWVTSCvmyXPO+6fjJyCcfdQiAeIxyV14M/9+kbjK0pDSoviRzep?=
 =?us-ascii?Q?u5ntx/HQr0CZcVqHh/vQHboym4m5LbsdEc89r5PCeTDN6EdsBGktUgQCASou?=
 =?us-ascii?Q?NRordOJSdf3Y8Jo3rixGG+b0mYwN+9naVBqnk4W8Tlqd7iMdVp23YAkhtFdo?=
 =?us-ascii?Q?JU7chFTTHE5Y/t+9DnO4MiHO165HuT3CatyomGBqKiXZKmzqp2+mPR3qGOi6?=
 =?us-ascii?Q?G9cP5N+LcUuDl1Zv4MiYNQNKP2gHkh7PZ2PN2mZ447CY3nqJ4wZMDpwBNcsS?=
 =?us-ascii?Q?8yUk5gdywps4fosPppi8rNfvZi5iCA9sX7z5T/8ewwPziAfz51RdJDtsCZSn?=
 =?us-ascii?Q?VrdqhgajJzx73AEG1RWLL6WoM/iia9dPjWkUaIouyHA1kJ0Gu7EjHHXsXlTg?=
 =?us-ascii?Q?+P5VlFHqvhhAeojek/TKbtD1mZVbu/cTYPbZVkx4cLT+90K/AJFE1/lfHGpA?=
 =?us-ascii?Q?1/mQET+Tppxg3surn+vgeLwn+nf0I+gJGjw0DDIi1JZHzJbeVqrR+DfAa8wG?=
 =?us-ascii?Q?x0qbOdvKcBDXNLCZORB1XatBq3t1xayixjXQAKslRi34rXv2LG8JuIjtfS1/?=
 =?us-ascii?Q?tcJZvihvbya6YICWb8S/hFP0RS62sQKxNOgj+hVY4avkGNUpQrDjyh3Z1wZ6?=
 =?us-ascii?Q?5t8F24mmxJ/JbxdUzypbOz6T343vPWfyqjkP0I1UMvSErtOcxvN7WaA53NyY?=
 =?us-ascii?Q?rlVa++a93uEN3uuyrPmqheisFdMbgRJHJc7QgiKHR6scWfGbGaywIT14DU8p?=
 =?us-ascii?Q?6sGvhPAZya5r/YiB63IpPes3UO83ZN9sfoN7jQf9Y71nx3ReAXPUwpwQvDdT?=
 =?us-ascii?Q?ISVkC7+jvuxopvTQGQv13JRpu1bUXjb4Vyi4jEhFMJJkPwhU1ugAs2ApeMqf?=
 =?us-ascii?Q?Ird7XWK9k0ZTBvWf7oPh+cDLE6RpP/zbvoThEHWDFpQIxd7jz5OoACxR1UfL?=
 =?us-ascii?Q?6UP1eBlLvXR+o+m2/H7rSRLzZ5fzwdPFFTRrtlq2FyeYsCVtugcNB9ZYdlWL?=
 =?us-ascii?Q?oH56IP0vxVHI2r32DnBI9Uqw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0563f06-24b1-4d79-4ca6-08d926c2eb46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 19:08:06.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v36GYcK0LCMk/Br7wrDJ18wqroqT4we6kfPm6SzhftsZaFf5PTIlhPLIWUCuynRm7QmamTUGZx2AHXWK/vW17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3272
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Although first implemented for NVME, this check may be usable by
other drivers as well. Microsoft's specification explicitly mentions
that is may be usable by SATA and AHCI devices.  Google also indicates
that they have used this with SDHCI in a downstream kernel tree that
a user can plug a storage device into.

Link: Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Keith Busch <kbusch@kernel.org>
CC: rrangel@chromium.org
CC: david.e.box@linux.intel.com
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

Changes from v3->v4
 * Rebase on nvme-5.14 (w/ patch 1/2 from v3 of series accepted)
 * Adjust commit message per Christoph's suggestions
 * Adjust documentation per Christoph's suggestions

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..1edb68d00b8e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if a storage device should use D3.
+ * @dev: Device to check
+ *
+ * Returns %true if @dev should be put into D3 when the ->suspend method is
+ * called, else %false.  The name of this function is somewhat misleading
+ * as it has nothing to do with storage except for the name of the ACPI
+ * property.  On some platforms resume will not work if this hint is ignored.
+ *
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

