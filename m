Return-Path: <linux-acpi+bounces-15083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA7AFFD37
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F72C1C86CCD
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816F28F92F;
	Thu, 10 Jul 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="duonGAm8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A128DF41
	for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137842; cv=none; b=OWeDcR1EWVO2zNBFMcIi0LIRVUFkCQCg61UpHJ5nKE/9GUsLTeQVuDSEVxLtbIxxXfwstgoXlvI5kX+J3PPttL290zyMhU07zlKO6F8b0EasMKRnk6adiivzV8PFqjRrfHC1htgfyvf5db1mn91L1iYgyq17nj/SYSvbUcoMLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137842; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY0HtSfkPNywwvgGlmjj2CgQaxsqYKp58FvB2RVunaMmbeU2aOSqFQ5gT2NZcaA/HQFitKlkXeqw5Llh2h1/Tui07N14WcgjSoI8bkagkfG5QoHpOn/L+ZYvAH7u9AZLbLFmr9Qg87fW75WSCt9Misp9IqP2KlGFEij6sd2pYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=duonGAm8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e63d4b05so483016b3a.2
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137841; x=1752742641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=duonGAm84/r2pR4wo0OQvLIJ71obGk9mvlJkF3jIw27umvMyZyZ+7k+t8S8piLiTxk
         yjk84gAt8KNCZFMkbm1uUbPoN2Lbx+va/lwHXxKFMyvOss3wOIPSsx8k0eKLz9SCUWcf
         pL20JBnalGDh6hOM+VVqqIyl1phdytkaiX3g3ByqOLKN0L4kzeBrwYTKGu+vL/4Ao6Lt
         8L7Ms5/KOzZeHkF9JdeBsnFOLApKQgRUG9X+qCZ/5sTuB/f0wCocn+C3A8i7w9JTo03I
         mdsxRBx0oUNXGGexK6iy/jOs5uiPdwnuGK8FOansY3Miq9/N0SfmxOAC+yhPDKtWOUs3
         qsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137841; x=1752742641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=om1uonzGClQsNmkPX4pLYQtO4FJFRt5OzJ9kbgPHc4EeGGK39Ty27pkWpD2dV7pkG+
         H8OAEDNQOqpBk4JTDS9pokz7UFzH3Cux2EtZQA09pPZp/apXxGuXgQpfo0CD6Sd2BXpk
         B2l4Bca1URn+kg46kkcYJDzhUxQJt+hDMR9KFDWT/7Wy2xpMY4aZ5x8AiIlnk7QnpTaG
         cEkJjBXQpbEmoPMsYHdNpd1uSpVBWhkNeoE+MplSBMNQpW04kvk0wlHALHnVoBkyn+0+
         P1ftj/trL7kIzhn0dXCrn79RXXOofZYR8VxOcBTtEeR41AHQfGYNoLsz2a40IzypAo6P
         sfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoShv/YRz3+5MUJEb6xYqx7PCHISBRRa0eN+PAUcmKpkoA7ACT0DAePX6mTF9UrBBYOHdO/6fb2VSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZANfWU8hkA0mB90z5ts8c+IWHQwhD1V1eQvmJf3baoCRsubB
	QmpdJNC6n8neZI/OanATfZa6k8MaaSsLYvKeXc06Cz/tYBuuwrwglN3Y/rVHXQDX3RA=
X-Gm-Gg: ASbGncvwf8Ato/u6PVPQ9JI8Y9QAOLirrGFku3ArEdX/QffOn2x6SYgX9AEssVJy/67
	+A3Wjkne5UCU8hYoz78duG095ku6qZOQP151z7M+mTZrbwxaqCBPL3hABdc8viC9vaN15AqwLgj
	y4KQ0+BckTa3BxoO+O97ykFHziQuOlUSp+MHKpJHsrFOL9aPyIkRbYG4agVYiobmWJQcRr6gFW1
	tQkrJztezQn/Yn661CPHp79fD+ObHBzhU7jjX3ugy8KngGO13UCg0cOYSnckAr14Xy5nWCY+Hjj
	ylskTkmrcIGKfUsR+ea4CiNDjTiYuNNzfC3v494ZnfOvUO6cReuVFUKQ8LFhZBOQkkoG5hHSbcU
	GR+xFf7w=
X-Google-Smtp-Source: AGHT+IGTMhySvFIKwSkWciVZb8lELRF3nbSYJnKAx6xboIUomqUcgBH56UpRO0apylqo7r2SLhP6yw==
X-Received: by 2002:a05:6a21:6e4b:b0:226:c204:3c40 with SMTP id adf61e73a8af0-23003af63admr2908259637.5.1752137840711;
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Thu, 10 Jul 2025 14:26:56 +0530
Message-ID: <20250710085657.2844330-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


