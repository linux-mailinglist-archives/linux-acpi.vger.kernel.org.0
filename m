Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981B8444883
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhKCStY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:49:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50012 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCStX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:49:23 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 9a91add219eb3001; Wed, 3 Nov 2021 19:46:45 +0100
Received: from kreacher.localnet (unknown [213.134.161.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9FECA661F93;
        Wed,  3 Nov 2021 19:46:44 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [PATCH] ACPI: Drop ACPI_USE_BUILTIN_STDARG ifdef from acgcc.h
Date:   Wed, 03 Nov 2021 19:46:43 +0100
Message-ID: <5779281.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.207
X-CLIENT-HOSTNAME: 213.134.161.207
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrtddvgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvvefgteeuteehkeduuedvudetleevffdtffdtjeejueekffetieekgfeigfehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduiedurddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvddtjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_USE_BUILTIN_STDARG symbol is never set in the kernel build,
so stop checking it in include/acpi/platform/acgcc.h and drop all of
the macros depending on it (which appear to duplicate the analogous
macros from linux/stdarg.h, but in fact are never used). 

Link: https://lore.kernel.org/linux-acpi/CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/platform/acgcc.h |   13 -------------
 1 file changed, 13 deletions(-)

Index: linux-pm/include/acpi/platform/acgcc.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acgcc.h
+++ linux-pm/include/acpi/platform/acgcc.h
@@ -10,25 +10,12 @@
 #ifndef __ACGCC_H__
 #define __ACGCC_H__
 
-/*
- * Use compiler specific <stdarg.h> is a good practice for even when
- * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
- */
 #ifndef va_arg
-#ifdef ACPI_USE_BUILTIN_STDARG
-typedef __builtin_va_list va_list;
-#define va_start(v, l)          __builtin_va_start(v, l)
-#define va_end(v)               __builtin_va_end(v)
-#define va_arg(v, l)            __builtin_va_arg(v, l)
-#define va_copy(d, s)           __builtin_va_copy(d, s)
-#else
 #ifdef __KERNEL__
 #include <linux/stdarg.h>
 #else
-/* Used to build acpi tools */
 #include <stdarg.h>
 #endif /* __KERNEL__ */
-#endif /* ACPI_USE_BUILTIN_STDARG */
 #endif /* ! va_arg */
 
 #define ACPI_INLINE             __inline__



