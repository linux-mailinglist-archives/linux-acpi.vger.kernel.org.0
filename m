Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416CB43E0D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfFMPqz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 11:46:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43385 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfFMJc7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 05:32:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so8511351qtj.10
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jun 2019 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/0wpLIS7FS7jhfZMMu4pHMqQtu6yoM37ibHoRt1LgU=;
        b=StfuJcl9WKbWPDsIq8RaJALRVoCTgMU9Q8yLgQEs1rm9JdM9lxObISExkJFvLKjP8v
         fknR5tNqhYvbCYQh+b+9fVkff9qAbWQEDPQhvXLkJEQo8J83nFKacIP6bHwzSg02xjtE
         fvJyGNiwK9qxBeLMY47n7oLUmZOASGlRz/7K1rhLLkD6z01DgxYnHhuyxXcwQvYsgWJ2
         ToqTSVXLM6PdVoHLFshwnn7mbH1k7zUh1OPvCfCJfr2M4uz29lYCa8jHe2HYVQZCYNzi
         ch94MDUx1lsMsQQWYPdOPuf691wwiuXpH3JvxVWmsDLJAbmwr1+bhviQ13iKi51+GbPf
         c3Eg==
X-Gm-Message-State: APjAAAVTMvyZHtcxazj3zUeUitc2nVHy1nOB33ZGeBs/t76kVZzNr4FS
        5CtkUK2u8JXOyVhmKdXEpTf4s9IV+63PnlWXpclCXQ==
X-Google-Smtp-Source: APXvYqw/sQ5mcSwPf8226TuS+vkXk4CpLpVjnLElzksMN1ydqMV4lnQn38CN7pVjb+V0MEL78hfXr9xatbC4c+/4rMI=
X-Received: by 2002:ac8:224d:: with SMTP id p13mr54002135qtp.154.1560418378757;
 Thu, 13 Jun 2019 02:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-5-ckeepax@opensource.cirrus.com> <20190612152718.GC2640@lahna.fi.intel.com>
 <20190613084858.GU28362@ediswmail.ad.cirrus.com>
In-Reply-To: <20190613084858.GU28362@ediswmail.ad.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 13 Jun 2019 11:32:47 +0200
Message-ID: <CAO-hwJL-U0n5oFP-QXX8rD2Fxt9mDOKp-AknRN6QwXEhZsUBYg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 13, 2019 at 10:49 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Jun 12, 2019 at 06:27:18PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 11, 2019 at 01:30:58PM +0100, Charles Keepax wrote:
> > > In preparation for more refactoring make i2c_acpi_get_irq available
> > > outside i2c-core-acpi.c.
> > >
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >
> > > Changes since v3:
> > >  - Move the change to use the helper function from i2c-core-base into its own patch.
> > >
> > > Thanks,
> > > Charles
> > >
> > >  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
> > >  drivers/i2c/i2c-core.h      |  7 +++++++
> > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > > index 7d4d66ba752d4..35966cc337dde 100644
> > > --- a/drivers/i2c/i2c-core-acpi.c
> > > +++ b/drivers/i2c/i2c-core-acpi.c
> > > @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> > >     return 1; /* No need to add resource to the list */
> > >  }
> > >
> > > -static int i2c_acpi_get_irq(struct acpi_device *adev)
> > > +/**
> > > + * i2c_acpi_get_irq - get device IRQ number from ACPI
> > > + * @client: Pointer to the I2C client device
> > > + *
> > > + * Find the IRQ number used by a specific client device.
> > > + *
> > > + * Return: The IRQ number or an error code.
> > > + */
> > > +int i2c_acpi_get_irq(struct i2c_client *client)
> > >  {
> > > +   struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
> >
> > Is this adev checked for being NULL somewhere below before it is being
> > dereferenced?
> >
> > It could explain the issue Benjamin is seeing.
> >
>
> Yeah could be that or just for some reason this isn't returning
> the same adev as we previously had. I will do some digging see if
> I can find any likely culprits.

That was almost the culprit: client is NULL here.
So the call of i2c_acpi_find_client_by_adev(adev) fails.

I guess this explains why the next commit is also not working :)

Cheers,
Benjamin
