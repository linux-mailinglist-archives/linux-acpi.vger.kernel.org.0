Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050014DC87E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiCQOQ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiCQOQZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:16:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67812FF92;
        Thu, 17 Mar 2022 07:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwtUIiqQnQHgHWHTBowx++dKH0Xz+qS5zqB8Ityub4bTHQx9Hb6ocmjmuflsB0HyeynpooOl9VLoHw1+1dQaPZ/5Dnd09BeGuIyYeP1vlOghMyXvca1onYAvr2Z/lwrT/5cBoMs1+4w8AqZdQ334di4R10POV5bLWvQDFPLmT0it2h3F3Ku8ma2PnXS/KvnEloqVg4VkqvZE1V7aYWftt/4i0a1YNL9OObQqNsh1NySpy7PaDvBdGZT95SOHzd1X12snd/UYc7+WeTktxQvFrWb0QRqC82bOmZ6HfN4EtYjI4biswmQwo9GYyaJWoY5gQojGD51Pf9FK5NshTDHRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaOSFhg+3Y/fOjaLLzq/DiwUkLVnyR0z+dWusFspFoM=;
 b=nMDfTwMOP05YOpgh5oynHm8y87wSI8GpIKdQHnzfjtFIxNWCzsdvwns3DoJqLOcgNT6py0c7RDUWyaOuXR/4sRRt/NkO4onZe4hUKBcsojcoECOHf3IIq6PwqBvgFLZJQbEAC+RsHf9w/wG7NdBwJplZP7tBGPgwYYHMSoO7A8m1RJtE1+UaL7Cz/iSS9gF+PhYtuiqU/TngBM7uS9ANSXSj35RgNblOFr2ERdnMabU9LWWiHDuujZ1RuhRY+OskyczTjWAhU6o5HckzqiFNba4ijlJzaR0jYKDndlLoeCMCMIcEASCVumIXbCZPr8zsG6XVPbGKG0GycW4yQ/V32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaOSFhg+3Y/fOjaLLzq/DiwUkLVnyR0z+dWusFspFoM=;
 b=KrtSBvBQfAr06fVPWetnViDvSV9/XMr4DLbQsf7KB+O1q94bo3QiGIFP078llWEDuMMPvngIRlbsZQbLmeaqcs6UUO6zgNsWD64jeE3M+TuejRoz1bV01TiNOJITP2Vna6upskCTjLyCnUMA6wxujkJ6wWE6RhonWhPSPh3LCNM=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 14:15:06 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::ab) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 17 Mar 2022 14:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 14:15:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 09:15:04 -0500
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
Subject: [PATCH v5 2/4] platform/x86: amd-pmc: Move to later in the suspend process
Date:   Thu, 17 Mar 2022 09:14:43 -0500
Message-ID: <20220317141445.6498-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317141445.6498-1-mario.limonciello@amd.com>
References: <20220317141445.6498-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e50626-cc00-4286-75ae-08da0820896c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB419049ED0DFE18906281B3ACE2129@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qkOUryv2aRwH9ZWIzkHdi59/OPIoQkkjU+hSAUqBYP4SdqdIEttmcD0nvUZnFAa7d9ouYWYl7OGKJmYs8WycZYr/Wf6NgwyHhl7plxN5jlmLoEUNPykKm1qSPfMMkcvwvf2ZKykqOSyV3e8IE8Ot7Y3NF4gHEodVW9TKICS8a8TUEjDC5R+mKc0ScvCUoihSC5eTcrcogXSPeMloAFmPhrPCPw1+t2VgXD/e29OL6BkPyUFUJjQLjNDp+0NHhIiD/JveowcxxUlX5MdNsj660Y/b+Hp/rxzjE58WlqtMQtmBNffm80oC5JVAx4Y0mvVQfZ9M1tT7Pi4sWQ1TsorVRu++qzVhPLty3Ws6KSSXLdY9+YBK8HWbBd1DsDC05LXQbV0iMqVaOj/n+VzMtbJ/owFXrj0CREXfx+KaUbxRMiwUJYfCm/zVK2H5UIyEwI6X9k1pTwli5KmtwzxQdjAwX7gSEyYbdqZVltiGZ1OSQJkGn0sVbAbOwsBZBVudA3vdUEo3WF2SjWUaLv1BFPk1Ev7koTsI+LBOPufs/I3MlKehtCO2vZIveD6cAn+7fEV5gBtzdkSuaHwCOMAQ0cQjVyFm50R9wZBytTr1Q3kalumvN4N+n2gcM9nnS4gTwLQFiPRkYmZ22Mc/UyfilB7VarpMwCSIpfH5xmTC8C1btKuQIvQtEo/ZSdrTv9ngIPI4v5gKlYbOxdPvJ4QxXtpHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(15650500001)(6666004)(44832011)(26005)(83380400001)(81166007)(186003)(1076003)(2616005)(426003)(336012)(7696005)(16526019)(2906002)(356005)(82310400004)(4326008)(40460700003)(8676002)(47076005)(36756003)(36860700001)(110136005)(316002)(54906003)(86362001)(5660300002)(8936002)(508600001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 14:15:06.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e50626-cc00-4286-75ae-08da0820896c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
changes from v4->v5:
* split into two patches
changes from v3->v4:
* Drop constraints messaging
* Adjust for changes on earlier patches
* Don't fail init if sleep_no_lps0 is set
changes from v2->v3:
* no changes
changes from v1->v2:
* adjust for changes in previous patches
* display a debugging message for constraints

 drivers/platform/x86/amd-pmc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 971aaabaa9c8..2736ab587f2a 100644
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
@@ -658,7 +658,7 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 	}
 
 	/* Dump the IdleMask before we send hint to SMU */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
@@ -672,18 +672,16 @@ static int __maybe_unused amd_pmc_suspend(struct device *dev)
 		dev_err(pdev->dev, "error writing to STB\n");
 		goto fail;
 	}
-
-	return 0;
+	return;
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
 
@@ -696,7 +694,7 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
 
 	/* Dump the IdleMask to see the blockers */
-	amd_pmc_idlemask_read(pdev, dev, NULL);
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
 	/* Write data incremented by 1 to distinguish in stb_read */
 	if (enable_stb)
@@ -711,13 +709,11 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
-
-	return rc;
 }
 
-static const struct dev_pm_ops amd_pmc_pm_ops = {
-	.suspend_noirq = amd_pmc_suspend,
-	.resume_noirq = amd_pmc_resume,
+static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
+	.prepare = amd_pmc_s2idle_prepare,
+	.restore = amd_pmc_s2idle_restore,
 };
 
 static const struct pci_device_id pmc_pci_ids[] = {
@@ -884,6 +880,10 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	amd_pmc_get_smu_version(dev);
 	platform_set_drvdata(pdev, dev);
+	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (err)
+		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
+
 	amd_pmc_dbgfs_register(dev);
 	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
@@ -897,6 +897,7 @@ static int amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
+	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
@@ -917,7 +918,6 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
-		.pm = &amd_pmc_pm_ops,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1

