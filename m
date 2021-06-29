Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6D3B76F9
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhF2RPR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 13:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhF2RPQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 13:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BsAjgggCdH28RjAi0ap8LRQEBtEJ6LK2b8ZtZ5ZSN28=;
        b=PRoTKNSJ62hGiYxfQ8XFb10jq+nDRSmuxocVfOoORkGiViiC/Xb6wixu4gshRFYwT//1ki
        fXOeB6MwRXhHU5r6i7ESwYbITVQOimcs5FDQ+9mgj2KHm7pa1ENzLIPcTM2PnRyZ+VZwuM
        T37XdfDl9LK/Wbjcj2d5x6maSP6YUE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wibo1R02Ok2PKHOTbbdn0Q-1; Tue, 29 Jun 2021 13:12:47 -0400
X-MC-Unique: wibo1R02Ok2PKHOTbbdn0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8F2F10A36EC;
        Tue, 29 Jun 2021 17:12:45 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-140.ams2.redhat.com [10.36.112.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9ED5C1D0;
        Tue, 29 Jun 2021 17:12:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Clamshell <clamfly@163.com>
Subject: [PATCH v2] mfd: axp20x: Update AXP288 volatile ranges
Date:   Tue, 29 Jun 2021 19:12:39 +0200
Message-Id: <20210629171239.6618-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Cherry Trail devices with an AXP288 PMIC the external SD-card slot
used the AXP's DLDO2 as card-voltage and either DLDO3 or GPIO1LDO
(GPIO1 pin in low noise LDO mode) as signal-voltage.

These regulators are turned on/off and in case of the signal-voltage
also have their output-voltage changed by the _PS0 and _PS3 power-
management ACPI methods on the MMC-controllers ACPI fwnode as well as
by the _DSM ACPI method for changing the signal voltage.

The AML code implementing these methods is directly accessing the
PMIC through ACPI I2C OpRegion accesses, instead of using the special
PMIC OpRegion handled by drivers/acpi/pmic/intel_pmic_xpower.c .

This means that the contents of the involved PMIC registers can change
without the change being made through the regmap interface, so regmap
should not cache the contents of these registers.

Mark the regulator power on/off, the regulator voltage control and the
GPIO1 control registers as volatile, to avoid regmap caching them.

Specifically this fixes an issue on some models where the i915 driver
toggles another LDO using the same on/off register on/off through
MIPI sequences (through intel_soc_pmic_exec_mipi_pmic_seq_element())
which then writes back a cached on/off register-value where the
card-voltage is off causing the external sdcard slot to stop working
when the screen goes blank, or comes back on again.

The regulator register-range now marked volatile also includes the
buck regulator control registers. This is done on purpose these are
normally not touched by the AML code, but they are updated directly
by the SoC's PUNIT which means that they may also change without going
through regmap.

Note the AXP288 PMIC is only used on Bay- and Cherry-Trail platforms,
so even though this is an ACPI specific problem there is no need to
make the new volatile ranges conditional since these platforms always
use ACPI.

Fixes: dc91c3b6fe66 ("mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile")
Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
Reported-and-tested-by: Clamshell <clamfly@163.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add second Fixes tag
- Add comment to commit msg about the regulator register-range also
  including the buck-regulator control registers
---
 drivers/mfd/axp20x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3eae04e24ac8..db6a21465594 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -125,12 +125,13 @@ static const struct regmap_range axp288_writeable_ranges[] = {
 
 static const struct regmap_range axp288_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP288_POWER_REASON),
+	regmap_reg_range(AXP22X_PWR_OUT_CTRL1, AXP22X_ALDO3_V_OUT),
 	regmap_reg_range(AXP288_BC_GLOBAL, AXP288_BC_GLOBAL),
 	regmap_reg_range(AXP288_BC_DET_STAT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_CHRG_BAK_CTRL, AXP20X_CHRG_BAK_CTRL),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
 	regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
-	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP20X_GPIO1_CTRL, AXP22X_GPIO_STATE),
 	regmap_reg_range(AXP288_RT_BATT_V_H, AXP288_RT_BATT_V_L),
 	regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
 };
-- 
2.31.1

