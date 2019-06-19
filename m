Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F374BA9B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSN6v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 09:58:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37455 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSN6v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 09:58:51 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so38431225iok.4
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2019 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvxTeLvo1wGHFPv7uTBe1XO0NnKzJUIfWhOOU5h4lIg=;
        b=JIQL/fuHh3nW4ACRNeOlsDUFR9QuWbLLWoW2shZ4gKxqwHNR7PJwfxZAIib07lXA5A
         J0wrBRgnmbTJ+J+xlLH9SaU+KKW12wZ8jrt82U7JpIZ3vA2REIfkOfxjdjm5iMiAEOXD
         WZldPZr3c0LPnK6pMU0/3KmDj8O8myXgfMVX5TL1IMpHPE//ZTO9X0HOQ3GSDd14CxP8
         uPQA/8o93f1sRZxGHjA2QsXtbpu/JpZL+vqTI6CXBzRtwxebsq3EGx6wBbAvwmOYOiO1
         7Dg0nNFRvdz6K86C8mEEQNr0LfclimlVHA8MbLn/J3NQ0pMySjjTTfezLfKGMq9PoLOk
         Ur5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvxTeLvo1wGHFPv7uTBe1XO0NnKzJUIfWhOOU5h4lIg=;
        b=H1Rc3JF8zQNJyhfKGMX1RFbHe8agW9kKfxOJ6n9GDmf2fiois0ebM07r65zHHvCXPP
         x8+V1zi4gtvx2CaShRIRwKtf4q6R+wOd1/UsRjIBn3pJTBSIqmXpkzIQWw3k9hxIwNn2
         tLEE+zUQlr7u3E466Ec0gAxRJxeCrlSnfLJTKbR58goUuzP5d/GDDgdKr+YfjAJA5alw
         o6Uc/DDb1YippOVjBEyRCo3tzUadK2C7fWN5yZzblofhU+o0AQq0376YBFP0goEt0+ND
         1deB2uw8MaQWG1QpvHHsNOJ9bMM/sE1gRnap3p1nyg55vTOBA5FA7Lf/lVoO4a+Bqlou
         vvBw==
X-Gm-Message-State: APjAAAV98t3msJy10SlCo41BHbEpa9mxXDNniacJqvQtPcS5sUVge2IU
        1KqTEmGYzAjo1rtvMFjiADt6N7hcu1cKbCWetQB2Hg==
X-Google-Smtp-Source: APXvYqxjv5E/j6PKuS5q3U1nNzQRVWACbrXUupHjV/lzwzD/A7tHJUe5JmRvpZyK59i47WifG0jYJ+lq2znG+WDwovY=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr23476992iob.49.1560952730283;
 Wed, 19 Jun 2019 06:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com> <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com> <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
In-Reply-To: <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Jun 2019 15:58:38 +0200
Message-ID: <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Jun 2019 at 15:21, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 6/19/19 2:59 PM, Ard Biesheuvel wrote:
> > On Wed, 19 Jun 2019 at 13:58, Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> >>
> >> On 6/19/19 1:16 PM, Mika Westerberg wrote:
> >>> On Wed, Jun 19, 2019 at 11:52:54AM +0200, Ard Biesheuvel wrote:
> >>>> The ACPI device object parsing code for SPI slaves enumerates the
> >>>> entire ACPI namespace to look for devices that refer to the master
> >>>> in question via the 'resource_source' field in the 'SPISerialBus'
> >>>> resource. If that field does not refer to a valid ACPI device or
> >>>> if it refers to the wrong SPI master, we should disregard the
> >>>> device.
> >>>>
> >>>> Current, the valid device check is wrong, since it gets the
> >>>> polarity of 'status' wrong. This could cause issues if the
> >>>> 'resource_source' field is bogus but parent_handle happens to
> >>>> refer to the correct master (which is not entirely imaginary
> >>>> since this code runs in a loop)
> >>>>
> >>>> So test for ACPI_FAILURE() instead, to make the code more
> >>>> self explanatory.
> >>>>
> >>>> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
> >>>> Reported-by: kbuild test robot <lkp@intel.com>
> >>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>
> >>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>
> >> I hit yesterday a regression caused by 4c3c59544f33. I've a custom ACPI
> >> tables defining I2C gpio expanders (gpio-pca953x.c as INT3491) and a
> >> spidev test device (SPT0001).
> >>
> >> Both stopped enumerating after 4c3c59544f33. With this fix spidev device
> >> enumerates but still get confused with I2C GPIO expanders (INT3491):
> >>
> >
> > Could you share the decomplied D/SSDT please?
> >
> It's Intel Edison with tables from Mika's sample ACPI tables. The
> interesting parts here are these two:
>
> https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/spidev.asl
>
> https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/gpioexp.asli
>
> The full tables are of course larger but I think those two above are
> relevant here. I build SSDT from arduino-all.asl below which includes
> bunch of other files and with above spidev.asl.
>
> https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/arduino-all.asl
>
> Let me know if you need full dump.
>

So can you explain how exactly the I2C GPIO expander is failing? I
struggle to understand how the SPI slave probing could be related to
that.
