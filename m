Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24BD3DF464
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhHCSMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 14:12:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60446 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbhHCSMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2021 14:12:35 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 809469d732130fdb; Tue, 3 Aug 2021 20:12:19 +0200
Received: from kreacher.localnet (89-64-81-181.dynamic.chello.pl [89.64.81.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4841A66A01E;
        Tue,  3 Aug 2021 20:12:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 6/7] ACPICA: Add method name "_DIS" For use with aslmethod.c
Date:   Tue, 03 Aug 2021 20:11:21 +0200
Message-ID: <9943028.nUPlyArG6x@kreacher>
In-Reply-To: <5748555.lOV4Wx5bFT@kreacher>
References: <5748555.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.181
X-CLIENT-HOSTNAME: 89-64-81-181.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekledrieegrdekuddrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5acc6818c537888be147d9da6b280a0b8c241a1d

Link: https://github.com/acpica/acpica/commit/5acc6818
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acnames.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index a2bc381c7ce7..30869ab77fba 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -20,6 +20,7 @@
 #define METHOD_NAME__CLS        "_CLS"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__DDN        "_DDN"
+#define METHOD_NAME__DIS        "_DIS"
 #define METHOD_NAME__DMA        "_DMA"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
-- 
2.26.2




