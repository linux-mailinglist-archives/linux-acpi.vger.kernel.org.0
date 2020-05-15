Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958131D4D5F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgEOMF5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 08:05:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:4688 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgEOMF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 08:05:56 -0400
IronPort-SDR: pbNWTpnTexALeOgUTQEJWtgskadJOYSEAPv7RTbh6zLW7pZmxF6YzFs4fyvcWzzFhHOskXad9k
 y1i8qEAfy3dg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:05:56 -0700
IronPort-SDR: ETu/rW6/uFdF7TdKoh27Q9VwNarsKv/Nw6Rqg/wuXAUPeJO4JbkpXTzyU+NuZoqdLKCQMtm7hB
 56shWPE1OBtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="372670460"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 May 2020 05:05:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 May 2020 15:05:52 +0300
Date:   Fri, 15 May 2020 15:05:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200515120552.GC1511@kuha.fi.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
 <20200511133202.GA2085641@kuha.fi.intel.com>
 <20200511175719.GA136540@google.com>
 <20200512142251.GD2085641@kuha.fi.intel.com>
 <20200512191910.GD136540@google.com>
 <CACeCKad4BebiBJS_wO=FdWVWypgOD822Dir7HeRBf0uXUuJusA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKad4BebiBJS_wO=FdWVWypgOD822Dir7HeRBf0uXUuJusA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Prashant,

> I just realized, the issue I initially pointed out would apply to the
> connect message too, i.e I'm not sure if "normal" orientation setting
> handles the case where port orientation is reversed correctly.
> Overall, I am not sure that re-using the typec_orientations[] string
> list is the best option for this use-case.
> we're looking for "normal" (i.e follows port->orientation) and "fixed"
> (i.e is always the same orientation, regardless of what
> port->orientation is), so it is perhaps better to just define a new
> array just for this driver.

Sorry, I got sidetracked with that Alternate-Direct Request stuff.
Let's start over..

The property itself is the indicator that the orientation is fixed for
those lines, not its value. If the property exists, we know the
orientation is fixed, and if it doesn't exist, we know we need to use
the cable plug orientation. So if we only want to use the property as
a flag, then it does not need to have any value at all. It would be a
boolean property.

But we would then always leave the ORI-HSL field with value 0 when the
orientation is fixed, and that would rule out the possibility of
supporting a platform where we have to use a fixed value of 1 there
(fixed-reversed). If we ever needed to support configuration like
that, then we would need to add a new property.

That scenario may not be relevant on this platform, and it may seem
like an unlikely, or even impossible case now, but experience (and the
north mux-agent documentation) tells me we should prepare also for
that. That is why I use the typec_orientation strings as the values
for these properties. Then the fixed-reversed orientation is also
covered with the same properties if we ever need to support it.

Maybe this code would be better, or more clear in the driver:

/*
 * Returns the value for the HSL-ORI field.
 */
static int hsl_orientation(struct pmc_usb_port *port)
{
        enum typec_orientation orientation;

        /*
         * Is the orientation fixed:
         *   Yes, use the fixed orientation.
         *   No, use cable plug orientation.
         */
        if (port->hsl_orientation)
                orientation = hsl_orientation;
        else
                orientation = port->orientation;

        switch (orientation) {
        case TYPEC_ORIENTATION_NORMAL:
                return 0;
        case TYPEC_ORIENTATION_REVERSE:
                return 1;
        }

        return -EINVAL;
}

thanks,

-- 
heikki
