Return-Path: <linux-acpi+bounces-6445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB91F90AECD
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C1DB276B5
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92ED19755E;
	Mon, 17 Jun 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b5TzQBVo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20997195985
	for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630076; cv=none; b=gAN7GdoYiBcsQDbnaouzAfhAj2LC6E4IWKR4hEIYZSJSYPbcCWKM6uIh5I0t60c/hVhoxEdsb7bFj+dMLacJAlOHEohQtzy4dj3BgucZXipjJrbbhXc8s7cjQKOVtFFO+nJorgYatpbYbWUsL3FnuQ0K1s+fEWjw8DZP6BjuGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630076; c=relaxed/simple;
	bh=f1DDzJv3xHeLtz/8Uh38H6uqD2mqnmTd8LGL7fsQk2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnnuySVYiaJkQ+jP+U/wemNsAyRqX5uhD/WPQYtuQgJ2+DQwjFjfiJmiFzxwY5Hpm63i483w8ibZf0Am/jJ66C9cvaWmpJGWem7I6fLGJWfq/69qJAQ0IXVSclNyAtXInIGJ0j7FeEJGymLFHS9mFRwTn9WtOSNrrDXQiDQiwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b5TzQBVo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f65a3abd01so37563115ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718630074; x=1719234874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=b5TzQBVof+D7ozqzsldxhUi+UlO8wz63mvtDIHt7ZOyrANkb3Jt/1cJFe9lw3yRAsg
         zfIx7E1VXmeSpIa//3xZ3bzRO7xjchhBhWHlgdv8JjT1vXuUARmgZ8NyfV5i2nGioha5
         k/AJSlszpZQWW+x+QD/qX/kWBgMpfFxzrP+39MmYwQEB+Hjrc8RoG5Lc7VIwO867L22C
         z2OUSyifBCYrIDDkcAolReyRSww9UwbwRfqX3bLsbPpVesVDULoZxD9TU2cCnaj6Nkkf
         LNRmZPWGD5+1L/VUFPGiuggrJ6fIXy3o2NbVy9ZrHxW+Aj6s0YKFX3fle79OWnpdSyYq
         X0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630074; x=1719234874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=hdNzVh7U1DvjZFvePlMwj9Utz73U5Dfg1TIlZEoVIXNA1W81iIupXJUi/RykBTQ3QV
         gAaCIw4y9NyFwgcV9/WPEV3wEjrGWMSUnBa+B4YqMviWSksxnkOCzTqWXLo1jqlrg2P2
         bg/CAZlFv1uOu1x5eTSngHTrVLC5FvDkAKtLiG6DDLJ5vZWYG0uW2qAs9e6vx/MAB7Uc
         hPy4YsWhl+ZhdbcP12BgDY1wv3+Srln+b4q4NsS6VCmJjdGTccjO6l6BPd6TfSCJjhvY
         VABAaQxpXjRP3pWR2FLMS7nvy+F2npJsLfKQisjd8ALTEv0+rRCg/GiwOULkhyJU4Ixx
         2KZA==
X-Forwarded-Encrypted: i=1; AJvYcCVTLubWwuucQJmn1qivNleSSlvpSzB/et53iVlTfluzyZEcS8afkPuSkcTbyClYGXbrv+v21pEpAZD+hRuy07bT1rKII1Cy/7DJKw==
X-Gm-Message-State: AOJu0YwEIEFRYoW/Oiz38QxVBttfAby1prIMHcoaY0gHG2L3FfRXpotO
	5rLTXKX11SJTe0uMWMmglOpD+YX1BVXXwrqCqusIRQ0JcQ+ywyQuXD+ZNcCM0ng=
X-Google-Smtp-Source: AGHT+IHD4rO7F/Egqxpgx8GA7LvUPhaTN7BCgz2f2PAN52kUoSotiU50nIDGx9zF+6fxgOrcqL1j1g==
X-Received: by 2002:a17:902:da83:b0:1f4:b18a:3f25 with SMTP id d9443c01a7336-1f8629fee64mr128841735ad.60.1718630074305;
        Mon, 17 Jun 2024 06:14:34 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm78801785ad.200.2024.06.17.06.14.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 06:14:34 -0700 (PDT)
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
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v6 1/3] riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
Date: Mon, 17 Jun 2024 21:14:23 +0800
Message-Id: <20240617131425.7526-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ci_leaf_init() is a declared static function. The implementation of the
function body and the caller do not use the parameter (struct device_node
*node) input parameter, so remove it.

Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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


