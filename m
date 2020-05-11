Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1403B1CDB40
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgEKNcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 09:32:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:31493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgEKNcG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 09:32:06 -0400
IronPort-SDR: KUWThOVokw+22igPqcGhYXsNpQTG/Rn8xP6pdyU0AOxfQEqoRZTz6RC44EHylq2Q+EoZq2SV16
 VTegjmUHF7xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 06:32:06 -0700
IronPort-SDR: ua08l74jDK6N53RK+hzjn3UO03K2ocJBHhbnx0ofM7hCCzQ1S9igxVMp/aa60S5eLLphK5FFa5
 UbI6MuvIfEHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="371223357"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 06:32:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 May 2020 16:32:02 +0300
Date:   Mon, 11 May 2020 16:32:02 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200511133202.GA2085641@kuha.fi.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508111840.GG645261@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 08, 2020 at 02:18:44PM +0300, Heikki Krogerus wrote:
> Hi Prashant,
> 
> On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > +{
> > > +	if (port->sbu_orientation)
> > > +		return port->sbu_orientation - 1;
> > > +
> > > +	return port->orientation - 1;
> > > +}
> > > +
> > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > +{
> > > +	if (port->hsl_orientation)
> > > +		return port->hsl_orientation - 1;
> > > +
> > > +	return port->orientation - 1;
> > > +}
> > > +
> > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > >  {
> > >  	u8 response[4];
> > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > >  
> > >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > +
> > > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > 
> > I'm curious to know what would happen when sbu-orientation == "normal".
> > That means |port->sbu_orientation| == 1.
> > 
> > It sounds like what should happen is the AUX_SHIFT orientation
> > setting should follow what |port->orientation| is, but here it
> > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > it should be set to 1 ?
> 
> I'll double check this, and get back to you..

This is not exactly an answer to your question, but it seems that
those bits are only valid if "Alternate-Direct" message is used.
Currently the driver does not support that message.

I think the correct thing to do now is to remove the two lines from
the driver where those bits (ORI-HSL and ORI-Aux) are set.

Let me know if that's OK, and I'll update the series.

thanks,

-- 
heikki
