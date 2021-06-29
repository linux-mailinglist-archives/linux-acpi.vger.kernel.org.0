Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716A33B6DC4
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 06:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhF2EzI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 00:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhF2EzG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 00:55:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADAEC061760
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 21:52:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g21so14475435pfc.11
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAe56hWX/iMkGrPjUvuhXGh5ni1/NjeEmb5RdJ/Ussc=;
        b=G66g0bLNjh/AJ0CJ0kUeXNklSmwJwSgkBCRQvpb6C5iOnIxN6Mvdk6x6OLENG97S4A
         kSJteKWeEpfadf8SvP2t5wk3AKbv/pzMWRHjrlmEpKiHGr7jxv/+6MnfUUVEXNvz9wsR
         t8+pMkm5YA4o1e8ks9ArKpT27ECkJIUekUEfNGCTD/xim3499ZsKLQ19VPDhPg6rH/hB
         FSp3fL0r/FK4Kh5Kd2qtpWCE7ZzGhk59zzDieJ3tGEmm76G/ogewnvvJckNBApn64Nwa
         ouP7Pru3ur1kHniHr1MOxK5Zt32wvUq5TWytNGDfFxXoZRrCWRcI7dNUGTohM0BBoTDC
         md7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAe56hWX/iMkGrPjUvuhXGh5ni1/NjeEmb5RdJ/Ussc=;
        b=ipU6ucpmPyBpniY/wEhLp6g8QFfuROdn6QNxRr/v1Lwc8JC++dAu8eQQEq4dSYR95B
         qXK7PzNrkNRfg6MT219hFWLN6Dh4SonFgZu1BnjLdD6USq0mQ+Vgi2nwKxG0eY6mXPaT
         rTO+hL6FCXuwAZITXRXF2KOd4ZVIwFIsncv8if0xJL2XOMFXnF6vV7mPVFjWYH7qQVfP
         b5EESeI7MfUfSOiCxy15H1l1o2YhS29Xw/E8xbx82JoK06p1br6cw4SLpFM/xL5ttpKq
         5CMlSfHxudwfRpGW3wNvWTPc0qYmSV+kvzvsdtIYtE0USQxcontorRgSoFSp9Bhfx1wu
         b94w==
X-Gm-Message-State: AOAM531alsoFBXu0XgYJCuVPW7iGGGk2KcaeCxoBNDBFs5tL37kag/7Q
        m2ITlKtaPDN14StM0ape00PkHA==
X-Google-Smtp-Source: ABdhPJxDd7Wod3XiCZg94Zt6uE1klx3/zku1RXl5juXJJsIzU0iVteePFsn+tLqlU4f9LjxcOG5/0Q==
X-Received: by 2002:a63:ba09:: with SMTP id k9mr19146152pgf.340.1624942358511;
        Mon, 28 Jun 2021 21:52:38 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id a23sm16457212pfk.146.2021.06.28.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 21:52:37 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:22:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210629045236.pmhqactkc7unsjgj@vireshk-i7>
References: <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
 <20210625143713.GA7092@arm.com>
 <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25-06-21, 22:29, Qian Cai wrote:
> Ionela, I found that set ACPI_PROCESSOR=y instead of
> ACPI_PROCESSOR=m will fix the previous mentioned issues here (any
> explanations of that?) even though the scaling down is not perfect.

Not sure how this affects it.

> Now, we have the following on this idle system:
> 
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
>  	79 1000000
>   	1 1160000
>  	73 1400000
>   	1 2000000
>   	4 2010000
>   	1 2800000
>   	1 860000
> 
> Even if I rerun a few times, there could still have a few CPUs
> running lower than lowest_perf (1GHz).

(Please wrap your lines at 80 columns, it makes it harder to read
otherwise).

I think only the counters stopping on idle can get us that.

> Also, even though I set all CPUs to use "userspace" governor and set
> freq to the lowest. A few CPUs keep changing at will.
> 
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
> 	156 1000000
>   	3 2000000
>   	1 760000

I think this is expected since the hardware is in control of frequency
here. The software can only request it to run at X frequency, the
hardware may choose to do something else nevertheless.

-- 
viresh
