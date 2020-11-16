Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFA2B4FED
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 19:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKPSiF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 13:38:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41646 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgKPSiF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 13:38:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id o3so6447861ota.8;
        Mon, 16 Nov 2020 10:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7txsWknCiewn8OFUjAkOemwMtstyUm6JbL05uCaZO30=;
        b=mwPwJfTytkIvoqE8WdgYnuYoBzNUSF9UCB6Yg4JovJsflfL4yUyyFdqSH5WDN6UdKB
         1WhbKQgi/vzgvS9wwpjqlKzHYrrvb1ccbDB11lRThWLL3OllDZC1rSPa7RoYSX6oJApx
         ob8vtaVkdPEn/BR8ThMiOMROC5za8PwjplIGVvzTMg269zskfNqGEZOZAc0LOF4pMaEi
         43orJCs3aJm+WkafGE4l9v1BVwWAr3y0Mb88+lNxktUf9fbcFUzY15doNHY9rYfpGuHU
         mOwSlHcY3NE1JtvzJsj0NFVbC/Wl2X8qMd0nC4Fqx328pYdujcATRhe8wgHhu2j2J2B1
         e4vg==
X-Gm-Message-State: AOAM532BzjsxbXwpZkUY3AwuiDRKndw549iszBky5mT6/hjpB0z5kmXd
        qRGkhwvS4lrHRHR/UjMuMnMrIDimkHL+HtfKX0U=
X-Google-Smtp-Source: ABdhPJydnVKU0HkvmtzkaJ8MXH5nibNJnfxF9XGbyqRGgQEVwOjyF9zM2XdFLOnFm4dfJ38vPNxHGWxqoWKpYDxzt7A=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr488714ota.260.1605551884287;
 Mon, 16 Nov 2020 10:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20201112131545.62628-1-f.suligoi@asem.it>
In-Reply-To: <20201112131545.62628-1-f.suligoi@asem.it>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 19:37:53 +0100
Message-ID: <CAJZ5v0gZxWJdNjRVqznhcNqO-Ofc6dGGES4CKhuk3w-jBhdaKw@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: ACPI: explain how to use gpio-line-names
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 2:15 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> The "gpio-line-names" declaration is not fully
> documented, so can be useful to add some important
> information and one more example.
>
> This commit also fixes a trivial spelling mistake.

The spelling mistake has been fixed already, so I dropped this part of
the patch and applied the rest as 5.11 material.

Thanks!

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>
> v2: - fix commit spelling mistakes
>     - add double back quotes to gpio-line-names
>     - adjust documentation lines layout
>     - add comma at the end of Package list names in the first example
>
> v3: - add: Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> v4: - add: Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
>  .../firmware-guide/acpi/gpio-properties.rst   | 58 ++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index bb6d74f23ee0..ae5396a1f092 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -107,7 +107,61 @@ Example::
>
>  - gpio-line-names
>
> -Example::
> +The ``gpio-line-names`` declaration is a list of strings ("names"), which
> +describes each line/pin of a GPIO controller/expander. This list, contained in
> +a package, must be inserted inside the GPIO controller declaration of an ACPI
> +table (typically inside the DSDT). The ``gpio-line-names`` list must respect the
> +following rules (see also the examples):
> +
> +  - the first name in the list corresponds with the first line/pin of the GPIO
> +    controller/expander
> +  - the names inside the list must be consecutive (no "holes" are permitted)
> +  - the list can be incomplete and can end before the last GPIO line: in
> +    other words, it is not mandatory to fill all the GPIO lines
> +  - empty names are allowed (two quotation marks ``""`` correspond to an empty
> +    name)
> +
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
> +          "pin_4_push_button",
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
