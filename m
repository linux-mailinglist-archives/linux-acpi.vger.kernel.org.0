Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8374D28B34D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 13:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgJLLAl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 12 Oct 2020 07:00:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33668 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387851AbgJLLAl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2020 07:00:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id t15so15520865otk.0;
        Mon, 12 Oct 2020 04:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1zzGoaY2S/EFy3jNz5H4aQ0+yU4Sr8kmv9ptMMnIcf8=;
        b=e9RTGE2+RhmJBDmIoHQ7f6HjRY7yZ9NkDHLJRtH65Gu2RyEHV//B4jE6GGZtfAbkPT
         Hew+hrYmoKMiqr5u6ELTFYXNB3LbF9QVvYXY2NL2aVmfWvFrd2G3m56nZhYsN1CFMM7H
         pbThAMpWrWpXRqajslMzzEcyvAdaOQv7N9KYD+mkDE01N5yohBxKcyETeg7pCe1hVTXV
         /1T7ykvfT6DQtpBrpvNawsGGc9bjVBPxkCnBgVvmznPM1FIbJO2Rr8Kqd61EWPR0tyUE
         BSa22mBaNEYINla4Rj/zPEKHA090RZYdgk63xLDpbbBWcXOVaw6HhvIpY8x7rz2USI1x
         3owA==
X-Gm-Message-State: AOAM531IbYyaBrA8pxqKvule9703OmXLVSWVdG1xv2a727CL8b4pB3dm
        OE0UptjUl14q0lYHC2uBUA2Mj/y/vfa1kUlxFO8=
X-Google-Smtp-Source: ABdhPJzKbmNdJGUGB3vocn6qhxNNfE4DQHDLsmhe3UNcG1kKuhMWsNUT113WNdSH0sNZd2Y8aa1zzukJYdKAuP9HzQY=
X-Received: by 2002:a9d:3626:: with SMTP id w35mr18911107otb.206.1602500439914;
 Mon, 12 Oct 2020 04:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <1a69c5bc-ccc4-68db-7871-af05a70052c9@molgen.mpg.de>
 <20201007221628.GW1009802@dtor-ws> <bbb70981-1242-0aea-01c9-f9507f8eae3b@molgen.mpg.de>
 <CAJZ5v0hKmESo0-kfN1+vK7to05GpVV3d7ZnO3XEsQ2jKKhvkJQ@mail.gmail.com> <7921b792-c99a-659c-730f-ecb25cb7f04b@molgen.mpg.de>
In-Reply-To: <7921b792-c99a-659c-730f-ecb25cb7f04b@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 13:00:28 +0200
Message-ID: <CAJZ5v0iim_XvBcjSZevEmbQb6F8bCb2jP14Ptnqd_7qfuuUHpw@mail.gmail.com>
Subject: Re: i8042_init: PS/2 mouse not detected with ACPIPnP/PnPBIOS
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 12, 2020 at 12:50 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Rafael,
>
>
> Am 12.10.20 um 12:39 schrieb Rafael J. Wysocki:
> > On Sun, Oct 11, 2020 at 1:08 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >>
> >> Dear Dmitry, dear Rafael, dear Len,
> >>
> >>
> >> Am 08.10.20 um 00:16 schrieb Dmitry Torokhov:
> >>
> >>> On Wed, Oct 07, 2020 at 11:18:41PM +0200, Paul Menzel wrote:
> >>
> >>>> On the Asus F2A85-M PRO Linux 5.9-rc8 (and previous versions) does not
> >>>> recognize a plugged in PS/2 mouse using the Plug & Play method. The PS/2
> >>>> keyboard is detected fine, and using `i8042.nopnp`, the PS/2 mouse also
> >>>> works.
> >>>>
> >>>>> [    1.035915] calling  i8042_init+0x0/0x42d @ 1
> >>>>> [    1.035947] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> >>>>> [    1.035948] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> >>>>> [    1.036589] serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>>> [    1.036621] initcall i8042_init+0x0/0x42d returned 0 after 687 usecs
> >>>>
> >>>> But, the DSDT includes the “mouse device”. From
> >>>>
> >>>>       acpidump > dump.bin; acpixtract dump.bin; iasl -d *dat; more dsdt.dsl
> >>>>
> >>>> we get
> >>>>
> >>>>                   Device (PS2M)
> >>>>                   {
> >>>>                       Name (_HID, EisaId ("PNP0F03") /* Microsoft PS/2-style Mouse */)  // _HID: Hardware ID
> >>>>                       Name (_CID, EisaId ("PNP0F13") /* PS/2 Mouse */) // _CID: Compatible ID
> >>>>                       Method (_STA, 0, NotSerialized)  // _STA: Status
> >>>>                       {
> >>>>                           If ((IOST & 0x4000))
> >>>>                           {
> >>>>                               Return (0x0F)
> >>>>                           }
> >>>>                           Else
> >>>>                           {
> >>>>                               Return (Zero)
> >>>>                           }
> >>>>                       }
> >>>>
> >>>> and the identifiers PNP0F03 and PNP0F13 are both listed in the array
> >>>> `pnp_aux_devids[]`. But adding print statements to `i8042_pnp_aux_probe()`,
> >>>> I do not see them, so the function does not seem to be called.
> >>>
> >>> My guess is that _STA returns 0 indicating that the device is not
> >>> present. I would try tracking where IOST is being set and figuring out
> >>> why it does not have mouse bit enabled.
> >>
> >> Does the ACPI subsystem allow to track, how ACPI variables(?) like IOST
> >> are read and set?
> >
> > My guess would be that IOST is a field in an operation region which
> > would indicate that it is initialized by the bootstrap part of the
> > BIOS.
>
> Thank you for your answer. But how can I verify that?

Inspecting the ACPI tables from the system in question could help you
to find out whether or not IOST really is a field in an operation
region, but its initial value may not be possible to determine this
way.

> Is there a Linux kernel parameter, that would print it?

Not that I know of.
