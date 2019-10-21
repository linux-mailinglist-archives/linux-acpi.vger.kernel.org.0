Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119E6DE70E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJUIso (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 04:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUIsm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 04:48:42 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62705C065113
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 08:48:41 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id b29so12757929qka.23
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRqmfLWgWgklrhuIT0YEqcb3zcO5An3swDX6Xn5ZmWQ=;
        b=S3J63zcuvqFQkrOEV0ZBReg2zab3C133LiYfvJkgnc7w8XXlc5gQKpR1ZqRdfGChur
         ikHcfoenUCyFA0SOmhAqEBvhIbPbRnnjgUzLig8ilOgrXB7VnYLG1WS35iZHjfmWR7fL
         DrpqMlqfD4yzIBL90vo+10xvVYMG7MU2kHOSkDi4LxNAWrbEly0KcZLk566M9PBuS7Rr
         WkyrOI6+L9y2OWwh0EvERRxU7FCdqWpZdwuVupLebiJlzKiRsXBNKpxqtJt5tdp589yC
         /pLsGn7zKQpN815Jme5qSqeQH+sdoUj3aq/JE1Trh9Gn4xAQWrx1XnLb4Zl6KpTmC52A
         EEoQ==
X-Gm-Message-State: APjAAAXhIKc11Tl/+EoVwQl8ruW6ct6jDVGbUeVd/BcQ7yv0SA4ZNFsK
        Hbq952W4mFQN79TH9Ge5al98iGziBmi8z8jpcjedyFgCowhvrcjPxcyWr0ILFDVkU9sdF/nMivL
        /a3WZqmNeHSV92y8y9rJBlziGSJzYXR8Pm8pawA==
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr21040851qkc.157.1571647720597;
        Mon, 21 Oct 2019 01:48:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMSJL3T6FDafLXsYkKHSRUn9ds4wEGZrqyrQwy1ZdVD37ycdGAVZNZ8hFxO2cMo4t/PkEIVrqxmsVkDYGB08g=
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr21040840qkc.157.1571647720291;
 Mon, 21 Oct 2019 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
 <5228680.jBuKzensJx@kreacher> <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
 <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com>
In-Reply-To: <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 10:48:29 +0200
Message-ID: <CACO55tvAyE1t2Bm8J=Yb_Gi5PDAgof=mRsJAKHFxOvEZpV-qGg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alex Hung <alex.hung@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fyi: I decided to go for a different workaround to fix the runpm
issues observed with nvidia gpus with nouveau in the "pci: prevent
putting nvidia GPUs into lower device states on certain intel bridges"
thread

that's on the pci and pm mailing list. Maybe it makes sense to wait
for that to land before actually removing the ACPI workarounds here?
The workaround I had in this series didn't seem to be reliable enough,
so I ditched that approached.

On Mon, Oct 21, 2019 at 10:14 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Oct 21, 2019 at 4:14 AM Alex Hung <alex.hung@canonical.com> wrote:
> >
> > We have done some tests on three of Intel + nVidia configuration
> > systems with OEM _OSI strings removed - while some bugs are still
> > observed, ex. one out of three has suspend/resume issues, no system
> > crashes were observed - the biggest issue that worries us.
> >
> > The positive results give us confident to ack the removal of the OEM
> > _OSI strings. While our tests were not able to cover all possible I+N
> > systems, we are sure we can fix issues along the way. If there aren't
> > systems that cannot be fixed without these OEM _OSI strings, these
> > strings should probably enable with DMI quirks (possible future
> > patches) so they won't affect others.
> >
> > Acked-by: Alex Hung <alex.hung@canonical.com>
>
> OK, thanks!
>
> I can queue this up or if it's better to route it through the DRM
> tree, please do that (and let me know).
