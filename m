Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A61CF6F5
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgELOXO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 10:23:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:24333 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELOXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 10:23:14 -0400
IronPort-SDR: ZiBXA76rb1/qZhNuKw1vgwQ2DC1XW3Kk46lXmqcYNjWIsc9o1haLQW2ZQ6LJ1X5Z1cPX6+KvQx
 T88Ij9y0cT7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:23:11 -0700
IronPort-SDR: GlzZtu1sGARwiLFsda7n5jP+UidS5IcfVek8rox5EIDoV01vzHRDGFl9rq8vjh2j1rPhVTZ4+J
 9F++snUjWrew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371578153"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 May 2020 07:22:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 May 2020 17:22:51 +0300
Date:   Tue, 12 May 2020 17:22:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200512142251.GD2085641@kuha.fi.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
 <20200511133202.GA2085641@kuha.fi.intel.com>
 <20200511175719.GA136540@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511175719.GA136540@google.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Prashant,

On Mon, May 11, 2020 at 10:57:19AM -0700, Prashant Malani wrote:
> Hi Heikki,
> 
> Thanks a lot for looking into this. Kindly see my response inline:
> 
> On Mon, May 11, 2020 at 04:32:02PM +0300, Heikki Krogerus wrote:
> > On Fri, May 08, 2020 at 02:18:44PM +0300, Heikki Krogerus wrote:
> > > Hi Prashant,
> > > 
> > > On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > > > +{
> > > > > +	if (port->sbu_orientation)
> > > > > +		return port->sbu_orientation - 1;
> > > > > +
> > > > > +	return port->orientation - 1;
> > > > > +}
> > > > > +
> > > > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > > > +{
> > > > > +	if (port->hsl_orientation)
> > > > > +		return port->hsl_orientation - 1;
> > > > > +
> > > > > +	return port->orientation - 1;
> > > > > +}
> > > > > +
> > > > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > > > >  {
> > > > >  	u8 response[4];
> > > > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > > > >  
> > > > >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > > > >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > > > +
> > > > > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > 
> > > > I'm curious to know what would happen when sbu-orientation == "normal".
> > > > That means |port->sbu_orientation| == 1.
> > > > 
> > > > It sounds like what should happen is the AUX_SHIFT orientation
> > > > setting should follow what |port->orientation| is, but here it
> > > > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > > > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > > > it should be set to 1 ?
> > > 
> > > I'll double check this, and get back to you..
> > 
> > This is not exactly an answer to your question, but it seems that
> > those bits are only valid if "Alternate-Direct" message is used.
> > Currently the driver does not support that message.
> Could you kindly provide some detail on when "Alternate-Direct" would be
> preferred to the current method?

Alternate Mode Direct request is supposed to be used if an alternate
mode is entered directly from disconnected state.

> Also, is there anything on the PMC side which is preventing the use of
> "Alternate-Direct" messages? It seems like the state transition diagram
> there would be simpler, although I'm likely missing significant details
> here.

So we actually should use the "direct" request if we are in
disconnected state to enter alt modes if I understood correctly. But
otherwise we should use the normal Alternate Mode request and not the
Alternate Mode "direct" request. And I'm afraid I don't know why.

> > I think the correct thing to do now is to remove the two lines from
> > the driver where those bits (ORI-HSL and ORI-Aux) are set.
> I see. How would orientation then be handled in a retimer configuration
> where AUX/SBU is flipped by the retimer itself?

Note that if we send a separate "connection" request first, then we
already tell the HSL and SBU orientation as part of the payload of
that request. That is why there is no need to tell about the HSL and
SBU orientation with the normal Alternate Mode Request.

So we have already handled the HSL and SBU orientation by the time
this function is called.


thanks,

-- 
heikki
