Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CF51EFC
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfFXXOR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 19:14:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51293 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXOQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jun 2019 19:14:16 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8612bd51ee35b0e6; Tue, 25 Jun 2019 01:14:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Robert R. Howell" <RHowell@uwyo.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate on BYT/CHT
Date:   Tue, 25 Jun 2019 01:14:13 +0200
Message-ID: <1935381.LvnFHGipmV@kreacher>
In-Reply-To: <b02ef915-faf5-635d-bf2f-92dd10d274b1@redhat.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com> <2830645.pXxymQ5XCC@kreacher> <b02ef915-faf5-635d-bf2f-92dd10d274b1@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, June 24, 2019 12:51:33 PM CEST Hans de Goede wrote:
> Hi Rafael,
> 
> <snip>
> 
> > Sorry for the long delay.
> > 
> > I haven't dropped this issue on the floor, I hope that you are still able to follow up here.
> > 
> > Can you please test the appended patch instead of the previous one?
> > 
> > I have found some inconsistencies in the handling of hibernation in the ACPI PM domain
> > and the LPSS driver that should be covered by this patch.
> 
> I know this is just a testing patch for now, but still I've given it
> a quick look, some comments inline.
> 
> > ---
> >   drivers/acpi/acpi_lpss.c |   63 +++++++++++++++++++++++++++++++++++------------
> >   drivers/acpi/device_pm.c |   30 ++++++++++++++++++++--
> >   include/linux/acpi.h     |    4 ++
> >   3 files changed, 79 insertions(+), 18 deletions(-)
> > 
> > Index: linux-pm/drivers/acpi/device_pm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -1171,6 +1171,32 @@ int acpi_subsys_thaw_noirq(struct device
> >   	return pm_generic_thaw_noirq(dev);
> >   }
> >   EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
> > +
> > +/**
> > + * acpi_subsys_restore_noirq - Run the device driver's "noirq" restore callback.
> > + * @dev: Device to handle.
> > + */
> > +int acpi_subsys_restore_noirq(struct device *dev)
> > +{
> > +	/* This is analogous to what acpi_subsys_resune_noirq() does. */
> > +	if (dev_pm_smart_suspend_and_suspended(dev))
> > +		pm_runtime_set_active(dev);
> > +
> > +	return pm_generic_restore_noirq(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_subsys_restore_noirq);
> > +
> > +/**
> > + * acpi_subsys_restore_early - Restore device using ACPI.
> > + * @dev: Device to restore.
> > + */
> > +int acpi_subsys_restore_early(struct device *dev)
> > +{
> > +	int ret = acpi_dev_resume(dev);
> > +	return ret ? ret : pm_generic_restore_early(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
> > +
> >   #endif /* CONFIG_PM_SLEEP */
> >   
> >   static struct dev_pm_domain acpi_general_pm_domain = {
> > @@ -1192,8 +1218,8 @@ static struct dev_pm_domain acpi_general
> >   		.poweroff = acpi_subsys_suspend,
> >   		.poweroff_late = acpi_subsys_suspend_late,
> >   		.poweroff_noirq = acpi_subsys_suspend_noirq,
> > -		.restore_noirq = acpi_subsys_resume_noirq,
> > -		.restore_early = acpi_subsys_resume_early,
> > +		.restore_noirq = acpi_subsys_restore_noirq,
> > +		.restore_early = acpi_subsys_restore_early,
> >   #endif
> >   	},
> >   };
> > Index: linux-pm/drivers/acpi/acpi_lpss.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> > +++ linux-pm/drivers/acpi/acpi_lpss.c
> > @@ -1069,36 +1069,67 @@ static int acpi_lpss_suspend_noirq(struc
> >   	return acpi_subsys_suspend_noirq(dev);
> >   }
> >   
> > -static int acpi_lpss_do_resume_early(struct device *dev)
> > +static int acpi_lpss_resume_noirq(struct device *dev)
> >   {
> > -	int ret = acpi_lpss_resume(dev);
> > +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> > +
> > +	/* Follow acpi_subsys_resune_noirq(). */
> > +	if (dev_pm_may_skip_resume(dev))
> > +		return 0;
> > +
> > +	if (dev_pm_smart_suspend_and_suspended(dev))
> > +		pm_runtime_set_active(dev);
> >   
> > -	return ret ? ret : pm_generic_resume_early(dev);
> > +	if (pdata->dev_desc->resume_from_noirq) {
> > +		int ret = acpi_lpss_resume(dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return pm_generic_resume_noirq(dev);
> >   }
> 
> Hmm, normally acpi_lpss_resume runs at resume_early time, AFAIK
> the order of resume callbacks calling is: resume_noirq, resume_early, resume
> 
> So normally our call order is:
> 
> ---noirq-phase---
> pm_generic_resume_noirq()
> ---early-phase---
> acpi_lpss_resume()
> pm_generic_resume_early()
> 
> My patch adding the resume_from_noirq flag, move the calling of
> acpi_lpss_resume() to the resume_noirq phase (if the flag is
> set) but kept the generic order, so the call order with the
> flag set currently is:
> 
> ---noirq-phase---
> pm_generic_resume_noirq()
> acpi_lpss_resume()
> ---early-phase---
> pm_generic_resume_early()
> 
> So the order of the 3 calls relative to each other did not change.
> 
> You are changing this to:
> 
> ---noirq-phase---
> acpi_lpss_resume()
> pm_generic_resume_noirq()
> ---early-phase---
> pm_generic_resume_early()
> 
> So now when the flag is set acpi_lpss_resume() runs before
> pm_generic_resume_noirq(). Is this intentional ?

Kind of yes, but this is two patches in one. :-)

The ordering change should really be a separate patch IMO.



