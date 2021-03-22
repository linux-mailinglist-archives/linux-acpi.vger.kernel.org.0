Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0081B34375E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 04:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCVDZL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Mar 2021 23:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCVDYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Mar 2021 23:24:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78FC061762
        for <linux-acpi@vger.kernel.org>; Sun, 21 Mar 2021 20:24:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so7632178pjf.4
        for <linux-acpi@vger.kernel.org>; Sun, 21 Mar 2021 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0OxWtGufCgAe0XbTGNWWjUrTicDtwtzOE+UdLLql1Jw=;
        b=YoYpoDncERnCl23zDdx/vuysDA3ATAoE9TocP6isvskZKkqJEuDADYwNV9nm7FWMEb
         7VVwBZiIKS2BAf4uE0FvMYabolFwG64gRVzT66CYsqXDoyFhZpheH44T3oz6TLpRrFOp
         JJi9eBRxlVCHq/VEeNieCywFZ+/j0O0LwQADuve0Z1sDVjhNZ+kKaVsBd8A5QLd9G32U
         gA5YDtkaOG38QqAq5mUnrSUMR6OnfVFVvU6uAP+C4msfEiSiEmRDBoj9qFKMGR9QYGmG
         t1EztxFvegh2M5GeN8IqG8j6Sokyqit36e2D6tTN4j1JwF0xgnvHjn+BlTPt8BjYlMvt
         tzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OxWtGufCgAe0XbTGNWWjUrTicDtwtzOE+UdLLql1Jw=;
        b=iZ/TQJLUgp2/bznBtDAT0KrVyYcjA5MK007rPO8xcBFHi5ZbmeLKbVwPMESdZu436y
         8TH1+4d2sw1pcJWHzv7FWrdkmOQNmdi4eL0vsNfC0wIky7Bke8ns8S28fENd5FPKARRv
         UCyyribNtd0AwQ+K3rDN97/6BZg3zLs9y9s5rTamYRMwA9GXKPjCaqAo908cMYFiH1Av
         oggXagqAmcPvr+EvlH0MMPOeof3092vvx9voYQhjIbttAIhZz/JfiE92387dRHmFfev0
         req195PTV9q1TbqBp1IHJ9BjccEve/JEAAmIwPYeR4izTSkA3aEYRWDG9/yjZ9CjUH+c
         4V0w==
X-Gm-Message-State: AOAM531TJqI8bb+aZm0l2ch+T0MdX4eQ1qQnblFukU52kAiOahhYEqVh
        E9C48wKSS6vO86ntiST6DgZqDA==
X-Google-Smtp-Source: ABdhPJxW1bQ3tLiqoJxUAzpwfz76tolklxGNNiRiyecHaYs/raCJ7Hw61stj8ANiFApVqPEyvXsaUw==
X-Received: by 2002:a17:90a:458b:: with SMTP id v11mr10575612pjg.189.1616383492308;
        Sun, 21 Mar 2021 20:24:52 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id f17sm4945038pgj.86.2021.03.21.20.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Mar 2021 20:24:51 -0700 (PDT)
Date:   Mon, 22 Mar 2021 08:54:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 4/4] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210322032449.eqx7wbltzfq5o66f@vireshk-i7>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
 <19fbb10acaaceaa25671c973b9eb6f170015de00.1615351622.git.viresh.kumar@linaro.org>
 <CAJZ5v0i-D+3gcL5UuRP6aW_V6NCe_eZ2qt6d8A1wYa8nw_2f0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i-D+3gcL5UuRP6aW_V6NCe_eZ2qt6d8A1wYa8nw_2f0g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19-03-21, 17:20, Rafael J. Wysocki wrote:
> Sorry for the delay.
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks.

> and I'm assuming that either you or the sched guys will take care of it.

Yeah, I have already queued this up.

-- 
viresh
