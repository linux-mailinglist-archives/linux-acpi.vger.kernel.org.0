Return-Path: <linux-acpi+bounces-9763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042439D64DD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6030DB21E16
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276518593A;
	Fri, 22 Nov 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdprW1Me"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610715F40B;
	Fri, 22 Nov 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307212; cv=none; b=aEZtWP4a8Vqr9xhtQuW9zHspUVcZGMcvTNrO3J/DcsrNdXsfyeTaDMcUUFDJDlpCcnXlGb52nUU6dAHoE/9xEcbmk1CM62JoSVwhe3IheEwVnuwYNFCC1TVTZI8aHr5JUAf9i5oTgdLHq5h/w1Vf7EoJwkcQG3UU2hpTqus0yQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307212; c=relaxed/simple;
	bh=6B1BK6wIWPggwIoC0MMHmHuadgqKGKX5TpZp45ctLkA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D2lvC/fcocMmXzUZhGehMQOGSTEDq9f4y9K5jLqEp6a87nb7/qSimOQDHL5ZnrGVEY3LE9gZ1DgiUt/Djs6MXb94MJzbqtJhq2s4hbdaI0SWQXPxNEY4Wyg/FGR7yLp0wnK5FQDCweJbHM+NpPKKTIJYrmPHwiHuXHECh8tgV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdprW1Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F74C4CED0;
	Fri, 22 Nov 2024 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732307212;
	bh=6B1BK6wIWPggwIoC0MMHmHuadgqKGKX5TpZp45ctLkA=;
	h=From:Date:Subject:To:Cc:From;
	b=EdprW1MeXYp3RkQlp1o7otuzojZq5RHMB8qVGAA3HKwV0DsCw2Vw05hLA0GzBf8Hq
	 V82AYr9Dk68NnRbT7eLK7OMjs6RdEQD2hgSEpjdDrKPpKL7Tv3Bm92uHufzj3drNoP
	 5gzoVLcjr/1x33jRcgDYvuMXU0kxxRadlf4/wb1V1KTxTYmzRAoziS4ZDjT6qgYiaa
	 ZdjKhN5xbQD33BFKGJYA0yDW1PZdkotmWkrCVKWPzRrkU4ZHElzL+7s8koxMmjU0au
	 bBE29i9g1xviKzmc1y5y9lX3lBaR9tKQgokA+C0CmAA35oypGWdVuCifnxhjDiSXpQ
	 RH3KKnt7PsbtQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2689e7a941fso1667607fac.3;
        Fri, 22 Nov 2024 12:26:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFcc5IU7Ibtb/flX1I3nZIIgPiegJusK1+Eo+L4ILrEU73mM4DbDHT1JoN0zblKL+UVZ/moaVo1n3tklf1@vger.kernel.org, AJvYcCVcMHVpLMywoXUrT5uGw5juolMqJPROw7GnUQDTUBrdW5r5Szoj0aiBf8vydgK3PBl98zBeV3FRtQ+N@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcXrUl/CUlaF4HGm3sg3iME9EjCIbK2smmSUBhfFxOqt60Joz
	CKUTOCHGmUaUcfbRc9V7TPRsCzVr10Ni20hGk2MX4AQfJ3BJYeNzs7ILAl44hwZmeeXzRKhBljw
	+MsRc9HpcdFSn52wV8JD0spaALZU=
X-Google-Smtp-Source: AGHT+IFOwzXdy8zDTCELl4+jkEyaKqTWdZcYugf+a20MywIWgLg2h5okyVyRJsr1ECrMmSuOcKbKCjWFqJpaC3x1v1Y=
X-Received: by 2002:a05:6870:330f:b0:296:e50e:628f with SMTP id
 586e51a60fabf-29720e7b0fcmr3306019fac.36.1732307211618; Fri, 22 Nov 2024
 12:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 21:26:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hD-P3fK4qiZeu3xqnV120UtBiiH6UN4PE5xBqQfOZQmw@mail.gmail.com>
Message-ID: <CAJZ5v0hD-P3fK4qiZeu3xqnV120UtBiiH6UN4PE5xBqQfOZQmw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc1-2

with top-most commit f3e66e78f2ecb18a55374f7d58030556b751dd79

 Merge branch 'pm-cpuidle'

on top of commit ad52c55e1d3a2e85e05e47b6d7056c662a9c0246

 Merge tag 'pm-6.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.13-rc1.

These mostly are updates of cpufreq drivers used on ARM platforms plus
one new DT-based cpufreq driver for virtualized guests and two cpuidle
changes that should not make any difference on systems currently in
the field, but will be needed for future development:

 - Add virtual cpufreq driver for guest kernels (David Dai).

 - Minor cleanup to various cpufreq drivers (Andy Shevchenko, Dhruva
   Gole, Jie Zhan, Jinjie Ruan, Shuosheng Huang, Sibi Sankar, and Yuan
   Can).

 - Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check" (Colin
   Ian King).

 - Improve DT bindings for qcom-hw driver (Dmitry Baryshkov, Konrad
   Dybcio, and Nikunj Kela).

 - Make cpuidle_play_dead() try all idle states with :enter_dead()
   callbacks and change their return type to void (Rafael Wysocki).

Thanks!


---------------

Andy Shevchenko (1):
      cpufreq: loongson3: Check for error code from devm_mutex_init() call

Colin Ian King (1):
      Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"

David Dai (2):
      dt-bindings: cpufreq: add virtual cpufreq device
      cpufreq: add virtual-cpufreq driver

Dhruva Gole (2):
      cpufreq: ti-cpufreq: Allow backward compatibility for efuse syscon
      cpufreq: ti-cpufreq: Remove revision offsets in AM62 family

Dmitry Baryshkov (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P compatible

Jie Zhan (2):
      cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
      cppc_cpufreq: Remove HiSilicon CPPC workaround

Jinjie Ruan (5):
      cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()
      cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
      cpufreq: mediatek-hw: Fix wrong return value in
mtk_cpufreq_get_cpu_power()

Konrad Dybcio (2):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X compatible
      arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

Nikunj Kela (1):
      dt-bindings: cpufreq: qcom-hw: document support for SA8255p

Rafael J. Wysocki (2):
      cpuidle: Do not return from cpuidle_play_dead() on callback failures
      cpuidle: Change :enter_dead() driver callback return type to void

Shuosheng Huang (1):
      cpufreq: sun50i: add a100 cpufreq support

Sibi Sankar (1):
      cpufreq: scmi: Fix cleanup path when boost enablement fails

Yuan Can (1):
      cpufreq: loongson2: Unregister platform_driver on failure

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   6 +
 .../bindings/cpufreq/qemu,virtual-cpufreq.yaml     |  48 +++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   2 +-
 drivers/acpi/processor_idle.c                      |   7 +-
 drivers/cpufreq/Kconfig                            |  14 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                     | 136 ++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/loongson2_cpufreq.c                |   4 +-
 drivers/cpufreq/loongson3_cpufreq.c                |   7 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   4 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |  28 ++
 drivers/cpufreq/ti-cpufreq.c                       |  10 +-
 drivers/cpufreq/virtual-cpufreq.c                  | 333 +++++++++++++++++++++
 drivers/cpuidle/cpuidle.c                          |  10 +-
 include/linux/arch_topology.h                      |   1 +
 include/linux/cpuidle.h                            |   2 +-
 19 files changed, 517 insertions(+), 103 deletions(-)

