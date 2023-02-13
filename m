Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C227694F1C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMSU5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBMSUz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:20:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF171632B
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 10:20:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bt4-20020a17090af00400b002341621377cso1958873pjb.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkraeEhzI+P/kuddQQjLe1CP6x1sXn1JWchrJ5jCm/s=;
        b=bonyc5DEWup9PuvomxT9xQxnhRbU6/PVOYBs6RLM+adcXUmOSeaXIq0ITbAEU5ZX/6
         ZsoJvX3kUgP/99Zqcvj476BjGKQXf0sKXKKUONBPw/lo8K1FkAgx7qHIXC9+T7mTq9lU
         vd0inA6k9sxpV+5G3fISh+7CZR9h3K8TkcA6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkraeEhzI+P/kuddQQjLe1CP6x1sXn1JWchrJ5jCm/s=;
        b=yHUEcwC/6BcepGN7g+SqSRLLAiX3AmAxcx8WQFz3E0dEK2+v1yheP5OA7dmzyYbe1c
         qW/sqHPwD5Hg0XBzyPdIV4kvhZiXZA+yn6MXoXMQsC4zLjdVP74AUtNj3SzHa1yN47vX
         7HqWGYlkfmC8WRHWxwHVBLkbnw4roxn+KmgVZaraDCZQ7RDXtyFGcOXdWca9P6pB+gtM
         YLfNux/5/1kmRGnDq1UflTn9ac9sUyZN8/HOwY+CefgifZDW2BbxlqnhU6Zt7Ea7l68e
         TuZDwc3Ock9vswaCwNnY/AUoPvJsympDTBLhDQRRy33Gf4lwJ4S3Y24ZABfRPozB2IfL
         jMoQ==
X-Gm-Message-State: AO0yUKV4Z/gpZ4daDnXMxLOpMbKIKEOh+ZAa/hot1WdX2ai0ypxWsvPg
        MyGttCRYQ6sUmy5hMxn2A+34bsFzi9LEv/IC
X-Google-Smtp-Source: AK7set8S6dkzETVTgy7xlVBkw4aKs1bO+SIherSSsl2t7dhPXoNJXg06UWYD1uNNHwDsRkMP3WZSeQ==
X-Received: by 2002:a05:6a21:9996:b0:bc:ccea:a969 with SMTP id ve22-20020a056a21999600b000bccceaa969mr32943946pzb.26.1676312453602;
        Mon, 13 Feb 2023 10:20:53 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id m12-20020a638c0c000000b004ecd14297f2sm7394687pgd.10.2023.02.13.10.20.52
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:20:52 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id gd1so1972451pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 10:20:52 -0800 (PST)
X-Received: by 2002:a17:90a:3da5:b0:233:ca37:37c6 with SMTP id
 i34-20020a17090a3da500b00233ca3737c6mr1490129pjc.108.1676312451788; Mon, 13
 Feb 2023 10:20:51 -0800 (PST)
MIME-Version: 1.0
References: <Y+Z5OSa6hepQBOyc@smile.fi.intel.com> <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com> <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
 <Y+pLLzLDotZQLpdA@smile.fi.intel.com> <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
 <CAHQZ30Cs+kp82coR10Wat7q3S_8+pFf=5=44kMEMcjBOjmn=6A@mail.gmail.com>
 <Y+p4Sq/WnZ4jAp+F@smile.fi.intel.com> <Y+p6I379g+V4vpIc@smile.fi.intel.com>
 <Y+p6mY+w9POvkBzC@smile.fi.intel.com> <Y+p68FfTYpUP7B1F@smile.fi.intel.com>
In-Reply-To: <Y+p68FfTYpUP7B1F@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 13 Feb 2023 11:20:40 -0700
X-Gmail-Original-Message-ID: <CAHQZ30DaNjAREK3TXKtKC-G31NXi1tFTLmRRf8c-Ck1tg4e-YA@mail.gmail.com>
Message-ID: <CAHQZ30DaNjAREK3TXKtKC-G31NXi1tFTLmRRf8c-Ck1tg4e-YA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2023 at 11:01 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 13, 2023 at 07:59:53PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 13, 2023 at 07:57:55PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 13, 2023 at 07:50:02PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Feb 13, 2023 at 10:20:41AM -0700, Raul Rangel wrote:
> > > > > On Mon, Feb 13, 2023 at 7:47 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
> > > > > > Am 13.02.23 um 15:37 schrieb Andy Shevchenko:
>
> ...
>
> > > > > > Schematics for the NH5xAx can also be found on this unofficial clevo mirror
> > > > > > (service manuals, scroll to end for schematics):
> > > > > >
> > > > > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
> > > > > >
> > > > > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AF1.zip
> > > > > >
> > > > > > User: repo
> > > > > >
> > > > > > PW: repo
> > > > > >
> > > > > > >> The schematics were shared by the reporter for the original issue which is
> > > > > > >> how we reached the conclusion there was a mistake.
> > > > > > >>
> > > > > > >> As they're both Clevo designs it's certainly possible they have the same
> > > > > > >> mistake in two systems.
> > > > >
> > > > > > > Thank you!
> > > > > > > I have looked at the schematics and read discussion.
> > > > > > >
> > > > > > > So, the conclusion that this is a BIOS bug is incorrect in my opinion.
> > > > > > > The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
> > > > > > > signal for a while or on the PCB level, so that pull up should be connected
> > > > > > > to another power source that stays on.
> > > > > > >
> > > > > > > This means the description on the initial patch with the same issue is
> > > > > > > incorrect.
> > > > > > >
> > > > > > > Do we know the power sequence on the suspend to see which and how on the
> > > > > > > time line the power sources are off/on?
> > > > >
> > > > > If you look at the load switch for 3.3VS, its EN2 pin is connected to
> > > > > SUSB#_EN which is connected to SUSB# which is connected to
> > > > > AND(SUSB#_PCH -> SLP_S3_L, PM_SLP_S0 -> S0A3_GPIO). So there is no
> > > > > PMIC/EC firmware that is incharge of this. I guess I'm not quite sure
> > > > > how they have S0A3_GPIO configured, so maybe I have an invert wrong.
> > > > >
> > > > > The EC does control DD_ON which controls the 3.3V and 5V rails.
> > > >
> > > > On page 6 of the schematics I see the U7 that forms SUSB# from SUSB#_APU
> > > > (which corresponds to what you said) _and_ EC_EN, which is GPIO from IT5570,
> > > > which is EC.
> > > >
> > > > Are you using different schematics? I'm using the one from FDO bug report.
> > >
> > > Just checked this one:
> > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
> > >
> > > Also uses EC (SUSB_EC#).
>
> Sorry, this has to be read as SUSBC_EC#.

It looks like SUSBC_EC# has to stay high during S3/S0i3 otherwise it's
going to shut down the S5 power domain. So I'm guessing U7 is there to
prevent the S3 domain from being powered on while the S5 domain is
powered off.

Sheet 59 of 73 VDDCR_SOC_S5, VDDCR_ALW seems to have a helpful table
that describes all the power states. I'm confused where SLP_SUS# comes
from though. I'm also not sure about S5_MUX_CTRL since that seems to
be connected to a testpoint.

>
> > So this all makes me thing that either EC firmware is buggy or we have ACPI EC
> > code in the kernel to fix.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
