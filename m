Return-Path: <linux-acpi+bounces-1912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03577FD978
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 15:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C09EB20B21
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF232C7A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E5E6;
	Wed, 29 Nov 2023 05:52:52 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id f46ce4111fa3dfca; Wed, 29 Nov 2023 14:52:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CA71B6684BD;
	Wed, 29 Nov 2023 14:52:50 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 1/4] ACPI: OSL: Rework error handling in acpi_os_execute()
Date: Wed, 29 Nov 2023 14:46:51 +0100
Message-ID: <8321623.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reduce the number of checks and goto labels related to error handling
in acpi_os_execute() and drop the status local variable, which turns
out to be redundant, from it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1060,7 +1060,6 @@ int __init acpi_debugger_init(void)
 acpi_status acpi_os_execute(acpi_execute_type type,
 			    acpi_osd_exec_callback function, void *context)
 {
-	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
 	int ret;
@@ -1073,9 +1072,9 @@ acpi_status acpi_os_execute(acpi_execute
 		ret = acpi_debugger_create_thread(function, context);
 		if (ret) {
 			pr_err("Kernel thread creation failed\n");
-			status = AE_ERROR;
+			return AE_ERROR;
 		}
-		goto out_thread;
+		return AE_OK;
 	}
 
 	/*
@@ -1107,12 +1106,9 @@ acpi_status acpi_os_execute(acpi_execute
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	} else {
 		pr_err("Unsupported os_execute type %d.\n", type);
-		status = AE_ERROR;
+		goto err;
 	}
 
-	if (ACPI_FAILURE(status))
-		goto err_workqueue;
-
 	/*
 	 * On some machines, a software-initiated SMI causes corruption unless
 	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
@@ -1123,13 +1119,14 @@ acpi_status acpi_os_execute(acpi_execute
 	ret = queue_work_on(0, queue, &dpc->work);
 	if (!ret) {
 		pr_err("Unable to queue work\n");
-		status = AE_ERROR;
+		goto err;
 	}
-err_workqueue:
-	if (ACPI_FAILURE(status))
-		kfree(dpc);
-out_thread:
-	return status;
+
+	return AE_OK;
+
+err:
+	kfree(dpc);
+	return AE_ERROR;
 }
 EXPORT_SYMBOL(acpi_os_execute);
 




