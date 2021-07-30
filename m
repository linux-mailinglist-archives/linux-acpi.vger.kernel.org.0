Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C53DB829
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jul 2021 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhG3MBH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 30 Jul 2021 08:01:07 -0400
Received: from mx1.emlix.com ([136.243.223.33]:42238 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238275AbhG3MBH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Jul 2021 08:01:07 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C9B575F82D;
        Fri, 30 Jul 2021 13:52:05 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-acpi@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 1/2] tools/thermal: tmon: simplify Makefile
Date:   Fri, 30 Jul 2021 13:49:04 +0200
Message-ID: <1951386.ZPQrlMDjM2@devpool47>
Organization: emlix GmbH
In-Reply-To: <2149399.oOxd0sxVbX@devpool47>
References: <2149399.oOxd0sxVbX@devpool47>
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
index 9db867df76794..3e650878ea824 100644
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
2.32.0

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



