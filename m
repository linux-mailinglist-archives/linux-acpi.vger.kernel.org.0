Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97B30C9DE
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhBBSbb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:31:31 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38443 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbhBBS36 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:29:58 -0500
Received: by mail-ot1-f42.google.com with SMTP id t25so10684481otc.5;
        Tue, 02 Feb 2021 10:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2VpDNxsMmLKvVqvFk/iIWO0mth/SOHLInguuBcwD2k=;
        b=db6E9MgJQKMt5fb13mhJwfHWFz3k8qQYI+OtAHdlHxl9rM6eTMzkELUmz392rtwHT9
         rUstyNw0Of3eNbDbXyXn0DsWGHeYu7iAXzcUYewz5YEDPzJ3ORWcXR5TTvGOOsBtaTHZ
         gwj3Y/3+6UDLN7WI8u+8EGJktFmbBeCPyTT2ESGUQ4zxXIxetJ50hi25D6I7CdRmH4Kc
         Oj37Q755YikC3hojs6GdqJM2cOVFxzuMCj8e9WvziveDGmJbtXDyEPkJuOs8qYmZu5g5
         0eEuFi81bOdkSWN7fXGchWoxJHvpgjcdgMQ0mfiXNKoFIVdRHh8fKPk7gdF44mnkY16z
         gW7A==
X-Gm-Message-State: AOAM532ZqMIR2gZiEsip0T0bY2jb+eABBM80cUzdu7srDUAjCYqULfkQ
        3I++YDMoNGf/u1w1Z891JJxuHlNDK5F2x08rMk0=
X-Google-Smtp-Source: ABdhPJwOwjbIFSLf33wNC1qg3hmqCYjGgWgzlE7pRdQ5hJBkhW1ErIvoqJ5+tGCycJFpeY5VW8WX47KR95WvdjjenV0=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr16272261otq.260.1612290557815;
 Tue, 02 Feb 2021 10:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net> <1611652167.11983.65.camel@suse.cz>
 <20210126093140.GB3592@techsingularity.net> <YA/pYrvvjf8AxPEv@hirez.programming.kicks-ass.net>
 <1611933781.15858.48.camel@suse.cz> <1612275425.27785.70.camel@suse.cz> <YBmYFnZuezAIlEhw@hirez.programming.kicks-ass.net>
In-Reply-To: <YBmYFnZuezAIlEhw@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 19:29:06 +0100
Message-ID: <CAJZ5v0gnu1DjPKEDWAf_hHku61rBdHfEL0pon+t-NwZXPzSEOQ@mail.gmail.com>
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

On Tue, Feb 2, 2021 at 7:24 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 02, 2021 at 03:17:05PM +0100, Giovanni Gherdovich wrote:
> > Hello Rafael,
> >
> > you haven't replied to this patch, which was written aiming at v5.11.
>
> I've tentatively queued this for x86/urgent, but ideally this goes
> through a cpufreq tree. Rafael, Viresh?

I've missed it, sorry.

I can queue it up tomorrow if all goes well.

Cheers!
