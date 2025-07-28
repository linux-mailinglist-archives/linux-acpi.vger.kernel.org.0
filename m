Return-Path: <linux-acpi+bounces-15372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA8B137D9
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D317B5CB
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264272550CD;
	Mon, 28 Jul 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E6Y5UYCz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF3253957
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695749; cv=none; b=Qjtnz9assf00MvrNFgQtFaMSSXxF388H9qHV79275o+sqlgSON29MMsTwM0E+1fXcjfsHQeYW5e+/5+QuylL41Bns12wR+myWJE4OPtQ9jTCbpVvBQSMjpxgrLQnri1kHu3rfoUDTwHxY7YZj9dPgP4nq4DRq3g20crGA3fdbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695749; c=relaxed/simple;
	bh=gqZpMXPd6DL/+kfXUibwUL8SSmPMehps7IgssTY7RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlZZu1slyM1dPwv7i5QgjJBVxmKkrKJ5BWyTTsGl3ohZQ+8BrYmSkwLXYeEhJT+G38RS9m/7aWX/iKXR7G52nPg9jf0oyBhjPAl4DOZFC2ma6gcqrDLaL9maDY1pd0PpkTRFvDxh+mnfjS3yYssS0CYm8WHfZ6lGPclJorLhmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=E6Y5UYCz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3058064a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695747; x=1754300547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=E6Y5UYCzp5TdNTw9k5ohUabkOSgaOQGqHbabmoP9W8SOJCwO3tlKfVR1SBT0DKepYc
         j/yts+CxP4oShUgoaeKNNWWnmc5IXx9u/5ie0hTRQEfj2OuCrx/nqrTZhk2oDpBb7I+F
         r+PEd/I12YiaIizmK8PsWW+Hr+wO88Xu9dC+nw0dHauiuQVpa9mkRdM+D/OEiDUGCDYD
         mIooCLQUSrZhhh6pIJKf/ysMBx2f+rt7BHoN80SQy1v+rY9WMO6ip6A1O6DCI7Bl5wma
         1l3n/vijVx5sSPXMWE6+xXku4d+WXCvWA3VnW15ulJO3G3NDTOKLepHzlMMC9z3sWaMM
         x5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695747; x=1754300547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMRC5c9xXUgo6eKv4jcoCHH6TENqo9cqAPQxW1Kbofo=;
        b=teJ8bbCgDAHcVNLw7uCnaO6HkE2xvrXhRbOHK2zYmf98OBRLq6F+POujWkJJg2keQN
         86Wcq4W2D63BFi7swOivtQhKpQLgM1r0NsEkrz1E5pZlppXsiJSjUgCrBIsruA7J2oyT
         ouq/wPGEQ6Ut1oZAfs/0l6H16ldQ9PYCQa40FcgagyYuMDuc2QJrXvaRB+tG7iA6oiGT
         cp4iuabb211ZNLf3Msgg2KSMgNcEzh7KrKpOUPyPNKf/6UBjkE4WQRUChJlmt+a8ieKG
         4X4CavDZS9j2xSvcUqCCpL5BV//j30Bw90n6gVAVkAy3eOtfw4T+187mGyDmn7QIZSW9
         Jflw==
X-Forwarded-Encrypted: i=1; AJvYcCUCVbienLK2xDjkWd/ckCkEbIcHbyN82a4ECR+c/iMfyG9zLPbHgHG/p/gcKM0fbwZBjyKS2jbtn71d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BwyHq1eGK2tI8LQrd3/yVxMOpQU6iJ/r/FM0zF7hmLvTBGRf
	Vdw1onAER4OUwLNi4QExuCrm3W+JKGOJZLe6f24EmQzwPJcgX9x67I5IgNNX8tjqq64=
X-Gm-Gg: ASbGncsl/Z9QDj/Bv4yTXinZicnZwo6Oy37jqJwO9CcPgrQfEEv3g7ZHg8GDo6/BMk5
	EffJY2WeSl3bX/R2UMODWO8HyEia0H5aj6pAWimqrzVzImBu4dy/divRYiXM7n9byGGxWf1ljAd
	K+LevpiNIGOHbMVUITrNwBnxe2+h80nnQ0ydw/Tgz/LzCP8EgYShn8JTzsZoG5ocJuptc+xCktT
	ybGiZMAx+pnkf2eVHs4fBehqygNEf0olcP/ape+8gPVHmS+JIC+NikglowSTMPs0JHzzqjTRo6X
	l97kFmqUWTP0mNQih+GOpQkDdCqAt9TaV/60mNeRMP2o44/4zLcbIqtcor6H78bDRNTm24jtVcZ
	r1Ksf1yV0WdP941Jbc78LVk8fkybftrlFyGTYHI1YduWotzyDN/8vXK9r7Wfv
X-Google-Smtp-Source: AGHT+IET1sWMZD/6AnfrHKkMC7OglTaiVF3qSrY2in0HUadzd58C0Shm9ghMuxb6ibvRVRWuWVfN2w==
X-Received: by 2002:a17:90a:d2c3:b0:31e:d643:6cb9 with SMTP id 98e67ed59e1d1-31ed6436e56mr3137835a91.1.1753695746628;
        Mon, 28 Jul 2025 02:42:26 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:26 -0700 (PDT)
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
Subject: [PATCH v9 09/24] dt-bindings: clock: Add RPMI clock service controller bindings
Date: Mon, 28 Jul 2025 15:10:17 +0530
Message-ID: <20250728094032.63545-10-apatel@ventanamicro.com>
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


