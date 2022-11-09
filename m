Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985F3622CD6
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Nov 2022 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKINv2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Nov 2022 08:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKINv1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2022 08:51:27 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58623157
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 05:51:26 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id ml12so12318531qvb.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Nov 2022 05:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWvAKiH1/mvr7kZZJrJ/hOQhLsckRfAT3gnv+TqAaPs=;
        b=RJ0cYU7mNMxNJIWssn13rKPis8HTQO8KPmC6hZHfSkcukCLsjEj0Ak8YUvUoonsA9u
         /4w3c0bmWW9HGsq/cvMUXnk3ZUWHNCItuxxkFitNQWvSZqXMfgEOtezZ1ck8bbNHIHvB
         UZhd/lbsjUIEG/GBmJYknJL5VftqcIOksyJ1f+5fQ/B5SvKz7dELTczOe+Ad0ocNivuJ
         KJGrSiDJNPyx5N4EuBWZgWYaf7fP+YZDydR+ZVrSrsgvchQL7lXAP5IAl/hKMQJWIkb2
         c30o6mhOlcc4SJoW7DopNxIFDR5LwpNEXYSlrQrGNFWF2n/xtam+bIe9FaNR+6Or0LxO
         vPVg==
X-Gm-Message-State: ACrzQf2cVvCMgz9E5XLe5I2iClD/D43bK2cDZcQ4O5F+2VrY7yVDnFPF
        pouflzRZGFKocVjp2JNcWREttabJ28Hx1e2wZ3jY1TL1Ad8=
X-Google-Smtp-Source: AMsMyM4/RSGviACwqoueB5g5Es1ITl0Nbe/j9BHwTvRvjPejA1xi67Cyfxeh3iv2xK/pwW9lCDbzCmsFpSE1AMp/bBg=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr54475285qvb.119.1668001885283; Wed, 09
 Nov 2022 05:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20221105145258.12700-1-hdegoede@redhat.com> <c364cee1-4309-ebc2-9aa3-ff467fe0096f@redhat.com>
In-Reply-To: <c364cee1-4309-ebc2-9aa3-ff467fe0096f@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 14:51:14 +0100
Message-ID: <CAJZ5v0hJx4GX-0Ny17LgbBZGXRDG+bnfmhDQeKpBDusQ+j1g6A@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: video: prefer native over vendor
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Sat, Nov 5, 2022 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/5/22 15:52, Hans de Goede wrote:
> > Hi Rafael, Matthew,
> >
> > Here is a second attempt at always registering only a single
> > /sys/class/backlight device per panel.
> >
> > This first round of testing has shown that native works well even on
> > systems so old that the don't have acpi_video backlight control support.
> >
> > This patch series makes native be preferred over vendor, which should
> > avoid the problems seen with the 6.1 changes before the fixes.
> >
> > ATM there is one known model where this will cause a regression,
> > the Sony Vaio PCG-FRV3 from 2003. I plan to add a DMI quirk for that
> > in the next version of this series, but I'm waiting for some more
> > testing (to check that the vendor interface does actually work) first.
> >
> > I will also do another blogpost, focussing on asking users to see
> > if they have a laptop which provides a combination of vendor + native
> > backlight interfaces, which may be impacted by this series. This is
> > the main reason why this is a RFC for now.
>
> The blogpost requesting testing of laptops with a combination
> of vendor + native backlight interfaces can be found here:
>
> https://hansdegoede.dreamwidth.org/27024.html

The patches in this series look reasonable to me, even though I'm not
sure if the assumption that the Windows 8 hardware certification
requirements were always followed is not overly optimistic.
