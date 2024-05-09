Return-Path: <linux-acpi+bounces-5679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC638C0BFD
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB024B21236
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930C8149C7B;
	Thu,  9 May 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rctwutpa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA391494D9
	for <linux-acpi@vger.kernel.org>; Thu,  9 May 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240041; cv=none; b=tLR5+lCUINjbmb7gQflrCLWuiLxFiT+eE4/o0a9MxjSj3Cjx9+MJO5f3XzWTQ060m0HpJDUvwLl5Xzv9M+4xJzCv4KVSCs9ZdFM6evyPmGVkvqLwzomn2unY09Pw5OO04/3zs8JWEaE7TIKgrRGFfAjjvK0MS/lk66IbPZ0tN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240041; c=relaxed/simple;
	bh=sCpUWY3HzIVMI3TbeegEZ/zm4GDQ+yecC/8p7PvVbno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUBUYi5e3EqxzzNQnofk/mqKG2E6DczW/0mqUsphuzKMePo1wUu7Cqvp3IqiJkNp7BZTvxnw5MJyVMlmbIPDyo0xyMevv2tZ0JfpKxiBy/jYOHHoibZDJEOtg3avzkdiAb5pycZWSfmIIns+uBqKL48pBTzouHc/oGHohDTYcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rctwutpa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee954e0aa6so3829495ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 May 2024 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715240038; x=1715844838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cwpsa2HL8S5jIz0x6grJAB8mOqnJkhHeKGCfgHpfOE=;
        b=RctwutpaGCvx7q08udDRVSsO3Q3+gNTCiU23tJP2hz1rw5/i6fVG+5C57Ncpelc+Tv
         mmufeibCLuk+luPj67E/El5R/duxtkqPnfSEK4ypc2t9NFQHxUecykK5RiSqkJG/hudE
         ebODZcSBAkVbXYag1S1ZKpF6WjPtVoA/H5BvoWf7hf9nCAPXiuXPIt9jv5IuK8FjcD8T
         7EBzbkOUtEV57TaS8C1iiHq+x/T4UW7l/gmMFPtK3K96wOzhLtLi2G/WLzxaPR3HcAk1
         SzqprbkBsHweEBmV+k4oyVD2OKxmgru9V/0jUo7qBaqpCocAR82Wi/nB0f9Lf/3ZQf3V
         eAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240038; x=1715844838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cwpsa2HL8S5jIz0x6grJAB8mOqnJkhHeKGCfgHpfOE=;
        b=WQYRuqhnRoWsbcOEf2q9Qlp+SlASYtMYHg/KgHgEsUqKhylbaK5ipH0BiZX1zfvJxj
         iX1rbtTp8fO1m9yhgaJnvd5bMG13mIisiBwkabufUtJBb5n+RhMmiRobRlhPyhEmNjWX
         lNEDx7Famkt26TsKn+5dwsoHKWnKK3VldSYmYiwFldZ+aBQVvVWZ64wyHmBPwWiZfmk4
         eGDGyhfVjsBx3WUDy//0oTrD8hqifkQM5L6r3GqLZLIET7u1jUd/nUmtrLi+H4D3ySR8
         JBKOrzZ9lviMvDvYmG1HBpbqFWay+OStHfwPi4zy2sox11pTI5kwhs9gYcOU1WfIsiJX
         Qcug==
X-Forwarded-Encrypted: i=1; AJvYcCVMfrqzM4uZFwcdk3Oe1h3c0KCeWySD9V/ulA0O5WRz9H3DXDnIiPuYXpEyGHmSd9w4jX9gSUD/zhy+J0WHAx018V9aznYe9RkRLQ==
X-Gm-Message-State: AOJu0Yz92dQZLD+FiO1JvRedtjouWBXXgwpszBv2gy876ngWg0VB+3/D
	IQhpqzpRpydKuXSCjanY1kE7pkjeVdiHf61Rpy1i40T2VTEVLX1CGynPXmUdHFc=
X-Google-Smtp-Source: AGHT+IG/D+4lV51kE6nf+1RISOvQK/tQQrWPzktPgLKIYfH6V7gZRVDpOTsPNQO9YGcb3oeKoFgoIg==
X-Received: by 2002:a17:903:258f:b0:1ed:1d37:267e with SMTP id d9443c01a7336-1eeb05919damr43288965ad.16.1715240038702;
        Thu, 09 May 2024 00:33:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcbacsm7519045ad.97.2024.05.09.00.33.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 May 2024 00:33:58 -0700 (PDT)
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
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Thu,  9 May 2024 15:32:59 +0800
Message-Id: <20240509073300.4968-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240509073300.4968-1-cuiyunhui@bytedance.com>
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
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


