Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3F1CA969
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLSo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 07:18:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:42674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLSo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 07:18:44 -0400
IronPort-SDR: stimH1Oq1Vwo/tGPtBr9NJJTTbJNJ/X6d7DHw5RY94xHEtjN8y9hx+t9On7+zwnUpdrPiUSCy/
 2A0p6wm1mfiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:18:43 -0700
IronPort-SDR: BiZcFTMRaL46E4gjmyLn2L68RKXVMFLXr374xd+Cwni8pAAnp7pSvXyUlIsX7gCspUL+cW0eU7
 tehvFA8kf1Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="370428589"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 May 2020 04:18:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 May 2020 14:18:40 +0300
Date:   Fri, 8 May 2020 14:18:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200508111840.GG645261@kuha.fi.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507224041.GA247416@google.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Prashant,

On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > +static int sbu_orientation(struct pmc_usb_port *port)
> > +{
> > +	if (port->sbu_orientation)
> > +		return port->sbu_orientation - 1;
> > +
> > +	return port->orientation - 1;
> > +}
> > +
> > +static int hsl_orientation(struct pmc_usb_port *port)
> > +{
> > +	if (port->hsl_orientation)
> > +		return port->hsl_orientation - 1;
> > +
> > +	return port->orientation - 1;
> > +}
> > +
> >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> >  {
> >  	u8 response[4];
> > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> >  
> >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > +
> > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> 
> I'm curious to know what would happen when sbu-orientation == "normal".
> That means |port->sbu_orientation| == 1.
> 
> It sounds like what should happen is the AUX_SHIFT orientation
> setting should follow what |port->orientation| is, but here it
> looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> it should be set to 1 ?

I'll double check this, and get back to you..

Thanks a lot for reviewing this. If you guys have time, then please
check also that the documentation I'm proposing in patch 3/4 for this
driver has everything explained clearly enough, and nothing is missing.

Br,

-- 
heikki
