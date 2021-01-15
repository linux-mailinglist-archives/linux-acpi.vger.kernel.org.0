Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDD2F7D4D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbhAONzH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 08:55:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53712 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733010AbhAONzH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 08:55:07 -0500
Received: from 89-64-81-100.dynamic.chello.pl (89.64.81.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id ad16ed3bd0b55fbb; Fri, 15 Jan 2021 14:54:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
Date:   Fri, 15 Jan 2021 14:54:24 +0100
Message-ID: <2473340.5W3TeCB90J@kreacher>
In-Reply-To: <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com> <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com> <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, January 15, 2021 1:49:17 AM CET Pierre-Louis Bossart wrote:
> Thanks Hans for your reply, much appreciated.
> 
> > Pierre-Louis, can you see if the following hack helps? :
> > 
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1939,7 +1939,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> >   		/* Bail out if the number of recorded dependencies is not 0. */
> >   		if (count > 0) {
> >   			acpi_bus_scan_second_pass = true;
> > -			return AE_CTRL_DEPTH;
> >   		}
> >   	}
> >   
> > @@ -1948,8 +1947,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> >   		return AE_CTRL_DEPTH;
> >   
> >   	acpi_scan_init_hotplug(device);
> > -	if (!check_dep)
> > -		acpi_scan_dep_init(device);
> > +	acpi_scan_dep_init(device);
> >   
> >   out:
> >   	if (!*adev_p)
> 
> Yep, those 'hacks' solve the boot problem on my device. I tried multiple 
> times and it's completely reproducible.
> 
> > And can you collect an acpidump from the device and either send it to me and Rafael
> > offlist, or upload it somewhere and send us a link ?
> 
> will do

In addition to what Hans asked for, can you please build the kernel with the
debug patch below applied (instead of the Hans' debug patch), try to boot
the affected machine with it and see what is missing with respect to booting
the kernel with the two problematic commits reverted?

Also please send me the outout of "dmesg | grep "Enumeration" from the debug
kernel if possible.

---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1951,7 +1951,7 @@ static acpi_status acpi_bus_check_add(ac
 		u32 count = acpi_scan_check_dep(handle);
 		/* Bail out if the number of recorded dependencies is not 0. */
 		if (count > 0) {
-			acpi_bus_scan_second_pass = true;
+			acpi_handle_info(handle, "Enumeration skipped\n");
 			return AE_CTRL_DEPTH;
 		}
 	}



