Return-Path: <linux-acpi+bounces-14916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF10AF0A9D
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254177AAA63
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6242236E1;
	Wed,  2 Jul 2025 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CUCd63pG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016F2222BF
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433430; cv=none; b=jVvtVVckeIqUkLFYSHDOuF+EDj5iLXOcC+L6QUdRTc3c7RlEieF+x+btkSUDw9FrReEnNdnv4+f2B1b7nAfHDwn/vTS+cWQbh11zki/r50RZqsL0Ck1cw1AT6DaFS7RuCdVKC1n11KrmZsAqs3DRmrGT+uJlZrUJQOSedxBy43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433430; c=relaxed/simple;
	bh=SIZVTA1dBlDgHWuqKkMeHUlssl6BYErjNhZuMkc2v6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRWxRUl/mJ19c47ol1g7XCXRdh4q4hYk35tqZXK9E/tgCdTS2GfdJKVwgHmSDvpNFo+epsj+34BX+EwgJVhOt05BVZqKe6Qo00OEPCoekyTHzO7JHk2JZEr4yGD6T3kncOd5bpG0AlgLhap9s2WdmAhqWBEpxeYi3duy9ehkrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CUCd63pG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so39449865ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433428; x=1752038228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t84+O6WBdBY0SCc3BtWc+Gw5ZYyMJomoxrVu9jQtsgg=;
        b=CUCd63pGeGu4fUzMEvMVeiJTYiKkqwGwjNi21xlBefLtX/hUB1ogxNyQDNZrl/P1iN
         feJFYgm2b18q4Oirn5PGBEtFyvn8x70pW1I/3mFb7UdRn4q6TSlB2blJ4sChn8XmSCwQ
         s9rfXaikuXMpNZC6KVi7uZd7oO7glF9aCF2bZSSN9WdahH3lF5mQcDtLFoueSnSu/kJy
         N1t3yG3FX4dQQGGY49xs4MfXUexnM3TNJ8Ii88lno/lERrej6ydoNqAAhs1FJQ7pGOFs
         iZWFGRlI5ugSEG9Zsb3a7mzq/ytyNK2FTow2ak7ocZnGoWxWw67Ag6VCrpW/4gcrz6m4
         vvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433428; x=1752038228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t84+O6WBdBY0SCc3BtWc+Gw5ZYyMJomoxrVu9jQtsgg=;
        b=qbMK1MeXNlSOxk9VujL1VFTrgu+SfgtzgEQaHiw3IGKkbiwAhK2yfb+NDsSLaROpaK
         qyI9k4KuGJDX31pQYr/JlpydW6DauqrnvxxdHBPwZrC39hE3Vs74Zs3Jb6MFqeZslGFl
         KJcNcX2pLPese2eCdOL/wfWpU5UjyyFfCTA4ozrcVl9ipFXP4rnc6VyjnOurulOFmPaU
         YOYLAV8aFGFRRpYS1VfC/3yvdq4YnIRz6M+CKvhsSosu0WvTs1jTQUH8jCl5nsmMdZsJ
         0b45uBrQUtdt4+CkWxaQiOqbcI4YtnUURBluqVuumKUDEN20rSN9W9WAF1Y4AlwY0s57
         PEEg==
X-Forwarded-Encrypted: i=1; AJvYcCUrJ+3J6oV8nzxGIybWEOMXyc5zQYqHlWK9U2CQfh46IAHG5PW4L4FbTLDomhhZXc/1HUBlDKVe8NCj@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbOh1kMMHPn6kKbtoIZBfF49knKLw09ZLaZnzIi5ZhLZNOzVh
	nOWULQ53G+9oYcfndlwYn1K7uu+76V0EOwOyT/w12yqPKPerR1RbYGqiOV5EP3rwXWpqHDfG2lk
	C8uFl
X-Gm-Gg: ASbGnct4rlD0KD9cc7bUzxB+rInK1xYWAFF93U/a89JxkjBS8iwTt4euySQdeP2FYCy
	8Suc7KYfHoCO0Y1EkS+GY6GwXX6uW4wPyqpircJDXKkfwau23fkQFrYiPZJpwjNalOpXOSWvvA2
	9DqdqObXVEGVoIql+wCDvbje260sTJtfCH8fHRyVwqu1s4oH6gXC+SR5pRURlUjaoy8I0MfI5vl
	nVk0BCUpTRl81wa2Yy0BzwJ9+1dx1fSD6CpTQ+uZ1FstYFZ6302vEuF+fZi0n2rLTK7sMK8lZHu
	26W6tknnN6LVb3jX5okLG4KYXwM6xhe1KkAKjRHphxJU9q238TLxumryOhDJi2yQrm1r8jE5OxV
	Ji8RO+ge/fEd5QdhN
X-Google-Smtp-Source: AGHT+IHF9jCGgWd1zPtdr7P6gyUcMpmB+BURtwnVFT7vtNKBR1DlMS0ym17Nq8ulkiJ1AGOTzoV1rA==
X-Received: by 2002:a17:902:cf4f:b0:235:27b6:a897 with SMTP id d9443c01a7336-23c6e552a2bmr15106685ad.34.1751433427932;
        Tue, 01 Jul 2025 22:17:07 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:17:07 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 24/24] MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
Date: Wed,  2 Jul 2025 10:43:45 +0530
Message-ID: <20250702051345.1460497-25-apatel@ventanamicro.com>
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

Add Rahul and myself as maintainers for RISC-V RPMI and MPXY drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bac4ea21b64..c22434a2756b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21397,6 +21397,21 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V RPMI AND MPXY DRIVERS
+M:	Rahul Pathak <rahul@summations.net>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
+F:	drivers/clk/clk-rpmi.c
+F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
+F:	include/linux/mailbox/riscv-rpmi-message.h
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@gentoo.org>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0


