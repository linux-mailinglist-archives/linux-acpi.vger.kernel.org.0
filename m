Return-Path: <linux-acpi+bounces-14901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E8AF0A5B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4284E3390
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57B1FFC46;
	Wed,  2 Jul 2025 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LfWGNmog"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01481953A1
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433317; cv=none; b=IZgW2k82J/O8E0yqlDlSYEnS7ESzapDq2XxZVFNxFBYySVuJ63J/Vq21ytAEY23etoa2mOUIyiFFhRFn3DUjBg6XNCis6DLlQ/xhfHvWc93RrWn10PrWmlSSqvjJAeKrBk+qXXnAZTz7nJJQhfanAaQqQ2n7MlfUYATzXjC/WrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433317; c=relaxed/simple;
	bh=gqZpMXPd6DL/+kfXUibwUL8SSmPMehps7IgssTY7RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt7VSeJo9isZ+LS8bO9LrCTQZOOipDv1RPidSkYq8UCA45KX4IRWDvk9jHyX2dfiZnqWAMtQzBkcSzkXx0ltFAAQkMShxCwe3JVwB1kNjX/iUuv/4qVby1iMpBCQp/nWERHwzgra67gJUWMuCcKaJ7NA6+7/lqmlY3lljxSJfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LfWGNmog; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235f9ea8d08so58036925ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433315; x=1752038115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=LfWGNmoghu3Bb7eWP2OvvY6iiv3SYTuDDT97/PY7/Iqj88voxp1xqd337LhPMSFzLc
         Bac6ZqEwr+aigw+NpuMb76b/s0MoLrXXBcUGs8WIgQzj0hp3TUOQuzfh8XwdYCt1XevP
         lhR3rtiozkdgONLTB1sMJX/dmYVZ8CG1VAiyO7MxufyRYNcglBZGfoFTANNL5eEl5H5P
         WohHTTHf5l6kowFaPSdnmQdg7A8Lb/TveV3Y4mbi6vauzodJ3AEYZm4LgYaCO7nN67yc
         6KixI1TBL5PN/Qf9vJ4GC1iQoFqahqorC2NBIUkvMwWbgRtdMnVcDUADqm+LBBG+PFf6
         Pl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433315; x=1752038115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=VaVtICBjEpaKI3/olsvdTAHc3DemUotxFRA/gQxsCeJMA8mb03RVr/t0Duuax8SmoD
         66zsK4S2xYh8tvQYX4wSTcHYXhuYyTjPvf1w5FoCXl3rT2JRrHOg0Teec0aJ/fhCgy+x
         5xiyGBh1lywu02V/iKGSueekWhbotzefnWOMWBK/K1na4eqsPP7uTIwWF1rwD5+wR4RI
         Fry2owohHfxwH1tjWMMsDeyMXATrS3AsWZ8xxdfIywvVj2gZx6/yzq9evzXjyuTY/t+t
         tuyJmGIc8tkIGMDf2rdo+iG6Yl4Ruvjjnx/zVxqTxnmjvaRr/v7IJV7Rd31P44gcwCfq
         UdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtKDnlPuEKSQlkGIsQ+vq7DrEWXdjMvFFXN8BCWGoAzMATrbhaSfqxuIELbp2sXaoEEFD2MJhiGLB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy107UTFJE7/wSVAgZm53yx2kg8rOPfKxQPVpuXfP9cY0TIYSRh
	1AY8EtS80trCopxlnqGrOEJwQlrrVbQjx8WZFzDwVKAIQfWWM9wJj+drOKlPyoyXQEU=
X-Gm-Gg: ASbGnctDGVWwWx/0skld3nlZpLV7+/YZRnrX1qfWIt6DUv4WyQMOGR1ofqCVZgZxOK0
	gqM5FTrCzlukoaNmCBUJWWKCr5Ir7b+W4fkG4w5Q4f44qtZQipzcA+AbUk5CbKWdVsder7Kgw6G
	md2ZFalorqKT9Dgaq4HVSQFewpIvimWO1oCIzG64afM0KxXv6huKefYO6dP9+0sP/esZAJMQEYm
	LiNEcaJEnfNzDWtADTwrJKvAgteSw+EOcimgCt/hw3isflvrhbLJnHKjK+NhWkLAbsT237+rJD7
	V4NsbvZH3/El6P8M0jXOYskBtuPKQpuZhgD9DFR4HOYD8R+NCRV/nJeJijGtAfePNezAIaXANkG
	aGjW9VXw9y3/ToMai
X-Google-Smtp-Source: AGHT+IGMgggDnrWmfF/y7sLrYD7q8r2h5NmHNdzY2iKqbrQlHfhi5a/4jD0kNAv2DXNo1e1e/iX9VQ==
X-Received: by 2002:a17:902:f792:b0:224:c46:d167 with SMTP id d9443c01a7336-23c6e501a07mr21381315ad.16.1751433315023;
        Tue, 01 Jul 2025 22:15:15 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:15:14 -0700 (PDT)
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
Subject: [PATCH v7 09/24] dt-bindings: clock: Add RPMI clock service controller bindings
Date: Wed,  2 Jul 2025 10:43:30 +0530
Message-ID: <20250702051345.1460497-10-apatel@ventanamicro.com>
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


