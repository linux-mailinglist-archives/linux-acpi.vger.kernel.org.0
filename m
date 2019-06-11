Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250643D08D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfFKPRL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 11:17:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40850 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfFKPRL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2019 11:17:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so14962765qtn.7
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2019 08:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8EQNdlfEKMSd2en3pkgledmujjaJiojIo3h1kmvnOQ=;
        b=qvWZ+7W5zKRtvD5J3EMg2UG2aQ3iuavNdRVFwnIcH4K4SZUfLPrUdmf8iG6RdmB7x2
         wza6nFyLZ7zyHh2OAPZy1YfrjjCWCo9q0rEflVOrIQc/QJIgErQEHEsha7SRnLu2OK4o
         /nULvM4M8R/6/qvNz/TEdzyntz1TYjFUp8fwZe7fcP+gJOawkjXrGhDLC37mfDsO2ujf
         lbPGBTGL51WbuiBhPXwUO7XvS1iDEq/tc3cvGdyeR7MkUee8TvnNW0213Z89ssKJPTDq
         Iy9SEiA2WPl8HNGcYS/GHlYEuqQFpQsrJhwTJ1USIIH8bGP0aDh7Db+0L94+fgq3ZthE
         iA0g==
X-Gm-Message-State: APjAAAW9+vRLkXtLdown0IQ5smKv+rlGXkTbY5IlHwgxuehresmYED2l
        r+e9jH6JivIEgGGw+0Q17TqGqflxGNZdt5Mh1wFlDA==
X-Google-Smtp-Source: APXvYqxTwhCXjUiYOLjzsXDsnhv8C1o60LWTFhRLJ28dtwbw6MnKs2gpVUwymuiiAZ8b1O+X+RMvu9It7qiwHlxTQk8=
X-Received: by 2002:ac8:2998:: with SMTP id 24mr62676416qts.31.1560266230100;
 Tue, 11 Jun 2019 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 11 Jun 2019 17:16:58 +0200
Message-ID: <CAO-hwJ+qSXwZ-5sAiZ55-r_PXp9pvnE1XEaE_v3SBnxzQQNH4g@mail.gmail.com>
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

On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> This series attempts to align as much IRQ handling into the
> probe path as possible. Note that I don't have a great setup
> for testing these patches so they are mostly just build tested
> and need careful review and testing before any of them are
> merged.
>
> The series brings the ACPI path inline with the way the device
> tree path handles the IRQ entirely at probe time. However,
> it still leaves any IRQ specified through the board_info as
> being handled at device time. In that case we need to cache
> something from the board_info until probe time, which leaves
> any alternative solution with something basically the same as
> the current handling although perhaps caching more stuff.

Hmm, I still haven't pinpointed the issue, but I wanted to give a test
of the series and I have:
[    5.511806] i2c_hid i2c-DLL075B:01: HID over i2c has not been
provided an Int IRQ
[    5.511825] i2c_hid: probe of i2c-DLL075B:01 failed with error -22

So it seems that there is something wrong happening when fetching the
IRQ and providing it to i2c-hid.

That was on a Dell XPS 9360.

Bisecting is starting.

Cheers,
Benjamin

>
> Thanks,
> Charles
>
> See previous discussions:
>  - https://lkml.org/lkml/2019/2/15/989
>  - https://www.spinics.net/lists/linux-i2c/msg39541.html
>
> Charles Keepax (7):
>   i2c: core: Allow whole core to use i2c_dev_irq_from_resources
>   i2c: acpi: Use available IRQ helper functions
>   i2c: acpi: Factor out getting the IRQ from ACPI
>   i2c: core: Make i2c_acpi_get_irq available to the rest of the I2C core
>   i2c: core: Move ACPI IRQ handling to probe time
>   i2c: core: Move ACPI gpio IRQ handling into i2c_acpi_get_irq
>   i2c: core: Tidy up handling of init_irq
>
>  drivers/i2c/i2c-core-acpi.c | 58 ++++++++++++++++++++++++++++++++-------------
>  drivers/i2c/i2c-core-base.c | 11 +++++----
>  drivers/i2c/i2c-core.h      |  9 +++++++
>  3 files changed, 56 insertions(+), 22 deletions(-)
>
> --
> 2.11.0
>
