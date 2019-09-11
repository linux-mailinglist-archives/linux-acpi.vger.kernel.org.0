Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE55CAF96A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfIKJsx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Sep 2019 05:48:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41156 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKJsw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Sep 2019 05:48:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id a4so19332820ljk.8
        for <linux-acpi@vger.kernel.org>; Wed, 11 Sep 2019 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuIkQgmeG79jRGh7Mc6IT8LtcxFI+4dknLktYiNBnXQ=;
        b=L9hidE0N4xL635hxcw9vlTRN7QAXwa1tqbNMX0wqBdiziEeeduIzzj5gjKcU30qXMF
         TFqnXs8FCbfOm+fVCavj1OS1SzMYREAvulE86OrDE0p5iOvMulbwW8m4eYToFexmptsz
         23eFNGaQ08ASPLBT6puN/H+I4MkXT6hGck9KM7deGnikBQTV2GBknCM95yBcopwqllrT
         rsuKn7sgfuTeCAwKGkwmMpruRXj5BB6MNudqZFw31naU+IvGuEt5rcqBtl7T7wxHyc8O
         mvpU73lwC3LHTGm9RFJveDA0RpvBouBFJh4b1dJD1YP5YwFK1ee4iDxY+PTXB1+ZHL6m
         W9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuIkQgmeG79jRGh7Mc6IT8LtcxFI+4dknLktYiNBnXQ=;
        b=KBm/pQk2VW45pSzHxx8bJMRgrIPM4xM7ycpsfDS5+triT0HHicMdADEKR0Ie3OxMHm
         FFDsuxBGbN57/tEhfDYQMnbQfxonW78D0q82yZeg7FGLipeW9sDc9M7+7hcXH2HW8YEX
         zjZ4xNuM+8oyn+jucDhDXhIuUXBf+zbx7+1Jn5fpYzAuA4VlA78cznSg5e1OmISOsgM1
         bq28nveIfj0ZFjnz271HdLqbeR+CLUDz82GMI2+FnYHgEdUWOSrGyLA/nNRL8DbAxNMW
         i9J5qRlvrCAcHcA035zFm2OpqCDFlLFaLFcr9s/F75NXShqwZVgOZvZNNsZcF7Q4ejMW
         sNZg==
X-Gm-Message-State: APjAAAWAi+FFcQualXLg9daDJoB6uhS05bTrW1fl3eJD7pCpUBUAYO99
        dEBIZaaNKTBp3GV5aAOo0uEt+U07dGiYgs9UXWK0yVJ8uDPGYA==
X-Google-Smtp-Source: APXvYqxvSRgGJGGfqxnn/UQNSNuz2YWRG/RHGlr6VjiTObudPBZcAs4WawR+xtXm841ztLt8I5JIM2db6KbSSn01jIk=
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr15586230ljc.28.1568195330701;
 Wed, 11 Sep 2019 02:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190827202835.213456-1-hdegoede@redhat.com>
In-Reply-To: <20190827202835.213456-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:48:39 +0100
Message-ID: <CACRpkdZ+89GMj0qkU40pR6Lhog6u_bjJe+8L0wui=Huwc_8KoQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot
 option and blacklist
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 27, 2019 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Another day; another DSDT bug we need to workaround...
>
> Since commit ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events
> at least once on boot") we call _AEI edge handlers at boot.
>
> In some rare cases this causes problems. One example of this is the Minix
> Neo Z83-4 mini PC, this device has a clear DSDT bug where it has some copy
> and pasted code for dealing with Micro USB-B connector host/device role
> switching, while the mini PC does not even have a micro-USB connector.
> This code, which should not be there, messes with the DDC data pin from
> the HDMI connector (switching it to GPIO mode) breaking HDMI support.
>
> To avoid problems like this, this commit adds a new
> gpiolib_acpi.run_edge_events_on_boot kernel commandline option, which
> allows disabling the running of _AEI edge event handlers at boot.
>
> The default value is -1/auto which uses a DMI based blacklist, the initial
> version of this blacklist contains the Neo Z83-4 fixing the HDMI breakage.
>
> Cc: stable@vger.kernel.org
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Ian W MORRISON <ianwmorrison@gmail.com>
> Reported-by: Ian W MORRISON <ianwmorrison@gmail.com>
> Suggested-by: Ian W MORRISON <ianwmorrison@gmail.com>
> Fixes: ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events at least once on boot")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use a module_param instead of __setup
> - Do DMI check only once from a postcore_initcall

Patch applied for fixes, thanks for working this out,
sorry for slow reply.

Yours,
Linus Walleij
