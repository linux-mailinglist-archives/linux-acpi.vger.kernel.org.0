Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593E345A3AC
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 14:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhKWN1l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 08:27:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:36785 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhKWN1k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 08:27:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234967619"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="234967619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="456693627"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga003.jf.intel.com with ESMTP; 23 Nov 2021 05:24:30 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] tools/power/acpi: Fix the compile error when output directory is specified
Date:   Tue, 23 Nov 2021 21:23:30 +0800
Message-Id: <20211123132330.1008671-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Compiling the tool when output directory parameter is specified would
trigger the following error:

make O=/data/test/tmp/ -C tools/power/acpi/

make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
  DESCEND tools/acpidbg
make[1]: Entering directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
  MKDIR    include
  CP       include
  CC       tools/acpidbg/acpidbg.o
Assembler messages:
Fatal error: can't create /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o: No such file or directory
make[1]: *** [../../Makefile.rules:24: /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o] Error 1
make[1]: Leaving directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
make: *** [Makefile:18: acpidbg] Error 2
make: Leaving directory '/data/src/kernel/linux/tools/power/acpi'

This is because the output directory has not been created yet. Fix this issue by
creating the output directory before compiling.

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/acpi/Makefile.config | 1 +
 tools/power/acpi/Makefile.rules  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 331f6d30f472..cd7106876a5f 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -69,6 +69,7 @@ KERNEL_INCLUDE := $(OUTPUT)include
 ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
 CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
 CFLAGS += $(WARNINGS)
+MKDIR = mkdir
 
 ifeq ($(strip $(V)),false)
 	QUIET=@
diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
index 2a6c170b57cd..1d7616f5d0ae 100644
--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -21,6 +21,7 @@ $(KERNEL_INCLUDE):
 
 $(objdir)%.o: %.c $(KERNEL_INCLUDE)
 	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
+	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
 	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
 
 all: $(OUTPUT)$(TOOL)
-- 
2.25.1

