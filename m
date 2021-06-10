Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6DF3A26F0
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFJI10 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 04:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFJI1V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 04:27:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3868C061760
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:25:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g24so3189826pji.4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvT4K65HJqu4cpNZj3n9YyeOT6IYKvd3QDptTISVcLM=;
        b=YgwD/vhyqvAl9YxKoqRmfRLmSPvk/YbVgEOGYMTvQRInI+4zjYhoU5675gLHS/WeWM
         BmOBTxu3YAmmsRm69LMLVBDXOZKpj8YOVzO1jaaNLeoc2pKS+2kZ+wQ0VXUjQ+CijkS6
         A5Mvq3Q97Oo5n/IpEntVH/yfEgoc/u4vttw5bFfhleC2APLNBu9E7rG3THZG7AVYVGdK
         9zkt2c62QQInyztkcmHxpnMQwqS9uEZZTQCrUQx2LnLZuWVy0P0A4vb+olICA2wDsJI0
         9+e2UgDuaBSPOJq6VKvowdL5Rs+qmQnuFbYHAGER+N0AY77lUyJgTISql2lTXS+Id93q
         EePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvT4K65HJqu4cpNZj3n9YyeOT6IYKvd3QDptTISVcLM=;
        b=YiijTKL7hLCgF109lm1a/l2R920RKBxGw4mfJOJQZBuo+BLMg7K3un8GmPEHk+WhcK
         y+sOQptPnT9UneRC5Z5md3Q07zyMEfO45oeoWS7zW9z5/I14NhdR8BDblaxsOluyKeWj
         2rHA76Y47Mh3mPETWxIvkcWsiM48h1raT4nnFVLnCXPKIOQ7s+yBKeX27xGDUu9t8U/b
         upPCfDUfOXxYVG/eDzGja2c8O/YjYWH+pVoN/1ZFbwpcK+C91EzOk3shT11WD7UFse/I
         +DwgJj0/814h4jmE+RoztykwHPy0gg+87n0k7gwZ8R8ynvFwRslJ23VSzcySda6JYSoy
         Ogsg==
X-Gm-Message-State: AOAM533jBa+XoxPbUayVVFh9grqTimZw8nQCZ5K6cTCF4dGmnGLcuM9x
        0B/xawjkJWOe24mHvGzyz2FBXw==
X-Google-Smtp-Source: ABdhPJwhppcQo/1ShgwmUjhTXb+2sRaKsNZA7dmdZMTrOzJ9ezaFknq9StjI6i16yGrjU5WvFO8bZA==
X-Received: by 2002:a17:902:b181:b029:fc:c069:865c with SMTP id s1-20020a170902b181b02900fcc069865cmr3936476plr.28.1623313511220;
        Thu, 10 Jun 2021 01:25:11 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id f28sm1962976pgb.12.2021.06.10.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:25:10 -0700 (PDT)
Date:   Thu, 10 Jun 2021 13:55:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210610082508.756r22w4xd2j6vmm@vireshk-i7>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
 <41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09-06-21, 11:46, Qian Cai wrote:
> Git blame pointed out this series for a use-after-free during CPU offline/online. Any thoughts?

Thanks for reporting the problem here Qian. I have sent you a patchset
to fix these issues, please see if that works fine or not. It isn't
tested by me, as I didn't have the right setup for it.

-- 
viresh
