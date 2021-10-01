Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77C941F4DE
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355753AbhJASTh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 14:19:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47484 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355761AbhJASTa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 14:19:30 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id c13c44df6369d84b; Fri, 1 Oct 2021 20:17:45 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A4B4466A7A3;
        Fri,  1 Oct 2021 20:17:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/4] ACPICA: Add support for Windows 2020 _OSI string
Date:   Fri, 01 Oct 2021 20:14:47 +0200
Message-ID: <1819636.tdWV9SEqCh@kreacher>
In-Reply-To: <2236872.ElGaqSPkdT@kreacher>
References: <2236872.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedrudeigeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

ACPICA commit 2dc55de56d2deac30af0b484dd1d65607eb33a9c

Link: https://github.com/microsoft_docs/windows-driver-docs/commit/5164e24985e78ef4870d7a5801a5336104f36366
Link: https://github.com/acpica/acpica/commit/2dc55de5
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utosi.c |    1 +
 include/acpi/actypes.h      |    1 +
 2 files changed, 2 insertions(+)

diff -Nurp linux.before_name/drivers/acpi/acpica/utosi.c linux.after_name/drivers/acpi/acpica/utosi.c
--- linux.before_name/drivers/acpi/acpica/utosi.c	2021-10-01 19:30:37.202896380 +0200
+++ linux.after_name/drivers/acpi/acpica/utosi.c	2021-10-01 19:30:32.677971784 +0200
@@ -73,6 +73,7 @@ static struct acpi_interface_info acpi_d
 	{"Windows 2018", NULL, 0, ACPI_OSI_WIN_10_RS4},	/* Windows 10 version 1803 - Added 11/2018 */
 	{"Windows 2018.2", NULL, 0, ACPI_OSI_WIN_10_RS5},	/* Windows 10 version 1809 - Added 11/2018 */
 	{"Windows 2019", NULL, 0, ACPI_OSI_WIN_10_19H1},	/* Windows 10 version 1903 - Added 08/2019 */
+	{"Windows 2020", NULL, 0, ACPI_OSI_WIN_10_20H1},	/* Windows 10 version 2004 - Added 08/2021 */
 
 	/* Feature Group Strings */
 
diff -Nurp linux.before_name/include/acpi/actypes.h linux.after_name/include/acpi/actypes.h
--- linux.before_name/include/acpi/actypes.h	2021-10-01 19:30:37.168896947 +0200
+++ linux.after_name/include/acpi/actypes.h	2021-10-01 19:30:32.644972334 +0200
@@ -1282,6 +1282,7 @@ typedef enum {
 #define ACPI_OSI_WIN_10_RS4             0x12
 #define ACPI_OSI_WIN_10_RS5             0x13
 #define ACPI_OSI_WIN_10_19H1            0x14
+#define ACPI_OSI_WIN_10_20H1            0x15
 
 /* Definitions of getopt */
 



