Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51C99CD45
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfHZK3M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 06:29:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:51121 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfHZK3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 06:29:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 03:29:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="197023719"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 03:29:09 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id D3E6820B47; Mon, 26 Aug 2019 13:29:07 +0300 (EEST)
Date:   Mon, 26 Aug 2019 13:29:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826102907.GP31967@paasikivi.fi.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
 <20190826084634.GB1095@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826084634.GB1095@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,

Thanks for the comments.

On Mon, Aug 26, 2019 at 10:46:34AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 11:31:08AM +0300, Sakari Ailus wrote:
> > Allow drivers and firmware tell ACPI that there's no need to power on a
> > device for probe. This requires both a hint from the firmware as well as
> > an indication from a driver to leave the device off.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/device_pm.c | 15 +++++++++++++--
> >  include/linux/device.h   |  7 +++++++
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index f616b16c1f0be..adcdf78ce4de8 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -1276,7 +1276,12 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
> >  	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
> >  		dev_pm_domain_set(dev, NULL);
> >  		acpi_remove_pm_notifier(adev);
> > -		if (power_off) {
> > +		if (power_off
> > +#ifdef CONFIG_PM
> > +		    && !(dev->driver->probe_low_power &&
> > +			 device_property_present(dev, "probe-low-power"))
> > +#endif
> 
> As proof of the "only a bus-specific thing", why is probe_low_power even
> needed?  Why not just always trigger off of this crazy device_property?
> That makes the driver changes less.

That's an option, too, but firmware having this property for a device the
driver of which doesn't expect it will fail to power on the device for
probe. This leaves some room for unexpected failures that admittedly are
easy to fix, but could be harder to debug.

> 
> Also, is this #ifdef really needed?

I thought it was but it seems if CONFIG_PM is disabled,
dev_pm_domain_attach() has a nop implementation. So I agree it is not.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
