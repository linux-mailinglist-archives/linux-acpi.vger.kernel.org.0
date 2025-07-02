Return-Path: <linux-acpi+bounces-14913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E0AF0A9E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E21173DD6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED720C023;
	Wed,  2 Jul 2025 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DIw3K2f7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757F23AE62
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433407; cv=none; b=tBPsCM93BDjjtyojxxVpRYOx3PGPclENWBoVzG3X65zYGjOpLvYvG5J6XQQd7uyXxuuH47AE3N35oMcsZOlTkqxEYszFDL2Wwoe2dQqs6DFu1EBgV5wKTS8Oh/y3C67F31w0PJpDvJhGv+F1wgSgk2rd75ef41HZNQwAayYphwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433407; c=relaxed/simple;
	bh=WWnAVv5sdX/U4PhLlvNmEa3n3L6K6Kq50t1ofY7W1Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy7JzIE0SpnJQdMoHr9jMrORbekyg3MsFyUA8pERmCjZtAh16pPZF1+OFG6GnkSr/xgTRrYIGBv/xMyoRqqk4Sxo8NcP32b2KMYzbRyqYeEQbpslo/vYVrl18cld5fqc006R2fHCFt5Mdd1eeZW7ZTdigaaGhcZfK8KsJ+pTRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DIw3K2f7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235f9e87f78so40756015ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433405; x=1752038205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V0Odgdog0meYxYnmF6ZJNtzVV8Khw6QA9VUe2JT1O4=;
        b=DIw3K2f7qx/Iyx0V+qKZbFJwWPNXV8P5tmOYgixn3frgKra7/70jEcX307v29IoilT
         Feo+qLPdNB5HEzXF4fGOMkCFIl1KNXOyJwo6NmpQiDEvF+Qt9XFM7Zx6t0ramVqT+9Hy
         IlMU1NmfPwP3oebRXEKF5jwrMY2SxIbI4nTR1dbNKGkw2bZ0x+o/X11cHW2bBKTtTRkB
         SCsse+Jpu9u+qF9HxCsehlB2TTb5w1UIN5S1n3dYB76Tl9rm7hKJN6NhO3bZVPuaJ+eR
         /fBDYhlGTNkyJwTGkc5tBeMaEXMAasKEIZ7udWW3c87hPSezGr0v4UFfXEguAAPd2yyD
         ZQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433405; x=1752038205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V0Odgdog0meYxYnmF6ZJNtzVV8Khw6QA9VUe2JT1O4=;
        b=gBsc6K6HIcqt51wXBw4j+/sZU+BMm8LKgLhGdSdNkhmWdT6EWkWMbXOlmIyrtFziE4
         A9vSgBXxbzjE/Z2+XV0QHsv6HkLkE2080VpnzBjoPvGJXfKgNQB0ywrGKrCWK5upIqrv
         DfjLq+movFM0cyeEy0jIdf5Fgl2ggMhthvw4t1zTGn+nxRVoeRneD9owZMV8HNHFpiGk
         LVAGy83Du7m/aUkdou/uVAZ/WHhVKJvC6moxxiu0eiYLq9QE8lWBYmtM8Yvn3V5aPEA8
         V0Gob+yi4aQqaW5hHY1CRBfYs6ZU8qmCDDxExvupfOwumkFMayo+pEjBCn6KhoFWDRCp
         lBag==
X-Forwarded-Encrypted: i=1; AJvYcCWeqm9QKjtMXxIDFcq3sWCutxUAOYed3bu1JmUQyrWDXamBJUCzAB1vSvM8nOr30VuS1ZA9cQBerJDg@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHQdEZi5rmUnv4zW0HufXdQRJV6i9U0I3cfbMpuE6RtkLN4h8
	ecs5iIJwm5UaDin55R3ZFHXXqrSnDEQ+Yl2yIi+MtWBvZSS2WU/T79xdwX9cy0SCncs=
