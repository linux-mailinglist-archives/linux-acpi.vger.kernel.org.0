Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884CE484915
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jan 2022 21:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiADUDa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jan 2022 15:03:30 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:42847 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADUDa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jan 2022 15:03:30 -0500
Received: by mail-qk1-f178.google.com with SMTP id r139so35095454qke.9
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jan 2022 12:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRmGFuyIC8DFPxodp5uo3EazNSa5oGwJmTBdv13c2Ik=;
        b=Iv2Gg/+vRCPTUu3gIOgIJRCYVINNCqZVYnhM1tIHk+jhuLG1KgygmG2LejXPb2RoEq
         CWpnLiFtQGdvWba9DwBKEYre3CQ7bshn5mPQAfSx8xg/urAFxkKnCXVUqLbWyCz9LV/E
         2Yatjf0Fi15Xc8+L4te/ahdkc3kD9QHmL4ruOOqH6SlunpB2r3tTE0oaSibV7ll1Fq9o
         Vt3WflnVk6dEs8Z1e7ynZi2MuK2grULigSmNal7peNkI3OYka6McQZ0utNxuLBilb8B8
         G1vvOthAz5OUAMCBXc6jsDE5wgVeb8RJUKTEPLr68uh6AXoKzDq+3FkROK07DgEY7UF2
         XlpQ==
X-Gm-Message-State: AOAM530eZMiBfv8j82DsGxIazTGcGYPKwPbJrO/I8/irN7fFUgR8oGvL
        Iezow4KI+nEyCsHwViUa4OVsomF15h7Y0UTWFPJELvcV
X-Google-Smtp-Source: ABdhPJwd+WA6SesZf2tvcDnSLua8hSpXRQXywSvw7jxgvlWdHFVxNgdDqH9v94h7GeEmWMFhvhUaKK3ZbqUxXZtvSxM=
X-Received: by 2002:a05:620a:40d1:: with SMTP id g17mr37243034qko.621.1641326609653;
 Tue, 04 Jan 2022 12:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20211230193120.589337-1-hdegoede@redhat.com> <CAJZ5v0ihpNHZxJBRDGDFGME+Z+PZ8p5qzZ+ck3DAL=UsfT_p2g@mail.gmail.com>
 <df517ead-3535-c191-32e4-abbca0358ec0@redhat.com>
In-Reply-To: <df517ead-3535-c191-32e4-abbca0358ec0@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 21:03:18 +0100
Message-ID: <CAJZ5v0g545AoFd1Z==gzJe4cR_n-7PTCUn8QBiLcV1GtUxvW2Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI / x86: ac and battery device quirk work
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 4, 2022 at 4:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 1/4/22 15:52, Rafael J. Wysocki wrote:
> > On Thu, Dec 30, 2021 at 8:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> Here are 2 patches for ACPI ac and battery device quirk handling on x86,
> >> the first one refactors the almost identical quirk handling in ac.c and
> >> battery.c out into a shared helper.
> >>
> >> And the 2nd patch then uses the now shared code to also skip / ignore
> >> ac and battery devices on x86 Android tablets with known broken DSDTs.
> >>
> >> Note this applies on top of my:
> >> "[PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs"
> >> series which you've just merged into your bleeding edge branch.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Hans de Goede (2):
> >>   ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
> >>   ACPI / x86: Skip ac and battery devices on x86 Android tablets with
> >>     broken DSDTs
> >>
> >>  drivers/acpi/ac.c        | 43 ++------------------
> >>  drivers/acpi/battery.c   | 42 ++------------------
> >>  drivers/acpi/x86/utils.c | 86 ++++++++++++++++++++++++++++++++++++----
> >>  include/acpi/acpi_bus.h  |  5 +++
> >>  4 files changed, 90 insertions(+), 86 deletions(-)
> >
> > Applied as 5.17 material.
> >
> > Note that the changes here clashed with some recent battery driver
> > changes, so I needed to resolve the merge conflict.  Please double
> > check the result.
>
> Sorry about the conflict.
>
> I just checked and something indeed went wrong with the merge.
>
> Checking drivers/acpi/battery.c from your bleeding-edge
> branch there a bunch of now dead code still present there
> related to setting the now never checked battery_check_pmic
> global quirk flag:
>
> Line 55: "static int battery_check_pmic = 1;"
>
> Line 1105-1111:
>
> """
> static int __init
> battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
> {
>         battery_check_pmic = 0;
>         return 0;
> }
>
> """
>
> Line 1146-1161:
>
> """
>         {
>                 /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
>                 .callback = battery_do_not_check_pmic_quirk,
>                 .matches = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>                 },
>         },
>         {
>                 /* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
>                 .callback = battery_do_not_check_pmic_quirk,
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>                 },
>         },
> """
>
> Since this all just sets the now no longer checked battery_check_pmic flag, it
> is harmless, but all of this can be removed.

OK, I redid the merge, please check again.

Thanks!
