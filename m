Return-Path: <linux-acpi+bounces-14894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09577AF0A3F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A596D7A3E96
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E051F8908;
	Wed,  2 Jul 2025 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dHQZ3EnM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A661F4281
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433264; cv=none; b=fWZDtD8/amonPqIErxHZ7LgxUpNViJL5oHbutrW+IYGeo0yXPXXmLRHCy284Ko+GLopIW7SzVIoWPoxsBfBFTOUavowcqCGF5mO9Hqm+6vzclIpYlJ0VO+7lZoHmFOQldtCWQ8LawjmRiR8lnqB+VVXU97M4du/61sTJVnY8rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433264; c=relaxed/simple;
	bh=wpGteD02sLvwEnKA7TBa2+SX4iYwOSU082ERtl6/Vjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK0jDssltPFtXX3C7s0J75QDSeTWC/FxEZqjlX60E58JLStAZMJZSS7XxQyLft5yDaRimEVeUYfe4GoNXOV8Lu2ifRLYtzy3GB5q7E+kOeegxiF7XoDW4sZsgCmd8xlAF4j19gtSVlrgsA3cmeU61ye3EFALdBo3/MwUJtwYIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dHQZ3EnM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235d6de331fso51539775ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433262; x=1752038062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=dHQZ3EnMGfJHsTfcH8UnP1mMvdJmezlR7gQfYTJShx9qFPtZKDvUy/sxQPNyTWDkhp
         xpAKFbrgESKJ/Z6YtnlvKIrWLVn5Aw8hXX58mszoyIhmad1tpJAVPuiKL5vlgIMTbEMR
         4FmxbXLmRRSDGHktMF7GT16OltAbyxdiOSJq9zVpRIn8Eo3iaTj9oF5K2wlcVfT2kQF3
         yApim1ixps4ywvuMqpOp6Cz+xW1RxeAFAtdXc+B3we7kWxCv2DcT0Sx0XxFlr3xoYv+h
         zofLffD+SLP86Plj1zTWwnMxKa2OPRteXWtVXQpYSVlYBusJG+A76MaOT6WsFDvUbRuL
         lWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433262; x=1752038062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGFMyHcY75Un2ey32rj/OGQJrYLrfBUEB3tHZxTx41w=;
        b=TWYqv3vECudv/KQOLs1U63apS7QdMdissb/TkwOioyiM0Q/IOvHZycAifgeb+nDlrf
         YxeI4dgn5OIQQz3chQZ+/WQajx/N4mwy6qsiZnf8xTfGDGxfo3XZc8btwWZJk/ADzic0
         wXnWd6gQgWRlgfaOqfbQiSr164WEiiOG43bJLjP0BS+VkO/wQBvyKtd0PYA1245V2TK8
         5G88parrOIRm+i/CY7pw82DkS+JjQI0Fa9Z21YA9UpaRE6YTgrasCkmSHEv6r4mgglZ2
         2j31WS0rTcidbwopf6k5PfnfbbHAB2U7zj5h12r3mTRWwnDbudoKh7im/v2LQJMeAp0/
         JdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeysB4aOsCSZ/YSkSPqT3kLlBf8JZJc/eL3rQH5r4LAREJq6XVmcdNJVEdE/oyM+AGfFX1irD99h4I@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPKo+12SLXQ+7bGlfBCsdeqkR3c0/aPq95YpPBZWto6TYeqCg
	UpV343yVf+OffzkStyT03dpwSQfJDUpiOGuer1hmtD+eU/cK9pZ3J3zcsVbj0/uFrOI=
X-Gm-Gg: ASbGncurHM/gEdew5N9+feE0ij4c4tS6M7TuKw+QpSOqAgx/maDg665E/2Xwrvh/XWF
	UoRGiXMjLElr+b9Odzk+DEg4W4kYoqWaNHNm1N3d+GvljVAClvMX5Wg5SQSJZMyLHXMOfjCuHgm
	JDhq/inr7+KVsfm+6Tg2/80+V2vCV/B1rI5sb61RbrM2D+uflgqGjr33eGwUUy2UQxNS+cd4Z6e
	+z2d56IdBVL/55hosvpxppsy54nvn7f+C7p1Y0bZ9Bu5Bk0mMtgj6NmXGOsHE+Q4wWFMYDWhH5f
	JMIX8E0cuwQ8Ae4KksANu60HnltbgNrSwzea3ApPu8g2chJdXWT88vSYC72cD1wBQHrziN1Mx6P
	monoEfLEbc0e+PFc8
X-Google-Smtp-Source: AGHT+IFyaNYbGu3J51YigXq7SSnInqGclIg3bY+r/3Kl6d4xMMAbKmX0D6qCx0IXUy6MpajxqM48mw==
X-Received: by 2002:a17:902:e852:b0:234:df51:d16c with SMTP id d9443c01a7336-23c6e5826camr22426015ad.45.1751433261848;
        Tue, 01 Jul 2025 22:14:21 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:14:21 -0700 (PDT)
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
Subject: [PATCH v7 02/24] dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
Date: Wed,  2 Jul 2025 10:43:23 +0530
Message-ID: <20250702051345.1460497-3-apatel@ventanamicro.com>
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


