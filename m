Return-Path: <linux-acpi+bounces-15371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F4B137D8
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E703BC246
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19314258CC1;
	Mon, 28 Jul 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cAXGc/H2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3F2566D9
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695738; cv=none; b=KrCrjpTYhr0TCtjzaRo5DtRHK5hFzey68VxcdrqDoLkeDu2QBmxjyOo+H/7XUIT+iwnurwGv4Y7ZuPMLTbPlHGTxZcRiUl7tHNnoe1ERcH4RV+ANMf1ZDURCaeOOd+Mi9Tqd3hiNYy2/CMXJHAo5ciJQeBD6iNPTiWxV9MwYpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695738; c=relaxed/simple;
	bh=dNnAUr+2trSDmCnQ7YgS/ZuDyO2yPRTU4DJLikPf2R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aptXtMFRHL+ZrboLIx+zYAgQxyRY+QmLk6SoaTDShrZuPAP5sTjMOtdnHwqM+rzbLNirS30Op6vh9leB68veKTWeKv6LvNPAPgo//TWZrC44ZqUKkVBqv3X4wdKEkPrWtnl63ZrTZFkioGj2q+l7j65x4vDiebwKMc5oKw4SZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cAXGc/H2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so3454043a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695736; x=1754300536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=cAXGc/H20wK0RQyxEaEfP7afvbchZxTmin8MaZLJmaNJ4/QlCeBX5yDuaSUgcNegrZ
         ifqc4WDaIUTU5A5rJzSOniSD+e45smpWwSgpp6eJOkWItm0C3IavvlbKsxTsHVlFzIjW
         dAMpBb81B7oBbFMG5DiNoZcVFOETVbF8uTVPVRq5OJg6sHFHqHyaWxlIYG5Qak8x+FMa
         ZmODj2LqIELQop8hajQMia4eqlY00GYEMSItnNRgrdFMY6TL+UYL7GDbN668e7MdPH7H
         bXbyOteI0yXraTKbEiLiJwVNm/X9ftBOrefA6sPolxQWNmsheRZM7jrOO/M+Pml4SIZv
         36fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695736; x=1754300536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=TvKqWpalLG7GV01tQH+aZLMShKTHk1tnYU/MIB/rI2RMxFKv/s2MVxdwE0zNJivcUG
         nUlS1c5CV6gedqNdyysFAg/Pd7VrcIldNARymWlHZTJC+vpxGmdNijOq+TT4YQ77jNuc
         BaNG4F/4bASCTgz2rjgICcBpp2rBAs9DGZcRLlqhWgV2eLobMJd/vDiqOeomHVkovi+h
         PlTeTCYxyX2q5HK78CohVan8rTuf8YIYZVe9MrGKBI8PZWu3po3dtKuUnsiL51VUuS4Y
         /8LVCuBrzU/TrutyPUw2l+73L0l62ADITYgRB1zYDSs/Jdb+qzs+dGB0aKaBfRyIuXeJ
         dgQg==
X-Forwarded-Encrypted: i=1; AJvYcCUI1eSxR/Z7SRq+KWYQZWURyl1kqSRjn7hojJhxKUzm9Botp4c4emXyAwlZo1XKXySRvQb+jRKRAg1J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/qayRjbtXECubcJXHp+emhug5MNudwn/Qv6sz/Nr/HFYGY8E
	HzvHQU0FONdaf0u5MHRgfmBbnhqEwFWSaHq0W1qMyicJ/X4dXWa8q7Az1ZAytiqiaf0=
X-Gm-Gg: ASbGnctBBHuxLBv7denJOQt0eZrlaX20U+M47orAk6CcKYsmMY2Qj8WQHNSDCr8H8y+
	AW4Jn6NcsmaxL+19AlxiUjQzjgMTdkPnxkZL3prTde6HoSKxx8Vghrtr39U7d2gOJXsGc/kkdRt
	Rv7TXuV/FZTxdBkCaPUav04zTQqUwFEa1WAdkCkzvjURTyOuvIp1RoTX9WNIrkON6yN+Giea7d4
	kQrAA1h00wZuMDxsX7HnA/xUUZ3OvNGKpZrHHTcz7JUUZnDAdo+1e8oBHbkU/4EyErQfaqZM/1K
	BlgJYiTPr8b7oh8TGhtOjuS2OoCBSugJctTo7R2LN0mr3uLTGq4v+Xk+HbzwzdMfqSmGuJVDml4
	btGFRtXFUIua4CoJa7qgw9VB23fy95mCi53l5F/pqKav+gf6p/4vsFAJYZ+ko
X-Google-Smtp-Source: AGHT+IGMNexUFTZgfnglCwA8dHkB4ePGnpWD+DuX2cDV9JJRgC1BszN5eGUa1rBL9rVd8I8xmDxQIg==
X-Received: by 2002:a17:90b:1d88:b0:31f:d0:95bc with SMTP id 98e67ed59e1d1-31f00d09a88mr2516269a91.25.1753695736376;
        Mon, 28 Jul 2025 02:42:16 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:15 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
Date: Mon, 28 Jul 2025 15:10:16 +0530
Message-ID: <20250728094032.63545-9-apatel@ventanamicro.com>
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

Add device tree bindings for the RPMI clock service group based
message proxy implemented by the SBI implementation (machine mode
firmware or hypervisor).

The RPMI clock service group is defined by the RISC-V platform
management interface (RPMI) specification.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-mpxy-clock.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
new file mode 100644
index 000000000000..76f2a1b3d30d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-mpxy-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based message proxy
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines clock service group for accessing
+  system clocks managed by a platform microcontroller. The SBI implementation
+  (machine mode firmware or hypervisor) can implement an SBI MPXY channel
+  to allow RPMI clock service group access to the supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-clock
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-service {
+        compatible = "riscv,rpmi-mpxy-clock";
+        mboxes = <&rpmi_shmem_mbox 0x8>;
+        riscv,sbi-mpxy-channel-id = <0x1000>;
+    };
+...
-- 
2.43.0


