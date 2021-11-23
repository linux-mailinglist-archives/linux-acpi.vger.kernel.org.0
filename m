Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98A45A420
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhKWN40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 08:56:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:22420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhKWN4Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 08:56:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215733332"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215733332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:53:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="457058410"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:53:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpWEN-009nIY-Fw;
        Tue, 23 Nov 2021 15:53:07 +0200
Date:   Tue, 23 Nov 2021 15:53:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power/acpi: Fix the compile error when output
 directory is specified
Message-ID: <YZzyQ2FD2meImsHD@smile.fi.intel.com>
References: <20211123132330.1008671-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123132330.1008671-1-yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 09:23:30PM +0800, Chen Yu wrote:
> Compiling the tool when output directory parameter is specified would
> trigger the following error:
> 
> make O=/data/test/tmp/ -C tools/power/acpi/
> 
> make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
>   DESCEND tools/acpidbg
> make[1]: Entering directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
>   MKDIR    include
>   CP       include
>   CC       tools/acpidbg/acpidbg.o
> Assembler messages:
> Fatal error: can't create /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o: No such file or directory
> make[1]: *** [../../Makefile.rules:24: /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o] Error 1
> make[1]: Leaving directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
> make: *** [Makefile:18: acpidbg] Error 2
> make: Leaving directory '/data/src/kernel/linux/tools/power/acpi'
> 
> This is because the output directory has not been created yet. Fix this issue by
> creating the output directory before compiling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  tools/power/acpi/Makefile.rules  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 331f6d30f472..cd7106876a5f 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -69,6 +69,7 @@ KERNEL_INCLUDE := $(OUTPUT)include
>  ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
>  CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS += $(WARNINGS)
> +MKDIR = mkdir
>  
>  ifeq ($(strip $(V)),false)
>  	QUIET=@
> diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
> index 2a6c170b57cd..1d7616f5d0ae 100644
> --- a/tools/power/acpi/Makefile.rules
> +++ b/tools/power/acpi/Makefile.rules
> @@ -21,6 +21,7 @@ $(KERNEL_INCLUDE):
>  
>  $(objdir)%.o: %.c $(KERNEL_INCLUDE)
>  	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
> +	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null

Not sure we need the `2>/dev/null` part.

>  	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
>  
>  all: $(OUTPUT)$(TOOL)
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


