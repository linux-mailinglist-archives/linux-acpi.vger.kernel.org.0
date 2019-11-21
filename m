Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71912105342
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKUNhx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 08:37:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44373 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKUNhx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 08:37:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so1625721lfa.11
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 05:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBjfogkmny/TFwXN7VDnq2QxaLgrfHo7DIEfnI/3nTg=;
        b=U2TYazxWCDbUrDzioWjNVb0h4MW3cyvbsOvSU5ckPvxHHODbjUJTxXXVginn/HmyIa
         p3qsIADXT3f9INDlCRqVeC+AL8+3H1DDO47uqaErFtVaRad9k/O4ndrV3LsSMlLQoXgn
         swehGAfvOLzu9dHljsNNfRWgB9ObkZN7uIXABkcA37/s2w9OIGZDwRAYpcpY1NPCoaF/
         TjnYLgC1y3uPEjlQ8BELUq4kWTXIvfKIQmhxbZwkbgFb3HujFYdnZKwynN3eZLTv7vC+
         9J39XeoX6b/iS+g+YrRCkpVFhCaLGGX7RZLBpqXAkRSqOPCr5YTzgcA2x83DG6A0NK8b
         wCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBjfogkmny/TFwXN7VDnq2QxaLgrfHo7DIEfnI/3nTg=;
        b=oUFk+K5caZ37Ac0+lsO50TqRRLbw1KHh4W8l5aqV4no2ZX/5ZFQB+pRRoDRn1zjvSR
         OthpfSC3sLBZWw5JdKHPT5Lh6S4ktfGRmJCSGYkSAZRZz5wSEPrV1Nf8TK+UgnpFwXm8
         d3HVFfgOn+BQrWZtXXPdCRLc7rS0au0FYO4twkXxfwI/ng+GXOJMCDbywtgkA/MBfAGj
         dlfalWqec8gF1NqmitJWEY4NK78gjnDr7Ovlk7PhRd0tK+ci8Ok1b8QN/GlLSZFIRLk+
         sVSn/e3PgWP+o1k+tYm+JZcj0ZSXzdmpBY53GXHN2jBencb4lJhZseh2d4tSgTNbd83H
         m9aw==
X-Gm-Message-State: APjAAAUtU9oQc8R7bqJTFvQfa6PETthnbjpRltYMGhqUnuS3vfK50xl0
        rQVaXAUCKhFHSCzeBsRzVBegN3vo5B3ikiWH0mU4iw==
X-Google-Smtp-Source: APXvYqzs1Wf1iQc/rqYLgevBcVLOm9Kp2098WDZuy+w74s6xQXXX0mPm40gMvAYEcqSRmNV83lt2pWbL9vS7SpwBjMU=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr7709131lfp.5.1574343471003;
 Thu, 21 Nov 2019 05:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20191114100804.15148-1-hdegoede@redhat.com>
In-Reply-To: <20191114100804.15148-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:37:39 +0100
Message-ID: <CACRpkdYC8qACy8tPRMxCX2+FdHN2G=eTVcX5npvV4HvxWKKe1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] pinctrl: cherryview: Split out irq hw-init into a
 separate helper function
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:08 AM Hans de Goede <hdegoede@redhat.com> wrote:

> Split out irq hw-init into a separate chv_gpio_irq_init_hw() function.
> This is a preparation patch for passing the irqchip when adding the
> gpiochip.
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add kerneldoc for chv_pinctrl.need_valid_mask struct member
>
> Changes in v3:
> - Check for pctrl->chip.irq.init_valid_mask instead of storing the result
>   of the dmi check in a new need_valid_mask pctrl struct member

Patch applied.

Yours,
Linus Walleij
