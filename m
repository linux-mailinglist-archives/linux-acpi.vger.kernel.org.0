Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63143D4C4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhJ0VYL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244544AbhJ0VWp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:22:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF5C0432C6;
        Wed, 27 Oct 2021 14:18:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp15so9014103lfb.4;
        Wed, 27 Oct 2021 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTg0c6UJkUtA3xox9iyqZdpwaCfteR79knUJVekTw18=;
        b=IOOovw4HthrHOXjOs46Y3yITm9+R54zah3HqdDtgfe0CoTVx3Ny/qQfSWJECq3va5v
         POFxHfUV4nFfAVF/2xQmQF0GAuAxqBjz1BtRvOKx4MR0EfN6IoGEZZUqz+WUpBWyPywt
         GrOnqTwA95eu+J8qffyJd/WsYZnQLcqOy0MiUotidUtoWBtzitEMBsbvSCmIUhOFOmfU
         TN0N1IIFJs2PwhqjyrirBl5OZM0AJ4ETZ7OvQijCQBnaCq4fjrrAiLoAARG8gCOMWpFL
         isJ90k/kflRmNXJGxu4rOU7Ttcg3V2boCXpvP5Lo62Urd2fuc4VonqYdYqPHg73Ap8Wn
         SfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTg0c6UJkUtA3xox9iyqZdpwaCfteR79knUJVekTw18=;
        b=ADMc0chHW5n+H5eKujckA+Bo50ein/UoSz7YRe3KTWR/bFqnjMH0wfiSP1RSuMjYq8
         Xipi68k3HcDAkmzauObv7Z+0UnD5pOfgUcGe6yGJIkfq5K4RMKuSyKXiHnSp5UDSk+eN
         B09VRseQbrmnNbIGTM8q+ZwENDDUo4/oo2tG5tXZZ/OZIF381adQL5GE1AQ6Hu5Yy8RT
         ruwSHDPqpZyra1LoK241puSwxWme4Su02f3x73RJtSHEjhuolwSCrYbvddTtTuRB+GrR
         WCL2FQR36Tszl7r9iJDT8hS0xqkPWdmEntV2MH9JyTL5kzODsyCLXCgxZobtM8PrfrOY
         /QFw==
X-Gm-Message-State: AOAM532bbAe1WHB13IRLECiGXenCBpr/Xlvmg7ktfYcziEV+NQoUMqOk
        6UCvNyXg8/sHPZXzgzjAZRs=
X-Google-Smtp-Source: ABdhPJxFzFVD2w1ioavz6oJ1REfrGLdo1ULxWozIc4isKil/5p3npr9c6ZJggbEvwegyiOXfsqbr2g==
X-Received: by 2002:a05:6512:3699:: with SMTP id d25mr132127lfs.380.1635369515664;
        Wed, 27 Oct 2021 14:18:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:35 -0700 (PDT)
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
Subject: [PATCH v2 23/45] ACPI: power: Switch to power-handler API
Date:   Thu, 28 Oct 2021 00:16:53 +0300
Message-Id: <20211027211715.12671-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Switch to power-handler API that replaces legacy pm_power_off callbacks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/acpi/sleep.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 3023224515ab..41b3ea867f8f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -47,19 +47,11 @@ static void acpi_sleep_tts_switch(u32 acpi_state)
 	}
 }
 
-static int tts_notify_reboot(struct notifier_block *this,
-			unsigned long code, void *x)
+static void tts_reboot_prepare(struct reboot_prep_data *data)
 {
 	acpi_sleep_tts_switch(ACPI_STATE_S5);
-	return NOTIFY_DONE;
 }
 
-static struct notifier_block tts_notifier = {
-	.notifier_call	= tts_notify_reboot,
-	.next		= NULL,
-	.priority	= 0,
-};
-
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -1016,7 +1008,7 @@ static void acpi_sleep_hibernate_setup(void)
 static inline void acpi_sleep_hibernate_setup(void) {}
 #endif /* !CONFIG_HIBERNATION */
 
-static void acpi_power_off_prepare(void)
+static void acpi_power_off_prepare(struct power_off_prep_data *data)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
@@ -1024,7 +1016,7 @@ static void acpi_power_off_prepare(void)
 	acpi_os_wait_events_complete();
 }
 
-static void acpi_power_off(void)
+static void acpi_power_off(struct power_off_data *data)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	pr_debug("%s called\n", __func__);
@@ -1032,6 +1024,11 @@ static void acpi_power_off(void)
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
+static struct power_handler acpi_power_handler = {
+	.power_off_priority = POWEROFF_PRIO_FIRMWARE,
+	.reboot_prepare_cb = tts_reboot_prepare,
+};
+
 int __init acpi_sleep_init(void)
 {
 	char supported[ACPI_S_STATE_COUNT * 3 + 1];
@@ -1048,8 +1045,8 @@ int __init acpi_sleep_init(void)
 
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
-		pm_power_off_prepare = acpi_power_off_prepare;
-		pm_power_off = acpi_power_off;
+		acpi_power_handler.power_off_cb = acpi_power_off;
+		acpi_power_handler.power_off_prepare_cb = acpi_power_off_prepare;
 	} else {
 		acpi_no_s5 = true;
 	}
@@ -1065,6 +1062,6 @@ int __init acpi_sleep_init(void)
 	 * Register the tts_notifier to reboot notifier list so that the _TTS
 	 * object can also be evaluated when the system enters S5.
 	 */
-	register_reboot_notifier(&tts_notifier);
+	register_power_handler(&acpi_power_handler);
 	return 0;
 }
-- 
2.33.1

