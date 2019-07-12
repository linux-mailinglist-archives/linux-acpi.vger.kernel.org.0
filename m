Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B26698D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfGLJCH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 05:02:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfGLJCH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2019 05:02:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McYP5-1iKMN90Vnp-00czGd; Fri, 12 Jul 2019 11:01:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <keith.busch@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] acpi: fix false-positive -Wuninitialized warning
Date:   Fri, 12 Jul 2019 11:01:21 +0200
Message-Id: <20190712090148.36582-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7sZP4eEbe+3OiH796kT5tvmwQXjNHcTkUqNNMEn68ZmKmEo6CTQ
 BHFynryqQUJ0/HtOfAQXY9d+LLBQAXJMJRRJHooKDNPwyEnvjAYlLtoRb0ldEWkJW/xkusO
 1oTvc/LiVwcz7hpDVmKvm14Kq8+Xd00cN096yPpbmDoDvfG71/3ZH8kKhxTXObXZyf1T11h
 vWXgjbh5NWnDpvFzM096Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHma/eG3W/E=:8gCfiHXH5JxqNVMP9GtKqR
 UfZhbNxOaHvx5labbIX9zIlNZ7ne9ANFBHnicgrff8XJFfaqw7KMc/oYMncjl475Fh1O+BCRs
 p49tVXu3YWMwatDiUer/3A1ilmWiYF0F76TERsrDSAcChhnbXqyLsMHWVRylVSn68gOouyVlc
 Ohl6W7ue5Q1knl1u1Fxxr8Glrsj9jbAptkGr+U+uRq08IfXZAuDlzQkSVnHv8A4speHHfe7hu
 CACI9LX+yFR7dzxjFd8wqbSrefjiWb2DC5fRQz0K7Js+Gp/CRvS2y411arZj5aA7EW+qgys2L
 eSnblhK2rbUqh+kjpWrXE9HqzgK/fZPjpOXZgkP/bW+5xYei1OOD/gWwViRx+v42R4RurEo7Q
 SUHqfXA8SROVuRPQ2BqsWN78h7O1aHTmAZkqQ9v74ySlDOtakMUNUeObeDFfRM4DxZyQhyAmg
 jHwJV1vSVh4vu4RPpirNNEppUV0VU8GBP9VJUc7ea+5mVmzTVU5fx1T5Bv6n17Qspywc+YzWf
 azfcaqyQbANe4erhQr3q/4sIzv8PVhn2A8iyManBx5Ki07p+Ow+kquc0QexydmlfMg+PiDNKp
 j7axKirR/LV0ABRNUjGP65aM4jxOeFni61kTN0X94onTHwEdAUiKrzaNsG6mRf1AI+NwJlkpq
 MebMpNqLUdANRki6OwF5+PAqsyfoT4f2ci4t2kZZUQ2yg5lSwdIa4VavPR0/JCkilryIbysty
 j8M+EhYvJ9wwr+uxZ8BX/vLmEE2zG4nn7duPyw==
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

clang gets confused by an uninitialized variable in what looks
to it like a never executed code path:

arch/x86/kernel/acpi/boot.c:618:13: error: variable 'polarity' is uninitialized when used here [-Werror,-Wuninitialized]
        polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
                   ^~~~~~~~
arch/x86/kernel/acpi/boot.c:606:32: note: initialize the variable 'polarity' to silence this warning
        int rc, irq, trigger, polarity;
                                      ^
                                       = 0
arch/x86/kernel/acpi/boot.c:617:12: error: variable 'trigger' is uninitialized when used here [-Werror,-Wuninitialized]
        trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
                  ^~~~~~~
arch/x86/kernel/acpi/boot.c:606:22: note: initialize the variable 'trigger' to silence this warning
        int rc, irq, trigger, polarity;
                            ^
                             = 0

This is unfortunately a design decision in clang and won't be fixed.

Changing the acpi_get_override_irq() macro to an inline function
reliably avoids the issue.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/acpi.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a95cce5e82e7..9426b9aaed86 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -324,7 +324,10 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-#define acpi_get_override_irq(gsi, trigger, polarity) (-1)
+static inline int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
+{
+	return -1;
+}
 #endif
 /*
  * This function undoes the effect of one call to acpi_register_gsi().
-- 
2.20.0

