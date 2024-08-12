Return-Path: <linux-acpi+bounces-7509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21AB94E449
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB11F21E94
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15120A929;
	Mon, 12 Aug 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DPupl6mD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47426847A
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424408; cv=none; b=TyEtnOPBufRwRxqiLU2Z073YGTbpZ2oYwxBzIIA+Md1XALyArMc2JA33VNW8q7KuxoZiy9OCPiSNPzGJWs5A2H60tjaUMgjNEPqdqEdVAvS5CBEG3Cm5CWK5ka3ajxMQJQkOQw23XDcF0cHVJQmgmrkiBPk4SpY2XjrAFriC3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424408; c=relaxed/simple;
	bh=K0yy2Cz0AHQ22O/DOvVoBVInCMziuYu5zVI87ewmQhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqaY8TWmTm1qT0rRMwV1/FmQDEqjoFOP2/eHx6VWmQNz23sFSkJ14UH0v6QORDcKSzpwr9NMCdmDQVtR9fTsmYvpQjKtbDlFkFrDCtP/MJbjU83jfBTCfdB8hHhuBGpxOkoGvPsnbN8Hq17XvW4jzklCHav5DyMgaLVEtKRbbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DPupl6mD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db16129143so2265756b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424406; x=1724029206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg7MKJMwlR+eRmszvFqgWwl0l7xFjetJlLXQ4McHDXI=;
        b=DPupl6mD8Li0+PwzeoZ7ghDCDT26Mm/9JDUve1DG4jAEnOhonmr4D8Nayk1fdZ3WAc
         E36uSB4R0LsyqY45B6MSGq/xCWZKrjXDWe/2ekB0CPf57t0Og2Jd71n9Ngn8T7iKJYj4
         HTkotHhuhcRS+5bUAHZsrMCoCI++JF4S40u4hyZYlRDjFieRQGmoCmVvF8BLq0G3mQhJ
         EKQWXOevBD8/+SkLP756ywzuA1HpX6Z8MhqLNHZMU5hXyIu+y3Xh4ZfQFzVIYb6I6VWu
         ZlXyQyy55dxyAAeFo33Xzu8Ea4e6I8+FcdL9oH4gSlNpWjGoEMEkvduEGHaiRT2BsUKS
         /+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424406; x=1724029206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg7MKJMwlR+eRmszvFqgWwl0l7xFjetJlLXQ4McHDXI=;
        b=kLxia2P6mExDRQGZD9wzETvKzmPKC8FX4OZV7Hq3Q808hZRRFwGeOzQi2WHT7g8kUo
         7+ReIG1dM5lPq3Kk6GIW/9VPYq6nCTVg4ERiP6X+HPfbzDB7iwInbGYTCnnDfPMuyGPF
         ZjzmKk4mJR/2CJl/py6dizDo/i348Rrvnu9syiETyHXtezGPCnHJmAlkjSQwNVEsKqrL
         NVX7fdN1MQ+kV6jSru74OmsJ7+d5salqT1sWzD47acWMKitYylbcwmApHN0RTEiBTRDH
         oyBNJhTkc7Xuj9gF1BHBUBV+GoR8Be/h3vOBee7IOPNGpHpvfRr5qjoMqYUOhsvbbnW0
         4Q7w==
X-Forwarded-Encrypted: i=1; AJvYcCWT0g+NmtaWAIyz6nHwd7wjcWb2xUyqOtXJL3sYdlqbodyKGSAfOeEsHGTNiwrgyiJhIcmee3y2Z5UJGJEz/6pF/1Dk+pAUXAeAyQ==
X-Gm-Message-State: AOJu0Yzv/01TrTOp8yB1WPXYCDeHaen7pHJQ10i8D2s6bW+hEkeyequR
	1uLk5IMpYyWyM5S8GG6ESr7LBE0DSIxds3qaociDE86WxF+JOSDSDvEPLxk7co0=
X-Google-Smtp-Source: AGHT+IFq/2aqIFIbaZVtORXZ4ma22Wclt9l+I9epH3oTGlfkp+sVOBf6L7LmmBy3q6/DeC+M+tbDQQ==
X-Received: by 2002:a05:6808:3a07:b0:3da:a16e:1764 with SMTP id 5614622812f47-3dc41667c8fmr8781731b6e.4.1723424406285;
        Sun, 11 Aug 2024 18:00:06 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:05 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 04/17] ACPI: scan: Refactor dependency creation
Date: Mon, 12 Aug 2024 06:29:16 +0530
Message-ID: <20240812005929.113499-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c     | 86 ++++++++++++++++++++++-------------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 52a9dfc8e18c..374cae4aef78 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2013,6 +2013,49 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
 	mutex_unlock(&acpi_scan_lock);
 }
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
+{
+	u32 count;
+	int i;
+
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
+		struct acpi_device_info *info;
+		struct acpi_dep_data *dep;
+		bool skip, honor_dep;
+		acpi_status status;
+
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_debug(handle, "Error reading _DEP device info\n");
+			continue;
+		}
+
+		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
+		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
+		kfree(info);
+
+		if (skip)
+			continue;
+
+		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+		if (!dep)
+			continue;
+
+		count++;
+
+		dep->supplier = dep_devices->handles[i];
+		dep->consumer = handle;
+		dep->honor_dep = honor_dep;
+
+		mutex_lock(&acpi_dep_list_lock);
+		list_add_tail(&dep->node, &acpi_dep_list);
+		mutex_unlock(&acpi_dep_list_lock);
+	}
+
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
 static void acpi_scan_init_hotplug(struct acpi_device *adev)
 {
 	struct acpi_hardware_id *hwid;
@@ -2035,8 +2078,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	u32 count;
-	int i;
+	u32 count = 0;
 
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
@@ -2045,48 +2087,14 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
 	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
+		return count;
 
 	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
 		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
+		return count;
 	}
 
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
-		struct acpi_device_info *info;
-		struct acpi_dep_data *dep;
-		bool skip, honor_dep;
-		acpi_status status;
-
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
-		if (ACPI_FAILURE(status)) {
-			acpi_handle_debug(handle, "Error reading _DEP device info\n");
-			continue;
-		}
-
-		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
-		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
-		kfree(info);
-
-		if (skip)
-			continue;
-
-		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
-		if (!dep)
-			continue;
-
-		count++;
-
-		dep->supplier = dep_devices.handles[i];
-		dep->consumer = handle;
-		dep->honor_dep = honor_dep;
-
-		mutex_lock(&acpi_dep_list_lock);
-		list_add_tail(&dep->node , &acpi_dep_list);
-		mutex_unlock(&acpi_dep_list_lock);
-	}
-
-	acpi_handle_list_free(&dep_devices);
+	count += acpi_scan_add_dep(handle, &dep_devices);
 	return count;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8db5bd382915..d6a4dd58e36f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0


