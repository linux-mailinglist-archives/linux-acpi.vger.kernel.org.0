Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608912D89EF
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Dec 2020 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgLLUTq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Dec 2020 15:19:46 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36807 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLUTq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Dec 2020 15:19:46 -0500
Received: by mail-ot1-f42.google.com with SMTP id y24so11728408otk.3
        for <linux-acpi@vger.kernel.org>; Sat, 12 Dec 2020 12:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvEXGZMMkz6MOnBvBd4OZMebUo1ElVtlE8Rsqp4CnZg=;
        b=rp8YU8WvLZmWQD8XM4Who0OEMiF1im/SsuviY16E3myqyGMI8v4sujAMca95SSaGUA
         dyUPVG73YHaU89fuTLEaNfSWX/r6Z4uLvV/uh0zhARLtFpsQImCVWSgOdv/5pJ023V3R
         4kyyJE3BpvR4IEviRs0JnwNnxQwexRxZYdOgZS44uCHwD/IJfAg18kcYMH9Pn9+tuQcs
         WGHdFxv++Q7RZGexdtmN/sIQBG+S0tR5ujdBeNqa9T98rOzRNCwM3mJq6F9mNlYnzls5
         GJDxNOnzJ6tSw4QW1WqGYxorMCuCTdUOTgEzAks3EF9gsPcxfnk1xPO3dEhw4TiV3mJK
         e3xg==
X-Gm-Message-State: AOAM533pMfx/fvV/tOinMycGHuPceYYBLNsFHcYehmEmBRA6C0Ocqs/+
        JPcnILz25+jXJGGN44ygbrMW2QFJ4rCVgNzT5fy/Gk+2SxU=
X-Google-Smtp-Source: ABdhPJzcaavzmZarCDoLLztFS+YysyEfbg5x7plEL1UvK0CTamcCcEtCJftLURxUnh1MWOsWFioSfpltLWNQ2GNdwxQ=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr14916070otk.206.1607804344945;
 Sat, 12 Dec 2020 12:19:04 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx8BmwWKAcH3vtLh=zrTEwJX_Y2nS1uB4Hq0priMQOnohQ@mail.gmail.com>
In-Reply-To: <CAGETcx8BmwWKAcH3vtLh=zrTEwJX_Y2nS1uB4Hq0priMQOnohQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 12 Dec 2020 21:18:53 +0100
Message-ID: <CAJZ5v0gyCmt66FKJU-ui8-ab6bedvpGU+cV7dKf25a_BOOKH4w@mail.gmail.com>
Subject: Re: fw_devlink for ACPI - need some pointers
To:     Saravana Kannan <saravanak@google.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 12, 2020 at 3:13 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Hi ACPI devs,
>
> I want to take a stab at adding fw_devlink support for ACPI.
>
> fw_devlink adds device links between consumer and supplier devices. It
> finds the supplier-consumer dependencies by looking at the firmware
> nodes of devices as they are added to driver core.
>
> Main benefits of fw_devlink (because it creates device links):
> * Removes a lot of deferred probes or probe failures (due to poor
> error handling).
> * Makes module load order less important for things to probe successfully.
> * Makes suspend/resume a bit more robust.
>
> For DT (devicetree), I know how to interpret the common properties
> (Eg: clocks, -gpios, etc) to figure out what devices supply resources
> for a given device. In general, I'm familiar with DT and there's also
> Documentation/devicetree/bindings/ that I can grep for if I need to
> know what a property means. So, I've been able to implement fw_devlink
> for DT.
>
> Now, I want to add support for ACPI to get the ball rolling. However,
> I'm fairly clueless with it comes to ACPI. So, if I can get some
> pointers, that'd be great!
>
> Things I need help with:
> 1) I don't even know how to view the ACPI data on my PC. For example,
> in DT, /sys/firmware/devicetree/ has the entire DT represented as a
> tree of folders and files. How do I read ACPI info that lists all the
> devices, their properties, etc?

You can look at the directory structure under
/sys/devices/LNXSYSTM\:00/ which roughly corresponds to DT contents.

> 2) Is there documentation to look up what each of those device properties mean?

Of course there is.  The docs in Documentation/firmware-guide/acpi/ to
start with, the ACPI spec and a number of assorted additional pieces.

> 3) How are some of the common device dependencies listed in ACPI? For
> example, if a device depends on power, clock, GPIO, interrupt, etc how
> does ACPI list the supplier devices for each of those resources?

That depends.

_DEP is one way to specify dependencies between devices in ACPI, but
there are others.

> 4) Assuming there are a few common properties that list the device
> dependencies, how do I look up a firmware node that a property points
> to? If this is not how it works, how does it work?

The concept of "properties" as you know them from DT doesn't apply to
ACPI in general.

While it is possible to define "properties" of a device in a way that
is kind of analogous to DT, it really isn't used in practice.

Generally speaking, the spec defines the ways to represent various
types of information etc.

> In general, any pointers to docs that'll answer the above questions
> would also be appreciated.

Well, you may find it less compelling than expected, but feel free to
ask if you have any more specific questions.

Cheers!
