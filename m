Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAF223120
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jul 2020 04:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgGQCT1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jul 2020 22:19:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42232 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQCT0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2020 22:19:26 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A7F0561;
        Fri, 17 Jul 2020 04:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594952364;
        bh=AY6ngIIQkPlQDWCl5lU11+0P+LyJOnh2DiIlr/M/gJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2/VmKznn1kMZnyN+GNhRaR2BpD7/aWu2fu8ckX5H7hq3YZ10cvD41elVTybpGJLP
         0pYrgi6VQ0t303acwAaCzExhHnX2tgiyLV3yp7IeZr89Rp2O4/i5GuNhTp9L/CZcwa
         1tMSWDFa+Isd5lAHLhJrR2giFVjghC5pQJL/hcUI=
Date:   Fri, 17 Jul 2020 05:19:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] device property: Add a function to test is a
 fwnode is a graph endpoint
Message-ID: <20200717021916.GA387@pendragon.ideasonboard.com>
References: <20200701062140.12953-1-laurent.pinchart+renesas@ideasonboard.com>
 <20200701062140.12953-2-laurent.pinchart+renesas@ideasonboard.com>
 <20200701073405.GB836@valkosipuli.retiisi.org.uk>
 <CAJZ5v0iSpC=67p++vyH0WjcsuPG5SMtJJamit2T9vOQPb9jm0w@mail.gmail.com>
 <20200715205717.GF836@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715205717.GF836@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Wed, Jul 15, 2020 at 11:57:17PM +0300, Sakari Ailus wrote:
> On Wed, Jul 01, 2020 at 02:19:21PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 1, 2020 at 9:34 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > > On Wed, Jul 01, 2020 at 09:21:37AM +0300, Laurent Pinchart wrote:
> > > > Drivers may need to test if a fwnode is a graph endpoint. To avoid
> > > > hand-written solutions that wouldn't work for all fwnode types, add a
> > > > new fwnode_graph_is_endpoint() function for this purpose. We don't need
> > > > to wire it up to different backends for OF and ACPI for now, as the
> > > > implementation can simply be based on checkout the presence of a
> > > > remote-endpoint property.
> > > >
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > ---
> > > >  include/linux/property.h | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/include/linux/property.h b/include/linux/property.h
> > > > index 10d03572f52e..9f805c442819 100644
> > > > --- a/include/linux/property.h
> > > > +++ b/include/linux/property.h
> > > > @@ -389,6 +389,11 @@ struct fwnode_handle *
> > > >  fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
> > > >                            u32 endpoint);
> > > >
> > > > +static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
> > > > +{
> > > > +     return fwnode_property_present(fwnode, "remote-endpoint");
> > > > +}
> > > > +
> > > >  /*
> > > >   * Fwnode lookup flags
> > > >   *
> > >
> > > Thanks for the patch. I've bounced it to devicetree and linux-acpi lists
> > > (now cc'd) --- hope that works.
> > >
> > > Rafael: do you think this simple patch could go though the media tree,
> > > assuming that folks are generally fine with the patch as such?
> > 
> > Yes, it could.
> 
> Thanks! I've applied this to my tree.

Do you mean the whole series ? :-) Do you intend to send a pull request
for v5.9 ?

-- 
Regards,

Laurent Pinchart
