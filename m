Return-Path: <linux-acpi+bounces-15783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99676B2980F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE431747C4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65A26FA58;
	Mon, 18 Aug 2025 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bjUvMBLU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8A269CE6
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490404; cv=none; b=HVZt5le2bz27NgHHb+U2huOog9Z2JiOzj7GmKR0Rc4BVAHLu4WVF6uqK53zrHQPZA61ImWvDgSQrvkJDWCBRM2vYtXiJNqTubA5Sl5GZ3qUSfK2d+abUahuDQ0sgdSGavM5lWf3Jy+83DfZGAGQB28WfhDZN5gwfindbmXZRxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490404; c=relaxed/simple;
	bh=t7NZai6cVoSZUb1jEl1jkTYbe9sRSs4UCr60ihc6DlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEkzDBHMLZ2Ev3JOP4yos5zdVhn7Y4+F4u8Dm1ph7TeGfmEQiNLV9OXPcXtw/S9wJiIUFcsPYkR2O8HXL5lmWfZQHEfD6fasqsxAo2ksCauZpX8khV/vOxBx2po+EbXpYhtN1ar0fbVWrku/NKknOpeKMFRvb2Eo2mnvUiIRg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bjUvMBLU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so3704349a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490402; x=1756095202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PujbwOz9dknJBj0WiTvzomVt33H+ylTg1a04PuImAic=;
        b=bjUvMBLUiMSGcvfX3ukFcf279nI6DcxdY5uzQWWkWPcszcRg9guWb2w0Fzv0HUT74F
         qdTp7rya3Jbmi6MmQNU2oG5yR6m1JvRZKYO/QMXwJV4NKHH1/poTNP3D3eyScFdtpcaz
         7QB4b6BeIjv0FomZFtY/B3k8defAy8RnlG4G5W1Lam0lCPTDDyGxIMS4xlUwjTAh/wwB
         8wELw+xaoD5XDjR01eBVTcTmqC4aLxVIMf7pemAs7ZLlly1F+PxdWG1jhF6U3uNct8SU
         S9+1Je61v3AIK3YWmt0hSsqnfenbFekkgLMEi5ASYxvJOgIfugNhEBxypT2pUaVMUatv
         WlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490402; x=1756095202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PujbwOz9dknJBj0WiTvzomVt33H+ylTg1a04PuImAic=;
        b=lunYuXDG9Hc+anEZvzXBGeHqvNMPpnv5sa9w9V28bbzmj5VgasD5iC2XLOQ6NFZ2ir
         ZV8fJwKwApj4LP5OzBuAAB6+wHReyjJUCj4CbsiEiGi+1CYlBc3bjgaXshcni0i/Vo46
         gYwQZGfPc/g6VECe5mRYL0b8g798acXjAM+2cACY+byXi8ak0TVTftN721vtGAZrnIa6
         tZfPtH7+FZWSOsgCGl33kW76miTwcxYof6JDqHbinq69fSfo9GTB89A/d0wqzilhZZNx
         i3UBnA/CmbTbFv4HqRcH0TimQA5Kh5vTFjdOOSsDsVpeCCzuYPxQcporvnXvldgXMqqB
         HFCg==
X-Forwarded-Encrypted: i=1; AJvYcCXJvWrG+P3wBelr65xmCXTqxbZVgScA7ZkTwawMEbwPTgL406UBDEJarA3BZNqkL2uxGTFSObTi5kWh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UEuZHRHKktUz/5hqppyDEbsIWWHk47SXNAOfy+b2IZfxje7c
	j92QS6f77faSkOvUoVCi/ekO0X5t/gjy4ejZffxnLJDULThfE95bdvcxvSdffJywkM4=
X-Gm-Gg: ASbGncvW/7BwA9GB/5nwsWRR9F246QU9Gls7GTFUw8r38as/lT6YpShM4XASA0VOwj4
	wFhcyvnoz02IHKZkQxMQ+oyErtOe+zup+7LB5eXdu6Pd8akFBDw4fCxZGp1Y3BMpVevmuyJj0i3
	CmDAndbuhNiMm13uXCeWrBJW8krgf1HH57yX5UBVDE0ml1lwQQ+DcXRL/R6W6PrSC4vWY83FVK6
	gfJM08ZyFWaZAz1RbiVhvOrG+1WGgwh+RCI95VwIYMprYbgh6FgLtu+Hi9x1QWhX3utIaHR0eQj
	abR+m2V3vctsOGQBdRl+wz1DCnwCluaI11DmGTebBJ455mHVacdvV2RZG1xUpfCmN2xELW/LUyx
	pKBd2rA7Nfo7S3vvT/tgD4SJLCMTNMLV6UU+fuvahhuFg+1cD3R6JDA==
X-Google-Smtp-Source: AGHT+IHd64OLVzgyUo/oPlpqgL2RhIpctnfrLzAnLHSZJO6tBzpwKW59cA8/JZnKdWHEIOpAgVUkNw==
X-Received: by 2002:a17:90b:2681:b0:321:c9cf:deaa with SMTP id 98e67ed59e1d1-323297bdeb6mr20158792a91.17.1755490402208;
        Sun, 17 Aug 2025 21:13:22 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:13:21 -0700 (PDT)
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
Subject: [PATCH v10 24/24] MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
Date: Mon, 18 Aug 2025 09:39:20 +0530
Message-ID: <20250818040920.272664-25-apatel@ventanamicro.com>
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

Add Rahul and myself as maintainers for RISC-V RPMI and MPXY drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..c675625504de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21698,6 +21698,21 @@ F:	drivers/perf/riscv_pmu.c
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


