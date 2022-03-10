Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232E64D4D08
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiCJPWV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCJPWL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 10:22:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228813111C;
        Thu, 10 Mar 2022 07:21:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q54qkZr8YHYL3hxSYEGI5daaR+0zkR+Qk4Qtmk9QjQQ/3PnH0ACvH3kLBQ/zwt6LhktJSIGQm+xdFfeRr2S0ZiS97Bflt8jyXuakEIzJ3KCR06l6JTBKj9rbsHaIcC+nz78yFOoQqtVLiuqeytdQmVRaUxJf1aDDT9NUNqce78BsV5wn6cmnU4dLPeNPysNnO29IXI1h3uNnaDaS+OiZk6ITdj3xmn10V7rR8S3T0LMJqPs+PA7gWXRRic5EkZpA8DLEfPhuPb0Ue3ufRclrZoYLC5mHukNYXtoKLovd4SNoP6olCsUrhPDwFvLmuH+WqoU6mwXaYL00uGVy/v0fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnsAEQexI7GD1H3chcI69yDQYzk4JoMJLOpqi6iCOs4=;
 b=gALhRsovDuU0eg2rxiiZEXX2j6Gum6HIU9661P5odrS/l+1ynCbWRG9CIlhFD0MKPB3R6dXziuNnyvgbHtL9RJGupCFYh6OeCaq8Km1Ip4fw3baf9Axs+S1mkZ9TuVY+O+mauChpFuVzePXhj7A7xBGjMM9I4XjqEsm/1gTuj7YXRWD6vJB/39p8lSFDVqyeFuD8TmQdyTRtqssxwgEL4gYaMJMTs0jCHp9IcsQTDl1n/dZIuJbWPMu1mzQDwXWpoubEvd5dbnL848bIP8x+zOLTZPN6qHQVaFnFKVDLWJskD/mYGWqW96YNoMJtBYypkGcRLq2j7mHiDvL4Ox1nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnsAEQexI7GD1H3chcI69yDQYzk4JoMJLOpqi6iCOs4=;
 b=OYZiL8q+C94uEVgmv3OwYe668NyXGyKs6j3P4MEC9jRKYki0JNiOTKdtbB9esq37nAxDnYckNE6n3xR4cd0h7ZV7p6uyDB9IUFS8hjwyfsk4kI1BrI0xlAsigxIMX1Cf84xVHH8H7eQmcGfiRwFrrX9iNQEhSh0zCEcHomZIMRU=
Received: from DM5PR06CA0088.namprd06.prod.outlook.com (2603:10b6:3:4::26) by
 CY4PR12MB1176.namprd12.prod.outlook.com (2603:10b6:903:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 15:21:04 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::4d) by DM5PR06CA0088.outlook.office365.com
 (2603:10b6:3:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 15:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 15:21:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 09:21:02 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] platform/x86: amd-pmc: Move to later in the suspend process
