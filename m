Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086FB4D7A08
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiCNFFL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCNFFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 01:05:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA21AF1F;
        Sun, 13 Mar 2022 22:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZftCgXv0r8zoy9HUIWNg3G4TCjYzkZI/xdChAtgec0MAcP0plo1MkeTbA1xbEtSGfsdVe1d+Sm3DrkCSDOvhbU+O3LZKeV8DLLlNIztfywLxoZI2iff02IqSh1CuifANY9eoC9boE5PIyTZnRX4Cj0vn5PCoEO3UoSvp5bf6PelMqekSAhPp/ogfyb/oY5F8VOi68mD4JBd6V+LOFUFXo1O2W+GOV02QrX7B58EXZA52QAmM/Exy7L09+cX+b6CFyEEqZDag50OkqBQVJyIudg/5v/h/ag6FNJ0iHPNYAeCUDqTU2eRXG8xdfJO4eSvhoJqTF4/GnSTkBqAXdtWaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ2j7lNsdwJuNrfGw8p6BimaJef8ofP94J4kuhzmYxw=;
 b=WbN/Ki1KtaeM5A4LIhnDlP6r5fv9Md9pQQ36iylOCyuUJcJj9rDUzDUjx+/S+HYgLHMehNUa7h4x06Vs/l4kfGNcnfyBfr0+p2AGNAbAJLrmoQ1jtQiK6CqKV6CKwzC14tjmO+vb1qtagW9eqtNkmutSWU+lXRVyAsjQg6hDhVlK+in60QWycw9FeNw0USKDvl97UWL8eGchmld/2TL+Md4hZRSbMwVl+EQwTVCWgZJW03dbGDLBZgHyYMeDX6GROTnWf+OTo3y1YW8EEuBjo76CAdP648jn28ujuZRf8TF0vULoacvalIJN++zQCFEnWH8uD2Pla5/0ikq6tTackg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ2j7lNsdwJuNrfGw8p6BimaJef8ofP94J4kuhzmYxw=;
 b=s1gT129RydtKeFIT34bSK2G5v6F2uGKNGPYxwwHi1cINpfYS/tZHH2+uMSKrYMMd5u1BeyjtlFn2pcpfRMqtyKFGtxL1Oje1yCaGDsa8+f8vZO8eA7KWeRKGg3SM3xB14j3YDvOrSC8TVpFdWVxaxrSV1/EJS1pkbSIelErt8uc=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 05:03:58 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::95) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 05:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:03:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:03:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/5] platform/x86: amd-pmc: Move to later in the suspend process
Date:   Mon, 14 Mar 2022 00:03:38 -0500
Message-ID: <20220314050340.1176-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314050340.1176-1-mario.limonciello@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fb2665-9415-43ac-78cf-08da05780bd6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38958153E0C844BA89E81290E20F9@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UcwCu8TLZSz1PbkmK5MfrmNI/LGaEHtHBRNeG7InPiJzWkB3WlGfIf2C9nV7t7vJ2K9ZLoQJsJ1zk9BwTvKr7fXADKdbuzlCOmQg8cn/eaaX+dE80afwpFrGXPTvqSfQJGuqm066QSPHwQ6CmTQJji+RdWuHrB78HdPYja8Zu6iiw/RUZlc9heQnSM+bhU1/NhMqGUKU23CWWAo+D8RG1i9dchgVjiCFSS9Yui4l6AaaaK/LzIUA/vKTwg/XiSXWIThtb3Z/7zEbrfYCs2khYZK0cWZ/sJHgfXq32wtJRRMcEl+p6hu+xPK61OYIsgBWaAhlEA9N7EvkYXdN2s2WPl9ysUSduTblgfKgE1OGtfhcXNM/ZQA7R8Pnr6vDY9EvE4MSis7t2Kj2fVmZAOf3wsWb0BDqZQkU4STZW5TOOQtOCHoSgh40rxRySCYy7dPweqm8fTRucJO+DmfgVoGM5lv2o+NbXMkWEd+s5k89LKlOG2cPmK5Z0BND0lW5RIZzXG3fuD1E3qJZZDkrV/bVJL/tFGRmXsVIh20MpwzcAE/nL96QTVPMB3QyzBN99fal68mjpfnpJQcpqIX4OaItgFL8IEVCHjOzOVXm/zUj+UNd9BrvHBayn/ZEV9GmUvdVIgmySgb9dlHq5WemR0OtcUX8uSZtvIEzuqgQe0m7LSmUIfmdcMJk5VoW9P6IZiKoeypOsQ7gJPBhixctacQWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(4326008)(40460700003)(70206006)(70586007)(7696005)(336012)(426003)(6666004)(508600001)(8676002)(47076005)(36860700001)(8936002)(356005)(15650500001)(81166007)(5660300002)(16526019)(316002)(82310400004)(54906003)(83380400001)(2616005)(110136005)(2906002)(186003)(26005)(1076003)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:03:57.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fb2665-9415-43ac-78cf-08da05780bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
changes from v2->v3:
 * no changes
changes from v1->v2:
 * adjust for changes in previous patches
 * display a debugging message for constraints

 drivers/platform/x86/amd-pmc.c | 42 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 971aaabaa9c8..752a99d759d2 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -639,13 +639,16 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
-static int __maybe_unused amd_pmc_suspend(struct device *dev)
+static int amd_pmc_suspend(void *context, bool constraints)
 {
-	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	struct amd_pmc_dev *pdev = dev_get_drvdata((struct device *)context);
 	int rc;
 	u8 msg;
 	u32 arg = 1;
 
+	/* for enabling constraints checking in the future */
+	dev_dbg(pdev->dev, "LPI constraints were%smet.\n", constraints ? " " : " not ");
+
 	/* Reset and Start SMU logging - to monitor the s0i3 stats */
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_RESET, 0);
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_START, 0);
@@ -658,7 +661,7 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	}
 
 	/* Dump the IdleMask before we send hint to SMU */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
@@ -681,28 +684,28 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
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
@@ -711,15 +714,8 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 
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
@@ -805,6 +801,11 @@ static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
 static int amd_pmc_probe(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = &pmc;
+	struct lps0_callback_handler lps0_handler = {
+		.prepare_late_callback = amd_pmc_suspend,
+		.restore_early_callback = amd_pmc_resume,
+		.context = &pdev->dev,
+	};
 	struct pci_dev *rdev;
 	u32 base_addr_lo, base_addr_hi;
 	u64 base_addr, fch_phys_addr;
@@ -884,6 +885,10 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	amd_pmc_get_smu_version(dev);
 	platform_set_drvdata(pdev, dev);
+	err = acpi_register_lps0_callbacks(&lps0_handler);
+	if (err)
+		goto err_pci_dev_put;
+
 	amd_pmc_dbgfs_register(dev);
 	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
@@ -896,7 +901,13 @@ static int amd_pmc_probe(struct platform_device *pdev)
 static int amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
+	struct lps0_callback_handler lps0_handler = {
+		.prepare_late_callback = amd_pmc_suspend,
+		.restore_early_callback = amd_pmc_resume,
+		.context = &pdev->dev,
+	};
 
+	acpi_unregister_lps0_callbacks(&lps0_handler);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
@@ -917,7 +928,6 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
-		.pm = &amd_pmc_pm_ops,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1

