Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E131EC78
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Feb 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhBRQqE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 18 Feb 2021 11:46:04 -0500
Received: from mx1.emlix.com ([136.243.223.33]:57412 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhBRNJY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 08:09:24 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C54225FC20;
        Thu, 18 Feb 2021 13:29:30 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-acpi@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2 RESEND] tools/thermal: tmon: simplify Makefile
Date:   Thu, 18 Feb 2021 13:29:30 +0100
Message-ID: <5568216.dqZi6GYWaa@devpool47>
Organization: emlix GmbH
In-Reply-To: <3551127.BzHy4GdJBa@devpool21>
References: <3551127.BzHy4GdJBa@devpool21>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 tools/thermal/tmon/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 59e417ec3e13..36dc70497066 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -13,7 +13,6 @@ CC?= $(CROSS_COMPILE)gcc
 PKG_CONFIG?= pkg-config
 
 override CFLAGS+=-D VERSION=\"$(VERSION)\"
-LDFLAGS+=
 TARGET=tmon
 
 INSTALL_PROGRAM=install -m 755 -p
@@ -33,7 +32,6 @@ override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /
 		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
-OBJS +=
 
 tmon: $(OBJS) Makefile tmon.h
 	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS)  -o $(TARGET) $(TMON_LIBS)
@@ -42,15 +40,13 @@ valgrind: tmon
 	 sudo valgrind -v --track-origins=yes --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=20 --track-fds=yes ./$(TARGET)  1> /dev/null
 
 install:
-	- mkdir -p $(INSTALL_ROOT)/$(BINDIR)
-	- $(INSTALL_PROGRAM) "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+	- $(INSTALL_PROGRAM) -D "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
 uninstall:
 	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
 clean:
-	find . -name "*.o" | xargs $(DEL_FILE)
-	rm -f $(TARGET)
+	rm -f $(TARGET) $(OBJS)
 
 dist:
 	git tag v$(VERSION)
-- 
2.30.0


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



