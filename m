Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEB45F08F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378026AbhKZP0a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 10:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348623AbhKZPY2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637940075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C4A6IjJVF4HMCVZNAGETNPhabywN8h43W6h1IEZFWsM=;
        b=V+x1ExeZsbig/hTUUEWZfpsBAqNuCEmnD8tbanyz8c5NLw80p1M2ORZ48SXxT9DjyQOjDL
        zaFaB60wcKuVpJFkYads/XVYd8ma55FEGXXtEqvPIusRg3KzEjLxtH+tIvEVXwmrqKsWFO
        FPjyFi4eHo1l1vvPIyMULlJjRfhoVzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-U5ObZSUvMUKky5MyTfuQuw-1; Fri, 26 Nov 2021 10:21:14 -0500
X-MC-Unique: U5ObZSUvMUKky5MyTfuQuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0193819251A0;
        Fri, 26 Nov 2021 15:21:13 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A7460854;
        Fri, 26 Nov 2021 15:21:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] ACPI: PMIC: constify all struct intel_pmic_opregion_data declarations
Date:   Fri, 26 Nov 2021 16:21:07 +0100
Message-Id: <20211126152109.230986-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The struct intel_pmic_opregion_data declarations never change,
constify them all.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic.c          | 12 ++++++------
 drivers/acpi/pmic/intel_pmic.h          |  4 +++-
 drivers/acpi/pmic/intel_pmic_bxtwc.c    |  2 +-
 drivers/acpi/pmic/intel_pmic_bytcrc.c   |  2 +-
 drivers/acpi/pmic/intel_pmic_chtcrc.c   |  2 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c |  2 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c    |  2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   |  2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 9cde299eba88..98bbfd99c709 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -25,7 +25,7 @@ struct intel_pmic_opregion {
 	struct mutex lock;
 	struct acpi_lpat_conversion_table *lpat_table;
 	struct regmap *regmap;
-	struct intel_pmic_opregion_data *data;
+	const struct intel_pmic_opregion_data *data;
 	struct intel_pmic_regs_handler_ctx ctx;
 };
 
@@ -53,7 +53,7 @@ static acpi_status intel_pmic_power_handler(u32 function,
 {
 	struct intel_pmic_opregion *opregion = region_context;
 	struct regmap *regmap = opregion->regmap;
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	int reg, bit, result;
 
 	if (bits != 32 || !value64)
@@ -135,7 +135,7 @@ static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
 static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
 			    int bit, u32 function, u64 *value)
 {
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	struct regmap *regmap = opregion->regmap;
 
 	if (!d->get_policy || !d->update_policy)
@@ -171,7 +171,7 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 		void *handler_context, void *region_context)
 {
 	struct intel_pmic_opregion *opregion = region_context;
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	int reg, bit, result;
 
 	if (bits != 32 || !value64)
@@ -255,7 +255,7 @@ static acpi_status intel_pmic_regs_handler(u32 function,
 
 int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 					struct regmap *regmap,
-					struct intel_pmic_opregion_data *d)
+					const struct intel_pmic_opregion_data *d)
 {
 	acpi_status status = AE_OK;
 	struct intel_pmic_opregion *opregion;
@@ -344,7 +344,7 @@ EXPORT_SYMBOL_GPL(intel_pmic_install_opregion_handler);
 int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 					      u32 value, u32 mask)
 {
-	struct intel_pmic_opregion_data *d;
+	const struct intel_pmic_opregion_data *d;
 	int ret;
 
 	if (!intel_pmic_opregion) {
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index 89379476a1df..467a39966dc8 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -25,6 +25,8 @@ struct intel_pmic_opregion_data {
 	int pmic_i2c_address;
 };
 
-int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle, struct regmap *regmap, struct intel_pmic_opregion_data *d);
+int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
+					struct regmap *regmap,
+					const struct intel_pmic_opregion_data *d);
 
 #endif
diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index bd7621edd60b..6620ce0833f6 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -369,7 +369,7 @@ intel_bxtwc_pmic_update_policy(struct regmap *regmap,
 	return regmap_update_bits(regmap, reg, mask, val);
 }
 
-static struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
 	.get_power      = intel_bxtwc_pmic_get_power,
 	.update_power   = intel_bxtwc_pmic_update_power,
 	.get_raw_temp   = intel_bxtwc_pmic_get_raw_temp,
diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 2a692cc4b7ae..8a1d895ed689 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -271,7 +271,7 @@ static int intel_crc_pmic_update_policy(struct regmap *regmap,
 	return 0;
 }
 
-static struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
 	.get_power	= intel_crc_pmic_get_power,
 	.update_power	= intel_crc_pmic_update_power,
 	.get_raw_temp	= intel_crc_pmic_get_raw_temp,
diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
index 2900dc3074d2..d8266d22cd8e 100644
--- a/drivers/acpi/pmic/intel_pmic_chtcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
@@ -23,7 +23,7 @@
  * intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
  * CHT Crystal Cove PMIC.
  */
-static struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
 	.pmic_i2c_address = 0x6e,
 };
 
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index fef7831d0d63..cb444ddec5a0 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -94,7 +94,7 @@ static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	return ((buf[0] & 0x03) << 8) | buf[1];
 }
 
-static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
 	.get_power = chtdc_ti_pmic_get_power,
 	.update_power = chtdc_ti_pmic_update_power,
 	.get_raw_temp = chtdc_ti_pmic_get_raw_temp,
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 7ffd5624b8e1..59385a9a05e5 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -253,7 +253,7 @@ static int intel_cht_wc_exec_mipi_pmic_seq_element(struct regmap *regmap,
  * The thermal table and ops are empty, we do not support the Thermal opregion
  * (DPTF) due to lacking documentation.
  */
-static struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
 	.get_power		= intel_cht_wc_pmic_get_power,
 	.update_power		= intel_cht_wc_pmic_update_power,
 	.exec_mipi_pmic_seq_element = intel_cht_wc_exec_mipi_pmic_seq_element,
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index cbe08e600fa3..b5f4d81c621f 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -293,7 +293,7 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
 	return ret;
 }
 
-static struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.get_power = intel_xpower_pmic_get_power,
 	.update_power = intel_xpower_pmic_update_power,
 	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
-- 
2.33.1

