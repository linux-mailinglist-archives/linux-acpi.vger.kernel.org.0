Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8428EDA3
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfHOOEj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:04:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44711 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732671AbfHOOEj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:04:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so5992131ote.11
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zM3G1xWX3WogoYIxIH0si8CwpIiqkYLZ2hiihxpOqQ=;
        b=CnYqMHQfB1q0aqvaDikCI8K3JB5IspmFdP1qmVUFGAQUkJTzWyNFmu3Z0wHXPODkUZ
         EFtnAT8S+m2B6FUjIboRWkoqUDxlTi64bpOTnZitFI9Lh8ZS1osi3+W5gmgTPE0dtuKk
         HzJKj908JmsWE1OMTm8lgbP7X25hxtsucdm5OBIfKBVjX0IQCM/5rb4PSjbTSq1M6Yq9
         xwaQlE9dLLTN30jk0Aq3zFHVG/NzIK+3wMLBC069Fpu55TPy1+4Jc2g9h7rw+DrlXTae
         fXQxaXij6yxLL2HWNHNTDIY1c83NomIIGErlb32RdAY5Wm4dCAcEfKhJpnTYwMsxAaPV
         tJUQ==
X-Gm-Message-State: APjAAAUgSdy5rT8l4ryvYL5+CNnEjQfGj8Mp0gUvYT61hHxIMMlxXRM3
        n3oso0+XTfQ14ONyKWWHJn+tk8itzJrxwKl3eAZ0Jw==
X-Google-Smtp-Source: APXvYqzchRXgP4x789+GjQl+9hOyJZGL6tLjLzEJ8LcaNO1Yx6DCAmdlcRIEhnpH8KVHbuj5x4BhAACAIvjM27sfOC8=
X-Received: by 2002:a5d:8195:: with SMTP id u21mr5821290ion.260.1565877878036;
 Thu, 15 Aug 2019 07:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com> <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:04:27 +0200
Message-ID: <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 3:56 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On
> > Behalf Of Dave Airlie
> > Sent: Wednesday, August 14, 2019 5:48 PM
> > To: Karol Herbst
> > Cc: LKML; Linux ACPI; dri-devel; nouveau; Rafael J . Wysocki; Alex Hung; Ben
> > Skeggs; Dave Airlie
> > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > enable dGPU direct output"
> >
> > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > >
> > > The original commit message didn't even make sense. AMD _does_ support it and
> > > it works with Nouveau as well.
> > >
> > > Also what was the issue being solved here? No references to any bugs and not
> > > even explaining any issue at all isn't the way we do things.
> > >
> > > And even if it means a muxed design, then the fix is to make it work inside the
> > > driver, not adding some hacky workaround through ACPI tricks.
> > >
> > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > >
> >
> > I think the reverts should be merged via Rafael's tree as the original
> > patches went in via there, and we should get them in asap.
> >
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Dave.
>
> There are definitely going to be regressions on machines in the field with the
> in tree drivers by reverting this.  I think we should have an answer for all of those
> before this revert is accepted.
>
> Regarding systems with Intel+NVIDIA, we'll have to work with partners to collect
> some information on the impact of reverting this.
>
> When this is used on a system with Intel+AMD the ASL configures AMD GPU to use
> "Hybrid Graphics" when on Windows and "Power Express" and "Switchable Graphics"
> when on Linux.

and what's exactly the difference between those? And what's the actual
issue here?

We already have the PRIME offloading in place and if that's not
enough, we should work on extending it, not adding some ACPI based
workarounds, because that's exactly how that looks like.

Also, was this discussed with anybody involved in the drm subsystem?

>
> I feel we need a knob and/or DMI detection to affect the changes that the ASL
> normally performs.

Why do we have to do that on a firmware level at all?
