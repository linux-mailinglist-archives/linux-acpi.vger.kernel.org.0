Return-Path: <linux-acpi+bounces-8963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BE9B08E7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EB51F22C46
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B243166F33;
	Fri, 25 Oct 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETOhtiKh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6521A4D1;
	Fri, 25 Oct 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871458; cv=none; b=lgR7Mm+WBPiIYsHduOfpTsTPkn0drDWVnReX3OeGAnp+Gg7FKi1lWJUWx5Hkdr2RX6gGbGGP2FZarOFQhDyCZs1SzHc3UV5QiadlYTm/rbwzzxTQf6S7mGz0yjT8JOrD7dgYQfs0ZwpUkTKf1LkggZqzr2sV/1s2Avb2umep6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871458; c=relaxed/simple;
	bh=Fi11uiXIQ+iNyojKutyX4w7orO4RUqctsjHq2NJr7EA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t0O6ys7Q596seaQ1gCNvjTYKj/2sD3JX6qoR0zR96n4YUJ6Xk3q4U4ugPDymfiGwJ2OIvHnlAwStrpof+VidcyS7XJQ/jWuSUPViVVA3wCL4kfUvj8ZSVnfVeW9KH2l6gjEX7UdNvApi3qblZREHlS8/m7z1Rts3UITAmxawE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETOhtiKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57698C4CEC3;
	Fri, 25 Oct 2024 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729871458;
	bh=Fi11uiXIQ+iNyojKutyX4w7orO4RUqctsjHq2NJr7EA=;
	h=From:Date:Subject:To:Cc:From;
	b=ETOhtiKhJcECkOBWApIkfsGMNyfmZtvZEIWbqjoJdlYPM0/pPrsC0+HHELse7TSK3
	 laZ8M24MDX5kw7pRkJPI19dy+Emhd24OQTOfHmNhlBuba0/37aWckt7Ioc1a1Ar2Wu
	 6TmKOrMZF8sDlAnGhCnk7J+HncwJxac2uKaz3J8y5OrRoLM6fK86RduvZ1zMHJrIa7
	 PhLLiKsOEjXRkR7fxPImTYSTNzT+gbsFDm2xvQI1cOPblV8o9fdN3s7XeOfZ4XBsH2
	 oEvlRD4Rpntwo1fsELvFhrxbWCWankw7jTGRUATAHtLmLz8TY75NEo0k+p1hVSgcvg
	 VA+74it8A7VVg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so1199528fac.1;
        Fri, 25 Oct 2024 08:50:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyWrPGFGu3Mj5XbrUz+CpDijjOj8A9FFIo/Q7Bc3pb7ztnLpP0ip+dmL0VPqYiMnREp5yzFdWHIT5a@vger.kernel.org, AJvYcCV7UkYrT5CvM1QTyAvmRVaPhlwrqLrtwBltfposaqMKUNnkD9vxXHMFGae8HvikXNkKNWqBYvMKD8GKprk4@vger.kernel.org
X-Gm-Message-State: AOJu0YymLGEJS4ks0C/0F2kbxhDzoprOWbYEXLsAvna3u3hGtV32geM9
	3pR7XkeC9FYQjgTOI3hebrk0mV7ejBDyEEuVsaobu0bycQYcsY5H0VSJMcAlmKBJQ24VSuaoeoK
	Fv2x6nAKCUzTcx4w0oeRjKbRvc6M=
X-Google-Smtp-Source: AGHT+IEexv+1+Np/f2c+G4k45uz21aAEHCVXbLx7OeEwEnn5lsuizjJKo8UnayxciDmSWeDhTX0jplzw4xBYqvqkaE0=
X-Received: by 2002:a05:6870:c1cf:b0:288:6d23:5f24 with SMTP id
 586e51a60fabf-28ccb6ad0cdmr10773896fac.31.1729871457680; Fri, 25 Oct 2024
 08:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Oct 2024 17:50:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9kJzKXGjF-q+r8NDTqYoDaa8J1cyOj=TRN-GMMHqiOg@mail.gmail.com>
Message-ID: <CAJZ5v0g9kJzKXGjF-q+r8NDTqYoDaa8J1cyOj=TRN-GMMHqiOg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.12-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc5

with top-most commit 1646a3f2b1bda03a763f7aecf83504144fb8bba9

 Merge branch 'pm-powercap'

on top of commit 42f7652d3eb527d03665b09edac47f85fb600924

 Linux 6.12-rc4

to receive power management fixes for 6.12-rc5.

These update cpufreq documentation to match the code after recent
changes (Christian Loehle), fix a units conversion issue in the CPPC
cpufreq driver (liwei), and fix an error check in the dtpm_devfreq
power capping driver (Yuan Can).

Thanks!


---------------

Christian Loehle (1):
      cpufreq: docs: Reflect latency changes in docs

Yuan Can (1):
      powercap: dtpm_devfreq: Fix error check against dev_pm_qos_add_request()

liwei (1):
      cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception

---------------

 Documentation/admin-guide/pm/cpufreq.rst | 20 ++++++++++----------
 drivers/acpi/cppc_acpi.c                 | 22 +++++++++++++++++-----
 drivers/powercap/dtpm_devfreq.c          |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

