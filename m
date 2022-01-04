Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A74843D7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jan 2022 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiADOwp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jan 2022 09:52:45 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:45778 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiADOwo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jan 2022 09:52:44 -0500
Received: by mail-qv1-f51.google.com with SMTP id a9so34532553qvd.12
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jan 2022 06:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iySLg1/pWzGJ8gx8MT8AAjBPH8Mzzac27pvv+MPdjU=;
        b=UjFmMY0pMQfzszi9OHghZ1XC8HKMR2wwCDXfg4ySFZ+F5XQI/ZbtovRDk5L1GaHDHc
         mJBrrqMENnoCYhZaWPco2hAl1IH/S/H/SpPayHWH7PwOor4Kg18j461N1VZijEYNdLUg
         QfPRbAnaE34/4dQjQLRlrKU5TTriCHcQ6LYVtsOEKo2JqpmsuZ4igckjvZZaD5dSTerY
         WwnVL3uALsTTwavhxFctcHTJ/JyqQ8h98IAe0JpAhkugUwupRxd0+rTnpAa0Xm71iByk
         EK3P1jSHyIluj9EYOC6QcI2TiL3rZ1mTdIEOuILDb1BGyD5fEV4gOfg+kNNasTPvDygI
         O3ng==
X-Gm-Message-State: AOAM530EMX8dd5RXLWU2y8uSmUfAHlsJOSJLnYpa3YMsapXBYV4LfwqG
        OlAdQs3G3ltfac1GDc257fUoInzLbT9q7M/Uw9xp0fsT
X-Google-Smtp-Source: ABdhPJwAkU8IAiITQkcC625JrAoTPRMJIf1gSecCgcZTB8e0DsWqC9+a8VeRbEbNGugqAEs83F87iwTqqr2ssljffLo=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr45623745qvd.52.1641307964319;
 Tue, 04 Jan 2022 06:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20211230193120.589337-1-hdegoede@redhat.com>
In-Reply-To: <20211230193120.589337-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 15:52:33 +0100
Message-ID: <CAJZ5v0ihpNHZxJBRDGDFGME+Z+PZ8p5qzZ+ck3DAL=UsfT_p2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI / x86: ac and battery device quirk work
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 30, 2021 at 8:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Here are 2 patches for ACPI ac and battery device quirk handling on x86,
> the first one refactors the almost identical quirk handling in ac.c and
> battery.c out into a shared helper.
>
> And the 2nd patch then uses the now shared code to also skip / ignore
> ac and battery devices on x86 Android tablets with known broken DSDTs.
>
> Note this applies on top of my:
> "[PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs"
> series which you've just merged into your bleeding edge branch.
>
> Regards,
>
> Hans
>
>
> Hans de Goede (2):
>   ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
>   ACPI / x86: Skip ac and battery devices on x86 Android tablets with
>     broken DSDTs
>
>  drivers/acpi/ac.c        | 43 ++------------------
>  drivers/acpi/battery.c   | 42 ++------------------
>  drivers/acpi/x86/utils.c | 86 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h  |  5 +++
>  4 files changed, 90 insertions(+), 86 deletions(-)

Applied as 5.17 material.

Note that the changes here clashed with some recent battery driver
changes, so I needed to resolve the merge conflict.  Please double
check the result.

Thanks!
