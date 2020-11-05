Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62BF2A8AB8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 00:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgKEX2a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 18:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgKEX23 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2020 18:28:29 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCFC0613CF
        for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2020 15:28:29 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id a12so2853958ybg.9
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 15:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1yQ/s7VjZpG6AwhzGebU5FEU866tdPdQ1xbNkFkqq8=;
        b=Yk4mo/7baJdKppRkrHPyZr1IVefIv9qFrVmuSlNHExkjOfEosxGxAdeD/pUhPfMZ+b
         mF9KuvUDKH7S1pyMqbMRrUZ7Tzt0v5p18deKMLYYy7CuIIoCmI3UPKMsRA8t58VPibJF
         ZEbOvVqRuqOKIC1sni93pPVEx2ygOsOX8zvvjxTNz1X0ENlfg4fIhtjq7xaadRes07Xa
         dRhaYsM+DTwoJTWGmN6xLrn7PrIy5pme7YO8F0PPmMxGrG5ZgAFNEa1btXRMP5vORJsR
         IkZ1LhADELoAzPvjKhdifq1ZE5AgGOuhqB7w9g2PDPHrGWObcaejUY34FpbUFOtyd1lW
         5CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1yQ/s7VjZpG6AwhzGebU5FEU866tdPdQ1xbNkFkqq8=;
        b=kHzI76UccyqX8z0x6GVlDR+PF9Op0zIP8AOD4Q32JtGtj6qt5N2+o11hJEwH9Miuq6
         nqyargIWLdGh7ThDcsHWbdYu7e6V1aqUPeJ/mnFUfHHIAnltqR98vMafuYAqFg61J3Rr
         TfZxPoUldmPZXSo8bLQ/ZNdFGrlrbCm/1W/EHXhapRnlji5Bh4qgRvJyiEuqsbDzR11U
         Fy/vuFmRWnkuxpmazWb90fjVS1h4KD8O9vBu6e8HJ2n7oJeVV/LvqXnPAPCUpXc05zzf
         hEufx3VJz08aV7bCeRJZyfnGe8EL2LpfBl+uU5akYcTBzgQM9/VKVb6sMNLU6G8yQm39
         SE+g==
X-Gm-Message-State: AOAM533JXx27Qk5R82/Aez1GFpC2n6zudRjrDXnoMGjGAAZJ+vJ3Uh9h
        9xi7pBmUlJju5hwJZlj44oBT10UxmxZQgdYAhzS7KQ==
X-Google-Smtp-Source: ABdhPJwstiaYkAyZo1THj8xe+oXW4f9JIHuI6T4+cJiAD4kreqKlrJz75p/Z0FWYTNDXLSHiu3l/0UHuauvk+uaRpio=
X-Received: by 2002:a25:f817:: with SMTP id u23mr7292640ybd.466.1604618908706;
 Thu, 05 Nov 2020 15:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-17-saravanak@google.com> <20201105094318.GF3439341@kroah.com>
In-Reply-To: <20201105094318.GF3439341@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 15:27:52 -0800
Message-ID: <CAGETcx_Kh32AjVoUB3uiYBRhB+24JrceTp+HxG6vK6Ks=-e26w@mail.gmail.com>
Subject: Re: [PATCH v1 16/18] efi: Update implementation of add_links() to
 create fwnode links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 5, 2020 at 1:42 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:23:53PM -0800, Saravana Kannan wrote:
> > The semantics of add_links() has changed from creating device link
> > between devices to creating fwnode links between fwnodes. So, update the
> > implementation of add_links() to match the new semantics.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/firmware/efi/efi-init.c | 23 ++---------------------
> >  1 file changed, 2 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> > index b148f1459fb3..c0c3d4c3837a 100644
> > --- a/drivers/firmware/efi/efi-init.c
> > +++ b/drivers/firmware/efi/efi-init.c
> > @@ -316,11 +316,10 @@ static struct device_node *find_pci_overlap_node(void)
> >   * resource reservation conflict on the memory window that the efifb
> >   * framebuffer steals from the PCIe host bridge.
> >   */
> > -static int efifb_add_links(const struct fwnode_handle *fwnode,
> > +static int efifb_add_links(struct fwnode_handle *fwnode,
> >                          struct device *dev)
>
> So you are fixing the build warning you added a few patches ago here?
> Please fix up the function signatures when you made that change, not
> here later on.

I'm trying not to have a mega patcht that changes a lot of code.

I guess I can drop this "const" diff from this patch and then merge it
with the earlier patch that removes the const. But still leave the
rest of the changes in this patch as is. Does that work for you?

-Saravana
