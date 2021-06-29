Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E33B6FC0
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhF2Izp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhF2Izo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 04:55:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E1AC061766
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 01:53:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1545651pjx.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/8aWcR8pQLRr1AneyecLvILPcZP/SywuwqtFiKRs6o=;
        b=UERVdQrpA6QxI7RQYA+eUhOfbgXgeUFYb4pvURcjwQKvNlRQqHAOYqkWee5zs+Xjb0
         Ah3t28sJQF+zhkVQHRqUV46YTiZXGBh15MtEwUIevK9C7jHP7Fn7YYpts7mxMjBYXvfV
         47iOj3Tl6L2SOmEYsEKhu1xRsUleykMhGR2fkj71nvNEvo29dZejYi93pRIysLFg/Jyj
         JIwu/CkRn40298AVPZw0CFNk+2U+cYskRpjwI/yVZ8wTDOqXyUmLMtHYRw69DrGY1b7o
         BrSUColfv2WDuJLrTcLbkUPwpk6iOu0/QE8q5I/rcsxj598vsuZMvfGGMrfhnqAJGbzj
         noXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/8aWcR8pQLRr1AneyecLvILPcZP/SywuwqtFiKRs6o=;
        b=sd2MaOVF9QI69G9eladLNqj7WyJtqHwGCSQfg0G79MMHac0OaTXsDam/Fmn3KD4Uft
         VNlmHWKm7+sqiBn0kvrG7SgTfb6YdjFip25Nre5gqm30eaAf6AkFBCzkAyw+Gymg6486
         XoX6FYxCPgFIqVEi1p/g3BvBP9BBpSxvoROAVDqP73abD2oHU+RQwAuwMdXar6/aG2A6
         eAqtZG/jo+S5BI9oajz3kTnrHt34Zo+1gMihR25Oc6AXeKR5bflgP/wr3dYi6Y564bZa
         m9SdjaSbXhHz3WRlT7y29e4Pe1yCk6nHkPssNBTbrXv2dM4Y9MLUabRBLy6B7KsrStj5
         B66Q==
X-Gm-Message-State: AOAM533SmuAdqYF7NF0goq1zfm85prjhnL4jpo1M/ADMQPgO2pvg8qby
        syetGmJEPuXJlOCOwBgmBw1y2g==
X-Google-Smtp-Source: ABdhPJwo1gpUzWaxumdXxHpJ6qsqw7SXNoTKDhbjUPtSfTPJXEB307kK2Bp7DWMmed5a8furb5U99g==
X-Received: by 2002:a17:90a:5907:: with SMTP id k7mr33269795pji.196.1624956794956;
        Tue, 29 Jun 2021 01:53:14 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id i188sm6191585pfe.30.2021.06.29.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:53:14 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:23:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210629085312.j6f4e4b6vuezsqvm@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
 <20210625165418.shi3gkebumqllxma@vireshk-i7>
 <20210628104929.GA29595@arm.com>
 <20210629043244.xkjat5dqqjaixkii@vireshk-i7>
 <20210629084737.GB2425@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629084737.GB2425@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 29-06-21, 09:47, Ionela Voinescu wrote:
> Okay, makes sense. I have not seen this code actually do anything wrong
> so far, and the issues I see on ThunderX2 point more to misbehaving
> counters for this purpose. This being said, I would have probably
> preferred for this feature to be disabled by default, until we've tested
> more, but that won't give the chance to anyone else to test.
> 
> Thanks!
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks for understanding Ionela.

-- 
viresh
