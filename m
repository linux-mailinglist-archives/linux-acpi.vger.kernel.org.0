Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3679855D
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Sep 2023 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjIHKC0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Sep 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjIHKCZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2023 06:02:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DA1FFE
        for <linux-acpi@vger.kernel.org>; Fri,  8 Sep 2023 03:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxVuRZ6JcwYLg3uVnFCUCttAqHq5IU76p8SlhdyRZq+5GI1NEBKQvrtuYkP1aHUMT2qvUuVTfTZL4jtKNBQ/3v1t0S2c6qJSLOcFJsvjMiJAZ4Ig3Fuc/+R6Dx5Q8kY/7hpIJA6nLE1OyUnyOYrWwrVZpNBszD9Z2ZJ/krRnSMBWG5T6AXlRCas1CphTI1z9L5Mr3UjLMPrKDf6j4YKU/BJjeT436JfGS+lA2+1g7dNpZ2z4j3Xsm+NYKbbZJlbJzFsjJrQXnD8vHVFXESBq2Yg7MQrRlaSlgbedZSLPUapUWHLo0beTYWBgm6qAOaTYpg7mfQ+JaaPfRy27uA1NJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpPAkoKWz/UrFl3XNGEwpJVGZRefTf/I6Lf6fw9LYpI=;
 b=nTjlTpThtj7JwIOpN64P8dPmTqCImnwCd8q0dP0D35UUF72lNylFi2B9PIpiZEj3Ab9H7X4pzXNE7bYyAinM9/v/2suydr24wbeGEs5NQJaU6bgpxbxXfgsSu7aWoWQoR5C7YLbpja9qre5/gWC77tIjrPIxFmh+w9/zpXmVRXB57prKvYLVz5zP3BtV2w78XB2SzGufV/PREiOJXiv+Z3yQ98/QAgM1geeERj8XDXFzopntzFrri2wdfwTZOXst8Hz1k5r4tUBYIdTUmO2jsVPsAUGhY45FaAz7d3lZ4LbLUIgen0po9QdaRK7H7vBWzwmF0aI6T+3HfDHhw4oM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpPAkoKWz/UrFl3XNGEwpJVGZRefTf/I6Lf6fw9LYpI=;
 b=V31mcx9SNSt8/vefTEKeegBkDQpIX79N+mNylVZoIArrORWeOabiAQrLjGwaETV149rUicNyaEIl061UtkdzNvDRRHlzg+yOVhMg8j5WR0UMG945Ma2olHJzvxYT0k7vQwwDy+px30t1zVqBuDRDa7XWcg1B54PubZw9GobnCrc=
Received: from SA9PR13CA0128.namprd13.prod.outlook.com (2603:10b6:806:27::13)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:01:23 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::1a) by SA9PR13CA0128.outlook.office365.com
 (2603:10b6:806:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 10:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 10:01:23 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 05:01:20 -0500
From:   Ken Xue <Ken.Xue@amd.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <Ken.Xue@amd.com>, <andriy.shevchenko@linux.intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] acpi: trigger wakeup key event from power button
Date:   Fri, 8 Sep 2023 17:57:49 +0800
Message-ID: <20230908095747.446389-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e82eab8-c547-4027-bfcc-08dbb0528ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0h3ubVNRvZz66YlfHe4cvigr3uL/JSCT9ZTzGi3+xDV3B5T4CtOajXR4SpYGlZOm3B/qQMY8Wn+szVhpSNEKQHqPgspZO/aKduOykiImQf64zLF8fm7nJ92wtnPmvEVhepI+s8jDXVYc7tjcEh0DvkhhT6ife3RRjxsiy3avU5kUlVLqHdXBf68BvngXGyvrC0AEa5R2twbs2NfGWZiBieMtiMiMr5EokyAVE3pbrhqaJBZAORWbFxMsiB52uvBBPDQopIsLOtWPrvkasPFYNvyLCm0FCf5pSD9fM51C4yu1XUemUIAmAMqaKRP2tvmakbd+hlT954cZSNM6xfQtH0gAZvvsMnK9i1w2j4IwYo5Y+G0ceNLaHMcR54PPRdhZl3UetXeIsuLT8XBSg8jWu8W6JA1PyeyHIDWP6hbOvEdDy4LDpuTHTE0N+Xwcck7go4zgH/y9SIy4cN0468WysY2blHuZudWClsC4rwtvMdmSfPa+fBQYKWKXG2Gh1K2oCBiVMMJiemTMGqcQk/edVqPSBf5ehkq3yVGK7/OQJkaLgMKAmcQmZI+zf8kmQ7Mz+7Ht6xbAsVvOgVCIFF/W5qGjUCzD/gQrpfI7w1m2V19yJvoTa7VF6aXgi7II7OHrHlCGAqGMp88Q5iz+z1c/B0EMIn30gjAxOuYdde2G27xDBolXU3x4uGSn97AZtQLIglT1slQxIn5ea0Xr2yoZ4czkj6eFfHA1sw9H9OQMEi5TvSbvF494B6SQYf3YWAeyYcmSkFkJMYZ4duFBc9an1CEVwCr7xxb/4JJfUmwBw4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(356005)(81166007)(6666004)(7696005)(40460700003)(36756003)(86362001)(82740400003)(36860700001)(40480700001)(47076005)(1076003)(26005)(2616005)(336012)(2906002)(16526019)(426003)(966005)(83380400001)(478600001)(41300700001)(70206006)(316002)(5660300002)(70586007)(8676002)(4326008)(8936002)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:01:23.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e82eab8-c547-4027-bfcc-08dbb0528ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/


Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 drivers/acpi/button.c | 16 ++++++++++++++++
 drivers/acpi/sleep.c  |  2 ++
 include/acpi/button.h |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..0e0f30286c22 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -363,6 +363,21 @@ static int acpi_button_remove_fs(struct acpi_device *device)
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
index af2fce5d2ee3..fa0fb170cfb5 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,17 +2,23 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+#include <linux/acpi.h>
+
 #define ACPI_BUTTON_HID_POWER	"PNP0C0C"
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
 
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
+}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */

base-commit: b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
-- 
2.35.1

