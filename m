Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3366A440E79
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJaM6V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhJaM6U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Oct 2021 08:58:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8BC061570;
        Sun, 31 Oct 2021 05:55:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x19so793600ljm.11;
        Sun, 31 Oct 2021 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYBcFBMeZpWF63PW4ltMOb2+AbXtsqy14RTIVi2Tq8M=;
        b=KAGfl8THlFd/61YZXNxdewLTT2I8zkNPQgpdR/CG3lbEcF2c5Cv/VSb64epMDfnL7A
         yRreNuiVp+wof9q1zqsWzDZb11Yx4hiD2ZYKw80SjPES/faVpqTRs0SsXwSSFEowkDq6
         9+GIFiLnkMgO8mmpnHfLXFjk1z7MskEJ89wxF+MRji8CFAyiqaVJiDkcuhG/03H8ECTc
         ZEXQsp9OSmeqqsw8UWYeeik5X5i7MgkJVGfdeZzF6LarKiZdavOQe0mYjjPvbAC2PsBv
         5AeyEnRFe5EXqVTeMkD8sHqxM8QsEteSB2mxhibS383JNFrNxSCuj4OmjpTDUyJRrT6S
         Wb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYBcFBMeZpWF63PW4ltMOb2+AbXtsqy14RTIVi2Tq8M=;
        b=fwpfohrBh7vN74a5pd5TpoCorl9JOuVAnS3k/lcuQGXJZc5GUOywVxXfreknWFZSf1
         JXH4eu4odEtcRwbAhJudm6395/XwUv9BV+V+uAVgfPPvGHpW3D9Xnx/PWUX/qTtrpEtj
         ZZKgBI9UoeVonLnwt75gZzw6UTOBGxGMmVcIqvJZeH9FU9fNmbHvgcJhCuRMeddWoXEw
         AqzBX6KIUbtKK+FTL50W/PLxkNeXP+M7xda1bzl3fGSvdpJfUxcV98tHzwl3HDuh882X
         2wDqWArHykEl/h37XuLUeu6e+E8O4baQCmZI88RAYTkqZK0g+iLmCjh/zEFQVyIrcjnV
         Rnhg==
X-Gm-Message-State: AOAM531kNpKxqWz9Cfe+fcW59Yzn1YTvqHTpG3ebk8FOsg0tW2ejQP49
        8gnlEHXcLyiQBI/SZTNxOWcxu64EAbZ0GgoWJ11uo8VDhjo=
X-Google-Smtp-Source: ABdhPJzXuLY+sYls8rFoLyqx1J9Fu6DuIoqpHz5dpcM3hrPvmY9cjjauTtB5mjwmnIb+sziF9NMhxcHliNvB26wfoJ8=
X-Received: by 2002:a05:651c:1503:: with SMTP id e3mr24562498ljf.182.1635684946643;
 Sun, 31 Oct 2021 05:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211031090028.6445-1-hdegoede@redhat.com>
In-Reply-To: <20211031090028.6445-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 14:55:10 +0200
Message-ID: <CAHp75VcAom2wThv9+d9rWCP_AFeP0rs=GjFVU78sL4hwppiCAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: Fix intel_pmic_regs_handler() read accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 31, 2021 at 11:00 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The handling of PMIC register reads through writing 0 to address 4
> of the opregion is wrong. Instead of returning the read value
> through the value64, which is a no-op for function == ACPI_WRITE calls,
> store the value and then on a subsequent function == ACPI_READ with
> address == 3 (the address for the value field of the OpRegion)
> return the stored value.
>
> This has been tested on a Xiaomi Mi Pad 2 and makes the ACPI battery dev
> there mostly functional (unfortunately there are still other issues).
>
> Here are the SET() / GET() functions of the PMIC ACPI device,
> which use this opregion, which clearly show the new behavior to
> be correct:

OpRegion vs opregion (I would prefer the former), i.o.w. a bit of
consistency would be nice to have.

-- 
With Best Regards,
Andy Shevchenko
