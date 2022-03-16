Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F824DBA1A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353348AbiCPVaz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358094AbiCPVav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 17:30:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80E2611B;
        Wed, 16 Mar 2022 14:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFWtZBh7KrS6XctWuDA2GyK/OaxAYvqGgZsh7VpPpn/fSmC7kDaGVb8jkHbuoWVFKvYmm95w6a7cOkYemBL1AYlzt/Th4srH2clBFzgBQTDis75+YIr7nY8L7q+jtqeAZpeF5Wo5u0o1BVD/3DtVaPUnqqI8gaN7LB3t3SSQg64DbSe9zMLkWXbe5jauh6NaKXKu6KzSIR5dL73Zpq9tNvaSkFJ0S4HKzHx/hGRpwvL5QYJBsP0KwYzZN4kmduKnyym1SpAyGPyUjEkkNrlk5Yii9Dw9oupWD2I6vLo1+vOmgNM51oEWc3M3ymJjr5OXHaMzjYiZFDktsvPUEdXpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIJAwma6dVSTR0nJFpcIgdHSrYuE9iFGAkD/WAsYhEI=;
 b=SAPGs9tMXNC3GjzYf3g1S/Ici6d0yQIwEhyN3yI06i1ynA4YnhEnlb6hJLgTqGzUcD+eXKXsD7k5jRlMXZWRWpSJARwW3by03g7JixADyVgC8FfQZZSlfshF05OofXZARRxP3FNRJbR49/3DrDsimHMdqtMKa9LCsdD2jDLCWX2DEBGM+HElLO1azTVTFkfybhQVLaAjCQeBN579fHVuylKcB2flDLSazkZOfQ3LryUTLbveUEx4DSexrq8SbCQwSQD1Bw6CRUW7t5x1eetU2PLXRDF6Brgr584Opedpq0NoynaDV/L8dUa1xo4yToqOhdyx+b0PxZR3fJ+zo2UaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIJAwma6dVSTR0nJFpcIgdHSrYuE9iFGAkD/WAsYhEI=;
 b=gFyLz1G0ep46tXJLxNcYvtHJYf6IzF36YPx8gTd1ynKv7DX3keCZTDM1s8ZJ/KdnvXMKj/ZVauEjvIbCDwsJM7S2M517Z9b7QTztHQtAPWkQr7yADm/jR1UEaQu+9hcE4qq+wdRAUnV4obE5qF1PH5D+BWgFMOhzRl/bV16DpCA=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 21:29:29 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::bb) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Wed, 16 Mar 2022 21:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 21:29:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 16:29:26 -0500
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
Subject: [PATCH v4 3/3] platform/x86: amd-pmc: Drop CPU QoS workaround
Date:   Wed, 16 Mar 2022 16:29:24 -0500
Message-ID: <20220316212924.5619-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b32b99c1-3ed0-49f3-ae59-08da07940db9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02046B2E582990C6FCFF56C1E2119@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chDNpRICnJAMMEG6Vhsk8iKXEliR5HTuORTqDtUggVb8iOEbU4LEJqpzr+g9vdUOSKN+/5NUej/9Ly0OWG3dnyzEMk22yVZz6XTIPKvZ6373tUml8vuVtm5zK0xl8IU8YL8GwhMpAzK+nZDtmOkhR74zDYEzQusP5VoalANbdP+q8cPMv2rYtZ/fuAYpmGl5hdjlhnWmxgUT4T5QEnAxF0px5htF5l3lW0U+8x7DPhAD3wPzQGuV81rvOHJrAacGlOMA9D7QD1OKO3joqw26b/+P4EGNnt4f3h95qqGbSEsOS6TQKYPnzWx9BO/clMCFqTEHAPI3li6RYYK0oQ611WT+V+GnmJVOuA0ppXhuHoStHGnavfwrB6w1s4m7JpcuCfX079MYHSTXfqtnxUREaSD1sjLZwwX/2ZE7onzqYHdH7KbBLce/Oj2h3Z1YHI8pPYEMiAqOhmTOcf8BcSch6lBuHEbCwya2yPaC+t76vBZppUY2s8vYOaOgnnCHE7jhJT7sax1H9zDQZQBWnjJVDzDC3+saiV5zXr0QYivFjYntJfbN2m6E/BT3IxixLf1fBWk1vI1oHZZX0QVXKXqV8Z4kIGZpacbYjF5727MocUqNSNNuxazwQYpCtH7Oq3xJkX0459meYwdv6tKMtggPbZywS2sbJ4kBZCL5ChCj9jH/8Q6oQ6ko0mgYBKIZAK2RoLMIjbZgRyX/54QI6nWq/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(110136005)(316002)(2906002)(36756003)(70586007)(36860700001)(508600001)(82310400004)(70206006)(44832011)(5660300002)(8936002)(4326008)(8676002)(356005)(81166007)(86362001)(16526019)(47076005)(2616005)(7696005)(1076003)(336012)(426003)(83380400001)(186003)(26005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:29:29.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32b99c1-3ed0-49f3-ae59-08da07940db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A workaround was previously introduced as part of commit 646f429ec2de
("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup")
to prevent CPUs from going into the deepest state during the execution
of the `noirq` stage of `amd_pmc`.  As `amd_pmc` has been pushed to the
last step for suspend on AMD platforms, this workaround is no longer
necessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v3->v4:
 * rebase on earlier patches
changes from v2->v3:
 * No changes
changes from v1->v2:
 * No changes

 drivers/platform/x86/amd-pmc.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index d4b1bf4b58b6..2ba79b2bb97f 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm_qos.h>
 #include <linux/rtc.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
@@ -96,9 +95,6 @@
 #define PMC_MSG_DELAY_MIN_US		50
 #define RESPONSE_REGISTER_LOOP_MAX	20000
 
-/* QoS request for letting CPUs in idle states, but not the deepest */
-#define AMD_PMC_MAX_IDLE_STATE_LATENCY	3
-
 #define SOC_SUBSYSTEM_IP_MAX	12
 #define DELAY_MIN_US		2000
 #define DELAY_MAX_US		3000
@@ -153,7 +149,6 @@ struct amd_pmc_dev {
 	struct device *dev;
 	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
-	struct pm_qos_request amd_pmc_pm_qos_req;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
@@ -628,14 +623,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
 	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
 
-	/*
-	 * Prevent CPUs from getting into deep idle states while sending OS_HINT
-	 * which is otherwise generally safe to send when at least one of the CPUs
-	 * is not in deep idle states.
-	 */
-	cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req, AMD_PMC_MAX_IDLE_STATE_LATENCY);
-	wake_up_all_idle_cpus();
-
 	return rc;
 }
 
@@ -655,7 +642,7 @@ static void amd_pmc_s2idle_prepare(void)
 		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
 		if (rc) {
 			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
-			goto fail;
+			return;
 		}
 	}
 
@@ -665,17 +652,13 @@ static void amd_pmc_s2idle_prepare(void)
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
 		dev_err(pdev->dev, "suspend failed: %d\n", rc);
-		goto fail;
+		return;
 	}
 
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
-fail:
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
 }
 
 static void amd_pmc_s2idle_restore(void)
@@ -701,11 +684,6 @@ static void amd_pmc_s2idle_restore(void)
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 
-	/* Restore the QoS request back to defaults if it was set */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
-
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
 }
@@ -884,7 +862,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
 
 	amd_pmc_dbgfs_register(dev);
-	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1

