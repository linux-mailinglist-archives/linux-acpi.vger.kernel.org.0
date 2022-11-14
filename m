Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A26283D2
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiKNP1y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 10:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiKNP1u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 10:27:50 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880020196
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 07:27:49 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id o13so5878596ilq.6
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 07:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTmBJiw7zq2+55IK2i5lvqXpXrgtNnZfziAf8eIe8Wo=;
        b=PaWrpJd/EIlMNI9jfFZReqGFh8H9grZ0A1tbNZHQjFVqRqm/wctdxI217YO8nUXeUF
         ttRNGT0eLKv6e0hJ+CKBJILStcwmJ36hyNd7O0ekq7t3eptiswJZEzo6BnIewSbO9cnf
         UTRwfTD3bm72JT7kfc3UlUpP1MPAwDpksnrDdAGEXk2HVE2QPp/Am4T6stA5Bhzwlbl8
         44K6kdZoOQZeSJPG6zbXHvGNgelVGhfdMDXkpAfKVN36ftmVqCSb2NQgShialygTbnOS
         C+R3rflSg/3tpNKYbpW5QVwA5cSWycHOKssF2xg0abvjk2VeTEi2KHBgbSE+bzOcGLQL
         HB7g==
X-Gm-Message-State: ANoB5pnNXGgqO2I/df5G5sUPZvtf/+KXlrsrbVo8nHw4rh+vdxawSO97
        oy6lcJMJvPDsYtH0sPcFs0/fHuLaTv4sPd7RzZc=
X-Google-Smtp-Source: AA0mqf5k/eaKKiIZ+n1xGSzntcavLzI1a8iWAljJbyt3k5LIAyG2BYa1Z3iaXXz8QNTayV0/XVqGetEGWV7lV9eMVQo=
X-Received: by 2002:a92:194d:0:b0:302:55d5:8808 with SMTP id
 e13-20020a92194d000000b0030255d58808mr3119054ilm.152.1668439669139; Mon, 14
 Nov 2022 07:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114144459.455519-1-hdegoede@redhat.com>
In-Reply-To: <20221114144459.455519-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 16:27:32 +0100
Message-ID: <CAJZ5v0jPV3VXSXO+tW+dUwZ7QkWdXmiDtA7TTOgM9++SpBiWZA@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: video: Prefer native over vendor + quirk updates
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
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

On Mon, Nov 14, 2022 at 3:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael, et. al.,
>
> As mentioned already in the RFC:
>
> """
> Here is a second attempt at always registering only a single
> /sys/class/backlight device per panel.
>
> This first round of testing has shown that native works well even on
> systems so old that the don't have acpi_video backlight control support.
>
> This patch series makes native be preferred over vendor, which should
> avoid the problems seen with the 6.1 changes before the fixes.
> """
>
> The 2 base patches (last 2 patches of the series now) are unchanged from
> the RFC. New is a bunch of video_detect DMI quirk updates, 3 small fixes to
> existing quirks + 2 new quirks. 1 of the new quirks is necessary to avoid
> a known regression with preferring native over vendor on 1 model,
> the other DMI quirk is unrelated to the other changes.
>
> This series applies on top of the platform-drivers-x86-v6.1-3 tag from:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/
>
> So either you will need to merge that tag (or merge v6.1-rc5 from Linus)
> before applying these patches, or I can merge this through my for-next
> branch which already has these changes. Either way works for me.

I'll apply them on top of the -rc5.

> Hans de Goede (7):
>   ACPI: video: Add a few bugtracker links to DMI quirks
>   ACPI: video: Change GIGABYTE GB-BXBT-2807 quirk to force_none
>   ACPI: video: Change Sony Vaio VPCEH3U1E quirk to force_native
>   ACPI: video: Add force_vendor quirk for Sony Vaio PCG-FRV35
>   ACPI: video: Add force_native quirk for Sony Vaio VPCY11S1E
>   ACPI: video: Simplify __acpi_video_get_backlight_type()
>   ACPI: video: Prefer native over vendor
>
>  drivers/acpi/video_detect.c | 110 ++++++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 48 deletions(-)
>
> --

Thanks!
