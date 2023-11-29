Return-Path: <linux-acpi+bounces-1910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60307FD976
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 15:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ED328214B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB932C80
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D88DE;
	Wed, 29 Nov 2023 05:52:51 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id eddb0e37afb314de; Wed, 29 Nov 2023 14:52:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4DBF06684BD;
	Wed, 29 Nov 2023 14:52:49 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 3/4] ACPI: OSL: Allow Notify () handlers to run on all CPUs
Date: Wed, 29 Nov 2023 14:50:54 +0100
Message-ID: <7617703.EvYhyI6sBW@kreacher>
In-Reply-To: <3281896.aeNJFYEL58@kreacher>
References: <3281896.aeNJFYEL58@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notify () handlers, like GPE handlers, are only allowed to run on CPU0
now out of the concern that they might trigger an SMM trap and that (in
some cases) the SMM code running as a result of that might corrupt
memory if not run on CPU0.

However, Notify () handlers are registered by kernel code and they
are not likely to evaluate AML that would trigger an SMM trap.  In
fact, many of them don't even evaluate any AML at all and even if
they do, that AML may as well be evaluated in other code paths.  In
other words, they are not special from the AML evaluation perspective,
so there is no real reason to treat them in any special way.

Accordingly, allow Notify () handlers, unlike GPE handlers, to be
executed by all CPUs in the system.

Also adjust the allocation of the "notify" workqueue to allow multiple
handlers to be executed at the same time, because they need not be
serialized.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1061,7 +1061,6 @@ acpi_status acpi_os_execute(acpi_execute
 			    acpi_osd_exec_callback function, void *context)
 {
 	struct acpi_os_dpc *dpc;
-	struct workqueue_struct *queue;
 	int ret;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
@@ -1101,24 +1100,22 @@ acpi_status acpi_os_execute(acpi_execute
 	 */
 	switch (type) {
 	case OSL_NOTIFY_HANDLER:
-		queue = kacpi_notify_wq;
+		ret = queue_work(kacpi_notify_wq, &dpc->work);
 		break;
 	case OSL_GPE_HANDLER:
-		queue = kacpid_wq;
+		/*
+		 * On some machines, a software-initiated SMI causes corruption
+		 * unless the SMI runs on CPU 0.  An SMI can be initiated by
+		 * any AML, but typically it's done in GPE-related methods that
+		 * are run via workqueues, so we can avoid the known corruption
+		 * cases by always queueing on CPU 0.
+		 */
+		ret = queue_work_on(0, kacpid_wq, &dpc->work);
 		break;
 	default:
 		pr_err("Unsupported os_execute type %d.\n", type);
 		goto err;
 	}
-
-	/*
-	 * On some machines, a software-initiated SMI causes corruption unless
-	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
-	 * typically it's done in GPE-related methods that are run via
-	 * workqueues, so we can avoid the known corruption cases by always
-	 * queueing on CPU 0.
-	 */
-	ret = queue_work_on(0, queue, &dpc->work);
 	if (!ret) {
 		pr_err("Unable to queue work\n");
 		goto err;
@@ -1668,7 +1665,7 @@ acpi_status __init acpi_os_initialize(vo
 acpi_status __init acpi_os_initialize1(void)
 {
 	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
-	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
+	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 0);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);




