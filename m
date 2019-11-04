Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BEEE7ED
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDTFC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 14:05:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46385 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfKDTFC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Nov 2019 14:05:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id b19so5860656oib.13
        for <linux-acpi@vger.kernel.org>; Mon, 04 Nov 2019 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYANoUNhVHHjzkfi60XF5k8Eu5GIth/T5JcxpoKJXY0=;
        b=VoQ4R3Ob8oRCb76tNmEXI+WfY2qFjXVsfjr7uf4OczplOi6CXNyP7MBGr5IFxqs64F
         hkfF5gDgIsz2+fNXNx9Y/DdLkXy1Jm0eS+KYclq+y5auzOiNrFZTF9Qo/nbzVkAid4ti
         FtDajpPrHbk8P8ml1g1s7AKzYTG+4jGaPhhue5yMsiK4mvavB3TQteAbfVf7/ocUCWr8
         lmJPbIo+mxAnHQdop8tZXrbwRp8qXvy1SGPh0/rr5WXIv6KneAbIBCvufzVwWKLT2VAq
         CTdmalU/lmZcyBW84XtqaueyMv1WKBwL7pJcKtE2M5ur0sxFP0wXytMyWUAfKIiOLHH8
         Y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYANoUNhVHHjzkfi60XF5k8Eu5GIth/T5JcxpoKJXY0=;
        b=oETGURS+7TiUl9xehr22kbrGZwAeKEnDZYrWClWwJgursCe+FwWRBj3Ia7f+wCIy+5
         tUgUD2QtK7OT9Pe/pzpNIeriiADFSt4+8rQtX+2ZKbnwa+rQU4OPEbm3/isTYYnyEff8
         PJD1dVl2D6UjfV6C3nCEXpnleiSFBS5c9VX+rhOFCiFzLXDnc4LH3Un+ixnhvPnoSbqD
         c7Ev1zNkMN/ImOPbP9nL5KEY3VYlvrwmVGN4ainB9FwcZRLNQjGijcwZLwZveehQCjTp
         OBbfQtxLevGAkKLROTynIKgPxcWcV1FnsEXkkLGYfKvh+291vFPHxtwdEzXFap4vPFOa
         Z3Xg==
X-Gm-Message-State: APjAAAVXAuYEJyzV4ZyOgBjqiCbvFJq7vJWMleKpDBzmtbIWOmsjr4Lh
        A7Sdjtdc8vHjFmfz4OkHDOUTAzv8+jCKhTcTnWf8qA==
X-Google-Smtp-Source: APXvYqzeOsO3lJGp75lvE1QRaAg9xgdEsSMkzfIhUjg6Z229ywUMz4CiybXTkTy+v3KlkaLnO+EIgYmrbUDN5vzHXaY=
X-Received: by 2002:aca:5116:: with SMTP id f22mr550365oib.30.1572894300567;
 Mon, 04 Nov 2019 11:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-5-saravanak@google.com>
 <CAL_JsqJQ9siUGgmGqZnF_Wk3mVau29yVZRL_3LxFKgD8=mccQQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJQ9siUGgmGqZnF_Wk3mVau29yVZRL_3LxFKgD8=mccQQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 Nov 2019 11:04:24 -0800
Message-ID: <CAGETcx-cj9K0G4EcRd1saQOuFdMaXpvaf8Hz9M_XwG1BGH-qEQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] of: property: Make sure child dependencies don't
 block probing of parent
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 4, 2019 at 9:01 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 5:00 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When creating device links to proxy the sync_state() needs of child
> > dependencies, create SYNC_STATE_ONLY device links so that children
> > dependencies don't block probing of the parent.
> >
> > Also, differentiate between missing suppliers of parent device vs
> > missing suppliers of child devices so that driver core doesn't block
> > parent device probing when only child supplier dependencies are missing.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you!

> One nit below:
>
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 2808832b2e86..f16f85597ccc 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1032,10 +1032,10 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
> >   * - -EINVAL if the supplier link is invalid and should not be created
> >   * - -ENODEV if there is no device that corresponds to the supplier phandle
> >   */
> > -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > +                             u32 dl_flags)
> >  {
> >         struct device *sup_dev;
> > -       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> >         int ret = 0;
> >         struct device_node *tmp_np = sup_np;
> >
> > @@ -1195,13 +1195,20 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
> >         unsigned int i = 0;
> >         bool matched = false;
> >         int ret = 0;
> > +       u32 dl_flags;
> > +
> > +       if (dev->of_node == con_np)
> > +               dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > +       else
> > +               dl_flags = DL_FLAG_SYNC_STATE_ONLY;
> >
> >         /* Do not stop at first failed link, link all available suppliers. */
> >         while (!matched && s->parse_prop) {
> >                 while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> >                         matched = true;
> >                         i++;
> > -                       if (of_link_to_phandle(dev, phandle) == -EAGAIN)
> > +                       if (of_link_to_phandle(dev, phandle, dl_flags)
> > +                                                               == -EAGAIN)
>
> nit: I'd just keep this one line or at least move '==' up.

You'd keep it one line even if it's > 80 cols? Ok, I'll move the "==" up.


-Saravana
