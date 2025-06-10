Return-Path: <linux-acpi+bounces-14259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB74AD3402
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8C51896786
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641F28D8CA;
	Tue, 10 Jun 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CDEvh3u9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D3284B33
	for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552424; cv=none; b=gVpPuU96Wx226WSNlh4H+jt7Wes8gJFpshctQGFWTc9tT3Iaoeu8EqT//ZfWlbYju84YGnMqfxk76KJ9Nk1CN2mBsUizLOrTzWxhFb8XT1RrvwS9RzQ+DDAPp8jI/YXaBzV2JwM2YKEhqjm1cDegG9IJJ1QXdo48TLEqPhuPS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552424; c=relaxed/simple;
	bh=h73ucvaKC7tusoZ366WFdpRJo5bbH+f6qpcdSe3pUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrF+KZ2Vuvyp9o/4OG+o4yisKR8B0pTbMhKHPyb+YIYduoOTcY9CTTU8s7+xy1zd3ClLT41UH0eJN/s7wi6IMSE5X2zLKRbQ/dHK6vNIlO9FKe1doIalHmCRrBTz92TKTn/xlOe9zRZttY9W9B0DexBEq2vdI+vfFJmitl6KO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CDEvh3u9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3961190b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552422; x=1750157222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOPKLQETC23awiI7CT9ZOjIxOZ+G4ZqvM0do3bqdxho=;
        b=CDEvh3u9CedjMhCO1N5s+MLcrQ09c8rpZxd9Gk43i32PSsQ+Ja6F3UqxMVQIPNAQol
         TkEtoMvs4nBTmOJupoMLyJBv+dfbmDuHZmemfajDr5TY6cbmmwF12SwzeRDmksaGDsvw
         ffCzywMcOC2njLYdREXdk8ZwYm6Ldd5Gocbx2fN8ztuBKrelHE+xbdWQoyuUbIEolpWD
         QLZJAdD3wLZyKPKeGGdRP2u7N6gYx42W3UEqQDe+pdfnWDOKJgOvBpTV+z1G4kNkPH4k
         ZMJYBC5NpNuIvkOXNitPLUMblLUH3CCmzu11bRSOTdIf5shw/yjpLquYZkqnobkeWrdH
         MnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552422; x=1750157222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOPKLQETC23awiI7CT9ZOjIxOZ+G4ZqvM0do3bqdxho=;
        b=Syw9mxafgI9VQZCszxrF4ayaOCR4xhDN4NEvRih3wHQkUGtP6gEz9RmsLiIP3Ypa9A
         T3+Wo7V+Lfkj8ZaDh2d0Q74WYVfuYI/xXApiELukrn8T2G2/R3dY7h8zAVTt1f69C4UY
         GljAELcq6ILnYKpJgaQyVOo38cTKLJTf/Iz2CoNPjB7FE3YIKsXCnoRIkk7uoE9x+AuM
         1zCXKgXA3cuCxx2bkm2T3f7CM4zgLnZKkwg2HFO3DVL1XRo/4rmLN2R8T4qZBpkm/s9Z
         d9i4Ka4+0eIktDaLTnE6sHV0ZuBau+XDKiuf8bg3PPYLuWrkywK8rqUNFBFXkT8tNiAf
         OX6g==
X-Forwarded-Encrypted: i=1; AJvYcCV4jbD16k7tqiNYukqw3Yhr35TpMwCcEYk6qK0lt1cv8yBRUfp1hKmFrSsYIoqUwK3OknlX2WJC4HLa@vger.kernel.org
X-Gm-Message-State: AOJu0YwngLr5yfOlxsz8UrInXFcUFRVNuJ6O5iB8MUEGV9k0LwCbmfkJ
	mclm6MhgEQktiUxMTfEynyHmlkpM+x9ll1IDsWfLGDMShTcx1V1qgx2cQdVjm/2gDQc=
X-Gm-Gg: ASbGncsJw3cHtnTFZSdEcM0/6kuGCipd6LgWPqdXOC5CkwAAlxPthHQGwJhbg7FLLJ4
	jXym9YTT4POubNFXfrTKwQbh/nSuqdSOVYpzNzqyIFSG7ICEcrTEvdb6Euo5EZD8b2F96uQeTZE
	F8/2BQxRKljR6BkIXkF3e0MnixDmfATNNz5oLn5UsJUz6+cFoR+3EMtTSs7ox3FfYViHaMO5nuQ
	5dRwbXfXlpH4J63I6RiJUAYM5Qt4BAg3JniRfhaOnsSHLkzP7Yvi5VcMlvOAtAZnYPUF+6pzmMQ
	D3+17cR/DoYYu9mgaoZRKtlTzn7V1GadgbBzTXfbHmfMgqcGQCBo5nPm2Jzfu6LVMvFVGmH4
X-Google-Smtp-Source: AGHT+IEY8u8v01mFisc/TL0W6gCvBjvkLcKdurAn91xGLMr57xfYjH/zVaAAA3K7rATTcPpWb32wlw==
X-Received: by 2002:a05:6a00:9292:b0:746:2ae9:fc49 with SMTP id d2e1a72fcca58-7485ea78f73mr3883622b3a.9.1749552422541;
        Tue, 10 Jun 2025 03:47:02 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:47:02 -0700 (PDT)
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
	Anup Patel <anup@brainfault.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Tue, 10 Jun 2025 16:16:40 +0530
Message-ID: <20250610104641.700940-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610104641.700940-1-sunilvl@ventanamicro.com>
References: <20250610104641.700940-1-sunilvl@ventanamicro.com>
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
Link: https://lore.kernel.org/r/20250514055723.1328557-4-sunilvl@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..70f57d58fd61 100644
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
@@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
+	if (err && err != -EPROBE_DEFER) {
+		err = rimt_iommu_configure_id(dev, id_in);
+		if (err && err != -EPROBE_DEFER)
+			err = viot_iommu_configure(dev);
+	}
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


