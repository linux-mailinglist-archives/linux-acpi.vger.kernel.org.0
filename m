Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95E4DC882
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiCQOQe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiCQOQd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:16:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947211F79B;
        Thu, 17 Mar 2022 07:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR/nt+sHNKxpQ/+UGaqaVA/fMo/iUxMfnVpv3oh2Y/TvhdnxyDjU26h3V/KnPf69tJGGvIcKbyVGJeDsZdHUJSxqlcAEAQSZRt9CryoMNnr82gr3NoD3KGfgtDnW0i9CDYC+2RkGOgyMYOpQ7+8gPVWAgM4Ew7PDxmvSETS8NDXXsUzNyWslKi4ORWR7W74undXgcaDKHYC/9a5zTxvjCl231DRgDGL3IT8Xbzb/PyoCbwXaYequiryu6PH715Uy1Ommz403pXxAEeTKWzrd1UllPw6c4Xfo9BmmFI2hxI3FeNoB+u+RXsJZCPrfc/ungNM2yWYJJzYcOQ4GfAUeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BK7WX43OaaA2tfp/nsRWxHSbPBE7xnjn86qaly80RM=;
 b=fI56kor1UtCO7DLzyguHnT5T7x7SzwH/YLlcGzJMqfUEwFdCbqSppNi56NZ2JgMLrExa84vdF0Y6vT8JgEbtrZUR0knFxleQYA2u6gahems0UcMvirKNtTFcECPKaMOoNy0fjlFeYSRi6l4Et+j0Fpz4vVK7XVQr7Mm6fmSH0mrkVpclPN+PIxvZ/Hz/TFexRpHHSqnM9YV/WkDmNP5QIUEVrt4m5u1K5/4yDpLHnLkbSFUUf64CK+8e2vMRXSUK23ZlovNZtB03qAF8j4/S/1MyIZQyNmrQgHbHfOcedPYcdiDQKoFrMQ0KtK4wM90WJfgRfahA82kgYFiVJbu/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BK7WX43OaaA2tfp/nsRWxHSbPBE7xnjn86qaly80RM=;
 b=GAUJvNldmn+HsEW+AQyUhN+to7ERBfw+H68xaTOPk7zj6x/s9GKZ34ts9SB5zBvk88P2t3BDLviRd4njYqF1/uo0LuyMrFX4myT4QVCqDQvWSo5OjZZkCcE9EpH/ByqFhHidrCITCcS2q/xOLuG01tp7t8BHTOaWNEGEKBRPjZA=
Received: from BN8PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:d4::25)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 14:15:09 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::88) by BN8PR04CA0051.outlook.office365.com
 (2603:10b6:408:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Thu, 17 Mar 2022 14:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 14:15:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 09:15:06 -0500
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
Subject: [PATCH v5 4/4] platform/x86: amd-pmc: Drop CPU QoS workaround
Date:   Thu, 17 Mar 2022 09:14:45 -0500
Message-ID: <20220317141445.6498-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 683a665f-b7a7-4d86-32a5-08da08208b36
X-MS-TrafficTypeDiagnostic: BL0PR12MB4931:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49316BE1B389C7CCE88B2680E2129@BL0PR12MB4931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdaOR42wWlEQw3Z8NJmFoHAwSdNhqbST7fxC+7Rw1gr1r/WLglpbBDABuuMYStEFPcZyGFNdMdkvP5ZveV6VsZ6E9+pETEWkkJCI5YwSZCyObbhfJTDz06xEH8cBNt6atD0RHfMDniNO63DBZccgQhDVmnAgrNWMQ8sLeE5ARGuQqXSYtXAToUtMi0RaZ8irqu5OyY+5WzDxLt3UtbOVRzK7J/A99tUQ282uZFI4nmpSSbSwrlDsK1EsvkR7wNHepK4HQQzxtTVFWnPpX5Wzdd/UpGiA625OdyWOo+rPnlzRQb3jythvW8rwgDOSnrBLCf2kgW43hUMUp2dFzJDU3v+I8J3aVnv7ojHQqY8EGPjpbG/7SYAG7MVIpZnVQhuDru8ELRRKnvxh4RDAsDKYrmjia1flpLx2sOI/w2JfB9LMwFyGGLqLGICTD4jpYUSd7igNvOlWR5v5mMlIhift1nB/+/JVQdXACo1xB/APvbzACHeu9FpPfOsDvgUg0/eOCi07LeiV7RwtKdUgZuwpPV2/uEV+wxD3WSLeIjIQ9Rp9x0+9AtzWpKiJBjoikHH7ZvZckbJMJfWIKkO7uaTuO/QgYKATRudylgbbQ+joIwr0QZ1HbmeTF4JtgEu6f+2G1P66EdSORjC6A7snk5Co60HVADHfSf7qFt3rE335+ckmVPImOxOaQfWfF9+gkdidgd8477ecBo+bQgpoHI4NJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(336012)(426003)(54906003)(16526019)(186003)(26005)(316002)(7696005)(36756003)(6666004)(508600001)(2906002)(44832011)(4326008)(82310400004)(36860700001)(86362001)(2616005)(110136005)(8676002)(70586007)(70206006)(83380400001)(40460700003)(356005)(81166007)(5660300002)(47076005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 14:15:09.3125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683a665f-b7a7-4d86-32a5-08da08208b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
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
changes from v4->v5:
 * rebase on earlier patches
changes from v3->v4:
 * rebase on earlier patches
changes from v2->v3:
 * No changes
changes from v1->v2:
 * No changes

 drivers/platform/x86/amd-pmc.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index f36cf125b284..7317993cd91b 100644
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
 
@@ -665,20 +652,13 @@ static void amd_pmc_s2idle_prepare(void)
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
 		dev_err(pdev->dev, "suspend failed: %d\n", rc);
-		goto fail;
+		return;
 	}
 
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
-	if (rc) {
+	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
-		goto fail;
-	}
-	return;
-fail:
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
 }
 
 static void amd_pmc_s2idle_restore(void)
@@ -704,11 +684,6 @@ static void amd_pmc_s2idle_restore(void)
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
@@ -887,7 +862,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
 
 	amd_pmc_dbgfs_register(dev);
-	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1

