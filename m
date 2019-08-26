Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556C79CD4D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfHZKcE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 06:32:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:63946 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbfHZKcE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 06:32:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 03:32:03 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="209316149"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 03:32:02 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 5A61120B47; Mon, 26 Aug 2019 13:32:00 +0300 (EEST)
Date:   Mon, 26 Aug 2019 13:32:00 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826103200.GQ31967@paasikivi.fi.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
 <20190826084343.GA1095@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826084343.GA1095@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,

On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:

...

> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 6717adee33f01..4bc0ea4a3201a 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -248,6 +248,12 @@ enum probe_type {
> >   * @owner:	The module owner.
> >   * @mod_name:	Used for built-in modules.
> >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > + * @probe_low_power: The driver supports its probe function being called while
> > + *		     the device is in a low power state, independently of the
> > + *		     expected behaviour on combination of a given bus and
> > + *		     firmware interface etc. The driver is responsible for
> > + *		     powering the device on using runtime PM in such case.
> > + *		     This configuration has no effect if CONFIG_PM is disabled.
> >   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> >   * @of_match_table: The open firmware table.
> >   * @acpi_match_table: The ACPI match table.
> > @@ -285,6 +291,7 @@ struct device_driver {
> >  	const char		*mod_name;	/* used for built-in modules */
> >  
> >  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> > +	bool probe_low_power;
> 
> Ick, no, this should be a bus-specific thing to handle such messed up
> hardware.  Why polute this in the driver core?

The alternative could be to make it I�C specific indeed; the vast majority
of camera sensors are I�C devices these days.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
