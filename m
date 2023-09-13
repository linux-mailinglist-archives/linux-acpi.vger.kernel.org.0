Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1A79DD3C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 02:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjIMArK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 20:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjIMArJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 20:47:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E3D1713
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 17:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8NQgdhgZ12cYPbYgQf6QHIEe2A2W2JdbPDcmE8zW8GYcYiOh+MMi83HTl/QMlMclbrL+E+I0Tm859Ew6gsrQiDfLbiHSoteJsB0exhj2bkWvYyZHZoXZ/ihny8mpKQAzQ2OwT0ab6YIAnKJd1fVzqcz1o5SDrwrJ4iJV+C/hlGHR10A+KstBsubJQsWG5mUR0GHC+xX58iwaLq4uhG36yHMZBa7p9rQEcgVeOVjvrQghyw8qDWBOmZINTBcZU/vYEMiiC9vRAliSZEKVSpczt3a+gSZ/LxpV1RuMvRHRqDw5Tomsh2/uubnV0fTG7p+05NtXSKvR23Yqgfb0UEB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt7NGH2ctl67zo0Wo42vZhZkC+0TzGKgSUt6stiHsgk=;
 b=c1Z7+HAD8xxbRaxTNquZnts7+QxMFmCaV50PfxHBrxGIrVIl6jVRH6lzW0dPEisN4SIW/Lxwp2qNK51oPCi+Gb4BnrzUo/fIt2aywwm8yHBOv0b46UxkX+9eY2dLeU8bJz83enIW4OsxZeuDTs5f9mwoAAZu5cFtqFUfejuzgQ35P8zEOHnYGTWtHyt74bn0o6qDkE5vjqoX8YYDJkyXchlOid/PjSbpE/5bCYAwQkBuXanJ6GuLYF92UW5rmYVBNHcpbigrc2C7oh4g7GGXV+P6vdFE2UNWmC7bi+E/ilky440pldfKJ4FynT2CFbKGgwLcdNHb4NCLxpiQdYLD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt7NGH2ctl67zo0Wo42vZhZkC+0TzGKgSUt6stiHsgk=;
 b=vP/teKHzFKepyB/4svIEoevFGXR070JAVl8NRlSmm/ZgnVJAjZFmlENj5wQBmI17O970W92QYGW2wS3k5ex0FMyJoxOFJStWxuH8kyHwn0vi2kXMrmZuHKAXyDqTWmI35DdRK426DqnOuvYtmWy5NdMDhBzyKUVufF/kKhlusOw=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 00:47:03 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::36) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Wed, 13 Sep 2023 00:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Wed, 13 Sep 2023 00:47:02 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 19:47:00 -0500
From:   Ken Xue <Ken.Xue@amd.com>
To:     <andriy.shevchenko@linux.intel.com>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <cwhuang@linux.org.tw>,
        Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH V4] acpi: trigger wakeup key event from power button
