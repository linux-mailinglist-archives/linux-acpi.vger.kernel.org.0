Return-Path: <linux-acpi+bounces-20727-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNoyNG5xemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20727-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BEA87F6
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16E313025E4A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228F37646B;
	Wed, 28 Jan 2026 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCoi2aWY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8037475F;
	Wed, 28 Jan 2026 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632085; cv=none; b=JJMwKxY0WzNAEOsU4+hJq9Qj4fM7MhqTg9lar8/qKgZuoKvL3cJ/M787slyMQLMgb73K6zF88ev9LF1lujIdMW7eKEnEqLaefdZ/c7f7NV2eIFfGtyf/M4AEU4SRKeXaOUA2AmIyF3jp9UfJ62vQXE/SDFumknwcwCsBV/eoOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632085; c=relaxed/simple;
	bh=e1gD37k8W4Pzp7U55pR9/mebQe/hwn2pjhUSiquHa+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+C9nrQihUfa6TTK70FmcXrc3HrNfnyIIoUuDgJhO3sowlcFaU9SYRx7AtROXvUlDmdX762wa6Mc3T7VbaS3cGeilomQAjxzJb/tfuNViWdNcW6uCJSYTuywz986+Y+YE9U1LuLwy3GalerzHeMWK41pkfzZe6d2EfYyUz3Akbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCoi2aWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF73C2BCAF;
	Wed, 28 Jan 2026 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632085;
	bh=e1gD37k8W4Pzp7U55pR9/mebQe/hwn2pjhUSiquHa+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RCoi2aWY/oZS67ocZqD2asZzFlXYhQYfYhe3wqNa6gStwaGO2FSunPiQni46XQpSQ
	 v+1mkd1Zi76k+jAK7BCTvTUqnvaTWrXRVi6KyTCxJOUkKxs2/ViSLefTPmB4M6TYfp
	 zgygXHEFdMq8RyNpJks8Ckn43dqM6a4lvqOEVNmoUXQ9XxGregt3JOmmtKLgsSjGsF
	 3DQcYdFAJ0FMYBe4PNJ5JST/NIi4UA9Wj3bLJQXJTzehMYVVJ2IFQjbSlGkzagdyaM
	 c7JBsIVir62difcOv6pNT3HM0+QnQeoK5MC82ctYZTuWro0r3JwENByHgcYGVw0yak
	 mRzMX4TE7tbIg==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:25 -0800
Subject: [PATCH RFC v2 04/17] RISC-V: QoS: define properties of CBQRI
 controllers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-4-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=fustini@kernel.org;
 h=from:subject:message-id; bh=e1gD37k8W4Pzp7U55pR9/mebQe/hwn2pjhUSiquHa+s=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFfo/PsmQs8/5uN0n4RmuNZbNnaqKh08JWp8PniEvI
 bZA5vf0jlIWBjEuBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBEplxlZLhUc3PVNvcCloD3
 kWI1zKbTl3BYzC5zeF0/S6nPd/bORDOGv7KKuyXYZZdlXPyvsccx8XE9U12Qqvt2Y92ekIhmPZU
 nHAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20727-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,baylibre.com:email]
X-Rspamd-Queue-Id: 6E4BEA87F6
X-Rspamd-Action: no action

Define data structure to represent the CBQRI properties that a driver
for an CBQRI-capable controller would discover during probe.

Each instance of a CBQRI-capable controller is added to a list that the
RISC-V CBQRI resctrl implementation will consume.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS               |  1 +
 include/linux/riscv_qos.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e98d553bd0ca..31e536304972 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22511,6 +22511,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/kernel/qos/
+F:	include/linux/riscv_qos.h
 
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
new file mode 100644
index 000000000000..51c3a96bbcd0
--- /dev/null
+++ b/include/linux/riscv_qos.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_RISCV_QOS_H
+#define __LINUX_RISCV_QOS_H
+
+#include <linux/iommu.h>
+#include <linux/types.h>
+
+#include <asm/qos.h>
+
+enum cbqri_controller_type {
+	CBQRI_CONTROLLER_TYPE_CAPACITY,
+	CBQRI_CONTROLLER_TYPE_BANDWIDTH,
+	CBQRI_CONTROLLER_TYPE_UNKNOWN
+};
+
+struct cbqri_controller_info {
+	unsigned long addr;
+	unsigned long size;
+	enum cbqri_controller_type type;
+	u32 rcid_count;
+	u32 mcid_count;
+	struct list_head list;
+
+	struct cache_controller {
+		u32 cache_level;
+		u32 cache_size; /* in bytes */
+		struct cpumask cpu_mask;
+	} cache;
+};
+
+extern struct list_head cbqri_controllers;
+
+#endif /* __LINUX_RISCV_QOS_H */

-- 
2.43.0


