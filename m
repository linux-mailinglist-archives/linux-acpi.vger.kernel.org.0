Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86053622E1F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Nov 2022 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKIOlu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Nov 2022 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKIOlt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2022 09:41:49 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5F30A
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 06:41:48 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id h10so12387033qvq.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Nov 2022 06:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBOH85dhgBajP+pDAIrjxyPqNX/hy+BNpReK2mRKnf8=;
        b=Tn7EbRclGn3+LnMkBvRxxiqtqZ90xL1gCJe4LX6/qluWgO9ugdrEJ1kgbSsOdaq4jh
         nBcImibABFA8dCUu+aePYlpVwYT5PRhRBQLwuynlcZ5jzVz9keGS7omNeq2KYBHZbx0C
         Dvino8ntrnuKQ8s5BSKL+sinV4VjqUWNHiHqzAsO6x2GnJiz3DOR9iQANqrGiLFqKmx5
         oJ32NqO/kG8vTh7Qqakw3qajT/FLvUbFTHY2tgi58Y32FJ3KESmM0RtELwAT8zlb5rsx
         7HstNwreUHq9oKmehLsrEUO4pEST34KHX5gvTkaDL1mi56e36zgiW5C8LZz+Sra8fnqd
         nhCA==
X-Gm-Message-State: ACrzQf3Lb8Do1uQk9/Ui0XAlgYDGbIcN8tPMTbUo7dv0S6vyCvOY4iM9
        j2pqTvpsbYsgluMfKDTW1eDRSc4+jC8qwMelFSA=
X-Google-Smtp-Source: AMsMyM60w0h+0/9xV/XrZGxB0Dtmw+nh1yFz28YvtXndDboZyB9Oa/UDHM0tvlQB8JF+tAkDWcDOJCEp6l3mB1YZh+M=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr46027486qvj.3.1668004907166; Wed, 09 Nov
 2022 06:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20221105145258.12700-1-hdegoede@redhat.com> <c364cee1-4309-ebc2-9aa3-ff467fe0096f@redhat.com>
 <CAJZ5v0hJx4GX-0Ny17LgbBZGXRDG+bnfmhDQeKpBDusQ+j1g6A@mail.gmail.com> <dd95fc25-6b46-b244-2ca6-954ba5ba129c@redhat.com>
In-Reply-To: <dd95fc25-6b46-b244-2ca6-954ba5ba129c@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 15:41:35 +0100
Message-ID: <CAJZ5v0gdFAoxsMbR==hecDsVrXFbB5CFJCv=r=XQec9cmRyENg@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: video: prefer native over vendor
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 9, 2022 at 3:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/9/22 14:51, Rafael J. Wysocki wrote:
> > On Sat, Nov 5, 2022 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 11/5/22 15:52, Hans de Goede wrote:
> >>> Hi Rafael, Matthew,
> >>>
> >>> Here is a second attempt at always registering only a single
> >>> /sys/class/backlight device per panel.
> >>>
> >>> This first round of testing has shown that native works well even on
> >>> systems so old that the don't have acpi_video backlight control support.
> >>>
> >>> This patch series makes native be preferred over vendor, which should
> >>> avoid the problems seen with the 6.1 changes before the fixes.
> >>>
> >>> ATM there is one known model where this will cause a regression,
> >>> the Sony Vaio PCG-FRV3 from 2003. I plan to add a DMI quirk for that
> >>> in the next version of this series, but I'm waiting for some more
> >>> testing (to check that the vendor interface does actually work) first.
> >>>
> >>> I will also do another blogpost, focussing on asking users to see
> >>> if they have a laptop which provides a combination of vendor + native
> >>> backlight interfaces, which may be impacted by this series. This is
> >>> the main reason why this is a RFC for now.
> >>
> >> The blogpost requesting testing of laptops with a combination
> >> of vendor + native backlight interfaces can be found here:
> >>
> >> https://hansdegoede.dreamwidth.org/27024.html
> >
> > The patches in this series look reasonable to me,
>
> Thanks.
>
> > even though I'm not
> > sure if the assumption that the Windows 8 hardware certification
> > requirements were always followed is not overly optimistic.
>
> After the second patch in the series the only remaining
> prefer_native_over_acpi_video() and thus the only acpi_osi_is_win8()
> call is guarded by a (video_caps & ACPI_VIDEO_BACKLIGHT) check as before:
>
>         if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>              !(native_available && prefer_native_over_acpi_video()))
>                 return acpi_backlight_video;
>
> So even if the assumption is wrong, there is no behavior change
> other then the intended behavior change already caused by the second
> patch.
>
> The last part of __acpi_video_get_backlight_type() which contains
> the basic (non special case) heuristics looks like this after
> this series:
>
>         /* Use ACPI video if available, except when native should be preferred. */
>         if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>              !(native_available && prefer_native_over_acpi_video()))
>                 return acpi_backlight_video;
>
>         /* Use native if available */
>         if (native_available)
>                 return acpi_backlight_native;
>
>         /* No ACPI video/native (old hw), use vendor specific fw methods. */
>         return acpi_backlight_vendor;
>
> Which is also a bit more KISS / easier to follow then before and
> I hope that this will work well.

Fair enough.
