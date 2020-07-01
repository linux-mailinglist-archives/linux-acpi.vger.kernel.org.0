Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFB21051B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jul 2020 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGAHeW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jul 2020 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgGAHeW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2020 03:34:22 -0400
Received: from hillosipuli.retiisi.org.uk (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289DC061755;
        Wed,  1 Jul 2020 00:34:22 -0700 (PDT)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 3DA42634C87;
        Wed,  1 Jul 2020 10:34:05 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1jqXFt-0000nt-C5; Wed, 01 Jul 2020 10:34:05 +0300
Date:   Wed, 1 Jul 2020 10:34:05 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 1/4] device property: Add a function to test is a
 fwnode is a graph endpoint
Message-ID: <20200701073405.GB836@valkosipuli.retiisi.org.uk>
References: <20200701062140.12953-1-laurent.pinchart+renesas@ideasonboard.com>
 <20200701062140.12953-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701062140.12953-2-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Laurent,

On Wed, Jul 01, 2020 at 09:21:37AM +0300, Laurent Pinchart wrote:
> Drivers may need to test if a fwnode is a graph endpoint. To avoid
> hand-written solutions that wouldn't work for all fwnode types, add a
> new fwnode_graph_is_endpoint() function for this purpose. We don't need
> to wire it up to different backends for OF and ACPI for now, as the
> implementation can simply be based on checkout the presence of a
> remote-endpoint property.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  include/linux/property.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 10d03572f52e..9f805c442819 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -389,6 +389,11 @@ struct fwnode_handle *
>  fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
>  			     u32 endpoint);
>  
> +static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
> +{
> +	return fwnode_property_present(fwnode, "remote-endpoint");
> +}
> +
>  /*
>   * Fwnode lookup flags
>   *

Thanks for the patch. I've bounced it to devicetree and linux-acpi lists
(now cc'd) --- hope that works.

Rafael: do you think this simple patch could go though the media tree,
assuming that folks are generally fine with the patch as such?
Alternatively,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
