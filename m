Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29D303601
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 06:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbhAZF5b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 00:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbhAYKAN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 05:00:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3CC061351;
        Mon, 25 Jan 2021 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJYeiAvL4VeVAenUSsgyMYNM2qEv0ZjDoysHFmUMJos=; b=jgTw6YQpQch96Jh2NAY77ZJaOK
        Z/CXctZ/YGYOQ29vtW6E7aXdigyHfW+hPf06Z0lUPiwnC9h7NU4CsZKFhWScilSj+ffNdBTqLswS8
        N2TfhsHCtqtmI/TzHn5tD1qjhxtEhx/jJGLxK1eDTMFXbxNWar/1wvxc5rM/4qUePeZkrgHD/RHo5
        PF5LQQFEX8vKLYcnS75Buw78QaV4YUZbgxgFExzAAOtCbOT1UE3gd30f1CCQM51nUZjK/nqVCdHte
        R356/Mu24kfBMqxvoePR48L/8PH2Wr2WnX474tEKcLKVsT+5Q2AaJiBvkvlDpIottlxUkLwpwa89o
        9HKDCL+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3xKp-0001tn-Ez; Mon, 25 Jan 2021 08:34:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AF1D3010C8;
        Mon, 25 Jan 2021 09:34:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEFA1207D3C61; Mon, 25 Jan 2021 09:34:49 +0100 (CET)
Date:   Mon, 25 Jan 2021 09:34:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Larabel <Michael@phoronix.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/1] AMD EPYC: fix schedutil perf regression
 (freq-invariance)
Message-ID: <YA6CqYcaEhUoyJdH@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <a5071cb5-6a5b-d2e4-ff06-fa7810b8127c@phoronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5071cb5-6a5b-d2e4-ff06-fa7810b8127c@phoronix.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 24, 2021 at 04:30:57PM -0600, Michael Larabel wrote:
> From ongoing tests of this patch, it still certainly shows to address most
> of the Linux 5.11 performance regression previously encountered when using
> Schedutil. Additionally, for a number of workloads where not seeing a
> regression from 5.10 to 5.11 Git is still showing even better performance
> with this patch. The power monitoring on the AMD EPYC server is showing
> higher power spikes but the average power consumption rate is roughly
> comparable to that of Linux 5.11 Git, which is higher than 5.10 by just
> about 3%.
> 
> So this patch still seems to be working out well and indeed taking care of
> some wide losses seen otherwise on Linux 5.11 when using Schedutil on AMD
> Zen2/Zen3. Still have some other tests running but so far no unexpected
> results.
> 

Did you do all this writing and forget to add:

Tested-by: Michael Larabel <Michael@phoronix.com>

?
