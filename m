Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F43DF468
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhHCSMi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 14:12:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59022 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbhHCSMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2021 14:12:35 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 362f9c51d7165ef0; Tue, 3 Aug 2021 20:12:23 +0200
Received: from kreacher.localnet (89-64-81-181.dynamic.chello.pl [89.64.81.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8AA2C66A01E;
        Tue,  3 Aug 2021 20:12:22 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/7] ACPICA: Headers: Add new DBG2 Serial Port Subtypes
Date:   Tue, 03 Aug 2021 20:10:02 +0200
Message-ID: <2799042.e9J7NaK4W3@kreacher>
In-Reply-To: <5748555.lOV4Wx5bFT@kreacher>
References: <5748555.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.181
X-CLIENT-HOSTNAME: 89-64-81-181.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffueeuvdfgffdtfefgffetfeduheetudejvdeuuedvjeevgfetiedvhefguefghfenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeekledrieegrdekuddrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

The Microsoft Debug Port Table 2 (DBG2) specification revision
September 21, 2020 comprises additional Serial Port Subtypes [1].
Reflect that in the actbl1.h header file.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table

ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f

Link: https://github.com/acpica/acpica/commit/d95c7d20
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a7ea179b2089..159070edd031 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -483,7 +483,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21, 2020
  *
  ******************************************************************************/
 
@@ -533,11 +533,24 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_MAX311XE_SPI      0x0002
 #define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_MSM8X60           0x0004
+#define ACPI_DBG2_16550_NVIDIA      0x0005
+#define ACPI_DBG2_TI_OMAP           0x0006
+#define ACPI_DBG2_APM88XXXX         0x0008
+#define ACPI_DBG2_MSM8974           0x0009
+#define ACPI_DBG2_SAM5250           0x000A
+#define ACPI_DBG2_INTEL_USIF        0x000B
+#define ACPI_DBG2_IMX6              0x000C
 #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
 #define ACPI_DBG2_ARM_DCC           0x000F
 #define ACPI_DBG2_BCM2835           0x0010
+#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
+#define ACPI_DBG2_16550_WITH_GAS    0x0012
+#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
+#define ACPI_DBG2_INTEL_LPSS        0x0014
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.26.2




