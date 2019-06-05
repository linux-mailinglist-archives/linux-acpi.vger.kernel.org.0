Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0093D35C47
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2019 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFEMIG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jun 2019 08:08:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:50975 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMIG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jun 2019 08:08:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 05:08:04 -0700
X-ExtLoop1: 1
Received: from pbooyens-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.48.29])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2019 05:08:02 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id DEBBE21D78; Wed,  5 Jun 2019 15:07:58 +0300 (EEST)
Date:   Wed, 5 Jun 2019 15:07:58 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, rajmohan.mani@intel.com,
        linux-media@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190605120758.3uwziqnqpl2i3cww@kekkonen.localdomain>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
 <20190510100930.14641-2-sakari.ailus@linux.intel.com>
 <9700088.HJ6KcFTmRF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9700088.HJ6KcFTmRF@kreacher>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, May 31, 2019 at 11:17:10AM +0200, Rafael J. Wysocki wrote:
> On Friday, May 10, 2019 12:09:26 PM CEST Sakari Ailus wrote:
...
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index e85264fb66161..2a459fd5b954a 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -245,6 +245,11 @@ enum probe_type {
> >   * @owner:	The module owner.
> >   * @mod_name:	Used for built-in modules.
> >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > + * @probe_powered_off: The driver supports its probe function being called while
> > + *		       the device is powered off, independently of the expected
> > + *		       behaviour on combination of a given bus and firmware
> > + *		       interface etc. The driver is responsible for powering the
> > + *		       device on using runtime PM in such case.
> >   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> >   * @of_match_table: The open firmware table.
> >   * @acpi_match_table: The ACPI match table.
> > @@ -282,6 +287,7 @@ struct device_driver {
> >  	const char		*mod_name;	/* used for built-in modules */
> >  
> >  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> > +	bool probe_powered_off;
> 
> This is a bit of a misnomer IMO, because it is not just about devices that are completely off.
> From the ACPI perspective that is about all devices not in D0, which may mean gated clocks
> etc.
> 
> I would call it probe_low_power or similar and analogously in patch [2/5], and apart from this
> I have no objections against this series, but I would suggest to CC the next iteration of it
> to Greg K-H and the LKML as it touches the driver core.

Ack. I'll do that for v2.

Thanks for the review!

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
