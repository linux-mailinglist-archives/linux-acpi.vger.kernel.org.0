Return-Path: <linux-acpi+bounces-14120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F8ACD5A6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 04:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203DF17A6A3
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 02:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52792139CE3;
	Wed,  4 Jun 2025 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BLo2BSJP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325E1BC4E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Jun 2025 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004272; cv=none; b=px26bgbM3IHLs/o6VY2ZtrA8bU7v8WVyMGrUzWyXdVVU+SS+uL2PkIh0cv3WL7e5KcNJeywjxSITrXdPlvsno9E/Ygr66KseY9NApqBi293/NFt8MjEXCMsQXZONCJ/SzMgyH+cSs26yOM4aaLYkG1u4Qq0D3WX6Vopb64gXDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004272; c=relaxed/simple;
	bh=k8xgcrym5qDtX84bQ8gtzxF7cH5SzBupbkfxITaTvZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFqWgUA3hQAOuU21ySoiCqPgxnKW2j+gsEwYB35oN1mawqMjYz+kkVNeY7/HTfUn5wSQSdaICbfUAdjXKGq6dkASnIx3iGr4lz/GTmj9wQ7Um0mytyCrmdAXewJlyI6pcFzfM8FNUZyyPYAt0WJY47juZqut630AT6JEU6Z2S8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BLo2BSJP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5326922b3a.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jun 2025 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749004269; x=1749609069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzx5EhyNYQwHeWkDzz8IdLJSsRXErPCykhPMATKhuXU=;
        b=BLo2BSJP0+xYQtpurYSZh5SKKU9jzGN52ZuByGD+RBLm5OCo6MCAAHtCx2Cy0BVpj6
         z6TyiOdo+G7beCAwE0qeOQXp3fxTWvN1u+ZD+ZIBRVNo1Y/uaz8bsEqqYyIB7qLCusz1
         mWodwYn7AX1b+a0FG/nmDELXj88/YaE2jPxuiHVRdQBHOXqEEReAMUmHsrBfWKgRmTD2
         LzbnvJZOdpo1faC6cmoshNIJHROt09nY8zGRPT7Hla/oFtTcSapztlVdL/gxoACLK9py
         7BPXcVBNe7m23pQUT2UOyVqSFWk307cOM4PrqAQk/XHvasSObZ+8zrrOxERMZXU98lWb
         r3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749004269; x=1749609069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nzx5EhyNYQwHeWkDzz8IdLJSsRXErPCykhPMATKhuXU=;
        b=mW0Tkd9WMME/L5nEy2FHd0ckNVSU0j/RSVlQTKVX2YWkdBPr6RcRQz54HuxkPPsZqP
         TpQaZJXdXh1cqNN9jdBubW6x8WEo5z8VOdm/MCCQS7BG+OW2p2rH64zFkMPUydllY68K
         5dnSOaBrh+PNFr+gK9rtOUSVXDOotr6vtfDeB/Lq+Rzzk79+070+i2jMYbDPxR2de146
         iL/30U22f5SoYSPI1GR+k7KgW5QOywfIy1QX4DH9a8+ddPIk7p5Qx3XfrdwQslleRS2M
         8BZmZPI5rOxcYDd5yDo+xNskHRr4gxmy+uAD1/hC8rGuL09zMhjlfDfD+cP7dVLB+Zw5
         GhbA==
X-Forwarded-Encrypted: i=1; AJvYcCXHDkX+DMN1gaX8PyuM7o9KWLnQC0O1+P7lQWWF52RdND49ocQG/4hZQLOUxEvYLU+se+DTdfrhwXkH@vger.kernel.org
X-Gm-Message-State: AOJu0YxykujAsbIF/c+Z5t97C3QPDa5SDegneE1Kde0gMfHlHSV4GHBA
	Ppic7qq4h0y1mobf0zT2F8VVhP8GiQTFyBzFaPk0t26kMY++pg7jkMPqeajYgTLCAZ8=
X-Gm-Gg: ASbGncvByZLtkMptfPaJdgcgt6BVq4nEietACk0cDxKNVQkOEPsSvUUv11VYVvwj6cq
	y+S4H6K2IuI38ZEGkOR4h7NFbwfy7Tw6BmXQjE8GEPpn6awuhD8Znu/cWi1i3CcvH6TWbfqM9+s
	nOEtO3Iz2/QfatKWt4ajkL1LrYnndxQsco7kLylHwAl0Ugq4KdhBhv+ZY9pb7HJDpjVEgGfGK2u
	hhcwZkzlw+Ulr0ax63UOy+gNQ0d0NkAK1zAU86+hYCza424X/JQL4zK9rDK43PkDdTiilutrd/N
	knS7J5d2GKTOpuv6HYphCdt5jm8mTmIuWpt6I8N2WkXA+0to4X1GwahJRHdmUMNi9HwJt5rEsQs
	n1kn+lOLHbQ==
X-Google-Smtp-Source: AGHT+IFOKXiUkg7DlGRUfdahAUAzm5CSAm5gLh6cesXxENqVYTXs/ggCdQWKGgbEMqM7qu6iI5d4xw==
X-Received: by 2002:a05:6a20:1594:b0:1f5:7873:304f with SMTP id adf61e73a8af0-21d22bb720fmr1601124637.37.1749004268701;
        Tue, 03 Jun 2025 19:31:08 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb0a1eesm6739256a12.14.2025.06.03.19.31.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Jun 2025 19:31:08 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	Pierre.Gondois@arm.com,
	viresh.kumar@linaro.org,
	sudeep.holla@arm.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] ACPI: CPPC: Fix panic caused by NULL pointer dereference
Date: Wed,  4 Jun 2025 10:30:36 +0800
Message-Id: <20250604023036.99553-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With nosmp in cmdline, other CPUs are not brought up, leaving
their cpc_desc_ptr NULL. CPU0's iteration via for_each_possible_cpu()
dereferences these NULL pointers, causing panic.

Panic backtrace:

[    0.401123] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
...
[    0.403255] [<ffffffff809a5818>] cppc_allow_fast_switch+0x6a/0xd4
...
Kernel panic - not syncing: Attempted to kill init!

Fixes: 3cc30dd00a58 ("cpufreq: CPPC: Enable fast_switch")
Reported-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a9ae2fd628630..6b649031808f8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -476,7 +476,7 @@ bool cppc_allow_fast_switch(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
 		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
-- 
2.39.5


