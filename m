Return-Path: <linux-acpi+bounces-733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62987CE02C
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D718A1C20C5A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9037C84
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RMQSb1h6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B4347A8
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 12:40:31 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B0E11F
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 05:40:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso3994284b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697632829; x=1698237629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2bhvVS+iGlODYrs0fN0iTmfeOWSVXnmMmj0GHdCTAk=;
        b=RMQSb1h6l1sL1msEixO2AlPtG+ceNrqLKD+J9chAAIqvWVPv7Eb751LaOTMkTCLTFP
         hJq5svk5+oR8wN2nbhnu0nEt7arFTX72RTvTK87SlgmjpVQRfS2fmddWUzHyd0GhlJIY
         +Znjd1gxhk60K1UvfOCostA82wC3oExu9kvO+64zWbpoMLa5wGJshBXNKx+t6LGtskyH
         MFAKmqp2hsxpPSHFzc2fpKl1cVicZdjN83tHjMVhyGTbG2ZP/YnqEQlYuYUYUjfKJxb6
         gZRgAZfm06S5t9XWsJi09a/6xoezJHrLpjoq3qW+FT6/Ap6FcIhszMeWUIfmTmJW315O
         oeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632829; x=1698237629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2bhvVS+iGlODYrs0fN0iTmfeOWSVXnmMmj0GHdCTAk=;
        b=NCrRANnTCc8IuG5ddE8OwE/pbOI8pTTn5F2ppaOe8oJPzp56qVD/E0PKFiUVVYR8DD
         2vt0j6arJhtaUzVHsz6X6WKIdSlstrqEf9QjTC1Uh9vVb0vPrKA9nkZ6bbBgF1kAatww
         8SEFFI/WZWYAQaoPW0jYclI6jYkeb3cg0fYgET+8kFkJtiAZ24i7iwNg6rCoNRMTgg3i
         4n4NHboHNm6jNGlgNrMuRhng+virylc6TxJ9ouLwoo3uKQjI2kCn/4gMkK5C4Q/KW/3U
         YRElMHxeL0KYUyvkgeDNSN+pnOp62WN/9f8YVTzh+YvlHOoYwkk2PKgv4p3KqdAloDjc
         5gvQ==
X-Gm-Message-State: AOJu0YxKET2xWtFdepGOpWzS6SGqZtHmR/BIMzZQhqowp+oOfHhf+652
	ZdgXtV8ayX8QaALTsP6oNzkr5g==
X-Google-Smtp-Source: AGHT+IFX5lHsddVHnrml5UqaK+P/TAYVDKZO5+Nh2aDb58jEp+tdc2ugg5iW4fHN20LrYBuh7yZ22g==
X-Received: by 2002:a05:6a21:6da8:b0:17b:4b61:a907 with SMTP id wl40-20020a056a216da800b0017b4b61a907mr1493643pzb.50.1697632829272;
        Wed, 18 Oct 2023 05:40:29 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id w190-20020a6382c7000000b005891f3af36asm1599267pgd.87.2023.10.18.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:40:28 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 -next 4/4] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
Date: Wed, 18 Oct 2023 18:10:07 +0530
Message-Id: <20231018124007.1306159-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initialize the CBO variables on ACPI based systems using information in
RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index f1387272a551..55a34f2020a8 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -3,7 +3,9 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -124,13 +126,24 @@ void __init riscv_init_cbo_blocksizes(void)
 	unsigned long cbom_hartid, cboz_hartid;
 	u32 cbom_block_size = 0, cboz_block_size = 0;
 	struct device_node *node;
+	struct acpi_table_header *rhct;
+	acpi_status status;
+
+	if (acpi_disabled) {
+		for_each_of_cpu_node(node) {
+			/* set block-size for cbom and/or cboz extension if available */
+			cbo_get_block_size(node, "riscv,cbom-block-size",
+					   &cbom_block_size, &cbom_hartid);
+			cbo_get_block_size(node, "riscv,cboz-block-size",
+					   &cboz_block_size, &cboz_hartid);
+		}
+	} else {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
 
-	for_each_of_cpu_node(node) {
-		/* set block-size for cbom and/or cboz extension if available */
-		cbo_get_block_size(node, "riscv,cbom-block-size",
-				   &cbom_block_size, &cbom_hartid);
-		cbo_get_block_size(node, "riscv,cboz-block-size",
-				   &cboz_block_size, &cboz_hartid);
+		acpi_get_cbo_block_size(rhct, &cbom_block_size, &cboz_block_size, NULL);
+		acpi_put_table((struct acpi_table_header *)rhct);
 	}
 
 	if (cbom_block_size)
-- 
2.39.2


