Return-Path: <linux-acpi+bounces-20737-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCQeLIhxemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20737-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFAA881C
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 500DF300CA3F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3630378D82;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDwDdAd9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC6376472;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632091; cv=none; b=pOGb2gH3okGTOpoMhHSqr5O5eSvDalFuBiczeYvkx61Gd3Dz/sEFHa+QtYm2aSIxssdxNh9Xl5JAdoCfNSzXXNJshm3YeyndY5bia/Q+T4vOpjbIFfblWgFdqqt5rGxUqEUNZbn91TWWexEjds0JjAM3VBh+JvIReucpC/Vkjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632091; c=relaxed/simple;
	bh=jn4odfUh7D9q/BnIUXd595ocfV3eTkf4xm4P7+F2KGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2wOOAYZf63eAW5KheZJDh9c/sP1/uULHO8XzYV+Wy5HZ+PX3+XfNeMqI2BEb42czYIPpDBBERJn+ggT+6bIuOUpSxzl1+G3Ocfzef6fS/3tp+gXpqapaKjfcJhPhYEPfTxeMlNrc11/mfFes+TjkeAyhKN2aDx6fOcFr2b1QgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDwDdAd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FFAC16AAE;
	Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632091;
	bh=jn4odfUh7D9q/BnIUXd595ocfV3eTkf4xm4P7+F2KGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MDwDdAd9XRRNE3fXT1SsP2N74mIyBQurX5zlQpUC8Uwy5AxUyQrSaVBKvEKbod00f
	 3hInkZQcy1YLatEB3rGECMP/1IUZQsPXikMMnz8mqBG/N4WS0dCQJ/ncBfBhARqLkK
	 v993QwZbPlgeVFVHoLdS+YkInKWyqZru//r+yWQruQdzLUZppye1iEQoeUBJpei/r8
	 l8yDTPtdKEuywf61SCIRW85jAbXeJUxY+Y+yycda8PnEqfQvOWN6SYz0cA/51FeRWf
	 TTW453sP2DeaNW4ElCPILZLVN4riIItZH/nbq2wBlp8P4qsNwoKEJ5YV2lfrua3Cw7
	 7FuCBahkxxcow==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:35 -0800
Subject: [PATCH RFC v2 14/17] include: acpi: actbl2: Add structs for RQSC
 table
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3784; i=fustini@kernel.org;
 h=from:subject:message-id; bh=jn4odfUh7D9q/BnIUXd595ocfV3eTkf4xm4P7+F2KGs=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQYuf+rF9cdUp/OLUNZB9dDmGU1v8/a8TDT4kd770
 Fs8T2hKRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAiF7Yx/E/VP/jo2DT+dXOC
 L1V5Le1/cSEtaInd38bvD4/9YGFy+JTMyHB+ZtysU13nM+xZDl1pKptxhLP42asagWTH7GXyDe8
 murAAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20737-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92BFAA881C
X-Rspamd-Action: no action

Add structs for the RQSC table which describes the properties of the
RISC-V QoS controllers (CBQRI) in the system. The table also describes
the topological arrangement of the QoS controllers and resources in the
system. The topology is expressed in terms of the location of the
resources within the system and the relation between the QoS Controller
and the resource it manages.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapter2.adoc
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 include/acpi/actbl2.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f726bce3eb84..7367990349ee 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -53,6 +53,7 @@
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_RIMT           "RIMT"	/* RISC-V IO Mapping Table */
+#define ACPI_SIG_RQSC           "RQSC"	/* RISC-V RISC-V Quality of Service Controller */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -3165,6 +3166,97 @@ enum acpi_rgrt_image_type {
 	ACPI_RGRT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/*******************************************************************************
+ *
+ * RQSC - RISC-V Quality of Service Controller
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_rqsc_fields_res {
+	u8 type;	// 1
+	u8 resv;	// 1
+	u16 length;	// 2
+	u16 flags;	// 2
+	u8 resv2;	// 1
+	u8 id_type;	// 1
+	u64 id1;	// 8
+	u32 id2;	// 4
+};
+
+struct acpi_table_rqsc_fields {
+	u8 type;	//  1
+	u8 resv;	//  1
+	u16 length;	//  2
+	u32 reg[3];	// 12
+	u32 rcid;	//  4
+	u32 mcid;	//  4
+	u16 flags;	//  2
+	u16 nres;	//  2
+	struct acpi_table_rqsc_fields_res res; // 20
+};
+
+struct acpi_table_rqsc {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num;
+	struct acpi_table_rqsc_fields f[6];
+};
+
+/* RQSC Flags */
+#define ACPI_RQSC_TIMER_CANNOT_WAKEUP_CPU       (1)
+
+/*
+ * RQSC subtables
+ */
+struct acpi_rqsc_node_header {
+	u16 type;
+	u16 length;
+	u16 revision;
+};
+
+/* Values for RQSC subtable Type above */
+enum acpi_rqsc_node_type {
+	ACPI_RQSC_NODE_TYPE_ISA_STRING = 0x0000,
+	ACPI_RQSC_NODE_TYPE_CMO = 0x0001,
+	ACPI_RQSC_NODE_TYPE_MMU = 0x0002,
+	ACPI_RQSC_NODE_TYPE_RESERVED = 0x0003,
+	ACPI_RQSC_NODE_TYPE_HART_INFO = 0xFFFF,
+};
+
+/*
+ * RQSC node specific subtables
+ */
+
+/* ISA string node structure */
+struct acpi_rqsc_isa_string {
+	u16 isa_length;
+	char isa[];
+};
+
+struct acpi_rqsc_cmo_node {
+	u8 reserved;		/* Must be zero */
+	u8 cbom_size;		/* CBOM size in powerof 2 */
+	u8 cbop_size;		/* CBOP size in powerof 2 */
+	u8 cboz_size;		/* CBOZ size in powerof 2 */
+};
+
+struct acpi_rqsc_mmu_node {
+	u8 reserved;		/* Must be zero */
+	u8 mmu_type;		/* Virtual Address Scheme */
+};
+
+enum acpi_rqsc_mmu_type {
+	ACPI_RQSC_MMU_TYPE_SV39 = 0,
+	ACPI_RQSC_MMU_TYPE_SV48 = 1,
+	ACPI__MMU_TYPE_SV57 = 2
+};
+
+/* Hart Info node structure */
+struct acpi_rqsc_hart_info {
+	u16 num_offsets;
+	u32 uid;		/* ACPI processor UID */
+};
+
 /*******************************************************************************
  *
  * RHCT - RISC-V Hart Capabilities Table

-- 
2.43.0


