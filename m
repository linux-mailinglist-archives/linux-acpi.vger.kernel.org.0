Return-Path: <linux-acpi+bounces-993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F117D75CA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962251C20358
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1C34187
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HmX0WIx5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11633983
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:25:02 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ECF189
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b2018a11efso152323b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265495; x=1698870295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=HmX0WIx5ZKR8Cg3REtV8WvU+4A28I3jLrhYLezQY+rp0mQhBER7xMb/ToHKODSjlj7
         9aLYkV02gUF/2XnEVo1AwnEOt58O6rZquL0s3P53ziGLqlbYyPbjdycjDYoUW1stjWvr
         rKgGnj5V3bcFCfmCjdxyPLXDN0xB2fxplJUE3DqCkdHc3mzjVEKH0kXwgsDTy4hYAqP9
         P/WBTpzN7E0ZoKTHRR2UA05tUxCkaAIkx+j19OSo9SBppQIUcY9JUwadvgwhh3sG76gl
         R7B0oJcJMu5lOEj+1NQvmnD88vwGK+ehl5SxiF0Ecwg7iRYw96TElPdqUlCsZbN/v6ch
         4ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265495; x=1698870295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=rNpSWsEDxTHb8IKBpt0Rv8cOwCy9ZCF9ZgJzd6wbu/ThmI0ZVoy4Z+KXRdNgq4yDML
         S5qQI6D51Ixhu5yL2c4uCVgvoPkN8qkFWl0KrdKbDqqd3HH2RpYzG8K+zqZqGdOcaWB2
         sHmaPlOP0c0OOfy5GU8fe2oEuW7eSCxDh4fl0p5Fj7BqylIQIY6LD8fBZ8W+dJGLhegk
         JHfV62liUbTcc2SD0Hb8ULhlVGwavLcdgKcrDkhUJ/kDQpHGgHTZL+7cxoQ7sr+nBPvn
         uoV1F3elpxEkrMxcqXE4DAjr/yen4r8npRFc0W3usRFasOiXUgAcisud2Mc9uyhD66Ma
         Mi4Q==
X-Gm-Message-State: AOJu0YzsA+LentiT9pTj7aNb5U8mOEIpb+hdVMM1w+QMdmcYh1e8fpXh
	01hmErQMOW/SErhDULAQONoZUQ==
X-Google-Smtp-Source: AGHT+IGOtWmx7Z9hH5AFpr5sZFQnzIJZNuxwJNKWTB6+enKWMWr67WgjO7Vy6dwjrSM8D50mINvLmA==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr19185035pfe.10.1698265495348;
        Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:54 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 08/21] ACPI: pci_irq: Avoid warning for deferred probe in acpi_pci_irq_enable()
Date: Thu, 26 Oct 2023 01:53:31 +0530
Message-Id: <20231025202344.581132-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

When the architecture like RISC-V supports deferred GSI interrupt
controller probe,  acpi_register_gsi() can return -EPROBE_DEFER which is
a valid use case to delay the dependent driver probe. So, avoid printing
the warning for the deferred probe case.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_irq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..f7d0822da08f 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -452,8 +452,11 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 
 	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
 	if (rc < 0) {
-		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
-			 pin_name(pin));
+		if (rc != -EPROBE_DEFER) {
+			dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
+				 pin_name(pin));
+		}
+
 		kfree(entry);
 		return rc;
 	}
-- 
2.39.2


