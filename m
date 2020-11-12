Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2412B0CAC
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKLSdN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 13:33:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKLSdN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 13:33:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8993AFF8;
        Thu, 12 Nov 2020 18:33:11 +0000 (UTC)
Message-ID: <1605205990.23683.98.camel@suse.cz>
Subject: Re: [PATCH v3 0/3] Add support for frequency invariance to AMD EPYC
 Zen2
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Thu, 12 Nov 2020 19:33:10 +0100
In-Reply-To: <20201110200519.18180-1-ggherdovich@suse.cz>
References: <20201110200519.18180-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2020-11-10 at 21:05 +0100, Giovanni Gherdovich wrote:
> v2 at https://lore.kernel.org/lkml/20201110183054.15883-1-ggherdovich@suse.cz/
> 
> Changes wrt v2:
> 
> - "code golf" on the function function init_freq_invariance_cppc().
>   Make better use of the "secondary" argument to init_freq_invariance(),
>   which was introduced at b56e7d45e807 ("x86, sched: Don't enable static key
>   when starting secondary CPUs") to deal with CPU hotplug.

The Intel 0-day bot reported a build error due to not guarding a part
of the patch with CONFIG_ACPI_CPPC_LIB. I've sent a v4 to fix that.

v4 at https://lore.kernel.org/lkml/20201112182614.10700-1-ggherdovich@suse.cz/
is now the most up-to-date version, ignore this one.


Thanks,
Giovanni

