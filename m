Return-Path: <linux-acpi+bounces-14904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44106AF0A67
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACCD4E3492
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDCC215179;
	Wed,  2 Jul 2025 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="deEezXLT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD7214A6E
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433340; cv=none; b=TnuqYwybtH8NTw7F8CRhqADFFPyATRHTlKpdpSgDLGfZzPpwCevWoSGL2M5hwRTutOJOI8BB5e9VR0ke8EdRdH8xz12KAkEMu1zRstWQ8VVl+/4O8LUMl96v+xe9eIgoQBEXvAi32a3zkpgeJ5Au/gID6Urr67Vtw+1eaZ7lY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433340; c=relaxed/simple;
	bh=vvd5aEr1EHa2kYCEzZk7/ahZeLh22JQayJGJfQ0Amwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek4G6BtotYmoor2kjl1vZvmmUkaw3s4wQJ+vAD5TNSV0b/tiL/9SYksg5NxKvXFRcTi3gNTntOEDlwv0Qcf/eJWM6ulkZECbrY9MgPY2c2S/yM2L05bmQ1nWXe6oBJmrWgU82MFPgfJsiM8TpR/ghNWhgoCwh4iFsOT+tP5Q0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=deEezXLT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350fc2591dso61241775ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433338; x=1752038138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIoG0/2CSPJ7QI1BAwRn3+gvtI7NC6tH67IoLVRWsu8=;
        b=deEezXLTMUc7jReGIsMaqikCJeoA+K9+Ii3ZlRcHzAvdaeg/mmcINdo7lQctiJZ3wr
         1WmwoPPZlOV+maB8PecY/OnbmL+krofCpiRmDYu7EneqoHuo3ZHfbmbwuOl+BFKpPFty
         lsKLCQjTSa+BvIB767OHGFieY2ujl0C73M5T6mbYACuFHMwTiMsaRWwia2X/YdAu9DS3
         4liqc0o/axsJb9ZSSPsq4ipC9O3syJ167sJHKdpjjsy1x+nnQAa+0xRRfwIUXh1YCtEf
         UNYwtb9hCF8ZStOQMjJc/qDNNw4Qf5+zHKP1QUbUDlL6b4PV59wDqVOmD/oIJ0qQlOqT
         wVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433338; x=1752038138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIoG0/2CSPJ7QI1BAwRn3+gvtI7NC6tH67IoLVRWsu8=;
        b=vYVPQRm5Jjk3Kr3/jb9XcoINWH6YePURAkAFLb9+x1JXiAbvz7ixraUaD0qZb4jQcI
         l/bwp1OYqdV79WOJHO78mapZ+e3UIEyQHHwlGoeeTVTz6iEsNKqK+9YDM450DQFU1cym
         JJKO5zSgIYYU7gapMMjf0GqB0sPp9fwTnU04x41Vju0K2YH2sMgb1SqBfw22NCu2Q58h
         woAJ2Pr8+/EdIJ9TpFRnLpkbOJ9DR0HXTB/NWWm7XLMcrgDz9GuXKp7Iek49eJWimsIj
         mBHnyoQzp4ofSTaXEIA+MKrWdBSLrVSGqY5yE4L/cGoUgiHT1VgIdtpNqiKhQChlPf6k
         AQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnI1nEew9hkaggun2Nk0p4rz36CZgFyO/uK+TPFi5NP/Rw7axwyEGqf+06HZRDIqMakV/oVVCc93k/@vger.kernel.org
X-Gm-Message-State: AOJu0YydRF6uJg2jvtSgnrTaaR6yG0bp+ElMAWiInVgvAaibVC/COIII
	tRQ2iGIvIDRjPcsBp5b43lRyOCXVGYoHJ/aBve3eQq0z3RQ+2P/vGsmQnnWPbcCbN3YcRHXZq1U
	eShGL
X-Gm-Gg: ASbGncsRAISaxqj9qB0fj6M24pNGRe24ZTnwwlWznNeaggDTWyX2BF/yvCSsyAgPsY2
	eESXdJsDD37S0OKyEmMpt39QYPwXh0bsB3V7f5ZygeW4tpHcYvF1QPR3P+SCDOc4/nKXsd7RY4V
	L5KAxPcpSqJgk9Fw4TLi6W+VA86kmByLys4GAv5A4/2Hh3aISN3ZLlh6LZb5mLITCyYEbbVa89C
	RpPIl0Zn7MUxHZT7LSBJ70bytHGNWURzY/lZIcEOJEjSu6ZWpzcTKhFi7Yoq0Pau1/ef/xNR25g
	aNC0e/Yf5DbF2NWbikZS8YF09W3rrgKQAivkAcmGW9b3IZvDIaXLKOoToZmEO/8TORAeUhpZ9gw
	yc+1eKyxQRuDc8w0t3ETtG6FN3po=
X-Google-Smtp-Source: AGHT+IFGXbh9c2Bzrg+n0L83k/iOpiHjIddjs0COzT8LmyyeoGEyCI13QifJfOuXuLEn4svubKrHpw==
X-Received: by 2002:a17:902:d4c5:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-23c6e7eb70cmr19839295ad.15.1751433338295;
        Tue, 01 Jul 2025 22:15:38 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:15:37 -0700 (PDT)
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
	Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 12/24] dt-bindings: Add RPMI system MSI interrupt controller bindings
Date: Wed,  2 Jul 2025 10:43:33 +0530
Message-ID: <20250702051345.1460497-13-apatel@ventanamicro.com>
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

Add device tree bindings for the RPMI system MSI service group
based interrupt controller for the supervisor software.

The RPMI system MSI service group is defined by the RISC-V
platform management interface (RPMI) specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../riscv,rpmi-system-msi.yaml                | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
new file mode 100644
index 000000000000..b10a0532e586
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,rpmi-system-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI system MSI service group based interrupt controller
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
+  The RPMI specification [1] defines system MSI service group which
+  allow application processors to receive MSIs upon system events
+  such as P2A doorbell, graceful shutdown/reboot request, CPU hotplug
+  event, memory hotplug event, etc from the platform microcontroller.
+  The supervisor software can access RPMI system MSI service group via
+  SBI MPXY channel or some dedicated supervisor-mode RPMI transport.
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
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    description:
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-system-msi
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  msi-parent: true
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - mboxes
+  - msi-parent
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+        compatible = "riscv,rpmi-system-msi";
+        mboxes = <&mpxy_mbox 0x2000 0x0>;
+        msi-parent = <&imsic_slevel>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
+...
-- 
2.43.0


