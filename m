Return-Path: <linux-acpi+bounces-7519-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FB94E45F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105C1280602
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBF17BB5;
	Mon, 12 Aug 2024 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kWYK6Fq/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57519535D8
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424471; cv=none; b=BLlTSsiNMZNHWPV6/UvHUwHFaiXcuJs/zwe+PuEfMuCWnqeMbKxnxX4+Se+i3jG1XRoD58jqBTAujIW4cmoad1sZXg5OQRBgIVJomx+Q5aw1iImtmKLIlyqwwDeA2SinyzR1SeF5k2Pfx07z7AzOQbjtdq14a/x6JMV3qmrNu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424471; c=relaxed/simple;
	bh=kUGmilJtSEYHecokfsz1Dv8H4HmvP4hekzWOib2uw/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXhb20SvWQ8wCh52kud9jB2FUcgSMocymYyVXGmxisLt8lYv/hMyD4zOmvqTZkIWns5CYN1N1JZdH1JHDftkS1fa3NJGrdb9xkcYT1Xfs2zI+ZOt4xbmvfZ2Y4HiZWGlhAtr/M+r6uREdaSrOBAN02Ltf8GtteOheVq9Kx752Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kWYK6Fq/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3dab336717fso2632602b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424469; x=1724029269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2F9HlOmYYBgfOGZ5Y5XAW+7ZHo7CSZJxIOIoseG4Ek=;
        b=kWYK6Fq/HwdwMPdSnaD01bOjKw/O3sxBsSzc06M8JflmeLCiw8H2wVKZUrovQGpVJX
         EvYk47MD/ieoRgy60gt2rTOGt4lKlZJ9u3Gd81wgmKf/lwLf+OePaorIjOOJsTfViZ5q
         dS4LX5DgvX+qlI91hDr7yz5nya1JUYpSfOO2puRfodzSWthO4CiKL/oztDEneEo+LOEo
         A3fKPwRDUXTMuMXw0H/slEJPCSA3C3WTrbgEfpnBPhztFp+xE/GnghQvmkpxLtIFN9tS
         1NubejwkX+KR1eaTead5IhTRpuYfmqklZKf52QEHs2x/lJsJWiJ+Mw3quCVE1FUejdu3
         eQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424469; x=1724029269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2F9HlOmYYBgfOGZ5Y5XAW+7ZHo7CSZJxIOIoseG4Ek=;
        b=jaF8kPstQNAxwSr6GN6Zs/ZSH7lYUxF7owtv0wZRX9ui+GSFeeViXjmZL+DRJ2xw+w
         szIPlN/sdqAX21SiBcXYnMu96HxcvXqelp7tykK4RnvxlKFcegENe1vU9TqXDZQUocsg
         yHI25NnO5yOCkq79+turHC+iobKOCVWMN6fhRVx4wfiprq2xv5jEWxQdTToWvpG2b24Z
         6zf6O3qJpIWD0UR6uRlL+JKLrOz7bkJuYCvQWbMhCkUyHeZuhz6olOf+v1+m4S36gPI2
         KHJFuVA23h18y8/U/bYtceVltzReDuUR/aaRB0pTVSmOujMGnv/LAE67LsINYDgYkKnI
         NEvg==
X-Forwarded-Encrypted: i=1; AJvYcCVKwoYY0urjKLK+f1ISQv7r1BpE++6YNmAwM2/wSJ2kCkuJBGNGXRHOukOj8GcEgL7QL2LYeKjfvtaznGTzGm6zPesoMrFxceF5jA==
X-Gm-Message-State: AOJu0YzyJI2aVA4Rzl8ouxNkglg1s2o0G7bB5Xl0+DlKrauMi7i5vqSr
	AMaV3nA9wx1kzvUaCn/UCkozIwWTlp5npVqLAb6LFKXm6IVMPhgbdEIJp1v+ksc=
X-Google-Smtp-Source: AGHT+IHZXV1nZ3pGHtKOzIjfGzSIJM5PQQnjoEr5t/Q7EAetVkMKeElEktJkKAiBNFFJkWIu7MYWBg==
X-Received: by 2002:a05:6808:bcc:b0:3d9:35df:8f2 with SMTP id 5614622812f47-3dc4169de4bmr11444935b6e.28.1723424469384;
        Sun, 11 Aug 2024 18:01:09 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:01:08 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 14/17] irqchip/riscv-imsic-state: Create separate function for DT
Date: Mon, 12 Aug 2024 06:29:26 +0530
Message-ID: <20240812005929.113499-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

While populating IMSIC global structure, many fields are initialized
using DT properties. Make the code which uses DT properties as separate
function so that it is easier to add ACPI support later. No
functionality added/changed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 97 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 5479f872e62b..f9e70832863a 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -510,6 +510,60 @@ static int __init imsic_matrix_init(void)
 	return 0;
 }
 
+static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
+					   struct imsic_global_config *global,
+					   u32 *nr_parent_irqs)
+{
+	int rc;
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids = global->nr_ids;
+
+	return 0;
+}
+
 static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 					  u32 index, unsigned long *hartid)
 {
@@ -578,50 +632,9 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	/* Find number of guest index bits in MSI address */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
-				  &global->guest_index_bits);
+	rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
 	if (rc)
-		global->guest_index_bits = 0;
-
-	/* Find number of HART index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
-				  &global->hart_index_bits);
-	if (rc) {
-		/* Assume default value */
-		global->hart_index_bits = __fls(*nr_parent_irqs);
-		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
-			global->hart_index_bits++;
-	}
-
-	/* Find number of group index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
-				  &global->group_index_bits);
-	if (rc)
-		global->group_index_bits = 0;
-
-	/*
-	 * Find first bit position of group index.
-	 * If not specified assumed the default APLIC-IMSIC configuration.
-	 */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
-				  &global->group_index_shift);
-	if (rc)
-		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
-
-	/* Find number of interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
-				  &global->nr_ids);
-	if (rc) {
-		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
 		return rc;
-	}
-
-	/* Find number of guest interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
-				  &global->nr_guest_ids);
-	if (rc)
-		global->nr_guest_ids = global->nr_ids;
 
 	/* Sanity check guest index bits */
 	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
-- 
2.43.0


