Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B13DE1FB
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 04:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfJUCOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Oct 2019 22:14:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfJUCOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Oct 2019 22:14:39 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1iMNDQ-0007MS-LQ
        for linux-acpi@vger.kernel.org; Mon, 21 Oct 2019 02:14:36 +0000
Received: by mail-io1-f69.google.com with SMTP id a22so15953060ioq.23
        for <linux-acpi@vger.kernel.org>; Sun, 20 Oct 2019 19:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnluuLx7N5FU6R1K0tIitcyLNhQag0yWZU1ygvdJBl4=;
        b=eBMa88gafnvAuodZCKqn8YaDZAoxozNcpD4f397eSlWW+FJxRdBD3A631EQ1Usvc03
         D6NVPUDpPpISeVY/3AnC7+TvgrMDd2Lqv3tpUaYTwkTcxMM6o/fE170wTlFuThSuxbtA
         LBx0fasPeo5H0IFjzXy8FmFMvalDpdXchZL7Evwk5hONrHag7ttajCXfvVcH7uhst7H2
         Ms0bxpJ5hqJp9DKoO6iU6OR82nNcGesDb1dD+Jnrl1cHs2vVL/9mXyVVeAcIYsx+cK1i
         gbvOaw5gFZabGzPBQr+sMPJrUFvv7ufXmgZbCM3fGL3gBBK7dbmf9QH3mo1K1hgUoZbH
         IP0Q==
X-Gm-Message-State: APjAAAWJQZ3TlXH+E1VJY0M/2DsGIbZEKvBVgutrr7BHJIcUlMJlYnCK
        2GxOlKwjL7qeJjcXQAURMtXlBsIZlAieBVPEUs2pBTTALC6enCChhVxFOa4mywOqU5XiLXyh5Nv
        vEJqybt2IdYYLT8+aHtJ9if9tWJDRNQu7hIztLcGKk9C6HeDaSVCzAGU=
X-Received: by 2002:a6b:e20f:: with SMTP id z15mr768964ioc.199.1571624075667;
        Sun, 20 Oct 2019 19:14:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfgJ3t7vqgICblfa3NVl6kSA7Md5mj/NPEb9Mqkp3Oi93uOwzfRxJ2gDaqQ9Rhf5GlAlggXH16Bna+cOgAtvk=
X-Received: by 2002:a6b:e20f:: with SMTP id z15mr768950ioc.199.1571624075361;
 Sun, 20 Oct 2019 19:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com> <5228680.jBuKzensJx@kreacher>
In-Reply-To: <5228680.jBuKzensJx@kreacher>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Sun, 20 Oct 2019 20:14:23 -0600
Message-ID: <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Karol Herbst <kherbst@redhat.com>, Dave Airlie <airlied@gmail.com>,
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

We have done some tests on three of Intel + nVidia configuration
systems with OEM _OSI strings removed - while some bugs are still
observed, ex. one out of three has suspend/resume issues, no system
crashes were observed - the biggest issue that worries us.

The positive results give us confident to ack the removal of the OEM
_OSI strings. While our tests were not able to cover all possible I+N
systems, we are sure we can fix issues along the way. If there aren't
systems that cannot be fixed without these OEM _OSI strings, these
strings should probably enable with DMI quirks (possible future
patches) so they won't affect others.

Acked-by: Alex Hung <alex.hung@canonical.com>




On Thu, Sep 5, 2019 at 10:26 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, September 5, 2019 5:51:23 PM CEST Karol Herbst wrote:
> > is there any update on the testing with my patches? On the hardware I
> > had access to those patches helped, but I can't know if it also helped
> > on the hardware for which those workarounds where actually added.
>
> Alex Hung and Mario need to answer this question I think.
>
> > On Mon, Aug 19, 2019 at 11:52 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
> > > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > > >
> > > > > The original commit message didn't even make sense. AMD _does_ support it and
> > > > > it works with Nouveau as well.
> > > > >
> > > > > Also what was the issue being solved here? No references to any bugs and not
> > > > > even explaining any issue at all isn't the way we do things.
> > > > >
> > > > > And even if it means a muxed design, then the fix is to make it work inside the
> > > > > driver, not adding some hacky workaround through ACPI tricks.
> > > > >
> > > > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > > > >
> > > >
> > > > I think the reverts should be merged via Rafael's tree as the original
> > > > patches went in via there, and we should get them in asap.
> > > >
> > > > Acked-by: Dave Airlie <airlied@redhat.com>
> > >
> > > The _OSI strings are to be dropped when all of the needed support is there in
> > > drivers, so they should go away along with the requisite driver changes.
> > >
> >
> > that goes beside the point. firmware level workarounds for GPU driver
> > issues were pushed without consulting with upstream GPU developers.
> > That's something which shouldn't have happened in the first place. And
> > yes, I am personally annoyed by the fact, that people know about
> > issues, but instead of contacting the proper persons and working on a
> > proper fix, we end up with stupid firmware level workarounds. I can't
> > see why we ever would have wanted such workarounds in the first place.
> >
> > And I would be much happier if the next time something like that comes
> > up, that the drm mailing list will be contacted as well or somebody
> > involved.
> >
> > We could have also just disable the feature inside the driver (and
> > probably we should have done that a long time ago, so that is
> > essentially our fault, but still....)
> >
> > > I'm all for dropping then when that's the case, so please feel free to add ACKs
> > > from me to the patches in question at that point.
> > >
> > > Cheers,
> > > Rafael
> > >
> > >
> > >
> >
>
>
>
>


-- 
Cheers,
Alex Hung
