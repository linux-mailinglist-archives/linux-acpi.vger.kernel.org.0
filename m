Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8068562C899
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 20:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiKPTBC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 14:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiKPTBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 14:01:01 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262C31201
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:01:00 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id c8so12504776qvn.10
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLM6+LrKMf4XdTMtPSWALevAf7ay8VXtgvZntexMbrk=;
        b=rs9vlp1iRi5vHmfmcCKZB6kWCtWJJNbg2nenHkSFysMUKTnojMnv7HwdI5sCX77BHp
         G6TtQizdGZhIOqDacIOO/3mc51a3Z5410FPmk10qx42nfqPjuexk9mEPB1Q4YkjV16zr
         D1Y0K2UICpSbUCOXBBEJPtWeaRB7xrnCMAXZdlI7aUjv5fc+mK/DaNvjMxcAB+HwAkvk
         DK9XwRiSD4tYIv1vd/uKHToK8Ka1V+8057zQUZinM4xqvnRZn4x7sawLo13PPQy546Ph
         fH/4ju2TPy1ss3DtMz7KlKQM4sKdoEU53mW6Fw0Qp6/3YGAItDN4HWQ2iHex954mXvM3
         HgwA==
X-Gm-Message-State: ANoB5pmtwsWL/MyAhPj+8ANYnGvuAtfHkxQyfTpVAuuX4UuEq89zFIrv
        FT4ZBxrVvJ/M+46b13Wymh8OSKFkYf6+qpwiutQ=
X-Google-Smtp-Source: AA0mqf5JV6/BN/dQBZ83dAG/hFB/QP0rA7N90nyhxAr/Kcs5UeQ3vfagIIyNiESC3oYYG+fMCtUwD2YxAzGighLA9U0=
X-Received: by 2002:a0c:8043:0:b0:4c0:8055:fb5 with SMTP id
 61-20020a0c8043000000b004c080550fb5mr22463649qva.73.1668625259135; Wed, 16
 Nov 2022 11:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20221114144459.455519-1-hdegoede@redhat.com> <CAJZ5v0jPV3VXSXO+tW+dUwZ7QkWdXmiDtA7TTOgM9++SpBiWZA@mail.gmail.com>
 <be4df501-8602-1154-f702-832391c4a362@redhat.com>
In-Reply-To: <be4df501-8602-1154-f702-832391c4a362@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 20:00:47 +0100
Message-ID: <CAJZ5v0gFstkKTvn06ib1ajQshDsB4hVRb3AiOuwqPYE1T6PZ1Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: video: Prefer native over vendor + quirk updates
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, Nov 14, 2022 at 5:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/14/22 16:27, Rafael J. Wysocki wrote:
> > On Mon, Nov 14, 2022 at 3:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael, et. al.,
> >>
> >> As mentioned already in the RFC:
> >>
> >> """
> >> Here is a second attempt at always registering only a single
> >> /sys/class/backlight device per panel.
> >>
> >> This first round of testing has shown that native works well even on
> >> systems so old that the don't have acpi_video backlight control support.
> >>
> >> This patch series makes native be preferred over vendor, which should
> >> avoid the problems seen with the 6.1 changes before the fixes.
> >> """
> >>
> >> The 2 base patches (last 2 patches of the series now) are unchanged from
> >> the RFC. New is a bunch of video_detect DMI quirk updates, 3 small fixes to
> >> existing quirks + 2 new quirks. 1 of the new quirks is necessary to avoid
> >> a known regression with preferring native over vendor on 1 model,
> >> the other DMI quirk is unrelated to the other changes.
> >>
> >> This series applies on top of the platform-drivers-x86-v6.1-3 tag from:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/
> >>
> >> So either you will need to merge that tag (or merge v6.1-rc5 from Linus)
> >> before applying these patches, or I can merge this through my for-next
> >> branch which already has these changes. Either way works for me.
> >
> > I'll apply them on top of the -rc5.
>
> Great, thank you.

Applied now, thanks!
