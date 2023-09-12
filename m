Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E079D1FA
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjILNVI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjILNVH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 09:21:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBE10CA
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 06:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ+9AqfknhAcK4uZ96ZDa0xIN7PczX9+LP6ZWtfaK0XI4bnzD58YBlVSeE+j//8CZS7uanx20/O4+zxzy/lq8BMD7ta9tnnKyYZTNMjfSxLwkuOlNfRG0MNBuBZkClNzvwjsLHX2QLEkHXpxAYdDDP3v+gu6Jl9zfbESH8+9g4cSv/E+gKx+0d9BB14JaqtAzS1sK/4/9HzxNUCcS/8vQQvOo8HOm9oyupKiMjkVVJjTCLBXUfDRf2I2uXcTXqSb/ofA9Vr1ZKb9fB6t+bRcIx1T5o76Y7iF0gjDqXvaf9AgFrX9hPMsX97VIL8cgChAqkT2gx5ytmF6USTN8Z+K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufyn6d3prl6NZY6owdW4W7004+W2icrwGMMQS44kF9Q=;
 b=D8o+ACNkknULb4D8u2QQqsMQito83KNLk1m2w3w5IH+OzvHT0Yo9ShlSMZZUp1ISqNNfzgkIj7mkSNn3YgN7RqnV3FsDUdlNM64W47CDu5pvDYjEn4uBKt0Q0zEt0KvLkh6Y6VGn4ZbB9U9F+bhh979c1eNctXvKnZqxlpo//AiC/tgyeGrlKbn/IlIViPTfp6JtdEs+EPtEZ5BriJ/hhCQMRvsKi8P5NpzayNeKQGG935b9g3Db3X0aSJQ0bM0V1n7LVTc6GkDVhPA1U8H3azW1Hm+ORdi8cf7ZoXunxO3du4DQljlEa350FtqSoXa7iGY2QbqRTzxaqjOju9g03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufyn6d3prl6NZY6owdW4W7004+W2icrwGMMQS44kF9Q=;
 b=r/OPfRlONrS4EDx3eX4PVq42hn95ii7UokLnK86QoarP2Fsktjo8R3byn0lGLVlblV77iNjNcOTGs3Q4pDCVR8JBxAXaJxOY3KBcSsCrw9W6/MLxwykGrLEr17wlSDprT2Vw6C9iuP7rkHkDFpXTJAZZooXvyDqj3b8z4xWY1BM=
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 13:21:01 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::61) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37 via Frontend
 Transport; Tue, 12 Sep 2023 13:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 13:21:01 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 08:20:59 -0500
From:   Ken Xue <Ken.Xue@amd.com>
To:     <andriy.shevchenko@linux.intel.com>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <ken.xue@amd.com>, <cwhuang@linux.org.tw>,
        Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH V3] acpi: trigger wakeup key event from power button
Date:   Tue, 12 Sep 2023 21:16:06 +0800
Message-ID: <20230912131605.734829-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c00c13-b680-4297-ce57-08dbb3931bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sj4QWcn1ps72Y1qgENNj4dXC6JyiaNzmIEd73QoNbKzVQFDUg9DHCOGqThjfysia4OmQp+GHNAgaqoXJUkJKJKttym1Rl5HtxpzFC/7SGH247utLN8K+9RnW+aVFoXvjPLQ8VZWVqzljtO2nvXUqlfsz4jwv+1Ax7RBfiauR7/pC5o4vI2o4pdmarEDkAesSKoQg3b1gqnrr5lsMFwaqwLyig3PqX/P60Z/ASefnZZJ3S329y4KFq0t90V2qu05ONp4rmizDQaRnGHnIVk3NAdAp9aIk4Lt96nP2TIhdtl37vlCL0YZrPvG3OuHOl0vOnX0GNB/pbFEeqwSaK+a2w63xOH1+Hirx0roIeOnHTuz1j68QvE7SPp5Rd0EutxFGh7QJEFlIYszfaGLO+o6cNDxrhHwY9q2zwUOQs7DUB5T0h7p3EqsW56+KII2F0PPVz9ivd+5GFGK26ehpN/6xj8ncWjcf0ZAotnEmxluGSSZ/Sr1NiZxgM3kJf5cUhm//TXdfG4NZc7to6g3TIl+cmmbIKwJAhjKmEAMjcg+wlMNOdGc/T4prU4Ol1wZJcZO4MSeMimsr8CrI2UtQ4pD1ujQXOICmYB35/Z5vAGhefen7olobWOrccYP+dIjvRxN2uPK2Ym6ep5CDbhEft04rnEutkRojZQYj0nfWUIaBBiawsuY96CtDxevsgx++ybcUk0V805rz8AMCggUNjuRCUEoT/3PGSudtcPqPuuyk8TDV93PIJvC4zKUKLQbnqhpWrmrMHAJdtLTseWWjqw90RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(356005)(426003)(82740400003)(81166007)(36756003)(40480700001)(86362001)(40460700003)(478600001)(2906002)(110136005)(6666004)(8676002)(70586007)(7696005)(8936002)(4326008)(26005)(5660300002)(70206006)(41300700001)(54906003)(316002)(47076005)(36860700001)(83380400001)(2616005)(16526019)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:21:01.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c00c13-b680-4297-ce57-08dbb3931bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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
V1->V2: fix some compile warning/error caused by lack of
        "struct acpi_device" declaration by including acpi.h.
V2->V3: use "forward declaration" to fix compile warning/error.

 drivers/acpi/button.c | 16 ++++++++++++++++
 drivers/acpi/sleep.c  |  2 ++
 include/acpi/button.h |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..3b8aa071732b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -363,6 +363,21 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
+void acpi_power_button_wakeup(struct acpi_device *dev)
+{
+	struct acpi_button *button = acpi_driver_data(dev);
+	struct input_dev *input;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		input = button->input;
+		input_report_key(input, KEY_WAKEUP, 1);
+		input_sync(input);
+		input_report_key(input, KEY_WAKEUP, 0);
+		input_sync(input);
+	}
+}
+EXPORT_SYMBOL(acpi_power_button_wakeup);
+
 /* Driver Interface */
 int acpi_lid_open(void)
 {
@@ -579,6 +594,7 @@ static int acpi_button_add(struct acpi_device *device)
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

