Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1589833D84F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhCPPyY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 11:54:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbhCPPyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2021 11:54:06 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id e5d6e2e5c90b9b90; Tue, 16 Mar 2021 16:54:04 +0100
Received: from kreacher.localnet (89-64-82-37.dynamic.chello.pl [89.64.82.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9861F668CF6;
        Tue, 16 Mar 2021 16:54:03 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH] ACPI: CPPC: Add emtpy stubs of functions for CONFIG_ACPI_CPPC_LIB unset
Date:   Tue, 16 Mar 2021 16:54:03 +0100
Message-ID: <538668936.KFQZekuijD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefvddgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedvrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrfeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihuhdrtgdr
 tghhvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehiohhnvghlrgdrvhhoihhnvghstghusegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For convenience, add empty stubs of library functions defined in
cppc_acpi.c for the CONFIG_ACPI_CPPC_LIB unset case.

Because one of them needs to return CPUFREQ_ETERNAL, include
linux/cpufreq.h into the CPPC library header file and drop the
direct inclusion of it from cppc_acpi.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |    1 -
 include/acpi/cppc_acpi.h |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

Index: linux-pm/include/acpi/cppc_acpi.h
===================================================================
--- linux-pm.orig/include/acpi/cppc_acpi.h
+++ linux-pm/include/acpi/cppc_acpi.h
@@ -11,6 +11,7 @@
 #define _CPPC_ACPI_H
 
 #include <linux/acpi.h>
+#include <linux/cpufreq.h>
 #include <linux/types.h>
 
 #include <acpi/pcc.h>
@@ -132,6 +133,7 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+#ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
@@ -142,5 +144,43 @@ extern unsigned int cppc_get_transition_
 extern bool cpc_ffh_supported(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
+#else /* !CONFIG_ACPI_CPPC_LIB */
+static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
+{
+	return -ENOTSUPP;
+}
+static inline bool acpi_cpc_valid(void)
+{
+	return false;
+}
+static inline unsigned int cppc_get_transition_latency(int cpu)
+{
+	return CPUFREQ_ETERNAL;
+}
+static inline bool cpc_ffh_supported(void)
+{
+	return false;
+}
+static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
+{
+	return -ENOTSUPP;
+}
+static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
+{
+	return -ENOTSUPP;
+}
+#endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -33,7 +33,6 @@
 
 #define pr_fmt(fmt)	"ACPI CPPC: " fmt
 
-#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/ktime.h>



