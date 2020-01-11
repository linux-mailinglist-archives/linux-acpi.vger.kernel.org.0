Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B463F137B0E
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2020 03:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgAKCVx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jan 2020 21:21:53 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45951 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgAKCVx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2020 21:21:53 -0500
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 19A1B240005;
        Sat, 11 Jan 2020 02:21:47 +0000 (UTC)
Date:   Fri, 10 Jan 2020 18:21:45 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: button: Provide option for power button to directly
 signal init
Message-ID: <20200111022145.GA166025@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Virtual machines and containers often use an ACPI power button event to
tell the machine to shut down gracefully.

Provide an optional, extremely lightweight way to handle this event by
signaling init directly, rather than running a separate daemon (such as
acpid or systemd-logind) that adds to startup time and VM image
complexity.

By default, the power button will continue to notify userspace through
the input layer. With the button.power_signal parameter set, the
power button will instead send the configured signal to init. (For
instance, sending SIGINT will make the power button simulate
ctrl-alt-del.)

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/acpi/button.c                           | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..bbb598e148f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -450,6 +450,12 @@
 			firmware feature for flushing multiple hpte entries
 			at a time.
 
+	button.power_signal=
+			[ACPI] When the power button is pressed, send this
+			signal number to the init process. If set to 0
+			(default), do not send a signal.
+			Format: integer
+
 	c101=		[NET] Moxa C101 synchronous serial card
 
 	cachesize=	[BUGS=X86-32] Override level 2 CPU cache size detection.
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index b758b45737f5..923259f132d6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/sched/signal.h>
 #include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/slab.h>
@@ -167,6 +168,10 @@ static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 
+static int power_signal __read_mostly = 0;
+module_param(power_signal, int, 0644);
+MODULE_PARM_DESC(power_signal, "Power button sends this signal to init");
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -426,6 +431,12 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			if (button->suspended)
 				break;
 
+			if (power_signal
+			    && button->type == ACPI_BUTTON_TYPE_POWER) {
+				kill_cad_pid(power_signal, 1);
+				break;
+			}
+
 			keycode = test_bit(KEY_SLEEP, input->keybit) ?
 						KEY_SLEEP : KEY_POWER;
 			input_report_key(input, keycode, 1);
-- 
2.25.0.rc2

