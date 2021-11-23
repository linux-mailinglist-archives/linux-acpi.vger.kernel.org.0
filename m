Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A3345A9A1
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhKWRJX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:09:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:51483 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233715AbhKWRJW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:09:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233785223"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="233785223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:03:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="497344837"
Received: from wangxu2-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.67])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:03:38 -0800
Date:   Wed, 24 Nov 2021 01:03:32 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power/acpi: Fix the compile error when output
 directory is specified
Message-ID: <20211123170332.GA27921@chenyu5-mobl1>
References: <20211123132330.1008671-1-yu.c.chen@intel.com>
 <YZzyQ2FD2meImsHD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZzyQ2FD2meImsHD@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 03:53:07PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 23, 2021 at 09:23:30PM +0800, Chen Yu wrote:
> > Compiling the tool when output directory parameter is specified would
> > trigger the following error:
> > 
> > make O=/data/test/tmp/ -C tools/power/acpi/
> > 
> > make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
> >   DESCEND tools/acpidbg
> > make[1]: Entering directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
> >   MKDIR    include
> >   CP       include
> >   CC       tools/acpidbg/acpidbg.o
> > Assembler messages:
> > Fatal error: can't create /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o: No such file or directory
> > make[1]: *** [../../Makefile.rules:24: /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o] Error 1
> > make[1]: Leaving directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
> > make: *** [Makefile:18: acpidbg] Error 2
> > make: Leaving directory '/data/src/kernel/linux/tools/power/acpi'
> > 
> > This is because the output directory has not been created yet. Fix this issue by
> > creating the output directory before compiling.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Thanks!
>
Thanks for review. 
> >  
> >  $(objdir)%.o: %.c $(KERNEL_INCLUDE)
> >  	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
> > +	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
> 
> Not sure we need the `2>/dev/null` part.
> 
If the 'O=' is a read-only directory, mkdir would print errors
and adding 2> would avoid printing it. So the user could focus
on the real compile error.

without '2>'  :
make O=/data/test/tmp -C tools/power/acpi/
make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
  DESCEND tools/acpidbg
mkdir: cannot create directory ‘/data/test/tmp/tools’: Permission denied


thanks,
Chenyu
> >  	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
> >  
> >  all: $(OUTPUT)$(TOOL)
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
