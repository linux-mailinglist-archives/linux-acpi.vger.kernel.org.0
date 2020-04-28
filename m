Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282971BCF71
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Apr 2020 00:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgD1WIn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Apr 2020 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgD1WIm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Apr 2020 18:08:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34C8C03C1AC;
        Tue, 28 Apr 2020 15:08:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so2869pgb.7;
        Tue, 28 Apr 2020 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CucLDCAtx0OGxZhd7U3+pHytapXL85CWzXGFNadaJVE=;
        b=u8UHPtK1e2CkwXwCIbugkPBrGfbll+2jZRPd5hxNVAPnRdPNIiaxQLWp0qctJuW3hZ
         TQFg2KWVdic6sCbm+fpRzywFvfjmaUkbLEEn5PbkAlomVTmvOWXUD5FSP1Zu/yCMXkXK
         7ul0qqpWHaXihJh4pYp4s3vBZuwjBPTll67qRISvg2JYnb2NK3vh7k6/fNBoWBC6IZAp
         /cWNk3N9t21YNqm50XA+Khtsc+vJCGhaNxST1UR/2EmPAPdKNdxutjKcyn5drifpKyK9
         pbpYNYt29TzmKJ0HSGrWGLy08Jdw006OMQr022lPvHNYIZyKTyUZQOmmzZPG7TdAa3Uw
         /ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CucLDCAtx0OGxZhd7U3+pHytapXL85CWzXGFNadaJVE=;
        b=dNf/0FjqaZR0ZfxqTbBoCQN0k7b/KhUH6Mju/lLK/bjiDUq199yYDX6DvUcwUzrV/D
         djzcqxPNjYbQth0jzxLMY0e0HRazylwbS6CV74wP5QC0qFGvIrnB9c3693ToOrIE5tlx
         9LqhuKsBCFJDeDjMb6YmodzssS7gGSwi8956K6bCkm3yANZaa0xzEmTCQ1oIM+BvBvBu
         1W0ex5glu6pJPncJWnMhzLFY9iDHphYjTRiOf+sJjSkuh4+mlztmu3MiSriDKNyup4It
         oPC97QnlehvYA8TIRitYBMmIEACX01GoCxrGHeYdZBnMlDVL/UK8cACb4rKFCJth+7Lq
         WIww==
X-Gm-Message-State: AGi0PuafWH6U3glVNvKjAlWqintt+ZSLFJqHfeI/abJQUFR270+uQ5YZ
        uklF3dlX7UuaFLZEP12Nw2fIvVpxLEthPE7y1Ro=
X-Google-Smtp-Source: APiQypII6SQ5Okuw51pNlgbiYJwS78/56MsUavstfIBtJG+uEuAH2KEa+LkeL7KGv5KMNZ+oiRyok8ChtOfvf7/z2/E=
X-Received: by 2002:a62:f908:: with SMTP id o8mr1552806pfh.170.1588111722155;
 Tue, 28 Apr 2020 15:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200428215804.48481-1-arnd@arndb.de>
In-Reply-To: <20200428215804.48481-1-arnd@arndb.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Apr 2020 01:08:30 +0300
Message-ID: <CAHp75VfSny=nSeiCnjE8MwL=hLT92G--9qy6=_0mittzuPxc-A@mail.gmail.com>
Subject: Re: [PATCH] acpi: avoid uninialized-variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 29, 2020 at 1:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Older compilers like gcc-4.8 produce a bogus warning here
>
> In file included from include/linux/compiler_types.h:68:0,
>                  from <command-line>:0:
> drivers/acpi/property.c: In function 'acpi_data_prop_read':
> include/linux/compiler-gcc.h:75:45: error: 'obj' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>                                              ^
> drivers/acpi/property.c:934:27: note: 'obj' was declared here
>   const union acpi_object *obj;
>                            ^
>
> Ensure the output is always initialized even when returning an error
> to avoid the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e601c4511a8b..3aa71daeb0b4 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -587,8 +587,10 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
>         int ret, i;
>
>         ret = acpi_data_get_property(data, name, ACPI_TYPE_PACKAGE, &prop);
> -       if (ret)
> +       if (ret && obj) {

It changes semantics and requires obj to be non-NULL.

Should be
if (ret) {
  if (obj)
    *obj = NULL;
  return ret;
}

> +               *obj = NULL;
>                 return ret;
> +       }
>
>         if (type != ACPI_TYPE_ANY) {
>                 /* Check that all elements are of correct type. */
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
