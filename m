Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCD3B6DEB
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhF2FXC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 01:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhF2FXB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 01:23:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0EC061766
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 22:20:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c5so16214501pfv.8
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKr7FA0vqoMz5lZ8aQYZkFOpTvgXxSqPGAHyogWXhmA=;
        b=BQTcGyEaOFgaEzNWgL0U3aAv4ua18qKVcpzUgxZjcUZ1qkLiCuG4edKFSRP+of3CyG
         lODkt0mtAg+ovzEkkeiMHky/zg5rnZsmD7OObSqHe8/NN1Fnj6HFuMNjVWufKo0pzVDg
         IUX7UJ8RsE6JVcERMvfW6+uQnNXucT5RGsaHU9o5ZfHmckYLGYN4XVcwieVaCcILlmZ2
         3H9MYkzb38aLGYaD4RrwsPjwGZvjutRA1Kv3+xovuwfPOBzIV8qEYPd25EB6pWQVAaHM
         8PFSMOUXbk5e88JZq5n9vi5P0B+qEph7lrj2QCKCy3g9R3UJV5W6fW4V9UlPuvtK99b3
         Lwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKr7FA0vqoMz5lZ8aQYZkFOpTvgXxSqPGAHyogWXhmA=;
        b=WFqFlYXWmNc6nxrQRbwyKkeXWXZTGHErR9VD6LjDWgeMWtIsHJ3mNcmpo8UjSffjB9
         Pd0ccaHINk1rcueUawWKBtPywsUeeh56S+nbfEHekJnNyRIsUGNBYaW8CNRN+QK3006h
         lAWbIFBKCERuZIzsDjDXgPG7i8y5WlkEBCBGHjNvMuNNIGkBivUc/6y9ydZvBSH6sVZG
         j2fgC+s2P2b/cGiqw0eggBkPOyxkK8XkKvjG4n2ZAr++Uw8UuLBGLCDXJFYawHQxuNK9
         Dr77Ud92VKjsk2KLEr4ASPR+VPW0108K5YBjQ5Rel7BYp9P0+jnaWAGbNFfzq8Scjz6M
         xHYg==
X-Gm-Message-State: AOAM533dWDq0GceCiV64MMTyqJEp45GySb6H8ccjNcWE80fAVRjkJ2bn
        miZmhP7wWBM1vz0f94O8qbdkpw==
X-Google-Smtp-Source: ABdhPJxQoxMvsY+8msj2d7ojur78Qh6vYgssLxqEcJRU+k1k0HimFDS5ePM1wiuDDChVReESndK9cw==
X-Received: by 2002:aa7:82cb:0:b029:2e6:f397:d248 with SMTP id f11-20020aa782cb0000b02902e6f397d248mr28776722pfn.52.1624944032106;
        Mon, 28 Jun 2021 22:20:32 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id g11sm16843191pgj.3.2021.06.28.22.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 22:20:30 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:50:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210629052028.srt6metmtylsxukw@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <20210628115452.GA28797@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628115452.GA28797@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28-06-21, 12:54, Ionela Voinescu wrote:
> If you happen to have the data around, I would like to know more about
> your observations on ThunderX2.
> 
> 
> I tried ThunderX2 as well, with the following observations:
> 
> Booting with userspace governor and all CPUs online, the CPPC frequency
> scale factor was all over the place (even much larger than 1024).
> 
> My initial assumptions:
>  - Counters do not behave properly in light of SMT
>  - Firmware does not do a good job to keep the reference and core
>    counters monotonic: save and restore at core off.
> 
> So I offlined all CPUs with the exception of 0, 32, 64, 96 - threads of
> a single core (part of policy0). With this all works very well:

Interesting.

> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1056000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1863.095370] CPU96: cppc scale: 697.
> [ 1863.175370] CPU0: cppc scale: 492.
> [ 1863.215367] CPU64: cppc scale: 492.
> [ 1863.235366] CPU96: cppc scale: 492.
> [ 1863.485368] CPU32: cppc scale: 492.
> 
> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1936000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1891.395363] CPU96: cppc scale: 558.
> [ 1891.415362] CPU0: cppc scale: 595.
> [ 1891.435362] CPU32: cppc scale: 615.
> [ 1891.465363] CPU96: cppc scale: 635.
> [ 1891.495361] CPU0: cppc scale: 673.
> [ 1891.515360] CPU32: cppc scale: 703.
> [ 1891.545360] CPU96: cppc scale: 738.
> [ 1891.575360] CPU0: cppc scale: 779.
> [ 1891.605360] CPU96: cppc scale: 829.
> [ 1891.635360] CPU0: cppc scale: 879.
> 
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 2200000 > scaling_setspeed
> root@target:/sys/devices/system/cpu/cpufreq/policy0#
> [ 1896.585363] CPU32: cppc scale: 1004.
> [ 1896.675359] CPU64: cppc scale: 973.
> [ 1896.715359] CPU0: cppc scale: 1024.
> 
> I'm doing a rate limited printk only for increase/decrease values over
> 64 in the scale factor value.
> 
> This showed me that SMT is handled properly.
> 
> Then, as soon as I start onlining CPUs 1, 33, 65, 97, the scale factor
> stops being even close to correct, for example:
> 
> [238394.770328] CPU96: cppc scale: 22328.
> [238395.628846] CPU96: cppc scale: 245.
> [238516.087115] CPU96: cppc scale: 930.
> [238523.385009] CPU96: cppc scale: 245.
> [238538.767473] CPU96: cppc scale: 936.
> [238538.867546] CPU96: cppc scale: 245.
> [238599.367932] CPU97: cppc scale: 2728.
> [238599.859865] CPU97: cppc scale: 452.
> [238647.786284] CPU96: cppc scale: 1438.
> [238669.604684] CPU96: cppc scale: 27306.
> [238676.805049] CPU96: cppc scale: 245.
> [238737.642902] CPU97: cppc scale: 2035.
> [238737.664995] CPU97: cppc scale: 452.
> [238788.066193] CPU96: cppc scale: 2749.
> [238788.110192] CPU96: cppc scale: 245.
> [238817.231659] CPU96: cppc scale: 2698.
> [238818.083687] CPU96: cppc scale: 245.
> [238845.466850] CPU97: cppc scale: 2990.
> [238847.477805] CPU97: cppc scale: 452.
> [238936.984107] CPU97: cppc scale: 1590.
> [238937.029079] CPU97: cppc scale: 452.
> [238979.052464] CPU97: cppc scale: 911.
> [238980.900668] CPU97: cppc scale: 452.
> [239149.587889] CPU96: cppc scale: 803.
> [239151.085516] CPU96: cppc scale: 245.
> [239303.871373] CPU64: cppc scale: 956.
> [239303.906837] CPU64: cppc scale: 245.
> [239308.666786] CPU96: cppc scale: 821.
> [239319.440634] CPU96: cppc scale: 245.
> [239389.978395] CPU97: cppc scale: 4229.
> [239391.969562] CPU97: cppc scale: 452.
> [239415.894738] CPU96: cppc scale: 630.
> [239417.875326] CPU96: cppc scale: 245.
> 
> The counter values shown by feedback_ctrs do not seem monotonic even
> when only core 0 threads are online.
> 
> ref:2812420736 del:166051103
> ref:3683620736 del:641578595
> ref:1049653440 del:1548202980
> ref:2099053440 del:2120997459
> ref:3185853440 del:2714205997
> ref:712486144  del:3708490753
> ref:3658438336 del:3401357212
> ref:1570998080 del:2279728438
> 
> For now I was just wondering if you have seen the same and whether you
> have an opinion on this.

I think we also saw numbers like this, which didn't explain a lot on
ThunderX2. We thought they may be due to rounding issues, but the
offlining stuff adds an interesting factor to that.

-- 
viresh
