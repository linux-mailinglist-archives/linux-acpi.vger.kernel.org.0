Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE33027C9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 17:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbhAYQ02 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 11:26:28 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:39147 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbhAYQ0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 11:26:03 -0500
Received: by mail-oo1-f42.google.com with SMTP id z36so1463211ooi.6;
        Mon, 25 Jan 2021 08:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFwTq+OScXIcVonxGOjBlHjUqwMYEvu6XWhum3jN8NI=;
        b=CL7M/oUzUcl5VtJNC1eEZNqlaTiTMo25p60mGtRGfBkTI4YgONPaJehJWyXipQ4Wh3
         HmlGnnu6Cq/wSBkKrTnr+Kb8XSlkwANRR/H14shTP2lnz571+KV4zPcZTGam+YdY2ULj
         4tJ5r14ODIRv4O1MwltyFZxfSFVwFyt1tnsHjQKdps6xmE5RIN78sA+cwEoJhvAxcrwE
         /A6+ihoLEI/Kg0VR4H02ezY2zB1oxAwUGIrMb2YfSnyQVtZrqUva89r6ejpjymPwghp8
         IjKJe+mzdS0VI727P4v9rn9Dtn0BNf3yB1iEPUaM9jrNLslh4VzU5ZZul5ce5chAB4DW
         INew==
X-Gm-Message-State: AOAM530+Kz8jRR4xJg4YpqkdTKEiIcXMCb55BtObKSSXHZuVLQqtQhuo
        uqel/MSI8wtOb4x+89bD7640S9II8dxjYVFxFlU=
X-Google-Smtp-Source: ABdhPJw94FS2sVkIv7zvr5rZNd8U07Htu+OFlLA4/p6peeom+asbQeBkITEoCKvoQ4I4CyzSQUvYE2e5xtNUlRgxMmc=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr1015923ooi.44.1611591922626;
 Mon, 25 Jan 2021 08:25:22 -0800 (PST)
MIME-Version: 1.0
References: <87blkbx1gt.fsf@gmx.net> <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
 <CAJZ5v0j7i86twMS+csYMaetUkvqjof4FD2GRNoZ_AN=SBF7F1w@mail.gmail.com>
 <9709109.MH8tSaV5v9@kreacher> <87eej0iuf0.fsf@gmx.net> <87wnw278ds.fsf@gmx.net>
In-Reply-To: <87wnw278ds.fsf@gmx.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 17:25:11 +0100
Message-ID: <CAJZ5v0ihGfW=8PRXZgLVMfwOCVJQQh=Kc+htqbYhBFvxgfYuZQ@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 24, 2021 at 2:49 PM Stephen Berman <stephen.berman@gmx.net> wrote:
>
> On Mon, 04 Jan 2021 16:38:43 +0100 Stephen Berman <stephen.berman@gmx.net> wrote:
>
> > On Thu, 31 Dec 2020 21:46:11 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> >> ATM, I'm tempted to do something like the patch below (with the rationale
> >> that it shouldn't be necessary to read the temperature right after updating
> >> the trip points if polling is in use, because the next update through polling
> >> will cause it to be read anyway and it will trigger trip point actions as
> >> needed).
> >>
> >> Stephen, can you give it a go, please?
> >
> > On Sat, 02 Jan 2021 12:03:17 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> >> There is one more way to address this, probably better: instead of checking the
> >> temperature right away in acpi_thermal_notify(), queue that on
> >> acpi_thermal_pm_queue
> >> and so only if another thermal check is not pending.
> >>
> >> This way there will be at most one temperature check coming from
> >> acpi_thermal_notify() queued up at any time which should prevent the
> >> build-up of work items from taking place.
> >>
> >> So something like this:
> >
> > Thanks for the patches.  I'll try them as soon as I can.
>
> FTR, since this is the thread I started for this bug, I've confirmed in
> https://lore.kernel.org/lkml/87y2gi78sg.fsf@gmx.net/T/#t that the latest
> patch fixes the bug.

OK, thanks!

The patch has been applied as 5.11-rc material.
