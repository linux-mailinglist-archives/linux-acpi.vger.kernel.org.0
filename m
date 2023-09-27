Return-Path: <linux-acpi+bounces-239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BD7B0C04
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7008F281642
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578791A58D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D947357
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 17:00:35 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7975F9
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69101022969so10432554b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834033; x=1696438833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9sLv+V8gGTdOjGyr5tjbv9gRJE2ViFoNFxWNgg6Hz8=;
        b=ImEM1Z7qQWJ9pWvjGfmPTZ6MedwTOlrrGPtiX5vsmQ3sUZ7MJxNJfy0baVKQiTMuZl
         n/sixhJG7Bna30gD0zlbk4h+NX5oTGDQedW9KHdC+WhNtxs9q0WlpdMBXlkFGbAl8zUU
         jEaelMhEX430FdiP0oWUkku+aI4HWNpzlt9xfMRC3Ck5/e1yPtPbbTyo6PDpn66S04KG
         2xfbey3SI0sMFsVbY7xEyQCz75FwnVeIL05esfhexrsbdU9pdpfu5A8V33YkVVfUF/vY
         bRdnxr0SYls53DcWGj/ghuNSKzPmgkuCaw9bA0vna1E6gttCE/gvsAkoj/B7HLtwufqt
         qy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834033; x=1696438833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9sLv+V8gGTdOjGyr5tjbv9gRJE2ViFoNFxWNgg6Hz8=;
        b=rx9rozzqfU7U4HQjK2YtOCvNE3+iinBVXZrydyS5x4FECwQt0ES9iNTCQJnTJD5DY9
         fjs8A4r5sMK7j7tryj47uz56MOm1/E+1iUo14bLlrdYMYDR1jTdLWUSPxXrz0iR/atBn
         psIzVtxZr1UtLX0rhucWPxG8yRs937Owut5SMUMNaMoKRKjatpW8J1dPOcndNajtFp/h
         OtSgRM0JVUkp/9B677hjtz9fPkNV+afj24pcywe3gmMce2FvIv5E4d7sq7bLjRcJVDBm
         pie3JQJgpIwf5hX/IbeY60t7G3eVy41+PRbyBeqXhJmmOILTwkvwex/65tHeoXgqLR2Q
         wxgg==
X-Gm-Message-State: AOJu0Yz9zkAZF1EDFdJ1OkL5IqCKtqtMPS8G9waA+U/4bWs68L5NXcv/
	0ySmfTswsmxlJY7caVUBu1gtJg==
X-Google-Smtp-Source: AGHT+IEa6asAbG8e1D9Wtlofxs/aqoo7qS7D0/bHcFiviEGPFGXQU+G/6kse8wYhSvo9I9okP5V4Sw==
X-Received: by 2002:a05:6a20:7d95:b0:14c:daa9:5e22 with SMTP id v21-20020a056a207d9500b0014cdaa95e22mr2978244pzj.45.1695834033151;
        Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:32 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 2/4] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
Date: Wed, 27 Sep 2023 22:30:13 +0530
Message-Id: <20230927170015.295232-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927170015.295232-1-sunilvl@ventanamicro.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
Add support to read the CMO node in RHCT to get this information.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  9 +++++
 drivers/acpi/riscv/rhct.c     | 72 ++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d5604d2073bc..0c4e8b35103e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u32 *cbom_size,
+			    u32 *cboz_size, u32 *cbop_size);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -79,6 +81,13 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline int acpi_get_cbo_block_size(struct acpi_table_header *table,
+					  unsigned int cpu, u32 *cbom_size,
+					  u32 *cboz_size, u32 *cbop_size)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index b280b3e9c7d9..9042949277f8 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 
 static struct acpi_table_header *acpi_get_rhct(void)
 {
@@ -56,7 +57,6 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	}
 
 	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
-
 	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
 	     node < end;
 	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
@@ -81,3 +81,73 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 
 	return -1;
 }
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory
+ */
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu,
+			    u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_cmo_node *cmo_node;
+	struct acpi_table_rhct *rhct;
+	u32 *hart_info_node_offset;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+	BUG_ON(acpi_disabled);
+
+	if (table) {
+		rhct = (struct acpi_table_rhct *)table;
+	} else {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return -ENOENT;
+	}
+
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (acpi_cpu_id != hart_info->uid)
+				continue;
+
+			for (int i = 0; i < hart_info->num_offsets; i++) {
+				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+							rhct, hart_info_node_offset[i]);
+				if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+					cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
+								ref_node, size_hdr);
+					if (cbom_size && cmo_node->cbom_size <= 30)
+						*cbom_size = BIT(cmo_node->cbom_size);
+
+					if (cboz_size && cmo_node->cboz_size <= 30)
+						*cboz_size = BIT(cmo_node->cboz_size);
+
+					if (cbop_size && cmo_node->cbop_size <= 30)
+						*cbop_size = BIT(cmo_node->cbop_size);
+
+					return 0;
+				}
+			}
+		}
+	}
+
+	if (cbom_size)
+		*cbom_size = 0;
+
+	if (cboz_size)
+		*cboz_size = 0;
+
+	if (cbop_size)
+		*cbop_size = 0;
+
+	return -ENOENT;
+}
-- 
2.39.2


