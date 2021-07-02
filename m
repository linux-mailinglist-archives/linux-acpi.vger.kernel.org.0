Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593593BA362
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGBQxe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 12:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBQxe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 12:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625244661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yJbnHAwVZYEldlG8dDs+r60cd3R3+p12OdCsSqrO5M=;
        b=IzveF37KE+T8cVSiGHnX92dG5IUgNXwU5N/8arVIvGK5twzoa8c3FkZlYN2xNmW0Nkr3uq
        kuN9S6cCIARLgTRwKguzsfadDrDrAZSQlbIMTYV/JkJWsZOPCkhO3URUY1m69PqlfHGgi9
        d4+U/AweOwAovNrJ11t+6g/6bB2Xp4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-uPpMs_q5OHikZogi40Ag_g-1; Fri, 02 Jul 2021 12:50:58 -0400
X-MC-Unique: uPpMs_q5OHikZogi40Ag_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E754E1084F7E;
        Fri,  2 Jul 2021 16:50:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-237.ams2.redhat.com [10.36.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF5B81001281;
        Fri,  2 Jul 2021 16:50:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI / PMIC: XPower: optimize MIPI PMIQ sequence I2C-bus accesses
Date:   Fri,  2 Jul 2021 18:50:52 +0200
Message-Id: <20210702165052.81750-2-hdegoede@redhat.com>
In-Reply-To: <20210702165052.81750-1-hdegoede@redhat.com>
References: <20210702165052.81750-1-hdegoede@redhat.com>
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

The default exec_mipi_pmic_seq_element implementation from
drivers/acpi/pmic/intel_pmic.c does a regmap_update_bits() call and
the involved registers are typically marked as volatile in the regmap,
so this leads to 2 I2C-bus accesses.

Add a XPower AXP288 specific implementation of exec_mipi_pmic_seq_element
which calls iosf_mbi_block_punit_i2c_access() calls before the
regmap_update_bits() call to avoid having to do the whole expensive
acquire PUNIT semaphore dance twice.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 644a495a4f13..93c516ad361e 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -266,10 +266,34 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	return ret;
 }
 
+static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
+						   u16 i2c_address, u32 reg_address,
+						   u32 value, u32 mask)
+{
+	int ret;
+
+	if (i2c_address != 0x34) {
+		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
+		       __func__, i2c_address, reg_address, value, mask);
+		return -ENXIO;
+	}
+
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, reg_address, mask, value);
+
+	iosf_mbi_unblock_punit_i2c_access();
+
+	return ret;
+}
+
 static struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.get_power = intel_xpower_pmic_get_power,
 	.update_power = intel_xpower_pmic_update_power,
 	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
+	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
 	.power_table = power_table,
 	.power_table_count = ARRAY_SIZE(power_table),
 	.thermal_table = thermal_table,
-- 
2.31.1

