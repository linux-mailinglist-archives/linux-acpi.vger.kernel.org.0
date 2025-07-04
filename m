Return-Path: <linux-acpi+bounces-14998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC338AF8891
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0411C874E7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5627875C;
	Fri,  4 Jul 2025 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mEENh5AU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833C2749E6
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612749; cv=none; b=M33GG8xi27DLER+0Db2jqmnjGXsET2jtGYLBT4nFx0dhU5t44ClzFIW9BsyKtLpOiuENNNLUGdVpqfX+7IEz9rE7/5vcn1EZeEu8I972gOgLAj5zG1uk0DY1/UvRIAm759R/BHrs6m7xEtwzmWDpdkBBvSSeZ0QGGMuXp7sJeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612749; c=relaxed/simple;
	bh=psnTedHrRclNzYfKOxzNdzEC/lgie9/9OjOQXPUJ9ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIWGgixVWmiDvYAECFOiCZdKDBaJfI9KFjJIwHnQIQstmRCuGen/qzUw9hENFkFAsPbzutPNovBL9ZZ4jcviMc2PRTPHSJB1sBgQJcf3LebFvD706qdQyu8ESUZFbaLc6QtmQCZOHNbW2uGhjuy9CdGPs0Ym5SiGQIW/nbEsaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mEENh5AU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d578e774so1537493a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612747; x=1752217547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM/HZQdb2lcK8V7OkC2GVlA2nnGt1f60vmRpDyo8E4k=;
        b=mEENh5AU/6DrOVelUFhjxKgJLY0Xnf83sNPuu4aUEB9ePkYmX68dcjdc2rL/v4/k/L
         GkiItF+tcvx4X2IeiIKTwTbTvqw0tlKd+6tsOQRTjV6GuoLsyvm5uPcttENLy+tAlHp5
         1EN0V1EcMH0/nHAEws+7djM4R0AMRipQi4G6g2DIMIHW/huE32eui2PlJ1/7oPKeUeta
         516nai761esP8gsq1okr9RPPNqryQlNm3ed6HmGAdnZDQDZWhRAMaSrjjmyBmIct+kWF
         IOZ81BJ+uunhGUD4Tc2qgkE3iJGr8HzQb5c52cHf72vXkeUQzByjDuUbbWG+Yu3PLEzF
         7kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612747; x=1752217547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM/HZQdb2lcK8V7OkC2GVlA2nnGt1f60vmRpDyo8E4k=;
        b=H5ZvgzzoSOPvD5CukJuQdbwxzwuBiAC8Q5jTA0YR0cW8CgYQH1RcrrxMVl86vp2wHl
         ct98/njdJVYMcDGxKi6pEqFBNvS0MlMCLw4VuDZpd/xJz4KLEQRaZjJFDeujtQtPTbRA
         XSv+uIecbwCMdiAjPswLxTxZbng0c9IDb6QxZ4ytQW8sm/g/iCPIoZPvdxZV54XOqXKk
         EyJtN4TlyUS3zFFPnS0st/bgGvaGOtb314BIPhhEbPyD3bYiHXmeKp4ceco7EoOhzyNw
         4KJzfVEe4Mg8akqQ6qxd7z+2P2fh5AHsCHbU6n4964x4DjxpLXpAwufmyR82A7opH1Mc
         iI9g==
X-Forwarded-Encrypted: i=1; AJvYcCXRE+AXvqhcgMJSBDM4aZZIIAVhfZdMypDVXOTE8r9kIAUD6kXD+u08NXv9tYNoZArToS7u9GNticEy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywckcax018cIUXnMBcnBwr2v6x1G59ytYH5i9+AbnVHtlSTplVa
	dZ1ObksdH9ru7JuAPSvCfgk/8W/DhnpmISN0WK75WJmK5b1Zmf7SW/WIAZzyyzwNx3M=
X-Gm-Gg: ASbGnct8XU6KmWusY+RVg/PJDhHU2zI3ParY9HmLRfoI6wdSHpZ8iFqhMEi6u1nfRJl
	ZL3OmUbcJlaoGobfHbCKc8BqG5fJOhw56rd5tytixPK+H4jg3DA6drlEu7AkqGLoPCvpLrH/SRQ
	pbtM0Kj2zo9UJxyTJzJYGBaLWHIP56czOhUUs7ihtHgVoup3/LBAkJGbNkebNUtLuxqp3JpV1xf
	Xhb7pt6GscGQHmY2inEa+0Jc6ZGIK8cgLLzybffgE5Gl4kyBPFktRqSVVxszfOnOL3QULKJsbbG
	E87uK1mWFv3jMiWw7YfeWvITCqT4vmgVObVUrG9WrsvAsCsIKAPzNSoWdfYCskQfbnD6XjdPhlc
	ztTj4skcqjRDT4msBUTkc1TJGGw==
X-Google-Smtp-Source: AGHT+IHtmFW2/QY9JlxyY/sNpsmHaQgh9pPlylF9L8hp3qD/XtkbiHA4dJh1wnEy5Pds8AHMwLTi9A==
X-Received: by 2002:a17:90b:582d:b0:311:83d3:fd9c with SMTP id 98e67ed59e1d1-31aaae6d975mr3196784a91.0.1751612747456;
        Fri, 04 Jul 2025 00:05:47 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:05:46 -0700 (PDT)
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
Subject: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
Date: Fri,  4 Jul 2025 12:33:40 +0530
Message-ID: <20250704070356.1683992-9-apatel@ventanamicro.com>
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
index 000000000000..70ffc88d0110
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
+    clock-controller {
+        compatible = "riscv,rpmi-mpxy-clock";
+        mboxes = <&rpmi_shmem_mbox 0x8>;
+        riscv,sbi-mpxy-channel-id = <0x1000>;
+    };
+...
-- 
2.43.0


