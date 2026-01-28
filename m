Return-Path: <linux-acpi+bounces-20728-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFuPCQlyemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20728-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:31:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E11A88EA
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E18430602F4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458A376470;
	Wed, 28 Jan 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuu7ZLVJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570937647B;
	Wed, 28 Jan 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632086; cv=none; b=WRi8ovSR/d6yuae07n7l/2/gzpo489LiKwYyfVK7QKMHb4OCqYeojstfFLLSQAbZYpLZxOXU9ntPV7EIjU9DXdWYSA3rDn79xsGqjSBTQ1wZsKM+DaRipKlfR/bz70/7hVQhnxS1+aWnOnLus6s0vKdHoikPWvk9pXCHPvm3DRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632086; c=relaxed/simple;
	bh=uuacy5TWBWCqGEovDfg1uYj/N0C7aRhzBOjqrPUPGZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqAMv1t/paPAEbPAzwV+16QBzYGwaa/tNiPGZ9LanoT+p5srNozK79mRS5up/Pi3AbEF80ZoEOYZHOtxNsQV7IEe4Ix+PhSzOit39BV5ZNsnIpVtdYWC7XxSj1MDavJt3dydyKgy5+Q9JlfkhsmTm3pa78txxRo2v8cGJnNxT2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuu7ZLVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68251C4CEF7;
	Wed, 28 Jan 2026 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632085;
	bh=uuacy5TWBWCqGEovDfg1uYj/N0C7aRhzBOjqrPUPGZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cuu7ZLVJx0gAzesWP4IDGrHlRXyqQrUU3YixYnv3MC5zLnNPDIxy56Z3WUd+GYJGZ
	 37bW/dN8Hg8BLsvrPtvuV+qeA8VYNQtI23k3Nb8AB1VA4DTDuptQU8GKXi+laiKnoE
	 rY07evMIMWYNs0oEL+s+DB7p+FHW7Jwl9k6evZvlAajvMFiiN6wWQgzs2H+ePBIhVU
	 ck2JSWcWrcw89q+4jI9q0QC8sdCZ7VPHtAb2prmwASOoTQXPQ8DyyQnVQP6WIBFVwM
	 g3RhVeKqNfC5aAi8d6/2r/iTMc8SvtCsj37uO2m8T8zZl/oMEfladXnfg5/ecKC2C2
	 KqVHJqVoum1DQ==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:26 -0800
Subject: [PATCH RFC v2 05/17] RISC-V: QoS: define CBQRI capacity and
 bandwidth capabilities
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712; i=fustini@kernel.org;
 h=from:subject:message-id; bh=uuacy5TWBWCqGEovDfg1uYj/N0C7aRhzBOjqrPUPGZE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQYobQy54nbak+F10tT+lae+cUrN6c4t9FE60iv55
 9jzZVvnd5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmEvCfkeGV0Z0j3a9ZmpQP
 na3VkK95pWS9f2Z6lm3MmZSS8mnWmQsY/nvsX7vaQzvSYWMWXw3nwwc94hMmfomZyzK3ctPkvYf
 PyrIAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20728-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99E11A88EA
X-Rspamd-Action: no action

