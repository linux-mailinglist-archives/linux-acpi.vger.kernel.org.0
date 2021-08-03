Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088E3DF469
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhHCSMi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 14:12:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50892 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhHCSMh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2021 14:12:37 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id d51e9b9f1238c297; Tue, 3 Aug 2021 20:12:24 +0200
Received: from kreacher.localnet (89-64-81-181.dynamic.chello.pl [89.64.81.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 24ED966A01E;
        Tue,  3 Aug 2021 20:12:24 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/7] ACPICA: Macros should not use a trailing semicolon
Date:   Tue, 03 Aug 2021 20:09:18 +0200
Message-ID: <2084744.irdbgypaU6@kreacher>
In-Reply-To: <5748555.lOV4Wx5bFT@kreacher>
References: <5748555.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.181
X-CLIENT-HOSTNAME: 89-64-81-181.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekledrieegrdekuddrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8d49c0b2b78b8a8c5dae4d5ff28432729f4d59f2

Link: https://github.com/acpica/acpica/commit/8d49c0b2
Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1b4c45815695..5a3875744678 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -415,7 +415,7 @@
 /* Conditional execution */
 
 #define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
+#define ACPI_DEBUG_ONLY_MEMBERS(a)      a
 #define _VERBOSE_STRUCTURES
 
 /* Various object display routines for debug */
-- 
2.26.2




