Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F285070896
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfGVS3b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 14:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfGVS3b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jul 2019 14:29:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B079C21901;
        Mon, 22 Jul 2019 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563820170;
        bh=+hifrCpXNdFDmg+2TTik5WppGirIpU+5Uvg26SzjKVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhTa47Ce9ebRm+v7XyDzUzwiDS0FQgPMYhqKwa9e9Z4mpUb10rR+yojuJNMWvy1TQ
         MsFuzBhgW67dm/N4kDZz4s+8RJPUtNax345vprI4ifpLfuDqsnmMzen4WCxkPSDygW
         XbQ2jEfqPZ1eCmlLmVf182HY8+oQceSB7grwkJgo=
Date:   Mon, 22 Jul 2019 13:29:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI: Remove acpi_has_method() call from acpi_adxl.c
Message-ID: <20190722182929.GA203187@google.com>
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
 <20190722023530.67676-2-skunberg.kelsey@gmail.com>
 <CAJZ5v0gRzu0bVL+7L9NhbWu5OxveEP8H8v5qpiW-FeOtoOepiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gRzu0bVL+7L9NhbWu5OxveEP8H8v5qpiW-FeOtoOepiw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+cc Tony (original author), Borislav (merged original patch)]

On Mon, Jul 22, 2019 at 10:31:11AM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 22, 2019 at 4:36 AM Kelsey Skunberg
> <skunberg.kelsey@gmail.com> wrote:
> >
> > acpi_check_dsm() will already return an error if the DSM method does not
> > exist. Checking if the DSM method exists before the acpi_check_dsm() call
> > is not needed. Remove acpi_has_method() call to avoid additional work.
> >
> > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > ---
> >  drivers/acpi/acpi_adxl.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> > index 13c8f7b50c46..89aac15663fd 100644
> > --- a/drivers/acpi/acpi_adxl.c
> > +++ b/drivers/acpi/acpi_adxl.c
> > @@ -148,11 +148,6 @@ static int __init adxl_init(void)
> >                 return -ENODEV;
> >         }
> >
> > -       if (!acpi_has_method(handle, "_DSM")) {
> > -               pr_info("No DSM method\n");
> 
> And why is printing the message not useful?
> 
> > -               return -ENODEV;
> > -       }
> > -
> >         if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
> >                             ADXL_IDX_GET_ADDR_PARAMS |
> >                             ADXL_IDX_FORWARD_TRANSLATE)) {

The next line of context (not included in the patch):

               pr_info("DSM method does not support forward translate\n");

IMHO kernel messages that are just a constant string, with no context
or variable part (device ID, path, error code, etc) are questionable
in general.  Is there any dev_printk()-like thing that takes an
acpi_handle?  Seems like that would be useful for cases like this.

This message *does* include an "ADXL: " prefix (from the pr_fmt
definition), and from reading the code you can see that the only
possible method is "\_SB.ADXL._DSM".

There's nothing an end user can do with these messages, so I suspect
their value is for debugging during platform bringup, and it would be
sufficient to drop the first one (as Kelsey's patch does) and change
the second one like this:

-              pr_info("DSM method does not support forward translate\n");
+              pr_info("%s DSM missing or does not support forward translate\n",
+                      path);
