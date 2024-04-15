Return-Path: <linux-acpi+bounces-5035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5C8A587B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE57EB242FD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000E86AE2;
	Mon, 15 Apr 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g8VaR1/m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59184A31
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200539; cv=none; b=KTueN2yvkoR0VoxGpIMp/lAAB5iNrwTH5isEuuYjOMXL+0HDArvi9B9QSvCZzL4RIEBb9Fcz2zKrV+JDziGbhL7zTE2AfFvlRLgLGiCbHDYpckFB+ZtkhfRn8Z7fqfMoJbYGhw/Je4voJiDXpBxgrLt9zi1ATPWD++djlmgrauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200539; c=relaxed/simple;
	bh=2Gz5QkDmnr7hC62yIyTV6F1j/bp+6gUwdzqqwho4EiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1/oaSGvHDJOeWLzkZSJtMTxZpddc4C5SKUQP1kzIGzkSsYShStxbWoCmTBD9/xW/TT1XzvsG1jiw0oM1hDzFwtXlyzYchjCfSdjKCKyP6ZuxfK1virWEs/JCt4jHKE3+1PcbRs3f9gTDJASyl6PUzFSutTbTR7f7Av0YKKBtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g8VaR1/m; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso2692151b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200537; x=1713805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=g8VaR1/m3IE/227Bo+gzhO/WkqQiWRT+aN5TF6XOdmS0ACj8BJfeGXzAvjNJkWUeRh
         WihRMp590qQS3MpkgRKqdwavMDkkz0HIHFioE9TgjFtCR0VypVzIejirZ3AQJSgm5fY0
         gEXGMz5A8FrhDEQO2+YPVlyjg2pMJthxpkgaEsvbxobMy2oqgMVu5tz0mLu/Ue+/ntfv
         GX7OkZvx/8uyJsT+oxuNI7kC3VjR6L1U2YRFAfA8IP+OVTmm7XeTQ0k64aalN+EZCftL
         FERWHQlSfdrPazQXuuwRQO4jcMPLOk7N8tcQiFE562urEdoA9KneK1UlKO8sxU2RHL9j
         8Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200537; x=1713805337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=fQ7FZ7ZJthCMYqYN4/ifaRsJSUgy3uT/gbPeVgbMxdaeC2AcPibEUKeznnlz7czw41
         cmolob6Oz/ICXSX4wuZJHWcC/VbOgNbpTQRR34dQrpKfxpfyJ42UC4T8mTA1hiNo2imT
         S3N8+XcmmnKLLkLJVYgUr5u8gVAp0FaXJrCQaIkKwFbiGzqEZyG25XUFP+MYdEYxCTfR
         KPSKnj13B0DGg1Zc/Vc4freSb+3fbwbBh/z/biWKFw3RxdR4FhAcJMprx1KDYZmk586z
         iN016KtqvgMjSlhTb0YiDZAnsVQuKxkbtcDRT/v1grlEzbfrK35+ZCFQUcypuEiVGdE+
         1PUw==
X-Forwarded-Encrypted: i=1; AJvYcCVaSwY6AUSoR+4KiN3abTWSOKlhNn2N3cc2FB7Z2OKG+3W+lAqwEPj2q/NBpjy+ybb8XdW/5Au52yLuXwUY6c8GZlp9cYvXComMDw==
X-Gm-Message-State: AOJu0Yy2tv1N+VP0JXjrvAtqmJo7m0gr/tu00EwjGKq4p/KrcAzsm74g
	bag1Qv298VqDFlKRD5PyBo95nnSm4vhTTqq24sPuaCJs0awQblxcq1KXFwRD2+c=
X-Google-Smtp-Source: AGHT+IEOKdv2GIoPVzAfszA+Mczkslu8VP2JvMat3iDp2rWUvNRo9ufo+FIpILZ6uWBafbyo9KluZw==
X-Received: by 2002:a05:6a00:2314:b0:6ec:cec1:8fe3 with SMTP id h20-20020a056a00231400b006eccec18fe3mr10562037pfh.11.1713200536823;
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
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
Subject: [RFC PATCH v4 08/20] ACPI: scan: Refactor dependency creation
Date: Mon, 15 Apr 2024 22:31:01 +0530
Message-Id: <20240415170113.662318-9-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 48 ++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index de30a0af7a2f..c8f40d81b6cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2028,33 +2028,18 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 {
-	struct acpi_handle_list dep_devices;
 	u32 count;
 	int i;
 
-	/*
-	 * Check for _HID here to avoid deferring the enumeration of:
-	 * 1. PCI devices.
-	 * 2. ACPI nodes describing USB ports.
-	 * Still, checking for _HID catches more then just these cases ...
-	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
-
-	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
-		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
-	}
-
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
 		acpi_status status;
 
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
@@ -2073,7 +2058,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2082,7 +2067,30 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
-	acpi_handle_list_free(&dep_devices);
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
+static u32 acpi_scan_check_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	u32 count = 0;
+
+	/*
+	 * Check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices.
+	 * 2. ACPI nodes describing USB ports.
+	 * Still, checking for _HID catches more then just these cases ...
+	 */
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+		return count;
+
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
+		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
+		return count;
+	}
+
+	count += acpi_scan_add_dep(handle, &dep_devices);
 	return count;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..28a9b87c23fa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1


