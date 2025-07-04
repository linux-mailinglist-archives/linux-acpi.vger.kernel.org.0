Return-Path: <linux-acpi+bounces-15001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC3AF88A2
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AE18961A7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C427A90F;
	Fri,  4 Jul 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gAGd50uE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0545274B54
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612786; cv=none; b=jweTO1FZwSjXjnOCcOyMJX4/jYA4lP1cSQR1LKtv0Tw+a0HwgARPjTkCzm5Q9WDE0U815cxLsosInt1jM5orWeIk77gpCeVkG+0R3Pwwd47l6CeJ4laZn4GFyewT3+Y9lKJMasI6VoqWUlhDp/VXn9J6FMq7zliqO+++zCz11kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612786; c=relaxed/simple;
	bh=sbelvMc++opfxCsxTvRuuhoDW5jErxOHLIiEYhi1zkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4Bcwuncpc2ryrbC1MNFZSIZBSL+usrYY+v3WZQMMFO4/1RbNIfze6I/7SyeCxxnF28qzuCnJmBNTbAOcqQf/MHcVk1TRGmMvSgSfTSdpENs+F1fLLkeJFIGj8yzFuL6NE2BTUWSOv4tbT7macjAk1IKHOfyV6mUm5wyGQ/unjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gAGd50uE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313910f392dso647806a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612784; x=1752217584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=gAGd50uECtTd26+oVC9QOx2AprRxabtvAf1FEXGJlqRCq5eLGY/sz5zgtfMRTVABX/
         ZRF+FSMuYHwTVQ8C8jktlwGB+AVCiIFBcMxulCJJ0JK3XVEG2+chP+vwz6ZwB5zEvFay
         zIVWWPqSya4+P50oFNAkm0/INdUXggtDlpsRtz+0+rrJpfCg26beF4SiFV+0Te1URGTY
         cPYScCp91Ajn3i8xR0IE/1bkCqewL4z5SHtX32lquunBSTvtupgS7QwwcdrGsj/F7I6k
         nPQGRakIsm/IqivWkUDlHLeigq8RKIWFW+1MRxZO0oat1BBsF1ub6duWkMoFVUs5kKVB
         M/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612784; x=1752217584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=Iv5QU44mYTAYlFMYxoR1iTctHEBNHdgoXVNUfhGuVHi2hmkDwyEPTdyOyxAw0cpwSl
         YxLtLy1Fx/b0rU+wf7GjKlYXXcPsgeclvLhnflLvC5nqoiw0x8QGfSqNNq2Ak83FfSE2
         gYCiHpYAJUrUlKrW5HY9JZzpCSFJedC9ptBhHx39W6nkHVW5R8ud6qMZuf/RnmG1i84j
         w0MSLccL+xSSf6RLt/eOQXl5i4gBRwYi1ElJ5BeD1Vkk3YfdD/6bbAcs6Im9vTHnVnGj
         jnUJR2CHxLlIJcQK4FxnkHhyjpgTYrN48YJ6KvGz8XG27DAZ4llVB+0m/ilrr1i9lOq0
         spNA==
X-Forwarded-Encrypted: i=1; AJvYcCWfIlOa61a7xxr3DQCBopziMWiS2o2uTx8rROdXSlXO7WTURFwfQWphOzb+6sT8HE5sEI5/TA0NNf48@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKI9aplMazTCoddFuScUgC/bIvh/fuY+iMQ9npfgS5xEK4JCo
	5OgunyspCFYBISVkkmvPhoOEzorG4yIsxJCN/Cybwr6QfiN13hlcnm59qnbf9gORKsg=
X-Gm-Gg: ASbGncsTxrlW0ohC1eFPfB4Ttg44XIwcMc5U4uoBfNx2Sp+XPbsulFFhjhlTxZqa+sD
	hgTevM+Ci/ylulv6up+2oyTcUYI9Ml0v7QvSuUVrcmCy39BAJ2B2bpQXYQL95syO0btPeLziyJ+
	En9jFccQsxamkuXcaTzGh/ncAY98eQNj7jaB4G545xDGxeeTZUkSAmLSJ5eFvHgFk1nPPNiQysx
	KGG3rlk+5lrUB/WnM6csgzm5EC8hEcyWatmhY+Jyjd1bHYQ0zTKLUMJy9yy6kOkAQPAUisWjUtq
	w8AZvrHRy/bZ7cX1jblKWlZbh+bUb3FbPHcMfqVH35E9702tUTqb4Q0KWIO0tIHWXKINlguLHa+
	A++xS0ITscXgp/qUdyFvQW9kZcw==
X-Google-Smtp-Source: AGHT+IF+TdlZoELuuTjQaFBwsOfjj9nVaP6qUAJ2uy4CPsdX0ww7K5CWHbfKzfTy6kNCQU07DyLnCw==
X-Received: by 2002:a17:90b:3fcd:b0:312:1c83:58fb with SMTP id 98e67ed59e1d1-31aadcf8f13mr1549627a91.1.1751612783864;
        Fri, 04 Jul 2025 00:06:23 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:06:23 -0700 (PDT)
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
Subject: [PATCH v8 11/24] dt-bindings: Add RPMI system MSI message proxy bindings
Date: Fri,  4 Jul 2025 12:33:43 +0530
Message-ID: <20250704070356.1683992-12-apatel@ventanamicro.com>
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

Add device tree bindings for the RPMI system MSI service group
based message proxy implemented by the SBI implementation (machine
mode firmware or hypervisor).

The RPMI system MSI service group is defined by the RISC-V
platform management interface (RPMI) specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../riscv,rpmi-mpxy-system-msi.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
new file mode 100644
index 000000000000..1991f5c7446a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI system MSI service group based message proxy
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
+  The SBI implementation (machine mode firmware or hypervisor) can
+  implement an SBI MPXY channel to allow RPMI system MSI service
+  group access to the supervisor software.
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
+    const: riscv,rpmi-mpxy-system-msi
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
+    interrupt-controller {
+        compatible = "riscv,rpmi-mpxy-system-msi";
+        mboxes = <&rpmi_shmem_mbox 0x2>;
+        riscv,sbi-mpxy-channel-id = <0x2000>;
+    };
+...
-- 
2.43.0


