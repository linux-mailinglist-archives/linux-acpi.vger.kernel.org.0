Return-Path: <linux-acpi+bounces-6675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8191CB76
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A751F22C9E
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 06:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F58364AE;
	Sat, 29 Jun 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RFdThJhf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E01CF9B;
	Sat, 29 Jun 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719644347; cv=none; b=mbSb+Fvp8wRd8rAfCe2HbEys4sG/fF5XF1fIF8H/+KdnJKnccErAc8wjZjzHrsNRNxnWMINJGY5VjJjc8Yi7m62eHbibyvh4RY9ts65bVCEuCoHNmFzQ9ezQq4uBgBSELrmbeRLo1E8gQ1bkpjC4NMUh3Jd4jLG6d3XjMyUcwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719644347; c=relaxed/simple;
	bh=6KyjtX5hOxB5LlFjn7fgJk+/s9NXrVzZ9ltFbNSFa2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2rOU53onIwN8wRks1YDYeRXIbfsEoKNTkneepKAONJS6u8aUPAIk8AHyXDlMJpgJZkuCC/VEPs0bJofbsq3F4WUBPI7nhSsar1BAWtUvqZs7Ih/s4sxGNWdJGUjNWnK8k1ERcDJQFc5XS5gUlC0uIH7Xxplm4mLP/jWRRJ9rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RFdThJhf; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id NS2ussK9tE745NS2vs6O5R; Sat, 29 Jun 2024 08:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719644336;
	bh=7ZffAGKYDmgIjO3VVxySPyiErhAqXhow8CsGzx+lLxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RFdThJhfv4vP0hsVXmPTV5moPfCdjkgSOtnIqkWMriydYqth15YzuIU7lvY7cYBYD
	 SxTULNmD8MBCbXjHJUwQy0f3hk1hMCh6uWVJykx9fay1rYE8U52k0tRgmWUNx9okxd
	 YfebuiBFrfp+8CjStf3Y9/L6y6x6olhY2w7w9HYLqq1lKvOETEIg8iW+8K1altibgl
	 6+/JosxD5GUz4zE9v23oRPFn13dL3ZE/LIlxRWXzpowNqG4NC+zyPnIH4rBMitnHVQ
	 4JK8CLFEeZ5kuvWKjI+RchpY5MS84JOMNC117wT5DfMXRFnQ8IgOacLOiGjQ/LI/bL
	 usaVooEKFjHIA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Jun 2024 08:58:56 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: PMIC: Constify struct pmic_table
