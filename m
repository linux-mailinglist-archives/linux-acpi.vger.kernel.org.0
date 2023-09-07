Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9479736D
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjIGPYH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjIGPYE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 11:24:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE57184
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 08:24:00 -0700 (PDT)
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 09:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfvHo9Xi+sdF9dHod9wq0Og3iNQkmaNuxdY37hsUcE8XmrpQ4kMHlzBiW+MhJ6IOulUhnbgnuVSLAkfqNEUB+Kp59AF1EKzPLZLIyxP9vN6WUx4UEL3QwqKKVBsqQ8fAYgBC1z+M4VADWngoT6msCYRRimC6haMXA90h55TxnAmhBgMz//YwjfXezrym8LFCZcseJSL5z91uhRF0hPnIc8t2iCZCgAZJULAkHj975J5Uis2JY/vHBNaxfgw/8RicmHFTOhrBQeYYGHTKEuPeQnFK6n2VqAtTfKWw3L0lF9BvzXHXjXHPKVFtqC5ahwDzt924eIdmeTIJZjnJEtYykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEOzMLJVRwgQGzL01ElYdN4scnmBUml8cqnMiU2L+KI=;
 b=Y7c+stdmrDD5Oben9eEuz9uTPaL0OzR2PmGuiSRYGEcxyCkb2LS46eEpNuaV8aCQYZNPcSaGkSHL1L4Fb9m9XCUmawmlQNA16sVea1U1XorW/9QDX1G0dJJIS3vsPRdZSUkrtMLmYg5qk+WL5Rw+hjIKqwWt8ItlyMwMIdGaIvsMISR0FpKXCrM789IG+aUkpkVXJw+gh1MNJ2J93GPLSuJp64ERiheewI+Ka4mS/IyJbapQLVDExNkwpJ1xSjJWsTk3IRq2pVoTXbgerVIws3tifxZ9GeQAn4PIj4kjSVm69d4ibO+FfwAZfpSEtrDAUmktWw75/qnNbttYnWlk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEOzMLJVRwgQGzL01ElYdN4scnmBUml8cqnMiU2L+KI=;
 b=xIbXpOgHO5/1E9GcRN6/lh+ZKorfjInGwHA6ry8YrQ6BZfPZ1+n79gX5z/QHp/Q6K9yg+E6YJK6PwUtnF/YBuBAxkhieJAQ2mc5+WFmt9iKerhDqDxar8pPwg2ViZGsfyCnAmlP5vVHzIxh56ZkbCchnbV7pqbS+uQkwYN3Fu9I=
