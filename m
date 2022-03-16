Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5A4DBA18
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbiCPVay (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353348AbiCPVap (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 17:30:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC224F3D;
        Wed, 16 Mar 2022 14:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFh9o14oH7UMKBgrkidqmszza9RxG9/STvlHJDg+kJtawZjjdbKqxHCiDJOFg5u/qqJEK0sdQZ6CSqNQ4L5rsQwZwCjNKNvmSqJu0rmZLrG1knY1KEQ28//BfMuvWOYL6tyug7H9uRK45rJrSDpQ9C13wy+ocm/gWtixaA49TSnVOzlKVYNuSrZD+CQLts9Y0wpyQU3yiGeLLATj+X/6Y0C00og2+MWoXCbul55wDVdDdTshIuqHvzEKvia6r/Tt2SRWR0dp9AD6Ndw5rUsoCgnXQQMrhapsgbQ2nxJYpdwvZxsXKVY/ze6EsexyOFw+RmwwTRN+gHgyv/y0LF55VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4Ryo+107Ei7EEEIJJY7YDOd9fJ8fbFKZY0m/VMZ1Ts=;
 b=ALLfmT3mEiPmahORZmLLTtCsNoLu9ZKEE/RXnwL3L14QyBT0xeEwRSfvYmEYSC+mYe9zIFWK6fhhGJ9Kl5knURb3RBQT1BTSW4aB1HF2YZ/Pctf4qNyI/9msrRWFP0u0iUx93m59fD0ZgVWKiNkaT6REjPciEXhNhXq/yhTYUtJ3pRuUFz2Qhm+AKLOLvxjAEowggt3UX38RDgdPbz9ESJKJBL4X31/Y9IQxvxtlpCm3h2Gp6mVXhH4QqJeifIhyIxK9hMZnRRibtja7yvobIL4vN8lL9bVeHzJjVpO8R/dTbHszqhzTNzeMiMuIHfxJ8p+VzjVYqrXdayk/KlcXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4Ryo+107Ei7EEEIJJY7YDOd9fJ8fbFKZY0m/VMZ1Ts=;
 b=IOTBpSLI5IvmwNbJb5J2ShwUE4mDw6xHjkH2QY2Yhgz9hePvJH2LK/BPAosttcu6BjmfNQbgqhTodNDvt5sceCtz6+skB7wNYYNBY10oZNXSHgOTRLxjMikpLuykRZixICksdq0WfJYVnSImTwuH3y58KP3glexVjJl7zwRLADE=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by BN8PR12MB3139.namprd12.prod.outlook.com (2603:10b6:408:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 21:29:28 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Wed, 16 Mar 2022 21:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 21:29:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 16:29:25 -0500
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
Subject: [PATCH v4 2/3] platform/x86: amd-pmc: Move to later in the suspend process
Date:   Wed, 16 Mar 2022 16:29:23 -0500
Message-ID: <20220316212924.5619-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316212924.5619-1-mario.limonciello@amd.com>
References: <20220316212924.5619-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39dcbe74-891b-4a73-d130-08da07940cd4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3139:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3139C853973C54643D3131B8E2119@BN8PR12MB3139.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ohzi3YyMsFHHczES+vH9uox9jz7r2TVkmZIFv32pXm7TaUCzQh7RwsQgYtxo6+dIU47vU2nBlRbRjfpOQu/1F6+1J5dWGPJNmO960YexyuliVfcTGsiEMBOnUc65+nNwTbcTIyPDD9PS8PyjMa3+yidMX3GkX+jznQCqX419MixutFoD7Kf/KgygbNzOGK9VJaBktE/wEh/J/b74fJhAX2UX7kNeNDRa80wJWK3WsZucQZJg/qVQw30FQGKjhMoSK4UvEVdwOw3RwDZYQYdAgMDizqGceJX2tjj0+2rE0m/FWvGFCR3Fu94U2MMe8BTtpBZqxY3ZHicowwdq6PpzViWL1YWOA0zJfkw6ccMMum/cNmXuW1J1q88uyq7PvtAMPZMKTVEbHuc0h4qMXWVK0wXvlFEjO3DwJ1SZt0eolXcI4inlS7fOpl09xfiT9aleMiSFHBa7hsdly069LOUhHTjM1CByiMD2EdjXsxcFxY3A1Pc1vJIK6LaG2wkzK+pORnptEklpvvdiolnlUMpOAElcWvkTHH/oWzIFPjymY/pE0xVUBnaqdL/N5ETcUEGsOeMLaqzqjfmpwHyoo1bESb+AoGihmb920xno8WeNDnsj+Jfd2c8Abg94EJd/hNY2koM8O8RM51rYgYvBY5We/zLLeIQYDljfuusFKRa2GNBQWl5+XKy9WPQyAoXboMv0428ThI8gw1F4Lc/9Xl2vpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(54906003)(44832011)(36756003)(36860700001)(47076005)(2906002)(40460700003)(8676002)(316002)(7696005)(356005)(70206006)(70586007)(336012)(8936002)(2616005)(81166007)(426003)(16526019)(15650500001)(4326008)(1076003)(186003)(26005)(82310400004)(508600001)(5660300002)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:29:27.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dcbe74-891b-4a73-d130-08da07940cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3139
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
changes from v3->v4:
 * Drop constraints messaging
 * Adjust for changes on earlier patches
 * Don't fail init if sleep_no_lps0 is set
changes from v2->v3:
 * no changes
changes from v1->v2:
 * adjust for changes in previous patches
 * display a debugging message for constraints

 drivers/platform/x86/amd-pmc.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 971aaabaa9c8..d4b1bf4b58b6 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -639,9 +639,9 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
-static int __maybe_unused amd_pmc_suspend(struct device *dev)
+static void amd_pmc_s2idle_prepare(void)
 {
-	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 	u8 msg;
 	u32 arg = 1;
@@ -653,56 +653,53 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	/* Activate CZN specific RTC functionality */
 	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
 		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
-		if (rc)
+		if (rc) {
+			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
 			goto fail;
+		}
 	}
 
 	/* Dump the IdleMask before we send hint to SMU */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
-		dev_err(pdev->dev, "suspend failed\n");
+		dev_err(pdev->dev, "suspend failed: %d\n", rc);
 		goto fail;
 	}
 
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
-	if (rc) {
-		dev_err(pdev->dev, "error writing to STB\n");
-		goto fail;
-	}
-
-	return 0;
+	if (rc)
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 fail:
 	if (pdev->cpu_id == AMD_CPU_ID_CZN)
 		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
 						PM_QOS_DEFAULT_VALUE);
-	return rc;
 }
 
-static int __maybe_unused amd_pmc_resume(struct device *dev)
+static void amd_pmc_s2idle_restore(void)
 {
-	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	struct amd_pmc_dev *pdev = &pmc;
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
@@ -711,15 +708,8 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 
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
@@ -802,6 +792,11 @@ static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
 	return 0;
 }
 
+static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
+	.prepare = amd_pmc_s2idle_prepare,
+	.restore = amd_pmc_s2idle_restore,
+};
+
 static int amd_pmc_probe(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = &pmc;
@@ -884,6 +879,10 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	amd_pmc_get_smu_version(dev);
 	platform_set_drvdata(pdev, dev);
+	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (err)
+		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
+
 	amd_pmc_dbgfs_register(dev);
 	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
@@ -897,6 +896,7 @@ static int amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
+	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
@@ -917,7 +917,6 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
-		.pm = &amd_pmc_pm_ops,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1

