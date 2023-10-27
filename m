Return-Path: <linux-acpi+bounces-1044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C947D91A5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAED1B20A19
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E524156D7
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zl3P/gHp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB901171E
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:04:09 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D71B6
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso13757335e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393845; x=1698998645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boXAGtuda+Qb9m4tektze7XbzOBCPPY4QNhYroPvhtw=;
        b=zl3P/gHpDw0RPFvixqZOSnOTWc94wvoSnLV5QwtVI0dzs9bDhV0MtGjCNcEH1MUgqz
         uV7T8Sr0/odz/xFTVsIK8ulhrNDaad6kxHlG4m86itcPb3NxuPFie0aFC7XDolTDDEPD
         RTUDWaRxybH9ik7xHI+3ASPuyV6z7LDT3xt5t40UP7ZoN7EUNfji3/X/Wad2KQ6igHCs
         uWm+8eJBuof3rht+Bvs6lNpvkbSXYWZ5A2U+6TYpR08GFI2bLKPmE1BBZCqXqQ3PS4DT
         3/HkKLj1NiwawMkRpD2O6nHCprEvoDko0e1dXJ4Zd5s4I8W7MLxFnGswa7T8oofj+FkA
         w9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393845; x=1698998645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boXAGtuda+Qb9m4tektze7XbzOBCPPY4QNhYroPvhtw=;
        b=dzRHFD9cOj3BYiZetBWRclRDWSm3WSBVVnEr4YniCmi6gcZUTQj5pLHDPGu8cpMruo
         Bl46bpc/+QWPM5eLR5E0kQLSjqPCE40VH8Lw+er6QDyA+0Aoh9sAc6U0eNW4mGTrwEw0
         BQoqa9R+IOKtrGeg5Jc9G7A98mWdWnDDODCZl23ecPANPZ3LyrIodxJeRjD/thyLCcOB
         b6O5G+/+YWF6OqP4MwI5cazmhChDdxPF0xsJM3o3GllgE/M+JNfiKeHRZhvPeDLQIPvb
         NarRxACqAaA9q86RzjSsXMoD8BSj/V5K+FgrEl/+LVwAKbZDYSeLj7Om6cMwZ8FxrMAq
         Vs7Q==
X-Gm-Message-State: AOJu0YzS6P/4t0hwY7nKcIfjoi5uPnlQBMkVnTGbs5IJkYfMBcVoBXTi
	reuIaQhPHyuZ/nXvMsLtbyWNfg==
X-Google-Smtp-Source: AGHT+IH55gRvNIIGzxY2wtfBzfKIjKSV3fYf5Htk7gWA3H0RGtGe6nmb/WOdKqFqMmC7RaRaxT+LWQ==
X-Received: by 2002:a05:600c:a44:b0:3fc:dd9:91fd with SMTP id c4-20020a05600c0a4400b003fc0dd991fdmr1629085wmq.40.1698393845086;
        Fri, 27 Oct 2023 01:04:05 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:04 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	viresh.kumar@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/7] consolidate and cleanup CPU capacity
Date: Fri, 27 Oct 2023 10:03:53 +0200
Message-Id: <20231027080400.56703-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).


Changes since v3:
- Split patch 5 cpufreq/cppc
- Fix topology_init_cpu_capacity_cppc() 
- Fix init if AMU ratio
- Added some tags

Changes since v2:
- Remove the 1st patch which has been queued in tip
- Rework how to initialize the reference frequency for cppc_cpufreq and
  change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
- Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
  of the AMU ratio to be done when intializing cpu capacity and
  capacity_ref_freq
- Added some tags

Changes since v1:
- Fix typos
- Added changes in cpufreq to use arch_scale_freq_ref() when calling
  arch_set_freq_scale (patch 3).
- arch_scale_freq_ref() is always defined and returns 0 (as proposed
  by Ionela) when not defined by the arch. This simplifies the code with
  the addition of patch 3.
- Simplify Energy Model which always uses arch_scale_freq_ref(). The
  latter returns 0 when not defined by arch instead of last item of the 
  perf domain. This is not a problem because the function is only defined
  for compilation purpose in this case and we don't care about the
  returned value. (patch 5)
- Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
- Added reviewed tag for patch 1 which got a minor change but not for
  others as I did some changes which could make previous reviewed tag
  no more relevant.

Vincent Guittot (7):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  26 +++---
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 +++++++++++++++++++++
 drivers/base/arch_topology.c      |  55 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 134 ++++--------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 +++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 221 insertions(+), 153 deletions(-)

-- 
2.34.1


