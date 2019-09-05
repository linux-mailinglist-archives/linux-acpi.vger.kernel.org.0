Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23A5AA7B0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfIEPvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 11:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfIEPvg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Sep 2019 11:51:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59933C03D470
        for <linux-acpi@vger.kernel.org>; Thu,  5 Sep 2019 15:51:35 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id a13so3713682ioh.18
        for <linux-acpi@vger.kernel.org>; Thu, 05 Sep 2019 08:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNe3ddKXkBveWMhw4c4f5b+wfxe2iykrAWeST0j0z4c=;
        b=iXTckJJ8sZAVL5AEuZ1SszLFYKXtH5Inic2s1DbYZQgzwvGuj8cEQDL5kbs5pJURF2
         aKGUsbvp2u9ymh+cNXW2KbujNtnD48tPco9PxfdisOl1nomF7rABGmfkRB0twaS2Mar2
         U5kosqHG8H6+/ndz6D6dSQnMpPGOc2jZ7ZeOIoEsuA0mdwM5dVqgOIXilGbo+HMFp9EB
         sDhrNo84SdV6s9w/aFCUDfrKm5ybm7iQNRcxOUOmXksAnJpfP/terAhek9WIMj2ZKJx7
         UB1CzDO8RBflrsX0qgKelLtfq5Dbq7VveOQfgGzJ1dw4er0MyLnOu4hB1NCoBtM0n/YO
         dy3A==
X-Gm-Message-State: APjAAAVEcpVs8a7P59/1l2DG3fqGnXLc6wId7/IlyTZeOLeQRflPSEJz
        rhyxnyq2ZmFOyDMGuTy82o2QZLU8pttUzcMmeNmDotCvt869zoJDXf5ilDHyIJz0GlzvWmHB0ps
        JCu7QxSgFSQtrJAerU8e2CGuWVJJ6BFgqYzJ1nA==
X-Received: by 2002:a5d:9750:: with SMTP id c16mr5160594ioo.260.1567698694755;
        Thu, 05 Sep 2019 08:51:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqziasJ9/F0fMtMAUdtQGxy5l/8SPZ81bDf6U0dhJV+tEsL0k25gm7aG+PD5J9cfxqlr1KkEZZquBbi9oi2tLXY=
X-Received: by 2002:a5d:9750:: with SMTP id c16mr5160555ioo.260.1567698694470;
 Thu, 05 Sep 2019 08:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com> <2215840.qs0dBhReda@kreacher>
In-Reply-To: <2215840.qs0dBhReda@kreacher>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 5 Sep 2019 17:51:23 +0200
Message-ID: <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

is there any update on the testing with my patches? On the hardware I
had access to those patches helped, but I can't know if it also helped
on the hardware for which those workarounds where actually added.

On Mon, Aug 19, 2019 at 11:52 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
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
>
> The _OSI strings are to be dropped when all of the needed support is there in
> drivers, so they should go away along with the requisite driver changes.
>

that goes beside the point. firmware level workarounds for GPU driver
issues were pushed without consulting with upstream GPU developers.
That's something which shouldn't have happened in the first place. And
yes, I am personally annoyed by the fact, that people know about
issues, but instead of contacting the proper persons and working on a
proper fix, we end up with stupid firmware level workarounds. I can't
see why we ever would have wanted such workarounds in the first place.

And I would be much happier if the next time something like that comes
up, that the drm mailing list will be contacted as well or somebody
involved.

We could have also just disable the feature inside the driver (and
probably we should have done that a long time ago, so that is
essentially our fault, but still....)

> I'm all for dropping then when that's the case, so please feel free to add ACKs
> from me to the patches in question at that point.
>
> Cheers,
> Rafael
>
>
>
