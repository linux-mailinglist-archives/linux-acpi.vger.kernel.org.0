Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1710536B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 14:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUNoQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 08:44:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45846 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUNoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 08:44:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so3230400ljg.12
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K0otERTNvT74kny//s+Esb968aWXqV7fYAW5fNqO0g=;
        b=MAaVb/M0xhecgSuOkJ0q9CK5Ul2e3S+RS4Pz5LboNvuMFgIwDwdaBelQhDi31212wS
         G4eXcTijIwM53aTV618gi6ofCsaq260bJQO3JzZCKhGOFkdy69BYR94V76JWXBl/6QzA
         TqOahLEmZFJnM3BYwFVw9mVjzDKClIj6A7NClMWxrrabT9otNDTU31pPNuwq7O43Uj+M
         0mCMWPZV0Ifs/Wv3k3qAf7rqZzRGhkXdSMB2qeDuxNC/EBnXkWdELNzSgCZ6mlFrqfo7
         O97ia5YBGK658Vm0EaDLFxFa2bMjT/ll1ceyBBWAoPKWGekNmssqkgg3k/MbIoeh91Ta
         2Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K0otERTNvT74kny//s+Esb968aWXqV7fYAW5fNqO0g=;
        b=hEIvuCBLkQkVQUoFm/87Y47SIKoPd5DFbcfGCiqb3cpW144spNltETmVFxTeCJuW2x
         Ta5GT9JWkOs3xbqNGfizW5O4/E1CoTxSyleQlw+vWHqMuk8Lq3K7PERlmbYITS06JNrI
         ZnD2UcAXxRr+e2YSSQYiq5ObQkMeqiyX1tDHgC9gvStq1JgmdLmnjxrJFTt3DuGgFDgm
         L4U7I8YDp35hqQsaG5SoK86zzoBRoKgyPINFaNrsxvXJr4TOqCOGoHhseQ9s5oQilVZJ
         GXc/bJrC72ikJCJrtM3ZthWJ31LV2aIpjMpW+rVwx5I3xs/fbJ1hcno/2Bz7zWJ1RmBE
         QCYg==
X-Gm-Message-State: APjAAAUwBL4Hr0RNi2Gjp9gp6IgBuBjFBywO9k6TBpOCfwoklcFb3iDL
        2ez8WJchORh8GVN2JcKPS/hoQ3gVDEKcd+0Zxp8xQg==
X-Google-Smtp-Source: APXvYqyVaIGF4hXZgkUL8OURtxHiBXZ+xiAU7pnS1QOfuIhQpLAxFvATZkjfMWlVIWAGyM3WUJeDaq6p3HFohJJSBUQ=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr7564523ljd.183.1574343854569;
 Thu, 21 Nov 2019 05:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20191114100804.15148-1-hdegoede@redhat.com> <20191114100804.15148-3-hdegoede@redhat.com>
 <20191115100657.GM32742@smile.fi.intel.com>
In-Reply-To: <20191115100657.GM32742@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:44:03 +0100
Message-ID: <CACRpkdby7iSNksc5AaiiLyvkvAYJb8zCq2R+uCNxu4jgjNkrqg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] pinctrl: cherryview: Pass irqchip when adding gpiochip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 15, 2019 at 11:07 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Nov 14, 2019 at 11:08:04AM +0100, Hans de Goede wrote:
> > We need to convert all old gpio irqchips to pass the irqchip
> > setup along when adding the gpio_chip. For more info see
> > drivers/gpio/TODO.
> >
> > For chained irqchips this is a pretty straight-forward conversion.
> >
>
> Pushed all three to my review and testing queue, thanks!
> (For v5.6 I suppose due to dependencies)

Ooops I noticed this and took out the two others I started to apply.
Sorry for the confusion, I let you send these to me when you think
the time is right. (Like right after v5.5-rc1).

Yours,
Linus Walleij
