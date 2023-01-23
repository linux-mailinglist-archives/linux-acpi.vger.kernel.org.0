Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC26786F7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWUAa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 15:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAWUA3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 15:00:29 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B927D6B
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 12:00:28 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id hw16so33457321ejc.10
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 12:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40qXZUnFGQ7ve0bNYv96SrOOUpKugaFZGVN1hQpqfP0=;
        b=0ZhqRm6hCi2ZZ3tnj1xQ64fTMEgozDfdQZBjXGrtkC+jHdlRDnEByKQe9BBwyysLdH
         lNN831u3bglXj9g93C38BVwetw4uyb0h1h9KPwzc/GLkhLOTnXC7O8aWjDLR3Ftzxw2W
         6tpwbl8fVlqntSAgb3Fb4dxWpOBX6qPHg8ZS67Gm97gR6dxFTlOfOO3GAdc1SSWmDUnm
         icyHOxkAHqiL9ISsxJQX1/ZHd1JLZNp5xzGRccclRhfHP69RtL4sHQKXtaW2QoYu7PYx
         qm643+ChHgzFF0IbnVtMVO681/3Ny3A14wy6nbFaTQ76HOqREyZanV6QRZ+E+djXA5nv
         zyvg==
X-Gm-Message-State: AFqh2koVlLY7AadRyaeVZFITZKb/fQqDVK1+O27ini8gXhESTOUMcsCc
        4cZD85XIV9fODuMykO1YUOELe6lGuidOfVICHm8=
X-Google-Smtp-Source: AMrXdXtDkWPO0cICOZRJSCYboLUtX4oU3AuOqdMLnCRm9VggXqnac2q+nS8HXqfswKbhD4Rw9RobR/LLKvaU7lxDc68=
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr2001363ejh.78.1674504027140; Mon, 23
 Jan 2023 12:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20230119163744.548749-1-hdegoede@redhat.com>
In-Reply-To: <20230119163744.548749-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 21:00:16 +0100
Message-ID: <CAJZ5v0he+0WHk_iQB6T06h6Zx-UOW6F7R=ay-hLV9-_KxbTaiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: video: More backlight quirks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> With the backlight changes landing in 6.1.y now showing up in
> distribution repositories I have been receiving a steady stream of
> backlight bug reports by email.
>
> These bug-reports fall into various categories and most of them are
> already fixed with some recent fixes which are in 6.1.7 and later.
>
> One category (unfortunately) requires adding DMI quirks.
>
> I have been receiving reports from users with pre Windows 8 laptops,
> who used to pass acpi_backlight=vendor on the kernel commandline to hide
> a non functioning acpi_video# backlight device, so that userspace will
> use the native (GPU driver) backlight device instead.
>
> Starting with 6.1.y acpi_backlight=vendor is now also honored by
> the native backlight drivers, hiding the native backlight device,
> leaving these users with no backlight device at all.
>
> This leads to them sending me a bug-report. Which in a way is a good
> thing because these models really needed to have a DMI quirk added
> all along, but this was never reported upstream.
>
> The fix here is to use "acpi_backlight=native" and to set this through
> a DMI quirk so that things will work out of the box.
>
> The Acer Aspire 4810T quirk from a couple of days was like this and
> the first quirk in this series is too.
>
> I expect to receive more bug-reports like this, so you can expect
> a steady trickle of backlight quirk patches from me the coming time.
>
> Note the second quirk in this series is also a "acpi_backlight=native"
> quirk, but the root cause is somewhat different, see the commit msg.
>
> Regards,
>
> Hans
>
>
>
> Hans de Goede (2):
>   ACPI: video: Add backlight=native DMI quirk for HP Pavilion g6-1d80nr
>   ACPI: video: Add backlight=native DMI quirk for HP EliteBook 8460p
>
>  drivers/acpi/video_detect.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> --

Both applied as 6.2-rc material, thanks!
