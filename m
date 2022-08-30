Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0215A694A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Aug 2022 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiH3RLr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Aug 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiH3RLp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 13:11:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6808B8F38;
        Tue, 30 Aug 2022 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661879504; x=1693415504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khrbh4gr+ZkSNoG8sXOunCid7R//3YaB05/qhwIX7Qo=;
  b=Yee3OgSorKU/59QmM0eQ5i0iu7aXGzSwoo9ijCgEhWGMKs/NpshjR5CJ
   0sAzAFF4GRJ0k0Getymu1yun02oDtp8wgM9LnAZyBHfVh1fuPk0mJPAc5
   VsRWl3fiey21VZHXZQv/rY9QOyMbwUH/z1Kpa+2VSXM0NwxzadAQ/6Z+Z
   TwgpfgkBzR5oweo3yXWBzkQzW0vyhb9FIim3iyOGeKvikGhCkSb5DmrN2
   PzoqgTnda21USEcazZe+7o4hk7me5gvvV763KeZQM2ELAnoESbH/2QkaT
   nfnWxkIr3ieYdN6k5fmEg0bcmkNnBLAigcUdxpmZccpI0OXUE5choKZMT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296525437"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296525437"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672961730"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2022 10:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9203941; Tue, 30 Aug 2022 20:11:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Date:   Tue, 30 Aug 2022 20:11:54 +0300
Message-Id: <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's easier to understand the nature of a data type when
it's written explicitly. With that, replace open coded
endianess conversion.

As a side effect it fixes the returned value of
intel_crc_pmic_update_aux() since ACPI PMIC core code
expects negative or zero and never uses positive one.

While at it, use macros from bits.h to reduce a room for mistake.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed inclusion (Mika), updated other drivers
 drivers/acpi/pmic/intel_pmic_bxtwc.c    | 50 +++++++++++--------------
 drivers/acpi/pmic/intel_pmic_bytcrc.c   | 20 +++++++---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++---
 drivers/acpi/pmic/intel_pmic_xpower.c   | 10 +++--
 4 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index e247615189fa..90a2e62a37e4 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -7,19 +7,20 @@
 
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include "intel_pmic.h"
 
-#define WHISKEY_COVE_ALRT_HIGH_BIT_MASK 0x0F
-#define WHISKEY_COVE_ADC_HIGH_BIT(x)	(((x & 0x0F) << 8))
-#define WHISKEY_COVE_ADC_CURSRC(x)	(((x & 0xF0) >> 4))
-#define VR_MODE_DISABLED        0
-#define VR_MODE_AUTO            BIT(0)
-#define VR_MODE_NORMAL          BIT(1)
-#define VR_MODE_SWITCH          BIT(2)
-#define VR_MODE_ECO             (BIT(0)|BIT(1))
+#define PMIC_REG_MASK		GENMASK(11, 0)
+
+#define VR_MODE_DISABLED        (0 << 0)
+#define VR_MODE_AUTO            (1 << 0)
+#define VR_MODE_NORMAL          (2 << 0)
+#define VR_MODE_ECO             (3 << 0)
+#define VR_MODE_SWITCH          (4 << 0)
 #define VSWITCH2_OUTPUT         BIT(5)
 #define VSWITCH1_OUTPUT         BIT(4)
 #define VUSBPHY_CHARGE          BIT(1)
@@ -297,25 +298,20 @@ static int intel_bxtwc_pmic_update_power(struct regmap *regmap, int reg,
 
 static int intel_bxtwc_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	unsigned int val, adc_val, reg_val;
-	u8 temp_l, temp_h, cursrc;
 	unsigned long rlsb;
 	static const unsigned long rlsb_array[] = {
 		0, 260420, 130210, 65100, 32550, 16280,
 		8140, 4070, 2030, 0, 260420, 130210 };
+	unsigned int adc_val, reg_val;
+	__be16 buf;
 
-	if (regmap_read(regmap, reg, &val))
+	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
 		return -EIO;
-	temp_l = (u8) val;
 
-	if (regmap_read(regmap, (reg - 1), &val))
-		return -EIO;
-	temp_h = (u8) val;
+	reg_val = be16_to_cpu(buf);
 
-	reg_val = temp_l | WHISKEY_COVE_ADC_HIGH_BIT(temp_h);
-	cursrc = WHISKEY_COVE_ADC_CURSRC(temp_h);
-	rlsb = rlsb_array[cursrc];
-	adc_val = reg_val * rlsb / 1000;
+	rlsb = rlsb_array[reg_val >> 12];
+	adc_val = (reg_val & PMIC_REG_MASK) * rlsb / 1000;
 
 	return adc_val;
 }
