Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06045174296
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgB1Wym (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 17:54:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45486 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB1Wyl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Feb 2020 17:54:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so5090121ljn.12
        for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2020 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEk+rGai1GRI6QlTmVACuUYoYRTC+COuRPdssaHj9hU=;
        b=QYV4KNTsjUJKQupViFBewOqKWiK0ODb/mIegNzyagUoADqT7tFF4wH6/X5NuXQCIeG
         GeOj/xuQqe7SRQF/VK+2IX9CFoJHrl3Jyl8rLlXkFd5k26unehSN22d3oin/PBJACHM+
         qOwlf1j3EgMZngWwCuc7T85BO3RofzpjvRhFDwxbfcjVz2DwaXHeL4BBo/aLUmUWcqsz
         nS8QkdPIsTVd+PTmcbhV3a15on3mrRx7CHbGdqlfkimlmSHek3jMo2Tf3w7ujAqlzB/U
         lxO4BC16mjMnt6CIcpUqOzYyr+8gdZs2dFtl2rnmp4cNPM9NiJZHvTF78LeqrtqVuDJs
         7MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEk+rGai1GRI6QlTmVACuUYoYRTC+COuRPdssaHj9hU=;
        b=BPl0CKr3iGHif9RriEju/HUfBEEklxLTgHdqsOj+eIZjZvpY3bR+g2Rmd9ptXqi4WM
         yV+NGYAwoSOh9fsy+XYYFbNYu6HJ+iPvEzOnrwxQFFpLf2UxKLc/x2ERsxBTYMY+XHD2
         px0XwkmVly11k/dxVCreYG1oGFUrwX7frJKB0NeClEbtcMZnyn124j3KHxsXUudhOFEu
         nDffIOQkRbvG+6gPq67iQ42mP/54R0g6rg8cbgx4fxPTzKMOSQMoJdmg/d4q7LnAfk94
         dNEKHcXz/MDlz2LnFoM80jpErnXRAduyC+UQ02Z8ChBAiSs0Qp/dAC0NA+mMwLaa2PNv
         G1tw==
X-Gm-Message-State: ANhLgQ06tSr13/O3q33Lk+My9DEAaZ+LfFBRDLPHBgG9Glw783xKMMK/
        NRWzc0gs+azKaJPxcNoRuUPHBnkn98WDQ3YLKO/O2A==
X-Google-Smtp-Source: ADFU+vvct0krUKrAq5gI5QS2nVa0gcdunFoiXaZPdLALeC2hJ9Co5jGX5anrbEAfVAy9PC+2zyrJxJbS9gAgbBTc2jc=
X-Received: by 2002:a05:651c:39b:: with SMTP id e27mr3066189ljp.99.1582930479633;
 Fri, 28 Feb 2020 14:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20200225102753.8351-1-hdegoede@redhat.com>
In-Reply-To: <20200225102753.8351-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 23:54:28 +0100
Message-ID: <CACRpkdb3W=fL3VnNSep2MFnihqEj5GwWsN6BdWRSWckZBMHAOg@mail.gmail.com>
Subject: Re: [PATCH resend 1/3] gpiolib: acpi: ignore-wakeup handling rework
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Lehmann <schmorp@schmorp.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 11:28 AM Hans de Goede <hdegoede@redhat.com> wrote:

> The first patch just updates the comment describing why we are ignoring
> GPIO ACPI event wakeups on HP x2 10 models.

OK

> The second patch is more interesting, in the mean time I've learned their
> are actually at least 3 variants of the HP x2 10, and the original quirk
> only applies to the Cherry Trail with TI PMIC variant (and the original
> DMI match only matches that model). We need a similar quirk for the
> Bay Trail with AXP288 model, but there we only want to ignore the wakeups
> for the GPIO ACPI event which is (ab)used for embedded-controller events
> on this model while still honoring the wakeup flags on other pins.
>
> I'm not 100% happy with the solution I've come up with to allow ignoring
> events on a single pin. But this was the best KISS thing I could come up
> with. Alternatives would involve string parsing (*), which I would rather
> avoid. I'm very much open to alternatives for the current approach in the
> second patch.
>
> Since sending out the first 2 patches of this series I've received
> positive testing feedback for the quirk for the HP X2 10 Cherry Trail +
> AXP288 PMIC variant, so here is a resend of the first 2 patches with
> a third patch adding a quirk for the third variant of HP X2 10 added.

I'm waiting for some ACPI person to say yes to this,
Mika ideally but the other Intel guys like Andy also works :)

Yours,
Linus Walleij
