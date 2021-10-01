Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11FC41F2D4
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354763AbhJARSH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 13:18:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59442 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbhJARSH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 13:18:07 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 1b1ad961ff2d9acf; Fri, 1 Oct 2021 19:16:21 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C773966A686;
        Fri,  1 Oct 2021 19:16:20 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: Update information in MAINTAINERS
Date:   Fri, 01 Oct 2021 19:16:20 +0200
Message-ID: <5776239.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfdvueeigeffgfdvueehkeffjefhkeefgfektddvuddvlefgudfgudejhfevkeegnecuffhomhgrihhnpedtuddrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudeigedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnrdgsrhhofihnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtgho
 mhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

Because Rui is now going to focus on work that is not related to the
maintenance of kernel code, drop the MAINTAINERS records for the
ACPI fan and video drivers that will be maintained by Rafael along
with the rest of the ACPI subsystem.

While at it, change the information regarding the Len Brown's role in
the ACPI subsystem to "reviewer" to reflect the current status.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 MAINTAINERS |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -334,7 +334,7 @@ F:	drivers/platform/x86/acer-wmi.c
 
 ACPI
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Len Brown <lenb@kernel.org>
+R:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
 W:	https://01.org/linux-acpi
@@ -355,7 +355,7 @@ F:	tools/power/acpi/
 
 ACPI APEI
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Len Brown <lenb@kernel.org>
+R:	Len Brown <lenb@kernel.org>
 R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
@@ -378,14 +378,6 @@ F:	drivers/acpi/acpica/
 F:	include/acpi/
 F:	tools/power/acpi/
 
-ACPI FAN DRIVER
-M:	Zhang Rui <rui.zhang@intel.com>
-L:	linux-acpi@vger.kernel.org
-S:	Supported
-W:	https://01.org/linux-acpi
-B:	https://bugzilla.kernel.org
-F:	drivers/acpi/fan.c
-
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Hanjun Guo <guohanjun@huawei.com>
@@ -422,14 +414,6 @@ W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
 F:	drivers/acpi/*thermal*
 
-ACPI VIDEO DRIVER
-M:	Zhang Rui <rui.zhang@intel.com>
-L:	linux-acpi@vger.kernel.org
-S:	Supported
-W:	https://01.org/linux-acpi
-B:	https://bugzilla.kernel.org
-F:	drivers/acpi/acpi_video.c
-
 ACPI VIOT DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	linux-acpi@vger.kernel.org



