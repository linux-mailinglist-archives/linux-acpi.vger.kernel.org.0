Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE21CA9BB
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHLgz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbgEHLgz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2020 07:36:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2290C05BD0A
        for <linux-acpi@vger.kernel.org>; Fri,  8 May 2020 04:36:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so742448pgq.13
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2020 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xG/oTmVNvsSrVAKyKn0GG7fP0wz/voKoWWtsagHKWks=;
        b=W1zZ1SHmI2Ggfi1Ayr4ozVYtK2iuT8r+74rAm5ZyvFqZalCMq2gcmRIvtkUzqyS+mj
         PaNmE2v+/aR1B8wUfixjzKlek1GOHGl+mvLQsQpJR1WpwH+9lzdA9IO/BJHK0qYLH9q6
         QxOQmJYFsuiIyR/FrfTlGrZANhUfvzr3R4QSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xG/oTmVNvsSrVAKyKn0GG7fP0wz/voKoWWtsagHKWks=;
        b=OEGRx7vCHoJPGJ2Pgbd874U9f5p9h6uiQXxFilH9XlldjIzhJIn1vrXI137+IJ3Co0
         zfEyWOdbnAr/TCywQk/0uAHCVNpIUiopn5GMCzrTJ0Rk0rRRr+H0MMAQzlORku1B2Y1j
         yr3yXs75VmX/sst2d90g5SypF00eGuBDLkDpU1Zt+vcy4rnz7PGJouKGlm7fnKcNWZ2D
         vYayfE+zMjHayBBzfKtBkOcYab5uh2Tq1BE97pqfguii2Cm7tZC7JjcoLtpcuRCAjq7r
         rd1sSI566/1trMXQ3mQ7avBTRCUI/t5wni2clG59X6UmDBMMxyEIGBqvz+DgHAi7eO9X
         J9RA==
X-Gm-Message-State: AGi0PuYIPYZ3AsOaSc4pwpBk+Uc3MmsBEJmTUxaxGY63C7uyO/K0Hntg
        66aeU+peTberiAhJwx8nzg7u6g==
X-Google-Smtp-Source: APiQypKT5Nd6sPhxivcyI6fARenFffjc+L0JYcg8jsLniC9BOmw17JjLzozG6egmA6aCO4DoBH6IVg==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr2454835pfc.190.1588937814083;
        Fri, 08 May 2020 04:36:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id a12sm1615001pfr.28.2020.05.08.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:36:53 -0700 (PDT)
Date:   Fri, 8 May 2020 04:36:52 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200508113652.GA34001@google.com>
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

On Fri, May 08, 2020 at 02:18:40PM +0300, Heikki Krogerus wrote:
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
> 
> Thanks a lot for reviewing this. If you guys have time, then please
> check also that the documentation I'm proposing in patch 3/4 for this
> driver has everything explained clearly enough, and nothing is missing.
> 
Sure thing, we'll take a look.

Best,

-Prashant
> Br,
> 
> -- 
> heikki
