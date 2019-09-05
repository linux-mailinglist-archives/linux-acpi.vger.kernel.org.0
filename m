Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5AAA91C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfIEQgn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 12:36:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53170 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbfIEQgn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 12:36:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so3567580wmi.2;
        Thu, 05 Sep 2019 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkGp5CuoZ7+DBs4HS2vxktRn4TIDGSJOXm8qEsfnCug=;
        b=CHYo7f5m6VPqE9QLpkVzXSD6hkAvDyeC6o/nT2cG/NAlupPoCvxlSNJ9WJ/fCabKX+
         RuCXNuBcezQ3NyxM5dr4EGNeqH/Vr7iq4+1Uv9WVYVP7jiMVUHSG/lNjw3yToh3SUGfA
         pkQRvFNI0bmaECFdIGhrz40A/qnK6in/WB92eNHldOZL75D89eby2AKCD7fM75DwJdM0
         CxrozoYT5B6FvgVgeGrmDS83v474qTxvRsSWPmmz0NZpSJxEZKaIRVE1sPyabVSxZO3k
         P185atT0E4KK2sM9dbue//XvVONoE9Re9KIcvwJUbAtowkAHQT8dvSVjS+7Z/H6zhMU5
         a1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkGp5CuoZ7+DBs4HS2vxktRn4TIDGSJOXm8qEsfnCug=;
        b=tqlvcaG6mpy+8NTIXIMXKZFq/2XSngycG9TzVATmsRt22df4lO7lGwPhYG+azdy4hz
         TH4A2a7RjV6/AzUI4wOIJLk6u1urDt1ESPf6kv0Z7sWpP0bFm1ktqsyBzSqfnrCN4JOP
         9uwWpt9Zun3hWRydU5BsQ/02k1t7SvJ6av94cmCbFmfCCF3fEcBB4GlR4RGeOkw38lDL
         rWscrJBB0/sRoI3mdf99gf3GKGO1y6EZajOQZzffdhlqP/BGVF3dcPdWo5R4N7pu1o8m
         2X6V2qbrLITtu6GCwcHwmK9PkYk5N0n5QGHJ/PWFgoPKGN2TBeWGCqliNTCC216LbgcO
         Aevg==
X-Gm-Message-State: APjAAAV938DTBxVnX6DEx8xvF9k4vL3QIunZgawweGIoOgLI+9UHjZUW
        5NIVZJBY1fzfF1cniZEKbr3rGAIZoYumZxAnzbg=
X-Google-Smtp-Source: APXvYqz9hFfnXxS5LgTBQz7g+RYOpjxUXfn5LexEg3DPsbwv7ynAv2O9TVtk+V6OTPQbyewJo1sVCMTYFV0YBT0Qo5E=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr2086098wml.67.1567701400749;
 Thu, 05 Sep 2019 09:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <2215840.qs0dBhReda@kreacher> <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
In-Reply-To: <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Sep 2019 12:35:56 -0400
Message-ID: <CADnq5_NSY=usXHcX8UqBiTbenPE8K3+yZ5Ujnu3vSWziVTr_QQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 5, 2019 at 11:51 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> is there any update on the testing with my patches? On the hardware I
> had access to those patches helped, but I can't know if it also helped
> on the hardware for which those workarounds where actually added.
>
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

Generally these conversations happen between the OEM, the relevant
distro, and hw vendor prior to production so they can't always be
discussed in public.  These programs have power, feature, and distro
targets and not all of those align.  Sometimes fixing this at the
firmware level is the best way to make the product work well at launch
given the state of Linux at a particular time.  Windows already does
similar stuff so that older versions of windows will work properly on
newer hardware.  I agree that we should all strive to fix stuff
properly, but that's not always possible.

Alex

>
> > I'm all for dropping then when that's the case, so please feel free to add ACKs
> > from me to the patches in question at that point.
> >
> > Cheers,
> > Rafael
> >
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
