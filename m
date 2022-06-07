Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E465317AC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 May 2022 22:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiEWRjU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 May 2022 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiEWRht (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 May 2022 13:37:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7615DD32;
        Mon, 23 May 2022 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653327112; x=1684863112;
  h=from:to:cc:subject:date:message-id;
  bh=1a6xvUVraNwPsJU4Rdg2VoIzY6z3cXUo5L9xyuMQW10=;
  b=jZZ4Ss2cC9FdaYUiYD7eMciUNKwWofAf83XDg39+G+pLQdKr7UfIDN9M
   NOZ5dO/pIEExNs0Q5Qe/7WhDsG0mkigC7xumOAZsnp8XX6ry1/hqqaJXY
   krrRtjY+/tL5mVpzLFBQkARspOEYeiwZxHh+8ECCDD6T831NcpTeNqQ8g
   325H4AE1/A1Sl1kQbC5maHrz9z1odexDxkaxdq3iPZREZH6ijuEqyL7t9
   NLHukXG80s9R0v4i3Wz/5VWTg20ml8X9VBT8fp+D3Ab9vteLajrdB0T3p
   V9A1U5OuTQLoC8ezi8Mqe+l+LNQRV9D964k8TLedNEY2nfeDybM/wOyMY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272115807"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272115807"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="744846445"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2022 10:30:14 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Support Meteor Lake
Date:   Mon, 23 May 2022 22:57:24 +0530
Message-Id: <20220523172724.30556-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add Meteor Lake ACPI IDs for DPTF devices.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
 drivers/acpi/dptf/dptf_power.c                          | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
 drivers/acpi/fan.h                                      | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index c0da24c9f8c3..4919e7abe93f 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -151,6 +151,7 @@ static int pch_fivr_remove(struct platform_device *pdev)
 static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1045", 0},
 	{"INTC1049", 0},
+	{"INTC1064", 0},
 	{"INTC10A3", 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index dc1f52a5b3f4..a5f29d061b37 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -231,6 +231,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC1050", 0},
 	{"INTC1060", 0},
 	{"INTC1061", 0},
+	{"INTC1065", 0},
+	{"INTC1066", 0},
 	{"INTC10A4", 0},
 	{"INTC10A5", 0},
 	{"", 0},
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 42a556346548..b7113fa92fa6 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -27,6 +27,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3532"},
 	{"INTC1040"},
 	{"INTC1041"},
+	{"INTC1042"},
 	{"INTC1043"},
 	{"INTC1044"},
 	{"INTC1045"},
@@ -37,6 +38,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
+	{"INTC1062"},
+	{"INTC1063"},
+	{"INTC1064"},
+	{"INTC1065"},
+	{"INTC1066"},
 	{"INTC10A0"},
 	{"INTC10A1"},
 	{"INTC10A2"},
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 44728529a5b6..e7b4b4e4a55e 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -14,6 +14,7 @@
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
 	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 79931ddc582a..1ea861473cba 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -669,6 +669,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INT3400", 0},
 	{"INTC1040", 0},
 	{"INTC1041", 0},
+	{"INTC1042", 0},
 	{"INTC10A0", 0},
 	{}
 };
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 07e25321dfe3..71d084c4c456 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -285,6 +285,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INT3403", 0},
 	{"INTC1043", 0},
 	{"INTC1046", 0},
+	{"INTC1062", 0},
 	{"INTC10A1", 0},
 	{"", 0},
 };
-- 
2.17.1

