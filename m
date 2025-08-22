Return-Path: <linux-acpi+bounces-15940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C7B31F0C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F6B1B617C7
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E3309DCB;
	Fri, 22 Aug 2025 15:34:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D84263899;
	Fri, 22 Aug 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876843; cv=none; b=oa45m/Kv8C2pVxyn6EUzsk5i7zOw/XY707R5xblyC5bE20wh1kc2Om+3RvvuN5RVyXdcB9W9kWCkGPOe3d6RnSlof4E+mYOJKI8TNFP9eppiJ8yi+/ZoHqcU38k6PfyPVO/W5vWUGAisErgLPuUvsi/FXDnS1E9Ke90FRRmJEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876843; c=relaxed/simple;
	bh=18sehYH0E8APdpVHinIWVpga+ncSNyEOb9yu9LBVPzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrI5FltohFqt8dKeT6QZQ7ugMJLIUy4wVmKprSY1Hno9qjl6DQANZDHn+qWxProhpQrvlUuVDl1ToaGFPsEnG+6/Vko1KsT+ZgpKHT9ysHEoPalzE3rdc7vU4nlHM5K63/0Z37j+Gtyd6qVucDodpvSh36SvZ59l1NIZogoja5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CCE27B5;
	Fri, 22 Aug 2025 08:33:53 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26AD63F63F;
	Fri, 22 Aug 2025 08:33:56 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 31/33] arm_mpam: Add helper to reset saved mbwu state
Date: Fri, 22 Aug 2025 15:30:12 +0000
Message-Id: <20250822153048.2287-32-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250822153048.2287-1-james.morse@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl expects to reset the bandwidth counters when the filesystem
is mounted.

To allow this, add a helper that clears the saved mbwu state. Instead
of cross calling to each CPU that can access the component MSC to
write to the counter, set a flag that causes it to be zero'd on the
the next read. This is easily done by forcing a configuration update.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 49 +++++++++++++++++++++++++++++++--
 drivers/resctrl/mpam_internal.h |  5 +++-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 8fbcf6eb946a..65c30ebfe001 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1155,9 +1155,11 @@ static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
 static void __ris_msmon_read(void *arg)
 {
 	bool nrdy = false;
+	bool config_mismatch;
 	struct mon_read *m = arg;
 	u64 now, overflow_val = 0;
 	struct mon_cfg *ctx = m->ctx;
+	bool reset_on_next_read = false;
 	struct mpam_msc_ris *ris = m->ris;
 	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_props *rprops = &ris->props;
@@ -1172,6 +1174,14 @@ static void __ris_msmon_read(void *arg)
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
 
+	if (m->type == mpam_feat_msmon_mbwu) {
+		mbwu_state = &ris->mbwu_state[ctx->mon];
+		if (mbwu_state) {
+			reset_on_next_read = mbwu_state->reset_on_next_read;
+			mbwu_state->reset_on_next_read = false;
+		}
+	}
+
 	/*
 	 * Read the existing configuration to avoid re-writing the same values.
 	 * This saves waiting for 'nrdy' on subsequent reads.
@@ -1179,7 +1189,10 @@ static void __ris_msmon_read(void *arg)
 	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
 	clean_msmon_ctl_val(&cur_ctl);
 	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
-	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
+	config_mismatch = cur_flt != flt_val ||
+			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
+
+	if (config_mismatch || reset_on_next_read)
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
 
 	switch (m->type) {
@@ -1212,7 +1225,6 @@ static void __ris_msmon_read(void *arg)
 		if (nrdy)
 			break;
 
-		mbwu_state = &ris->mbwu_state[ctx->mon];
 		if (!mbwu_state)
 			break;
 
@@ -1314,6 +1326,39 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	return err;
 }
 
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
+{
+	int idx;
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	if (!mpam_is_enabled())
+		return;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
+		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
+			continue;
+
+		msc = vmsc->msc;
+		mpam_mon_sel_outer_lock(msc);
+		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
+			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+				continue;
+
+			if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
+				continue;
+
+			ris->mbwu_state[ctx->mon].correction = 0;
+			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
+			mpam_mon_sel_inner_unlock(msc);
+		}
+		mpam_mon_sel_outer_unlock(msc);
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
 static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 9f627b5f72a1..bbf0306abc82 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -297,10 +297,12 @@ struct mon_cfg {
 
 /*
  * Changes to enabled and cfg are protected by the msc->lock.
- * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
+ * Changes to reset_on_next_read, prev_val and correction are protected by the
+ * msc's mon_sel_lock.
  */
 struct msmon_mbwu_state {
 	bool		enabled;
+	bool		reset_on_next_read;
 	struct mon_cfg	cfg;
 
 	/* The value last read from the hardware. Used to detect overflow. */
@@ -410,6 +412,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features, u64 *val);
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.20.1


