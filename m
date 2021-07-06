Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F593BDAF0
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jul 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGFQMK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jul 2021 12:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhGFQMK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jul 2021 12:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625587770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m3+C5bBq8Bg2+D53rZ6305BEoSr8862yafNAj4N+5YA=;
        b=MLb2ksUqPipRjFaJl98IPbEqsRd8pgtQ0/KZWgxHtNgAUU1BryNCQRBXYEGjVwZoZHT1Pd
        AU4MMybgEfv9HfTqBFNQkM+wGUpH9DD/oEPZp388qbQlk2QEPwMwohLs82DN/CkE55KUFD
        kldQkASU2SyuC8tRCAHdnMHt5Qq7Rrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-v3ISHBkUNeGdivqIfV0n_A-1; Tue, 06 Jul 2021 12:09:29 -0400
X-MC-Unique: v3ISHBkUNeGdivqIfV0n_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78501023F41;
        Tue,  6 Jul 2021 16:09:27 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-131.ams2.redhat.com [10.36.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84DBA5C1D5;
        Tue,  6 Jul 2021 16:09:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
Date:   Tue,  6 Jul 2021 18:09:22 +0200
Message-Id: <20210706160923.20273-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
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

Add iosf_mbi_block_punit_i2c_access() calls around groups of register
accesses, so that the P-Unit semaphore only needs to be taken once
for each group of register accesses.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Do not hold the P-Unit sempahore over the usleep_range() in
 intel_xpower_pmic_get_raw_temp()
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index a091d5a8392c..5750c5e7d4c6 100644
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
@@ -234,6 +236,11 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 		return ret;
 
 	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
+		/*
+		 * AXP288_ADC_TS_PIN_CTRL reads are cached by the regmap, so
+		 * this does to a single I2C-transfer, and thus there is no
+		 * need to explicitly call iosf_mbi_block_punit_i2c_access().
+		 */
 		ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
 					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
 					 AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
@@ -244,6 +251,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 		usleep_range(6000, 10000);
 	}
 
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
 	if (ret == 0)
 		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
@@ -254,6 +265,8 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 				   AXP288_ADC_TS_CURRENT_ON);
 	}
 
+	iosf_mbi_unblock_punit_i2c_access();
+
 	return ret;
 }
 
-- 
2.31.1

