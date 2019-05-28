Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BA2C55D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE1L0i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 07:26:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46573 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfE1L0i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 07:26:38 -0400
Received: by mail-io1-f67.google.com with SMTP id q21so15364466iog.13
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f63H1f5vJ9qAhu7DFKNxQrE7HwrSDOZLpyEalUp3FmA=;
        b=MoNcMVK+19rETeCSdS86WvUOF+QanmMuzgyz4USKjDCyqJy5ATxtytdNyWhLUhPzK7
         3lLrA4eJp6EUT974Ua9jV0EW1h3qZbVDHKknvEVDD0yCnCqhV3q1+395Q30LTAn5kyK8
         YJ/9sbJy+3/3jSrakrFSJGTunWBuqpSw9bTrYyQLBB2BB/1K8kUaCM1rOjXwFd8T1Kem
         x5hrYzZwsa+/3J4oY99XIA70l/itoCfN5VdEhdJgMf5CBuZH+xrGEZNyswxjs+4JDpGK
         x04m+SZ/gzISHQNxsntNIhWsx6Qp31qyqxvHeq1YNtXegLT6XWBd45+kOk48qErpubmi
         DSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f63H1f5vJ9qAhu7DFKNxQrE7HwrSDOZLpyEalUp3FmA=;
        b=s7fF7RPmxoM4gwfgBS6vQMFtimQuiQDVPS5EykYLC0k9qpWU/ECwpPPnqP1Uwlvdke
         KZv0WTBTcxJOF9cmUefwFPlqxEf2t83oT0QbAmpmq6kVM3Ngey3PC8lX/5Bsa8W//xJD
         BNMigQQ9F8yPKXKQE/LZBYrbEtPyGNk+o+nLGDwF06Xx5K8xL0M5H8kzD/43PUKwzsWJ
         RdyIAGdDOHrQcw9wXgAF24SOPlakD+0zu6X33Kg9KGTrQ1YK12YiZ+0GQNT3VjjdVNiU
         Fvs2clvAcQiffEZQX2RTqC4iZdKLIT+3hp79Nlf0ajnxcjgBfz/ZR8sx8xJYzp4UCO78
         Abaw==
X-Gm-Message-State: APjAAAU6EpB8fTlDSAgUvOyFZvj9UYRvERvA9fA9uryzpqU8PaJZAczo
        eOFsjwCUzGbOO9V6aM3ysqBWDIhzWGNjXkiNMlzYYQ==
X-Google-Smtp-Source: APXvYqxPxBqa6Q5trPqt6nLpEjrJvWagv+vXglYbTXmsfxK8aHVbZ7UlOoBk7J5fCcFuJ1NWlwPXJV7IrICxwnh16Ds=
X-Received: by 2002:a05:6602:2109:: with SMTP id x9mr108496iox.128.1559042797766;
 Tue, 28 May 2019 04:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
 <20190527112720.2266-5-ard.biesheuvel@linaro.org> <CACRpkdZt-AosWLPcwDQqi_2i4adDk-ioT3g3aTicyXiZpQOGGg@mail.gmail.com>
In-Reply-To: <CACRpkdZt-AosWLPcwDQqi_2i4adDk-ioT3g3aTicyXiZpQOGGg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 May 2019 13:26:25 +0200
Message-ID: <CAKv+Gu90dwSdLOwVFEuobSEAMYCS+ju8x-MDHVGng8OKG7taug@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] gpio: mb86s7x: enable ACPI support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 28 May 2019 at 10:34, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, May 27, 2019 at 1:27 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>
> > Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> > support for ACPI GPIO interrupts routed via platform interrupts, by
> > wiring the two together via the to_irq() gpiochip callback.
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks.

> I assume you want to merge this through the IRQ tree or the ACPI
> tree, so go ahead.
>
> If you want me to queue the whole thing in the GPIO tree just tell
> me (once we have the ACKs in place).
>

Marc is willing to take the whole thing via the irqchip tree. I'll
need to apply some tweaks though, so I'll send out a v4 shortly.
