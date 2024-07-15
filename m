Return-Path: <linux-acpi+bounces-6884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DC9317BA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC271282C1F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02EC19247A;
	Mon, 15 Jul 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tBMksm9R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABD190698
	for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057632; cv=none; b=nw7QrYRKUa0esmOgvKFAmvetXbEHzMXpx2cLcAnYRVm361OSdaqXCK94SMlcS040vPm3c/R7/2+Q8RbZ0BYkaij2Pa804Eu3rC72CSVmj9pLLCzV9xzWBZfhOm/orYlOnD6+UkDy3xR0x4qJel6/SAuhmX0ILW2mwbHj3FZ+CUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057632; c=relaxed/simple;
	bh=O17oVYZHosGaaJhlD2MlU5PTYcT36bEOgqEoMy9Lp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RbyMozwXPtVdTNVgz2nV9ER0Nh8cGIMWIFe/d9866fqICXjIA0PwjWrQRoWzAWkjbYsr6wzmCVy6rAKXrGwpTJ1xFNQRYdyOt+9crpYr8zPwUaUJjGfrLFi730SC4IVzbTdjjqm/o79e/XVrntcFq+c5Be6swDHg74lC9Fv0tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tBMksm9R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb761b1f8bso2928955ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2024 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721057628; x=1721662428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNrBKwYTcdYHsoBHljeLphuQCOZ/YFIVZ+KLTOSWsAs=;
        b=tBMksm9R3VMCr1eWe6f7oerChBH24oyqE9gpHbGX/GDHSPyFQePYwlAtESFSc6725L
         6eXjTemeaVyZXWnBLOvxWBIbS5g5CvdnCAH9HXExZT/OP2Ti2q7bAtpDqvB869Ao6VOI
         ArEc7DhfdpWpajlxLy5P5wxbTWc7h6K2FpQ110bJnAgHhBiFiEeJeusPu2b7dHbvSw+I
         KPLeC58Ndrbozl5DpsSr4Ud1ppFywpjmiYBrLWkfPevgF4Z2IgTrFm+wgb91GzV/y2+6
         TKGNCY5jUZqfDUgIs6iW7ZRz7DN0XPu6lLt48f1e7ofj641YxMR9N5v2Vgtz2Ga/u70p
         wDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057628; x=1721662428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNrBKwYTcdYHsoBHljeLphuQCOZ/YFIVZ+KLTOSWsAs=;
        b=SQtCY4oK2PK1Pzmks5g1v2VGtSulRqdUAKCa9aHTy5H0TbePR6Ruzlw/29hehzPWMI
         lkza+6PcgHRr+MHDvUVfw2y1I733CJ1OSQvvWY8W6jyvRu5ZCXpvJnzndKXXg0KvI8E7
         qDdZOohY/eBSkyHBsSwSx53ic6Cjqf0fcD1R+/lktGGvIqWPYkZ1/2UhzeDSnEkNEn5R
         AaupCdFTz0qPi46A5UlOrsnxgeA27wlF82Gk5Z6qHZhFp2Czcq8RGqK32VNQ/W9ghJnC
         kDMB2UaULKXgmu0zRMxBZK4bKI5jb0v8nZ8uLjUSMzKdPd+ljW3VU8GEBDyviPdN/5aw
         W15g==
X-Forwarded-Encrypted: i=1; AJvYcCUst95YA2ew/sZ0g9tieUZm9wpOUH2+3CuX5hO+8SnBq/cJwdT3POYWmdUMLh1cD4LCntTfubdm2LPMYwrtg9+9mrzj992zBgS9WA==
X-Gm-Message-State: AOJu0YyWDr8yFnLrOl3+nCoNN3IwvdN+y9q92cRoKSMjlKarnD1G4Yu3
	Kini4yjT22WyNd32vnI9S17PBqjm9zGPcJMW4ZEyu8YjMCga8LQ5tLLmEJt+AX8=
X-Google-Smtp-Source: AGHT+IFBGQtaMboH87ZiITDVDC8NxVYCRbzN4TT71saPPYRoOL+WvGv7Cmx1qWcc0JUtTQaQgm2X2w==
X-Received: by 2002:a17:903:2348:b0:1fb:3c1:cb26 with SMTP id d9443c01a7336-1fbdc45a9a0mr120691815ad.1.1721057628613;
        Mon, 15 Jul 2024 08:33:48 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2736dsm42303825ad.159.2024.07.15.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:33:47 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] ACPI: CPPC: Fix MASK_VAL() usage
Date: Mon, 15 Jul 2024 17:33:35 +0200
Message-ID: <20240715153336.3720653-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MASK_VAL() was added a way to handle bit_offset and bit_width for
registers located in system memory address space. However, while suited
for reading, it does not work for writing and result in corrupted
registers when writing values with bit_offset > 0. Moreover, when a
register is collocated with another one at the same address but with a
different mask, the current code results in the other registers being
overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
should actually read the value, mask it, update it and write it with the
updated value. Moreover, since registers can be located in the same
word, we must take care of locking the access before doing it. We should
potentially use a global lock since we don't know in if register
addresses aren't shared with another _CPC package but better not
encourage vendors to do so. Assume that registers can use the same word
inside a _CPC package and thus, use a per _CPC package lock.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  2 ++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..2e99cf1842ee 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
 					GENMASK(((reg)->bit_width) - 1, 0))
+#define MASK_VAL_WRITE(reg, prev_val, val)						\
+	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
+	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
@@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
+	spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		*val = MASK_VAL(reg, *val);
+		*val = MASK_VAL_READ(reg, *val);
 
 	return 0;
 }
@@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
 	int size;
+	u64 prev_val;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+	struct cpc_desc *cpc_desc;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		val = MASK_VAL(reg, val);
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_desc) {
+			pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+
+		spin_lock(&cpc_desc->rmw_lock);
+		switch (size) {
+		case 8:
+			prev_val = readb_relaxed(vaddr);
+			break;
+		case 16:
+			prev_val = readw_relaxed(vaddr);
+			break;
+		case 32:
+			prev_val = readl_relaxed(vaddr);
+			break;
+		case 64:
+			prev_val = readq_relaxed(vaddr);
+			break;
+		default:
+			ret_val = -EFAULT;
+			goto out_unlock;
+		};
+		val = MASK_VAL_WRITE(reg, prev_val, val);
+		val |= prev_val;
+	}
 
 	switch (size) {
 	case 8:
@@ -1134,6 +1166,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		break;
 	}
 
+out_unlock:
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		spin_unlock(&cpc_desc->rmw_lock);
+
 	return ret_val;
 }
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4..e1720d930666 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -64,6 +64,8 @@ struct cpc_desc {
 	int cpu_id;
 	int write_cmd_status;
 	int write_cmd_id;
+	/* Lock used for RMW operations in cpc_write() */
+	spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
-- 
2.45.2


