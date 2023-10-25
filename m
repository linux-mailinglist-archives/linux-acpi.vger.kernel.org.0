Return-Path: <linux-acpi+bounces-992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DE87D75C9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A221C20B2B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336934189
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eJujG6QR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C887328DD
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:24:54 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333F10E5
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fb85afef4so140870b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265489; x=1698870289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bjA2IFkbvQ+cjwZ90V9r6vmNOzBSbezE1qJqMO1A+c=;
        b=eJujG6QRF1LoqNfAqafA4JP/kq7hTbjci2TIo9bHxvPUlxqdX/zQcNl0n6qfWEyjut
         5CtQ2sPrekj/5bfbgo8qQK9MGC8/B0e5NtB5BDxQbRXVnc4aIb/tweaYpQf6JKA/BIJb
         rucTEkR+rs0lOGJoWuWG7sgy2LZLnlxlmgrSClK2IHBzB+v2H9jFLHJpbXASppyFAVcK
         kj0G3gqmO40Aqlxj8Z4LKnqmiq/z8GKI6UQkv1Y1w5a8dJoXoly0r4CGsRZy4dYotPjo
         IyYFZIytQmcY2z3HDtKnJYF2xaGF509bS6t9YxW/zPkRmcEtCrGGA/Ol7rBIFQjWmuIe
         EFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265489; x=1698870289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bjA2IFkbvQ+cjwZ90V9r6vmNOzBSbezE1qJqMO1A+c=;
        b=dbuqRMGMRJYmWVgCmOGl0kxwjiYXeSTDTCgcfncsodgBVcjKLW1Cxeir5q8OyqgIjO
         l7s9tsiN1HO8wnclYOE66NWQWoCd+854sBb3eQH5LZGOHRbnBrL/dk76/ZSb7FFiaQzL
         cgeI/uLT0BAtPxwodL3B6eWVesDpc7afpZGurQUmu7aVFc0I3emyvzmJ+zR29RzkJ5FU
         tJO/9N9I6T3v54f4L2aiIxk5ENuOABcvWiOlHztHDBia8XnDVW/DTa44BrCcM5dfnfGS
         kZ5KaW7ZRILBAlLirUAZsb3zYosFMTF1Ht7XhRnw19/tWXiJfQ6FSwfobsjUkwp0MoId
         oQWA==
X-Gm-Message-State: AOJu0YwY29R6d8eyh6d9RWcUpQpm8xd/HOdIOjm/2XNqI4aYMLYywDNl
	rJrvmyKyDyBojTMOf2CbOTjB4Q==
X-Google-Smtp-Source: AGHT+IG0SpgdyiZkoMurZXPLkoY/g9K3mifAR/RprvidWByJ+cvRjgFm+eLWR/dX/aORh+7WvaUdiA==
X-Received: by 2002:a05:6a21:33a4:b0:17b:3cd6:b1bc with SMTP id yy36-20020a056a2133a400b0017b3cd6b1bcmr8121322pzb.14.1698265489371;
        Wed, 25 Oct 2023 13:24:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/21] serial: 8250_pnp: Add support for deferred probe
Date: Thu, 26 Oct 2023 01:53:30 +0530
Message-Id: <20231025202344.581132-8-sunilvl@ventanamicro.com>
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

With pnp_irq() able to return error code, enhance the serial pnp driver
to support deferred probing. Return -EPROBE_DEFER when pnp_irq() returns
the same so that the driver probe is deferred.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..dcb3daf7c816 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -8,6 +8,7 @@
  *
  *  Ported to the Linux PnP Layer - (C) Adam Belay.
  */
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pnp.h>
@@ -443,8 +444,21 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
+	if (pnp_irq_valid(dev, 0)) {
+		ret = pnp_irq(dev, 0);
+		if (ret == -EPROBE_DEFER) {
+			struct resource r;
+
+			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), 0, &r);
+			if (!ret)
+				uart.port.irq = r.start;
+			else
+				return ret;
+		} else {
+			uart.port.irq = ret;
+		}
+	}
+
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
 		uart.port.iotype = UPIO_PORT;
-- 
2.39.2


