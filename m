Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29FC3A99A4
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhFPL4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhFPL4q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 07:56:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835AC06175F
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 04:54:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u18so1015591plc.0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LO5EJonCZ/d5EwONfrhTxGMVZOU8PfqKuC1jlKIm6KY=;
        b=VB0iWCJfLn2XcQfTxTRN/CEHfkX0u3u7T9uUKaOKeUl2KexASUw/FNEg/owhnh7jcn
         XLfyljKXu3Tp61NHNzQtHuuPiWtdICkoxV6qceNWWsqJbvaxlUv2rmDvy+I86SICSEPC
         OhkzIelxRmSMHueQ4EyK1JssvE+n5ymmByD3kP9IWDMGMbuV5xrDmgnSiostd2OoFtfK
         7JOcmEzIU8jlKDqU02dMq1/i5OVGJFG+aBurXRrYz6EjV3S3RBop5J3NxGsRA47lbbmT
         HJwe5S9aqQ7EWztiDalPGuUXYv0yzYlBm344RVcyx0YTsxsLf1RIpv8+NAD1l9nBFi8P
         zvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LO5EJonCZ/d5EwONfrhTxGMVZOU8PfqKuC1jlKIm6KY=;
        b=l7Awd+87+eAI1AzMKqbG4mPGfGTMra8GM/0ntJsHUmUkvFhFSip6pleDgExZVw2RIv
         dUFrBUuCHKBHWq2GVL0iuodhaFfA3Vtk59vsATDdmPpIqxcZcR0GE5Yt/nZaR7JKkDex
         xrIHs7568T7NA18ChWoUzkcRxF8JjBMMFTciW0HHhCXrqrJVFmoYboXZO50g7Ke+/fsn
         LcGOg/GZFQru6AOA1oow6a3YIVhq0QCEerQ5vda1ntXaTcqFLPAR/RUVR35+iHJdfjuy
         vzsXyzrlkqEPaYjDjZaUisuYEUKAY8LoG/LknHQCcRnff+uJzlP5HGSUSZ5QeWe0plQb
         dtwQ==
X-Gm-Message-State: AOAM533flt1OK41CC++r2+kIFZsqeomBuYOV5FYhk0E5g3vvcrEknKT7
        YswhvrFNzrUDvPaEF15x6u4p8g==
X-Google-Smtp-Source: ABdhPJyYd3VQzt+tqYJ+n4o4+TQazujKn+PEyQYXSaGhFBXLJnG6eDoXfU6zgGPLGiB8Uk5i2qK6zA==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id h4-20020a170902f704b029011acdee0490mr8551076plo.37.1623844479074;
        Wed, 16 Jun 2021 04:54:39 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id w7sm2019453pjy.11.2021.06.16.04.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:54:38 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:24:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 0/3] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210616115436.5mm64htpbyxrnpzg@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <CAKfTPtCawkocU+ssGi9hz10tMGYib_pfiFGXNMiF1HGYWinMdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCawkocU+ssGi9hz10tMGYib_pfiFGXNMiF1HGYWinMdw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16-06-21, 12:02, Vincent Guittot wrote:
> I tested your branch and got the following while booting:
> 
> [   24.454543] zswap: loaded using pool lzo/zbud
> [   24.454753] pstore: Using crash dump compression: deflate
> [   24.454776] AppArmor: AppArmor sha1 policy hashing enabled
> [   24.454784] ima: No TPM chip found, activating TPM-bypass!
> [   24.454789] ima: Allocated hash algorithm: sha256
> [   24.454801] ima: No architecture policies found
> [   24.455750] pcieport 0000:0f:00.0: Adding to iommu group 0
> [   24.893888] ------------[ cut here ]------------
> [   24.893891] WARNING: CPU: 95 PID: 1442 at
> drivers/cpufreq/cppc_cpufreq.c:123 cppc_scale_freq_workfn+0xc8/0xf8
> [   24.893901] Modules linked in:
> [   24.893906] CPU: 95 PID: 1442 Comm: cppc_fie Not tainted 5.13.0-rc6+ #359
> [   24.893910] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS
> 0ACKL026 03/19/2019
> [   24.893912] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> [   24.893915] pc : cppc_scale_freq_workfn+0xc8/0xf8
> [   24.893918] lr : cppc_scale_freq_workfn+0x5c/0xf8
> [   24.893921] sp : ffff80003727bd90
> [   24.893922] x29: ffff80003727bd90 x28: 0000000000000000 x27: ffff800010ec2000
> [   24.893928] x26: ffff800010ec2000 x25: ffff8000107c3d90 x24: 0000000000000001
> [   24.893932] x23: ffff000816244880 x22: ffff8000113f9000 x21: ffff009f825a0a80
> [   24.893935] x20: ffff009efc394220 x19: ffff800011199000 x18: 000000000000001b
> [   24.893939] x17: 0000000000000007 x16: 0000000000000001 x15: 00000000000000bf
> [   24.893943] x14: 0000000000000016 x13: 000000000000029b x12: 0000000000000016
> [   24.893946] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff009efc6958c0
> [   24.893950] x8 : ffff009efc394248 x7 : 0000000002bde780 x6 : 00000000ffffffff
> [   24.893954] x5 : 00000000916e502a x4 : 00000000d9730e80 x3 : ffffffffffffffff
> [   24.893958] x2 : 00000000001e8480 x1 : 00000000002625a0 x0 : 0000000000000401
> [   24.893962] Call trace:
> [   24.893964]  cppc_scale_freq_workfn+0xc8/0xf8
> [   24.893967]  kthread_worker_fn+0x110/0x318
> [   24.893971]  kthread+0xf4/0x120
> [   24.893973]  ret_from_fork+0x10/0x18
> [   24.893977] ---[ end trace ea6dbaf832bce3e4 ]---

Thanks Vincent.

This is triggering from cppc_scale_freq_workfn():

        if (WARN_ON(local_freq_scale > 1024))

Looks like there is something fishy about the perf calculations here
after reading the counters, we tried to scale that in the range 0-1024
and it came larger than that.

Will keep you posted.

-- 
viresh
