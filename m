Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1E43D577
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhJ0V1j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbhJ0VZ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:25:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB063C0432F7;
        Wed, 27 Oct 2021 14:19:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h11so7032494ljk.1;
        Wed, 27 Oct 2021 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OlHSqJ+90NzTUoF0ScIJd6Gu2h2samNuNJcsiL1Jk8=;
        b=TlGsLZtcrVzUb7sAOhif3p7pVw8LafC2xLy1EDPy1NIwJl5MQQvmHy2JQZYszcOE8Z
         bpdCDmyEM5D03Couzbs3VVZUIdamWSCPF0yzl5vvizBqtDssLI1790jRM+TPIcawNrlD
         8STEeq0OEOHvy2rX7OXiOWUq9V+Wbq3xZg3vhjF/dealnvdRkEuGDx5b0mmtoBXsa4Tg
         7gFUHQvvLRw3QjAUV5dCuqij4emeiEy4r7tFICkEZrQaaXXABdfN2M8h/mxrxQbImqYG
         GaGzMOCXHjG+QuAc4Dq0gK0PotuHucIYhVqvi35iVuJc+hGZhg1h00rdw0kra8k/EpLO
         luJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OlHSqJ+90NzTUoF0ScIJd6Gu2h2samNuNJcsiL1Jk8=;
        b=6eRm/yH4uKwzVBusC+BubrYhiUqmHSMgN+xIU10SkaLqZQ6UhwTixA9F5p7HCf8hJX
         BtKiglbu+s9lKyiLsXwPYJ0YFa+/sb/JKbUqG4iosT+DYghpkfPFTN8oTx4kXPpfPqUX
         BZzcK5lQmcOIlSjnAozEdBL/4waX82mrhMVQoHabZlzGHhME3ey570ll/4Vk94W1ibwd
         W6iP7eXhRmjKxnZpK+tu0X4vCO1Dibj3oD4ijyIKQOBDxAKdRc1+dIw4bDwby+fDXp4P
         IGN5OlYbg5NYg5CyXrMoEKwApCIgNjbyNGm20p8wjEpuqdO9tlJFopXRX0eb+1yqhQB/
         aKGw==
X-Gm-Message-State: AOAM532PJfWISP/N1/cuottR4XrInzLbhIHHrtyD4WiShr6hjTHTm7Z+
        2814HwxygRkqPakxwrOV2Iw=
X-Google-Smtp-Source: ABdhPJzDbMhKltt/cJ4cLHVC7lvSJKFFWBp4i2pL/KBXA4D8sI4Ihh3wNKVdm9xKvnEcHeY8d+ELCw==
X-Received: by 2002:a2e:b0e2:: with SMTP id h2mr336408ljl.522.1635369545290;
        Wed, 27 Oct 2021 14:19:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:19:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 39/45] mfd: dm355evm_msp: Use devm_register_trivial_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:09 +0300
Message-Id: <20211027211715.12671-40-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_trivial_power_off_handler() that replaces global
pm_power_off variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/dm355evm_msp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 54fb6cbd2aa0..5ee830f65589 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/err.h>
@@ -375,11 +376,10 @@ static void dm355evm_power_off(void)
 	dm355evm_command(MSP_COMMAND_POWEROFF);
 }
 
-static int dm355evm_msp_remove(struct i2c_client *client)
+static void dm355evm_msp_remove(void *data)
 {
-	pm_power_off = NULL;
+	/* FIXME remove children ... */
 	msp430 = NULL;
-	return 0;
 }
 
 static int
@@ -392,6 +392,11 @@ dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EBUSY;
 	msp430 = client;
 
+	status = devm_add_action_or_reset(&client->dev, dm355evm_msp_remove,
+					  NULL);
+	if (status < 0)
+		goto fail;
+
 	/* display revision status; doubles as sanity check */
 	status = dm355evm_msp_read(DM355EVM_MSP_FIRMREV);
 	if (status < 0)
@@ -416,13 +421,15 @@ dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto fail;
 
 	/* PM hookup */
-	pm_power_off = dm355evm_power_off;
+	status = devm_register_trivial_power_off_handler(&client->dev,
+							 dm355evm_power_off);
+	if (status)
+		dev_err(&client->dev, "failed to register power-off handler: %d",
+			status);
 
 	return 0;
 
 fail:
-	/* FIXME remove children ... */
-	dm355evm_msp_remove(client);
 	return status;
 }
 
@@ -436,7 +443,6 @@ static struct i2c_driver dm355evm_msp_driver = {
 	.driver.name	= "dm355evm_msp",
 	.id_table	= dm355evm_msp_ids,
 	.probe		= dm355evm_msp_probe,
-	.remove		= dm355evm_msp_remove,
 };
 
 static int __init dm355evm_msp_init(void)
-- 
2.33.1

