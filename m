Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC23AE5D2
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUJW2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUJW2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2021 05:22:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18BEC061756
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 02:20:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bb20so5403239pjb.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xucopJdQYEMHhZQ7dqqB8UQAFZOXBMVYsdXdizA97FA=;
        b=vgHziPNRBMyZcOclBhC3U0MKPvE9Hn1g1zorbrtQPSjbwjjMHtxuehLkK5jav4xtQP
         0MsgvldXgiQbvefMiSDkhR0TiOaOfA3sw7mIbn4hm//b6lkh2TSQ/YwZbqiwf9k6q/yl
         MpAFGvVHz6gQ8nfIE6QxXJhawJXd93wnismO4+HeCAIO4326OoyrTnZPgapwS53dgSOD
         2mJPLOYkN9tz8rtAKlyp/n7wxonyxaqipTjoEzSm04OT0zO3uTSx3e8XZY026j5NTswn
         9c2xHcwYqnPU4NA+I6izG4vBuEs9oAjRCzer7DlyPRnQZtSsiugwN/QrvqdekmRETZ34
         n7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xucopJdQYEMHhZQ7dqqB8UQAFZOXBMVYsdXdizA97FA=;
        b=NMQ5vhHer0pD7Ym74nO1MEYuRyT4PIzhQ8cOGi1FZuKid8mRFgd+W/NUwDfCnz8UsJ
         +8XLZhY9870dy3fO7PNhcjaw8p8PbIrra1RSBHuyl9BztSaYqlOrPWoxTQVjCZ5b6l0Z
         JA+OiGZ8X3Lr00gjQDtYKLx/d84h4/ib8gJRSBt/82bBoCnhEeXbhJtFqgPkHKqGUODC
         WxQnZoUHh8l6jzzFzZPc7QlLqLtEiKCppD9IbHaMvYBQ6VmdwkZ+nI5Eekrf1jniSP61
         4dlby4oK3fKSwom1Q7XZpU70ZP/B64S/CYJxwQWPC9E1KvATALklbQY3phGceC6dE6lE
         42MA==
X-Gm-Message-State: AOAM532JSDGjmsNIRCTKtfU380ek9QS+hAO9VPVpcX/RUMbfDaZTdyZ7
        RpbulhheXEJqgV+SEQG6e7o3OA==
X-Google-Smtp-Source: ABdhPJymdL2wIiZ+VPdAPkTBA1iFDujziFi2nwnCOjvdII9bEiKPuiO3gz+pu3aUf6faKlwyhs0G5Q==
X-Received: by 2002:a17:902:e313:b029:125:827f:c621 with SMTP id q19-20020a170902e313b0290125827fc621mr1847055plc.25.1624267212333;
        Mon, 21 Jun 2021 02:20:12 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id w123sm7828850pff.186.2021.06.21.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
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
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
Date:   Mon, 21 Jun 2021 14:49:33 +0530
Message-Id: <cover.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Changes since V2:

- We don't need start_cpu() and stop_cpu() callbacks anymore, we can make it
  work using policy ->init() and exit() alone.

- Two new cleanup patches 1/4 and 2/4.

- Improved commit log of 3/4.

- Dropped WARN_ON(local_freq_scale > 1024), since this can occur on counter's
  overlap (seen with Vincent's setup).

- Handle stuff from init/exit() callbacks only.

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

This is based of v5.13-rc7 + a cleanup patchset:

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


The same is done by Vincent on ThunderX2 and no issues were seen.

I would like to get this merged for 5.14, since it was recently reverted from
5.13. And that it is still an independent change to a single driver and topology
APIs that no one is using apart from arm64 topology stuff.

Thanks.

--
Viresh

Viresh Kumar (4):
  cpufreq: cppc: Fix potential memleak in cppc_cpufreq_cpu_init
  cpufreq: cppc: Pass structure instance by reference
  arch_topology: Avoid use-after-free for scale_freq_data
  cpufreq: CPPC: Add support for frequency invariance

 drivers/base/arch_topology.c   |  27 +++-
 drivers/cpufreq/Kconfig.arm    |  10 ++
 drivers/cpufreq/cppc_cpufreq.c | 287 +++++++++++++++++++++++++++++----
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 5 files changed, 292 insertions(+), 34 deletions(-)

-- 
2.31.1.272.g89b43f80a514

