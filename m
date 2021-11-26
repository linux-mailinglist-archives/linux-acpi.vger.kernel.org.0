Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DF45F092
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378078AbhKZP0g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 10:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353931AbhKZPYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637940078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKttWd6cs0mohsyyaVdL7YZnd2EokG9Ow4h7VFpEbts=;
        b=UDcTU5yyThTX0Nbe34EEzn6awXEEeFfPXFfck5neC7LZjIVlf07WrGGAT5KA4q/4ZizMld
        98ylpELjMZBlxSXHlRcK9OKVjTjuCQDYZ3BiHNf1JOgTCRCNnfOqw0VfXaX+8Jfi9cSK5z
        dMX36qGdvTc7FjSYFKLqgEXMuHj3odg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-Qn8Ff-D8NSGbltvT5j7RlA-1; Fri, 26 Nov 2021 10:21:15 -0500
X-MC-Unique: Qn8Ff-D8NSGbltvT5j7RlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B2A53482D;
        Fri, 26 Nov 2021 15:21:14 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE3660854;
        Fri, 26 Nov 2021 15:21:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] ACPI: PMIC: allow drivers to provide a custom lpat_raw_to_temp() function
Date:   Fri, 26 Nov 2021 16:21:08 +0100
Message-Id: <20211126152109.230986-2-hdegoede@redhat.com>
In-Reply-To: <20211126152109.230986-1-hdegoede@redhat.com>
References: <20211126152109.230986-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The LPAT tables used in the DSDT for some PMICs require special handling,
allow the PMIC OpRegion drivers to provide an alternative implementation
by adding a lpat_raw_to_temp function pointer to struct pmic_table;
and initialize this to the default acpi_lpat_raw_to_temp function
for all PMICs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic.c          | 2 +-
 drivers/acpi/pmic/intel_pmic.h          | 4 ++++
 drivers/acpi/pmic/intel_pmic_bxtwc.c    | 1 +
 drivers/acpi/pmic/intel_pmic_bytcrc.c   | 1 +
 drivers/acpi/pmic/intel_pmic_chtcrc.c   | 1 +
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
 drivers/acpi/pmic/intel_pmic_chtwc.c    | 1 +
 drivers/acpi/pmic/intel_pmic_xpower.c   | 1 +
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 98bbfd99c709..f20dbda1a831 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -95,7 +95,7 @@ static int pmic_read_temp(struct intel_pmic_opregion *opregion,
 		return 0;
 	}
 
-	temp = acpi_lpat_raw_to_temp(opregion->lpat_table, raw_temp);
+	temp = opregion->data->lpat_raw_to_temp(opregion->lpat_table, raw_temp);
 	if (temp < 0)
 		return temp;
 
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index 467a39966dc8..d956b03a6ca0 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -2,6 +2,8 @@
 #ifndef __INTEL_PMIC_H
 #define __INTEL_PMIC_H
 
+#include <acpi/acpi_lpat.h>
+
 struct pmic_table {
 	int address;	/* operation region address */
 	int reg;	/* corresponding thermal register */
@@ -17,6 +19,8 @@ struct intel_pmic_opregion_data {
 	int (*update_policy)(struct regmap *r, int reg, int bit, int enable);
 	int (*exec_mipi_pmic_seq_element)(struct regmap *r, u16 i2c_address,
 					  u32 reg_address, u32 value, u32 mask);
+	int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
+				int raw);
 	struct pmic_table *power_table;
 	int power_table_count;
 	struct pmic_table *thermal_table;
diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index 6620ce0833f6..e247615189fa 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -376,6 +376,7 @@ static const struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
 	.update_aux     = intel_bxtwc_pmic_update_aux,
 	.get_policy     = intel_bxtwc_pmic_get_policy,
 	.update_policy  = intel_bxtwc_pmic_update_policy,
+	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
 	.power_table      = power_table,
 	.power_table_count = ARRAY_SIZE(power_table),
 	.thermal_table     = thermal_table,
diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 8a1d895ed689..9ea79f210965 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -278,6 +278,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
 	.update_aux	= intel_crc_pmic_update_aux,
 	.get_policy	= intel_crc_pmic_get_policy,
 	.update_policy	= intel_crc_pmic_update_policy,
+	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
 	.power_table	= power_table,
 	.power_table_count= ARRAY_SIZE(power_table),
 	.thermal_table	= thermal_table,
diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
index d8266d22cd8e..f9301c6f098e 100644
--- a/drivers/acpi/pmic/intel_pmic_chtcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
@@ -24,6 +24,7 @@
  * CHT Crystal Cove PMIC.
  */
 static const struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
+	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
 	.pmic_i2c_address = 0x6e,
 };
 
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index cb444ddec5a0..418eec523025 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -98,6 +98,7 @@ static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
 	.get_power = chtdc_ti_pmic_get_power,
 	.update_power = chtdc_ti_pmic_update_power,
 	.get_raw_temp = chtdc_ti_pmic_get_raw_temp,
+	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
 	.power_table = chtdc_ti_power_table,
 	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
 	.thermal_table = chtdc_ti_thermal_table,
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 59385a9a05e5..f2c42f4c79ca 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -257,6 +257,7 @@ static const struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
 	.get_power		= intel_cht_wc_pmic_get_power,
 	.update_power		= intel_cht_wc_pmic_update_power,
 	.exec_mipi_pmic_seq_element = intel_cht_wc_exec_mipi_pmic_seq_element,
+	.lpat_raw_to_temp	= acpi_lpat_raw_to_temp,
 	.power_table		= power_table,
 	.power_table_count	= ARRAY_SIZE(power_table),
 };
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index b5f4d81c621f..e844bc1f3df5 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -298,6 +298,7 @@ static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.update_power = intel_xpower_pmic_update_power,
 	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
 	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
+	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
 	.power_table = power_table,
 	.power_table_count = ARRAY_SIZE(power_table),
 	.thermal_table = thermal_table,
-- 
2.33.1

