Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444073BA361
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGBQxc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 12:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBQxc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 12:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625244659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hczf/zYMcFbd9s+5bjvba857G/D075IEVL9MJvSYO7s=;
        b=b7GoLmNLEFZ8dAPgVxObWpVztyV+zJST4/VMClLkNVP6yY/Q0B5RmsPHlu8QDmY52yyeIx
        GXEHxGjHW3Ox053vz2doYMkR3ESZub39vt+O50V+XwFfEgk26WWn8QaqX8W91b6xsEK4u9
        U7K9141fFOrJwfbWaU5Dmm9BzynMtQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-tDb4ghCnNDKaV0ezAAFK0A-1; Fri, 02 Jul 2021 12:50:56 -0400
X-MC-Unique: tDb4ghCnNDKaV0ezAAFK0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C1941084F62;
        Fri,  2 Jul 2021 16:50:55 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-237.ams2.redhat.com [10.36.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34FCC1000324;
        Fri,  2 Jul 2021 16:50:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
Date:   Fri,  2 Jul 2021 18:50:51 +0200
Message-Id: <20210702165052.81750-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs PUNIT. The PUNIT has a semaphore which the kernel must "lock"
before it may use the bus and while the kernel holds the semaphore the CPU
and GPU power-states must not be changed otherwise the system will freeze.

This is a complex process, which is quite expensive. This is all done by
iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
I2C-bus-driver for every I2C transfer. Because this is so expensive it
is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
fashion, so that higher-level code which does multiple I2C-transfers can
call it once for a group of transfers, turning the calls done by the
I2C-bus-driver into no-ops.

Move / add iosf_mbi_block_punit_i2c_access() calls in / to the XPower
OpRegion code so that the PUNIT semaphore only needs to be taken once
for each OpRegion access.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index a091d5a8392c..644a495a4f13 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -178,15 +178,17 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 {
 	int data, ret;
 
-	/* GPIO1 LDO regulator needs special handling */
-	if (reg == XPOWER_GPI1_CTRL)
-		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
-					  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
-
 	ret = iosf_mbi_block_punit_i2c_access();
 	if (ret)
 		return ret;
 
+	/* GPIO1 LDO regulator needs special handling */
+	if (reg == XPOWER_GPI1_CTRL) {
+		ret = regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
+					 on ? GPI1_LDO_ON : GPI1_LDO_OFF);
+		goto out;
+	}
+
 	if (regmap_read(regmap, reg, &data)) {
 		ret = -EIO;
 		goto out;
@@ -218,6 +220,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	int ret, adc_ts_pin_ctrl;
 	u8 buf[2];
 
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret)
+		return ret;
+
 	/*
 	 * The current-source used for the battery temp-sensor (TS) is shared
 	 * with the GPADC. For proper fuel-gauge and charger operation the TS
@@ -231,14 +237,14 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	 */
 	ret = regmap_read(regmap, AXP288_ADC_TS_PIN_CTRL, &adc_ts_pin_ctrl);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
 		ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
 					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
 					 AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Wait a bit after switching the current-source */
 		usleep_range(6000, 10000);
@@ -254,6 +260,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 				   AXP288_ADC_TS_CURRENT_ON);
 	}
 
+out:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	return ret;
 }
 
-- 
2.31.1

