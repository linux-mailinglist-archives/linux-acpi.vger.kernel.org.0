Return-Path: <linux-acpi+bounces-15767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68BCB297CB
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78E93A59B4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0A265623;
	Mon, 18 Aug 2025 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L7yecv++"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6625FA05
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490277; cv=none; b=pyVucaq4b6eJZZqpTkETt0Qk4CSNNJnIF7Zc+gHIvNSuvrHoQVVize3yA/6/celPh+NK1jwgDHhLDKas5jJ7+jFrVpwdnuxGeybidLyZDoOZHb75xsaAzMVXUuew+T0Y2t5H9j1k8r4qhSwHuOzBE1q8JyLD3gx67o+j6eHEXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490277; c=relaxed/simple;
	bh=dNnAUr+2trSDmCnQ7YgS/ZuDyO2yPRTU4DJLikPf2R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0QWo6kqSyMv4c0lHJzpB6CERNr6vhaAzi0YTxY2foowLqqUE6U/DpowU6XINaxh2nXH7hi7I0WO7g2o83KdedMt01+1nrc9XSqMIkiw2xpGtANx74qd5ZpqHv+ZJSfdoQVzFBAXmed0iSeY0t1LDGjy55P18loVUSS0CgR1+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L7yecv++; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e613e90so2606756b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490274; x=1756095074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=L7yecv++YfTdiQH3LP8sXJz/zFgqIUvFc3RdS+eMbyZXCedJnF/iQFTlcKlAYwckxx
         CHUHCiwOYtO2cBlRIQle7Yt+7hoPtJnaVnanl+cd50qn/YOjve7upvXbJ/sMR+fRJ+HI
         tT7UqT2HCRtvewhktbRzGHvMHUk/F0o/oDGL1nP5vJqE3eiF4yKxfk935Jj5PxvZMofa
         wgztZwZ5A/R5WsoyHjL7n2DQrKchQGCCCRMBduQtNxKR6xf9nw50U+wo0w4gDnONTg0a
         eqAo7fAic2YcFG/SO0YYHEKpLJuZFWpTvwfr7fnhgmkTE6qx+3LW4t1NEtpSvI3JYQ9a
         vH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490274; x=1756095074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=MGMBRyZaGTbvjWASjLDYC3SHQAlfgtpuD0FubHxPg/7h7WN2y7kkiWH28zOM5CjYbm
         LLagNKp2Mf0ao3QqKK4lunGfWAcCfaAsb3WzpjST/tJxkYhg+7p/CnhKmR1I1lizN1uP
         FZfIy2ReEDR/WN17ppt6F4m4qzdxgtkP75Tb8/OhOoSh7rO8r7fSEr5yA2+CRSEC7hpL
         XqKim6n7/RvWnURw5DXUlLFtN0sWcuI1M/J/dbqCXXvh/BHCK+UwcU/H7otZV3bRrt+f
         ZTLt/QwDgHH6eBt9OJceE6iFSoeLlGjTW0hfk3TZKIS6NlXYNJunMy0E6/3Sd+shKnBI
         BxpA==
X-Forwarded-Encrypted: i=1; AJvYcCU/sEbcgBxSJuZL0r4ljr0YaKj6yt2+K5G+OTF/LUz/fS6vfVbYEHqkx+mVzWq8JpT8w2bgEOjiRAQY@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2yj2A4vgLfuhMtnhWT4THrkgXGTvdW1HV4DpjU/weJuL4bSO
	hMs2sqsX3R1QFbd2nnFr4qkz8Q7C5bPESn2J+LjbngwSV8/Mwp/WSxgo6b/FZGf58X0=
X-Gm-Gg: ASbGncvJApWrhb03OTuhmrBklgQF3jwF/jbymyvvixwL1rexwYIjKWW/ItpOgyEHeet
	2hZjtaV999dcqkUHcOPjF44bInGHqeJkQM1C3H3TZDcT2wM2065WPy0sR2z1tbL2MPsC3mjvKTJ
	WzItdIauURJfv1E5fZSjdBDanMykbBklHz+gPobQQNFix5yksiwjGZ678Idv8o+CK0qscijYKpW
	q1mQX3CYffv607WDUyX8gs85lL3tA4vnDLxIW9/GGDanZDyal/Q5EtAG53HGgl32MEb0DfxXRR3
	uREXtfkTSczPyHXVmXYCtKxUBtVJls0QgpDUGMi5LbM/0aBBpPbkEHDBIIreSie1IfgjhZ3Z70F
	aQcawz6k1KiKqT2F8OaGk+gsUxR+XTZKo8SwtTZfJO3n3htQT9zyFdA==
X-Google-Smtp-Source: AGHT+IEUmCBJqt58NVIHDPHHca9PR8O5TrOG4aqKnEqH28bGTGwWCZIcGW0W6/qShoAW7F8CGp1xoA==
X-Received: by 2002:a05:6a20:9183:b0:23d:9dd0:b2ce with SMTP id adf61e73a8af0-240d2f668bfmr14194804637.44.1755490273971;
        Sun, 17 Aug 2025 21:11:13 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:11:13 -0700 (PDT)
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
Subject: [PATCH v10 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
Date: Mon, 18 Aug 2025 09:39:04 +0530
Message-ID: <20250818040920.272664-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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


