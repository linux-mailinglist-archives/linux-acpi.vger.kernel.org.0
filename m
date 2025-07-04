Return-Path: <linux-acpi+bounces-14992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC275AF8870
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40305586836
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E9274B54;
	Fri,  4 Jul 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B2kDdazX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE651272E46
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612683; cv=none; b=f5RcpwOBbMhJKead+zjUej16jwtWL4DhHFaNM3Lp9yFhQKbSsHpg67y54nfrPWvObXvIZZT2/1Xfoi7VKURLWHKhHXwESGdoTdIz+hM9DPFcmSqfSYB1tQ0xt82guMIZsGLh7G0V+Egsg6dMH/YbNAk/nv3ZoY/udzaiYV0lRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612683; c=relaxed/simple;
	bh=wpGteD02sLvwEnKA7TBa2+SX4iYwOSU082ERtl6/Vjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhhDhN78QeuuafWHNu/t62HT+FHZBuC4CvdX3hFrBeV55H0EANI0ymCfwPdJbnPQ988w4Xg/el371ZGvwxjDVinh6uaSjW23E0uZg1zGY9v0aTLIs8BhW08EXMuZKy4EYf34IODHD00FK3c9O9lOZ1fyWMg8K/giQT+XKeS2r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B2kDdazX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso500495a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612680; x=1752217480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=B2kDdazXn9KyGYigqxoSW87e6P/A0PbahzqZvgnUWRnwiF+sYQwO1BERzfrkh+CexP
         0dP7FeIvhiKQ/n1TRPjcvGTDVNYfiV0/AGna8CBP7oHR7ZXlKGaBiVqXCbYGr+/Y090a
         oBdseL1DdlUEftAaBLZVSUCZmq2kifU4HWDY5+FEod0zA8AiauNHlDc7dUlW/QBYTxC/
         iGmKHFA/OWGliQ0u5IfH1p5wy8ZdCzb6sUwDHWJJyF/mPul80zU/QeUJ0QMJyNX5nCIo
         2+2nTIn9DOO7xeZRBBmiLQGZSJ8TmZA7HbTP8pbRPgONNVHn4qfzw85hcv3fIwq2RqdR
         41Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612680; x=1752217480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=b7UmsGx2jrvxijjtZXbq2X+DIfA/sZV98yxXnOMSZIcuX79ZgeDc1tN++z6fR/ehYF
         2lo9JoxOWsyC4fSuGK+IoZymFjJWiju/LdZ425HqxytOj7A/ibN3SDMTsoTKSBRWnIbZ
         6Ec52xFF41dSNY1sTK+hcdyDoDTm7tkqqzzUE7UP/s9wFSrFOONFi2FPFyvzCT2G5XFq
         3UGP2aHKJij8shW7jmRiJSdMK+t01U88pLKQYpJv+LCHGCZWGPgZZalNTm4DjO0SWo3H
         ux1D8sNtIY1/rzconLg9PjNfaeCl7uWPRStkdEcUonQ0xYqQ2bZKZmcb0yrJ7RPhefO1
         d+ig==
X-Forwarded-Encrypted: i=1; AJvYcCXpb1mPA5ueAXBFB0koTDPwuIdBV2Msu0wKa9C5wTgVlJGfyqpwstNowWaQynF2V5tiYM0NXwExoAjb@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEFT5v5pS2zIpnuxzJlgjrnsbrmNF9s62ACZ94WetncG4q2ob
	Zt56cIXM4Lms/z2BTvMoOignqERDS0PVuZvTkAGTFW58t2vwkJ5gbHyP26sJOXXKZoQ=
X-Gm-Gg: ASbGncspvTbTvpAzVr3QRNaoxtHtfm1FsX/5vGP4O07b+M5MuRkJH94UmY7cs4el4l7
	AdWM8jNZTfj6qTYq1nQNkG9qL+Vt0t6hmX6hbeoJBpK+XVsgIs2R3IKGwTwG/A/c9j754f478If
	Zcn7/lT3jr9pL3mAQkeU9F5KIGG6zimQJ0pF6q4SqlwAnypALspjfIybm021DC/g24nxcqp7Vhf
	eUdPGmw338vWdOIEFaFJ4N7MTrL6vusVLvi+1XrubbTjZYuACGDXMEcMgGfdVTBHRtJTpUB0jbY
	DW29BUtQMqORIbBXLTGcz+TQZSjsRGqJD+hvDxKafA4e+TcXFFZPOrPMnNRzXWgLNvq9wwTo8ND
	0HzArSVxRna6X8Y41q/YUQkPefg==
X-Google-Smtp-Source: AGHT+IH7pAY4DEaeFD0g/LqQ4vl0f8jxx2LFhaIvUOj/iUdZwYT735N07dZ29I38RmiE/z8zxFQSjA==
X-Received: by 2002:a17:90b:48cc:b0:312:26d9:d5b2 with SMTP id 98e67ed59e1d1-31aac212971mr3321434a91.0.1751612679913;
        Fri, 04 Jul 2025 00:04:39 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:04:39 -0700 (PDT)
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
Subject: [PATCH v8 02/24] dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
Date: Fri,  4 Jul 2025 12:33:34 +0530
Message-ID: <20250704070356.1683992-3-apatel@ventanamicro.com>
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

Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
extension as a mailbox controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
new file mode 100644
index 000000000000..061437a0b45a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V SBI Message Proxy (MPXY) extension based mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V SBI Message Proxy (MPXY) extension [1] allows supervisor
+  software to send messages through the SBI implementation (M-mode
+  firmware or HS-mode hypervisor). The underlying message protocol
+  and message format used by the supervisor software could be some
+  other standard protocol compatible with the SBI MPXY extension
+  (such as RISC-V Platform Management Interface (RPMI) [2]).
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+  [2] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  compatible:
+    const: riscv,sbi-mpxy-mbox
+
+  "#mbox-cells":
+    const: 2
+    description:
+      The first cell specifies channel_id of the SBI MPXY channel,
+      the second cell specifies MSG_PROT_ID of the SBI MPXY channel
+
+required:
+  - compatible
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox {
+          compatible = "riscv,sbi-mpxy-mbox";
+          #mbox-cells = <2>;
+    };
-- 
2.43.0


