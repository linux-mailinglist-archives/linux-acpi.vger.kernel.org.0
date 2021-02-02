Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E1930CB34
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 20:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhBBTQT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 14:16:19 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45106 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhBBTBo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 14:01:44 -0500
Received: by mail-ot1-f43.google.com with SMTP id n42so20873357ota.12;
        Tue, 02 Feb 2021 11:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7c/SpUzGMJvfhT9d/3bvqW/cNh7KiE+wRFD8OSEwEkY=;
        b=jOWrSbW4ly0EtWDF/GJsQov47PlqxgTMOLzvpoqnNzb87uH8ZI6J0fLzlwA9AYWM+T
         FNtjXsrquuOOj8pemksh3F83zYygDjws9n/W8zrma+u+JPFfx5QNXoRDgULUXR+6U8Hc
         BF2UfEUb32AUsA64DYdfnbdZxVr7dxTJuxDfzWXZbOCwbsU/pKNPfUmQDFc2k5/fOfrH
         iIP/q8+QGoqVi9kl6Uh+dYPdO/VlPv4EO5JNVC6fKnFTjA33kOzdvsBbpReUlHbPbVVY
         tIrXXdtsS3vk5BZ9ajZT4Wc/k7RgJv16DxeCrVzhOE1VAVUTkP3Yrw1iz8jvJDmpiYAS
         wRrw==
X-Gm-Message-State: AOAM530npFrb9/6RqzQcT0nA4IFzQFJxVJ618VOM+2MyqFxA3Wcg4VrQ
        IX+cpJXtLOdRAUR+dw6jyFdYAaIx4hP6Ld53SHg=
X-Google-Smtp-Source: ABdhPJy5y3o42Ck2CXfv6vfBWEhbmbAhOSfOyQebNjSEq4QtbYxDypppaqQtG6BwjJKjOJWJ0GAHEhSlIHPu8L8yNZs=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr16961711ote.321.1612292460714;
 Tue, 02 Feb 2021 11:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net> <1611652167.11983.65.camel@suse.cz>
 <20210126093140.GB3592@techsingularity.net> <YA/pYrvvjf8AxPEv@hirez.programming.kicks-ass.net>
 <1611933781.15858.48.camel@suse.cz> <1612275425.27785.70.camel@suse.cz>
 <YBmYFnZuezAIlEhw@hirez.programming.kicks-ass.net> <CAJZ5v0gnu1DjPKEDWAf_hHku61rBdHfEL0pon+t-NwZXPzSEOQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gnu1DjPKEDWAf_hHku61rBdHfEL0pon+t-NwZXPzSEOQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 20:00:49 +0100
Message-ID: <CAJZ5v0jkOvr6-UQmoQuFx7dPsoP_WJBqAyUsebBFTyzf2+7MCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 2, 2021 at 7:24 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Feb 02, 2021 at 03:17:05PM +0100, Giovanni Gherdovich wrote:
> > > Hello Rafael,
> > >
> > > you haven't replied to this patch, which was written aiming at v5.11.
> >
> > I've tentatively queued this for x86/urgent, but ideally this goes
> > through a cpufreq tree. Rafael, Viresh?
>
> I've missed it, sorry.
>
> I can queue it up tomorrow if all goes well.

So actually I'm not sure about it.

Looks overly complicated to me.
