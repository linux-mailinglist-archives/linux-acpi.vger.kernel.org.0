Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B764915466C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBFOpx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 09:45:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:55868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgBFOpx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Feb 2020 09:45:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08038ABEA;
        Thu,  6 Feb 2020 14:45:52 +0000 (UTC)
Date:   Thu, 6 Feb 2020 15:45:32 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: Forcing non-ACPI watchdog driver
Message-ID: <20200206154532.359086d6@endymion>
In-Reply-To: <20200205163831.GG2667@lahna.fi.intel.com>
References: <1580915129.23547.3.camel@suse.de>
        <20200205152435.GE2667@lahna.fi.intel.com>
        <20200205163048.GD25403@roeck-us.net>
        <20200205163831.GG2667@lahna.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mika,

On Wed, 5 Feb 2020 18:38:31 +0200, Mika Westerberg wrote:
> On Wed, Feb 05, 2020 at 08:30:48AM -0800, Guenter Roeck wrote:
> > On Wed, Feb 05, 2020 at 05:24:35PM +0200, Mika Westerberg wrote:  
> > > You should be able to revert to iTCO_wdt by simply disabling
> > > CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
> > > which means that iTCO_wdt is used instead.  
> > 
> > That may not be possible in a generic distribution.  
> 
> Right, they would need to build their own kernel. Currently there is no
> way to do that without changing .config.

OK, that's pretty much what I was compl^Wworried about ;-) Would you
consider applying something like the following patch?

From: Jean Delvare <jdelvare@suse.de>
Subject: ACPI / watchdog: Allow disabling WDAT at boot

In case the WDAT interface is broken, give the user the option to
ignore it to let a native driver bind to the watchdog device instead.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 ++++
 drivers/acpi/acpi_watchdog.c                    |   12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--- linux-5.4.orig/drivers/acpi/acpi_watchdog.c	2020-02-06 15:20:27.187333079 +0100
+++ linux-5.4/drivers/acpi/acpi_watchdog.c	2020-02-06 15:30:08.707408406 +0100
@@ -55,12 +55,14 @@ static bool acpi_watchdog_uses_rtc(const
 }
 #endif
 
+static bool acpi_no_watchdog;
+
 static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
 {
 	const struct acpi_table_wdat *wdat = NULL;
 	acpi_status status;
 
-	if (acpi_disabled)
+	if (acpi_disabled || acpi_no_watchdog)
 		return NULL;
 
 	status = acpi_get_table(ACPI_SIG_WDAT, 0,
@@ -88,6 +90,14 @@ bool acpi_has_watchdog(void)
 }
 EXPORT_SYMBOL_GPL(acpi_has_watchdog);
 
+/* ACPI watchdog can be disabled on boot command line */
+static int __init disable_acpi_watchdog(char *str)
+{
+	acpi_no_watchdog = true;
+	return 1;
+}
+__setup("acpi_no_watchdog", disable_acpi_watchdog);
+
 void __init acpi_watchdog_init(void)
 {
 	const struct acpi_wdat_entry *entries;
--- linux-5.4.orig/Documentation/admin-guide/kernel-parameters.txt	2020-02-06 15:20:27.187333079 +0100
+++ linux-5.4/Documentation/admin-guide/kernel-parameters.txt	2020-02-06 15:31:16.614155680 +0100
@@ -136,6 +136,10 @@
 			dynamic table installation which will install SSDT
 			tables to /sys/firmware/acpi/tables/dynamic.
 
+	acpi_no_watchdog	[HW,ACPI,WDT]
+			Ignore the ACPI-based watchdog interface (WDAT) and let
+			a native driver control the watchdog device instead.
+
 	acpi_rsdp=	[ACPI,EFI,KEXEC]
 			Pass the RSDP address to the kernel, mostly used
 			on machines running EFI runtime service to boot the

Thanks,
-- 
Jean Delvare
SUSE L3 Support
