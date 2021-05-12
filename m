Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BC37BFD1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhELOXC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 10:23:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56024 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhELOXB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 10:23:01 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 1e1cd55b6afb28a8; Wed, 12 May 2021 16:21:49 +0200
Received: from kreacher.localnet (89-64-81-242.dynamic.chello.pl [89.64.81.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2CCC46695E9;
        Wed, 12 May 2021 16:21:49 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: hybrid: Avoid exposing two global attributes
Date:   Wed, 12 May 2021 16:15:48 +0200
Message-ID: <1798832.tdWV9SEqCh@kreacher>
In-Reply-To: <2212930.ElGaqSPkdT@kreacher>
References: <2212930.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.242
X-CLIENT-HOSTNAME: 89-64-81-242.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdehvddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddvgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihuhdrtgdrtghhvghnsehinhhtvghlrdgt
 ohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The turbo_pct and num_pstates sysfs attributes represent CPU
properties that may be different for differenty types of CPUs in
a hybrid processor, so avoid exposing them in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    6 ++++++
 drivers/cpufreq/intel_pstate.c                |   15 +++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -365,6 +365,9 @@ argument is passed to the kernel in the
 	inclusive) including both turbo and non-turbo P-states (see
 	`Turbo P-states Support`_).
 
+	This attribute is present only if the value exposed by it is the same
+	for all of the CPUs in the system.
+
 	The value of this attribute is not affected by the ``no_turbo``
 	setting described `below <no_turbo_attr_>`_.
 
@@ -374,6 +377,9 @@ argument is passed to the kernel in the
 	Ratio of the `turbo range <turbo_>`_ size to the size of the entire
 	range of supported P-states, in percent.
 
+	This attribute is present only if the value exposed by it is the same
+	for all of the CPUs in the system.
+
 	This attribute is read-only.
 
 .. _no_turbo_attr:
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1365,8 +1365,6 @@ define_one_global_rw(energy_efficiency);
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
 	&no_turbo.attr,
-	&turbo_pct.attr,
-	&num_pstates.attr,
 	NULL
 };
 
@@ -1391,6 +1389,14 @@ static void __init intel_pstate_sysfs_ex
 	if (WARN_ON(rc))
 		return;
 
+	if (!boot_cpu_has(X86_FEATURE_HYBRID_CPU)) {
+		rc = sysfs_create_file(intel_pstate_kobject, &turbo_pct.attr);
+		WARN_ON(rc);
+
+		rc = sysfs_create_file(intel_pstate_kobject, &num_pstates.attr);
+		WARN_ON(rc);
+	}
+
 	/*
 	 * If per cpu limits are enforced there are no global limits, so
 	 * return without creating max/min_perf_pct attributes
@@ -1417,6 +1423,11 @@ static void __init intel_pstate_sysfs_re
 
 	sysfs_remove_group(intel_pstate_kobject, &intel_pstate_attr_group);
 
+	if (!boot_cpu_has(X86_FEATURE_HYBRID_CPU)) {
+		sysfs_remove_file(intel_pstate_kobject, &num_pstates.attr);
+		sysfs_remove_file(intel_pstate_kobject, &turbo_pct.attr);
+	}
+
 	if (!per_cpu_limits) {
 		sysfs_remove_file(intel_pstate_kobject, &max_perf_pct.attr);
 		sysfs_remove_file(intel_pstate_kobject, &min_perf_pct.attr);



