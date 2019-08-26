Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354F79D0B5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfHZNeu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 09:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfHZNeu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 09:34:50 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D702053B;
        Mon, 26 Aug 2019 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566826489;
        bh=J15dobAyAiPcoi9K2hHV1JPfrfxKHe5HttHtObVxoUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz1ahVJaWnyyuTHGw8aCOngvZmA5M7WMFjHz3CzsEpttgxVJXDRywkTu3p0Y+5Obt
         w/pvdLPDw+1Uys/nGqi/bbskdGR1REVbsUlN28MXkea2/S9pa26sSLYiNkvyCTgdqH
         nuBtULzqvj8AjcmmIL6poINxQpKz1q6DLDHjJA/w=
Date:   Mon, 26 Aug 2019 15:34:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826133439.GA13275@kroah.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
 <20190826084343.GA1095@kroah.com>
 <20190826103200.GQ31967@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826103200.GQ31967@paasikivi.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 26, 2019 at 01:32:00PM +0300, Sakari Ailus wrote:
> Hi Greg,
> 
> On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:
> 
> ...
> 
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 6717adee33f01..4bc0ea4a3201a 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -248,6 +248,12 @@ enum probe_type {
> > >   * @owner:	The module owner.
> > >   * @mod_name:	Used for built-in modules.
> > >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > > + * @probe_low_power: The driver supports its probe function being called while
> > > + *		     the device is in a low power state, independently of the
> > > + *		     expected behaviour on combination of a given bus and
> > > + *		     firmware interface etc. The driver is responsible for
> > > + *		     powering the device on using runtime PM in such case.
> > > + *		     This configuration has no effect if CONFIG_PM is disabled.
> > >   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> > >   * @of_match_table: The open firmware table.
> > >   * @acpi_match_table: The ACPI match table.
> > > @@ -285,6 +291,7 @@ struct device_driver {
> > >  	const char		*mod_name;	/* used for built-in modules */
> > >  
> > >  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> > > +	bool probe_low_power;
> > 
> > Ick, no, this should be a bus-specific thing to handle such messed up
> > hardware.  Why polute this in the driver core?
> 
> The alternative could be to make it I²C specific indeed; the vast majority
> of camera sensors are I²C devices these days.

Why is this even needed to be a bus/device attribute at all?  You are
checking the firmware property in the probe function, just do the logic
there as you are, what needs to be saved to the bus's logic?

thanks,

greg k-h
