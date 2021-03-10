Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DC3334D9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 06:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCJFYF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 00:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCJFXl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 00:23:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C9C061760
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 21:23:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so6836819pjb.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 21:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNfsTKHRqikZKDJpk3ZLLd8WdOKtskH70hYikTl5M4=;
        b=lYvgYuHQ+43IDf50Nw1EmBSIyL7fXfv4Nr3KnquWOQck0aXiXI0d4TTDuMmJ5K/8ls
         gT2RRp5DI35ogBnizM4GiIE/LF4cTmFh9/3vyHwU/OaX8HMhGlxkAVxy1T54sBYbTy7o
         uPcjlLO8QPgoLl/3mh2tZyVwEkY3TqgtZYFMvOiF+IXDX10DQzE5Qm4rRrG+evkDYR+q
         2Dgt9UNJ1m59MfPiMwGxHFxKJrR1bR1r0I6NU0W7JkXfXOPBXpbb9xfuWTzx4qTy/U4z
         g7lQ27S/9Ae58/q69oDcKy25XqJmIBTx0/sR3R8JjbDF/+LL7c620nyyEirBH4a9Tzl4
         0kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNfsTKHRqikZKDJpk3ZLLd8WdOKtskH70hYikTl5M4=;
        b=BV8ETUtYQK+FndXzVW82fzmTTwVhRtXBh5xmult+fjz9U/d1WUfrl89PuKBSvfcUUB
         VT/ohZUJlqdPytjiTHLlkJvf+Wr3cXDY0Bn1KNM5f7lbhn5kPzDbMfa7ohWIbHGSeIbA
         Ot7cBS8F9z6uiXxi0oQ7kAf8UTQMuwf+m4OhGgaQcdQvkktg8H7O7Ger88Pgw5dcdCTo
         mNyLd/m2SPlRNxUVsHcUuPrJVWS9RLKARGA+DxII9YdbtzpoYzmhB23qCangD2e1pmqD
         B9i6caW9UtKUnLAqmGkt2Jccx9KoPQc+J28VB91yy3gptHqCGjw3YE0Iwy22hK5ZMRuM
         uU6g==
X-Gm-Message-State: AOAM531RzqMFNf1wbDf7vbJS3laFjSX7Y8zD03K0cfRrPbpQc5XPMYdO
        NX7xhTk1Iz8amGhc8cMTJjNAIFCnTSsDVw==
X-Google-Smtp-Source: ABdhPJzuL00Zp+tBMXN7pBV0GvYvFgNsl98h+A5+Yaf3P8yLznthV781A8esUxFwRezpcnDhfzruig==
X-Received: by 2002:a17:902:b08b:b029:e4:deb:69a9 with SMTP id p11-20020a170902b08bb02900e40deb69a9mr1241127plr.35.1615353820285;
        Tue, 09 Mar 2021 21:23:40 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id u9sm14776075pgc.59.2021.03.09.21.23.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:23:39 -0800 (PST)
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
Subject: [PATCH V6 0/4] cpufreq: cppc: Add support for frequency invariance
Date:   Wed, 10 Mar 2021 10:53:22 +0530
Message-Id: <cover.1615351622.git.viresh.kumar@linaro.org>
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
- Vincent Guittot on ThunderX2.
- Ionela Voinescu on Juno R2.
- /me with hacks on Hikey, as I don't have access to the right hardware.

This is based of 5.12-rc2. I will merge these via the arm-cpufreq tree
directly.

Changes since V5:
- New patch to rename freq_scale to arch_freq_scale (Will Deacon).
- Separate patch to export arch_freq_scale and helpers (Will Deacon).
- Some improvements in the last patch like commit log, moving more stuff
  to policy init, new fie_disabled flag, etc. (Ionela Voinescu).
- Added Reviewed/Acked/Tested-by tags.

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
Viresh

Viresh Kumar (4):
  arch_topology: Rename freq_scale as arch_freq_scale
  arch_topology: Allow multiple entities to provide sched_freq_tick()
    callback
  arch_topology: Export arch_freq_scale and helpers
  cpufreq: CPPC: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |  10 +-
 arch/arm64/kernel/topology.c      | 109 +++++--------
 drivers/base/arch_topology.c      |  89 ++++++++++-
 drivers/cpufreq/Kconfig.arm       |  10 ++
 drivers/cpufreq/cppc_cpufreq.c    | 245 ++++++++++++++++++++++++++++--
 include/linux/arch_topology.h     |  19 ++-
 kernel/sched/core.c               |   1 +
 7 files changed, 385 insertions(+), 98 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
2.25.0.rc1.19.g042ed3e048af

