Return-Path: <linux-acpi+bounces-20729-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODm3HSJyemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20729-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:31:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD2A8901
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF7E3097FC3
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C15376BC7;
	Wed, 28 Jan 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyoMgQ1P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6E374187;
	Wed, 28 Jan 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632086; cv=none; b=MR+Nh60g5xb8OF/6ebpq7yDidT+PwZYRJ/w4RbnKHyHNbLBykA3hql3CYZCvyXB/0LlglqWUaMg7XCHsNP2ohje8HGGz4IE00g0NlAHT2bPaJz8YpAZm5ayMoDYcE5N1nn9n+fz1vax8XLwpOtHzXGJhOhEOcVMDRvMrwDujK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632086; c=relaxed/simple;
	bh=nRtrIHSuWEDHEeDXLCrpmYAAH9Hp3uZpgjylkcnSlpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKTmyosd/Qs4ufVM8wkqKO6Tybn7UR3LcPs73ytZs0/eqh8poVKssG5hSexYt77vINm+HVShEgyTCsHJafjWMf7BrNsOtQksJJmUDckzsP81DQOp/YvA9OJ93hNenS1KCcf9ZJoJuR5+7iOo8/d80BqLjevTSYejzTx+oV1TuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyoMgQ1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B31DC2BCAF;
	Wed, 28 Jan 2026 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632086;
	bh=nRtrIHSuWEDHEeDXLCrpmYAAH9Hp3uZpgjylkcnSlpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QyoMgQ1PlpsL25i4MmYfj4pTfftDnw7v3FsxFrm0jEker86I3vX4LLM3Vfp5/3oX2
	 0CNeldeXnjcgDuhembANRxNc0zAi7xPH2f7N0zKk9Ql/qiff+RbvLIyJspncWrBJO6
	 gSg1zmnP5UtM7ZF2EVg5Bw3fmIeQZZSpqWOcst/dkdR32o/2GF72e7Z3VR6xOjowhI
	 X4SNGkZm/4G4g0pf9+V7X0VNFnul2tCcpiK7MwzdyfGDpNYwnSNAle1sxZ3UL/qCGJ
	 MPtURsWZmNvZY7R0JKskU0HYVIUF+LxDzIU+i3GXfI39kDlCd0Ue6jqQ5jtJxFC9YJ
	 gFTNMoLDM+uyA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:27 -0800
Subject: [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl resources
 and domains
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=fustini@kernel.org;
 h=from:subject:message-id; bh=nRtrIHSuWEDHEeDXLCrpmYAAH9Hp3uZpgjylkcnSlpU=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQZcWOafc1mIUyQrfPft57MCLq6xf8c35WlDxxZ/h
 trtfz886ShlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZFsMw2+2eX9Mbvuknzs9
 +9bmf3fmG1k9iFq368zirCNn7MIYrle0MTIszUg6Kj236ZH6fPNX17YwnmDmXZb4seOg0E0T+23
 drwOZAA==
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
	TAGGED_FROM(0.00)[bounces-20729-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0DD2A8901
X-Rspamd-Action: no action

Define data structures to encapsulate the resctrl resource
and domain structures.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
[fustini: rebased current upstream]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
index ff2c7eff50be..c0402dd06cfa 100644
--- a/arch/riscv/kernel/qos/internal.h
+++ b/arch/riscv/kernel/qos/internal.h
@@ -65,6 +65,11 @@
 #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
 #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
 
+int qos_resctrl_setup(void);
+void qos_resctrl_exit(void);
+int qos_resctrl_online_cpu(unsigned int cpu);
+int qos_resctrl_offline_cpu(unsigned int cpu);
+
 /* Capacity Controller hardware capabilities */
 struct riscv_cbqri_capacity_caps {
 	u16 ncblks; /* number of capacity blocks */
@@ -125,4 +130,26 @@ struct cbqri_controller {
 	bool mon_capable;
 };
 
+struct cbqri_resctrl_res {
+	struct rdt_resource     resctrl_res;
+	struct cbqri_controller controller;
+	u32 max_rcid;
+	u32 max_mcid;
+};
+
+struct cbqri_resctrl_dom {
+	struct rdt_domain_hdr       resctrl_dom_hdr;
+	struct rdt_ctrl_domain  resctrl_ctrl_dom;
+	struct rdt_mon_domain   resctrl_mon_dom;
+	u64 cbm;
+	u64 rbwb;
+	u64 *ctrl_val;
+	struct cbqri_controller *hw_ctrl;
+};
+
+struct cbqri_config {
+	u64 cbm; /* capacity block mask */
+	u64 rbwb; /* reserved bandwidth blocks */
+};
+
 #endif /* _ASM_RISCV_QOS_INTERNAL_H */

-- 
2.43.0


