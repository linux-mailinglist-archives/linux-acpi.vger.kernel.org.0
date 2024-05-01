Return-Path: <linux-acpi+bounces-5561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA38B89B3
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 14:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFA1C21308
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FD126F16;
	Wed,  1 May 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dQMgDEvd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E13126F3C
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565924; cv=none; b=TAI0hetwr/F5ZsqjOScO2Ba4rp3vb+eV9ISGIrp5muYinLFulbQtX68R6HUtD7WVbYBd22UB/syixoiDZvmDzIUcnAUiNVYUqdLlBFSKvRPCvfN/y7txco5GXVjfli/7dXeI/T3h9YPe8a6WGSRf5CbPkgudklyh3axZv/FUtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565924; c=relaxed/simple;
	bh=8Sfu8Z9vX1s+/fsrTVCUwOEPkW2bmWazbW7JyHI1Yzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKwTZyFKqhuV/u6H2i7BLNtArYz5FwUC/ISZ5DFRhJM0okdM+AvvYv23j9wW/Wd5sEcus1F5UKARUUEDwVm8/aF4qwENuMsux4qeCjepUmewfsY/lsiI1io/7PawBdyiUa7BnpuF9Vj6y9w4XQeCgpSzW4ajIpqLjRJrlYi7jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dQMgDEvd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so66749365ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565923; x=1715170723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=dQMgDEvdGDpkqffEqE0YIpbluC9isPcjHb1zOy6hv2Np2N/8nAVqGcGJRlwqvpUDY8
         bnsB7zH723riXC83pII+dlLuSOPW1eOBGt++KkIbN5xvAmSq0UiDCO0zuz2vs4SKGWZy
         Tncrx+1FWLtyHRKzanmiqamw27DPSxEa84g15k0zJZDrK8muzvpaV+LfJ5bLoGJiSs/E
         ZGegZy9o7fQMonMn0YViScl3RPkZX1J5hry8+vrvxFb2zjqZWgbRjmY/jcv1yT4NslZg
         rtetA5YEBa6NGScgTCw+fArrKFiCSxWIxI11V5q8He7YHksYonh6/ciZed/jNjP4Nhmt
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565923; x=1715170723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=IZiy4DiHRYmRmtUvypmDGDBukf3dm78UJYVS2dHAl8aT2H6EqesjsRFhPy7a2kwB8i
         ke2Ye7QooC5eGQs/qEF1z4TIbRFHLzpXJ1L6j3jGyWJm24WYw3L2ws9k5v7W2F2tTQnb
         rwYDalGvwvOvpbJ2Zngbx15CTc4a/O6jXeVteO8kG0NEq7h9pQ5gkoF9GNJWFDXZQ1rk
         1/MMzW0v8005EBPNsXpJ+s4TsOmvbrw+vzZY50SO8Nl33uNqsg5PXR1xmZB54n8o/RVB
         HOfCD6FM5BvnarTVRa+p6ZQdjKhNMQxQa82aPkz60+v0J2NoM3CbVceVmp3qDDtq/OQg
         iRig==
X-Forwarded-Encrypted: i=1; AJvYcCUa4Hw/B0RKAjmi9f6VOuea6Oxnc9GbI4OJZYPhZSd2C4LKe3cEISrrO2rOaXhdcbRRx0V2FjGcecjbGYJimmbQsZHvDVlC93buBQ==
X-Gm-Message-State: AOJu0YwhSlNIftNcoCfXyrTUoj9c8kuGSdlBhxzcLMAGtnJ577oWEDjj
	6UDP8kjk+jry8rz37YVMd+cS1AudIgIKhxS31ksqPoBW+VgYEaPFo2+4SOX5dG8=
X-Google-Smtp-Source: AGHT+IGI5pV9TYR10/cfbIQ9JMek+r7tBzzTGhtdRl1CfIULDyfaZRTCxXSzFPv/bTagC0SBwcv3pQ==
X-Received: by 2002:a17:902:db09:b0:1ea:cc:e123 with SMTP id m9-20020a170902db0900b001ea00cce123mr2687556plx.46.1714565922763;
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Wed,  1 May 2024 17:47:30 +0530
Message-Id: <20240501121742.1215792-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e3320ddb3da..beded069cb0a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


