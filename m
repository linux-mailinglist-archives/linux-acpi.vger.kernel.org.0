Return-Path: <linux-acpi+bounces-15007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E483AF88C6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CF81C21AE1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA66279DAA;
	Fri,  4 Jul 2025 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RK6i798o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE18274B22
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612855; cv=none; b=Ki+BpL/pMRa/VXDkF0uavxKgB8bEzTkLoUnqeSrMkiKHLHamSFEUlS5mwD7HjySyCuu0W30pXYiNpYA8YykvqVRFfeoYeC1dxnBOGBpaxR+pkh8iQSx/4odDYMZzubdJU+/KYpDaWS4cGaKPDZrD1/+SOrraadUbusVvKQnkKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612855; c=relaxed/simple;
	bh=uLkW3DQcKIIgVHib4AKQIVSEPy4uT4MPjoilFNj5tRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1dXNp7R6dtcogjaPvg5FKfeMohl+dbMMy3gqGLSo1j97ZqVl+5rDiBdmyD7PZu5Lek77ppfQ2DXdEFKVQJr5zT+25alOVw0c7kzBLTvEIrVhOU+gbL+DIelxXwZHA2nHrlz8IM1AXbzvg2WpT6fIN0ZvyHknvKMAFYwVEpSRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RK6i798o; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so391650a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612853; x=1752217653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=RK6i798oHw38np0BJcviII1esSH97BpY0O50SqJ+OZ1GawlTa3WR3pHqgsQMa6pkEh
         8198kOCp/kdwVgAztz43Zn2vRPXVNEbUcv9TwlYharKOpR0zTP+d7K2xtJ/Uz54j4znx
         P8DSXpMV3usj0Wr29+NMXm8EWzIXsTX37V5YUQ2cILMXu6EQRk+voQb77D6VjeJ5Yt6I
         ZRPhXoOpQiypZ6SwEzeKctrZRHFfqbinRVQOFDLoB+h6ASlHT6/71CkwdnGiBwNM/XWC
         A3rGbmnij4m8gUX4xkabQO2lYSI6CsFbhaDjpaXdKoTMn44G3FmDUUm/O4iIm9cpizk0
         txGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612853; x=1752217653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=rnnOZd1I41pIIjzNoNl0p9W8kuCiLK7PaXJZx9oD1nHo3luWHI3Tj5TTr3k7waDr8W
         0nsPWMPlVfgcPuoIR+u5KRgUvtpx7DIcd/WnydgUdP8rum0z+ACjiAKpFF7PNCF1Qx9X
         q47n5q5H5a+gL9ynQV7+LwpHm71klw4+02dh+WOZPiIbdSuxWyS8rsjwAsWTK4xcsRJ+
         t2EZAPD27N6u7G6iYALPdgnWlm7fxmffq0RDFQpXm8pRzlWZpA9G+9aq1k306M+Qjs3g
         CZ/PEm3TeFBL1cQzFuLWATgUajPLEToCsfAGAJSHDQpfeg186grb2nCVIg9QIenHWuQB
         6sxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnUJXTzsbPdW2OwurOh9HNG8Q8jO0b6MS62l0pcyVnQ1Tt+xVH3Q98zzeQbk4gb3gnVd0AYxhY3eFm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/fRoOjmE4bRYSobFzk+bxOOi8vi4FwXSm/pXlkTSGXCGv5pg
	U8qg4rSSa1H7Qfvj3W0rEBYccJ/JEmA1Ki/6ohOQI2qrxgpaVFvF2437oZ1Fltv2S8s=
X-Gm-Gg: ASbGnctIbyf3JQmwCcai9/d+7GOxba/8VZ3hF9P+4xQ2BafEKPnYGPZlOBfgC8NY/qF
	ufTpVM3WPcvVY0BI8KCt1ZBBtC72YAGG1YwgJaHe/2fkTkvN8XQqfSJ5ABSRbeNtJwE7IVx30to
	5G9Uds+i4XNo5erscOrNgpimkEJhQjqw1ZHExW3zqU6FDTY8TtGULbXXYyqMsh3T6Xkqp3XpFup
	Rm9tITjm9b3l9kPbAxUNNdP7MrUhrrWRXdoBTps3dB14PIZcYjr6XKAKMyJnb4E291A90LRMFol
	TwbRvhCtTvy2AGQzTOOkBT+r5yYmWTSRT2SGygfH4PszAYZB3dtCCNQ/WD8Otlm67kHBINBBJRc
	lpt3rqo1tnnB632J+MN8fQSySIA==
X-Google-Smtp-Source: AGHT+IH8K2q+ff9EmJzgqGezoG5ijxAfT3GRB5m50yeRgyCl4S8KgAneBei7J20U/ic7bxWUp8DQog==
X-Received: by 2002:a17:90b:2d92:b0:312:e744:5b76 with SMTP id 98e67ed59e1d1-31aac545a19mr2734380a91.33.1751612852693;
        Fri, 04 Jul 2025 00:07:32 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:07:32 -0700 (PDT)
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
Subject: [PATCH v8 17/24] ACPI: RISC-V: Create interrupt controller list in sorted order
Date: Fri,  4 Jul 2025 12:33:49 +0530
Message-ID: <20250704070356.1683992-18-apatel@ventanamicro.com>
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

From: Sunil V L <sunilvl@ventanamicro.com>

Currently, the interrupt controller list is created without any order.
Create the list sorted with the GSI base of the interrupt controllers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index cced960c2aef..33c073e2e71d 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -115,7 +115,7 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
 static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
 					       u32 id, u32 type)
 {
-	struct riscv_ext_intc_list *ext_intc_element;
+	struct riscv_ext_intc_list *ext_intc_element, *node;
 
 	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
 	if (!ext_intc_element)
@@ -125,7 +125,12 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 	ext_intc_element->nr_irqs = nr_irqs;
 	ext_intc_element->nr_idcs = nr_idcs;
 	ext_intc_element->id = id;
-	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+	list_for_each_entry(node, &ext_intc_list, list) {
+		if (node->gsi_base < ext_intc_element->gsi_base)
+			break;
+	}
+
+	list_add_tail(&ext_intc_element->list, &node->list);
 	return 0;
 }
 
-- 
2.43.0


