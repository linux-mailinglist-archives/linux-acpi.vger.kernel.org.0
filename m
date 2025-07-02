Return-Path: <linux-acpi+bounces-14909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB1AF0A91
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F802486CD4
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED27239E73;
	Wed,  2 Jul 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mLshOdYw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE12397AA
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433377; cv=none; b=itGedES1/6SCud4mnexUk9tv3hEIk+ln6AYL+3z130kG1e7qO5/x1QZOPeF3gUjG8QAYWaCO7smimpUQbf9kN63bE2Y3yaQfZqb4mHluiMzSCx8HcEaX5Eeiai3TerEfBRdgq36RPbmw78wBqacyHhR9D7XwlWq+HMuv74+x3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433377; c=relaxed/simple;
	bh=uLkW3DQcKIIgVHib4AKQIVSEPy4uT4MPjoilFNj5tRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0TsLRKNMlFSuMs2Zadr7zg+5Zwesm0nepCdTVhWaaL8u9dMrJwroz6wdfs3OjSKGhKb7FrPdHmQKq6QYo5IMpa8cC3aVxwCAw8A2iQ11p7IV2fNbjYFs6/zezxFC4TFaJzfoQTp5RMR4HVg58E6REkknHgHwlZRqdRJd78tWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mLshOdYw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b9dfb842so36876165ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433376; x=1752038176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=mLshOdYwRso9NYdA2xWmc5BHkiXVkNhdQRS7fkM+oi3HN9lYqr2zu+SU7N3RFUXsv7
         6ixs635lpXrjRzRqmEGLVFAvMZYxRbbj9BnsG4/G52+rBkAwMedcv0iYG/S8r4uw3BGp
         OUaaVq7kS01vqrJJfNWDVrkhOV2F2ciyegq6PCPnDI8PbZS6aEYt3Ut5rNJ52eHvhi1/
         Ia0j1DWBdlf+DBMsGVNyK0YGqBBmyMnrf51ZfVLtHmEMP225zyJRRLxmuy0xAPn3OAu+
         xnLRVfArzUqmBP/G88cgclovYfLVBPVixhnrcpYvPXeClFjaiHKS6ZFp/YfqDN08lr3U
         JfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433376; x=1752038176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=euOhimeavd8SrciigC9YUp/8su3xSyFkLK+Vv74nZDZhYA2gImGG+HJ7M2q8U8SKv2
         OOwKW8ZyPq+xNaD/Agy+y6fMQEF0eWRzvTLM72JQ5iv82306dALX+080wKgT1EL5c4Z9
         r3CEGijvwkHlTLw6BAi86J0xUb7PbmuLV+0Ockh8wVwM7Y7wFLcfdmgwWrot9IBcHDPP
         V950mzkZXBo8gV9YBnRJDYU2ONyIoPMJ8vpuctlaW1LWkyvSIDn0usESAZU4dYE/fkfe
         UD4l3hhUpI41F5tqBYGu5bQwYHqJwzS7+qEVlglBqxJGj3qwpaNXZP67Zn2ypp/TnXj5
         jYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXlBpUUHQLgoRjXYnZoIjVH4R/zBIhw95vOuYHKiWEZh0jLwktSa5t2/meje9vWUMck/x9RCi/SchPS@vger.kernel.org
X-Gm-Message-State: AOJu0YwooPexqQ9pXSj1x4bmmoiP9vM8hLks+bV0tKwoCXxAeip1oU8s
	lc8dWJnZWMTAV79WPlwve0hAtW6yZKF6bM5Ad1szzk3KWnfHfUFyIikx+3Vg5T2fkE8=
X-Gm-Gg: ASbGnctyygAYFVHqExsklbc1u8NO3DDy3/qIf9930cuHQWjPQfoA5B6qsgMRIw0gwLW
	9JUhoPEms1Y0R97+bygHEYrXQdlvXXr6z43HDOKHpZMNBYc58KIxYtN/myA/qusAld+oHXKogKy
	LVrVzDWxCW7njI3iYbqL6K4/WxsUy0ORP3nvyvB9fn+LzEnjcA+V7kDUc8qMqXT5Ae14qjcoHYt
	QUbHrE3ME9RgehzqZlZnOMNt6qYFwcQzP5ky4Qv8dpil1btr9V47mZz4GVqiEIuRDLMnRhzYdBm
	AXwKridr75z6kpMTPmLVD/l+kqLoUCnruV28OouZj08uvUP1gjg9srBtdIJNTnx7xyX3NUJz146
	PxQQ3nwvihpVxzr20
X-Google-Smtp-Source: AGHT+IHK7JJshpTCYWIRPYhBfujfdQF43fCmzueM9e8EwtFQkDR9S8tXHvcjhHdLfuN/8WzEAqudfQ==
X-Received: by 2002:a17:903:948:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-23c6e4d3578mr24923105ad.5.1751433375731;
        Tue, 01 Jul 2025 22:16:15 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:15 -0700 (PDT)
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
Subject: [PATCH v7 17/24] ACPI: RISC-V: Create interrupt controller list in sorted order
Date: Wed,  2 Jul 2025 10:43:38 +0530
Message-ID: <20250702051345.1460497-18-apatel@ventanamicro.com>
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


