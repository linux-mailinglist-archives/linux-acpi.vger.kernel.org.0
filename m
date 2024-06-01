Return-Path: <linux-acpi+bounces-6121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A88D70A1
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2BD1F23615
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618815279B;
	Sat,  1 Jun 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IZuwQd/J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E37152E0A
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254306; cv=none; b=b2AWUrvz7QS/Nt0lncS3UfkgeT1hvcW8XtkqwiXFdpMxFa11f7YbdvODFBmPBdKzoCWgYHIDuRPF3g4OKCDrMYswRdN1jbHOYWK0xZoSucO9Ew+WOh1EBbM0FMtvM8cAT/E5ceykZNOPZ2Y9bd9uzRZRXbh8nYyigClYQfdvpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254306; c=relaxed/simple;
	bh=gUZ5nlwTeV/W2GAxqRBkwnxWUnWQmkvoylnNCHneLXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGS6A9BVBBD+D1msMSFhXeQ43UjUA9kDxt0P6rva7r6vADIey/MgVnjhuM7juU5VghRZxY3bn3sIZ/n/Dzf73j78z6R5Lu3F9xubeCz3Yp4jqkfgwicpnYRlqWtToqKaWjWPtZPRmgNtEBb1o9h8lojGTdTMGfYAZHylYHvY5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IZuwQd/J; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3748d68b713so5531675ab.1
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2024 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254304; x=1717859104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/CsLBy86VnyNo2isQPCT1WZPGBpvem+xh2ISHmLXVs=;
        b=IZuwQd/Jc+GX1RaooXAgCSZ9pqgw4oZRgMY7PlmedJT+SD8NwxL7xPHt6OK0tpAAW3
         rDexKMV0YFVSma+weZAs8Q7TtIb1c3g3JFHjTZr6Gaz48ZrNq/6FQ8onugsLGv+04EcI
         KdK4Eg4gan9h9VIXW/ZIIskIN3Os6NfDCQ1nrssG0UUi+cqNUa/BQgeKveir1kJy4Rsd
         aGbVfGJglSfBxfSHCbu3BCV8F8nOIuo1mbPRBtSyavX3Dx0J7dj7CL4G/w+XsPYwkvwj
         rKTCyAn0TdPCLwIhArVi15PjrFK7q5Zykhr4ps1/xTexc8IINOA7tUIMdUziqNBAfsr6
         VRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254304; x=1717859104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/CsLBy86VnyNo2isQPCT1WZPGBpvem+xh2ISHmLXVs=;
        b=uIY9Ekno083QaIifAsgzjmozFPXcsUdNWkPe2E5rMgddmWqk/yCH3lYV2MbuHbl082
         rLjFwP8PyQlY/zIGNQnUx/+8VTOgeXdOgZ8V26I+qM5HpeE8KjFA3NX5OqEmyJzxTOrL
         TWnqoxvmgyZQy6HHPsi+S5IAZJugKNn0jbClQZha7je5a7+5jEUszy1lYby9L/sLRZ6m
         8vXf7W/gkHI9l1uZQPlSDp9jmF/SDJQQsiUau+mXRyW5kKbH8fZg/mmZzVaT3zpbFk4t
         2BMeAUvxWH1r5mcvKpU2oPDTZlItzRQA5Setgvg2kyoMUhklY/DDa5NN7NxCyc6JAt63
         0FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXnspCbaVplPdyI737+b2Fvp0Jfdb1qKOWJsWIQLYWx78t2tfz1Y0frGl+LaWkWZdkiAjF3+dezsEWWdigLzo3GK0e+QxnNQL8Pg==
X-Gm-Message-State: AOJu0YzppAEOk8t+ZBp0kDe8uEs3fVFQ3HC332LXAk+8bG2H1YdXrrkZ
	yVb31D+DgeZi6/BjvP/DciULNs6UIEay3LFiwrQNMgNSU0DnuPZP9me9AdUX5S4=
X-Google-Smtp-Source: AGHT+IF3OVauvlGO1nxR3XDABScTnbIuW6VxwtguVbngDcxS9MthKKzwc9GQNZ47KhPfz+utEVmKGg==
X-Received: by 2002:a05:6e02:1a63:b0:374:5672:6791 with SMTP id e9e14a558f8ab-3748b97ee00mr54534805ab.8.1717254303897;
        Sat, 01 Jun 2024 08:05:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:03 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Sat,  1 Jun 2024 20:34:00 +0530
Message-Id: <20240601150411.1929783-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6f3152170084..918e71fc54cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2068,11 +2068,22 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 28a9b87c23fa..5fba4075d764 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1


