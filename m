Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82B45919F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhKVPwC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 10:52:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:55738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239850AbhKVPwC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 10:52:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="222030849"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="222030849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 07:48:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="674105379"
Received: from lvzhongw-mobl2.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.29.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 07:48:51 -0800
Date:   Mon, 22 Nov 2021 23:48:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v11 4/4] tools: Introduce power/acpi/tools/pfru
Message-ID: <20211122154842.GA10345@chenyu5-mobl1>
References: <cover.1637505679.git.yu.c.chen@intel.com>
 <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
 <YZt+VPI2n/MED9O6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZt+VPI2n/MED9O6@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,
On Mon, Nov 22, 2021 at 01:26:12PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 21, 2021 at 11:17:29PM +0800, Chen Yu wrote:
> > Introduce a user space tool to make use of the interface exposed by
> > Platform Firmware Runtime Update and Telemetry drivers. The users
> > can use this tool to do firmware code injection, driver update and
> > to retrieve the telemetry data.
> 
> Have you tried to build tools with `make O=/my/tmp/folder/for/kernel/build ...`
> which previously has been used for kernel builds?
>
I was not aware of that and just had a try. It seems that there is an issue in
tools/power/acpi that, only with the following patch appiled, the make O=xxx
would work:

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

Should above patch be a separate one or folded in [4/4]?

thanks,
Chenyu
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
