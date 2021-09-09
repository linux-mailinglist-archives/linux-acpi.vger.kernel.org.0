Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F84405D14
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Sep 2021 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhIIS65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Sep 2021 14:58:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65140 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhIIS64 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Sep 2021 14:58:56 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id d43d481c64ac2b61; Thu, 9 Sep 2021 20:57:45 +0200
Received: from kreacher.localnet (unknown [213.134.181.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 260B266A4C2;
        Thu,  9 Sep 2021 20:57:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Change Rafael's e-mail address
Date:   Thu, 09 Sep 2021 20:57:44 +0200
Message-ID: <5509701.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.77
X-CLIENT-HOSTNAME: 213.134.181.77
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudefledgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffekteethfdvhfefgffhueefleehudeihedujeeutddvfeekvdehtdetteeuieehnecuffhomhgrihhnpegrrhhmrdgtohhmpdhophgvnhhlihhnuhigrdhorhhgpdhkrghnughordhhuhdpkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukedurdejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdejjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
 gh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

I have been slow to respond to messages going to rjw@rjwysocki.net
recently, so change it to rafael@kernel.org (which works better for
me) in MAINTAINERS.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 MAINTAINERS |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -333,7 +333,7 @@ S:	Maintained
 F:	drivers/platform/x86/acer-wmi.c
 
 ACPI
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
@@ -354,7 +354,7 @@ F:	include/linux/fwnode.h
 F:	tools/power/acpi/
 
 ACPI APEI
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <lenb@kernel.org>
 R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
@@ -402,7 +402,7 @@ S:	Maintained
 F:	drivers/platform/x86/i2c-multi-instantiate.c
 
 ACPI PMIC DRIVERS
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <lenb@kernel.org>
 R:	Andy Shevchenko <andy@kernel.org>
 R:	Mika Westerberg <mika.westerberg@linux.intel.com>
@@ -4797,7 +4797,7 @@ W:	http://www.arm.com/products/processor
 F:	drivers/cpufreq/vexpress-spc-cpufreq.c
 
 CPU FREQUENCY SCALING FRAMEWORK
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
@@ -4815,7 +4815,7 @@ F:	kernel/sched/cpufreq*.c
 F:	tools/testing/selftests/cpufreq/
 
 CPU IDLE TIME MANAGEMENT FRAMEWORK
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
@@ -7525,7 +7525,7 @@ W:	ftp://ftp.openlinux.org/pub/people/hc
 F:	fs/freevxfs/
 
 FREEZER
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-pm@vger.kernel.org
 S:	Supported
@@ -7778,7 +7778,7 @@ S:	Supported
 F:	drivers/i2c/muxes/i2c-demux-pinctrl.c
 
 GENERIC PM DOMAINS
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Kevin Hilman <khilman@kernel.org>
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
@@ -8244,7 +8244,7 @@ W:	http://drama.obuda.kando.hu/~fero/cgi
 F:	drivers/video/fbdev/hgafb.c
 
 HIBERNATION (aka Software Suspend, aka swsusp)
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-pm@vger.kernel.org
 S:	Supported
@@ -14838,7 +14838,7 @@ F:	kernel/time/*timer*
 F:	kernel/time/namespace.c
 
 POWER MANAGEMENT CORE
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org
@@ -17775,7 +17775,7 @@ F:	arch/sh/
 F:	drivers/sh/
 
 SUSPEND TO RAM
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-pm@vger.kernel.org



