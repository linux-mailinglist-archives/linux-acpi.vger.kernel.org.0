Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A404A5D53
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfIBVIV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 17:08:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35669 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBVIU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 17:08:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so14719013otn.2;
        Mon, 02 Sep 2019 14:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huTQD+G6wSs8hXbu4stIdO9xW+9jjAIMQ/j2IBKOSLs=;
        b=kGdy5a6AxvT29kVSZ2Kida0dWzlyvLm2AgBkZrYN9pf7HnDv9MfF345a+0CKCigvWF
         CL1bNb8UEGH3t3ws7yGOul2dULhL3pS7ar+AiP3+x0p4oDRTngpwPOv5IVz+/CYiJOAx
         fY2Z2JUgCvs7HiQLDLSzMlBEBK95cG2gt3OnQMP7a+8sKU3vnvPuHS3UgzW9c1X/vNSd
         Bi39o+TKfx1+fltm4JGm3yZ7OzMo0B9K8L5AKm2mgYZ3AA2+IH2BYHP7Xz7Jk+eax+dK
         0w6g7FSG38HxRssA7lEMRA4o6cpBpZs28wKiYpZO/wM787ILchCaQJ805OuTghwHzvMn
         wacw==
X-Gm-Message-State: APjAAAXLxzdB5swd05MTJqInq8SQCSgIM3hFSrkFATmawv8Ny7j+qTog
        UhN1UZ2SdtbwqCCK9ZGINA4xg6364tcjiaMojAI=
X-Google-Smtp-Source: APXvYqyI27hb2RWcNRadfCbRlDtIXktARg70zP5FAIcXUKIjdX66KnAXJFj+Kt7ssn8uG1C93zycuqAbTk3HFoTJ7d8=
X-Received: by 2002:a05:6830:154:: with SMTP id j20mr26200025otp.266.1567458499533;
 Mon, 02 Sep 2019 14:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
 <20190722023530.67676-2-skunberg.kelsey@gmail.com> <CAJZ5v0gRzu0bVL+7L9NhbWu5OxveEP8H8v5qpiW-FeOtoOepiw@mail.gmail.com>
 <20190722182929.GA203187@google.com>
In-Reply-To: <20190722182929.GA203187@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:08:08 +0200
Message-ID: <CAJZ5v0iF=TxxD_gCJfaZzORTrcu+2StJE1_vhthB70jxqCkHuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: Remove acpi_has_method() call from acpi_adxl.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry for the delayed reply.

On Mon, Jul 22, 2019 at 8:29 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Tony (original author), Borislav (merged original patch)]
>
> On Mon, Jul 22, 2019 at 10:31:11AM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 22, 2019 at 4:36 AM Kelsey Skunberg
> > <skunberg.kelsey@gmail.com> wrote:
> > >
> > > acpi_check_dsm() will already return an error if the DSM method does not
> > > exist. Checking if the DSM method exists before the acpi_check_dsm() call
> > > is not needed. Remove acpi_has_method() call to avoid additional work.
> > >
> > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > ---
> > >  drivers/acpi/acpi_adxl.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> > > index 13c8f7b50c46..89aac15663fd 100644
> > > --- a/drivers/acpi/acpi_adxl.c
> > > +++ b/drivers/acpi/acpi_adxl.c
> > > @@ -148,11 +148,6 @@ static int __init adxl_init(void)
> > >                 return -ENODEV;
> > >         }
> > >
> > > -       if (!acpi_has_method(handle, "_DSM")) {
> > > -               pr_info("No DSM method\n");
> >
> > And why is printing the message not useful?
> >
> > > -               return -ENODEV;
> > > -       }
> > > -
> > >         if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
> > >                             ADXL_IDX_GET_ADDR_PARAMS |
> > >                             ADXL_IDX_FORWARD_TRANSLATE)) {
>
> The next line of context (not included in the patch):
>
>                pr_info("DSM method does not support forward translate\n");
>
> IMHO kernel messages that are just a constant string, with no context
> or variable part (device ID, path, error code, etc) are questionable
> in general.  Is there any dev_printk()-like thing that takes an
> acpi_handle?  Seems like that would be useful for cases like this.
>
> This message *does* include an "ADXL: " prefix (from the pr_fmt
> definition), and from reading the code you can see that the only
> possible method is "\_SB.ADXL._DSM".
>
> There's nothing an end user can do with these messages, so I suspect
> their value is for debugging during platform bringup, and it would be
> sufficient to drop the first one (as Kelsey's patch does) and change
> the second one like this:
>
> -              pr_info("DSM method does not support forward translate\n");
> +              pr_info("%s DSM missing or does not support forward translate\n",
> +                      path);

You have a point, but then I would expect the changelog to mention that.

As it stands, the patch does more than the changelog says, which isn't nice.