Define data structures to store the capacity and bandwidth capabilities
that are discovered for a CBQRI-capable controller.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/kernel/qos/internal.h | 128 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
new file mode 100644
index 000000000000..ff2c7eff50be
--- /dev/null
+++ b/arch/riscv/kernel/qos/internal.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_QOS_INTERNAL_H
+#define _ASM_RISCV_QOS_INTERNAL_H
+
+#include <linux/resctrl.h>
+
+#define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_MON_CTL_OFF      8
+#define CBQRI_CC_MON_CTL_VAL_OFF 16
+#define CBQRI_CC_ALLOC_CTL_OFF   24
+#define CBQRI_CC_BLOCK_MASK_OFF  32
+
+#define CBQRI_BC_CAPABILITIES_OFF 0
+#define CBQRI_BC_MON_CTL_OFF      8
+#define CBQRI_BC_MON_CTR_VAL_OFF 16
+#define CBQRI_BC_ALLOC_CTL_OFF   24
+#define CBQRI_BC_BW_ALLOC_OFF    32
+
+#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_CC_CAPABILITIES_FRCID_MASK   0x1
+#define CBQRI_CC_CAPABILITIES_FRCID_SHIFT  24
+
+#define CBQRI_CC_CAPABILITIES_NCBLKS_SHIFT 8
+#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK  0xFFFF
+
+#define CBQRI_BC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_SHIFT 8
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_MASK  0xFFFF
+#define CBQRI_BC_CAPABILITIES_MRBWB_SHIFT   32
+#define CBQRI_BC_CAPABILITIES_MRBWB_MASK    0xFFFF
+
+#define CBQRI_CONTROL_REGISTERS_BUSY_SHIFT   39
+#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    0x01
+#define CBQRI_CONTROL_REGISTERS_STATUS_SHIFT 32
+#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  0x7F
+#define CBQRI_CONTROL_REGISTERS_OP_SHIFT     0
+#define CBQRI_CONTROL_REGISTERS_OP_MASK      0x1F
+#define CBQRI_CONTROL_REGISTERS_AT_SHIFT     5
+#define CBQRI_CONTROL_REGISTERS_AT_MASK      0x07
+#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
+#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
+#define CBQRI_CONTROL_REGISTERS_RCID_SHIFT   8
+#define CBQRI_CONTROL_REGISTERS_RCID_MASK    0xFFF
+#define CBQRI_CONTROL_REGISTERS_RBWB_SHIFT   0
+#define CBQRI_CONTROL_REGISTERS_RBWB_MASK    0xFFFF
+
+#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_CC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_CC_ALLOC_CTL_OP_FLUSH_RCID   3
+#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_BC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
+
+/* Capacity Controller hardware capabilities */
+struct riscv_cbqri_capacity_caps {
+	u16 ncblks; /* number of capacity blocks */
+	u16 cache_level;
+	u32 blk_size;
+
+	bool supports_alloc_at_data;
+	bool supports_alloc_at_code;
+
+	bool supports_alloc_op_config_limit;
+	bool supports_alloc_op_read_limit;
+	bool supports_alloc_op_flush_rcid;
+
+	bool supports_mon_at_data;
+	bool supports_mon_at_code;
+
+	bool supports_mon_op_config_event;
+	bool supports_mon_op_read_counter;
+
+	bool supports_mon_evt_id_none;
+	bool supports_mon_evt_id_occupancy;
+};
+
+/* Bandwidth Controller hardware capabilities */
+struct riscv_cbqri_bandwidth_caps {
+	u16 nbwblks; /* number of bandwidth blocks */
+	u16 mrbwb;   /* max reserved bw blocks */
+
+	bool supports_alloc_at_data;
+	bool supports_alloc_at_code;
+
+	bool supports_alloc_op_config_limit;
+	bool supports_alloc_op_read_limit;
+
+	bool supports_mon_at_data;
+	bool supports_mon_at_code;
+
+	bool supports_mon_op_config_event;
+	bool supports_mon_op_read_counter;
+
+	bool supports_mon_evt_id_none;
+	bool supports_mon_evt_id_rdwr_count;
+	bool supports_mon_evt_id_rdonly_count;
+	bool supports_mon_evt_id_wronly_count;
+};
+
+struct cbqri_controller {
+	struct cbqri_controller_info *ctrl_info;
+	void __iomem *base;
+
+	int ver_major;
+	int ver_minor;
+
+	struct riscv_cbqri_bandwidth_caps bc;
+	struct riscv_cbqri_capacity_caps cc;
+
+	bool alloc_capable;
+	bool mon_capable;
+};
+
+#endif /* _ASM_RISCV_QOS_INTERNAL_H */

-- 
2.43.0


