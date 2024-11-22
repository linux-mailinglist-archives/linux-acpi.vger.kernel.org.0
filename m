Return-Path: <linux-acpi+bounces-9731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055669D5957
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ACBB2358C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8D174EFA;
	Fri, 22 Nov 2024 06:21:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD7172BCE;
	Fri, 22 Nov 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256465; cv=none; b=GeEkhwT2CwHIe/cDyM5vXpiIMSHVdHtMaN0hy7RYhWYmaNqCtkmTE0P9DhLbvQrlVEbDJU5YknzvLL8E3zg45qo+wH/DNIkgOAIG2QVGuqXSiNsKPMmBQpnihkqYoT4F4kMuXspZwtk7kYsw3E/vIrqndM0o4gMINyUM6uwfTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256465; c=relaxed/simple;
	bh=QQ6LrOCUEsxBPGEuK5GpLv4j/UI1sBjl6gPoIdltCz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9rVSsvx6PGrL0j5r/f6P/c1b4bZhDsyHNPxMd73kTRDRCmtYfxMZ7ldKM3Trsr9Zav4tb7JrEqsrdQAhtYx/RBiA1c22Ir2WfjA+nNjBbhKefdtrGU+fASF7otVonB88hHSWfkUVFu6l6lwvdIe2tp5c9mb/QFsTdSh8ypKcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XvlKk1nrJz10WFd;
	Fri, 22 Nov 2024 14:18:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E3821800DE;
	Fri, 22 Nov 2024 14:20:54 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 14:20:53 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 2/3] ACPI: CPPC: Add autonomous selection ABIs
Date: Fri, 22 Nov 2024 14:20:50 +0800
Message-ID: <20241122062051.3658577-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

cppc_set_epp - write energy performance preference register

cppc_get_auto_act_window - read autonomous activity window register

cppc_set_auto_act_window - write autonomous activity window register

cppc_get_auto_sel - read autonomous selection enable register

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 20 ++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9aab22d8136a..48354d7d04bb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1588,6 +1588,50 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
+/**
+ * cppc_set_epp() - Write the EPP register.
+ * @cpu: CPU on which to write register.
+ * @epp_val: Value to write to the EPP register.
+ */
+int cppc_set_epp(int cpu, u64 epp_val)
+{
+	return cppc_set_reg(cpu, ENERGY_PERF, epp_val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_epp);
+
+/**
+ * cppc_get_auto_act_window() - Read autonomous activity window register.
+ * @cpu: CPU from which to read register.
+ * @auto_act_window: Return address.
+ */
+int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
+{
+	return cppc_get_reg(cpu, AUTO_ACT_WINDOW, auto_act_window);
+}
+EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
+
+/**
+ * cppc_set_auto_act_window() - Write autonomous activity window register.
+ * @cpu: CPU on which to write register.
+ * @auto_act_window: Value to write to the autonomous activity window register.
+ */
+int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	return cppc_set_reg(cpu, AUTO_ACT_WINDOW, auto_act_window);
+}
+EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
+
+/**
+ * cppc_get_auto_sel() - Read autonomous selection register.
+ * @cpu: CPU from which to read register.
+ * @auto_sel: Return address.
+ */
+int cppc_get_auto_sel(int cpu, u64 *auto_sel)
+{
+	return cppc_get_reg(cpu, AUTO_SEL_ENABLE, auto_sel);
+}
+EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
+
 /**
  * cppc_get_auto_sel_caps - Read autonomous selection register.
  * @cpunum : CPU from which to read register.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 62d368bcd9ec..134931b081a0 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -159,6 +159,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
+extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
+extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
+extern int cppc_get_auto_sel(int cpu, u64 *auto_sel);
 extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -225,6 +229,22 @@ static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls,
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_epp(int cpu, u64 epp_val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_auto_sel(int cpu, u64 *auto_sel)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -EOPNOTSUPP;
-- 
2.33.0