Date:   Wed, 13 Sep 2023 08:21:46 +0800
Message-ID: <20230913002145.743571-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7978f10d-23c0-4cec-8fee-08dbb3f2f1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26QUPZ+Mz+aP8eQ9F2OKBW8N5AqMsZ1av7fnQMWRF1bbQivQq8kVxp+EhdBdAuWsNrw4OdSMLwkXNGRFE0ZDQ8qQ2yKu6r625IpsN71bXp/Q5UiS3uekWXwtzY1gcccwSSOgPiXSHDNrkLQ5XsrSuk+Nc5Qz/wAU6OnEdwgYqH1hzGqn/5rBbetYnsXXOkhNDNg4WZvHPTA3Rh6Gh8gAqahV21OHbGXpQwfvdKfrZLcr79BirduraRNNNRqGjE+eEDWZJm5b6AfzeofsGLOcWpVmmxHlgphILKYg8wZ5x+Fb7zZcZn7SnBTPH78hXWatECEJ+2SoLS3FyEpVqULcvzHLIS4ezPtzKqnFpae0ZMjbiBdoRC3365k+1aCfKcPYxURZU9YnvjKjnhP9H6dOHekP6VeQmmP1VkhQMrkRZEkL3ZIYHr7u8lB1SQgnhNYNEsNVQ6PoUkmzgKruQjk6mYcjIjNt+VgGU843bv41S7n0kfApA0Ji/42gQHkuc7JO2bVS+ajtWK2/OljBWgo4vNR7NdOtZAIF5ALVGFz2FV2qiKk/Cn7dv8p+/A5VfTufMVFli7zqPSwiuX0x9ecVL/JB75MDxw7mDGIwtQqOCOPgxY67/YrcKydOrh/sLfD+iN7hw75diU+To2HmOrNCLQARbSycPEN9nhI0bjOd5+wYHz5fCGAuJ5CMLdsYQAHkRWl5hNTG7B1WIt00MXcu/4LsHoFzrXC9oylgl9HhO/YNKzST/Z2dVMm5zG2o+9I4JktEpJS3goHHKAcDIRpUkPIp83jouygAL1ntloFsEO8rv6G5aFzPl4lC5d/reLHG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(86362001)(36756003)(40480700001)(40460700003)(478600001)(82740400003)(81166007)(356005)(1076003)(70586007)(2616005)(36860700001)(336012)(2906002)(47076005)(426003)(83380400001)(26005)(16526019)(70206006)(41300700001)(6666004)(5660300002)(7696005)(54906003)(8936002)(110136005)(316002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:47:02.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7978f10d-23c0-4cec-8fee-08dbb3f2f1fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Andorid can wakeup from various wakeup sources, but only several wakeup
sources can wake up screen with right events(POWER, WAKEUP) from input
device.

Regarding pressing acpi power button, it can resume system and
ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
pm1a_sts, but kernel does not report any key event to user space during
resuming by default.

So, send wakeup key event to user space during resuming from power button.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>

---
V1->V2: fix some compile warning/error caused by lack of
        "struct acpi_device" declaration by including acpi.h.
V2->V3: use "forward declaration" to fix compile warning/error.
V3->V4: refine coding style and commit message

 drivers/acpi/button.c | 17 +++++++++++++++++
 drivers/acpi/sleep.c  |  5 +++++
 include/acpi/button.h |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..3baddecd66c6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -363,6 +363,22 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
+void acpi_power_button_wakeup(struct acpi_device *dev)
+{
+	struct acpi_button *button = acpi_driver_data(dev);
+	struct input_dev *input;
+
+	if (button->type != ACPI_BUTTON_TYPE_POWER)
+		return;
+
+	input = button->input;
+	input_report_key(input, KEY_WAKEUP, 1);
+	input_sync(input);
+	input_report_key(input, KEY_WAKEUP, 0);
+	input_sync(input);
+}
+EXPORT_SYMBOL(acpi_power_button_wakeup);
+
 /* Driver Interface */
 int acpi_lid_open(void)
 {
@@ -579,6 +595,7 @@ static int acpi_button_add(struct acpi_device *device)
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
 		input_set_capability(input, EV_KEY, KEY_POWER);
+		input_set_capability(input, EV_KEY, KEY_WAKEUP);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d11209..f816606abd71 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -20,9 +20,13 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/syscore_ops.h>
+
 #include <asm/io.h>
+
 #include <trace/events/power.h>
 
+#include <acpi/button.h>
+
 #include "internal.h"
 #include "sleep.h"
 
@@ -507,6 +511,7 @@ static void acpi_pm_finish(void)
 	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
 						    NULL, -1);
 	if (pwr_btn_adev) {
+		acpi_power_button_wakeup(pwr_btn_adev);
 		pm_wakeup_event(&pwr_btn_adev->dev, 0);
 		acpi_dev_put(pwr_btn_adev);
 	}
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..6126d665aa42 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,17 +2,21 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+struct acpi_device;
+
 #define ACPI_BUTTON_HID_POWER	"PNP0C0C"
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
+extern void acpi_power_button_wakeup(struct acpi_device *dev);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
+static inline void acpi_power_button_wakeup(struct acpi_device *dev) {}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */

base-commit: b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
-- 
2.35.1

