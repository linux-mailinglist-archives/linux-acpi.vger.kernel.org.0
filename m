Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7B55AFC1
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jun 2022 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiFZG7j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Jun 2022 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZG7i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Jun 2022 02:59:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB7764A;
        Sat, 25 Jun 2022 23:59:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ge10so12764598ejb.7;
        Sat, 25 Jun 2022 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFCTsw44eCfrIgw5g5eDIqwDRb52nasQ63KFo0XcRT8=;
        b=iosWctIEzGRn3VqhcDfevg21KFkBMr3PQc+fjRGdNPv6hLOSRgC4v7M2AstxoDchuC
         V7S++HUkNhKKm+6CFaxqe48R83MawCe1Sg1Cwal4RQ8QxsGkCdCLj3J8TdtAFkLk/8hI
         bpu2EZ3jGalQfBU0b4emd3UMybTBYMzNCYQARAjBEBYSbKEMDjkYF7EnjvHBFt3v59yy
         N76Bw0kQ69124S5YAS0EK3Tsim6/8AWqwDM2nhUbIb5wGPvJvxKxafMl1g8oj7ak7gVH
         QEU+nvsxU1m6Wz/GS6D2qYSdz9k8f3xlSVnzXaf6UoDGsiuRTf5baihDQkYYkStzBW6M
         +jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFCTsw44eCfrIgw5g5eDIqwDRb52nasQ63KFo0XcRT8=;
        b=ay4mBWHIhdI2SDaE4NM1UMlcVwn5aEKcZQwY7+MAlwXTPLHDBTCwjcK2xz6tjVLyy9
         3bqtnXNqTmdh9U+lRbZ+16Pl6gd5k64z9LJ0Vmo7DKqwAxlr0j568X/wxR1HE6QTAUxv
         oNTAa4TS3Av+m52psje68vuawU209A/GAslQ5d+PTr/a+aDXBGoGzE+vO8+bxkk9z/xx
         I51EYR5XVchJWvAaywAD4fL7ezJ1fFHgaY/Z+tNdFIJpBGblEBYYkaq3z4mV1WDZGn7z
         ffvSQ7yNadMqr9MVSE3xGz5bIycX2dL9sQCf8zXqP/ITl6sTch8jdvOTC2treZaX3In9
         xEZw==
X-Gm-Message-State: AJIora/RgSv/wgU3yAT4E6KkyaoJW7Asapr2Wjb+nMNWMdRvYOOzdpa7
        8BnX9EE5qbp8AENeAhJTZkVz5nwbR06UxzCvMPQ=
X-Google-Smtp-Source: AGRyM1vdbd0R7YMxYxy0P2dd8vQrxNLQeA6X4bNQXzyEIGvSWfphBH2XZjr5H4rQJtEKHjuHxSI7AndhUPKnaI4Hbw4=
X-Received: by 2002:a17:907:2d24:b0:726:34e6:52fd with SMTP id
 gs36-20020a1709072d2400b0072634e652fdmr7061557ejc.307.1656226775034; Sat, 25
 Jun 2022 23:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220624112340.10130-1-hdegoede@redhat.com> <df35a580-3e4b-cf45-004f-7c6848a1dfae@message-id.googlemail.com>
In-Reply-To: <df35a580-3e4b-cf45-004f-7c6848a1dfae@message-id.googlemail.com>
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
Date:   Sun, 26 Jun 2022 14:58:57 +0800
Message-ID: <CAPqSeKu0XRsgg1dQce+cc89LVrqX0GY0ak5Vzzv+PEHF2Pr95w@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: video / platform/x86: Fix Panasonic laptop
 missing keypresses
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans and Stefan,

On Tue, 21 Jun 2022 at 02:10, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
>
> Well, I looked into the acpi_video.c module and that one is to blame.
> By default, it assumes that both "OUTPUT_KEY_EVENTS" and
> "BRIGHTNESS_KEY_EVENTS" should be handled by this module.
> But on the CF-51, this does not happen. "Video Bus" does not generate
> any key events (I'm not sure about output, but plugging in a VGA monitor
> and enabling/disabling it with xrandr or tapping the "display" fn-f3
> hotkey does not get anything from "Video Bus" input device.
>

The "display" Fn-F3 hotkey doesn't generate any key events on mine
either. I have no external VGA monitors to test it anyway.

Apart from that, the patches work perfectly on my Let's Note CF-W5.
Cheers, Hans!

Tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>


On Sat, 25 Jun 2022 at 03:49, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
>
> On 24.06.22 13:23, Hans de Goede wrote:
> > Hi All,
> >
> > Here is a series fixing the missing keypresses on some Panasonic Toughbook
> > models. These missing keypresses are caused by
> > commit ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double
> > trigger bug"), which made the panasonic-laptop driver unconditionally drop
> > most WMI reported hotkeys.
> >
> > This series reverts that commit and then adds some more selective filtering
> > to still avoid the double key-presses on some models, while avoiding
> > completely missing keypresses on others.
> >
> > Rafael, these fixes rely on patch 1/7, which is a tweak to
> > the acpi_video_handles_brightness_key_presses() helper. Without this
> > tweak this series will cause a regression, so I would like to merge
> > the entire series through the pdx86 tree, may I have your ack for this?
> >
> > Regards,
> >
> > Hans
> >
> >
> > Hans de Goede (6):
> >    ACPI: video: Change how we determine if brightness key-presses are
> >      handled
> >    platform/x86: panasonic-laptop: sort includes alphabetically
> >    platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger
> >      bug"
> >    platform/x86: panasonic-laptop: don't report duplicate brightness
> >      key-presses
> >    platform/x86: panasonic-laptop: filter out duplicate volume
> >      up/down/mute keypresses
> >    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
> >
> > Stefan Seyfried (1):
> >    platform/x86: panasonic-laptop: de-obfuscate button codes
> >
> >   drivers/acpi/acpi_video.c               |  13 ++-
> >   drivers/platform/x86/Kconfig            |   2 +
> >   drivers/platform/x86/panasonic-laptop.c | 112 ++++++++++++++++++------
> >   3 files changed, 91 insertions(+), 36 deletions(-)
>
> The whole series works without any manual setup on my Toughbook CF-51:
>
> Tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
>
> Thanks again!
>
> Stefan
> --
> Stefan Seyfried
>
> "For a successful technology, reality must take precedence over
>   public relations, for nature cannot be fooled." -- Richard Feynman

-- 
Kenneth
