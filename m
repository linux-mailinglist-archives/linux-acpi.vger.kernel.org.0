Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCC10C994
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2019 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK1Nfm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Nov 2019 08:35:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45129 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfK1Nfl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Nov 2019 08:35:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so20052435lfa.12
        for <linux-acpi@vger.kernel.org>; Thu, 28 Nov 2019 05:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvu9OZfemBYDKg0MnhgqQk6YdpE94ksYWMXeOTcKvqI=;
        b=rZpffZGhAtCrVfEJ0STTAMBuizBQYAW52mwdkSePWuUDC6OQ0zz8Z9UVdUnR6H2hrY
         K8Zvn9LxDwzAlWTeJB7Ldx3bCWiqA26Hw3n9v/gp2fQF0eKMGpFlNmWAhySJS3XNTdas
         UUYv0H6vIgRTCERz1VJr2aOhsjB4FMCFbAux9lo6Cj8a+zIJaKjQ2RPLedJmZmMefZkO
         2hd68TxsA4uugErhZ0gKWJvLLL3X1uaEi7ucIqoM58qk7UPERby7BEqxbpuqpWVJFpK0
         FvtarJybUCicf7nDe5WUj+gFj10VYyPHsGggZmdyoMKuoCbUs3mvy/kEGkC9/BW9M5mK
         RBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvu9OZfemBYDKg0MnhgqQk6YdpE94ksYWMXeOTcKvqI=;
        b=IAuzZn5Lcbk8eoXGPVGlITDMr9gAUPXvyL58apalge44pJ5fQspV0UxwtlkBOV2mQA
         fBwo2255upxbgZ8YNiT4CkW3+u/77o1XIgmiaCzOZgHWOEdfDXnX2GamciWqMKi43IYr
         8ntXS6UNHKhX/Q4geZuoPRjQErCyyisXVBFn/aA0hviCCHKhHjRmIM+nrZYDE4r3nxDG
         aXKw9sxDuIe+q6QlbSCRNtbKeEwld5OF6Z1Gr7RjCXv/2DARxekt150KrE/9SOT48i52
         97IMjUt4XsuJp1SlKP89GrVCXIDPoOB7+x1iO9Td4aIZCH5ne5R3T8ZMBmiB+mYI/n8X
         kJoQ==
X-Gm-Message-State: APjAAAWLi2IrZ/BJyVG6MUYMPHv9SMi2KKLrmsV2cv7BWyCJasyUPWkq
        Pzdv2oedHvggDOojc6csRvIaJMRswhcFCDHAb7xC7axkprA=
X-Google-Smtp-Source: APXvYqzK0FbZzikTAfGQ/Uf5e40RCuK+895pCTYy155zY+oNBupV1A0B056rLvdFg3jVNLYSLcvbRBi8zlZyV8ONdPA=
X-Received: by 2002:a19:645b:: with SMTP id b27mr22047811lfj.117.1574948139781;
 Thu, 28 Nov 2019 05:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20191127104509.10196-1-hdegoede@redhat.com>
In-Reply-To: <20191127104509.10196-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 14:35:28 +0100
Message-ID: <CACRpkdZVPJyagQT4UwZDUHBvg0erFCwQumNKX9U3=AcHi=ZQGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Turn dmi_system_id table into a
 generic quirk table
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

On Wed, Nov 27, 2019 at 11:45 AM Hans de Goede <hdegoede@redhat.com> wrote:

> Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
> into a generic quirk table, storing the quirks in the driver_data ptr.
>
> This is a preparation patch for adding other types of (DMI based) quirks.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This patch does not apply to my "devel" branch, which I am about
to send to Torvalds, so it will very soon be the mainline.

Could you rebase it and I will queue it up for fixes.

Also: should these two be tagged for stable? (I.e. a non-v5.5
problem.) I suppose that requires backporting for -stable
though.

Yours,
Linus Walleij
