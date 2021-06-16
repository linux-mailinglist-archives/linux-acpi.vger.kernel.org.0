Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB63A9302
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFPGuV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 02:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFPGuV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 02:50:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E53C061767
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso3401860pjb.0
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGeux1k9JWdeLuVQiCjnsXhyQPPrJGOsEZqXQl3yO0U=;
        b=C5NAcwkC7mA1qeppXu2tkTAkN7Jy2MTgN4kTAeYpf+aPPjiofwWPc/Zen9dH10DK9V
         6jXvGF/h1ZATOw9SeR1C7Tx2GNtiD1WXbuLL0OmjuErWPNdPy1V4lUzHlOm44m45mxhl
         KIOXN8nSFwgX4g6ztaeKjzyvLd5+qN0qZ00DSYdmWjSz01xXoRMwnQm0dEXk8RG+nJhu
         ikNPloTrQEgHmsd0HVbuetcSPjbihvHfewN5fDSOrtd0H5lo0o3Ng2oAMv3ekAyGprDv
         4EEZ4SXI/07UVoQ/B+WJu+EawA/rY0eOg30vHev6mco1uKydZbGOCjfDjoQYRHtLgWkm
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGeux1k9JWdeLuVQiCjnsXhyQPPrJGOsEZqXQl3yO0U=;
        b=KFzXJYLF76rWOAiqCmBq2pT4j77ZdTfrwuWuSdB1oqMkQS+8Ct56fq4qXKzszwZH1V
         Qj8r2QIO3EEqzoSdZ8+/3ce7IeuycDkWPs7WZMmSkWAH9A+Z+UrHZdV71sgpnYjIz/mE
         gt27FVkkfnC1X3svEXuduXz5vjyCPWmLRl6O6sKOed8r/OfaeN7Id+S+W/tkvv6+vj0o
         I06X92wX2C3noKVNaM98+TNwtsHRP4PTBFpnxMw4BvCrDfW8RENsKj35ogzH/FyPmlLV
         QQffhDCGvZfradabkoC/SHc2A9uuVUSqHBCQoHbYl2cVkqB3ClsfreTPU3haSE9XGNDE
         3ABg==
X-Gm-Message-State: AOAM530xboEOK/aUMlrBO3uAlWSjldI6KLxDN+6rLmRF3Brr9byXDfiM
        BodAe2GIMKEHcCED2aF9wPRzfg==
X-Google-Smtp-Source: ABdhPJxyy8SzyZMJWv8Peo5J64qiBMxpXojyyPNFDjOw/oZUudqWKkHh3X4bGVEIbT9V/VeVa7bnoQ==
X-Received: by 2002:a17:903:3053:b029:110:d36:af61 with SMTP id u19-20020a1709033053b02901100d36af61mr7798331pla.5.1623826095004;
        Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id x36sm1096314pfu.39.2021.06.15.23.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:48:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH V2 0/3] cpufreq: cppc: Add support for frequency invariance
Date:   Wed, 16 Jun 2021 12:18:06 +0530
Message-Id: <cover.1623825725.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Changes since V1:

- Few of the patches migrating users to ->exit() callback are posted separately.

- The CPPC patch was completely reverted and so the support for FIE is again
  added here from scratch.

- The start_cpu() and stop_cpu() interface is reworked a little so stop_cpu() is
  only ever called for a CPU if start_cpu() was called for it earlier.

- A new patch to implement RCU locking in arch_topology core to avoid some
  races.

- Some cleanup and very clear/separate paths for FIE in cppc driver now.


-------------------------8<-------------------------

CPPC cpufreq driver is used for ARM servers and this patch series tries to
provide counter-based frequency invariance support for them in the absence for
architecture specific counters (like AMUs).

This was reverted earlier for the 5.13 kernel after Qian Cai reported kernel
oops during suspend/resume.

This is based of pm/linux-next + a cleanup patchset:

https://lore.kernel.org/linux-pm/cover.1623825358.git.viresh.kumar@linaro.org/

All the patches are pushed here together for people to run.

https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/cppc

This is tested on my Hikey platform (without the actual read/write to
performance counters), with this script for over an hour:

while true; do
    for i in `seq 1 7`;
    do
        echo 0 > /sys/devices/system/cpu/cpu$i/online;
    done;

    for i in `seq 1 7`;
    do
        echo 1 > /sys/devices/system/cpu/cpu$i/online;
    done;
done


Vincent will be giving this patchset a try on ThunderX2.

Meanwhile it is up for review. Ideally I would like to get this merged for 5.14,
but lets see how it goes.

Thanks.

--
Viresh

Viresh Kumar (3):
  cpufreq: Add start_cpu() and stop_cpu() callbacks
  arch_topology: Avoid use-after-free for scale_freq_data
  cpufreq: CPPC: Add support for frequency invariance

 Documentation/cpu-freq/cpu-drivers.rst |   7 +-
 drivers/base/arch_topology.c           |  27 ++-
 drivers/cpufreq/Kconfig.arm            |  10 ++
 drivers/cpufreq/cppc_cpufreq.c         | 232 +++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c              |  19 +-
 include/linux/arch_topology.h          |   1 +
 include/linux/cpufreq.h                |   5 +-
 kernel/sched/core.c                    |   1 +
 8 files changed, 272 insertions(+), 30 deletions(-)

-- 
2.31.1.272.g89b43f80a514

