Return-Path: <linux-acpi+bounces-668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E247CB2AB
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A066C2811D7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA333398E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ejddTP9L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B91286AF
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 16:50:18 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEAE1CE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:15 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57bca5b9b0aso2503026eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697475015; x=1698079815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=771urCD3ivMrGFxRwO6FF0bHhNMWlumN7WHUnj5mC2E=;
        b=ejddTP9LVNNwFngQrJ2MDm+S6rqEhAZBTy5rwQ2m0W9rGjH2ZCCFikWZ5j57O7cvkQ
         C6HibdcLOD2rMH6vyIEWjT6kEfexxPxBwFhVFTqt8QRmJK5N+d2XBgI4QDeCc+W2D179
         HPuPXbg6rspGID9EXgbjFYuWH1C/mlCHMbGGTEW/n7sej0YASa91E7TjkbFQEKFhJzVb
         6OH9GnHg/zmNLWglO/0HheXV+lmWfVmOsYfFjQZAvZkJK9p5WariVEYDQXAIuakIuGdl
         1/pYUrfMH531wx85NJEq+sARZpNhMaBa3uUpq7qY4pq5TIXnIdXnRxHE5iizYQgy02H7
         Sy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475015; x=1698079815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=771urCD3ivMrGFxRwO6FF0bHhNMWlumN7WHUnj5mC2E=;
        b=qBz9hl8ypGUonyoJ7ChPrB4XM/AgUVVKVx/7mIbMAysg/IphWT9n7u5ik8j+dufw3V
         mEjVlQkxYcWVKBBo/SzpaTaGdlKJy3T/zd25S8pWUyAunpQYKrcF7kcNgWgH+Nw75MkX
         pBek6Vf3WUSCYACeKomCtVYaLj/W+9IQOKl93QldoooY8s2XTCtoVMsDlagsfIwLe1hp
         JqNBJAZmOIgdmFfpSBQwRBcbd2g1aIVbtvq8RqFcszpv9nBkNZLyfsIy6MmgJNglPYOe
         JpGEEOhmtYsw1T61FIizZ/+frf+tV/lFtn/B0J3J+sfHlDNjN90FfUwwlkY78cc5+EMW
         DXtg==
X-Gm-Message-State: AOJu0YxCWvqRQqxIBOe0tZXViMDEoQToE3fD7kKY0vjyBQB6vaOQR6qp
	8QmSQIy15JIvbi60EpFwFVu6Lg==
X-Google-Smtp-Source: AGHT+IHj6pvcAY/EU6tBAGFPTeSDrRqJvly9AhUO9Z+1tZDpjcbVdOpa7xjrqxaz1DWdPrnVU3y4vw==
X-Received: by 2002:a05:6358:18:b0:164:a5c0:46ac with SMTP id 24-20020a056358001800b00164a5c046acmr18820773rww.21.1697475015175;
        Mon, 16 Oct 2023 09:50:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id t21-20020a056a0021d500b006b1e8f17b85sm111252pfj.201.2023.10.16.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:50:14 -0700 (PDT)
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
Subject: [PATCH v3 -next 2/3] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
Date: Mon, 16 Oct 2023 22:19:57 +0530
Message-Id: <20231016164958.1191529-3-sunilvl@ventanamicro.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
Add support to read the CMO node in RHCT to get this information.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  6 +++
 drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d5604d2073bc..7dad0cf9d701 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
+			     u32 *cboz_size, u32 *cbop_size);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -79,6 +81,10 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
+					   u32 *cbom_size, u32 *cboz_size,
+					   u32 *cbop_size) { }
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index b280b3e9c7d9..105f1aaa3fac 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 
 static struct acpi_table_header *acpi_get_rhct(void)
 {
@@ -81,3 +82,95 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 
 	return -1;
 }
+
+static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
+					  struct acpi_rhct_hart_info *hart_info,
+					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
+{
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	struct acpi_rhct_node_header *ref_node;
+	struct acpi_rhct_cmo_node *cmo_node;
+	u32 *hart_info_node_offset;
+
+	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+	for (int i = 0; i < hart_info->num_offsets; i++) {
+		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+					rhct, hart_info_node_offset[i]);
+		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
+						ref_node, size_hdr);
+			if (cbom_size && cmo_node->cbom_size <= 30) {
+				if (!*cbom_size) {
+					*cbom_size = BIT(cmo_node->cbom_size);
+				} else if (*cbom_size !=
+						BIT(cmo_node->cbom_size)) {
+					pr_warn("CBOM size is not the same across harts\n");
+				}
+			}
+
+			if (cboz_size && cmo_node->cboz_size <= 30) {
+				if (!*cboz_size) {
+					*cboz_size = BIT(cmo_node->cboz_size);
+				} else if (*cboz_size !=
+						BIT(cmo_node->cboz_size)) {
+					pr_warn("CBOZ size is not the same across harts\n");
+				}
+			}
+
+			if (cbop_size && cmo_node->cbop_size <= 30) {
+				if (!*cbop_size) {
+					*cbop_size = BIT(cmo_node->cbop_size);
+				} else if (*cbop_size !=
+						BIT(cmo_node->cbop_size)) {
+					pr_warn("CBOP size is not the same across harts\n");
+				}
+			}
+		}
+	}
+}
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory
+ */
+void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
+			     u32 *cboz_size, u32 *cbop_size)
+{
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	struct acpi_rhct_node_header *node, *end;
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_table_rhct *rhct;
+
+	if (acpi_disabled)
+		return;
+
+	if (table) {
+		rhct = (struct acpi_table_rhct *)table;
+	} else {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return;
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
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
+						      cboz_size, cbop_size);
+		}
+	}
+}
-- 
2.39.2


