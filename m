Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6062CBEB0
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgLBNuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 08:50:10 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:36529 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLBNuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 08:50:09 -0500
Received: by mail-oo1-f67.google.com with SMTP id l20so368034oot.3
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2020 05:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFjESLmuxNLKDf+Mf0ioNhvLb6p8ExlMqA7Oi02P130=;
        b=HjezcuVn8Toc7wixsvXeYHPEWy+jtB52VHDIEzBxvhRg12PaJJuvqjjPvhjU+/eY31
         j/cGfGAlat1pRPczjbR6kyJ0o+rY3joUuBDKwjeLLjbCfawmxWPHDiB8jPdidysYdFwo
         2KuNyThFBtbB7bFB99O4tuTMzpkfZHqZCNmxPCPkI0JDZzfj2RViyRG4d2RlF3rPfi5n
         P2w5BVvhLcRJgK2/8sarHRCFbcTpwZDtxiI8wW0PnZRm7Z4I48RUqTSt9F7yxzrqApef
         tRbu3ldIg1/3q3UtUbWpcZJRplw9NOgorcaIDaNtY8QSD09Hd6EvkbMjTJ1DVQBTYQvT
         6nXA==
X-Gm-Message-State: AOAM532pbB2/ezz6hxrI1FW4XbiSCidQPOrPTiC/TKUh+kAaZpSf46at
        o3JqggLKdbJ49eQGTjJDFFafqglplDptELcEmhKV1W9Pp0I=
X-Google-Smtp-Source: ABdhPJw49kVJTx25/JdtmboyJAORgupBPlM1ufcs58U96G7RGd3SNv6Bkxi3FDBuTamQ8Xw0BOhGSgpvKfrJTu8gxQc=
X-Received: by 2002:a4a:bb07:: with SMTP id f7mr1717960oop.44.1606916968890;
 Wed, 02 Dec 2020 05:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 14:49:17 +0100
Message-ID: <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> A while ago (almost 2 years ago) I discussed an issue with you about
> some devices, where some of the methods used during device-addition
> (such as _HID) may rely on OpRegions of other devices:
>
> https://www.spinics.net/lists/linux-acpi/msg86303.html
>
> An example of this is the Acer Switch 10E SW3-016 model. The _HID method
> of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
> the installed wifi chip and update the _HID for the Bluetooth's ACPI node
> accordingly. The current ACPI scan code calls _HID before the GPIO
> controller's OpRegions are available, leading to the wrong _HID being
> used and Bluetooth not working.
>
> Last week I bought a second hand Acer device, not knowing it was this
> exact model. Since I now have access to affected hardware I decided to
> take a shot at fixing this.
>
> In the discussion you suggested to split the acpi_bus_scan of the root
> into 2 steps, first scan devices with an empty _DEP, putting other
> acpi_handle-s on a list of deferred devices and then in step 2 scan the
> rest.
>
> I'm happy to report that, at least on the affected device, this works
> nicely. While working on this I came up with a less drastic way to
> deal with this. As you will see in patch 4 of this series, I decided
> to first add a more KISS method of deciding which devices to defer
> to the second scan step by matching by HID. This has the disadvantage
> of not being a generic solution. But it has the advantage of being a
> solution which does not potentially regress other devices.
>
> Then in patch 5 I actually do add the option to defer or not based on
> _DEP being empty. I've put this behind a kernel commandline option as
> I'm not sure we should do this everywhere by default. At least no without
> a lot more testing.
>
> Patch 6 fixes an issue with patch 5 which causes battery devices to stop
> working.
>
> And patch 7 adds some extra HIDs to the list of HIDs which should be
> ignored when checking if the _DEP list is empty from Linux' pov, iow
> some extra HIDs which Linux does not bind to.
>
> Please let me know what you think about this patch-set. I would be happy
> to see just patches 1-4 merged.

I took patches 1 and 2, because IMO they are generally useful (I
rewrote the changelogs to avoid mentioning the rest of the series
though), but I have some reservations regarding the rest.

First off, I'm not really sure if failing acpi_add_single_object() for
devices with missing dependencies is a good idea.  IIRC there is
nothing in there that should depend on any opregions supplied by the
other devices, so it should be safe to allow it to complete.  That, in
turn, will allow the flags in struct acpi_device to be used to mark
the "deferred" devices without allocating more memory.

Next, in theory, devices with dependencies may also appear during
hotplug, so it would be prudent to handle that on every invocation of
acpi_bus_scan() and not just when it runs for the root object.

So my approach would be to allow the first namespace walk in
acpi_bus_scan() to complete, change acpi_bus_attach() to optionally
skip the devices with missing dependencies and return a result
indicating whether or not it has set flags.visited for any devices and
run it in a loop on the "root" device object until it says that no new
devices have been "attached".

Let me cut a prototype patch for that and get back to you.
