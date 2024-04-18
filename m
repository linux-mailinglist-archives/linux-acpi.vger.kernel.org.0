Return-Path: <linux-acpi+bounces-5135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856398A919F
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 05:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C02D1F21E47
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 03:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7B524AF;
	Thu, 18 Apr 2024 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jDGnFXiA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C150A73
	for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2024 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411858; cv=none; b=K+lXTVysGgT4qa/lEsmI0D2Z6wNGV3JtSZHLOFktPp4iLN3XQ8znHWc9Ts4Oo0sVfwHsguQvUpsGNlC7XYc+ZPixW+f8IcqjMhL/6NgfC+W2NmBZKH7zNyZkIjQyqNiswgkPL0buIZHFYm+/grJz9xv6COa30Nwm1Zl44a6v0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411858; c=relaxed/simple;
	bh=W/8ji5MqM5eWeh/ADTB3VySHgvKL73pmYr0YTKV3mAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Szc9ZW3qYCVrY2zAu8r7iRJiUitGgIhsEEIvMxyzAUFofI/VEMbdmr5wyeYewPKhFI2G0MzG43E7gXu4ip76FQkeBhZmCD8kWuuGef3YuY6UA1XOxmNzpOZXw/jc/lo5Z0v2lu9OtREOTQhgl2n3Ss2YQf9FSc4ko0J+gK09qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jDGnFXiA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so3791525ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 Apr 2024 20:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713411856; x=1714016656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV+tTK/O3Cf3pGvDZokWea7cMMg5t3YML7P6RO2qmfM=;
        b=jDGnFXiAjSIGsWMkpozT3wduiTqiyX+/2g0e/r5chl3mGBKG8UEvWNSD/dpy+mP48l
         OIJ71uB0n9nV43AkngZjTgJcQKkKFhqswcdqTtTX7lEVmn1DPQ5OrkxfRoi26D0wRZZG
         mcJByuGICFeGmw1nB5jK0Pw9pPpLURcU+jG5YHWwIsADZ1nlCOu8xu+T7cub21gfnwS+
         txJoQ+oVRb3a8qz5ta8ab0EMTR0ZLK/qHMwywkKI7upiYKQcJcxvUYn66m0cqs27OJD7
         l9crynsxN1iQ3+SDmisK7sgSrLezf1IEBwASXT6Ah54RNCGjXp44C1Q3L/Yiqfmhgvcd
         ZzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411856; x=1714016656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV+tTK/O3Cf3pGvDZokWea7cMMg5t3YML7P6RO2qmfM=;
        b=n81r0RDW1wZojgm7OS/gR9bHz8XX+HVk3fDrSSidU2t33s+BsQhB/KgZ67qsA3hjea
         v6wKb7h9Cm+qbPivjkmwVF9fgMiFh8qCg37hZOzCdWwMwH1pEzfzLpuHpuUvtqIQvQRA
         wHMfX1m13sWQUXGQLc2ugJYMEo7cpcZFMmNVyJDba3iV41D8i4DNspywXlTomuNqHqnb
         1jTgKfxj7u1yt3hFYXocRTePPuKasorvtya/NgmLX1zU/yfAyYTFdBKQIHF9wyw+evKi
         eVg8VQrDVSxoRk1VklCNXOeP1U5fEsNa7Ghn69HTqcizC9sk6YUERz+nUs4UpDZZOXjd
         /YvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAhFVZPOBoutpOI+MwxriqnMRhYopf6HtQnlYu0JdTJuGm5Pb6TCYtLbYoxlSjUJISQl1+C1x7cZdg/G0fd2n/JRDIihM88zCbA==
X-Gm-Message-State: AOJu0YzeZQXaErd/ESRp8Q+8jLg6jdbkw6VUpW1nmK5CoVnaTmYyQfEG
	SFeMMLbSP3pT9iUMU5iigEtQcuKpgvvTTS58swACfoumAxLQKxE0IRXoabNFPJM=
X-Google-Smtp-Source: AGHT+IF8Ybd8h59QRpmrLTR1zcYkAknZUw68pJcmzna4XUaXYII2l5xPSDLL6d6AFTyAFaONPu4ZYw==
X-Received: by 2002:a17:903:22c5:b0:1e3:cf2b:7151 with SMTP id y5-20020a17090322c500b001e3cf2b7151mr2011147plg.59.1713411856291;
        Wed, 17 Apr 2024 20:44:16 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170902fa4400b001e88a4ebeb2sm109880plb.152.2024.04.17.20.44.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 20:44:16 -0700 (PDT)
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
Subject: [PATCH v4 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Thu, 18 Apr 2024 11:43:29 +0800
Message-Id: <20240418034330.84721-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240418034330.84721-1-cuiyunhui@bytedance.com>
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
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
 arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..e47a1e6bd3fe 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
+#include <linux/acpi.h>
 
 static struct riscv_cacheinfo_ops *rv_cache_ops;
 
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


