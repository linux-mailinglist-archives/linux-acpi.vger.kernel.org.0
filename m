Return-Path: <linux-acpi+bounces-13277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D109A9CDE2
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6133BE38C
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086D18FC92;
	Fri, 25 Apr 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUzN27iE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9046447;
	Fri, 25 Apr 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597815; cv=none; b=UHTqTWF4iumwVhjz/+HPOUF9OVb7Fp4DS0MEyz9YKpV6PEvalapukNChoixZrF2QNiKjzunS5aeOyQQf6zIM/wmoKtBPAeoD1f6lgTJeszB/Qae+Q9N8fpjEXnaS2Sjm9OTjQU0IvVTzC8WMI1CncSbC1fJsb2Yj2OHgRuz30eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597815; c=relaxed/simple;
	bh=8JW2vZqTEBXcaeQjmDTLoCd9QWwIOsH1ErInhCxEcUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kOuNfv9BG20RBpIrg8DYZuoQSqYgjYg6baiuX4wD8UjbFD2uWBX8CGRC3GZh/b3ApUNv5S/BbQNG5AX7CaQHpYqPwvsbJDKisoUU0jNHlCVOM86hqEYrkfyzoYGvk8EhvbELmw9N8JVrJa9Gy33yOsCPv+Xf10tHMYASaYCqD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUzN27iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8FC4CEE8;
	Fri, 25 Apr 2025 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745597815;
	bh=8JW2vZqTEBXcaeQjmDTLoCd9QWwIOsH1ErInhCxEcUA=;
	h=From:Date:Subject:To:Cc:From;
	b=iUzN27iEOLxf1h2S7k9dlxUS5jEzFerSbgJRM8GTBOVJqIk982S7a7Siw+4AYW7Qe
	 LpNC3VpjXPqFL5Nz0dUnZ26dvMPSJbXnZB3UqSbv7ysXSAVDd+wOKR5d9SSj9IvymE
	 FpMe3wWIdMdb1jSljtcGNwiVwArqC/NrJwTHi9vhwWufxUGsgOShVlGFZ6PPeuAwQO
	 NzT8yWDEQuNVZOE60ByRGqVrhJCjNYBVTzc81XdBLmyHuhdRRr260HKVp/2OimE22A
	 rHfI0Vw2KxBka/iWHwzLSb6/ZLZx3kNnJ5ofVBUafa+1+7yJiCa2xPSr+TAwis/F5g
	 kLnF4ttwWErRQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c47631b4cso1556707a34.1;
        Fri, 25 Apr 2025 09:16:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUifHwTYh7BM69UOctX1z/Ardbig1ECfTVsZPhCzD3U0VimRGtnmigR1SHJYzFUXDZ6pAYjs4uYWF5LIMPo@vger.kernel.org, AJvYcCXBtOvCLllT3NuGmM/HIrMAw+tbZnFSYng923QtKIjy+Tf/vVWUmbGdjgHFSbolMU/XtJsm6h6mfOQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMacX6N/7fUhKmTSkLgqAayTETedJQUn1gyaeKbEmzvDIVECJ
	GKM5hnYouLE65q2NzFpKBo3dQky/Pz377foneIajBikxTebVaUtmUkJOoLVTqxB/CicnHdpKVj7
	OjfmI7Y1tga7efRC4MwjNLU6ffjQ=
X-Google-Smtp-Source: AGHT+IEBTIyD7hhcKfoRUs9/MQH7opvPv05v33Y84BtrwnX+9H+cIU3lhNAPJSRsmKXrT6aeBC4jDmq+aAkw085da2w=
X-Received: by 2002:a05:6870:a7a5:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2d99de7e336mr1850172fac.35.1745597814257; Fri, 25 Apr 2025
 09:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 18:16:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3STvUcv15K4RhpNa9t7hZQ8nJGFfFD77WU-3-4X0zog@mail.gmail.com>
X-Gm-Features: ATxdqUG7WiELpCNi397MpmWhtNNmYphz9oOLJTgR9dpSMMaRmT2a3pq0xF4xajY
Message-ID: <CAJZ5v0i3STvUcv15K4RhpNa9t7hZQ8nJGFfFD77WU-3-4X0zog@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.15-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.15-rc4

with top-most commit 5786ef8ad8d4222fdc2e7cf65337880695cef60e

 Merge tag 'cpufreq-arm-fixes-6.15-rc' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 9d7a0577c9db35c4cc52db90bc415ea248446472

 gcc-15: disable '-Wunterminated-string-initialization' entirely for now

to receive power management fixes for 6.15-rc4.

These are cpufreq driver fixes addressing multiple assorted issues:

 - Fix possible out-of-bound / NULL-ptr-deref in cpufreq drivers (Henry
   Martin, Andre Przywara).

 - Fix Kconfig issues with compile-test in cpufreq drivers (Krzysztof
   Kozlowski, Johan Hovold).

 - Fix invalid return value in .get() in the CPPC cpufreq driver (Marc
   Zyngier).

 - Add SM8650 to cpufreq-dt-platdev blocklist (Pengyu Luo).

Thanks!


---------------

Andre Przywara (1):
      cpufreq: sun50i: prevent out-of-bounds access

Henry Martin (3):
      cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Johan Hovold (1):
      cpufreq: fix compile-test defaults

Krzysztof Kozlowski (1):
      cpufreq: Do not enable by default during compile testing

Marc Zyngier (1):
      cpufreq: cppc: Fix invalid return value in .get() callback

Pengyu Luo (1):
      cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist

---------------

 drivers/cpufreq/Kconfig.arm            | 20 ++++++++++----------
 drivers/cpufreq/apple-soc-cpufreq.c    | 10 ++++++++--
 drivers/cpufreq/cppc_cpufreq.c         |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/scmi-cpufreq.c         | 10 ++++++++--
 drivers/cpufreq/scpi-cpufreq.c         | 13 ++++++++++---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 18 ++++++++++++------
 7 files changed, 50 insertions(+), 24 deletions(-)

