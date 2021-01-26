Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA23044E7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbhAZRRw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 12:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392961AbhAZQaE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 11:30:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C228C0611C2;
        Tue, 26 Jan 2021 08:29:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so23765528ejf.11;
        Tue, 26 Jan 2021 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJCa0cOTJvX5zYj1Www2fkXyoYmX0kF/2yQRjPEXfzI=;
        b=MCdqpn+KiuPT1B3ptrofAJeKE+m0GA2s3i3B7Q+rlEN47D32lRy35NLmKSLmswGKqF
         z8vcRerVnSzVXMCnAW+VmsrQC7broxoIDI+aVzz8f7URjemri5gapUFOGM2CJJ8DiglR
         Az7GW65zZNVnD9D4Ka/ig69OoymPLK/pUH2wVOvfrP01+9fN8G+KEQENalHpshnh379a
         wNFprTIF0xQlCry/4cTwYOqhbCGYW4NtIOvHVQffL4ghl6N0nul29p1MBPDU/wVB6mAT
         I7Yt1Ra0JXfCK6yWsIkUXwIAV4GBaFi3XhuabB03kHvTqsy4G+Zi3q8KP6WMyBft+3lg
         IpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJCa0cOTJvX5zYj1Www2fkXyoYmX0kF/2yQRjPEXfzI=;
        b=MoJjw3QenK7OZ+9/4EePtmAKTdLmvXWvkOMrWQ5Xb4UfT/HQm4uNYxGbCiJ5tcdLxb
         Un4sxlpNE33m7a4/ZpiGxO3VNdsA4QiHW07F3JKrpFdKPTd82ADG+6LXlvB1ovYpKrCp
         cnFnA1vG8wgSb2NYkbE3JpKzzg8P8S64J4TrHgeEZTl07VbYkou3lkgL8aqljPDu0+5W
         qC05pRjM0MKJEeYhDJ4weAJZ3w7MN1nKMyZOVLLw37IAkxXsWQi7snRYXbUoDYJWFVdd
         CslnPtxfMT3bHuF+kTyU2lnEr2i3j733hNBFV00825lK+5VjENbU7quiDdzwmSOK73qz
         sz5g==
X-Gm-Message-State: AOAM532zGRamWQ7Qv2oN8SGjfDe0tniuIrDNorPE6YhFXswGmZYXYvPP
        +JaS0oSCTjnyRGK+7hpBBhI8ALuZNSusm3aUUbA=
X-Google-Smtp-Source: ABdhPJxrbAJ14sn7uvoeut1bNy0BDzhd9SOgMoknlpeXav6FQ/pq2SrBcTiuptJ5zkNU+RkbZlw/ee/ba2pOSyRUfXA=
X-Received: by 2002:a17:906:4690:: with SMTP id a16mr4052661ejr.442.1611678588312;
 Tue, 26 Jan 2021 08:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-3-mika.westerberg@linux.intel.com> <CA+CmpXscOVjn20ffw37GRLBWhQDRJ9J8svYvU1-VWg5eA-Bm4A@mail.gmail.com>
 <20210126162630.GA1988617@lahna.fi.intel.com>
In-Reply-To: <20210126162630.GA1988617@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 26 Jan 2021 18:29:32 +0200
Message-ID: <CA+CmpXvWq_ce5HOSjUNt05BFAyyb96Yb_=o45V53nyqfRkZ0ng@mail.gmail.com>
Subject: Re: [PATCH 2/6] thunderbolt: Add support for PCIe tunneling disabled (SL5)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 6:26 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jan 26, 2021 at 06:18:47PM +0200, Yehezkel Bernat wrote:
> > On Tue, Jan 26, 2021 at 5:57 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Recent Intel Thunderbolt firmware connection manager has support for
> > > another security level, SL5, that disables PCIe tunneling. This option
> > > can be turned on from the BIOS.
> > >
> > > When this is set the driver exposes a new security level "nopcie" to the
> > > userspace and hides the authorized attribute under connected devices.
> > >
> > > While there we also hide it when "dponly" security level is enabled
> > > since it is not really usable in that case anyway.
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> >
> > Looks good to me, I'm just not sure I understand how this is different from
> > dponly mode. Is this just because it comes from the new _OSC?
>
> The firmware connection manager reports this new security level instead
> of dponly so we reflect that to the userspace, and while at it take
> advantage of the nopcie when USB4 _OSC disables PCIe tunneling so they
> both look the same from userspace perspective.

Makes sense. Thanks for the clarification!
