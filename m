Return-Path: <linux-acpi+bounces-20736-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PyiAshxemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20736-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:30:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53CA889B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F01E30574FB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9EE378D6D;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbukFBG+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F2378837;
	Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632091; cv=none; b=mubM2BXCbr5vBWY1t0s3N1cjNewHNMKHTTGoQmuAuJDqxiBcusxgE+p9vhq2rnMXqMqGNoQwfwWTClXUDIXjnCv80W9eguIdg1dpQM6xFZ9ab4jNXjzr5qRveDJIBk2kWLkbbGsF53VDGbtJt4rsm79hcDzO/D6R17v3HXCq8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632091; c=relaxed/simple;
	bh=ocyqe4U7WsJJbTpfliXFcM4vxluIpCLTh7ZpGc7FQ9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFQo9ZxTXLxsR410HCm5IiOV4+sVt+YhPP37D/9K8JLUR1QgREkIhNr+kjxZ0iZF6bgHrQTAGkM9XbOQJNISzsHUREBps7MaYlIe1n0Wj09/6xT+AqAAVGfGh1212kJL06yxu5wDBxqw/sXojDmxXSan8w/aYvnV4VKXD6Ii4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbukFBG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE73C2BCB6;
	Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632090;
	bh=ocyqe4U7WsJJbTpfliXFcM4vxluIpCLTh7ZpGc7FQ9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HbukFBG+BVdHcteku9MwelF3rnMrQgJFghq6OZXCg5Wo5w/M6fgaw9wzgtHBlHOW1
	 rW+G8vQfaNvEpize+pVloepoxynpzcwSDZtd1EvjSC7x6CRsoL+mEwfeiWcRaINuAB
	 HteP3IzzZ4ADheYpxvQLwdEw4d45oPj+bD4erFph+GLriIDePg7Wy0A795AFfwg58Q
	 oPznvx57FUi9ilO1GmxcLQEd3anBF7PgGs6eLNE0VUweCeMp0zy8wox7hUNXwW9sYN
	 nrkbieancGhVy32DDtoVxFMZ22KPgdi7fRCht6u66H7FBBP/GsUmiYk9w4BxjqokkX
	 +WncgTdQo4sjA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:34 -0800
Subject: [PATCH RFC v2 13/17] acpi: pptt: Add helper to find a cache from
 id
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-13-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=fustini@kernel.org;
 h=from:subject:message-id; bh=ocyqe4U7WsJJbTpfliXFcM4vxluIpCLTh7ZpGc7FQ9c=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQZ+FZveccRm85//urc4F8ws39AV4PNEeSnr7A3fJ
 qQfjjZR6ihlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZN5JRoY9yR671mX9nXtM
 Y0eh5fX2lpN5ji2OBTNnHiqsUwgTMzZn+B86nb1+klSz0ddQYdlrLO/8j2srLPvgcEXN9ulepdj
 O1ywA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20736-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD53CA889B
X-Rspamd-Action: no action

Add function to find the pointer to an instance of acpi_pptt_cache.

find_acpi_cache_from_id() is based on find_acpi_cache_level_from_id()
from commit c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID") in
the morse/mpam/snapshot/v6.14-rc1 branch.

TODO: find_acpi_cache_level_from_id() has changed since then so this
function should be updated. In additon, there may be a simpler way for
acpi_parse_rqsc() than adding this function to get a pointer to
acpi_pptt_cache.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  8 +++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..d1002673dc39 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -1063,3 +1063,66 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
 
 	return 0;
 }
+
+/*
+ * find_acpi_cache_from_id() is adapted from find_acpi_cache_level_from_id()
+ * introduced by c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID")
+ * in the morse/mpam/snapshot/v6.14-rc1 branch.
+ *
+ * TODO: find_acpi_cache_level_from_id() has changed since then so this
+ * function should be updated. In additon, there may be a simpler way for
+ * acpi_parse_rqsc() than adding this function to get a pointer to
+ * acpi_pptt_cache.
+ */
+struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id)
+{
+	u32 acpi_cpu_id;
+	acpi_status status;
+	int level, cpu, num_levels;
+	struct acpi_pptt_cache *cache;
+	struct acpi_table_header *table;
+	struct acpi_pptt_cache_v1 *cache_v1;
+	struct acpi_pptt_processor *cpu_node;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return NULL;
+	}
+
+	if (table->revision < 3) {
+		acpi_put_table(table);
+		return NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		num_levels = 0;
+		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+		if (!cpu_node)
+			break;
+		num_levels = acpi_count_levels(table, cpu_node, NULL);
+
+		for (level = 1; level <= num_levels; level++) {
+			cache = acpi_find_cache_node(table, acpi_cpu_id,
+						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
+						     level, &cpu_node);
+			if (!cache)
+				continue;
+
+			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
+						cache,
+						sizeof(struct acpi_pptt_cache));
+
+			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
+			    cache_v1->cache_id == cache_id) {
+				acpi_put_table(table);
+				return cache;
+			}
+		}
+	}
+
+	acpi_put_table(table);
+	return NULL;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fbf0c3a65f59..fee6a5059a46 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1546,6 +1546,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 int find_acpi_cache_level_from_id(u32 cache_id);
+struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id);
 int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
@@ -1570,10 +1571,17 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 }
 static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
 						     cpumask_t *cpus) { }
+
 static inline int find_acpi_cache_level_from_id(u32 cache_id)
 {
 	return -ENOENT;
 }
+
+static inline struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id)
+{
+	return NULL;
+}
+
 static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
 						      cpumask_t *cpus)
 {

-- 
2.43.0


