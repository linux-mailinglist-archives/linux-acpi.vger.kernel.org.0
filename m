Return-Path: <linux-acpi+bounces-18319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC4C1A06B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BF39568AF5
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA9335076;
	Wed, 29 Oct 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WTi4wd3o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F0335092
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737251; cv=none; b=XWRqNCy6cPp6hSsv9JFc1sgJVhrHh7GsPDPU9DeBrpdOLrgkh8QEIP73wlcWGvdPKc1nIvCVQAHWRWQm5dL1UmYLuqmXUgrty0AxH5PpnmLYokwRAW9tZnNGCKJgxM5G7uCT3EXhYQDd364LIDi2FFRazIWspRODiddOrzLqHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737251; c=relaxed/simple;
	bh=TSz747FjNEhM7uf1XzqCJ/IKzP85Xywzfa1M0ZRoX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTccwmaoVY0X9p1hYNXAxnKTWSfdw2xsC1cG26YYshA1uQEcOzrDUUuWWOjzU4+PGqBkLam9sFccAvGv31Dx2NS15w7D8XPehaBgj0DI7ZAwuotDCK5lJGhJI3NWz5JYO/3EWZHGEjAUk5HCnAZeMgYxqI4B+YMHVQIUnS5ft+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WTi4wd3o; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so3317450b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737249; x=1762342049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=WTi4wd3oXOxF8q1Jd84m90kQ33Jx02mWFL06AgA/izDdMv0Wgd7ehAWAQuteldL+nM
         wOVL63CdMbIZ+63TaJH08k0SPDLF1j/zbgMEYA6Lr4Carul3Vkn+vghCZEquZ5S55fba
         xpwTanLyB1ge2YZSiltHVjk27vyCC5uRhvLVg683NZTFXJ7lyfluZfS33LHyC8oMq8K3
         w53Dt570zmJTchho7PdkgUGjHk6Hc8aZ8glzvYaN9bQyV/c4NZv0deviZyX0MumrDzgX
         VHoiqlC9nVqpJ8w9rQsRx+jqdAWBljXFQ0bj0HKI1T2VyL46qR8ptlGORZfgvQfU0UqH
         N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737249; x=1762342049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=MQ+aBu+0zF66oWpnK9XZeD9o+gTokauoAU4TWEGnd7JwCV6dE6NvLyNw5/Kd+zWZ10
         Yl9DTyE7CbxyLxoJh4U6XGiya8Gwio5dNa6/yRJ1wLig2hgVxemsysPfSJb3u+CuaS/T
         B00NQS2NNgKfzZ4Gpfe/sciW29LKU9Zb/qfhEUTlEQ/5LSsNbmMIcTHiKQtM+NbwFx6S
         aH9V7pwOnZdyDrJRVitkNDjMyG6D+EQnBClepyt6bhOGzXsTtAcVSA3vpobvqhhk3i5R
         6FlQ1syIRUC2J1fFzfCGZNQrqUsnh4uqB4PZXV24ceF6ZcaHTa6uqgEIlfxlg1qyG4Y5
         NpoA==
X-Forwarded-Encrypted: i=1; AJvYcCUP5Jcqj5MpMjwtNUHH6QjX5vjza0bf7DJFypPDuCnAR7NXUUaPqlURD4ud34kdqbpYQK7M0IxSsppv@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNo5yvFDxol2AtVIMJiZMiGQJ13aqVIu66cZ4XJGOaN3kbAZj
	beXvNalWB5iGs3/w12CgyI8lk/Ml5jOHwZjTG5km34bhgYo+apRJihA6xpwF6ub0mew=
X-Gm-Gg: ASbGncupuyd8KPGf3B6YDShHELlZ2VClLk228GSGH0RMHvWUniZZRSbldB1y4iVkmbW
	bZJ2/zcxTN5nxmXGGnvJqo7aruUqLxTun3nb2S+fV87oGtqkSI1O+6b1P1N5zhCDATFykdHahVD
	xqcdSEGqWUYws9ZQdaoL9yBdhq+kZ1R4HMNdYKgtrctbZYzmjS5sbmuyui7xLPIKQQH2lVqOPrF
	AcI4Y+Wv1jHnjwxhSa0LUjkIkKh7+xos8IrG8cn85LFRyd4MEy4uSNQHlTZEnZ1sIhZTYXsuGHE
	tXkd+XeWV3AGt7loz37Z9yC94iQ0BjmLTMSmL/Bh4eEcce9ThIujekdf6vRE3C+M39FmcOGI+w2
	1JoemjHFf1Z8w9aapmEC/XSALBOb8e2HeraqrTYsQW9spQ5vOl2WIiw2g9HntEA1jVO6pSsBFP5
	oag3Lbph/BmQB1dGwNgE0aWwQ8bhKX
X-Google-Smtp-Source: AGHT+IHs9/yah7+LL8dEcqJhQQLW+XK5ngSWHXrirtA5CcwyDvBqFPLqGRdj2uDT9wLcliFabWN9TQ==
X-Received: by 2002:a05:6a20:4328:b0:341:ea4:b977 with SMTP id adf61e73a8af0-3465381d8f4mr2997177637.44.1761737249215;
        Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:28 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 29 Oct 2025 16:56:43 +0530
Message-ID: <20251029112649.3811657-6-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..f2cbd7414faf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1356,6 +1356,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1374,6 +1375,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


