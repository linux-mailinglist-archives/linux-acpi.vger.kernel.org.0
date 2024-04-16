Return-Path: <linux-acpi+bounces-5052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE798A6151
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 05:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAAC282CCA
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877914F78;
	Tue, 16 Apr 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K3oBTXpQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85F4C7E
	for <linux-acpi@vger.kernel.org>; Tue, 16 Apr 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237291; cv=none; b=tzNvhHcsUEiReULx+ppC9y5QG2U/+tO8GhByPkYgeu6bPm9LqQA5skph7Nw1zRidLPrH9IGZ4au5qNFMRBtXohJCQokUHz3p5EGEQvpW3F3UbTJTfhm9ZoDWBzdD7iAImsBElevE5CweC0WmgSRfKIekLQuX5pILqsOhQ0xWP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237291; c=relaxed/simple;
	bh=n36euKbqIUH9mEQGupSkNUxESKc9mvK/u+joVsfYJnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fab85h2I4IkJZlX50ViWC/SEWvOc4W78iOOMfV44x9VQC0kaJzFfFesz+o6CzVZR/svf5DYOnGjyTLc4gc2rtW5LPLM/L3rPraTyo/zSwAsJtA9aTO4DWb8MUkvGjrMZ6eWpRdgQORy5i9QjbkWa+PZ0DvjbFLzuq2Fa6QiE+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K3oBTXpQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb77e56b20so1632862a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713237289; x=1713842089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=K3oBTXpQfnc0YOmVSJKOFzcEs/7dB2z5UafrSyOVnvD+7ZK94Cxbk9GigIxCob3g86
         uwCpP8RtRnS52Bh3wPiXd+MLB6CmEcHK5bSFdROQIjKgC/+QzduJw+YGF+EG4sSkiqBv
         R2klRdqKWI8N0W60ZFoDSjUeEtEgl1A/vj9ZjYMeXPWchGCm8cIo8KnDIsCx+G6g0dK0
         XmWBNiU9VHGE32N9S/FBxykmYGpNlxED3xSMyPuRAO+A2kLku1ZBD/W83CrbOb3awaZh
         ax/Yzs/qlBoQpOUaVt9snhrqizjV0WZsnieIC2ja97HceFY/dIQMDBejPGms0/KX+V+W
         FTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237289; x=1713842089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=NkhECqf2AqwEpOygbV5TBMYMHARphY+S4WoBh3sMnkjSBKs5jAidrHfHjejVKoHbOn
         sI9AAkFJ8bUB28R5Vq0/LOEmZ4wGZqJ+4ezXxLW81IjkY52kH/FgJkL1yLmriyau4TdN
         Cct6Pea4rUdJEb8pID7TPYrfS2zG2gZAt13MGNrxnkERLGkjEnG/M6HbQurC02wwU1Ok
         NrnROppobUPSEUAhjwBmfQnXi+Aa+OHYB6C1tJIQtNstx2LpeD9BHLRZdxtACNLDGCSJ
         0gMlF0ximN2JSHzw3SBF1T9fn7j/Yl2X/hfJw2xTZ2U2miF98s/YUQTB5lFB+VbXTdio
         Y41A==
X-Forwarded-Encrypted: i=1; AJvYcCVnXvzOCjV/QwTORsik2zyuM+jREuasKl5L58XV4HQuhSCgQHrBfUSO3DtTsHx4znSGHoEKOQ1WnBkVk4lptfXBqbbfZjzaOQaEKA==
X-Gm-Message-State: AOJu0YxdlKXc2aXv9gdNj8V3vYONqZhqJ2UO1IQ8/uxSHp/e619XbzP/
	D00lKemLAYS3f1YkOjMEqLGuaL2sM8fg7chXW0uB29cQBaAr/x0L+YKS3J/RJYk=
X-Google-Smtp-Source: AGHT+IEUEhPIFbi25ZykOAC+pbd6o9LQdaAFbDsNVQBq2JuTsulcC5uS7XAD4urvJzqQy3HPwtT6fQ==
X-Received: by 2002:a05:6870:c1cf:b0:22a:bdd7:7b3b with SMTP id i15-20020a056870c1cf00b0022abdd77b3bmr14102111oad.11.1713237288784;
        Mon, 15 Apr 2024 20:14:48 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006e6adfb8897sm7907983pfo.156.2024.04.15.20.14.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 20:14:48 -0700 (PDT)
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
Subject: [PATCH v3 1/3] riscv: cacheinfo: remove the useless parameter (node) of ci_leaf_init()
Date: Tue, 16 Apr 2024 11:14:36 +0800
Message-Id: <20240416031438.7637-1-cuiyunhui@bytedance.com>
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


