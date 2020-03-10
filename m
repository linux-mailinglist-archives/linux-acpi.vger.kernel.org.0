Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B852C17F062
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Mar 2020 07:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCJGPE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Mar 2020 02:15:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32777 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJGPE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2020 02:15:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jBYAN-0002FR-Nx; Tue, 10 Mar 2020 07:14:59 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jBYAM-0007Nk-LV; Tue, 10 Mar 2020 07:14:58 +0100
Date:   Tue, 10 Mar 2020 07:14:58 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, kernel@pengutronix.de,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: fix port numbering example
Message-ID: <20200310061458.6ruh2omqqcugemqt@pengutronix.de>
References: <20200305145601.3467-1-m.felsch@pengutronix.de>
 <20200309133757.GS5379@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309133757.GS5379@paasikivi.fi.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:13:04 up 115 days, 21:31, 130 users,  load average: 0.01, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On 20-03-09 15:37, Sakari Ailus wrote:
> Hi Marco,
> 
> Thanks for the patch.
> 
> On Thu, Mar 05, 2020 at 03:56:01PM +0100, Marco Felsch wrote:
> > If I understood it right the ports should be numbered using the "port"
> > property and not the "reg" property. I stumbled over it during
> > extending the v4l2_fwnode_parse_link() helper which also use the "port"
> > property.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Hi,
> > 
> > I don't know if this is right since I'm not a ACPI guy *sorry*
> > Anyway reading the doc description and the v4l2_fwnode_parse_link() code
> > give me a 2/3 chance.
> 
> Looking at the documentation, this indeed seems to be a bug in the
> documentation. The code is right, as is the example. As the property was
> previously called "port", there is no actual harm even if someone just read
> the documentation, and not the examples or the code parsing this.
> 
> The buggy patch is a4138e7c12287268348cc2dcad414a62c515d77a .
> 
> Could you use this instead?

Of course, thanks for the clarification. It seems that we need to update the
v4l2_fwnode_parse_link() too?

Regards,
  Marco

> diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
> index 1a6ce7afba5ea..2f19a0487b18c 100644
> --- a/Documentation/firmware-guide/acpi/dsd/graph.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -56,7 +56,7 @@ package would be::
>  
>      Package() { "endpoint@0", "EP40" }
>  
> -Each port node contains a property extension key "port", the value of which is
> +Each port node contains a property extension key "reg", the value of which is
>  the number of the port. Each endpoint is similarly numbered with a property
>  extension key "reg", the value of which is the number of the endpoint. Port
>  numbers must be unique within a device and endpoint numbers must be unique
> 
> -- 
> Sakari Ailus
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