@@ -325,7 +321,9 @@ intel_bxtwc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
 {
 	u32 bsr_num;
 	u16 resi_val, count = 0, thrsh = 0;
-	u8 alrt_h, alrt_l, cursel = 0;
+	u16 mask = PMIC_REG_MASK;
+	__be16 buf;
+	u8 cursel;
 
 	bsr_num = raw;
 	bsr_num /= (1 << 5);
@@ -336,15 +334,11 @@ intel_bxtwc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
 	thrsh = raw / (1 << (4 + cursel));
 
 	resi_val = (cursel << 9) | thrsh;
-	alrt_h = (resi_val >> 8) & WHISKEY_COVE_ALRT_HIGH_BIT_MASK;
-	if (regmap_update_bits(regmap,
-				reg - 1,
-				WHISKEY_COVE_ALRT_HIGH_BIT_MASK,
-				alrt_h))
-		return -EIO;
 
-	alrt_l = (u8)resi_val;
-	return regmap_write(regmap, reg, alrt_l);
+	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
+		return -EIO;
+	buf = cpu_to_be16((be16_to_cpu(buf) & ~mask) | (resi_val & mask));
+	return regmap_bulk_write(regmap, reg - 1, &buf, sizeof(buf));
 }
 
 static int
diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 9ea79f210965..ce647bc46978 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
 #include <linux/init.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/platform_device.h>
@@ -14,6 +16,8 @@
 
 #define PWR_SOURCE_SELECT	BIT(1)
 
+#define PMIC_REG_MASK		GENMASK(9, 0)
+
 #define PMIC_A0LOCK_REG		0xc5
 
 static struct pmic_table power_table[] = {
@@ -219,23 +223,27 @@ static int intel_crc_pmic_update_power(struct regmap *regmap, int reg,
 
 static int intel_crc_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	int temp_l, temp_h;
+	__be16 buf;
 
 	/*
 	 * Raw temperature value is 10bits: 8bits in reg
 	 * and 2bits in reg-1: bit0,1
 	 */
-	if (regmap_read(regmap, reg, &temp_l) ||
-	    regmap_read(regmap, reg - 1, &temp_h))
+	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
 		return -EIO;
 
-	return temp_l | (temp_h & 0x3) << 8;
+	return be16_to_cpu(buf) & PMIC_REG_MASK;
 }
 
 static int intel_crc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
 {
-	return regmap_write(regmap, reg, raw) ||
-		regmap_update_bits(regmap, reg - 1, 0x3, raw >> 8) ? -EIO : 0;
+	u16 mask = PMIC_REG_MASK;
+	__be16 buf;
+
+	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
+		return -EIO;
+	buf = cpu_to_be16((be16_to_cpu(buf) & ~mask) | (raw & mask));
+	return regmap_bulk_write(regmap, reg - 1, &buf, sizeof(buf));
 }
 
 static int intel_crc_pmic_get_policy(struct regmap *regmap,
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 6c2a6da430ed..1e80969c4d89 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -8,12 +8,16 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
 #include <linux/init.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/platform_device.h>
 #include "intel_pmic.h"
 
 /* registers stored in 16bit BE (high:low, total 10bit) */
+#define PMIC_REG_MASK		GENMASK(9, 0)
+
 #define CHTDC_TI_VBAT		0x54
 #define CHTDC_TI_DIETEMP	0x56
 #define CHTDC_TI_BPTHERM	0x58
@@ -73,7 +77,7 @@ static int chtdc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
 	if (regmap_read(regmap, reg, &data))
 		return -EIO;
 
-	*value = data & 1;
+	*value = data & BIT(0);
 	return 0;
 }
 
@@ -85,13 +89,12 @@ static int chtdc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
 
 static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	u8 buf[2];
+	__be16 buf;
 
-	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
+	if (regmap_bulk_read(regmap, reg, &buf, sizeof(buf)))
 		return -EIO;
 
-	/* stored in big-endian */
-	return ((buf[0] & 0x03) << 8) | buf[1];
+	return be16_to_cpu(buf) & PMIC_REG_MASK;
 }
 
 static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 33c5e85294cd..3c7380ec8203 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
 #include <linux/init.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+
 #include <asm/iosf_mbi.h>
+
 #include "intel_pmic.h"
 
 #define XPOWER_GPADC_LOW	0x5b
@@ -218,7 +222,7 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
 	int ret, adc_ts_pin_ctrl;
-	u8 buf[2];
+	__be16 buf;
 
 	/*
 	 * The current-source used for the battery temp-sensor (TS) is shared
@@ -255,9 +259,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, sizeof(buf));
+	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, &buf, sizeof(buf));
 	if (ret == 0)
-		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
+		ret = be16_to_cpu(buf) >> 4;
 
 	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
 		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
-- 
2.35.1

