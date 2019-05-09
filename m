Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB618944
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfEILwZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 07:52:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35017 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfEILwZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 07:52:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id a132so1680935oib.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 May 2019 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iST7jMDClAzvyVwro4n5ml4YF9xDAvujMjiBR6BcQCA=;
        b=tfJrJiKO3X51qShaVmgzO/MiU1GCxxnAb4Mq0Dm1hekkmBTXYqu0bBuAKtVbfy7fmq
         GRTn/d1UuFpn0ifvaih4gEc5Dqg8lXbtc6OIjPMc5Q+ONvCj8Q8O3HwdayDjG3BPhnxl
         lv8TGml4iEBRGtVxPP/1jxVjiWSI2dq7MSyZykYH2TQLs6MkAN76KZZ7JJgjb9+x7qwg
         l1uxRorElxsOF0+qP4bZcXbKYPgJ15EEHojRBPFQuhlGhmDo+RQJ5P4SRx9KqESPHnPK
         JL0T5YtyHRwUSesfqqPoUaTFynSoQnHfd8Sva1YG0o0NieT1YgeV8SyWcMswPUAjAjzB
         LXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iST7jMDClAzvyVwro4n5ml4YF9xDAvujMjiBR6BcQCA=;
        b=FGpjFQNqiA0Hop0XOIYA7KiOK0kVuo9sHgWv2KZ5uboEcUTO+U6z20XJJM6BpO9hMJ
         MsGhIXZuN2QPFsOPzTVcXkPgk5ic54yV8Od1L6XzyUWNs6PDOvAyqBYtnnTDqeVzuJPM
         Gnc7echnxLeSZnw7jCv8Y3LcY9s2ntRLgldAFJk6PMeXMXhocmPn0+C2ChJc53pBnVhK
         z38YClqEpGR1ohimTyPOfFuPuz0oHtSGqsxpoxtSYX87FFvLsMgWPLZ85MojePmhWQUX
         TpnTGg9v2jaVb0tP0NovfbKRxPy6O7iIZSu6vaZlDilQPVvzyAoXqyIuNZ7xgWr4SEus
         4mow==
X-Gm-Message-State: APjAAAU3braHjOgVC5gSitjd16rQZQXvLQ0rXqJvZnj40og1XuMb2y0c
        LLEVFLqM6M2qR/uO7bRbV7V9eWRjFyd8E5pBOddTIw==
X-Google-Smtp-Source: APXvYqzfbIKjWMZvLgY5HFX4aYZrPdOggzW32bQke3976sbDwqKvdqLAZs9W7DmV0kFlifRbsDnZvEqeREvhJAYLw7Y=
X-Received: by 2002:aca:5986:: with SMTP id n128mr1174792oib.2.1557402744008;
 Thu, 09 May 2019 04:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <s5hsgu0ihyg.wl-tiwai@suse.de> <EksOpJxc6GB@mike.franken.de>
 <20190430090021.GF26516@lahna.fi.intel.com> <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
 <20190502114839.GC24696@kroah.com> <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
 <20190506064534.GG2895@lahna.fi.intel.com>
In-Reply-To: <20190506064534.GG2895@lahna.fi.intel.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Thu, 9 May 2019 04:52:12 -0700
Message-ID: <CAEGmHFHfMtuNk9MAFxFAabZnTxQPQyqaiqZyH2Ou7AWZ4ePS5w@mail.gmail.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>, mh@mike.franken.de,
        Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, May 5, 2019 at 11:45 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, May 03, 2019 at 04:35:02PM -0700, Furquan Shaikh wrote:
> > Thanks for reporting the issue and apologize for the breakage. When I
> > pushed the patch, my understanding was that the device drivers do not
> > depend on stale GPE events to take any action.
> >
> > I am curious to understand the behavior for the thunderbolt device
> > since I do not have one to test with. The failure seems to be a result
> > of either having a edge-triggered interrupt or a pulse interrupt which
> > indicates some kind of ready condition to the kernel driver. All the
> > runtime GPEs seem to be initialized as part of acpi_init before ACPI
> > bus is scanned. So, is this some special kind of requirement for
> > thunderbolt that requires GPE enabled before the device can actually
> > be probed. And so the GPEs going active before being enabled are then
> > used as a way to call into ACPI Method to enable something which is
> > essential for probing of device?
>
> IIRC the idea is that when you boot with a TBT device connected (this is
> only for the BIOS assisted/ACPI enumeration mode) the Thunderbolt host
> router (the device with PCIe switch + xHCI + NHI) is configured in two
> phases. The basic configuration is done in the ASL code that then waits
> for a synchronization event (signal) from the SMI hotplug handler that
> allows it to continue. The GPE which can be either edge or level is then
> used to call the SMI hotplug handler to initialize the host router and
> its resources properly.
>
> If this is not done the PCI stack finds the host router half-configured
> causing the failure.

Thanks for the explanation!

>
> > The other question I have is given that handling of GPE events that
> > were active before being enabled is required at least for some set of
> > devices (e.g. thunderbolt), what is a good way to solve the original
> > problem that was being addressed by the patch being reverted i.e.
> > stale events resulting in spurious wakes on wakeup GPEs. One way I can
> > think of is clearing the status of GPEs when they are setup for
> > wake(acpi_setup_gpe_for_wake). What do you think?
>
> Sounds good to me.

I will work on this and test it out to see how it goes. Thanks!
