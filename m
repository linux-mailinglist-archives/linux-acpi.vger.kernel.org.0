Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4B7416E3B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbhIXIxJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbhIXIxF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 04:53:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A519C061574;
        Fri, 24 Sep 2021 01:51:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q23so8287765pfs.9;
        Fri, 24 Sep 2021 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lh0PhdMB4mUJ1U71AlvzrKsulNEKVtBA4jA9nNVlp8=;
        b=aq30uJKRB6NwfSJA9zBe3J0fh0gYBxL/BJxvPB6z4LuNg7yJxdZO1AoHVAfHgkoBOc
         4gekuuMOliZ2XMKr+PHboonew2BX1xurBkC9QcfPcw1W2KjpNiaJsF6aA9sw5ozuZLYM
         n1yaRvphEz+Sb7Hnb2MFgLnL4t4vflRzmKDZ7oCTUVdlcS2FJOB4Lrr5WzXe7cgd63AR
         JERv8DH/f+NYJnn/fPZ/mXWY48Ryn81pTMmQHduzMqsYoFo0k4lr8qIDpr/5IO42PdMb
         yMxW7uaknELGMAaz/F+Pz2h4x1oQaoukDeiGnShdOqYDealMEL2j3oSNGarr6ffggFvL
         kLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lh0PhdMB4mUJ1U71AlvzrKsulNEKVtBA4jA9nNVlp8=;
        b=NFEcNZoKovGfGD0Ug6vGR5q+sKgJP8rseQrzvdmzYm4/QEw2slS4l44Ld9WQws+wkt
         CHvLXIzJ6JDxJAP1hiajmCmzxAqnzE7rk1BqFTD9DCxH8SwknKZiFwo5eFrDcrk0v4mS
         yDBPofoF5yirZDmPS/j7VqP1SdT1QXxReEV2idpY+mLz+NEPHmqSv6txna0GLyXlWn31
         wIzGV3X11VBrPlUXq9fQLqKWSB4sFSNXiOHwPG6VYhw5Z52JLPuFQ5yTHW+T6Ei4ZJfd
         vZMvJ4exf1pOM9Z4M4HGaFlrDjpAEghOsJvkAL8NmWBbHX9f/hLEGBwHn0bNrqAu9W/F
         rQ9A==
X-Gm-Message-State: AOAM530bvMtT4IW9U4fCB0gs4TK/pg6Pu3BH+GmiljXGqPWBPO6Ze1wb
        Nu9HgkT0D36Ne2ugd7EaXgY=
X-Google-Smtp-Source: ABdhPJx0gAA7flFVnvUm8oFV6A+UegkJQM8Rnl2Ujvha5BjEKwW2Lai3YZndG2P7PRVYYJiDXUFDqw==
X-Received: by 2002:a63:3748:: with SMTP id g8mr2846222pgn.102.1632473491902;
        Fri, 24 Sep 2021 01:51:31 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:cad3:ec9e:d66f:102d])
        by smtp.gmail.com with ESMTPSA id t15sm9188362pgi.80.2021.09.24.01.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 01:51:31 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     aubrey.li@linux.intel.com, bp@alien8.de, bristot@redhat.com,
        bsegall@google.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        mark.rutland@arm.com, mgorman@suse.de, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        song.bao.hua@hisilicon.com, sudeep.holla@arm.com,
        tglx@linutronix.de, rafael@kernel.org, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, will@kernel.org, x86@kernel.org,
        yangyicong@huawei.com
Subject: [PATCH RESEND 0/3] Represent cluster topology and enable load balance between clusters
Date:   Fri, 24 Sep 2021 20:51:01 +1200
Message-Id: <20210924085104.44806-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

ARM64 machines like kunpeng920 and x86 machines like Jacobsville have a
level of hardware topology in which some CPU cores, typically 4 cores,
share L3 tags or L2 cache.

That means spreading those tasks between clusters will bring more memory
bandwidth and decrease cache contention. But packing tasks might help
decrease the latency of cache synchronization.

We have three series to bring up cluster level scheduler in kernel.
This is the first series.

1st series(this one): make kernel aware of cluster, expose cluster to sysfs
ABI and add SCHED_CLUSTER which can make load balance between clusters to
benefit lots of workload.
Testing shows this can hugely boost the performance, for example, this
can increase 25.1% of SPECrate mcf on Jacobsville and 13.574% of mcf
on kunpeng920.

2nd series(wake_affine): modify the wake_affine and let kernel select CPUs
within cluster first before scanning the whole LLC so that we can benefit
from the lower latency of cache coherence within one single cluster. This
series is much more tricky. so we would like to send it after we build
the base of cluster by the 1st series. Prototype for 2nd series is here:
https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-June/000219.html

3rd series: a sysctl to permit users to enable or disable cluster scheduler
from Tim Chen. Prototype here:
Add run time sysctl to enable/disable cluster scheduling
https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-July/000258.html

This series is resent and rebased on 5.15-rc2.

-V1:
 differences with RFC v6 
 * removed wake_affine path modifcation, which will be separately second series
 * cluster_id is gotten by detecting valid ID before falling back to use offset
 * lots of benchmark data from both x86 Jacobsville and ARM64 kunpeng920

-RFC v6:
https://lore.kernel.org/lkml/20210420001844.9116-1-song.bao.hua@hisilicon.com/

Barry Song (1):
  scheduler: Add cluster scheduler level in core and related Kconfig for
    ARM64

Jonathan Cameron (1):
  topology: Represent clusters of CPUs within a die

Tim Chen (1):
  scheduler: Add cluster scheduler level for x86

 Documentation/ABI/stable/sysfs-devices-system-cpu | 15 +++++
 Documentation/admin-guide/cputopology.rst         | 12 ++--
 arch/arm64/Kconfig                                |  7 +++
 arch/arm64/kernel/topology.c                      |  2 +
 arch/x86/Kconfig                                  |  8 +++
 arch/x86/include/asm/smp.h                        |  7 +++
 arch/x86/include/asm/topology.h                   |  3 +
 arch/x86/kernel/cpu/cacheinfo.c                   |  1 +
 arch/x86/kernel/cpu/common.c                      |  3 +
 arch/x86/kernel/smpboot.c                         | 44 ++++++++++++++-
 drivers/acpi/pptt.c                               | 67 +++++++++++++++++++++++
 drivers/base/arch_topology.c                      | 14 +++++
 drivers/base/topology.c                           | 10 ++++
 include/linux/acpi.h                              |  5 ++
 include/linux/arch_topology.h                     |  5 ++
 include/linux/sched/topology.h                    |  7 +++
 include/linux/topology.h                          | 13 +++++
 kernel/sched/topology.c                           |  5 ++
 18 files changed, 223 insertions(+), 5 deletions(-)

-- 
1.8.3.1

