Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728865454A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiLVQmy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 11:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVQmx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 11:42:53 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89627DEE
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 08:42:52 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id mn15so1551884qvb.13
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 08:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSG4zYUj7P9Kgd+tx/TGwxdJYqamamppxaq2ATrBM24=;
        b=vyHU/N3hhtzlXenQ8Nk/ktnkLxRaxWEjflDSX0Sw22n36g6PAB0rza3IkU3LZC2E7A
         gJPr9IJ0lyVopDSNZuyJlaNtUQFwle3+mXEnY4fMzBNYGCDfTOYPdM8cJvSQR/OWdxrp
         Oc9+3eZOLuuE98+MXWG6dee9X3/MnJ+4FqkFlCmGHF9KotdM8awr2x9FDr+gpvGfRck3
         6IK38/qwK7HAR11uvn+2AIfDQxe911EhkPv7apUXGPbaKTMeM3jtEn5+uBXW9Blc01c7
         a2X5VFSOkbScfBmDmtZ7FqI+E6dQ/PZ1xDv/cXIfNl/qGMD+oGXt2YgO7BoS+8r6L/mj
         qzjA==
X-Gm-Message-State: AFqh2krpyYOE+HlPv2A3a75T6NoXEExnctFAQrH7FS6wB4erPLkqIK8t
        MuAuUZYSUnyPgRTDlTwW7t0EUpV4g6lVlnK1iNwpC7F8
X-Google-Smtp-Source: AMrXdXsZFdpO33sUccLBgM5DQFt0F7BiKU2fEqrR0SD5IJsittclD8nA5IuXCdJ3dQ7XhNJeW4xjYbPfDTTeKPBigjQ=
X-Received: by 2002:a0c:c345:0:b0:4c7:27cf:dfca with SMTP id
 j5-20020a0cc345000000b004c727cfdfcamr270636qvi.3.1671727371530; Thu, 22 Dec
 2022 08:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20221208164207.13518-1-mario.limonciello@amd.com>
 <MN0PR12MB61014F8D6D5B04B90997480DE2E19@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJZ5v0hm00E4xNC6r9MieOTFtdchQHj9k8a34fk-0Oi6UzwLQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hm00E4xNC6r9MieOTFtdchQHj9k8a34fk-0Oi6UzwLQA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:42:40 +0100
Message-ID: <CAJZ5v0g8eF5B1D0qUGMXeSuMBenCJ4NixHALPpxS_xc+B5z89w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Adjust ACPI video detection fallback path
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
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

On Thu, Dec 15, 2022 at 8:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 15, 2022 at 8:20 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Sent: Thursday, December 8, 2022 10:42
> > > To: Rafael J . Wysocki <rafael@kernel.org>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Hans de Goede
> > > <hdegoede@redhat.com>
> > > Cc: amd-gfx@lists.freedesktop.org; linux-acpi@vger.kernel.org; Daniel
> > > Dadap <ddadap@nvidia.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>
> > > Subject: [PATCH v3 0/3] Adjust ACPI video detection fallback path
> > >
> > > In kernel 6.1 the backlight registration code was overhauled so that
> > > at most one backlight device got registered. As part of this change
> > > there was code added to still allow making an acpi_video0 device if the
> > > BIOS contained backlight control methods but no native or vendor drivers
> > > registered.
> > >
> > > Even after the overhaul this fallback logic is failing on the BIOS from
> > > a number of motherboard manufacturers supporting Ryzen APUs.
> > > What happens is the amdgpu driver finishes registration and as expected
> > > doesn't create a backlight control device since no eDP panels are connected
> > > to a desktop.
> > >
> > > Then 8 seconds later the ACPI video detection code creates an
> > > acpi_video0 device that is non-operational. GNOME then creates a
> > > backlight slider.
> > >
> > > To avoid this situation from happening make two sets of changes:
> > >
> > > Prevent desktop problems w/ fallback logic
> > > ------------------------------------------
> > > 1) Add support for the video detect code to let native drivers cancel the
> > > fallback logic if they didn't find a panel.
> > >
> > > This is done this way so that if another driver decides that the ACPI
> > > mechanism is still needed it can instead directly call the registration
> > > function.
> > >
> > > 2) Add code to amdgpu to notify the ACPI video detection code that no panel
> > > was detected on an APU.
> > >
> > > Disable fallback logic by default
> > > ---------------------------------
> > > This fallback logic was introduced to prevent regressions in the backlight
> > > overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
> > > timeout.  If this turns out to be mistake and this part is reverted, the
> > > other patches for preventing desktop problems will avoid regressions on
> > > desktops.
> > >
> > > Mario Limonciello (3):
> > >   ACPI: video: Allow GPU drivers to report no panels
> > >   drm/amd/display: Report to ACPI video if no panels were found
> > >   ACPI: video: Don't enable fallback path for creating ACPI backlight by
> > >     default
> > >
> > >  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
> > >  include/acpi/video.h                            |  2 ++
> > >  3 files changed, 18 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.34.1
> >
> > FYI, besides me, this series also tested successfully by one of the
> > reporters to the Red Hat bugzilla.
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1783786#c8
>
> Thanks for letting me know!
>
> I'll queue it up for 6.2-rc next week.

Done now, thanks!
