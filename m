Return-Path: <linux-acpi+bounces-6447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41DB90AED2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A21B2890F2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEAF19884B;
	Mon, 17 Jun 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="APqNQZsQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C60197A9E
	for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630087; cv=none; b=uhsuRY4O063wxbqoStKLFQHrF7lNFvzBo7Zt34knRMOyZDShaZAYcwn404En1CI1yErSH7FxvYebUCWIFK/pdvxIXtO4vw001GJ/SPJYr8g2jfCDBH15/oUFWuVKEY4Hn+mjrJMQk9swtMBDOxrRctVjqN8GYb8fUggVdGThhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630087; c=relaxed/simple;
	bh=OCESIZEsN6lzcI6fYlcJjhkKfQLZHYvy2cJISU/VEiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp5skGNm4JaTb6QNwTDAIjkzgg8PQChShRFXGHuBy7K+jchqYGSVRWZJNZYHEa3Zz7ktoAcxL/62PkyEMZfcMUJm4I7z/99drVsuPohTRzL/OnYiaiD/+n2w+RIzmUKc04AE+NuCxK6a6rryFsLBYj4nTbf8Z6GMMCkLFpuU91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=APqNQZsQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7041e39a5beso3168250b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718630085; x=1719234885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqH5PnYnV4OCHciC6unnqcv3QJd6vOkUagh67OcQSZo=;
        b=APqNQZsQWZBAkMN6ajq9Lnefzr38sgZdKH9AZnIzsdeNhZfXlEv246aIx3yB1Jy3as
         oSrgO35J1tuEH5mteCnb7WjVSvqFKXhx2B8W4uVpZIp3sOD8e6w87lcKwF1+tuWLpQX2
         W10FfnFBMF026aOYa0shuHZosG8JUE6FNjqq8yjDYGULmn4rTstMIsM0CX1qMnXj6C4X
         zunyUNmQ63/Su+8iHrgA4QhZ5PIqx3N4qS2p1Rb8+NCGBjvcXyuCWlBvxWi7sZyLu1sb
         JUNi6k7tHhK5/OGiwYeJchb67Me4W3EyRvx0La5Z2bvA/ngoQqor1cQuMtPr9hzRkLj1
         CjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630085; x=1719234885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqH5PnYnV4OCHciC6unnqcv3QJd6vOkUagh67OcQSZo=;
        b=APM9+bXCaA8L2CkMFjU6on4wcqtYMRU+LmfcxwobfuJV0oJ5Vc7hCIuW/p5cvG7ncI
         MhZJ1gDz948kD+Q6eIOgIR9aP+mwys9IJQsLfvwDxy8G8AzI8ljsjJ55+q7b1TqrbUab
         N+HgQX1JmjLTJBSVN4njUiL6Fjz2TAs7+dAe1JJXdsQ/Om1eiC0W/pTD5PsoKLH7ualZ
         1I4UdnJVuhVA1lgu0lB431ig4dyOtX1nqfYs9MJMrM84iX9fX9qtGfmHleEylGaspfCF
         xVbD/4JwCTryHbOYN8CnjNiTKIIPsbF3QtJYgJb1TGmwyEj4jdtQQnc7o4DSVFBr5YFJ
         UD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwqJ7wQDA0Cid4NImQA0yumNgdxrRPx0yzAl5Uw18DWDQ1bMOq1QcOo49p1/8SohJgmVk4MAZCUFCvonYkmyVofxu9icHnfJ3imQ==
X-Gm-Message-State: AOJu0YxKUu5N4CijtVjjuVUSPfM8cBxbyTrLY98/TabcTsFCUec6yJTY
	RSjUAy8wwmvjFAQejAK41yNyJslnHp5Sns7p1Xqynw0CuSLd1gAHMt5sJCAVdZ4=
X-Google-Smtp-Source: AGHT+IHUp84UpJvFEPcFIvQ17kOX+r6zqro+izswgYoYp+hs6jkxCQlxN7m1kXBF5qblIw630FU0lw==
X-Received: by 2002:a05:6a20:3caa:b0:1b2:b2b:5698 with SMTP id adf61e73a8af0-1bae8243b5fmr9208865637.33.1718630085193;
        Mon, 17 Jun 2024 06:14:45 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm78801785ad.200.2024.06.17.06.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 06:14:44 -0700 (PDT)
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
Subject: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
Date: Mon, 17 Jun 2024 21:14:25 +0800
Message-Id: <20240617131425.7526-3-cuiyunhui@bytedance.com>
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

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9f38a5ecbee3..1b4c310a59fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
-- 
2.20.1