Date: Sat, 29 Jun 2024 08:58:42 +0200
Message-ID: <a6c9b1bcdf259adabbcaf91183d3f5ab87a98600.1719644292.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct pmic_table' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   3811	    786	      0	   4597	   11f5	drivers/acpi/pmic/intel_pmic_xpower.o

   text	   data	    bss	    dec	    hex	filename
   4147	    450	      0	   4597	   11f5	drivers/acpi/pmic/intel_pmic_xpower.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/acpi/pmic/intel_pmic.c          | 2 +-
 drivers/acpi/pmic/intel_pmic.h          | 4 ++--
 drivers/acpi/pmic/intel_pmic_bxtwc.c    | 4 ++--
 drivers/acpi/pmic/intel_pmic_bytcrc.c   | 4 ++--
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 4 ++--
 drivers/acpi/pmic/intel_pmic_chtwc.c    | 2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index f20dbda1a831..134e9ca8eaa2 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -31,7 +31,7 @@ struct intel_pmic_opregion {
 
 static struct intel_pmic_opregion *intel_pmic_opregion;
 
-static int pmic_get_reg_bit(int address, struct pmic_table *table,
+static int pmic_get_reg_bit(int address, const struct pmic_table *table,
 			    int count, int *reg, int *bit)
 {
 	int i;
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index d956b03a6ca0..006f0780ffab 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -21,9 +21,9 @@ struct intel_pmic_opregion_data {
 					  u32 reg_address, u32 value, u32 mask);
 	int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
 				int raw);
-	struct pmic_table *power_table;
+	const struct pmic_table *power_table;
 	int power_table_count;
-	struct pmic_table *thermal_table;
+	const struct pmic_table *thermal_table;
 	int thermal_table_count;
 	/* For generic exec_mipi_pmic_seq_element handling */
 	int pmic_i2c_address;
diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index e247615189fa..c332afbf82bd 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -24,7 +24,7 @@
 #define VSWITCH1_OUTPUT         BIT(4)
 #define VUSBPHY_CHARGE          BIT(1)
 
-static struct pmic_table power_table[] = {
+static const struct pmic_table power_table[] = {
 	{
 		.address = 0x0,
 		.reg = 0x63,
@@ -177,7 +177,7 @@ static struct pmic_table power_table[] = {
 	} /* MOFF -> MODEMCTRL Bit 0 */
 };
 
-static struct pmic_table thermal_table[] = {
+static const struct pmic_table thermal_table[] = {
 	{
 		.address = 0x00,
 		.reg = 0x4F39
diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 2b09f8da5400..b4c21a75294a 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -16,7 +16,7 @@
 
 #define PMIC_A0LOCK_REG		0xc5
 
-static struct pmic_table power_table[] = {
+static const struct pmic_table power_table[] = {
 /*	{
 		.address = 0x00,
 		.reg = ??,
@@ -134,7 +134,7 @@ static struct pmic_table power_table[] = {
 	}, /* V105 -> V1P05S, L2 SRAM */
 };
 
-static struct pmic_table thermal_table[] = {
+static const struct pmic_table thermal_table[] = {
 	{
 		.address = 0x00,
 		.reg = 0x75
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 79f9df552524..ecb36fbc1e7f 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -23,7 +23,7 @@
 #define CHTDC_TI_BPTHERM	0x58
 #define CHTDC_TI_GPADC		0x5a
 
-static struct pmic_table chtdc_ti_power_table[] = {
+static const struct pmic_table chtdc_ti_power_table[] = {
 	{ .address = 0x00, .reg = 0x41 }, /* LDO1 */
 	{ .address = 0x04, .reg = 0x42 }, /* LDO2 */
 	{ .address = 0x08, .reg = 0x43 }, /* LDO3 */
@@ -39,7 +39,7 @@ static struct pmic_table chtdc_ti_power_table[] = {
 	{ .address = 0x30, .reg = 0x4e }, /* LD14 */
 };
 
-static struct pmic_table chtdc_ti_thermal_table[] = {
+static const struct pmic_table chtdc_ti_thermal_table[] = {
 	{
 		.address = 0x00,
 		.reg = CHTDC_TI_GPADC
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 25aa3e33b09a..81caede51ca2 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -70,7 +70,7 @@
  * "regulator: whiskey_cove: implements Whiskey Cove pmic VRF support"
  * https://github.com/intel-aero/meta-intel-aero/blob/master/recipes-kernel/linux/linux-yocto/0019-regulator-whiskey_cove-implements-WhiskeyCove-pmic-V.patch
  */
-static struct pmic_table power_table[] = {
+static const struct pmic_table power_table[] = {
 	{
 		.address = 0x0,
 		.reg = CHT_WC_V1P8A_CTRL,
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 43c5850b4bf3..49bda5e0c8aa 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -26,7 +26,7 @@
 #define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
 #define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
 
-static struct pmic_table power_table[] = {
+static const struct pmic_table power_table[] = {
 	{
 		.address = 0x00,
 		.reg = 0x13,
@@ -129,7 +129,7 @@ static struct pmic_table power_table[] = {
 };
 
 /* TMP0 - TMP5 are the same, all from GPADC */
-static struct pmic_table thermal_table[] = {
+static const struct pmic_table thermal_table[] = {
 	{
 		.address = 0x00,
 		.reg = XPOWER_GPADC_LOW
-- 
2.45.2


