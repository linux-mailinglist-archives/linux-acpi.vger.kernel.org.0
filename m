Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57B278C82
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgIYPYP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 11:24:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37201 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgIYPYP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 11:24:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id a3so3170013oib.4;
        Fri, 25 Sep 2020 08:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pZ+oKMneSbQw+VBTAklpjVM+xZE6n37L3PNMsbYGCk=;
        b=IS5AJUwbxmqg/SlJ5QJYgUH5jffofCrFFxDsdaNFBrSMR7ZlJ/LPj1Xcietl7Dr2Su
         ugYrqsRmDCv4F3UExVSL9fnB2oMzH+9js2bOYVcJGSQGVw4dLAc+909ofaeSuQCyIuTO
         3U7J2OzeF9zTHOniU8rLjph92h/JfqMltnk0yOqMtDXBCH0rTZrCxSfYrz69UewcoA+Q
         HqliPkwYsH4EdavbKS1UAjNaQxWV9K7kQgshkSv93BBvhnBnruEQ7J8Ljt0+1l5QL3RB
         +sN6bQJ/cVX1eRih02EhiD/MkMNeuzc79kt3dsyw8MujhQcLyvNSEHUoOfcQP7iJOn1a
         YZZQ==
X-Gm-Message-State: AOAM531GF0CZ+595OjQ9rnn782bWGlavHuRa+WPIyIfGn7w0eR7gQ0Vm
        dE6ddzdG+gkl6Q/VDieW0E8YE953ctZom6tli+8=
X-Google-Smtp-Source: ABdhPJynZTdx2wxg22Twifp6xQ8/oH+tTUIQpiZntiGs7FXznEMy9Km6ptDPDqbUp9ofVaK9Gu8Txi1IadhRpLqTS0E=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr568875oib.68.1601047454038;
 Fri, 25 Sep 2020 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.479637218@infradead.org>
 <20200925152000.GA171076@roeck-us.net>
In-Reply-To: <20200925152000.GA171076@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 17:24:03 +0200
Message-ID: <CAJZ5v0g2sCth5nofpPt4ucjQC0W=aU3YmSPqSRp+OyFWgS6YxA@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] acpi: Take over RCU-idle for C3-BM idle
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 25, 2020 at 5:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Sep 15, 2020 at 12:32:01PM +0200, Peter Zijlstra wrote:
> > The C3 BusMaster idle code takes lock in a number of places, some deep
> > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > the driver take over RCU-idle duty and avoid flipping RCU state back
> > and forth a lot.
> >
> > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> >   that combination, otherwise we'll loose RCU-idle, this requires
> >   shuffling some code around )
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> ia64:defconfig:
>
> ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
>
> I realize that this has already been reported more than a week ago, with
> no visible reaction. Another problem introduced in the same file, resulting
> in
>
> drivers/acpi/processor_idle.c: In function 'lapic_timer_needs_broadcast':
> drivers/acpi/processor_idle.c:179:1: warning:
>         no return statement in function returning non-void
>
> may cause ia64 boot problems since a non-zero return value will trigger
> a function call. AFAICS that is not supposed to happen on ia64.

There are fixes for the above in my tree, they will go to Linus shortly.

Thanks!
