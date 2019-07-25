Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE58875972
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfGYVXt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 17:23:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43053 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGYVXt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 17:23:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so38766382oif.10;
        Thu, 25 Jul 2019 14:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymU59qUw9f+YTxwPbG7+MzBEYroVA+eRo9XyYVrY9Y0=;
        b=jx2CrTTtBfcYutOC3ytJVzumXkRkXZIJsczv0xclVXJBGFqNHF66eL75m9GXvuZq6+
         X1X6ORUfprAwKhe5Fh870lp0MVchdoeQbFN0X37XP6f+Le01XbfI8IOK+ckqYnkZfRGF
         RRHyYJSz0lM5ETHhtFHKjixs4Riy9hlcyQD892fkSYWzL1GsT4/4Arvqdyj+qo+M+HhP
         9OjixcdrEByXvqU8YzGtFFP+FhAj1t3AAUfqZsylZa6fq1UqtYHZVwR8BbYd/zT5R6qA
         PPcUXzL6s1ok7N6jgcXV8xW4qpHYIj/hrdYQLcKdHHHkBRrV/1BZkKismw73f44MHeTf
         /E5Q==
X-Gm-Message-State: APjAAAXr3q9SVNvyx8LvqPHSHulrgAKYCKA6NXRLFeyrnPIYmLjB2Jp2
        iAHQpIeWmJdhsZt+HKf2TprZ+uF+hBQ7TjrnWEg=
X-Google-Smtp-Source: APXvYqyvlhdC/BZI1W/nxzJZ72rWrJHG8Ltb0e8ZMHIC8wvEkvppGARCCAW+v73DBm/IDsBdOykCZuSDfEu2WefnQ+k=
X-Received: by 2002:aca:d907:: with SMTP id q7mr43310361oig.68.1564089828123;
 Thu, 25 Jul 2019 14:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190724143017.12841-1-david@redhat.com> <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com> <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com> <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
In-Reply-To: <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 23:23:37 +0200
Message-ID: <CAJZ5v0h+MjC3gFm1Kf3eBg2Rs12368j6S_i5_Gc24yWx+Z3xBA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in acpi_scan_init()
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 25, 2019 at 10:49 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.07.19 21:19, Michal Hocko wrote:
> > On Thu 25-07-19 16:35:07, David Hildenbrand wrote:
> >> On 25.07.19 15:57, Michal Hocko wrote:
> >>> On Thu 25-07-19 15:05:02, David Hildenbrand wrote:
> >>>> On 25.07.19 14:56, Michal Hocko wrote:
> >>>>> On Wed 24-07-19 16:30:17, David Hildenbrand wrote:
> >>>>>> We end up calling __add_memory() without the device hotplug lock held.
> >>>>>> (I used a local patch to assert in __add_memory() that the
> >>>>>>  device_hotplug_lock is held - I might upstream that as well soon)
> >>>>>>
> >>>>>> [   26.771684]        create_memory_block_devices+0xa4/0x140
> >>>>>> [   26.772952]        add_memory_resource+0xde/0x200
> >>>>>> [   26.773987]        __add_memory+0x6e/0xa0
> >>>>>> [   26.775161]        acpi_memory_device_add+0x149/0x2b0
> >>>>>> [   26.776263]        acpi_bus_attach+0xf1/0x1f0
> >>>>>> [   26.777247]        acpi_bus_attach+0x66/0x1f0
> >>>>>> [   26.778268]        acpi_bus_attach+0x66/0x1f0
> >>>>>> [   26.779073]        acpi_bus_attach+0x66/0x1f0
> >>>>>> [   26.780143]        acpi_bus_scan+0x3e/0x90
> >>>>>> [   26.780844]        acpi_scan_init+0x109/0x257
> >>>>>> [   26.781638]        acpi_init+0x2ab/0x30d
> >>>>>> [   26.782248]        do_one_initcall+0x58/0x2cf
> >>>>>> [   26.783181]        kernel_init_freeable+0x1bd/0x247
> >>>>>> [   26.784345]        kernel_init+0x5/0xf1
> >>>>>> [   26.785314]        ret_from_fork+0x3a/0x50
> >>>>>>
> >>>>>> So perform the locking just like in acpi_device_hotplug().
> >>>>>
> >>>>> While playing with the device_hotplug_lock, can we actually document
> >>>>> what it is protecting please? I have a bad feeling that we are adding
> >>>>> this lock just because some other code path does rather than with a good
> >>>>> idea why it is needed. This patch just confirms that. What exactly does
> >>>>> the lock protect from here in an early boot stage.
> >>>>
> >>>> We have plenty of documentation already
> >>>>
> >>>> mm/memory_hotplug.c
> >>>>
> >>>> git grep -C5 device_hotplug mm/memory_hotplug.c
> >>>>
> >>>> Also see
> >>>>
> >>>> Documentation/core-api/memory-hotplug.rst
> >>>
> >>> OK, fair enough. I was more pointing to a documentation right there
> >>> where the lock is declared because that is the place where people
> >>> usually check for documentation. The core-api documentation looks quite
> >>> nice. And based on that doc it seems that this patch is actually not
> >>> needed because neither the online/offline or cpu hotplug should be
> >>> possible that early unless I am missing something.
> >>
> >> I really prefer to stick to locking rules as outlined on the
> >> interfaces if it doesn't hurt. Why it is not needed is not clear.
> >>
> >>>
> >>>> Regarding the early stage: primarily lockdep as I mentioned.
> >>>
> >>> Could you add a lockdep splat that would be fixed by this patch to the
> >>> changelog for reference?
> >>>
> >>
> >> I have one where I enforce what's documented (but that's of course not
> >> upstream and therefore not "real" yet)
> >
> > Then I suppose to not add locking for something that is not a problem.
> > Really, think about it. People will look at this code and follow the
> > lead without really knowing why the locking is needed.
> > device_hotplug_lock has its purpose and if the code in question doesn't
> > need synchronization for the documented scenarios then the locking
> > simply shouldn't be there. Adding the lock just because of a
> > non-existing, and IMHO dubious, lockdep splats is just wrong.
> >
> > We need to rationalize the locking here, not to add more hacks.
>
> No, sorry. The real hack is calling a function that is *documented* to
> be called under lock without it. That is an optimization for a special
> case. That is the black magic in the code.
>
> The only alternative I see to this patch is adding a comment like
>
> /*
>  * We end up calling __add_memory() without the device_hotplug_lock
>  * held. This is fine as we cannot race with other hotplug activities
>  * and userspace trying to online memory blocks.
>  */
>
> Personally, I don't think that's any better than just grabbing the lock
> as we are told to. (honestly, I don't see how optimizing away the lock
> here is of *any* help to optimize our overall memory hotplug locking)
>
> @Rafael, what's your take? lock or comment?

Well, I have ACKed your patch already. :-)

That said, adding a comment stating that the lock is acquired mostly
for consistency wouldn't hurt.
