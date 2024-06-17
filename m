Return-Path: <linux-acpi+bounces-6446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47090AECF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67114288CCB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1619755E;
	Mon, 17 Jun 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R4hQBs5j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EE197A9A
	for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630082; cv=none; b=JIchf1ditYdNHHDC2Tw2VG379GcDCQ23uD4JDt/kQsk3Y+9SwIC+Hm20qPEXVs7FlugMz09a5QZQoK5B3eZgAuRyITwsEA+tqELknxAyrqJ0iaLBTql9rzkrnm0VfiwWzn2J9v9YIhHaKVSVjPWgcIV2pTG52+ioDvcw4hDNVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630082; c=relaxed/simple;
	bh=+JzJj8ucCazBC6mptHHx0+nGx8xyX4nB++98g/I1ZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTUGtjJgCsD6peiyDB3gHMwxmpeP+b4/T0SSGw1AttwFsFaIo0NVwXEVtaNS4PGdUijX4hC2sEwkftFKB5D9hjPSKFl+tkU3iaaY+oLenthiUPM06M7F7bEgV3n4XpB0FvjW0rkyy0RQnkEB0wYR0bQryr0I0rgXjUdY0ycqD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R4hQBs5j; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70109d34a16so3783393b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718630080; x=1719234880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=R4hQBs5jjD109BAZ583iZIwha7pp0epmdo/8HFEmMY3Rz5wKmtFi2RCscf5XBFi0yZ
         Ucz8hpFI5v+J8A4cfP8Pr8LDfa4ke3DY/KHmZTLigRe5latAO7g3tw7op8gM5evlIYVt
         CiHUJbj8EdvNSFgOlcgdIbwV8+ju2zLdI+3tdDSqXmaBYvgKVGYCkJHvXRB2KEqpZW+r
         VPd1jk939uRY8oA8TNSfsxx6s74AqO2GIkTayeQStoUN112n+W3YqTQiuws9lQ4vUriJ
         AC6EXoLGLx3PQRux0hwlz70uYG/POO4gsEaSidIAdfz528SaffQDpuaj1Ay+hftGrvCP
         35Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630080; x=1719234880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f2nZESk5IwUhjcBCwDQD5m6WSIwM88cL3SwI9ltT4Q=;
        b=LQYnLL9AXWsEelu71dSc0jGM0MKn96vqzkxTpiuKctXPcdNwDD3ecWSEAChktg6Egr
         m77LXOaxytYpIs7hyPablwkB8S6jMzqVDIlVyzXgHppJq8ayTcerb3ROSONDiB+adAD8
         Adpg1whS0ed25gxpxiTNeTCHCmtwPDsXWuUrKgNMaWPzGazcjnW/uw4C0pGNZDmNsz3X
         +Pqn5y7O1v0SL58yrA/DqGHEhG8E/w6UI7kyR3wk6Vw2G/sUl9OeJ8j5qoYptRGKwt3D
         WkGEThrlkbQU20blwllJIpTER+whI2JCL54yc6HItVpZG3RDYrevQ6fPCWVmfmAdf5UU
         AkhA==
X-Forwarded-Encrypted: i=1; AJvYcCWJK3KpA5Df9ADUbtM+cflYmfyBgk/OcsxnWXZ9Gs+GxUhXmu+o7JRRqISIxjjxk1Y8dfxxLMaWTPsFmVV6WVwRVfU12S+SXFn+Lg==
X-Gm-Message-State: AOJu0YwragcuOsTBHNUnh4iANw75909x9qhuSp4Qwa2s/6R3lBD0UM+4
	CeQ4mFjQRMey82dWA/yC1y/WVxgRM78WmoZqfvTuj3oGtdIOf27hgTa+jjTa624=
X-Google-Smtp-Source: AGHT+IFyXVXcwEnHkFr+M+B09gwoggwiZPCR+TNh4urQv2uHfL8+aZj9PiLWU/sney1s+CzXzICoGA==
X-Received: by 2002:a05:6a20:6597:b0:1bc:a4c5:445b with SMTP id adf61e73a8af0-1bca4c54494mr873421637.24.1718630079903;
        Mon, 17 Jun 2024 06:14:39 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm78801785ad.200.2024.06.17.06.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 06:14:39 -0700 (PDT)
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
Subject: [PATCH v6 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Mon, 17 Jun 2024 21:14:24 +0800
Message-Id: <20240617131425.7526-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240617131425.7526-1-cuiyunhui@bytedance.com>
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
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


