Return-Path: <linux-acpi+bounces-669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC47CB2B0
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71DF1C20902
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1034189
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gQArJ88m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D2286AF
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 16:50:23 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADA35AE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c644a1845cso3244536a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697475019; x=1698079819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ0vGD2+BKy40gDZpkmDGFYSfDE+/JpanTOV3I4/UO0=;
        b=gQArJ88mZHl4FZCcgOndCz7jWFnjzhzDkmv73hirutORkdAvF/uryfkl4E7orGhVAq
         vFZVFGowdwMfpS4bbJu+2TDe/YtN+1O31HgopAffcByIEX1EKA0gJQlPQVTquhalTXJh
         8Q0cPjouu+tU6EhjLWB+9F5VzXNW9DgPqN3o6LOV+L0qj+lcoF3M7X79KHEruRIDTtTr
         qGYMPbJgcRn7/B7roaTjuThQEz0590Cx82ZgRcivNXKc9ftOMF/PU2mEdLBEfQvq+Ocw
         Y8Dt+8f8yURcAuTAPPH8DdLCVlTPOYkA5Le5TTibEcTP9p6OJVt99sgSgu4cLBdJe4pv
         iuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475019; x=1698079819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ0vGD2+BKy40gDZpkmDGFYSfDE+/JpanTOV3I4/UO0=;
        b=efRSIv6e2+wjnS/MzzXNqHxY5f8zbUudt5mXY8fLG7trtmfZhbL4I8u+zA/6PdPqZo
         OzuYOHhFfsU1Wtr6ss/2hD3OmYCmLHKemg+M2gmj5dzW8cE16Uzwrz2ZrpHffQSD8IT0
         F9v+hnwg9Jn4XO97duL89uahUY3oX8LawSORnmIdzfcy/hsGyLx/4q0f4Vc1VFlYeszS
         BglN7ykgnrqvIWMFYFRdcGOfj7taqIxYSr2T9Nm7mvcii0jcR0EwbtLe+NHrOWHPGWlY
         SJROHkAAAqyb1M+4uUl1PyzIjp89bRzMDKdkAr7IV38+VFBjyZ3En6d9Hx83SJk4NkU7
         saKg==
X-Gm-Message-State: AOJu0YxilHU1T8xQbQWdz0BId/yP/OXjrg9vWjNPwKmD1Y1q7Hc6AZto
	c1h1b0yeygcD9oQI0y4e7FluiA==
X-Google-Smtp-Source: AGHT+IHqliXUJFOJEhcrG6Kun9snmsLpe7mNtDv2ZFSs1vqugxC/0ZpQcV+6xbYVXPNJauOh7+BCtw==
X-Received: by 2002:a05:6830:4ae:b0:6c4:9ca1:f13a with SMTP id l14-20020a05683004ae00b006c49ca1f13amr35003337otd.35.1697475019591;
        Mon, 16 Oct 2023 09:50:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id t21-20020a056a0021d500b006b1e8f17b85sm111252pfj.201.2023.10.16.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:50:18 -0700 (PDT)
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
	Ard Biesheuvel <ardb@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 3/3] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
Date: Mon, 16 Oct 2023 22:19:58 +0530
Message-Id: <20231016164958.1191529-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initialize the CBO variables on ACPI based systems using information in
RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
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


