Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472D03277D0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 07:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhCAGwK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 01:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhCAGwF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 01:52:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D3C06178A
        for <linux-acpi@vger.kernel.org>; Sun, 28 Feb 2021 22:51:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id i14so8807061pjz.4
        for <linux-acpi@vger.kernel.org>; Sun, 28 Feb 2021 22:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqYwd+HQ765ezIeB0Bc/wTGpv0fipfbf8xfki7p6edQ=;
        b=Y631LNIj8XPs2GZZlzOu/pCAPkeV03yi0tSc90ZFqdWNq4MwxG2RTvBVvVI7L1qhLr
         DvAwJrrisVMtoRu9qYW0NODodR7cn0ldGEeIt5YpsHOyzJvEQ/Oig/cK4ucYwkVN9row
         ase1SDeTqqe3UZ5a66nc1bl9NZeZNErYMsQbajplFOmEw+rEFNg1uHE9Kh1kMofQOZWs
         E0L4wOnNiDQmCcYKoaB4apAqviTyz95oO3XfPlUhMeApoWbiasUEybs3nAoS/eYGD/KB
         qA4ZK7bL8Vf9mWEIlM1kwRveM0x9KHA6EW2B8gbovP2pjL73L5vTnmbRRQYfzfXcK7TK
         gnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqYwd+HQ765ezIeB0Bc/wTGpv0fipfbf8xfki7p6edQ=;
        b=OhJkZxQNG+Auxrc0UhHl87I2O4LJXbvclldjmkh7f3HbZh1aY04BXi7l2X3HzIwaFa
         FSZb6blj6zS69vml3QcpqLjzTX4RX+70efcBkY7UbQxra+FS6TsQgoi3zvBy/WI4+9YS
         uZ+M7AAXTH9TZff7hiDaBSf1Lfd2WH5IbLwHxyCWQMvQM+E9JpuP0D+qFJZJdudl1pij
         XCaL6AtfUc3aw0emrlFOki1pO8Nbx1KFPvcAHbj99MydRIlqw4DsujDE6BvKyo7N+0Ml
         R+fSpI4WiUvZYvfzJ6uYml2c5q5qR6o1fox72EKxHW1l5Nsqq9J9iq5Zq4kb18F97D9q
         CGQQ==
X-Gm-Message-State: AOAM532fhPiAYtd1f8ju6jOykSfMrqXgDXBfepbHNVTKAX+KGQ2kStBL
        8gzzhDMz6MlsbWaSirWPZg0XkA==
X-Google-Smtp-Source: ABdhPJyyeDkeZLl+9Bb9rZkhCqorIxui0T4q6log1k/2GJaVJJkHpEqq2xxfCVbgDiTyFMHDKRdJNg==
X-Received: by 2002:a17:902:ce8d:b029:e4:bc38:c4 with SMTP id f13-20020a170902ce8db02900e4bc3800c4mr1231327plg.48.1614581483871;
        Sun, 28 Feb 2021 22:51:23 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id x23sm16104211pff.133.2021.02.28.22.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 22:51:23 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
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
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/2] cpufreq: cppc: Add support for frequency invariance
Date:   Mon,  1 Mar 2021 12:21:16 +0530
Message-Id: <cover.1614580695.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

CPPC cpufreq driver is used for ARM servers and this patch series tries
to provide counter-based frequency invariance support for them in the
absence for architecture specific counters (like AMUs).

This is tested by:
- /me with some hacks on Hikey, as I didn't have access to the right
  hardware.

- Vincent Guittot on ThunderX2, only initial testing done.

- Ionela Voinescu on Juno R2, though she tested a previous version of
  this.


This is based of 5.12-rc1.

Changes since V4:
- Move some code to policy specific initialization for cppc driver.
- Initialize kthread specific stuff only once in cppc driver.
- Added a kerneldoc comment in cppc driver and improved changelog as
  well.

Changes since V3:
- rebuild_sched_domains_energy() stuff moved from arm64 to drivers/base.
- Added Reviewed/Tested-by Ionela for the first patch.
- Remove unused max_freq field from structure in cppc driver.
- s/cppc_f_i/cppc_freq_inv.
- Fix an per-cpu access, there was a bug in earlier version.
- Create a single kthread which can run on any CPU and takes care of
  work from all the CPUs.
- Do the whole FIE thing under a new CONFIG option for cppc driver.
- Few minor improvements.

Changes since V2:
- Not sending as an RFC anymore.
- Several renames, reordering of code in 1/2 based on Ionela's comments.
- Several rebase changes for 2/2.
- The freq_scale calculations are optimized a bit.
- Better overall commenting and commit logs.

Changes since V1:
- The interface for setting the callbacks is improved, so different
  parts looking to provide their callbacks don't need to think about
  each other.

- Moved to per-cpu storage for storing the callback related data, AMU
  counters have higher priority with this.

--
viresh

Viresh Kumar (2):
  topology: Allow multiple entities to provide sched_freq_tick()
    callback
  cpufreq: CPPC: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |  10 +-
 arch/arm64/kernel/topology.c      | 105 +++++--------
 drivers/base/arch_topology.c      |  85 ++++++++++-
 drivers/cpufreq/Kconfig.arm       |   9 ++
 drivers/cpufreq/cppc_cpufreq.c    | 244 ++++++++++++++++++++++++++++--
 include/linux/arch_topology.h     |  15 +-
 kernel/sched/core.c               |   1 +
 7 files changed, 377 insertions(+), 92 deletions(-)


base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
2.25.0.rc1.19.g042ed3e048af

