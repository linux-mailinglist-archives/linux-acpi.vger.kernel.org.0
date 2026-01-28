Return-Path: <linux-acpi+bounces-20739-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMypOJ9yemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20739-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:33:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3A5A89B3
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F11C306C577
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0B3793D4;
	Wed, 28 Jan 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucbNnild"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF803793BE;
	Wed, 28 Jan 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632092; cv=none; b=aKjlj3AKOIt2BFsfDtSfNVQzuOCOMlNwBHCyEulBzGVPuHeOtS/tLDopg2yTAHCbmiLk8AwFFdjl6Qzam3c4rjGFwzQskXL67MFmQlt1c5rrRFOvkbdRR4DX+n4rMD9kZCqSTA5C/dKZKacFR8tHE7deLLGqyYi1DCfrg3DsePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632092; c=relaxed/simple;
	bh=/31EreH53ZbfLgFROUgaazBzJSVsVuqJTT5oOs7SCjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1ga4kkXUtpwyIRI5LhctQFtbRUyBt/SuGGhm6TQ7KVFdZEooMwpe3yoHEv5reoYmUl0nrWObDau2KTbwlpD2r2LYxOZHk4uu1Oo7fDfZzPZlf6hTWdQJpt3QWWIKsIjvMOZz2q64JVR9FBD0DNsMLPsalhvoPT+UibFUOZXJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucbNnild; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB782C16AAE;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632092;
	bh=/31EreH53ZbfLgFROUgaazBzJSVsVuqJTT5oOs7SCjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ucbNnildD1YQ95dVxpJ2kkQXeMWx+bA6Mc2FsARgFcVczjwggyqCOcgGWKsjXfec0
	 51D6f5QPatAMeAu9Vw6HX+6MRLWkyyK6yzpjQQlivsYVrTrYieeOmAAYjkYpC6njYK
	 K7NE0shSt3timYgnt9sBnvphGh2hQP16PqKuqTDkVV3H2wkYDF5c/dL9sHxeiHygKF
	 6QL+fgFZpGiBtC1RH0UUPAzxFv/9qe2Nje7LN9WU+3iv6g+cZCTL5ZvPakAArH+9Lp
	 9GlN8ysBJm1zNmO5ChhjFmzSnxiSs0gdkJhnT9j7aw0P+nGRKD/uKtDX9+BI2hS/q1
	 dAoFoM2VcjExQ==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:37 -0800
Subject: [PATCH RFC v2 16/17] acpi: riscv: Parse RISC-V Quality of Service
 Controller (RQSC) table
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-16-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, Rob Herring <robh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5705; i=fustini@kernel.org;
 h=from:subject:message-id; bh=/31EreH53ZbfLgFROUgaazBzJSVsVuqJTT5oOs7SCjM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQZGmc3dXWH840Dfap/on9x8wdaVnnOLfHdbrlfoZ
 HF8f8W3o5SFQYyLQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjCRfdsZGf7cnRk68dAd/agJ
 ifslzvismBv8apVhxuS3PauDbFtSvs9mZOgQt1u7wGulryvHyoVrpmtsZF2jVzO1cZL8hI91bI+
 mqnABAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20739-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D3A5A89B3
X-Rspamd-Action: no action

Add driver to parse the ACPI RISC-V Quality of Service Controller (RQSC)
table which describes the capacity and bandwidth QoS controllers in a
system. The QoS controllers implement the RISC-V Capacity and Bandwidth
Controller QoS Register Interface (CBQRI) specification.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                   |   1 +
 arch/riscv/include/asm/acpi.h |  10 ++++
 drivers/acpi/riscv/Makefile   |   2 +-
 drivers/acpi/riscv/rqsc.c     | 112 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ead357a634..e96a83dc9a02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,6 +22512,7 @@ S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos/
+F:	drivers/acpi/riscv/rqsc.c
 F:	include/linux/riscv_qos.h
 
 RISC-V RPMI AND MPXY DRIVERS
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..16c6e25eed1e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -71,6 +71,16 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+int acpi_parse_rqsc(struct acpi_table_header *table);
+#else
+static inline int acpi_parse_rqsc(struct acpi_table_header *table)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 1284a076fa88..cf0f38c93a9f 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o init.o irq.o
+obj-y					+= rhct.o rqsc.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
 obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
