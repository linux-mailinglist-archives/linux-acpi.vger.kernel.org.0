Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751292AD6C3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKJMrI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 07:47:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35987 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgKJMrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 07:47:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id n89so1137238otn.3;
        Tue, 10 Nov 2020 04:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQI2guPjiDZb/My9nXr68aWP3FxBBZe/IxqcdhKiV/8=;
        b=VVOSFla7rm2VFbnkQOvKXcbMP4+t3VsdZ2No6MCkSOZcgNBFPV7Y9NR5SGF1S6Jgwa
         L4D024E7CmqXVW+fNEYScFcTkTFk/f5SVk5O7oiL11ia2I5wb94YSCmJkiigVTFKwwmr
         sr7JGUUAD4KJoPJH79qfL/n75aQKQpg3j7gJHq9wC0n6/S0eSRyW0f5w7zPOISl1eLy0
         LsE7SLx5B31LzbCmK8VWycgMZgfXTAfTtdPbKMreFid+S/7JHNuolqoK0sXWXUvphy+C
         1c1cSivSOwZBex9KOUOAxCZHAFRla+q4v/4Zg1asvOl18s9KU1EDt4fuLGteE8LBzN9a
         BMDA==
X-Gm-Message-State: AOAM5319jEI935ppUFoUOME+p2/J1QDEJHELZ+1MN1Vee4FSrhmjX2si
        bv1An44+J5SeGV91UNVpGZgaBt3LPR6DzfP18pU=
X-Google-Smtp-Source: ABdhPJz5pC83/KRZx7w7Vo6FyNhdmyLZJwGmN2hwsfoIrsxqQ+5Z+EEtzTarksKAhskk4wWF4GSOIjntpHA9alZMmY8=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr14745639otu.206.1605012427418;
 Tue, 10 Nov 2020 04:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20201109172435.GJ4077@smile.fi.intel.com> <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
 <dleftj4klypf5u.fsf%l.stelmach@samsung.com> <20201109185305.GT1003057@dtor-ws>
 <20201109190551.GM4077@smile.fi.intel.com> <20201110123939.GN1224435@kuha.fi.intel.com>
In-Reply-To: <20201110123939.GN1224435@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:46:54 +0100
Message-ID: <CAJZ5v0jqN1v-g4v0eMSQeJCXQ9yntFWaLns9k2bDcaja-jdkcA@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 1:39 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Nov 09, 2020 at 09:05:51PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 09, 2020 at 10:53:05AM -0800, Dmitry Torokhov wrote:
> > > On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> > > > It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> >
> > ...
> >
> > > > Probably I have missed something and I will be greatful, if you tell me
> > > > where I can find more information about software nodes. There are few
> > > > users in the kernel and it isn't obvious for me how to use software
> > > > nodes properly.
> > >
> > > Yeah, I disagree with Andy here. The lookup tables are a crutch that we
> > > have until GPIO and PWM a taught to support software nodes (I need to
> > > resurrect my patch series for GPIO, if you have time to test that would
> > > be awesome).
> >
> > We don't have support for list of fwnodes, this will probably break things
> > where swnode is already exist.
> >
> > I think Heikki may send a documentation patch to clarify when swnodes can and
> > can't be used. Maybe I'm mistaken and above is a good use case by design.
>
> Yeah, the problem is that I'm not sure that we can limit the swnodes
> for any specific purpose, or dictate very strictly how they are used
> with other possible fwnodes.

Generally agreed, but if there are known problems, they need to be
documented at least for the time being until they are addressed.

> Right now I'm thinking we should simply not talk about the
> relationship a software node should have or can have with other
> fwnodes (regardless of their type) in the swnode documentation.

This sounds reasonable to me, with the above exception.
