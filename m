Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA90400B8B
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhIDNy4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Sep 2021 09:54:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48742 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhIDNyy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Sep 2021 09:54:54 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 3ad7206103145ea8; Sat, 4 Sep 2021 15:53:51 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CB1A766A3B0;
        Sat,  4 Sep 2021 15:53:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI: CPPC: Introduce cppc_get_nominal_perf()
Date:   Sat, 04 Sep 2021 15:51:45 +0200
Message-ID: <4692874.31r3eYUQgx@kreacher>
In-Reply-To: <11837325.O9o76ZdvQC@kreacher>
References: <11837325.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhi
 rdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some systems the nominal_perf value retrieved via CPPC is just
a constant and fetching it doesn't require accessing any registers,
so if it is the only CPPC capability that's needed, it is wasteful
to run cppc_get_perf_caps() in order to get just that value alone,
especially when this is done for CPUs other than the one running
the code.

For this reason, introduce cppc_get_nominal_perf() allowing
nominal_perf to be obtained individually, by generalizing the
existing cppc_get_desired_perf() (and renaming it) so it can be
used to retrieve any specific CPPC capability value.

While at it, clean up the cppc_get_desired_perf() kerneldoc comment
a bit.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |   47 +++++++++++++++++++++++++++++++----------------
 include/acpi/cppc_acpi.h |    5 +++++
 2 files changed, 36 insertions(+), 16 deletions(-)

Index: linux-pm/include/acpi/cppc_acpi.h
===================================================================
--- linux-pm.orig/include/acpi/cppc_acpi.h
+++ linux-pm/include/acpi/cppc_acpi.h
@@ -135,6 +135,7 @@ struct cppc_cpudata {
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
+extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
@@ -149,6 +150,10 @@ static inline int cppc_get_desired_perf(
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	return -ENOTSUPP;
Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -1008,23 +1008,14 @@ static int cpc_write(int cpu, struct cpc
 	return ret_val;
 }
 
-/**
- * cppc_get_desired_perf - Get the value of desired performance register.
- * @cpunum: CPU from which to get desired performance.
- * @desired_perf: address of a variable to store the returned desired performance
- *
- * Return: 0 for success, -EIO otherwise.
- */
-int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
+static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
-	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
-	struct cpc_register_resource *desired_reg;
-	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cpc_register_resource *reg = &cpc_desc->cpc_regs[reg_idx];
 
-	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
-
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
+		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+		struct cppc_pcc_data *pcc_ss_data = NULL;
 		int ret = 0;
 
 		if (pcc_ss_id < 0)
@@ -1035,7 +1026,7 @@ int cppc_get_desired_perf(int cpunum, u6
 		down_write(&pcc_ss_data->pcc_lock);
 
 		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			cpc_read(cpunum, desired_reg, desired_perf);
+			cpc_read(cpunum, reg, perf);
 		else
 			ret = -EIO;
 
@@ -1044,13 +1035,37 @@ int cppc_get_desired_perf(int cpunum, u6
 		return ret;
 	}
 
-	cpc_read(cpunum, desired_reg, desired_perf);
+	cpc_read(cpunum, reg, perf);
 
 	return 0;
 }
+
+/**
+ * cppc_get_desired_perf - Get the desired performance register value.
+ * @cpunum: CPU from which to get desired performance.
+ * @desired_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
+{
+	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
+}
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
 /**
+ * cppc_get_nominal_perf - Get the nominal performance register value.
+ * @cpunum: CPU from which to get nominal performance.
+ * @nominal_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
+{
+	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
+}
+
+/**
  * cppc_get_perf_caps - Get a CPU's performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
  * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h



