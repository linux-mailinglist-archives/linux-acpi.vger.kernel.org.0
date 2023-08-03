Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740676F142
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHCSDQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHCSCU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 14:02:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AAB420F
        for <linux-acpi@vger.kernel.org>; Thu,  3 Aug 2023 11:01:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686b9964ae2so889247b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Aug 2023 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085686; x=1691690486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aQz/o5NvlReZUl/stpeRs4o5FY0c8qnUYDCfHqNmJI=;
        b=Yv3oRH7T1TZNQw/AeEOc/wdAwvfBHh5qCQDTqqhRRIWLN2RT7duj6j3Mlz5B+tyUjx
         DwzXxTjoAWH+iw6CkKfwMxF9xCniQjo3B09L5BaQ+m3yDEsvvlfRGxAUpVXc7dZmfqkz
         PN5+8DYtk9mthHfXcWzvd40WNmLxpaQLT+X3GYJHhIU0xy+P4PfNU1GlwdTTN0c2vXWS
         N5M/tFDrDNAY9aGtxjAy1r+U43wKUASBkf3zWtuZ0PK/OlWurnWRvhkcieTUH/K57kZ9
         QHExlMok+1N1kt3iHzoySeHMoWERDl2+R1ayM9E29ohmdQ7YVT4UT939xn3e7d7QWGc0
         3iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085686; x=1691690486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aQz/o5NvlReZUl/stpeRs4o5FY0c8qnUYDCfHqNmJI=;
        b=QXnN8v/RzO5acSyLGKBBm3kvtILkUjUcvhIVxGeKsTfaYUcAD2uJTax59GEwAxPjGP
         o3hdFiGR9dKCEOiQn3MTmfUOZahZqsAcep8qTyd8K54YBydVbRq5ZGfNql3n3Fi35/VX
         sjchpNkfsTCs4dy4szwV3n/wrU3LpObHN9XVoytSGwHaUnDWEzaSbBVrPgZZcCP0pfhI
         EEs2BwM15a7tQmT49ndvZs4MpWi0Pejs5yy0TwG7zec/HA4v/QVKmsyqnbQiQ5znIutb
         JsFNqiwleI26aT5bYTCPytM7IW3V4mTQNq6KqiKbmSZnWzPJHEypm/eL+/K4gbjUB3QO
         a0eQ==
X-Gm-Message-State: ABy/qLZEKraU8WvgTz79q0wpzsnwGpQ5TyYze5Frh9j9csLGvpx4Rwta
        o78iIRPgeqfoExNEj+IJ72hG5A==
X-Google-Smtp-Source: APBJJlGAchtJBdt5IHqdaCzjHt1kkOK9wPe4WveHGvpGtfcTQHQdjS3NSncu/qTOIgVracHNUgSdbg==
X-Received: by 2002:a05:6a20:3d91:b0:132:c07c:f042 with SMTP id s17-20020a056a203d9100b00132c07cf042mr22166693pzi.15.1691085686344;
        Thu, 03 Aug 2023 11:01:26 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:26 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 15/21] ACPI: RISC-V: Create IMSIC platform device
Date:   Thu,  3 Aug 2023 23:29:10 +0530
Message-Id: <20230803175916.3174453-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The MSI controller functionality of the RISC-V IMSIC is
probed as a platform device by the driver. So, create the
IMSIC platform device if the IMSIC was discovered in MADT
during early IMSIC driver probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c    |  2 ++
 drivers/acpi/riscv/init.h    |  4 ++++
 drivers/acpi/riscv/irqchip.c | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index b5807bbdb171..be61c08ea385 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_imsic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..a2f72bb294d3
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init riscv_acpi_imsic_platform_init(void);
diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
index 6e15d45cb229..ca96bf109cf7 100644
--- a/drivers/acpi/riscv/irqchip.c
+++ b/drivers/acpi/riscv/irqchip.c
@@ -9,7 +9,10 @@
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
+#include "../../../drivers/pci/pci.h"
 
 struct riscv_irqchip_list {
 	struct fwnode_handle *fwnode;
@@ -101,3 +104,23 @@ struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev)
 {
 	return imsic_acpi_fwnode;
 }
+
+void __init riscv_acpi_imsic_platform_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	if (!acpi_riscv_get_msi_fwnode(NULL)) {
+		pci_no_msi();
+		return;
+	}
+
+	pdev = platform_device_alloc("riscv-imsic", 0);
+	if (!pdev)
+		return;
+
+	pdev->dev.fwnode = acpi_riscv_get_msi_fwnode(NULL);
+	ret = platform_device_add(pdev);
+	if (ret)
+		platform_device_put(pdev);
+}
-- 
2.39.2

