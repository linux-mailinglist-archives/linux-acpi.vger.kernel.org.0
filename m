Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE51A26C9A0
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgIPTPC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 15:15:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35949 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgIPRip (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:38:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so7493945otw.3;
        Wed, 16 Sep 2020 10:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JDB+lU39ICq4aZ4kuFhJ9S4Knnwc0sZGJgPF5oVb6A=;
        b=TpkEnf6LfwMpqw7wvrW9ZzmIIvL1bshMvnGzzN32cGOkk1QyRrRb9/zoirG469CeyU
         ps06zreneQu6ySdAvWWgdB6MlHvGbkjCMa5r2lvZwqI0Lp5flWfoOV/TvfhjizyBw4H0
         fcKQE5yi5pcdS+RgqrTdW50Ut2dnC3V9zWHQpg3AxIH+4ZMIpmsjR7d/VaauYvSrLACm
         aC0meroUJKdAMuQUW0zGBG8oloC2+EVd83DFUsK1yk6UyTQTld44nnPjv5LHnuG+czgm
         AmtdVdDA4YoS76o+RrVjeI2zxSVAcfCD48Y5n9+GSSGlvPbMXwPAod6Aowek1cX8dEGY
         idjQ==
X-Gm-Message-State: AOAM530ebULNRY9ms1ewXk7fmFN3Df57ydPxDm5S5/is+gbJr+u9qF95
        J3RJjvo1fdOANeQK/FcOClSIhGcgCCi5ndJ6BzA=
X-Google-Smtp-Source: ABdhPJxXEqAa3xrm8VkiFZHBv5NvR2k7vtEw0BUNQO3Uy5RDg2tS6HrUyrTx22BrGUCOQuYdQq7k76PRnK+AsrbFRGY=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr17331423otj.262.1600277907620;
 Wed, 16 Sep 2020 10:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.280265587@infradead.org>
 <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com> <20200916154212.GE1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200916154212.GE1362448@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Sep 2020 19:38:16 +0200
Message-ID: <CAJZ5v0ipLfTA47d+qXUNLO+LAHpOmdEvfLyz=goF_rPh1nVJXw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 16, 2020 at 5:42 PM <peterz@infradead.org> wrote:
>
> On Tue, Sep 15, 2020 at 06:26:52PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 15, 2020 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Make acpi_processor_idle use the common broadcast code, there's no
> > > reason not to. This also removes some RCU usage after
> > > rcu_idle_enter().
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > The whole series looks good to me, so please feel free to add
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > to all of the four patches.
> >
> > Alternatively, please let me know if you want me to take the patches.
>
> Feel free to take them. All the prerequisite borkage is in linus' tree
> already.

OK

All applied (with some minor edits in the subjects) for 5.9-rc6.

Thanks!