X-Gm-Gg: ASbGncuwUFkV8OZTs3mDqzADKEAq6VwPhzxjVhK85mGv9pvuHIs2KOs/HjfK7LYD7Wx
	yxlvt07vBtpo2kiq5eAFTDs91GPKJfgrgjijDHPMjcuD81YwPjZEgiyt34Wtpn0fbyyRr9zSeZm
	HTjPhSeywROq2LeaZpJii+r5//nrRA2XhLUr5+9ini6kR3BWA/xMXcjpdzL0L2a1IFrCFc2oQ5d
	K2FS+2leblEsU2b4+0fZiJLkdOZ+TOMorrEKnIIWgK2gok2uDco6Xcep6WOK6Qh6lZBSMQw7RAX
	UuZKwiAg+ZKansLx4hc/TZUQ8P9tvXU9iqA2DW4jIa+EOW5PiKKVcO51jBsugvjBbwdcu5C20kX
	pTLcQlWqUSdHx1PnM
X-Google-Smtp-Source: AGHT+IH3e0m3Z712B5FuScEtM+R3UhY2+EC/UOkyXFHE4lffL+PCS6CYNx/+xTtoNWCyksjFpU2g1g==
X-Received: by 2002:a17:902:c94c:b0:235:ef67:b595 with SMTP id d9443c01a7336-23c6e56c276mr22583325ad.35.1751433405437;
        Tue, 01 Jul 2025 22:16:45 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:45 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
Date: Wed,  2 Jul 2025 10:43:42 +0530
Message-ID: <20250702051345.1460497-22-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Add ACPI support for the RISC-V SBI message proxy (MPXY) based
mailbox driver.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/mailbox/riscv-sbi-mpxy-mbox.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/riscv-sbi-mpxy-mbox.c b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
index 129710f947ae..deb269a9a844 100644
--- a/drivers/mailbox/riscv-sbi-mpxy-mbox.c
+++ b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2025 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/mm.h>
@@ -779,6 +781,7 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 	u32 i, *channel_ids __free(kfree) = NULL;
 	struct device *dev = &pdev->dev;
 	struct mpxy_mbox_channel *mchan;
+	struct irq_domain *msi_domain;
 	struct mpxy_mbox *mbox;
 	int msi_idx, rc;
 
@@ -901,6 +904,8 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 
 	/* Set the MSI domain if not available */
 	if (!dev_get_msi_domain(dev)) {
+		struct fwnode_handle *fwnode = dev_fwnode(dev);
+
 		/*
 		 * The device MSI domain for OF devices is only set at the
 		 * time of populating/creating OF device. If the device MSI
@@ -908,8 +913,13 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 		 * then we need to set it explicitly before using any platform
 		 * MSI functions.
 		 */
-		if (dev_of_node(dev))
+		if (is_of_node(fwnode)) {
 			of_msi_configure(dev, dev_of_node(dev));
+		} else if (is_acpi_device_node(fwnode)) {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 	}
 
 	/* Setup MSIs for mailbox (if required) */
@@ -954,6 +964,13 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		acpi_dev_clear_dependencies(adev);
+#endif
+
 	dev_info(dev, "mailbox registered with %d channels\n",
 		 mbox->channel_count);
 	return 0;
@@ -973,10 +990,17 @@ static const struct of_device_id mpxy_mbox_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mpxy_mbox_of_match);
 
+static const struct acpi_device_id mpxy_mbox_acpi_match[] = {
+	{ "RSCV0005" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mpxy_mbox_acpi_match);
+
 static struct platform_driver mpxy_mbox_driver = {
 	.driver = {
 		.name = "riscv-sbi-mpxy-mbox",
 		.of_match_table = mpxy_mbox_of_match,
+		.acpi_match_table = mpxy_mbox_acpi_match,
 	},
 	.probe = mpxy_mbox_probe,
 	.remove = mpxy_mbox_remove,
-- 
2.43.0


