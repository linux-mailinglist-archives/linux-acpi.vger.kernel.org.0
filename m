Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654F9DE72A
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJUIzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 04:55:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42827 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfJUIzC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2019 04:55:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so10356888oif.9;
        Mon, 21 Oct 2019 01:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/ILjmf9K7qy+5ndurAox0KwdPha8scfK03vxEE4NRY=;
        b=qcIdAx+pCT2mvNclo7bSkh3t1yfqyHeWFKZL+trru+D74F9qqvwzrzfgbFrhCLelCH
         sy+cOMGn0SDsiQrJNBwtMjKsLUwa3qxNehbuA0tNAG8ev326bQ7meCnRF8TgmUkq/phr
         SmzxuclRSKqNS3byHFotU9M8cOIyIogL5+pU952zYSBr3vFLHg0Xg2rjver8K6Z7YY7B
         6x2zvJ5RSxf66rUNDUzzKm7A0J1/HLTdE914hFIZhLGI9pV2IrK5kTGHtsFiEeT1Ocyw
         aHKGWLcCXZFPAm/GXKTBmM6pllNN/2y9+VRrxqFdLLbLWpcfmoxNip/Ub3KwrvDVn6GV
         ovvw==
X-Gm-Message-State: APjAAAWxsjiwYzVkxkyvT47sWH1hukgyP2V6IhebSCsMi5+kdI4nOQK9
        zKVxXUlSbQGet8wmx3umU4AJ462++Y6jAXPhTv4=
X-Google-Smtp-Source: APXvYqxjzY5Z9AlzOzvJ1XuK2u9xTXSln0v5M1CtCTChjomBuQeW7TgO9aX3S6FSb4eoCSqoL9ysnO+NpbIvsAV6Oss=
X-Received: by 2002:aca:5885:: with SMTP id m127mr18881140oib.110.1571648099816;
 Mon, 21 Oct 2019 01:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
 <5228680.jBuKzensJx@kreacher> <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
 <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com> <CACO55tvAyE1t2Bm8J=Yb_Gi5PDAgof=mRsJAKHFxOvEZpV-qGg@mail.gmail.com>
In-Reply-To: <CACO55tvAyE1t2Bm8J=Yb_Gi5PDAgof=mRsJAKHFxOvEZpV-qGg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 10:54:48 +0200
Message-ID: <CAJZ5v0hedXR13mw2FANuMNNOx0XmXiUUTus5C14Y-ADGteM4hA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
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

On Mon, Oct 21, 2019 at 10:48 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> fyi: I decided to go for a different workaround to fix the runpm
> issues observed with nvidia gpus with nouveau in the "pci: prevent
> putting nvidia GPUs into lower device states on certain intel bridges"
> thread

OK, I've seen that.

> that's on the pci and pm mailing list. Maybe it makes sense to wait
> for that to land before actually removing the ACPI workarounds here?

Sounds reasonable.

> The workaround I had in this series didn't seem to be reliable enough,
> so I ditched that approached.

OK, please let me know when the _OSI string in question can be dropped.

> On Mon, Oct 21, 2019 at 10:14 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Oct 21, 2019 at 4:14 AM Alex Hung <alex.hung@canonical.com> wrote:
> > >
> > > We have done some tests on three of Intel + nVidia configuration
> > > systems with OEM _OSI strings removed - while some bugs are still
> > > observed, ex. one out of three has suspend/resume issues, no system
> > > crashes were observed - the biggest issue that worries us.
> > >
> > > The positive results give us confident to ack the removal of the OEM
> > > _OSI strings. While our tests were not able to cover all possible I+N
> > > systems, we are sure we can fix issues along the way. If there aren't
> > > systems that cannot be fixed without these OEM _OSI strings, these
> > > strings should probably enable with DMI quirks (possible future
> > > patches) so they won't affect others.
> > >
> > > Acked-by: Alex Hung <alex.hung@canonical.com>
> >
> > OK, thanks!
> >
> > I can queue this up or if it's better to route it through the DRM
> > tree, please do that (and let me know).
