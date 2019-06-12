Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76E942A86
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501881AbfFLPNn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 11:13:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42614 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501887AbfFLPNm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2019 11:13:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so10495191qkc.9
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2019 08:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwIDmOAGcEki3RdvfGMK1ES9aAPDYLop/FJjdHjbbH0=;
        b=tVXUG3Ik4yI/0d7nY0cnTx6GqDu2GPiI4oRE1fhS6Cu5efAqxa4tLfWcaIY+Bquu42
         dEASWmpyfNyzhjBjYJLOMu9CiekQD1tHRFOEsD7P4XnIBtOVZtWtMv2xe/uFzXGfrzlc
         MRPQSelW8uH3KxH8jtoIkyma5X9nkLdtgC6KSKT1kWq6hKukzAE9VAyEo9hLb5qV8aTH
         eGOSsDEdh7iJVaeEuBPdDmb5z6la4O3zMe4j3U2JWhpZxVTXpLO50lGbdn8rjCJHknw4
         W+lRcTXqEoAcXmNc+qVrzKOU5YRpyH9VDDwJQbNpI3Mm1xlV/+5YKk4NecTUN4yya9wE
         HiqQ==
X-Gm-Message-State: APjAAAXahdZ2HkgVpU8hp7bEGifDoXfnhTmpv1VEKnZb/J7AT/vRjHDe
        HQ6Nb6h+WkYQcC8VgYl9C0Q0uDvfVFWBh7G2nR3KQw==
X-Google-Smtp-Source: APXvYqyuURPY4j2JOFu4hsedR0SBO7Tpt4TyJyufs9gmWqDZmLHo/p8lFdBRjG8oj/ETsABwFm/k9tSacoYc2LNbjeQ=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr23929067qkn.269.1560352421153;
 Wed, 12 Jun 2019 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <CAO-hwJ+qSXwZ-5sAiZ55-r_PXp9pvnE1XEaE_v3SBnxzQQNH4g@mail.gmail.com> <20190611152833.GR28362@ediswmail.ad.cirrus.com>
In-Reply-To: <20190611152833.GR28362@ediswmail.ad.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 12 Jun 2019 17:13:29 +0200
Message-ID: <CAO-hwJKvxWktLOH4cpmUZEWrm3aPsazGe4Oo3eGSMdvQXZV4-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] I2C IRQ Probe Improvements
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, mika.westerberg@linux.intel.com,
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

On Tue, Jun 11, 2019 at 5:29 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Tue, Jun 11, 2019 at 05:16:58PM +0200, Benjamin Tissoires wrote:
> > On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > This series attempts to align as much IRQ handling into the
> > > probe path as possible. Note that I don't have a great setup
> > > for testing these patches so they are mostly just build tested
> > > and need careful review and testing before any of them are
> > > merged.
> > >
> > > The series brings the ACPI path inline with the way the device
> > > tree path handles the IRQ entirely at probe time. However,
> > > it still leaves any IRQ specified through the board_info as
> > > being handled at device time. In that case we need to cache
> > > something from the board_info until probe time, which leaves
> > > any alternative solution with something basically the same as
> > > the current handling although perhaps caching more stuff.
> >
> > Hmm, I still haven't pinpointed the issue, but I wanted to give a test
> > of the series and I have:
> > [    5.511806] i2c_hid i2c-DLL075B:01: HID over i2c has not been
> > provided an Int IRQ
> > [    5.511825] i2c_hid: probe of i2c-DLL075B:01 failed with error -22
> >
> > So it seems that there is something wrong happening when fetching the
> > IRQ and providing it to i2c-hid.
> >
> > That was on a Dell XPS 9360.
> >
> > Bisecting is starting.
> >
>
> I have a sneaking suspision, does this diff fix it:
>
> diff --git a/drivers/i2c/i2c-core-acpi.c
> b/drivers/i2c/i2c-core-acpi.c
> index 57be6342ba508..a90b05a269c36 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -169,7 +169,7 @@ int i2c_acpi_get_irq(struct i2c_client *client)
>         acpi_dev_free_resource_list(&resource_list);
>
>         if (irq == -ENOENT)
> -           irq = acpi_dev_gpio_irq_get(adev, 0);
> +         irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
>
>         return irq;
>  }
>

Unfortunately, this doesn't solve the issue.

The problem is either in 4/7 or 5/7 (4/7 doesn't boot AFAICT).

(chasing multiple rabbits at the same time, so hard to get to the bottom of it)

Cheers,
Benjamin

> There was some earlier discussion about which device was suitable
> for this call.
>
> Thanks,
> Charles
