Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E77A01DB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfH1MgA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 28 Aug 2019 08:36:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40235 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1Mf7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Aug 2019 08:35:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so2565098otb.7;
        Wed, 28 Aug 2019 05:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8QDH9jpinSuXfS+ZOI90wcZgvUUIjZNcFdkdHit9RCY=;
        b=MGVqp5aRVR8oKT+Yo25Ujqb64JrB5PcCJ7FnHBQajzIrdYNIIE8N4+dhxYUIiumsPl
         pDVwBJmRnxfLO3X/1eQ6biwPeUjUN6DWITI+mGDc6Dsim4Xe+bcVzFgp4YcQxbEfQxiK
         XJGuN0kGOU0RhElDBp1JeE/OB0OQIaxkYOhgAF6BSHlVKmq7j56lqMB+eBLALpSfyqoD
         RYiYYKDWh3vz+fyu7xeBs1i3yArf+Mhy6hD2TkF0POG21Dk50C+I6YOvbWph0T/dX5B9
         N8mMwRKge3mw6VQOwkYo7mDAUeR7jfqEcS0vnvMey9/5L98Y6OKxHtcJpll94pwCHM/L
         xuyw==
X-Gm-Message-State: APjAAAWRcnAAEAk+rzeWiqchhIMXM2r+C3BxM3kI+fg+wifucTbljMi3
        zbw0bLsHAaTz8jcxoZtFBNzzN/FYyd7xRU7V4UbFYA==
X-Google-Smtp-Source: APXvYqykwnj9n9QqtXyldmv4OqFTxHAgh7E3a+SF0O/1IY+hlXF/oXNDosKbW38kWtSu6Dhda2kbUI8M3d2WCe9UBOQ=
X-Received: by 2002:a9d:12d1:: with SMTP id g75mr2946048otg.189.1566995758287;
 Wed, 28 Aug 2019 05:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com> <20190826084343.GA1095@kroah.com>
 <20190826103200.GQ31967@paasikivi.fi.intel.com> <20190826133439.GA13275@kroah.com>
 <CAJZ5v0jmsPO5m2zBV3_j8LgqQ2Uj6euXUCJgT74L93hZP9nP_A@mail.gmail.com> <20190828095701.GC7657@paasikivi.fi.intel.com>
In-Reply-To: <20190828095701.GC7657@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Aug 2019 14:35:46 +0200
Message-ID: <CAJZ5v0gLPyJ7zDGTCLsv94fn4JJSmPEEpxwNJQyfU+RyveEspQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 28, 2019 at 11:57 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Aug 28, 2019 at 10:55:42AM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 26, 2019 at 3:34 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Aug 26, 2019 at 01:32:00PM +0300, Sakari Ailus wrote:
> > > > Hi Greg,
> > > >
> > > > On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:
> > > >
> > > > ...
> > > >
> > > > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > > > index 6717adee33f01..4bc0ea4a3201a 100644
> > > > > > --- a/include/linux/device.h
> > > > > > +++ b/include/linux/device.h
> > > > > > @@ -248,6 +248,12 @@ enum probe_type {
> > > > > >   * @owner:       The module owner.
> > > > > >   * @mod_name:    Used for built-in modules.
> > > > > >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > > > > > + * @probe_low_power: The driver supports its probe function being called while
> > > > > > + *                    the device is in a low power state, independently of the
> > > > > > + *                    expected behaviour on combination of a given bus and
> > > > > > + *                    firmware interface etc. The driver is responsible for
> > > > > > + *                    powering the device on using runtime PM in such case.
> > > > > > + *                    This configuration has no effect if CONFIG_PM is disabled.
> > > > > >   * @probe_type:  Type of the probe (synchronous or asynchronous) to use.
> > > > > >   * @of_match_table: The open firmware table.
> > > > > >   * @acpi_match_table: The ACPI match table.
> > > > > > @@ -285,6 +291,7 @@ struct device_driver {
> > > > > >   const char              *mod_name;      /* used for built-in modules */
> > > > > >
> > > > > >   bool suppress_bind_attrs;       /* disables bind/unbind via sysfs */
> > > > > > + bool probe_low_power;
> > > > >
> > > > > Ick, no, this should be a bus-specific thing to handle such messed up
> > > > > hardware.  Why polute this in the driver core?
> > > >
> > > > The alternative could be to make it I²C specific indeed; the vast majority
> > > > of camera sensors are I²C devices these days.
> > >
> > > Why is this even needed to be a bus/device attribute at all?  You are
> > > checking the firmware property in the probe function, just do the logic
> > > there as you are, what needs to be saved to the bus's logic?
> >
> > The situation today is that all devices are put into D0 by the ACPI
> > layer before driver probing since drivers generally expect devices to
> > be in D0 when their probe routines run.  If the driver is prepared to
> > cope with devices in low-power states, though, powering them up before
> > probing for a driver may not be necessary, but still the core (or
> > generally the code invoking the driver probe) needs to know that the
> > driver really is prepared for that.  Hence the driver flag AFAICS.
> >
> > Now, in theory there may be some platform requirements regarding the
> > power states of devices during driver probe, although admittedly it is
> > not entirely clear to me why that would be the case) and hence the
>
> Please see the cover page of the set (also here):
>
> <URL:https://lkml.org/lkml/2019/8/26/175>
>
> > property.  I would think that if the driver could cope with devices in
> > low-power states during probe, the platform wouldn't need to worry
> > about that.
>
> I understand this as driver deciding whether it'd power on the device
> during probe.
>
> That way there's no way to judge whether the device is accessible, and
> probe would succeed without an error, which then manifests itself on the
> first access of the device.

OK, so the property really represents the platform preference in that
respect and the presence of it by no means guarantees that there won't
be any problems on the first device access.

> Such as on the at24 EEPROM driver, the error
> would take place on first read of the contents, not in probe.
>
> Somebody might consider that as a driver bug.

Well, I guess you can argue that the safer thing, which therefore
should be the default, is to power up the device before probing and to
check whether or not it is accessible at that time.  However, in some
cases it may be desirable to avoid powering up the device at that
point, whatever the reason, and the property provides a hint about
that.

Fair enough to me, but honestly I'm not sure about the example in the
cover letter. :-)
