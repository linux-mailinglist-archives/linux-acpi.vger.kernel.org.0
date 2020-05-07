Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E881C9E8B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 00:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEGWko (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgEGWko (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2020 18:40:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0EC05BD0A
        for <linux-acpi@vger.kernel.org>; Thu,  7 May 2020 15:40:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so3457793pgb.7
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPTDJmF/tujVfBkCFmIE4YvP6laom+6vA1WUeov6LY0=;
        b=DYcbxanU7xOF7YD85/inr43/fl2m/NFGp69K/Fs0JxJj5YQcPBMMfEXPTjty4kzn93
         2xJnSrkADBiKUlrja6Cu/EQMrkstARiLmcYwYTjsq913C0t7xDoN9kX0owwP9+babTbD
         k9vhtvPWlGcBZBugvw+mAj7yMgqSS1UDC7GYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPTDJmF/tujVfBkCFmIE4YvP6laom+6vA1WUeov6LY0=;
        b=iJY57L3cJjs/Pfgsw6Oqhb6Axmp6qRETPU87PRDG24RwC4FSSR95iCok4n6xhHrHls
         wZxuhIf4aBGUb8wp0x1PW4zDbvfvWZndPNPI+VlfgCri7taMz0F3puhp+Vs60iSRvA3y
         JYAUnmYmVUmi06yi2EkE7IuZxiQcOax9lmqmwZBB/tzQk4nSw6zWARKtNV8okqS+L2na
         FXLlENZWDWDWP7td8AxSH7SHj1RRSZXy0wTVnvrsybr79ZuMFkVzQ3ayPuq9bjyfvcaI
         d4LU/00zNGGnoYVmik75AbyEZU0mvKvEUyxxPQ/McuApUye8q3Wllme9MNlsLwT5XT+p
         6NBQ==
X-Gm-Message-State: AGi0PuZrbw/4iffiku4tx5CccARXDwXeU/tHCVVGX3laQ6msmqio17sg
        vOqH3khtu/pzOkYXI8p1Q9fB1w==
X-Google-Smtp-Source: APiQypKzWVGuTQrhg0T2RKxcHC1dccZOfB4yuHc7rhnl1Ib0TLRLPytRWJ/yhmppXsA3XgWdl6pDDQ==
X-Received: by 2002:a62:4ec8:: with SMTP id c191mr16441851pfb.30.1588891243415;
        Thu, 07 May 2020 15:40:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p189sm5898931pfp.135.2020.05.07.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 15:40:42 -0700 (PDT)
Date:   Thu, 7 May 2020 15:40:41 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200507224041.GA247416@google.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

Thanks for the patches.

On Thu, May 07, 2020 at 06:08:58PM +0300, Heikki Krogerus wrote:
> The SBU and HSL orientation may be fixed/static from the mux
> PoW. Apparently the retimer may take care of the orientation
> of these lines. Handling the static SBU (AUX) and HSL
> orientation with device properties.
> 
> If the SBU orientation is static, a device property
> "sbu-orintation" can be used. When the property exists, the
> driver always sets the SBU orientation according to the
> property value, and when it's not set, the driver uses the
> cable plug orientation with SBU.
> 
> And with static HSL orientation, "hsl-orientation" device
> property can be used in the same way.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 42 +++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index f5c5e0aef66f..1aac218099f3 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -91,6 +91,9 @@ struct pmc_usb_port {
>  
>  	u8 usb2_port;
>  	u8 usb3_port;
> +
> +	enum typec_orientation sbu_orientation;
> +	enum typec_orientation hsl_orientation;
>  };
>  
>  struct pmc_usb {
> @@ -99,6 +102,22 @@ struct pmc_usb {
>  	struct pmc_usb_port *port;
>  };
>  
> +static int sbu_orientation(struct pmc_usb_port *port)
> +{
> +	if (port->sbu_orientation)
> +		return port->sbu_orientation - 1;
> +
> +	return port->orientation - 1;
> +}
> +
> +static int hsl_orientation(struct pmc_usb_port *port)
> +{
> +	if (port->hsl_orientation)
> +		return port->hsl_orientation - 1;
> +
> +	return port->orientation - 1;
> +}
> +
>  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
>  {
>  	u8 response[4];
> @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
>  
>  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
>  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> +
> +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;

I'm curious to know what would happen when sbu-orientation == "normal".
That means |port->sbu_orientation| == 1.

It sounds like what should happen is the AUX_SHIFT orientation
setting should follow what |port->orientation| is, but here it
looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
it should be set to 1 ?

Apologies if I misunderstood the code...


Best regards,


> +	req.mode_data |= hsl_orientation(port) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
>  
>  	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
>  			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> @@ -173,8 +193,9 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
>  
>  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
>  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> +
> +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> +	req.mode_data |= hsl_orientation(port) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
>  
>  	if (TBT_ADAPTER(data->device_mode) == TBT_ADAPTER_TBT3)
>  		req.mode_data |= PMC_USB_ALTMODE_TBT_TYPE;
> @@ -211,8 +232,8 @@ static int pmc_usb_connect(struct pmc_usb_port *port)
>  	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
>  
>  	msg[1] = port->usb2_port << PMC_USB_MSG_USB2_PORT_SHIFT;
> -	msg[1] |= (port->orientation - 1) << PMC_USB_MSG_ORI_HSL_SHIFT;
> -	msg[1] |= (port->orientation - 1) << PMC_USB_MSG_ORI_AUX_SHIFT;
> +	msg[1] |= hsl_orientation(port) << PMC_USB_MSG_ORI_HSL_SHIFT;
> +	msg[1] |= sbu_orientation(port) << PMC_USB_MSG_ORI_AUX_SHIFT;
>  
>  	return pmc_usb_command(port, msg, sizeof(msg));
>  }
> @@ -296,6 +317,7 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
>  	struct usb_role_switch_desc desc = { };
>  	struct typec_switch_desc sw_desc = { };
>  	struct typec_mux_desc mux_desc = { };
> +	const char *str;
>  	int ret;
>  
>  	ret = fwnode_property_read_u8(fwnode, "usb2-port", &port->usb2_port);
> @@ -306,6 +328,14 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
>  	if (ret)
>  		return ret;
>  
> +	ret = fwnode_property_read_string(fwnode, "sbu-orientation", &str);
> +	if (!ret)
> +		port->sbu_orientation = typec_find_orientation(str);
> +
> +	ret = fwnode_property_read_string(fwnode, "hsl-orientation", &str);
> +	if (!ret)
> +		port->hsl_orientation = typec_find_orientation(str);
> +
>  	port->num = index;
>  	port->pmc = pmc;
>  
> -- 
> 2.26.2
> 
