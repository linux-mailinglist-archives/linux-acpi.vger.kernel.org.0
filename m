Return-Path: <linux-acpi+bounces-4991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4A8A3FF7
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 04:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA371F21DCF
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781112E75;
	Sun, 14 Apr 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UhDvYiAq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284F17BA8
	for <linux-acpi@vger.kernel.org>; Sun, 14 Apr 2024 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063580; cv=none; b=f/2TJTyP0pDmXTqjj8hjRPu/rJcfIwdbzi/JpIpTNoNLgejP/JqNDWvY0aUk/UZTKIPhbi16AoW++lbZwGlwxWvh09v/xYVgI9WRR4St2gXStWgkGMQygm1x8p3U2f5SA0cUlzexPDe6MT0fI09NFgwBpWqAXV7UEhssytANie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063580; c=relaxed/simple;
	bh=n36euKbqIUH9mEQGupSkNUxESKc9mvK/u+joVsfYJnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvTMvu9AHQUz5fWoIT2wh4AyQfaUWH1pl+t5V7XuwLVyzrHCUPIuJKrEyGjO0ILf51vmYuaRKFUoozelniKioIWC2Owiy8aIHdUp41Ig56L5VsTOLT/Sxib4B+lOhmyehBl+6ozMQWCQlGQ9pK3vZ8rvJyYbGYH0nGrshaRTjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UhDvYiAq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4266673bbso17656435ad.2
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063578; x=1713668378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=UhDvYiAqdHYP+/0g2Q/zaRuHNN+XPG2ubNofs0VPEoHr5w62078lFkPsSVGIZPkg5/
         pYyr4H7zCuiVQ9Pxu5zp9KmJMS3/HI5BNpVsoZP9GdeNaMw9YuNzEJfLTSR6OFKncVG5
         +xlu5s0IRE9uliVo0jGnFGN08ZDENawluMoEQ/dJylgP5bTTENKzlIhcjX/y+jrLIP+W
         aEdlQsjz8GbyFNmWAempiKPvbDShVus2oUoyn2zI+kfKXrVeo22ofW6kj5zs/9C2ovLn
         k/cSBjWugBNWWjcv4Irx/gcfR4TP6/4u2YsXaxyvyRq0jMrl1Spytl4abRvmvwApCDZM
         a4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063578; x=1713668378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=YmylMD8kYj3YzOTwG8RDIUChcd9Phstg8yIMk6R7bF6GMOroJXS8D1n7B2CnHHXKNi
         FOO5TRtpqN6W/lFMo7fYwQ3bpJ62nmvWaKRUibfdCNuPd1fXf6HaSxi+KOmqL3NStlMU
         z+brw0RaumL/zj+Zh7b0RrFnBoXR+0CQ6hRBgaTATHTMLCBX/fvQcw9PFaeNEoMJqhfC
         E/u3++3adW4PMvNxCF2mid+xTzMjg4ZiQ2yjELw0Rok4gKxawKm1XjYaA42AO7Z0fvrI
         5hxyDzYoiUxDB7xV4tYeblmM+WEEpFnYLiIrTz1MgpbdEqVAkTmWhxob9nXFeHUECfqU
         QVSg==
X-Forwarded-Encrypted: i=1; AJvYcCXs95StfThq36umj8vc7MsOnRPJrrRfYXg5Ysssj/5sLpBrGwtWNVO+do2zcR7VI15h+BJkUU22CxD3RJHwW9QkgtDli4VSlpIkMw==
X-Gm-Message-State: AOJu0YyknMGuMsJoOwOSFDZKnvN3NRxpXI9RNakO6pka+ZZVky4HdW8n
	qV7XuTnhNMs8upl3N5/vBsx+hBXuG3QF1UVSDdUCapwY76YGqcyHjzTZ/BAvBcQ=
X-Google-Smtp-Source: AGHT+IG7b7aVnf3Zx6K5E292MakYH/snzrvJ2cHDzaIo1qp/4oj8mSnNTvgLFCUzjYXaXUBKeIJdDw==
X-Received: by 2002:a05:6a21:7e86:b0:1a8:2cc0:290a with SMTP id th6-20020a056a217e8600b001a82cc0290amr6050259pzc.30.1713063578513;
        Sat, 13 Apr 2024 19:59:38 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:38 -0700 (PDT)
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
Subject: [PATCH v2 1/3] riscv: cacheinfo: remove the useless parameter (node) of ci_leaf_init()
Date: Sun, 14 Apr 2024 10:58:24 +0800
Message-Id: <20240414025826.64025-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the ci_leaf_init() function body and the caller
do not use the input parameter (struct device_node *node), so remove it.

Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..30a6878287ad 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
@@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
@@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
 		if (level <= levels)
 			break;
 		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.20.1


