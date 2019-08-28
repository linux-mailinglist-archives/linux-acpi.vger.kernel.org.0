Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46F9FDA4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfH1Izy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 28 Aug 2019 04:55:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44961 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfH1Izy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Aug 2019 04:55:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so1980203ote.11;
        Wed, 28 Aug 2019 01:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mmNh7TCZzrfQu4dpCLq683e3Q8F8Ju4FY9urUanFkys=;
        b=JKAnayug82FSVO/2f2cI4d6o8jdZAwjiFxRI94DFJGvB8Bl49Cb9suGHeX7RmCvZ03
         mexaip8eu84t2NXVWXcTeSF3j6HQm61W88Ts024bH/ystN+6pFTcYa6VS26w9cCWZ+I/
         XJcGo4eiq+svgpIbVxcqDklafjhaVSYvp5YxWKpt16QOu6L0+Q84AdvbTpi2nTbzph2b
         Ei7zt/OV10ONgawrkHaHnSjjGeKEVJ6rBWwrKAtX3z0gm04k6e77Y+P9V6RLAPOb6zDD
         JeRDnXEHHlR0pKLn8fGFQA6Xnt55pFf/8M1wF5jb6I/TuPoGx9QNrTgsdyAX2mjNmKLf
         ZKqA==
X-Gm-Message-State: APjAAAW/Sq5syWAPkjvV3+CNAInB4D+uFnOTiJHArX32EMkL4uFaM88V
        Q6BEN+9nUrwu941t7b/kZW/HLxDoHID8SM4eiYw=
X-Google-Smtp-Source: APXvYqzvCCzqmpJv/pCz10tOxmmDVAhwvGdkAVIKUcvjSYf1AHXomLL9szBu1nmbePqxuYZKK1+iLjJWbNyP+JvP+28=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr2208451otm.118.1566982553420;
 Wed, 28 Aug 2019 01:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com> <20190826084343.GA1095@kroah.com>
 <20190826103200.GQ31967@paasikivi.fi.intel.com> <20190826133439.GA13275@kroah.com>
In-Reply-To: <20190826133439.GA13275@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Aug 2019 10:55:42 +0200
Message-ID: <CAJZ5v0jmsPO5m2zBV3_j8LgqQ2Uj6euXUCJgT74L93hZP9nP_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 26, 2019 at 3:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 26, 2019 at 01:32:00PM +0300, Sakari Ailus wrote:
> > Hi Greg,
> >
> > On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:
> >
> > ...
> >
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index 6717adee33f01..4bc0ea4a3201a 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -248,6 +248,12 @@ enum probe_type {
> > > >   * @owner:       The module owner.
> > > >   * @mod_name:    Used for built-in modules.
> > > >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > > > + * @probe_low_power: The driver supports its probe function being called while
> > > > + *                    the device is in a low power state, independently of the
> > > > + *                    expected behaviour on combination of a given bus and
> > > > + *                    firmware interface etc. The driver is responsible for
> > > > + *                    powering the device on using runtime PM in such case.
> > > > + *                    This configuration has no effect if CONFIG_PM is disabled.
> > > >   * @probe_type:  Type of the probe (synchronous or asynchronous) to use.
> > > >   * @of_match_table: The open firmware table.
> > > >   * @acpi_match_table: The ACPI match table.
> > > > @@ -285,6 +291,7 @@ struct device_driver {
> > > >   const char              *mod_name;      /* used for built-in modules */
> > > >
> > > >   bool suppress_bind_attrs;       /* disables bind/unbind via sysfs */
> > > > + bool probe_low_power;
> > >
> > > Ick, no, this should be a bus-specific thing to handle such messed up
> > > hardware.  Why polute this in the driver core?
> >
> > The alternative could be to make it I²C specific indeed; the vast majority
> > of camera sensors are I²C devices these days.
>
> Why is this even needed to be a bus/device attribute at all?  You are
> checking the firmware property in the probe function, just do the logic
> there as you are, what needs to be saved to the bus's logic?

The situation today is that all devices are put into D0 by the ACPI
layer before driver probing since drivers generally expect devices to
be in D0 when their probe routines run.  If the driver is prepared to
cope with devices in low-power states, though, powering them up before
probing for a driver may not be necessary, but still the core (or
generally the code invoking the driver probe) needs to know that the
driver really is prepared for that.  Hence the driver flag AFAICS.

Now, in theory there may be some platform requirements regarding the
power states of devices during driver probe, although admittedly it is
not entirely clear to me why that would be the case) and hence the
property.  I would think that if the driver could cope with devices in
low-power states during probe, the platform wouldn't need to worry
about that.
