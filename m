Return-Path: <linux-acpi+bounces-4992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A898A3FF9
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340D11C20EE3
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA217565;
	Sun, 14 Apr 2024 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IK2OiGAN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A118C3D
	for <linux-acpi@vger.kernel.org>; Sun, 14 Apr 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063586; cv=none; b=C4M+MLjrboPf7fx8Oe5C3IjQSlp93yM44V3E7vUD2cM10Onkxw2e31XKgjUCUQLswSLAzMQH47ZfIccmm+OkVm03Ibh0LXM7BWoHZZKjsFJW/5VteYTjs6E5U7aeZFSQcFlNrDfvgr0ISFDmtgbl4UUK1d52dxrRBGzUAWfaA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063586; c=relaxed/simple;
	bh=GNxwO8FiM91HhPodNEqh1grX1c2NbQXpFfur+digntU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yfwl/mmam5CpTlyc/4GlL8jW9+ltH3gsykmjnM6e6Qlhvw5m6Y5NTQS9Av5teKxcHB0h8v5bYyW9d+V6uAiG93fnW4H3tb2JOokKcGyCjcniEvCQ5KhhabBjzsVTHmjocg7YZLmjF7L5y+NrFJequ+KgP8EQT+GY7DOo/452GME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IK2OiGAN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so1696400a12.3
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063584; x=1713668384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+iJ/bWcbs5TbNYkdodB+bg4kp9o+X2TePK5VotNZ5U=;
        b=IK2OiGAN6NQbyDG1JvzjtEYJ79zVP7XjJeqSP4Xko8J++mC73Vivgs2R8QkUJ+BITx
         LGNqPcl85iDceypbrSZ7XaFn7m1RzhkFEbZDHEzt4/1/dF3IbCtrN+Vx4g5z9AiuPvU2
         M1+OFXpee1cYSVEoQqU2E0c909ylfOMGS9nfNsXTkOBjTOAE5mauGFup1tahk88rSIji
         TGqqImmeRIjrOpHtSq5TXofa8mWaJqZV/+zJ1vUTIfbfGn6YVQWTgsI8FCBBmpoFkNgH
         XlrRDEAbOHlLDdf3EqDICDoj93UAC7dYq//CyqP5aIvmCPeGd7aSUSQp8lubCZ7ODnrg
         JgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063584; x=1713668384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+iJ/bWcbs5TbNYkdodB+bg4kp9o+X2TePK5VotNZ5U=;
        b=Ky+BgSmu2GxJSgV+tsFBFUjREkhTpxvs3j0FQrlfpnzFXRZ8buyLj2kapFrNhtsA6F
         ZiMMD5sSbFhpIQyImjkDMX6wCUBSoAm4gCAHPLEV1lUXoAmAakT2UYcIYMw4P/F+Q1vn
         ta7g85dF+1qS79WrPBVw6gktlWGvnFNm1Ty65AarwVmWWc9iht3usugV6rGfZcNrUFc4
         c1nXOwMQpjD4/Z4HsluNMFmB50UyeKs5kN3Y+vYEdYT/m7opFvXnXBwpT60U4KZ7nc68
         2GTMmYWYViTQIUrXOJl/rg26jfBqd0q9+gw/7rR6c9D4jabCGzRWhtMcZK6IG4cH+hQy
         wNtA==
X-Forwarded-Encrypted: i=1; AJvYcCXhBaU6muGA2aYQ7ag0qnPlZCCOAFhzHXdNTFqzAGvYo1biUCuusTaXgaIoW5ZWwBjqs9gOF5bG9mq9J/WQvwgmBqOO/4Zyu1KM2Q==
X-Gm-Message-State: AOJu0YyUGg6YqcarGNlWhtR3BfLkTMJvJoVJwz38O6qIs8ZwiwjMHBKa
	bD+V8k0ajm6TSPQES2u6lA6B3p7/IFU5iBOrq69+aL5EcNNwjaDMWbOj1lFrdG4=
X-Google-Smtp-Source: AGHT+IFC7Ostz4NVqRl+TdyivWIDYqcK3ZnTae/PQDs3xYi5nfAgFK24gkFZANSYBnnATXXDHJF4Cw==
X-Received: by 2002:a17:90b:80a:b0:2a5:513:921e with SMTP id bk10-20020a17090b080a00b002a50513921emr5443131pjb.31.1713063584355;
        Sat, 13 Apr 2024 19:59:44 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:43 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Sun, 14 Apr 2024 10:58:25 +0800
Message-Id: <20240414025826.64025-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240414025826.64025-1-cuiyunhui@bytedance.com>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before cacheinfo can be built correctly, we need to initialize level
and type. Since RSIC-V currently does not have a register group that
describes cache-related attributes like ARM64, we cannot obtain them
directly, so now we obtain cache leaves from the ACPI PPTT table
(acpi_get_cache_info()) and set the cache type through split_levels.

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..ece92aa404e3 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
+#include <linux/acpi.h>
 
 static struct riscv_cacheinfo_ops *rv_cache_ops;
 
@@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
+	if (!acpi_disabled) {
+		int ret, idx, fw_levels, split_levels;
+
+		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+		if (ret)
+			return ret;
+
+		/* must be set, so we can drop num_leaves assignment below */
+		this_cpu_ci->num_leaves = fw_levels + split_levels;
+
+		for (idx = 0; level <= this_cpu_ci->num_levels &&
+		     idx < this_cpu_ci->num_leaves; idx++, level++) {
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


