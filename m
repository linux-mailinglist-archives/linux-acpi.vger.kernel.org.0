Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D778B2AF2CA
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 14:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKKN71 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 08:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKKN6u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2020 08:58:50 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A8C0613D1;
        Wed, 11 Nov 2020 05:58:50 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q5so1656192pfk.6;
        Wed, 11 Nov 2020 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX2IknY34AVLLsHKeEvJf13PSvdzJ2CHpJHjlbr+QWs=;
        b=DHcXpGaP1Bhzy1k2x0jQBqu7WZ7PgcGJh1laWS28dfzZ4qUwBw2VDcUAjkhrRS/7Yg
         kka5FFAw6g8OwGQ7eEzt4SV/lrk6w84Dqw21JDebOJ6ABzIZSt0V2kt8vWa6Yl4tPnrD
         cvp9sb95LU6olmxJ3Gu1oad3z0nh4u6XpnERWrehlKFGYREqQr/jvNzb2o397wY9R8dO
         FrhJ2oSLsQdRyQ+saY0TDBH/PCofMYfL47gTbJ2rPzahNLULTh+FE07Xf21c3qktKgF+
         73W1RBcm72nASy9BumLe9MV3Uo7kvK3nwm9cK6Ey9QIjb0UEeYqt2tkf9KoQZG3uu4vL
         SYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX2IknY34AVLLsHKeEvJf13PSvdzJ2CHpJHjlbr+QWs=;
        b=s4sLjA9+0KA8bo+0a5ts2WqFuLLk7fx9FWxVxsL7/L/rhVef/Lxb2JegpVI+D4LtqC
         4XuxBYGs/O4D5FRur4UOYRfDTZq9SY+bkt0fvDJOTIW6oWOLOvMUBVmzIS6zgpnLdU3l
         LpQ7sDHa8MYlkMHv4mCP8IUbIhUFDBJqX+yh6Bx+1TsIhEw9UXp+6D8obtpiU10SelIj
         Z0yhYaitXAIXZJGokjF/Q6t8ktee9ar14mafZG4VEMgnszf/xdr01AT0f0cEsDNxrFwf
         T1G2GMegrFZR0AVK1x07KMOpl0UuLRg4f5F1+9blBjFUlJyM77Z2GCNMctsMxSLALzla
         L+xA==
X-Gm-Message-State: AOAM532T3OevRK82/eJynqCUsLbIYKDUYYusycJZclJw6lCa3TO6PGi3
        /qSe0nAG2udXlbgFs7ijUOgpJzztnndeCOaJqphGLRN9Hfo=
X-Google-Smtp-Source: ABdhPJz5ScUzutVG3Yc6hFE+som1BIyVyqo/NnVgIKRNwsYUcaN7O04JLogjpy9P/0a2RrS/HKq6ftC5P8kENZpR7CM=
X-Received: by 2002:a63:4d64:: with SMTP id n36mr13334019pgl.203.1605103130049;
 Wed, 11 Nov 2020 05:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20201111130435.432982-1-f.suligoi@asem.it>
In-Reply-To: <20201111130435.432982-1-f.suligoi@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Nov 2020 15:59:38 +0200
Message-ID: <CAHp75VeccWtKRQkQE0XyyDZVvkD3QrBig2yU6=pz3KEG-bCKjA@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: ACPI: explain how to use gpio-line-names
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 11, 2020 at 3:07 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> The "gpio-line-names" declaration is not fully
> documented, so can be useful to add some important
> information and one more example.
>
> This commit also fix a trivial syntax error.

fix -> fixes
syntax error -> spelling mistake

Taking into account this done from the experience, it's a very good job, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Also nit-picks below.

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  .../firmware-guide/acpi/gpio-properties.rst   | 58 ++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index bb6d74f23ee0..a9f4dfa932cc 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -107,7 +107,61 @@ Example::
>
>  - gpio-line-names
>
> -Example::
> +The "gpio-line-names" declaration is a list of strings ("names"), which
> +describes each line/pin of a GPIO controller/expander.
> +This list, contained in a package, must be inserted inside the GPIO controller
> +declaration of an ACPI table (typically inside the DSDT).
> +The gpio-line-names list must respect the following rules (see also the
> +examples):

Since it's rest, I would expect gpio-line-names in above paragraphs to
be a term, something like
``gpio-line-names`` (double back quotes on each side). Yes, I know
that there are other places which need to be amended, but I believe
it's out of scope of this patch.

Also no need to have each sentence to be started from a new line, it
will be rendered as it has one white space in between.

> +  - the first name in the list corresponds with the first line/pin of the GPIO
> +    controller/expander
> +  - the names inside the list must be consecutive (no "holes" are permitted)
> +  - the list can be incomplete and can end before the last GPIO line: in
> +    other words, it is not mandatory to fill all the GPIO lines
> +  - empty names are allowed (two quotation marks "" correspond to an empty name)

``""`` but better to check the resulting (rendered) file. You may use
rst2pdf script for that.

> +Example of a GPIO controller of 16 lines, with an incomplete list with two
> +empty names::
> +
> +  Package () {
> +      "gpio-line-names",
> +      Package () {
> +          "pin_0",
> +          "pin_1",
> +          "",
> +          "",
> +          "pin_3",
> +          "pin_4_push_button"

+ comma at the end here as well.

> +      }
> +  }
> +
> +At runtime, the above declaration produces the following result (using the
> +"libgpiod" tools)::
> +
> +  root@debian:~# gpioinfo gpiochip4
> +  gpiochip4 - 16 lines:
> +          line   0:      "pin_0"       unused   input  active-high
> +          line   1:      "pin_1"       unused   input  active-high
> +          line   2:      unnamed       unused   input  active-high
> +          line   3:      unnamed       unused   input  active-high
> +          line   4:      "pin_3"       unused   input  active-high
> +          line   5: "pin_4_push_button" unused input active-high
> +          line   6:      unnamed       unused   input  active-high
> +          line   7       unnamed       unused   input  active-high
> +          line   8:      unnamed       unused   input  active-high
> +          line   9:      unnamed       unused   input  active-high
> +          line  10:      unnamed       unused   input  active-high
> +          line  11:      unnamed       unused   input  active-high
> +          line  12:      unnamed       unused   input  active-high
> +          line  13:      unnamed       unused   input  active-high
> +          line  14:      unnamed       unused   input  active-high
> +          line  15:      unnamed       unused   input  active-high
> +  root@debian:~# gpiofind pin_4_push_button
> +  gpiochip4 5
> +  root@debian:~#
> +
> +Another example::
>
>    Package () {
>        "gpio-line-names",
> @@ -191,7 +245,7 @@ The driver might expect to get the right GPIO when it does::
>  but since there is no way to know the mapping between "reset" and
>  the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
>
> -The driver author can solve this by passing the mapping explictly
> +The driver author can solve this by passing the mapping explicitly
>  (the recommended way and documented in the above chapter).
>
>  The ACPI GPIO mapping tables should not contaminate drivers that are not
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