new file mode 100644
index 000000000000..a86ddb39fae4
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Tenstorrent
+ *	Author: Drew Fustini <fustini@kernel.org>
+ *
+ */
+
+#define pr_fmt(fmt) "ACPI: RQSC: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/riscv_qos.h>
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
+#define CBQRI_CTRL_SIZE 0x1000
+
+static struct acpi_table_rqsc *acpi_get_rqsc(void)
+{
+	static struct acpi_table_header *rqsc;
+	acpi_status status;
+
+	/*
+	 * RQSC will be used at runtime on every CPU, so we
+	 * don't need to call acpi_put_table() to release the table mapping.
+	 */
+	if (!rqsc) {
+		status = acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
+		if (ACPI_FAILURE(status)) {
+			pr_warn_once("No RQSC table found\n");
+			return NULL;
+		}
+	}
+
+	return (struct acpi_table_rqsc *)rqsc;
+}
+
+int acpi_parse_rqsc(struct acpi_table_header *table)
+{
+	struct acpi_table_rqsc *rqsc;
+	int err;
+
+	BUG_ON(acpi_disabled);
+	if (!table) {
+		rqsc = acpi_get_rqsc();
+		if (!rqsc)
+			return -ENOENT;
+	} else {
+		rqsc = (struct acpi_table_rqsc *)table;
+	}
+
+	for (int i = 0; i < rqsc->num; i++) {
+		struct cbqri_controller_info *ctrl_info;
+
+		ctrl_info = kzalloc(sizeof(*ctrl_info), GFP_KERNEL);
+		if (!ctrl_info)
+			return -ENOMEM;
+
+		ctrl_info->type = rqsc->f[i].type;
+		ctrl_info->addr = rqsc->f[i].reg[1];
+		ctrl_info->size = CBQRI_CTRL_SIZE;
+		ctrl_info->rcid_count = rqsc->f[i].rcid;
+		ctrl_info->mcid_count = rqsc->f[i].mcid;
+
+		pr_info("Found controller with type %u addr 0x%lx size  %lu rcid  %u mcid  %u",
+			ctrl_info->type, ctrl_info->addr, ctrl_info->size,
+			ctrl_info->rcid_count, ctrl_info->mcid_count);
+
+		if (ctrl_info->type == CBQRI_CONTROLLER_TYPE_CAPACITY) {
+			ctrl_info->cache.cache_id = rqsc->f[i].res.id1;
+			ctrl_info->cache.cache_level =
+				find_acpi_cache_level_from_id(ctrl_info->cache.cache_id);
+
+			struct acpi_pptt_cache *cache;
+
+			cache = find_acpi_cache_from_id(ctrl_info->cache.cache_id);
+			if (cache) {
+				ctrl_info->cache.cache_size = cache->size;
+			} else {
+				pr_warn("%s(): failed to determine size for cache id 0x%x",
+					__func__, ctrl_info->cache.cache_id);
+				ctrl_info->cache.cache_size = 0;
+			}
+
+			pr_info("Cache controller has ID 0x%x level %u size %u ",
+				ctrl_info->cache.cache_id, ctrl_info->cache.cache_level,
+				ctrl_info->cache.cache_size);
+
+			/*
+			 * For CBQRI, any cpu (technically a hart in RISC-V terms)
+			 * can access the memory-mapped registers of any CBQRI
+			 * controller in the system.
+			 */
+			err = cpumask_parse("FF", &ctrl_info->cache.cpu_mask);
+			if (err)
+				pr_err("Failed to convert cores mask string to cpumask (%d)", err);
+
+		} else if (ctrl_info->type == CBQRI_CONTROLLER_TYPE_BANDWIDTH) {
+			ctrl_info->mem.prox_dom = rqsc->f[i].res.id1;
+			pr_info("Memory controller with proximity domain %u",
+				ctrl_info->mem.prox_dom);
+		}
+
+		/* Fill the list shared with RISC-V QoS resctrl */
+		INIT_LIST_HEAD(&ctrl_info->list);
+		list_add_tail(&ctrl_info->list, &cbqri_controllers);
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */

-- 
2.43.0


