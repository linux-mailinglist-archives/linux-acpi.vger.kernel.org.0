Return-Path: <linux-acpi+bounces-15387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A977B13812
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383877A1791
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871526B2DB;
	Mon, 28 Jul 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OQ+xphiu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539325DAFF
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695895; cv=none; b=nAvEDG5z8HBgUCQhVgkVZcQv6vyIPnZURlCqzcZ6ANupKr5yQtzyKMCZbqoNoiB2PDNlqdahw+pthLIqBdcmLgDC1RyAnadd5elV9U16vd56EIl5POnIGeC0Z+7KcFbDEckTZh7j/UXedQf1C1XqPXKNqcWPVmQ9Jj3dltxrjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695895; c=relaxed/simple;
	bh=BkvhWSTnjiIWMOiaDZEJPElgPR0D+BhOKMYO4PPRBxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD1CQn5veNDDJGn3W2SE3KiOL+SGpKQA86MIWvMxme7njXAttG0GdSYEqMe7sSOGhOHtQccgzpuODkFdcaiKh3Uso3QQyJ5/goS+syHRT3PzXPjrfEhUS+tdOQMTVDZciwZbhZMsbEtcc7pVB78pgDGPfLYasayH5N8Tkr9EySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OQ+xphiu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af51596da56so2990146a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695893; x=1754300693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x549zkWeZBn9yckX51psel8f2gpHv6i7OmNEj/3BvHk=;
        b=OQ+xphiukz8x0QDClcE1KNags9bZfbkyI+HyW8ZfgLHQzcIYmUME3vsKa348RFPem6
         C8qPbFEvmedn1MhHtaaR7e9m0+U1Ss0Axs422nT8j4QIRHXrUcdbymt7m9hVcaZyXM0S
         gyBM4I3yXVNLzif7EtzwnAB2A/HaOj36HIRzmXx0CW+SFvtEX3a2UtktTq5dXAV9k7Ig
         FRgX2PfGzXArxzr4wfBdF7akOpQMx+2YcewmJ0HvmIm8HC8njEJH8NdZPvS9xnO4/Pbl
         bH27VKv6XZsqnH7+im+3U/GFh5N9GoEal67bLpTk9iKLHQR32Tu2cvkUemZbzw0/HuOG
         IwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695893; x=1754300693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x549zkWeZBn9yckX51psel8f2gpHv6i7OmNEj/3BvHk=;
        b=kc/W6KiehhurRxnIVxex0QWfKSStJFLNMkYNqzT9nSZ0GHXU15ztdK2mqIBQ8nvPaJ
         hhTrrvffH44xrQVSlobJhntVs2HWSFdDtHxA18iPQVkjkc04nUWagFpGD9Gx66Wrtzmr
         u2+C3KQkhr17xlwL/l4ngPRkg8XhwUuECYSy18T9J0xie7KmKXWIGWyQbh4h5ghpje8W
         4ISD3qlOucXYcVG8RyaWdtEckl1wELK/aojWoRx7c4pEfLBOqvOg7UdPHDp1xJ1wmSeh
         3NMkK0ZZA3gECfoUu49Hh0+w49yb57oEzZGpKnfnr/oNolH4GSdc3hTcjwNZs1HYUiBf
         GZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXaZmBn0R1gR373kiP02NJwQ7n14clfvQ+HDrrxYXK7+qQHEl+ralBndyTu/6MNdAHnLy0d8Gs2grqs@vger.kernel.org
X-Gm-Message-State: AOJu0YyjILVnP/4KHdXjFsOEroK5f2wDU9CaqI3AgtNWIbP2FFi1EYIx
	VVNr9cbAzudBtt3Mw7GnhS4+dZIbpnCSO2HPKcihY7Ua1c0rP1bJRkfBJMlu0w7ndZA=
X-Gm-Gg: ASbGncvAO8aT7mgtCOi0buZWWX8VtFqAP1DVqaMvNoCzvzEn7eFVwFT18BUGwxMvzr8
	gfG0F8qy37H0eSkLUnm7bf/mhCvdpt1oGLsKz38BYn/9fc/LarD3QNRvU9+5QgvXD9OXyvGs4Oe
	K/3sSm6cK5MsPmOV2ctgiuzVXQj4Bntn1dWtxoxIwLf4+OIdUkGhCrgZ9Fofo53T/Z4lQJVL8tQ
	kTlEqaHPEDU+z7mDPXRQGmQcwsbzIOBFqKG4Yfd277KSWuYukwmMa8lY4tbf4gbIZ4pN/0TtlN2
	ZAXi+2KZME62rGJNLAxfPg/hQRQlVxmfmrK9yL14sGU68RY15YBlqwYT6TODOrVyuvNrBvyV/Sc
	BxVOhWTuiVgbuZkpXt2YLJRuGsu8PyCK5PXVdbhDk/jO7VUV3buYg9huVqsGd
X-Google-Smtp-Source: AGHT+IGSbo27hBN363qDwsNMdhMoZk2PtIESdVUuOULrb8b8ZFITrd8ZdG3auXim/8/7RPtqAB6o6g==
X-Received: by 2002:a17:90a:e70b:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-31f1744ea0emr283600a91.31.1753695892281;
        Mon, 28 Jul 2025 02:44:52 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:51 -0700 (PDT)
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
Subject: [PATCH v9 24/24] MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
Date: Mon, 28 Jul 2025 15:10:32 +0530
Message-ID: <20250728094032.63545-25-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rahul and myself as maintainers for RISC-V RPMI and MPXY drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..ad6404e8292d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21395,6 +21395,21 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V RPMI AND MPXY DRIVERS
+M:	Rahul Pathak <rahul@summations.net>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
+F:	drivers/clk/clk-rpmi.c
+F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
+F:	include/linux/mailbox/riscv-rpmi-message.h
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@gentoo.org>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0


