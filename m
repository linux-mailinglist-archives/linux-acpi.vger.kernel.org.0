Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A792CF2D3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbgLDRKy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 12:10:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:42368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388544AbgLDRKy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7643ACC3;
        Fri,  4 Dec 2020 17:10:12 +0000 (UTC)
Message-ID: <1607101812.24959.157.camel@suse.cz>
Subject: Re: [PATCH v4 RESEND] x86, sched: Use midpoint of max_boost and
 max_P for frequency invariance on AMD EPYC
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Nathan Fontenot <Nathan.Fontenot@amd.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 04 Dec 2020 18:10:12 +0100
In-Reply-To: <20201204170326.4178-1-ggherdovich@suse.cz>
References: <20201112182614.10700-3-ggherdovich@suse.cz>
         <20201204170326.4178-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2020-12-04 at 18:03 +0100, Giovanni Gherdovich wrote:
> Frequency invariant accounting calculations need the ratio
> freq_curr/freq_max, but freq_max is unknown as it depends on dynamic power
> allocation between cores: AMD EPYC CPUs implement "Core Performance Boost".
> Three candidates are considered to estimate this value:
> [...]
> 
> Benchmarks are described in the next section.
> Tilde (~) means the value is the same as baseline.
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>             ondemand  perfgov  sugov-noinv  sugov-max  sugov-mid  sugov-P0  better if
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> [...]

Hello,

this patch is currently merged in the tip tree, branch sched/core as
commit 46609527577d1def0af29ca5b56cffeeea771ada.

Unfortunately in the original commit message I used "----------" for
making table headers, and git dropped all the commit message after
that sign, i.e. the benchmark results and my signed-off-by.

In this "resend" I replaced the offending sign and the new commit
message should make it intact to the destination tree.


Thanks,
Giovanni



