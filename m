Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB603A143B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFIMZE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 08:25:04 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:35365 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFIMZE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 08:25:04 -0400
Received: by mail-oo1-f53.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so5829765ood.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 05:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef4o5raAS3In70X0xfp1x71L6eApbLteni5XOPikDJs=;
        b=B9w8KQa0H9fM6xWPvnZCuy7FSWv6TRAY9gZYqFglEKnJ2iwGtp4tFuka/13A38mFZE
         WY5OZxxj/cy5OBaUe8f/9kBILW0Y6sBbm4k8miz9lA3LXXZBZD7lpoMOk9k+3ViFgohh
         Zmi3M/W7KIijX4EOfyBrQFJUMV1dL38pFAwVFZCsC57IPPNkNocyY1NS3R6dfKC5hVV/
         74ipGf6dqSl87aZXSVmJF8Kby6BVQC5NEePF/oLtvw0TfpoAkpt90i9TfnDSe0YE/5p0
         1JhGuiy3hYJBs8jeeHI4qeuvhgtEBS0BVIpXdVoPpLty/3gKW9FV1boeQwQttT7bch9a
         CK8A==
X-Gm-Message-State: AOAM532ofyg0MhnVdzU58l6iC+Z6180WSHpusaiMq960ghNNhEdvGRmU
        l15JNHVj00U+oGTNVWNdSl9bXn9YKCAsFn4VI4zsGwgw
X-Google-Smtp-Source: ABdhPJxAwsu/2N2fyR/8TnPe/YvsCqxGBuX8j0eIHVomDBlTF4yQgD/rLZK20Q/4bvJ+p9qTHpyBcjyGgscnsStT0u4=
X-Received: by 2002:a4a:9bcb:: with SMTP id b11mr21605499ook.44.1623241389662;
 Wed, 09 Jun 2021 05:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210609102533.6565-1-mika.westerberg@linux.intel.com> <54a5da2d-255c-4617-b2fa-8bc8e8746360@redhat.com>
In-Reply-To: <54a5da2d-255c-4617-b2fa-8bc8e8746360@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 14:22:58 +0200
Message-ID: <CAJZ5v0gyZhwcODnLhOfNc=Lxkr9kqt4UrsYsQUggp2dtGRWWSg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Pass the same capabilities to the _OSC
 regardless of the query flag
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@outlook.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 9, 2021 at 1:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/9/21 12:25 PM, Mika Westerberg wrote:
> > Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
> > clear") makes acpi_bus_osc_negotiate_platform_control() not only query
> > the platforms capabilities but it also commits the result back to the
> > firmware to report which capabilities are supported by the OS back to
> > the firmware
> >
> > On certain systems the BIOS loads SSDT tables dynamically based on the
> > capabilities the OS claims to support. However, on these systems the
> > _OSC actually clears some of the bits (under certain conditions) so what
> > happens is that now when we call the _OSC twice the second time we pass
> > the cleared values and that results errors like below to appear on the
> > system log:
> >
> >   ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
> >   ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
> >
> > In addition the ACPI 6.4 spec says following [1]:
> >
> >   If the OS declares support of a feature in the Support Field in one
> >   call to _OSC, then it must preserve the set state of that bit
> >   (declaring support for that feature) in all subsequent calls.
> >
> > Based on the above we can fix the issue by passing the same set of
> > capabilities to the platform wide _OSC in both calls regardless of the
> > query flag.
> >
> > While there drop the context.ret.length checks which were wrong to begin
> > with (as the length is number of bytes not elements). This is already
> > checked in acpi_run_osc() that also returns an error in that case.
> >
> > Includes fixes by Hans de Goede.
> >
> > [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> > Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> > Cc: Mario Limonciello <mario.limonciello@outlook.com>
> > cc: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.13-rc material, thanks!
