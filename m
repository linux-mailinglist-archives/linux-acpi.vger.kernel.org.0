Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97565210AEE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jul 2020 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgGAMTe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jul 2020 08:19:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37974 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgGAMTe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2020 08:19:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id r8so20400313oij.5;
        Wed, 01 Jul 2020 05:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lKvcHCLUJbtgdK0hdZoGgT86fGFZZmtsMyR7+SlSG8=;
        b=SivwNhHrv051c1WrI7MmTPYmCFRbL72Ma7NFNH0PWWCsEYqO8j7OSW2DxNxPJURiA9
         0SPlTRdzonTBeyo9rrEkR/EZpszEX3MeTUHXxB/96S6BCRp305ofQoEfXPxTiPq00SkT
         hkXi4apvHmOAclxAJCRGDsBia2q6jrxnMKTvW66fJfjZX7Ga0FZRH7JKcAMhURe6M6fK
         fo7MI353ZQ98WZ7Wj5+3ZiHrkm7MJIvS0SwwDD30L0hda3O3o7HxAM+EI5F3A+R00Wgl
         TlDQZXED/klnnE/01aHhIW4ERsrBTEyYFvHhJYTVj9LlJ3el8EZ8ki4yXn1kg5ug31B+
         m8pg==
X-Gm-Message-State: AOAM531HWV7sgzYASrw6ValD39opv2PxafgI+ulpbC56wWvHHqgdLCR2
        WE9bhj34dkkYsYbZsQtPw0HIDGkVg/N5/Ke3qhY=
X-Google-Smtp-Source: ABdhPJzLCE9xDXtcTvnQkYUY3+XR2ef/vN6UYnES49W6m7DDHnWOZ49LApIokEJcUPpwfIuEYqxZbZ1YV2pb+qGUQ3g=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr20767181oia.103.1593605973188;
 Wed, 01 Jul 2020 05:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200701062140.12953-1-laurent.pinchart+renesas@ideasonboard.com>
 <20200701062140.12953-2-laurent.pinchart+renesas@ideasonboard.com> <20200701073405.GB836@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200701073405.GB836@valkosipuli.retiisi.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Jul 2020 14:19:21 +0200
Message-ID: <CAJZ5v0iSpC=67p++vyH0WjcsuPG5SMtJJamit2T9vOQPb9jm0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] device property: Add a function to test is a
 fwnode is a graph endpoint
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 1, 2020 at 9:34 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Laurent,
>
> On Wed, Jul 01, 2020 at 09:21:37AM +0300, Laurent Pinchart wrote:
> > Drivers may need to test if a fwnode is a graph endpoint. To avoid
> > hand-written solutions that wouldn't work for all fwnode types, add a
> > new fwnode_graph_is_endpoint() function for this purpose. We don't need
> > to wire it up to different backends for OF and ACPI for now, as the
> > implementation can simply be based on checkout the presence of a
> > remote-endpoint property.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  include/linux/property.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 10d03572f52e..9f805c442819 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -389,6 +389,11 @@ struct fwnode_handle *
> >  fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
> >                            u32 endpoint);
> >
> > +static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
> > +{
> > +     return fwnode_property_present(fwnode, "remote-endpoint");
> > +}
> > +
> >  /*
> >   * Fwnode lookup flags
> >   *
>
> Thanks for the patch. I've bounced it to devicetree and linux-acpi lists
> (now cc'd) --- hope that works.
>
> Rafael: do you think this simple patch could go though the media tree,
> assuming that folks are generally fine with the patch as such?

Yes, it could.
