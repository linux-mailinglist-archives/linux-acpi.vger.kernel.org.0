Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D5159D65
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBKXi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 18:38:57 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:15763 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgBKXi4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 18:38:56 -0500
X-Originating-IP: 172.58.46.131
Received: from localhost (unknown [172.58.46.131])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 845AC240003;
        Tue, 11 Feb 2020 23:38:48 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:38:06 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: Add new tiny-power-button driver to directly
 signal init
Message-ID: <af419b2293c486b5cff6834770fc8e02cfea06c9.1581463668.git.josh@joshtriplett.org>
References: <cover.1581463668.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581463668.git.josh@joshtriplett.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Virtual machines often use an ACPI power button event to tell the
machine to shut down gracefully.

Provide an extremely lightweight "tiny power button" driver to handle
this event by signaling init directly, rather than running a separate
daemon (such as acpid or systemd-logind) that adds to startup time and
VM image complexity.

The kernel configuration defines the default signal to send init, and
userspace can change this signal via a module parameter.

Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/Kconfig             | 24 +++++++++++++++++
 drivers/acpi/Makefile            |  1 +
 drivers/acpi/tiny-power-button.c | 46 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 drivers/acpi/tiny-power-button.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cc57bab146b5..ce2730d61a8f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -190,6 +190,30 @@ config ACPI_BUTTON
 	  To compile this driver as a module, choose M here:
 	  the module will be called button.
 
+config ACPI_TINY_POWER_BUTTON
+	tristate "Tiny Power Button Driver"
+	depends on !ACPI_BUTTON
+	help
+	  This driver provides a tiny alternative to the ACPI Button driver.
+	  The tiny power button driver only handles the power button. Rather
+	  than notifying userspace via the input layer or a netlink event, this
+	  driver directly signals the init process to shut down.
+
+	  This driver is particularly suitable for cloud and VM environments,
+	  which use a simulated power button to initiate a controlled poweroff,
+	  but which may not want to run a separate userspace daemon to process
+	  input events.
+
+config ACPI_TINY_POWER_BUTTON_SIGNAL
+	int "Tiny Power Button Signal"
+	depends on ACPI_TINY_POWER_BUTTON
+	default 38
+	help
+	  Default signal to send to init in response to the power button.
+
+	  Likely values here include 38 (SIGRTMIN+4) to power off, or 2
+	  (SIGINT) to simulate Ctrl+Alt+Del.
+
 config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 33fdaf67454e..e81e1ebbfb32 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
 
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
+obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
new file mode 100644
index 000000000000..6273d73c0b59
--- /dev/null
+++ b/drivers/acpi/tiny-power-button.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/sched/signal.h>
+#include <linux/acpi.h>
+#include <acpi/button.h>
+
+ACPI_MODULE_NAME("tiny-power-button");
+MODULE_AUTHOR("Josh Triplett");
+MODULE_DESCRIPTION("ACPI Tiny Power Button Driver");
+MODULE_LICENSE("GPL");
+
+static int power_signal __read_mostly = CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL;
+module_param(power_signal, int, 0644);
+MODULE_PARM_DESC(power_signal, "Power button sends this signal to init");
+
+static const struct acpi_device_id tiny_power_button_device_ids[] = {
+	{ ACPI_BUTTON_HID_POWER, 0 },
+	{ ACPI_BUTTON_HID_POWERF, 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
+
+static int acpi_noop_add_remove(struct acpi_device *device)
+{
+	return 0;
+}
+
+static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
+{
+	kill_cad_pid(power_signal, 1);
+}
+
+static struct acpi_driver acpi_tiny_power_button_driver = {
+	.name = "tiny-power-button",
+	.class = "tiny-power-button",
+	.ids = tiny_power_button_device_ids,
+	.ops = {
+		.add = acpi_noop_add_remove,
+		.remove = acpi_noop_add_remove,
+		.notify = acpi_tiny_power_button_notify,
+	},
+};
+
+module_driver(acpi_tiny_power_button_driver,
+		acpi_bus_register_driver,
+		acpi_bus_unregister_driver);
-- 
2.25.0

