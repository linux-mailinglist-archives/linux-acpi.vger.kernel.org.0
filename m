Return-Path: <linux-acpi+bounces-10146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE59F2CB9
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 10:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C39816328B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C78201035;
	Mon, 16 Dec 2024 09:16:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0A202F9F;
	Mon, 16 Dec 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340579; cv=none; b=am0XU6HApH1YiXWIkLIqfdCK5c6KRhs2UMfD0YGOWyEh5qpQnpg4emuVTehUJVawVsaogdkaQs0KyZLKw3bTD5CfcDZKsLs4/76Qhves8XgQWGvD0NmUYmHiqeO6RQOa3q4LXz3PMTkWxtOtqYgMvlms9l93XDeGyPydYJVgn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340579; c=relaxed/simple;
	bh=DVbfO+bImgQLdojqzoZJCD0lmtLp8iIAPncop/S3X/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpi618kseFOUJMCS6ZicDyxhGgAvp6TJuvhsB7wjppmca0mfCsVXIplrJEnqKUTbnjC4rE1c42L93aTd9jrE+LuJZq3nTcIucLxikwdYadBe6JJZiph6/caYObnXMlpTz3AV/Lsts8dtk+VmEElMkwY9/a3BzwNKHTpQ31fdAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YBZ4G4V31z2Dj0L;
	Mon, 16 Dec 2024 17:13:34 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id AE79D1A016C;
	Mon, 16 Dec 2024 17:16:06 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 17:16:05 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 3/4] ACPI: CPPC: Add autonomous selection ABIs
Date: Mon, 16 Dec 2024 17:16:02 +0800
Message-ID: <20241216091603.1247644-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
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
index 83c7fcad74ad..645f2366c888 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1595,6 +1595,50 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
+/**
+ * cppc_set_epp() - Write the EPP register.
+ * @cpu: CPU on which to write register.
+ * @epp_val: Value to write to the EPP register.
+ */
+int cppc_set_epp(int cpu, u64 epp_val)
+{
+	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
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
+	return cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
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
+	return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
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
+	return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, auto_sel);
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


