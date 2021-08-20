Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5343F245A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 03:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhHTBbb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 21:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhHTBbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 21:31:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95514C061575;
        Thu, 19 Aug 2021 18:30:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so6143837pjl.4;
        Thu, 19 Aug 2021 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEu4LjhxdzJpv+ocnqyemAsq+6b9y6L8AxnBWIqIiuA=;
        b=uFRwG28QYMv23yTBgfdwOQ1M/nZxlSg3QtQqePxm4ZYKVcIM7BKdC7chZufJfOj438
         MBirMnlNOpwcBliXs/nOWdgBBLOlZ0ssEV/859qMx81fsEO0cFIgU4OYMR6wMAv4kEEo
         wp8nnody9rEPPKP0G1A22paosr0iuV9z9EHil021kw0gA436ma30PmTFh+CB2TgVhU3Q
         KRYMOCZDCv+KYLRDZhRac4GaBSXD1JJ32zernzHRirP1gcduVGoXKFuODq9z9s8j5yh2
         fJFpaxi1Tt746ZcqGGKa8wtms1yMCVFsm8hBXlcbkPIvHRfAL9MxkLKYo1nALJiYgG1O
         kFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEu4LjhxdzJpv+ocnqyemAsq+6b9y6L8AxnBWIqIiuA=;
        b=bSATrL6esEaFRCpn8HZG3POBYfea7tCozdkuDYkBo3t8Voaou0zv4zzWFluqLREi+a
         bYItsb7HEuXItbBnSqPaRNsUREPSGY/++YHsn80SIwb+S/MqsYUDu39tIEKRvq0kVjzF
         tMu2/zrIOinl4mkkcXFPrT9mXqOtDMYYbPcI0tO8PyppkfFkrZSEbLsvUajafvsNsfiR
         RPINcZVxoM/ripJ/5KASUkk3QxbCnSL3zSXvvS0ywWOJvea1bvhAeAJP2lWuDh/qlY1t
         dJ0QzMVyVcFNcmQx0ksxVDPM7+BkBkMzc2lvjEXtiXP9TIDLH2Zjr+r5s22hyZpgsB6L
         fsNw==
X-Gm-Message-State: AOAM5332M73rcrw/WYG+K6kA07BDbGqatz0npXbQcVh2wMn0peCdC+8z
        pLPathe3acFHEGuNDL7RVpk=
X-Google-Smtp-Source: ABdhPJz7l+BYtUjbRn0Q/hd9a2zLFXFpEdnWbSBpIrS39V7JTIi85Cg7ko5ARW7ryfC55aGIIyDYNA==
X-Received: by 2002:a17:903:2305:b0:12f:6a02:808d with SMTP id d5-20020a170903230500b0012f6a02808dmr7494332plh.75.1629423054044;
        Thu, 19 Aug 2021 18:30:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:d23:7118:c805:b5a5])
        by smtp.gmail.com with ESMTPSA id 66sm4877950pfu.67.2021.08.19.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 18:30:53 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bp@alien8.de, catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, juri.lelli@redhat.com,
        bristot@redhat.com, lenb@kernel.org, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        sudeep.holla@arm.com, tglx@linutronix.de
Cc:     aubrey.li@linux.intel.com, bsegall@google.com,
        guodong.xu@linaro.org, jonathan.cameron@huawei.com,
        liguozhu@hisilicon.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rostedt@goodmis.org,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, will@kernel.org, x86@kernel.org,
        xuwei5@huawei.com, yangyicong@huawei.com, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 0/3] Represent cluster topology and enable load balance between clusters
Date:   Fri, 20 Aug 2021 13:30:05 +1200
Message-Id: <20210820013008.12881-1-21cnbao@gmail.com>
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
ABI and add SCHED_CLUSTER which can make load balance among clusters to
benefit lots of workload.
Testing shows this can hugely boost the performance, for example, this
can increase 25.1% of SPECrate mcf on Jacobsville and 13.574% of mcf
on kunpeng920.

2nd series(packing path): modify the wake_affine and let kernel select CPUs
within cluster first before scanning the whole LLC so that we can benefit
from the lower latency of the communication within one single cluster.
this series is much more tricky. so we would like to send it after the 1st
series settles down. Prototype here:
https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-June/000219.html

3rd series: a sysctl to permit users to enable or disable cluster scheduler
from Tim Chen. Prototype here:
Add run time sysctl to enable/disable cluster scheduling
https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-July/000258.html

This series is rebased on Greg's driver-core-next with the update in topology
sysfs ABI.

-V1:
 differences with RFC v6 
 * rebased on top of the latest update in topology sysfs ABI of Greg's
   driver-core-next
 * removed wake_affine path modifcation, which will be separately b2nd series
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

 .../ABI/stable/sysfs-devices-system-cpu       | 15 +++++
 Documentation/admin-guide/cputopology.rst     | 12 ++--
 arch/arm64/Kconfig                            |  7 ++
 arch/arm64/kernel/topology.c                  |  2 +
 arch/x86/Kconfig                              |  8 +++
 arch/x86/include/asm/smp.h                    |  7 ++
 arch/x86/include/asm/topology.h               |  3 +
 arch/x86/kernel/cpu/cacheinfo.c               |  1 +
 arch/x86/kernel/cpu/common.c                  |  3 +
 arch/x86/kernel/smpboot.c                     | 44 +++++++++++-
 drivers/acpi/pptt.c                           | 67 +++++++++++++++++++
 drivers/base/arch_topology.c                  | 14 ++++
 drivers/base/topology.c                       | 10 +++
 include/linux/acpi.h                          |  5 ++
 include/linux/arch_topology.h                 |  5 ++
 include/linux/sched/topology.h                |  7 ++
 include/linux/topology.h                      | 13 ++++
 kernel/sched/topology.c                       |  5 ++
 18 files changed, 223 insertions(+), 5 deletions(-)

-- 
2.25.1

