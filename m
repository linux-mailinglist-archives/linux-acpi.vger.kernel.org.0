Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B84D51FF
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiCJTSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiCJTSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:18:34 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A30395;
        Thu, 10 Mar 2022 11:17:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9hXCjevnAuiTP4YJ6Xe4KNWh/gKcdyON0LnSPnjdVK2cY3AhLVukgvuT2Sx0Z7d5QHDcnY+RDuXjwg8ji7z+fAe/E8Dicwqn5Wk1/zaxKaPjLFE9rxXtJX85crtn66fJM9EzSdfzelUY0H4gpDHYpX/xRK9VEOfP5HqEHOUrA5CCoptDbGI9abmdE0rmXVXXOUHhu9wJmZWfMe+pFaHomvZwhS1ptRsniSDCuSGZJashqROXQau4eTXLc5W+038N8GaEDeM2zH2e79s52A2fp9JdCONxt43ZOrTx0yJi2MdqHPdI0VCeP0vpvIVeUMOo41dTHV6JUTXTdn0gxqZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsaQyPXbbvSezoBQ2ZpwNaclrSlh0XZv66sl17ttm3I=;
 b=T4QsUxT3KbCwr0f+e0+NuqBXJQv6NKQALhQEG8/yxTxaWg3PhwXVjzqAaqATP8RtL5/eMvJaCj0w2GQEORxgwfsmHgg+w3Vu1sv+gzX+pDwUIY4vCGvQHyFnQFW5FX2gnpGtMZTHQQVJeJqkpHsiGdZj5TaHh1BEkv8OfpIGbiX7KnskPSIwLOWpmjxhq6enDNOm05kztA8d845t6IS4vYDJDTA3z0Hax2UScQ8gmRKJGN66RS/vlq7Ga/IiTFUMoUA90SxWB+zVfI4vmyMgl2/1zw9PQDVa8rEu0YtvafMYeTsXAc+Lvacm+C7/YvgUuk4IjSvoaU0GIy9GPAP3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsaQyPXbbvSezoBQ2ZpwNaclrSlh0XZv66sl17ttm3I=;
 b=a2xORd9HsMdPSL+qRYJoTMGd7Ho8ThsDWlS2ZL5kDqEdRvC6D8hJ6pVlf6pJQf98alaPs2uQ3QjkgdU0fGvwgXKS1RLnazJ5enIXkP3dDtkMV0j7Kg8CXElnsGi74v05wmGW9tjW9msvmCK+w1silvIgegiLZz+MQiyRNZlrdxk=
Received: from MWHPR14CA0036.namprd14.prod.outlook.com (2603:10b6:300:12b::22)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 19:17:28 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::42) by MWHPR14CA0036.outlook.office365.com
 (2603:10b6:300:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15 via Frontend
 Transport; Thu, 10 Mar 2022 19:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 19:17:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 13:17:25 -0600
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
Subject: [PATCH v2 4/5] platform/x86: amd-pmc: Move to later in the suspend process
Date:   Thu, 10 Mar 2022 13:17:23 -0600
Message-ID: <20220310191724.1440-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310191724.1440-1-mario.limonciello@amd.com>
References: <20220310191724.1440-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a928f38-aa40-4406-cca4-08da02ca9de2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4918:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4918F1A179B034F342E7DD31E20B9@BY5PR12MB4918.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go85hYyn2dX/P8wTfTFUptumlF+g71PjJOB8ez5WVi8xkv976kZ3MDtESyEVozYpqL0HXnTrJWzz3RHHaFOb1bhbMuSLz0RUw/yiqLvNBwRol55YOTFrKbK0cOy+E4e+NcoywTQ5Jio+3Luk6YKJj8/KvqGhzwm/an/P69zXxpvf/cUBSEAZbfdenr0fMGmiwkFX1G9iWfhVlxSk4Nbjig/dRYWxe++54sukCIoyZ8CmssGi0RtjpwOk8SuUNqFdtZ+btkzBVeHHFCBGDaX+SMjjc4zXyX6OuS6zJOpHn4+6gwN70cZtSa5IzGEm97DEeYk5pXleCy8XYf2Av8QroBLsT8DjE+fUSDnhiQUZZ/znwSzbkqzAkcIHX+zG34YgnTOU5WFkt/X7HpqaX78GGo7MCmQBnYgGpW7QUwfilnMf7GlHSnKg/ouQ6G4NlJf5GEhbBrZ7FZugkmfSE0OYQiQ2o+hghroyOtcNEJXtPwmImDPwC0HhbKHwoq+qzAD2lff0tPCPBodhmRvm9YItCr/byZWMW9C2XmQVzby5U+GhS5EY6dFIQA3YKObaCVBcvmXvott7Mq2AgKZ4KYZ8bvNU00bPwpI1ptIIKqm2PKifbomFIL6LZpHsMjzWoGcU+HhQiDNBgtDOkaEjtyEHw5a1yoZ1sxsZxNCDayzkQA/rTZ3kzPk4PDaZxeXnqtxK4Zd7KM5MX1ej6reIUuwfaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(426003)(336012)(40460700003)(86362001)(81166007)(16526019)(26005)(186003)(316002)(54906003)(110136005)(2616005)(82310400004)(1076003)(36860700001)(44832011)(356005)(83380400001)(70586007)(8676002)(70206006)(4326008)(508600001)(47076005)(15650500001)(36756003)(5660300002)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:17:28.0007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a928f38-aa40-4406-cca4-08da02ca9de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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

