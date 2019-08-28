Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876C59FEFA
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1J5G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Aug 2019 05:57:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:7349 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfH1J5F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Aug 2019 05:57:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 02:57:05 -0700
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="356062968"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 02:57:03 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 28B9620ABC; Wed, 28 Aug 2019 12:57:01 +0300 (EEST)
Date:   Wed, 28 Aug 2019 12:57:01 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190828095701.GC7657@paasikivi.fi.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
 <20190826084343.GA1095@kroah.com>
 <20190826103200.GQ31967@paasikivi.fi.intel.com>
 <20190826133439.GA13275@kroah.com>
 <CAJZ5v0jmsPO5m2zBV3_j8LgqQ2Uj6euXUCJgT74L93hZP9nP_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jmsPO5m2zBV3_j8LgqQ2Uj6euXUCJgT74L93hZP9nP_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Aug 28, 2019 at 10:55:42AM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2019 at 3:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 26, 2019 at 01:32:00PM +0300, Sakari Ailus wrote:
> > > Hi Greg,
> > >
> > > On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:
> > >
> > > ...
> > >
> > > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > > index 6717adee33f01..4bc0ea4a3201a 100644
> > > > > --- a/include/linux/device.h
> > > > > +++ b/include/linux/device.h
> > > > > @@ -248,6 +248,12 @@ enum probe_type {
> > > > >   * @owner:       The module owner.
> > > > >   * @mod_name:    Used for built-in modules.
> > > > >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > > > > + * @probe_low_power: The driver supports its probe function being called while
> > > > > + *                    the device is in a low power state, independently of the
> > > > > + *                    expected behaviour on combination of a given bus and
> > > > > + *                    firmware interface etc. The driver is responsible for
> > > > > + *                    powering the device on using runtime PM in such case.
> > > > > + *                    This configuration has no effect if CONFIG_PM is disabled.
> > > > >   * @probe_type:  Type of the probe (synchronous or asynchronous) to use.
> > > > >   * @of_match_table: The open firmware table.
> > > > >   * @acpi_match_table: The ACPI match table.
> > > > > @@ -285,6 +291,7 @@ struct device_driver {
> > > > >   const char              *mod_name;      /* used for built-in modules */
> > > > >
> > > > >   bool suppress_bind_attrs;       /* disables bind/unbind via sysfs */
> > > > > + bool probe_low_power;
> > > >
> > > > Ick, no, this should be a bus-specific thing to handle such messed up
> > > > hardware.  Why polute this in the driver core?
> > >
> > > The alternative could be to make it I²C specific indeed; the vast majority
> > > of camera sensors are I²C devices these days.
> >
> > Why is this even needed to be a bus/device attribute at all?  You are
> > checking the firmware property in the probe function, just do the logic
> > there as you are, what needs to be saved to the bus's logic?
> 
> The situation today is that all devices are put into D0 by the ACPI
> layer before driver probing since drivers generally expect devices to
> be in D0 when their probe routines run.  If the driver is prepared to
> cope with devices in low-power states, though, powering them up before
> probing for a driver may not be necessary, but still the core (or
> generally the code invoking the driver probe) needs to know that the
> driver really is prepared for that.  Hence the driver flag AFAICS.
> 
> Now, in theory there may be some platform requirements regarding the
> power states of devices during driver probe, although admittedly it is
> not entirely clear to me why that would be the case) and hence the

Please see the cover page of the set (also here):

<URL:https://lkml.org/lkml/2019/8/26/175>

> property.  I would think that if the driver could cope with devices in
> low-power states during probe, the platform wouldn't need to worry
> about that.

I understand this as driver deciding whether it'd power on the device
during probe.

That way there's no way to judge whether the device is accessible, and
probe would succeed without an error, which then manifests itself on the
first access of the device. Such as on the at24 EEPROM driver, the error
would take place on first read of the contents, not in probe.

Somebody might consider that as a driver bug.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
