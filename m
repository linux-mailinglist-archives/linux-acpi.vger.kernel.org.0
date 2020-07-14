Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C915521F683
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jul 2020 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgGNPx1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jul 2020 11:53:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42964 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPx1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2020 11:53:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id t4so14287285oij.9;
        Tue, 14 Jul 2020 08:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsghvSlXCqKA5TycPVdHieRffX+h0fMKm3ZWSRwaSJk=;
        b=eu/hEH2bPv6lVzePyqjuZQSOOL/FNBTHvLrhSYNYXHJFomfBEbr7agVdpiDAENskpl
         udLRhvtcOldb/kq6xev+GT+WQHFhspHaDW1Yu4OnABMp3PHyi6lYdavxUBxIlxXEka6m
         MZ5H/QeXXFkVzRcqYUbM7cerNRAoYDSq7HdehuIKBOWaXxTRoJwXULjNxQNthC7LbcMX
         PhQTyG28Ku9Jf/ZwJAge5m6Rst05OK+y26JsQNz7/9DZBSb1RgLLIK++HfeKtNKXpJOM
         yM1Hl4DWpBK19qnMeMfL6nQ7h2xl8d92WHhPof6GDg0Legrpfe7I6V/oq2Tv44i4QfZp
         WZKA==
X-Gm-Message-State: AOAM533Ns0oPUFbIi53tdhlS48O+V/K3lEdgmZNmGDuxZFYxMgl80pWz
        xt8BLD5GTAKtJZMLeGfFAVj4U/GtOXxDIbnmOKw=
X-Google-Smtp-Source: ABdhPJw9BaF0Zl8Hh2Y+DeuKLc3Omx2W+DkTyhLmTA9kzPXC1FceBizx/dz72dgTlAWyYI35nOkUk+YfKG0ktjpTRiY=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr4103301oih.68.1594742006593;
 Tue, 14 Jul 2020 08:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net> <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net> <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net> <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de> <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com> <20200714141135.47adndrsdgpiqfy4@linutronix.de>
In-Reply-To: <20200714141135.47adndrsdgpiqfy4@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 17:53:15 +0200
Message-ID: <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 14, 2020 at 4:11 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-07-14 15:54:57 [+0200], Rafael J. Wysocki wrote:
> > On Tue, Jul 14, 2020 at 3:44 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:>
> > > On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:
> > >
> > > Let me summarize the thread here:
> > >
> > > On Stephen's system, ACPI informs the thermal zone driver to poll the
> > > temperature every second and the driver does so.
> > > The driver queries the temperature by invoking acpi_evaluate_integer()
> > > which invokes (at some point) acpi_ev_queue_notify_request().
> >
> > Well, I don't quite see how acpi_ev_queue_notify_request() can be
> > invoked from the acpi_evaluate_integer() code path.
> >
> > Do you have a call trace showing that?
>
> So the trace in
>      https://lore.kernel.org/linux-acpi/87o8pjh1i0.fsf@gmx.net/
>
> shows the pattern and we nailed it down that it comes from
> thermal_get_temp().

acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.

> I assumed acpi_ex_opcode_2A_0T_0R() since the other
> candidate was acpi_ev_asynch_execute_gpe_method().

Which probably is the case.  Specifically

acpi_ev_asynch_execute_gpe_method: Evaluate _L66

is likely to cause the Notify() to be dispatched.

> Stephen, the patch attached adds a WARN_ON() statement which will
> produce a stack trace (4 or so). Could please run 'dmesg' after a while
> and send it back. There should be a
>     "WARNING in drivers/acpi/acpica/evmisc.c"
>
> statement or something along the lines.
>
> Rafael, are you also interested in an ACPI dump?

That might help a bit.

So what probably happens is that poking at the TZ causes a GPE to
trigger and a Notify() to be dispatched which then goes into the
workqueue for execution.

Now, I'm not sure what happens to those Notify() items, though.  They
each should cause a handler (in the thermal driver) to be executed,
but does that happen?
