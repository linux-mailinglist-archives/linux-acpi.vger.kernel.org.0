Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCB46563B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhLATT1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 14:19:27 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46037 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLATT0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Dec 2021 14:19:26 -0500
Received: by mail-oi1-f170.google.com with SMTP id 7so50552582oip.12;
        Wed, 01 Dec 2021 11:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OBdGMq4dd6q5ULNQxzUbPqXvw17CH5bFY6zNdVF51c=;
        b=G7fpR2mDxcC6cdNc1n818EhFqUklCoObSavNenUS4ZLIlrRIC66YvbcUKHVqRpTU2O
         +q3rMw3gzaz7/Jlq6+RY6mhRHaljdoGqQA6QnssneoEKUjJxDdlH6IKJjZ53unRE3ejg
         7yb1vFnPonVoKR+h0leZ9k/S4JlXqc1ILZvrJHEj1cuQNJrHHCFzSP/EXwi4L1UNEQZY
         xnP7ltkD3FE3BYtrPwR9avRuZaDAxKnfwMtiuDkpXB8EkojncSmQHwMLwxb6UI2cNs5h
         Edo/eQFn0wIc6Dnw4/6A0HCgT8GBTdVnGgHho02YXLphJ+KNKr5tAr6OJFJLo0fcKJnl
         vnog==
X-Gm-Message-State: AOAM533j8u1eM17f+Y6e7SHu0pm8yRGRJZrBe18hptEDyHkeOSkQMKdV
        lSGCaljYJScymASBIuBphrZolRmwvPNrfixC2Ts=
X-Google-Smtp-Source: ABdhPJzgpzdAoG8LxmgbxgA7nvJ0OQ3laiKyn2wRiL1HzJJ/jOWok40Q8xE7Hm8OUnKft2B+tANH8yz/Za6C1gZ64D4=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr110266oih.51.1638386165436;
 Wed, 01 Dec 2021 11:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20211122170536.7725-1-hdegoede@redhat.com> <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
 <cecea505-9a30-7114-3d3e-80856cccb6c4@intel.com>
In-Reply-To: <cecea505-9a30-7114-3d3e-80856cccb6c4@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 20:15:54 +0100
Message-ID: <CAJZ5v0jOtWRtf-iHG30+tw_BDibBOn4o7ROyokh=On4J5=R_2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ACPI: acpi_device_override_status() changes
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 25, 2021 at 10:53 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23/11/2021 13:13, Ulf Hansson wrote:
> > On Mon, 22 Nov 2021 at 18:05, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> As requested here is a v2 of my series previously titled:
> >> "ACPI: scan: Skip turning off some unused objects during scan"
> >>
> >> Which was a regression fix series for the commit c10383e8ddf4
> >> ("ACPI: scan: Release PM resources blocked by unused objects")
> >> change, but that has been reverted now. So as requested here is
> >> a v2 changing the wording of various commit messages since these
> >> changes are still useful to have regardless.
> >>
> >> Patch 1/7 is a v2/resend of the "ACPI / x86: Drop PWM2 device on
> >> Lenovo Yoga Book from always present table" patch. You requested
> >> changing the commit message of this one a bit to make it sound
> >> less like a regression fix (which it is not). But you already
> >> have the previous version of this patch in your bleeding-edge
> >> branch, with a "Cc: 5.1+ <stable@vger.kernel.org> # 5.1+"
> >> added ?  So depending on which version you want you can either
> >> skip this patch when applying this series, or replace it with
> >> the version from this series.
> >>
> >> Patches 2-4 are the main changes to make the always_present
> >> quirk handling more flexible, changing it into a status_override
> >> mechanism + adding a quirk for the GPD win and pocket to fix
> >> an issue with those in a more elegant matter then the current
> >> kludge in the sdhci-acpi code.
> >>
> >> Patch 5 is an unrelated patch which touches the override-status
> >> quirk table, so it needed to be rebased and I decided to add it
> >> to this series to make it clear that its v2 needs to be applied
> >> on top of the other ACPI changes from this series.
> >>
> >> Patches 6+7 cleanup the sdhci-acpi code, removing the now no
> >> longer needed ugly kludge for the GPD win/pocket. These can
> >> be merged independently from patches 1-5, through the mmc
> >> tree, as long as they get send to Linus during the same
> >> kernel cycle as the ACPI bits.
> >
> > This sounds like the mmc changes are really not that independent after
> > all. What about bisectability?
> >
> > An option is to funnel the sdhci patches together with the ACPI
> > patches through Rafael's tree. You have my ack for this, but let's
> > wait for Adrian's ack too.
>
> Looks OK to me.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

All patches in the series applied as 5.17 material, thanks!
