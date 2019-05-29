Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBF2DB0D
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2KvF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 06:51:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54463 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfE2KvF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2019 06:51:05 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so2927640itk.4
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LAgcjR7era76837ZVupJ1O8SoQVeLnh8cZfpeylJLY=;
        b=EEG1HaatyVgH65b4dDbncceMTfLGdSGuXy3aR3ymfnN10mD1HnXAioDuMpjBF390dy
         BGUI4mcrWKlfljrBm6+oAeE6NOJ/LLWkfpmRKOKwbR1pwNSe99mQJ7hF/Vd2fC2LhQ+c
         QX8iPPaVGNyw+AtmTQ/xbVzsmCZW7Yrgdt2jXdIHAkax/onBAkcIN00lFOnLQtn/N++I
         CYDKIqMzCi1ZujkbKqgkWi8ERRlsP4rvL4jxPZ/Lk9vVh4H1+KLSANN30Gsot4GJ1ebB
         Mjy1nYTClXsu3oYHoh9eCNGACkfHs1grNeKctK0VRNXKKhRCEsT8UmQrHs+f9PKg95vU
         Z7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LAgcjR7era76837ZVupJ1O8SoQVeLnh8cZfpeylJLY=;
        b=KaXlrB3jI4TOxpSzMJMdVU3ASpcu5V7w0hYBMUoE6JhwM6XtnQcgANOACRYsD597ui
         6NQrZ0WqRMnze8aVkjf1euDmox/smvt25R++HLvTnD/66C75iZaTOuSSbB3Bj379niGx
         ZbmdhtZ6xyW6CMQJIvUd3MzHA8/ikSGJzN8jKwC3Nbfpob9Tiz6b0zfzPcyUTD38p2kX
         n3X5z7oWenM0uub6dwibgPWQckwM8hTosNs8D7UC11HEdgx8p2ZZWEuNaDSQUG9KHj7X
         4rb2YHebTAAh+kkRbK/OwPnKuy565rZQdqdhizDAUUyMmvE1bfGcG9fpgk3R8fd0Kj2U
         YZrQ==
X-Gm-Message-State: APjAAAV7kD+E2WyMNfIy8583l3I0x+iYUf+u51+/KW7+FZhgnBn1Qwej
        m17NPw7/Ft76636FCbSz58PNEyfoyaNafHpZLtC5vQ==
X-Google-Smtp-Source: APXvYqw7rzjT8QDzUeqqM6KMIsW4kP6oMm7U8AcW9PA716fmjdAA2zox27Ha8YQxOL1CTcIXB4QKLXBnckJa9XyN9Ys=
X-Received: by 2002:a24:1614:: with SMTP id a20mr501136ita.153.1559127064365;
 Wed, 29 May 2019 03:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190529101342.30673-1-ard.biesheuvel@linaro.org> <20190529102747.GI2781@lahna.fi.intel.com>
In-Reply-To: <20190529102747.GI2781@lahna.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 29 May 2019 12:50:51 +0200
Message-ID: <CAKv+Gu_N2OC6mMcpvmz+gqa2cNaCf+ALe-tc0z+s4kDDi1RK3w@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio/acpi: set direction for ACPI OpRegion GPIOs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 29 May 2019 at 12:27, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, May 29, 2019 at 12:13:42PM +0200, Ard Biesheuvel wrote:
> > The ACPI GPIO OpRegion code never sets the direction for GPIOs that
> > it configures from scratch, leaving unconfigured GPIOs to be left
> > at the default direction, which is typically input not output.
>
> The code does:
>
>   enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio);
>
> before it requests the GPIO. Isn't that sufficient?

Yes, it works if I set the PullXxx value explicitly in the GpioIo() resource.