Date:   Thu, 10 Mar 2022 09:17:04 -0600
Message-ID: <20220310151705.577442-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310151705.577442-1-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8fc826-0fd0-46c4-6d66-08da02a997a9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1176:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1176A6A48CA9CEF3F296B937E20B9@CY4PR12MB1176.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zgp3nCzV48LoUKhwTeRjke1nzXjiaEobCDddhe2YNUVzg3yKuTFXLxLJXlj7ZwqVB84KD3OJzfwjCSb+v22EFMkg8SxSybODRit4xvOvy+HePiB0BR8fJP+eG5poNG5naKP3G+uab/lJnOpM/HqL0F9dr6hmamvEHpXLSUk45RlfI2max4wRVCRsZ0gNIK+y/eRwEZw1PradY+2LlDyA90CyQsV8Q3WkGjRGqaJ0mxMcKPyihwYgIdS+ait5mk7+sFAfyBfm9X8BmvI/O1tBkfiK1dtIa2n8WYZt7j1Y0iEcZblQf+2ZAC1hI0DtiONj0Z6rOleFEf4sjBvwJa5rUX1+OMuW8i+lCuXq8i74L8sIjSFRSqrci9M+kEt/puGFQwi5wVofZjRBg/xhyy/zcFk6cmlcyeVabZYqr3kq5Fh3ciUK5/t1q9SsKw7w6D6NTa8DXm7O/nyFOPsQIijVG2gacS/MyIyFmPEjkpRYHFPqgdWl8blG1GQjnkzaTvE3w9708SIDvyZL5zj2ESyG7UMA5lAYem7KVFhK24i17tJTElEhwBk/unKgGxP6u6lk+YeLTJLSrQxQXAIpl2rEkHRRFcMgsjhwGe69ueZkKJWOlRK6SebyRyLF+2veDt7mJ1JHA3sXHYMjHsxs9jg7VVgQTxhgjwpo2IBXY9vnkJ7GDV7GkHMi6NZm29WElSqKGMsykO+ljraV5dUIMuuy1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(82310400004)(81166007)(186003)(36860700001)(15650500001)(70206006)(70586007)(110136005)(54906003)(4326008)(36756003)(86362001)(316002)(8676002)(40460700003)(2616005)(1076003)(5660300002)(83380400001)(356005)(336012)(26005)(508600001)(8936002)(16526019)(2906002)(44832011)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:21:04.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8fc826-0fd0-46c4-6d66-08da02a997a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The `OS_HINT` message is supposed to indicate that everything else
that is supposed to go into the deepest state has done so.

This assumption is invalid as:
1) The CPUs will still go in and out of the deepest state
2) Other devices may still run their `noirq` suspend routines
3) The LPS0 ACPI device will still run

To more closely mirror how this works on other operating systems,
move the `amd-pmc` suspend to the very last thing before the s2idle
loop via an lps0 callback.

Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 971aaabaa9c8..c13fd93f2662 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -639,9 +639,9 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
-static int __maybe_unused amd_pmc_suspend(struct device *dev)
+static int amd_pmc_suspend(void *context, bool constraints_met)
 {
-	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	struct amd_pmc_dev *pdev = dev_get_drvdata((struct device *)context);
 	int rc;
 	u8 msg;
 	u32 arg = 1;
@@ -658,7 +658,7 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	}
 
 	/* Dump the IdleMask before we send hint to SMU */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
@@ -681,28 +681,28 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	return rc;
 }
 
-static int __maybe_unused amd_pmc_resume(struct device *dev)
+static void amd_pmc_resume(void *context)
 {
-	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	struct amd_pmc_dev *pdev = dev_get_drvdata((struct device *)context);
 	int rc;
 	u8 msg;
 
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, 0, NULL, msg, 0);
 	if (rc)
-		dev_err(pdev->dev, "resume failed\n");
+		dev_err(pdev->dev, "resume failed: %d\n", rc);
 
 	/* Let SMU know that we are looking for stats */
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
 
 	/* Dump the IdleMask to see the blockers */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
 	/* Write data incremented by 1 to distinguish in stb_read */
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
 	if (rc)
-		dev_err(pdev->dev, "error writing to STB\n");
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 
 	/* Restore the QoS request back to defaults if it was set */
 	if (pdev->cpu_id == AMD_CPU_ID_CZN)
@@ -711,15 +711,8 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
-
-	return rc;
 }
 
-static const struct dev_pm_ops amd_pmc_pm_ops = {
-	.suspend_noirq = amd_pmc_suspend,
-	.resume_noirq = amd_pmc_resume,
-};
-
 static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_YC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_CZN) },
@@ -884,6 +877,12 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	amd_pmc_get_smu_version(dev);
 	platform_set_drvdata(pdev, dev);
+	err = acpi_register_lps0_callbacks(amd_pmc_suspend,
+					   amd_pmc_resume,
+					   &pdev->dev);
+	if (err)
+		goto err_pci_dev_put;
+
 	amd_pmc_dbgfs_register(dev);
 	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
@@ -897,6 +896,9 @@ static int amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
+	acpi_unregister_lps0_callbacks(amd_pmc_suspend,
+					amd_pmc_resume,
+					&pdev->dev);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
@@ -917,7 +919,6 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
-		.pm = &amd_pmc_pm_ops,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1

