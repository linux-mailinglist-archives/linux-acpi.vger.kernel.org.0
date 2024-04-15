Return-Path: <linux-acpi+bounces-5046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5709E8A58A4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843851C209D5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F912AAE2;
	Mon, 15 Apr 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hUiz36kn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83482892
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200614; cv=none; b=jCbBFg5fliqT0WFOAXYpvWwYZVeh98zNDJE2MgidKxA+lne5PIPoGCP2rGQi2uIUjcPZrC/9+ReWnlH7NKkHh2TK4OkmIFVp/acKwkjDSMfsVjTe9E+knN7pkSYNrTup+LosTUgHE4+5p2vcjZPAqMknTHPeMXe8JMln3mWFqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200614; c=relaxed/simple;
	bh=3keJ3Kuinu5AbppHGPB5DBSDarCkqrC+tWX8DaE+7S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1tg+kct8P1K9c5T3Sq/14Mo+M+x7sXhL+/D9+P3TPHlz4MjfjeM1FwtyKZmW6N9oWeazq/4EyQqsjX69eok1U+hEhNkAsOHcDgb0+I1WCkPLY6UzO+yBsIBMtz5GkTS4Hnwf2qAF8eZG4fowAdCU6tLxLTdNC9jO9eSkrkMYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hUiz36kn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso2100397b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200611; x=1713805411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiK7floMzb7J5dAtjxG557Fp/B2Bd1rBgLoGJEgu0Mc=;
        b=hUiz36knPqPpd+S1tMexzQ6TUvLG4yRv6AKpTCq8usqHXkPSMlq30Xtx0WA1uHi2di
         /0UfJhgy/vnESbpVZpjwuGkODJxTJzgVe7AMNgQJ8c7V9mKLmADQuDVBdsF7dA2KlxdG
         L+svUYkVMTGoFg5sDDnSyetUNAk38Pvi7sg9bD/4HbjSeZxVcsXnMkVdJaaJv5SssrOE
         dTQLuu6aHMULrH4dOFuB85MoXmw/LBn5/Io/4ON7g7swpBvqOdqlPrQrAhDaLq8Qrkty
         9w8fB1+//nivy2qVl5XtSIhWr7+O1Ba9TwsFFfngGf9sJmhXWnW0jmi6ci/FVH8B4kbW
         r8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200611; x=1713805411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiK7floMzb7J5dAtjxG557Fp/B2Bd1rBgLoGJEgu0Mc=;
        b=P4pC+Z1YZF3qkwaphJACW4fv7n3MOQJ5rZf6K38F4ovOvh0OVZste3B9lb4iaApCAN
         MIOfzRt8YQ3cQKOAnJSYs8jjrxr35EPaOU4/WAJPJqSLUY10aCckrl08NHHcHYCWQ4ap
         EDpIbB5zhAvY+mEYPL/5FpJMoBG0SxDV6ix+rkiyYUnAfsxUjlqY0l1JrWP1wfn1d7/L
         n9hMVK6LcacOEywMCYkhKDcZnMnWv8HCtQntZzRFdtDTH/6Ccd9z3mtPNRI2hkZZkCsK
         O8N4CZftOBmAgoWZYR8dhksD/VxFP1znZav+Q3Hc11CkctAjRiP24THieZ7aWPfynz8A
         Wj9A==
X-Forwarded-Encrypted: i=1; AJvYcCUjmBhyfepMdsaQ8IoP/bTSvc/G0QCwuGw+wdBtCPc3xDX7QPgQH3liwN9u4CDuqQH6wJI9FYe7L0WaKEdcM8tE+y5lXNTK64BPbQ==
X-Gm-Message-State: AOJu0YyI+zHJAbc3zNMZ33jR/2pLxf6TPTYQyhtTbsTs3OqbcfcLjRZR
	t5Fij+9nud4wv8MtNmli3mpizq5K3c1d2yy/9d21hmm5CKRNFY290YoFsEzjrj0=
X-Google-Smtp-Source: AGHT+IFd9+zDBggMUEnYbs4X0hsHQYh+Hj4Aej+R4rn7fzXqChszrhGpkzejjAS1RwVrkPfA71InHg==
X-Received: by 2002:a05:6a21:3182:b0:1a9:da1f:1679 with SMTP id za2-20020a056a21318200b001a9da1f1679mr4846522pzb.34.1713200610709;
        Mon, 15 Apr 2024 10:03:30 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:30 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 19/20] irqchip: riscv-intc: Set ACPI irqmodel
Date: Mon, 15 Apr 2024 22:31:12 +0530
Message-Id: <20240415170113.662318-20-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INTC being the root interrupt controller, set the ACPI irqmodel with
callback function to get the GSI domain id.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b20272151aed..af7a2f78f0ee 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -326,6 +326,10 @@ int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
 	return 0;
 }
 
+static struct fwnode_handle *ext_entc_get_gsi_domain_id(u32 gsi)
+{
+	return riscv_acpi_get_gsi_domain_id(gsi);
+}
 
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
@@ -366,6 +370,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return rc;
 	}
 
+	acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, ext_entc_get_gsi_domain_id);
 	return 0;
 }
 
-- 
2.40.1


