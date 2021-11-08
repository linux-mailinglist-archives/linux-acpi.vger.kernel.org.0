Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CED44780B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 02:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhKHAym (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbhKHAxP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:53:15 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D1C0797BC;
        Sun,  7 Nov 2021 16:48:31 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id i26so26174769ljg.7;
        Sun, 07 Nov 2021 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkacp5n+z0D4++qm+Vz/WWDd0s3O3Dw6o+6i9hrIfWs=;
        b=RqR+4fCVEnzIej5WEta4m7eVP9J0cifvkt1Mu0YPaTP2A9CMdL6tu/SjMp4lB0+FJm
         ZQshmgPm64wSSZwKBHmOtA8t/EVqSNmkzF0MqQPAR/mp7ZLpjGx/vSJ1KlsFqNnZ9veH
         Dcm8gmKpUcqPf8R7fL5FlDm6P589xDSkGrLH67wFz4P5/cBO1nSmh1ck88Vc3JUYjWJZ
         ai5x9zvn9mG9RuY2DGypZ1nMlX0U5N+2NIBjhooAS4M0ocg5F25DHZ4qNHyux3JP8ufI
         p4KngmDN11Xh1YN0KCXFJvsyGD+xkZe8nNCdya2HLnrDDghh7kB3TpDSsqXcchV7r1qK
         LCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkacp5n+z0D4++qm+Vz/WWDd0s3O3Dw6o+6i9hrIfWs=;
        b=cNnZDWosKcqdKwoM6dztjOrF0epYOt5TEKo3Ay9kwdA4ezOJhcGNtW9LGbuEqah6Vs
         Ij1i61ARKyn88OFjXn+kkN2bttk6MIQcYViX6Tl8HPVyb02iXx7LDvvmnwA39bMegaZ/
         DuNQvbS14e2kITh2VRVPiY73iGnWENXSMC14wvJJQ0lu+3UfTu4lXUsdmJnMmPqYSfDB
         DfMuUgYR+XcrXtGOJK8TPqqsv0g/lLhKGTwXr1BKTAnPsXpd4MiRSQpUBRQIiCJRDOFv
         3E7c/WbgU6KYMQDhaynsQATcMXcBRdr0dyA0eGrlhfWD2FKmkNMvRVJ4pdV8MVWfyVxG
         7ZmA==
X-Gm-Message-State: AOAM533ePAcBTq1LoVTeuBmkeVutv5ks6ddk8oQt+anm3CJlPojju5iF
        froPgEe4zKQ0IR5m8xzxds4=
X-Google-Smtp-Source: ABdhPJxfKztOfDSBd7HSMtU+Am4Er8ebg/172DyOtTe15mPTYxlsPPldUWp9y70Z3OwiXlFCDFSHow==
X-Received: by 2002:a2e:7616:: with SMTP id r22mr1836123ljc.391.1636332510201;
        Sun, 07 Nov 2021 16:48:30 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 24/25] regulator: pfuze100: Use devm_register_sys_off_handler()
Date:   Mon,  8 Nov 2021 03:45:23 +0300
Message-Id: <20211108004524.29465-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_sys_off_handler() that replaces global
pm_power_off_prepare variable and allows to register multiple
power-off handlers.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/pfuze100-regulator.c | 38 ++++++++++----------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index d60d7d1b7fa2..2eca8d43a097 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/pfuze100.h>
@@ -76,6 +77,7 @@ struct pfuze_chip {
 	struct pfuze_regulator regulator_descs[PFUZE100_MAX_REGULATOR];
 	struct regulator_dev *regulators[PFUZE100_MAX_REGULATOR];
 	struct pfuze_regulator *pfuze_regulators;
+	struct sys_off_handler sys_off;
 };
 
 static const int pfuze100_swbst[] = {
@@ -569,10 +571,10 @@ static inline struct device_node *match_of_node(int index)
 	return pfuze_matches[index].of_node;
 }
 
-static struct pfuze_chip *syspm_pfuze_chip;
-
-static void pfuze_power_off_prepare(void)
+static void pfuze_power_off_prepare(struct power_off_prep_data *data)
 {
+	struct pfuze_chip *syspm_pfuze_chip = data->cb_data;
+
 	dev_info(syspm_pfuze_chip->dev, "Configure standby mode for power off");
 
 	/* Switch from default mode: APS/APS to APS/Off */
@@ -611,24 +613,23 @@ static void pfuze_power_off_prepare(void)
 
 static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
 {
+	int err;
+
 	if (pfuze_chip->chip_id != PFUZE100) {
 		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
 		return -ENODEV;
 	}
 
-	if (pm_power_off_prepare) {
-		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
-		return -EBUSY;
-	}
+	pfuze_chip->sys_off.power_off_prepare_cb = pfuze_power_off_prepare;
+	pfuze_chip->sys_off.cb_data = pfuze_chip;
 
-	if (syspm_pfuze_chip) {
-		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
-		return -EBUSY;
+	err = devm_register_sys_off_handler(pfuze_chip->dev, &pfuze_chip->sys_off);
+	if (err) {
+		dev_err(pfuze_chip->dev,
+			"failed to register sys-off handler: %d\n", err);
+		return err;
 	}
 
-	syspm_pfuze_chip = pfuze_chip;
-	pm_power_off_prepare = pfuze_power_off_prepare;
-
 	return 0;
 }
 
@@ -837,23 +838,12 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int pfuze100_regulator_remove(struct i2c_client *client)
-{
-	if (syspm_pfuze_chip) {
-		syspm_pfuze_chip = NULL;
-		pm_power_off_prepare = NULL;
-	}
-
-	return 0;
-}
-
 static struct i2c_driver pfuze_driver = {
 	.driver = {
 		.name = "pfuze100-regulator",
 		.of_match_table = pfuze_dt_ids,
 	},
 	.probe = pfuze100_regulator_probe,
-	.remove = pfuze100_regulator_remove,
 };
 module_i2c_driver(pfuze_driver);
 
-- 
2.33.1

