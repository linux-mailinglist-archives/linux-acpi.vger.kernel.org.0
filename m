Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B584E3B2D8F
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jun 2021 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFXLRq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Jun 2021 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhFXLRh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jun 2021 07:17:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB9C06175F
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jun 2021 04:15:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h15so9534430lfv.12
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jun 2021 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBeXYZWV/5BphYQoBRycv7o/G0vcpUulJaPvVaWo0hY=;
        b=be5nxis7yjUUmikvo97sgsl1dVxYeKMBAmDqgtjaJ5IA+03sIPCdzB69LSB1K9XvoV
         IjmOl7yNCitywGNdQs6bQAd6fFOIxz9/MNhu1lIizTZymn6KU+FtSjqohDGGMdolqEHm
         fCj7x9ElobekxfYyfhyo2ukicjHUUEJ6h28TkNJPhSI8Wg3kDsNu8/F64T3EVJmN1y2I
         DK/yyEmbsdsZOcMc0irTDWynYHF8+RSVul+o1NZ9/JsAONc3y7ZYfxaAPHPalk0tl/bQ
         g+0afZEGN8BAsP5J8Vi4hXK+hbV59p9+KWW3dcDSncMkCTK7gSx8jXou3A2OQZGZXYis
         iXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBeXYZWV/5BphYQoBRycv7o/G0vcpUulJaPvVaWo0hY=;
        b=lDPDZhh3ymrO+P6IpnmKBN2WI7gJm/ZmLvEDgZQNdrrP4M+8Gz4aUZG5CcgwdGu4tv
         iH5a0AtN6GmqIG5KKvMX4wl+LMfOSsnEOvY/221qekpmA+T5eVZ45eJvMGJAXBAv45RV
         mm0wvfyzt3ntCtc/O5IlE8AKrOlf6JEzldEVubIpH0FOtbDubskmhxeBnN6Kj+P9d7ky
         LUFhlyKf21ARifFIqLcCwA6XcDccVqhwoHqxJ6gl3kjZhFyWDcrPfrOwQt0lovsFibNi
         Iq30fJ1t3lpT7r/dHfr4BLRkTse2PbWsPrS+bsmZ+DKNC3GyNYNC/fvVpH+JDk3nvkn3
         OrLw==
X-Gm-Message-State: AOAM5320pq+OGc4lR07+51jwbhzbEtx2KIgcIKPBtsUSOoZ4s5aj0Bli
        bV8TorL/8cKj/STVKDd60GBidQKUrEZithyYiRL75g==
X-Google-Smtp-Source: ABdhPJxXzLBF4txHG71/WJOdpAJctSJcR8nWW7QGoWwlBzbZW8b2rBbyLZw9YycJrAVOGBQ6eF8Y8XHAqlIBzmqCZQY=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr3604469lfp.286.1624533315667;
 Thu, 24 Jun 2021 04:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624266901.git.viresh.kumar@linaro.org> <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7> <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7> <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
In-Reply-To: <20210624104734.GA11487@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Jun 2021 13:15:04 +0200
Message-ID: <CAKfTPtAYuon+V96WmuLz+ekWuqVcb5k17w8ZwNuCzm2KMvZw+w@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 24 Jun 2021 at 12:48, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> On Thursday 24 Jun 2021 at 11:49:53 (+0200), Vincent Guittot wrote:
> > On Thu, 24 Jun 2021 at 04:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 23-06-21, 08:57, Qian Cai wrote:
> > > > Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> > > > development, and will provide an update once ready.
> > >
> > > Oh sure, np.
> > >
> > > > Also, I noticed the delivered perf is even smaller than lowest_perf (100).
> > >
> > > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > > >  ref:103377547901 del:54540736873
> > > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > > >  ref:103379170101 del:54541599117
> > > >
> > > > 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53
> >
> > I'm not sure that I understand your point. The formula above says that
> > cpu8 run @ 53% of nominal performance
> >
>
> I think this is based on a previous example Qian had where:
>
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
> 300
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 1000
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
> 100
> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
> 100
>
> ..so the 100 is not from obtaining percentage, is the reference
> performance.
>
> The logic of the formula is to obtain the delivered performance when
> knowing the number of ticks for each counter, so:
>
> So if one gets (103379170101 - 103377547901) ticks for the counter at
> running at 1GHz(perf 100), what is the frequency of the core, if its
> counter ticked (54541599117 - 54540736873) times in the same interval
> of time?
>
> The answer is 530MHz(perf 53), which is lower than the lowest frequency
> at 1GHz(perf 100).

But the nominal_perf is 280 and not 100 if i'm not wrong so the perf
value is 148 > lowest_perf in this case


>
>
> > > >
> > > > My understanding is that the delivered perf should fail into the range between
> > > > lowest_perf and highest_perf. Is that assumption correct? This happens on
> > > > 5.4-based kernel, so I am in process running your series on that system to see
> > > > if there is any differences. In any case, if it is a bug it is pre-existing,
> > > > but I'd like to understand a bit better in that front first.
> > >
> > > Vincent:
> > >
> > > Can that happen because of CPU idle ?
> > >
>
> Not if the counters are implemented properly. The kernel considers that
> both reference and delivered performance counters should stop or reset
> during idle. The kernel would not account for idle itself.
>
> If the reference performance counter does not stop during idle, while
> the core performance counter (delivered) does stop, the behavior above
> should be seen very often.
>
> Qian, do you see these small delivered performance values often or
> seldom?
>
> Thanks,
> Ionela.
>
> > > --
> > > viresh
