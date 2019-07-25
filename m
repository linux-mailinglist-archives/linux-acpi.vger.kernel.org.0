Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F4749C3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfGYJW7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 05:22:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43071 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJW7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 05:22:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so26666429otp.10;
        Thu, 25 Jul 2019 02:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6bXcLy59IZQ/jzA1KAA80JAzsTaXl85YCv6d26dui4=;
        b=YgAFSsZl40uJsBLqBAa/nghfo9s3ZYbLXRRWsrusTWRysayxj+RGnjLJDggP7Gt1t5
         ne/CM80G/EHak/AOqUTkFbdyN1288V0QaJBnGMjhqn9B6rgUbyMj52CFYMrXbDZ/9SSN
         GlfW9VwAsXboGEAasWGr8pW8B0UWRygTUOP5/d6856JmhkYgk+RacMstHm3+toiXWkqs
         Wzo0wSaHr5eG5caXjl2VGSEPCysPa3Gnzz9LVZJWHIFKpJwF+aCSMrHd4+Nej2tlIuw6
         SU+AJ6/fSFxQInk9t+CQE0SklKj/lfoZi48ogleGfuP03NbkXG5J9czsx/2o/Ur3dpzu
         74WQ==
X-Gm-Message-State: APjAAAXOcZtnpxyix/hQNCfKqRXBm22pvgj69EAUYboOzezfh8ujthJ8
        UIsWSXtflSf6r0n34jxmVluETiHh7uhn93NCAN4=
X-Google-Smtp-Source: APXvYqxJ49+1aZ6N4TDMyBMfQsD/Uphq9/3dCsGS122VqG+v2Ww7f6i5dT2dazWN0C3ylFEI+mrm0iTK0F636Zu0+Q8=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr59724305otp.189.1564046578263;
 Thu, 25 Jul 2019 02:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190724143017.12841-1-david@redhat.com> <20190725091625.GA15848@linux>
In-Reply-To: <20190725091625.GA15848@linux>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 11:22:46 +0200
Message-ID: <CAJZ5v0iBntT1c7gKkXG-RJpabZne2n-Afq40GKeA6-tUViVZuQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in acpi_scan_init()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 25, 2019 at 11:18 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jul 24, 2019 at 04:30:17PM +0200, David Hildenbrand wrote:
> > We end up calling __add_memory() without the device hotplug lock held.
> > (I used a local patch to assert in __add_memory() that the
> >  device_hotplug_lock is held - I might upstream that as well soon)
> >
> > [   26.771684]        create_memory_block_devices+0xa4/0x140
> > [   26.772952]        add_memory_resource+0xde/0x200
> > [   26.773987]        __add_memory+0x6e/0xa0
> > [   26.775161]        acpi_memory_device_add+0x149/0x2b0
> > [   26.776263]        acpi_bus_attach+0xf1/0x1f0
> > [   26.777247]        acpi_bus_attach+0x66/0x1f0
> > [   26.778268]        acpi_bus_attach+0x66/0x1f0
> > [   26.779073]        acpi_bus_attach+0x66/0x1f0
> > [   26.780143]        acpi_bus_scan+0x3e/0x90
> > [   26.780844]        acpi_scan_init+0x109/0x257
> > [   26.781638]        acpi_init+0x2ab/0x30d
> > [   26.782248]        do_one_initcall+0x58/0x2cf
> > [   26.783181]        kernel_init_freeable+0x1bd/0x247
> > [   26.784345]        kernel_init+0x5/0xf1
> > [   26.785314]        ret_from_fork+0x3a/0x50
> >
> > So perform the locking just like in acpi_device_hotplug().
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
>
> Given that that call comes from a __init function, so while booting, I wonder
> how bad it is.

Yes, it probably does not matter.

> Anyway, let us be consistent:

Right.
