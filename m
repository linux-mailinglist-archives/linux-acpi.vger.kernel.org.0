Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCBCAA8EC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfIEQ0J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 12:26:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60169 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfIEQ0J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 12:26:09 -0400
Received: from 79.184.255.97.ipv4.supernova.orange.pl (79.184.255.97) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 8a7029f060d47632; Thu, 5 Sep 2019 18:26:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to enable dGPU direct output"
Date:   Thu, 05 Sep 2019 18:26:06 +0200
Message-ID: <5228680.jBuKzensJx@kreacher>
In-Reply-To: <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher> <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, September 5, 2019 5:51:23 PM CEST Karol Herbst wrote:
> is there any update on the testing with my patches? On the hardware I
> had access to those patches helped, but I can't know if it also helped
> on the hardware for which those workarounds where actually added.

Alex Hung and Mario need to answer this question I think.

> On Mon, Aug 19, 2019 at 11:52 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
> > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > >
> > > > The original commit message didn't even make sense. AMD _does_ support it and
> > > > it works with Nouveau as well.
> > > >
> > > > Also what was the issue being solved here? No references to any bugs and not
> > > > even explaining any issue at all isn't the way we do things.
> > > >
> > > > And even if it means a muxed design, then the fix is to make it work inside the
> > > > driver, not adding some hacky workaround through ACPI tricks.
> > > >
> > > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > > >
> > >
> > > I think the reverts should be merged via Rafael's tree as the original
> > > patches went in via there, and we should get them in asap.
> > >
> > > Acked-by: Dave Airlie <airlied@redhat.com>
> >
> > The _OSI strings are to be dropped when all of the needed support is there in
> > drivers, so they should go away along with the requisite driver changes.
> >
> 
> that goes beside the point. firmware level workarounds for GPU driver
> issues were pushed without consulting with upstream GPU developers.
> That's something which shouldn't have happened in the first place. And
> yes, I am personally annoyed by the fact, that people know about
> issues, but instead of contacting the proper persons and working on a
> proper fix, we end up with stupid firmware level workarounds. I can't
> see why we ever would have wanted such workarounds in the first place.
> 
> And I would be much happier if the next time something like that comes
> up, that the drm mailing list will be contacted as well or somebody
> involved.
> 
> We could have also just disable the feature inside the driver (and
> probably we should have done that a long time ago, so that is
> essentially our fault, but still....)
> 
> > I'm all for dropping then when that's the case, so please feel free to add ACKs
> > from me to the patches in question at that point.
> >
> > Cheers,
> > Rafael
> >
> >
> >
> 