Received: from DS7PR05CA0068.namprd05.prod.outlook.com (2603:10b6:8:57::20) by
 BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 07:44:22 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::21) by DS7PR05CA0068.outlook.office365.com
 (2603:10b6:8:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.26 via Frontend
 Transport; Thu, 7 Sep 2023 07:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 07:44:22 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 02:44:20 -0500
From:   Ken Xue <Ken.Xue@amd.com>
To:     <linux-acpi@vger.kernel.org>, <rafael@kernel.org>,
        <andriy.shevchenko@linux.intel.com>
CC:     <Ken.Xue@amd.com>
Subject: [PATCH] acpi: trigger wakeup key event from power button
Date:   Thu, 7 Sep 2023 15:43:42 +0800
Message-ID: <20230907074342.7722-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BL1PR12MB5349:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d6d867-c5ba-4d56-0aea-08dbaf764084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW5mZOoomudAoL/Ey9ikbT3fVlxNx1NxFX5Lk+bENkkeN+LItmxy9asrcZnZC905FvwDYGMdULF+7FpgrTBFnnUMLmi3ZoKh0r8kjh/83oSC90nlcFBxWgZvrf6jTYRAj4njEl61sCudRz+qKb4BVmbnMgcPSjGEK0l9LL4096bVqCoSZ/Q+UVlbxoliaWQhpNXu5vOFV9X4nq6fr5ifKXAyJOIajOWPwhBaHHd5MxiI8VZel71HMuzDnU2P/ptTbMol9U2gTCAcbYtJqhC5grYuq+Urmq5xYJAgBHbpN2mVXt2qXFkakA9nEa3X7bsJ+BMaByQflE7v7l71wzfGqFgy73b4Yj5grmPotPqCnSFZFr3CEf8nqju7NjOsl106HgcMkGcaVseysVrbQNEWGopzi7ha+2c7UGobEDi0D/PsZ2WTK806vJ1P4PFr79ZgXLvumj+y16N+kN7MBY8Kfsd5KzCg3iGEIBshKhP8/4gLp0R+8SnSo9SBtmS23JwRLFJv5HwRPziSz5rg5Vcv53iE0bhrXKtOQbHyJ+E6WrPOYl5LtpD5jvNxwGv2gwrz9RI5xiY0v2I6AtOziFFZmLaFa8VJeY3me2FemZVh7gsCSForLu6D1DVd8CWRVh+0OHX7zvomjAzH6YJMMZA64KYyEkgSVNWZsV18Rx2GlSBWfx8DmX6gPLsoIiYVTX0zxqADMfrE0lbHBuLtzY3mCs1zjBs/1v+TzcwTXXYJ9MryCv+WdAKLrjqqten1VGzgvc6il/D4D4Hzzwz1oQUODg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(41300700001)(36860700001)(5660300002)(86362001)(6666004)(478600001)(2906002)(8676002)(4326008)(8936002)(316002)(70206006)(70586007)(110136005)(26005)(1076003)(81166007)(16526019)(7696005)(2616005)(40460700003)(356005)(336012)(426003)(82740400003)(36756003)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:44:22.5360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d6d867-c5ba-4d56-0aea-08dbaf764084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-OriginatorOrg: amd.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Andorid can wakeup from various wakeup sources,
but only several wakeup sources can wake up screen
with right events(POWER, WAKEUP) from input device.

Regarding pressing acpi power button, it can resume system and
ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS
are set in pm1a_sts, but kernel does not report any key
event to user space during resume by default.

So, trigger wakeup key event to user space during resume
from power button.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 drivers/acpi/button.c | 18 ++++++++++++++++++
 drivers/acpi/sleep.c  |  2 ++
 include/acpi/button.h |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..22f41526731e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -363,6 +363,23 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
+void acpi_power_button_wakeup(struct acpi_device *device)
+{
+	struct acpi_button *button = acpi_driver_data(device);
+	struct input_dev *input;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		input = button->input;
+		input_report_key(input, KEY_WAKEUP, 1);
+		input_sync(input);
+		input_report_key(input, KEY_WAKEUP, 0);
+		input_sync(input);
+	}
+
+	return;
+}
+EXPORT_SYMBOL(acpi_power_button_wakeup);
+
 /* Driver Interface */
 int acpi_lid_open(void)
 {
@@ -579,6 +596,7 @@ static int acpi_button_add(struct acpi_device *device)
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
 		input_set_capability(input, EV_KEY, KEY_POWER);
+		input_set_capability(input, EV_KEY, KEY_WAKEUP);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d11209..dcd5d0237eeb 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,6 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
+#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -507,6 +508,7 @@ static void acpi_pm_finish(void)
 	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
 						    NULL, -1);
 	if (pwr_btn_adev) {
+		acpi_power_button_wakeup(pwr_btn_adev);
 		pm_wakeup_event(&pwr_btn_adev->dev, 0);
 		acpi_dev_put(pwr_btn_adev);
 	}
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..67e2dab27401 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -8,11 +8,16 @@
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
+extern void acpi_power_button_wakeup(struct acpi_device *device);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
+static inline void acpi_power_button_wakeup(struct acpi_device *device)
+{
+	return;
+}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */
-- 
2.35.1

