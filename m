Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0F29F5B4
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgJ2UAu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJ2T76 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 15:59:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970FC0613D2
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 12:59:58 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 32so3499474otm.3
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLa2ZHCXHWu0bt5VmwEbsYdLxajAJVN4w/GM5byMaUg=;
        b=datsJVpPzeYFAZ8ec3rDhSvnG/UwVqhf99XQ/1HFEA9OGgE4uRxNr11zMM2QdK76/2
         AfbMjvWceUnySG3jldV9cmSfKO/cvAWzfs67UV+PF3hJvIdK9aCKKeZpiNdd5U3597En
         iOuI8rB7ekEWOURZNlhq+3UaP9UBVySGZ8qpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLa2ZHCXHWu0bt5VmwEbsYdLxajAJVN4w/GM5byMaUg=;
        b=lyx6ptOxO6ZLSY5PdHM2VPdEEYvjcsRAy9UNXBjOVnCqXqverxkQJw657iH1pOEE/c
         Cgcqdd+4yt3CFYWoPtYU48qzYJiSXKar/b+OEPopIxO5ksvXfhVQ8mcJ/va+kN8fW9dF
         0ttL50jM7XRCv2YGsxd//B0JqZs/7k+XCuIoJdgVr/3PpiaoT7yx52dROWiXDMO7x21q
         qRdxIkZKW+x1sNEH9EAHblqm4NvfmQaVlUIzY8TXn39kdfc66p2X361k056kz0CNpY1Z
         jPS6cDVheTN0Sg42lt4kIr5050ejy2BcXqUn7sFV1S88OZYzR9XUCSh55/mY7Qivzsle
         sAjQ==
X-Gm-Message-State: AOAM5331rDCv9bVrWzciy1PExvZfLN0Hnwr+KR2xa4Ou5EFB42HxNOn8
        dVXfDGEwDIvji09QgbIxQxrrSyfVH20aodv4
X-Google-Smtp-Source: ABdhPJyaWHiY3jgPN2Hk/9EVTItp2vmWcQG25xqgpVmnxQxmBNTkA0/Kg1cJNbnw5kPx73SyGXjg+g==
X-Received: by 2002:a9d:32b6:: with SMTP id u51mr4217008otb.226.1604001597603;
        Thu, 29 Oct 2020 12:59:57 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id z22sm851818ooe.21.2020.10.29.12.59.56
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 12:59:57 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id x203so4274329oia.10
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 12:59:56 -0700 (PDT)
X-Received: by 2002:aca:cc01:: with SMTP id c1mr957490oig.128.1604001596307;
 Thu, 29 Oct 2020 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com> <20201029193243.61546-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201029193243.61546-2-andriy.shevchenko@linux.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 29 Oct 2020 20:59:44 +0100
X-Gmail-Original-Message-ID: <CANiDSCseRCUVBV7SGZeuuyUyiFBmDYQ1D_DfXoEXXMaRxgvzzg@mail.gmail.com>
Message-ID: <CANiDSCseRCUVBV7SGZeuuyUyiFBmDYQ1D_DfXoEXXMaRxgvzzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 8:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It appears that people may misinterpret active_low field in _DSD
> for GpioInt() resource. Add a paragraph to clarify this.
>
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> v2: added Rb tag (Mika)
>  Documentation/firmware-guide/acpi/gpio-properties.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index e6e65ceb2ca1..370fe46c6af9 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -55,6 +55,9 @@ Since ACPI GpioIo() resource does not have a field saying whether it is
>  active low or high, the "active_low" argument can be used here.  Setting
>  it to 1 marks the GPIO as active low.
>
> +Note, active_low in _DSD does not make sense for GpioInt() resource and
> +must be 0. GpioInt() resource has its own means of defining it.
> +
>  In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
>  resource, second pin in that resource with the GPIO number of 31.
>
> --
> 2.28.0
>


-- 
Ricardo Ribalda
