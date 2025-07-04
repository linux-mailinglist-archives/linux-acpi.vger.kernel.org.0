Return-Path: <linux-acpi+bounces-14999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCADAF8894
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827274852A9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69775279DC0;
	Fri,  4 Jul 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jKa++m2T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED37279DC4
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612762; cv=none; b=XPFvvUPQZSYpNSqAD6TmAKDKH3KaqOnPRzZm6dHMH8vG9pM6w2EOyP/Nm0ps/rGbtCLO3AB0n6Ub2Z7frWifasNrTZbeAzG2GadIkiukugwPNo8+WI9NXocGMf6k1G4jnlzdyQAjsQzaAE+GOeNVfXi7s95Yx2DpWQmYRAkLk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612762; c=relaxed/simple;
	bh=gqZpMXPd6DL/+kfXUibwUL8SSmPMehps7IgssTY7RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R91qKNzvrE51pl5Josnno9dpIpBFrM7Sjtoy9+UnVNo8/NNklbIs1Kn2XgYqOUdJui1MOPrXC13KOp9hZn76jcwDomcl1sp5RnbbuEt1Ia9VKkD5opc9eDG4VwIUnhpD8+cJATxqHtVIqYC3LX9FGqXdCEFa9TjjEikm+NTY8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jKa++m2T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso352013a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612759; x=1752217559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=jKa++m2T/65KYJ+zWi42iHYdOOtk8WxWplz35AjpfZV98KGo0Cn9inyx1iz63hPl4I
         5m+apzuY/lX01xNaFrnMI5sIZcM9njQsW4cIR5/hP79Zs7I9jO0wX9KdLOtVLrWIg7Bv
         Uvj20kppz7ilK6DBOfi4ncIA89QtfDl8BQfAIytPZ0B+UnShkXmXbYscQHmVCVZKLS2j
         E4vYAMsK4MGjdc5V68pmS5VsJT27O17Ht1ZFvefh2GWGX+GWYoUPvqi1cFgWpS3hGYuD
         YFhCdHFyZvWvauQu7fQEaUBR2d8AElNxXVKYNuInjIbqFEwoEDKJhO7WG6NFEQWdlMfq
         jikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612759; x=1752217559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=KELJhFYmCJq3FnfDBE5UgavePAX4zBBhIJD9nlrw651b4PipXHHIe2tWw4/cZJOz2G
         5z/BiR/qcXU7sxAZ3LHg63hRfu0Qa4L8UfPNwdTrZbRutclCieoGJ+qYknnKH9nyBCxm
         Qox3Wl1GqcI0zStjpnyUMsOMidOWVE1jG/wtSlZvrcSyMfr+yJOLnS9ZI4j49NASfz+m
         uFkRlgVezH8itpC2EpRzW66ml77rATvgC26MrdXpEkMNJPGxMTAhorUmYaWX86j+BkU4
         9Wajm2lVoa7p0b+IEiqGChZGWNmTVD32Kk17IEdMEGftHpvusxvSKXYWviZSUS+6PNLL
         ipxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhKmuFnEyXpIeCvEGYyIrvBG0cv3s82bMBEpEo/c1YDpmHcZYFOVpBes6rzdQVqskVxguEpRoJXKhH@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU4llgyFtcM/WnCtAvC6xX50eFQc19NxZmYwYIphFlsxuDAYw
	yn7VZSq2nWrKp7tMXkDYH90ymRUZMTQYtxnmRz4WlZAtlTj5ItlfsoeX0hAm18PplgU=
X-Gm-Gg: ASbGncuf6te/p6MEjYv4qe13zRHxbThigbzwkcu4rbojs66N/FdK3yP00FiOn6Q0YP2
	AtOFwcUUar8r85jULmy0JyRv2RbHR8jm34YsCN4bbE1SE7RXntye2V35rJAKpLYVDW0mpaDDdpC
	1qazq7boDoagJak+oriyNWtk9qLgZTII3F43g3m9S4z/ktWZVmrS9/xlRvr/QliXe7Hh9Hnt008
	nTRHY/D7Wo8ZRibHxw2NTO7+74Qi+/3lnvgKleKE37WqHs00QDcQJg3phs0SlSMoT+h7HxrOBCB
	PYvYqlnizpq/m3qY0khExEwQqbq8AiYRMKRrF9GcebZYgdI3cZoMfEbr4XXdGFbPwg4LbZhqWA5
	oEo4HWYuA+pTr4s4AaPON57FnIg==
X-Google-Smtp-Source: AGHT+IEsY9DjJEKtUwl9ZcWbIEnsXVkhcprck0a7/CT8yNIOArahqDh4/mdoR/7EaIpy+0pjEevTMA==
X-Received: by 2002:a17:90a:dfcc:b0:315:cbe0:13b3 with SMTP id 98e67ed59e1d1-31aadcf4962mr1778242a91.7.1751612759095;
        Fri, 04 Jul 2025 00:05:59 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:05:58 -0700 (PDT)
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
Subject: [PATCH v8 09/24] dt-bindings: clock: Add RPMI clock service controller bindings
Date: Fri,  4 Jul 2025 12:33:41 +0530
Message-ID: <20250704070356.1683992-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the RPMI clock service group based
controller for the supervisor software.

The RPMI clock service group is defined by the RISC-V platform
management interface (RPMI) specification.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-clock.yaml      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
new file mode 100644
index 000000000000..5d62bf8215c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based clock controller
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
+  system clocks managed by a platform microcontroller. The supervisor
+  software can access RPMI clock service group via SBI MPXY channel or
+  some dedicated supervisor-mode RPMI transport.
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
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-clock
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  "#clock-cells":
+    const: 1
+    description:
+      Platform specific CLOCK_ID as defined by the RISC-V Platform Management
+      Interface (RPMI) specification.
+
+required:
+  - compatible
+  - mboxes
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+        compatible = "riscv,rpmi-clock";
+        mboxes = <&mpxy_mbox 0x1000 0x0>;
+        #clock-cells = <1>;
+    };
+...
-- 
2.43.0


