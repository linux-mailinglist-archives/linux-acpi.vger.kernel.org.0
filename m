Return-Path: <linux-acpi+bounces-740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC87CE2E0
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6849B280A94
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5683D38D
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f86YaXtM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FC3C681
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 16:25:50 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F64136
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c53c5f7aaaso28644981fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646345; x=1698251145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBPvPoGvatc00L33SJsgf3xSxpMurf+haw6UVXLiWPI=;
        b=f86YaXtML514/6hcHcHG494U3VcI39PTNleMOokXtthRJSlhtK+m9+ZWKLuZhxoFam
         S4/WuueLWNQMmZF8PQlGrEBQVj27gTHcuM1YYzw4fUvTE6h1GPa8NDaP7aBP66rzFzsh
         l4Ii8o15m9reNVYYYIXHYJunlKa3MfimluOJAWkpZi9oCAeGNZZXHgYOSkRm6edog/8F
         fHxLWPsjp1Pj8T9jMqFQRFwXRIKAZriuhp9uDPlUVSkLhxZgftsgPtaLFr8vgg2GPzY4
         gSyvcZ/fh+JdFnTmP1+N1NZWmj2hA8eKOsY5UrEsVYGgk299pMiZlAdFHvfEBgqaBV3w
         0q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646345; x=1698251145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBPvPoGvatc00L33SJsgf3xSxpMurf+haw6UVXLiWPI=;
        b=Y2YtAzZ+Iv9TfVmCkpXcNnDl2vput5tnnHTFDsdTbZHRu6p1TI1MLmEXH8kZWOZmnw
         QMLk2Hw+n9cEu92bG6jQUuDTef9J4oaxRM0rtWCpJSjubLsOJHNyCBHvzHDNo9QS6oW3
         D3veWAYSM+eIPB5oBQVqQRsoopRnrFWnJD8PCXU+vtRoxek1IhE9Cra7s6a6RugvddIb
         9vNSztQVKfd+cE6c++55AlAwXv2lH5KCAIA2jE43QcyJ7oc0yEWacBvW+P684emlZKqA
         BnCTcj+tQG+aPv1yDwJs3J8PtUemyDwkFaDOHHCBRRJXhcL0zD/5toGvvkZ6S9Ke6KHd
         setA==
X-Gm-Message-State: AOJu0Yx84DrC4hjKwS95NGqj1VdJ3cwDI7X18IMbLc5g1GEc1aAmCrpw
	fT3gebUoLaATXiGomEed9BKxcg==
X-Google-Smtp-Source: AGHT+IGH+vBGDOxCQ/foE4RgwBOMrvwQGARWZwd5FKiVeXsCBR4rYrmOd1rONRCEvyTJKlIqnP29Cg==
X-Received: by 2002:a2e:800f:0:b0:2c0:a99:68e7 with SMTP id j15-20020a2e800f000000b002c00a9968e7mr4322747ljg.19.1697646344796;
        Wed, 18 Oct 2023 09:25:44 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:44 -0700 (PDT)
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
Subject: [PATCH v3 0/6] consolidate and cleanup CPU capacity
Date: Wed, 18 Oct 2023 18:25:34 +0200
Message-Id: <20231018162540.667646-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).


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

Vincent Guittot (6):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  18 ++--
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 ++++++++++++++++++++
 drivers/base/arch_topology.c      |  56 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 141 +++++-------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 ++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 225 insertions(+), 149 deletions(-)

-- 
2.34.1


