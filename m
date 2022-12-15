Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BD64E1E0
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 20:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLOTiR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 14:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLOTiQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 14:38:16 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859B42F40
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 11:38:15 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id o12so105149qvn.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 11:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCo5fHS/msARJvD6FMrxNCEmeCv0inrfXrJpjQuhCMw=;
        b=mVxFyH7Heasaeeeav+pOudUDQcnHvVezR/3CGRHtUaMmijNoR/eanjW0XazHmUt5RQ
         IET7Z/4yUHX203bo8jNq7Y8x4iKYg/na3ZbtWTfLBd1+dV2JXniu2yX9FDUgoKym+xib
         COXV+Or9cVPKvnT7ksaTJbo1jN9uZpkH1BSMOxfZEljceMikzq4mARediMaw5kjW5YP+
         3BbTwBMZmkB7qT+s7D+TZGReDgH2jYnwNz7WF+eSV8S4wGIxUn51OCqPlHrPkMQmkraN
         6pNmOIlKfIXO8nTS292pb9hPkdpgBFTdDMIFBF5U017wIfiMX3Lafkomw2+g1T6rxu7S
         l61A==
X-Gm-Message-State: ANoB5pnqmZMYqC4xWbJXhSOVQR0IeZPSVbTWlM2VuCaOS6vdRfFg6YWm
        80zt/pYjBPEnz//79Yq87Jg2hgBJc9Trqumt8o4=
X-Google-Smtp-Source: AA0mqf7AdSAPqm+Rm/jIw/Y0XeGDJqKbVJTE1m/sfpcH1vOPVW7DK7mkqwaQKrN3oZtPkNTVgdrXiuouoqbHmBThyl8=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr70255020qvs.52.1671133094531; Thu, 15
 Dec 2022 11:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20221208164207.13518-1-mario.limonciello@amd.com> <MN0PR12MB61014F8D6D5B04B90997480DE2E19@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61014F8D6D5B04B90997480DE2E19@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Dec 2022 20:38:03 +0100
Message-ID: <CAJZ5v0hm00E4xNC6r9MieOTFtdchQHj9k8a34fk-0Oi6UzwLQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Adjust ACPI video detection fallback path
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Daniel Dadap <ddadap@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 15, 2022 at 8:20 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Thursday, December 8, 2022 10:42
> > To: Rafael J . Wysocki <rafael@kernel.org>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Hans de Goede
> > <hdegoede@redhat.com>
> > Cc: amd-gfx@lists.freedesktop.org; linux-acpi@vger.kernel.org; Daniel
> > Dadap <ddadap@nvidia.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>
> > Subject: [PATCH v3 0/3] Adjust ACPI video detection fallback path
> >
> > In kernel 6.1 the backlight registration code was overhauled so that
> > at most one backlight device got registered. As part of this change
> > there was code added to still allow making an acpi_video0 device if the
> > BIOS contained backlight control methods but no native or vendor drivers
> > registered.
> >
> > Even after the overhaul this fallback logic is failing on the BIOS from
> > a number of motherboard manufacturers supporting Ryzen APUs.
> > What happens is the amdgpu driver finishes registration and as expected
> > doesn't create a backlight control device since no eDP panels are connected
> > to a desktop.
> >
> > Then 8 seconds later the ACPI video detection code creates an
> > acpi_video0 device that is non-operational. GNOME then creates a
> > backlight slider.
> >
> > To avoid this situation from happening make two sets of changes:
> >
> > Prevent desktop problems w/ fallback logic
> > ------------------------------------------
> > 1) Add support for the video detect code to let native drivers cancel the
> > fallback logic if they didn't find a panel.
> >
> > This is done this way so that if another driver decides that the ACPI
> > mechanism is still needed it can instead directly call the registration
> > function.
> >
> > 2) Add code to amdgpu to notify the ACPI video detection code that no panel
> > was detected on an APU.
> >
> > Disable fallback logic by default
> > ---------------------------------
> > This fallback logic was introduced to prevent regressions in the backlight
> > overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
> > timeout.  If this turns out to be mistake and this part is reverted, the
> > other patches for preventing desktop problems will avoid regressions on
> > desktops.
> >
> > Mario Limonciello (3):
> >   ACPI: video: Allow GPU drivers to report no panels
> >   drm/amd/display: Report to ACPI video if no panels were found
> >   ACPI: video: Don't enable fallback path for creating ACPI backlight by
> >     default
> >
> >  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
> >  include/acpi/video.h                            |  2 ++
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >
> > --
> > 2.34.1
>
> FYI, besides me, this series also tested successfully by one of the
> reporters to the Red Hat bugzilla.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1783786#c8

Thanks for letting me know!

I'll queue it up for 6.2-rc next week.
