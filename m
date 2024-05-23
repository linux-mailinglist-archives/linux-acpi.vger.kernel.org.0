Return-Path: <linux-acpi+bounces-5959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F178CD102
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4392AB2025F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CF146D5C;
	Thu, 23 May 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eUNW5cfh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F601146D57
	for <linux-acpi@vger.kernel.org>; Thu, 23 May 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462831; cv=none; b=aYyqpOm6a6ATAvWMRWPU29leiChJUIHovgY8qHzasDIiqhuaPqEapnnG69TjzrEEpo7yWb/VuGCHnamPZg89Tiz5y6HeOVGmaonKHEGkmKFcnis8AlXz/ApLmThjv467DmOHZ0PXMu2mWHnlBm/8+KbDybnGSo5pmljqLemkjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462831; c=relaxed/simple;
	bh=+JzJj8ucCazBC6mptHHx0+nGx8xyX4nB++98g/I1ZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TotPYPCNS0O2EwliOHj7bRhKSp4VWjO1OnzhmIjbAq69wnK/t8Rqe9rBtjQJxhpzpSksfxVcYx4lbG/Qh2gWbPwyOpk2J9IvpQEfbLcxRWyyXbFls8ugmpkXvx6Zw0VSPqStDhZ/teS3X9USN90EB4Joo5OxLLlxLoXICwmITv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eUNW5cfh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f3421564d2so3142395ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 May 2024 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716462829; x=1717067629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=eUNW5cfheZqC47sMn4VqXjVInthPc9hTs9fDH0DkY5YD4ETMq7jwZHw5sDLdOawNIF
         /9KIWy1vFY659hnNF35q+n4ySWfdWhsPag3p2Ef3doH8PRsgcrIo5zFoj2taH+HbRud9
         /4c8cF7h8eJVWqs01Or0RKtol7PT0IJ1KuS9YYrT4FWIuXZeTtpqTEgXpJYPEoAA+E5m
         ulYPwHcihSraBFkQj95DtRL6Amh3PqgqMxbCPbobxURdoqvK2yYMtrKIgDwy1jkEZtat
         R9NZDH94eDjkJlXOTdzLBob/FYb0KuBM96ZZigNUlcogU1EBTjJMwHZWee8HjT4cgA3G
         tpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462829; x=1717067629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=dwst4ds5rwKbJJvtCpAgpcPmfzeyB0p+3JlWOA9iTpQvCXmM2LPxYB8+cgP/ewhake
         BxyCCixwBqJIuXuLYGLkBLRHCfHC+OLle6gm8a4qVbducIySrE9uKXklqH3GPxw183Pj
         o3/5kwpDegi0n7EmtxjTriN92zebI+3288oFXpZdSDrN2sm0t0ZfdY5syZjcsJQvtTwD
         EUdcvEZV1A5VU+zWRiWoiXKwXN2qK/HTOGlZW31cj6PnXnaoPfW8duQct7A2Ty1O3mA/
         bu9t//2Q2h+OKwN3a6j9DXN98UmCjyknA+j15lyVzxHXNnuT2JZwy5uo6VvxkwkB/Zzw
         +ktw==
X-Forwarded-Encrypted: i=1; AJvYcCWejY/7LTGMRRXjUcrxYtpV2pJsWs0l/LMPbu3WgndwDXjE9TPriR+t59dX419TV9u2b2U5QMIfTf9Ozo4D6A4y37E760IrdtQBzA==
X-Gm-Message-State: AOJu0YwWygfRwJgMKBEw1bXY0mSouUE3RlDGU/3izt/Q3sEkVvCSfIDx
	lH0MjvEpIb2RZYYTnAGlb6+CEygdad/+8shTFOOgQQ0ZgfDo+tBWnepEXPjgC+c=
X-Google-Smtp-Source: AGHT+IGZ11ZGVf2+lfQ+CO04h7/H65xj0+v0lVBzHE9gqd6ctUMXI7IPUiUEZxYjkmeoEd9vNdVmxg==
X-Received: by 2002:a17:902:c942:b0:1f3:830:783e with SMTP id d9443c01a7336-1f339f0d128mr27457195ad.20.1716462829566;
        Thu, 23 May 2024 04:13:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fb4ca0ebsm76399555ad.119.2024.05.23.04.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 May 2024 04:13:49 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	sunilvl@ventanamicro.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v5 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Thu, 23 May 2024 19:13:21 +0800
Message-Id: <20240523111322.19243-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240523111322.19243-1-cuiyunhui@bytedance.com>
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before cacheinfo can be built correctly, we need to initialize level
and type. Since RISC-V currently does not have a register group that
describes cache-related attributes like ARM64, we cannot obtain them
directly, so now we obtain cache leaves from the ACPI PPTT table
(acpi_get_cache_info()) and set the cache type through split_levels.

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..d6c108c50cba 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
@@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
+	if (!acpi_disabled) {
+		int ret, fw_levels, split_levels;
+
+		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+		if (ret)
+			return ret;
+
+		BUG_ON((split_levels > fw_levels) ||
+		       (split_levels + fw_levels > this_cpu_ci->num_leaves));
+
+		for (; level <= this_cpu_ci->num_levels; level++) {
+			if (level <= split_levels) {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			} else {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
+			}
+		}
+		return 0;
+	}
+
 	if (of_property_read_bool(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-- 
2.20.1


