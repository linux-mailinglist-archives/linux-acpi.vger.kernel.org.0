Return-Path: <linux-acpi+bounces-5054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E004A8A6155
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD861F22152
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93D17984;
	Tue, 16 Apr 2024 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="POaODImO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAC22075
	for <linux-acpi@vger.kernel.org>; Tue, 16 Apr 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237302; cv=none; b=iDiFfyjUlrsqLVNeuQx/N64MY01mgq5OGLipodkDDrtNlEsSHcIzicOy1aUxUoZQlrXVnXzb+N/ilpfdUys4iQcGOTyyofiSN57suMNNRso1vp4gqhvNOr0msr15YQJdO8jJePeuIASx4yLM/49P4aLKOEqad7JqCjO+yyF6jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237302; c=relaxed/simple;
	bh=74/j8ENughgKXArfiTJjMj2qv/FhTXWLGElJJX5xuq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7rQQtVx3cfbIEnoodpp6GQ5vCu46CGRc7LUKE5hXbiUscCo/mL5zK40Yx6wEg4yywTAxicGhVuMCTZGHVJ0W+VpZTRGhTf1/afpTqJc0gZriDHjjV1g3I6u3OSHxZj9Cx2tsTZ44UGf9JvIsblSPvR9sopdCE0lpLm4bvxnDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=POaODImO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2331bef249eso1726569fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713237300; x=1713842100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=POaODImOE0GrDhMkCrPC5b1c4UeZhlUiLUyBc69bAN153de2BSJpaBjAJsiN7gLb0+
         JpOAJSyHB+qPQxST5KrPf0UGSDMckVHBUmc9EMq06Meat5WOuD1eHDFb6Nhj9LV3Quqp
         dugLoXjofPWEz+6pmL0jqFgR94aJId6PXKfEXLezqi3n+y7LRhqXAuDurXp8v9+tYVRh
         tET2GyVPDQOhGwd+QPgkM2dnGI/+rbDTeZZa5Ebk7wa57aVZueKw5u9IXcOGeKho5qgq
         xnu+0mr4WurKgAF9GLNOL1xJgCzY9HyzAIPFeT0rlJU50k4n+YZ56rAjSfwAsdrtWrmb
         xlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237300; x=1713842100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=mScpeRvhuqNfectOnV9LSEMxtqdUqxVBW7KxiHq9r+FUYmZHiz/c95B2DmII9jYqhI
         nVOP047biMal94XXiunk+4ADPNYCO07lO9EifyDR1OAMbY4uamwjItT3BPXhCCOyRbgN
         wXgMegY7iWsnBZTl0KrcViaL73louXfvUkpE2kFyWlXlmTmQDV7t42GnUqQbsGfXWjvc
         yHrq/glqt61p1eiBq+EIvlw1uTSa1lGCOXlIMn/gEtKZ6IS2niZorOMABZsS5Gna9GnM
         us/4/F1gUZtYvqW54CSkG/CIM7tH9OG3EJLljeg2NUmdfjqBsuYK7h+pjrwfY0yeFBN6
         Z/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVTNlB6ksspbl6CWFcwbsNkCdRK094b2RBLDr154rWx/eI45h6ajbgCSiqMws5wUTb8ap51mTR1zPYfktoFHDzwC++toalE5ZAAQ==
X-Gm-Message-State: AOJu0Yzi1egt2baDLq6MKwi2zc3SaekVmE8clIRr4IXqJeYPTHn1H6nA
	7zwMCRik8IckwBQWHAANVrLqhct5D1IICAyMyyNY03KMwVmSX6klNrHiU1DRLfJ5O1fREbWpoEo
	7jf0=
X-Google-Smtp-Source: AGHT+IGHqrx1cBNmqnGC6ynZDle54CpzgsuaxouCGoQwD7AV+L407iMBlKY6fL1a8Ib2gQlJQspleg==
X-Received: by 2002:a05:6871:553:b0:22e:a970:a2ba with SMTP id t19-20020a056871055300b0022ea970a2bamr13356803oal.8.1713237300386;
        Mon, 15 Apr 2024 20:15:00 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006e6adfb8897sm7907983pfo.156.2024.04.15.20.14.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 20:15:00 -0700 (PDT)
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
Subject: [PATCH v3 3/3] RISC-V: Select ACPI PPTT drivers
Date: Tue, 16 Apr 2024 11:14:38 +0800
Message-Id: <20240416031438.7637-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240416031438.7637-1-cuiyunhui@bytedance.com>
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
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
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..5d73fcaf9136 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


