Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4296DA57BE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfIBNgk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 09:36:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34337 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfIBNgh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 09:36:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so12940022ljh.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Sep 2019 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LhD/sF/NTN0NjoFAgiiHQ7UUs0ybG0eLJoGIh+N4ts=;
        b=yt5Kk70QvcaLMsgSVuGuAG4SWM+BIcLIE5gou9GHOehJB4r9b6weJu+L7oHTmKWf1G
         fX/yXW2q6/k6BNw8YAh51Jz1YplyVXmpWkzRX/rbuKi1zIv8GcZA3hbylkT11Dc7iaf2
         UGWvbJ0bU+abLpXT6JPE+sKYsFDh14BO9haw58yB5Jesu632ftsPtb7jEp+yQsLtBeua
         h6bewrNUmYJldinBXbVXilFKl05GC6gWO8jL+Ees9sIZ+roT2Xq6s4iZF1aIs4QqX4Va
         fNgWF6FpKWU72uZOR1YsWCa5OnA/ZEmxIr5AAA9nCB5JlphyvX/FIT4W0Oxgn0gPqATz
         CsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LhD/sF/NTN0NjoFAgiiHQ7UUs0ybG0eLJoGIh+N4ts=;
        b=Pty6+DJ/DTRab8m93AB+v+ZVdZMkxAYAjUPKq67zKkYFfgVE3nc67vkdJUwZQ9gxyW
         bE37VvFbUroPiIDYCdflwCVIyBhw5e61ZK42YSKJ4cOqaorejM19hW0VdjaeBfednGVR
         f5/UUkX10UmWKBXc+GOXKTIZ4vouoGQSpK3owj3z9KlUSzErFadrLO5Gc5UX1AQ0+kWi
         sX0eveeY3V4UeboiwlTTPKmyFxmNv75SReMKpUWXDHBsbaBEzu/oQKhFf41bVlwcnlpE
         K5SyXatuClUwvDruf5xUCeNz/pSLfq3vSXkE+HvRkQRreuk9fBWi4MNJcdrMpinIE9AJ
         rESQ==
X-Gm-Message-State: APjAAAUwkF62DybYH6pwOqTHa7/HEAIuMwEDMDLvjlEaA9+jcyTJvs1/
        KAFG73fbllz/GO2fQPzEaF3gQU7bK48jkr0f9IcIrx+p/2U=
X-Google-Smtp-Source: APXvYqy/56/JZhH9u5h/dgz83LrB1WA4WlE3a52G84UNe7DNmvw7eo78678HYTfzEBqzkAB8w0uR5xAG6bAC2llAAJg=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr16425420lja.180.1567431395793;
 Mon, 02 Sep 2019 06:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190831030916.13172-1-peter@typeblog.net> <20190902100141.GW2680@smile.fi.intel.com>
In-Reply-To: <20190902100141.GW2680@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Sep 2019 15:36:24 +0200
Message-ID: <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: acpi: add quirk to override GpioInt polarity
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Cai <peter@typeblog.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 2, 2019 at 12:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Aug 31, 2019 at 11:09:14AM +0800, Peter Cai wrote:
> > On GPD P2 Max, the firmware could not reset the touch panel correctly.
> > The kernel needs to take on the job instead, but the GpioInt definition
> > in DSDT specifies ActiveHigh while the GPIO pin should actually be
> > ActiveLow.
> >
> > We need to override the polarity defined by DSDT. The GPIO driver
> > already allows defining polarity in acpi_gpio_params, but the option is
> > not applied to GpioInt.
> >
> > This patch adds a new quirk that enables the polarity specified in
> > acpi_gpio_params to also be applied to GpioInt.
>
> Thank you for an update!
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> on the condition that Dmitry and other input / Goodix developers are okay with
> the approach in general.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
In case Dmitry needs to merge this.

Or should I simply merge this patch to the GPIO tree?

Yours,
Linus Walleij
