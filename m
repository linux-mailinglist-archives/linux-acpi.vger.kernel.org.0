Return-Path: <linux-acpi+bounces-9456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CD9C2600
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 21:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D5328385B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710D1AA1D5;
	Fri,  8 Nov 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfVmydp6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B6233D85;
	Fri,  8 Nov 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096019; cv=none; b=bu9TMpDH9PCuliIqRywkHH8k+6+7ScmiL2lkjwYGqzlnQStzIwsFPVcfYqyK1dZil9Y84mw8Sha8wrE10qlpEn8RU0f+jua1tETzz+dWdmd2fi/vxIttXuTW6zyDfyyO2wCdY0snl8Ur7TIx1oR7c5/R6j2rNLZ/aXWQMe7SbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096019; c=relaxed/simple;
	bh=je+69nRk//qJ8V1a76UbIwfeYsc9692V/mShvQRGwwo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n12aB9KjuvdKpu7Awz0ZhJoiQonF7o40rnboJX58AXtZiTUFvHHN5jLywTVob3bueEWZJRcxqo2pKv1e8aj1Ox1452Jlaqqb6+u4fShMskLusirZ6Zjfaas4Fbj1yi3IG/eyGla9wM96Cpv97+zJXGMVuW1nDE9WAaDqJpBCh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfVmydp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A287CC4CECD;
	Fri,  8 Nov 2024 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096018;
	bh=je+69nRk//qJ8V1a76UbIwfeYsc9692V/mShvQRGwwo=;
	h=From:Date:Subject:To:Cc:From;
	b=PfVmydp6jujbO+jV/L3eluozKVD9O0BwZQ0kpdEW6+eQGj/y1Wa64AizNXG7UEcqD
	 5Zr+CGNsQ3WkuIS6mMsWRwhyxU8SYN032pvzXlaf7kGTZvKWysnOGofZ+v+7TOuspC
	 bgHKJR+8zcyJ/eMMzkw0cJcBRIjgymYUATfkVGM9ChQrwsnN+mi/fq/uTyXPgRpZ+e
	 WmoS7CyxUwJ0wRfhLrqJl6legpDzy/ekoJF/43LpQig4lfPaBuW/vSb5O834gdFM+1
	 eXnHd2HtDsUjn58KNhJmpixqmiCL2CfDHTaGciBoC4SC4V0rurq7w1hwG6efW+CvMX
	 ogpHVXkwEt4QA==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so757608a91.3;
        Fri, 08 Nov 2024 12:00:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVana7Q2WhirUmxfCkVqnsRh8uc6JVgSIx2JWYPVqWnWT98O+a1tPq+gNew9UQz6WtKikSDh2UIpJI=@vger.kernel.org, AJvYcCW2YZZUa9CUaHgeD6HRfnI0bNmF0moQ8VfzKyncyGoqbC7XTfdLvisGeaToht1ECXUI0js9wHMZlgD2Hvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCiOqe30pjXHb7h30a6sErN9pEcPATqb5D/h1pA44GRzd4Ot0
	eyfny1Cne5jX38gE+8BW1CVnug89Nxmsv5YvnRhMOTYqUeBH46foD5fJsHGIAu9/2Ra8y0Nu+wf
	auy9x7PcrdIEcw340PifQo6NadT4=
X-Google-Smtp-Source: AGHT+IGuWMVcvjSC6bDG4yq9S1/S4bDLEa1chKrQ/sbgcATQv+qKiDyq6G69HUT6SVxV8jSufGw2kmUyXLjOq4eelCI=
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id
 98e67ed59e1d1-2e9b16ab979mr5281785a91.20.1731096018256; Fri, 08 Nov 2024
 12:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Nov 2024 21:00:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iiZQV=G_ZTomtK5isPEQFJXmD+wzztDSvumcx56uSw+g@mail.gmail.com>
Message-ID: <CAJZ5v0iiZQV=G_ZTomtK5isPEQFJXmD+wzztDSvumcx56uSw+g@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.12-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc7

with top-most commit b79276dcac9124a79c8cf7cc8fbdd3d4c3c9a7c7

 ACPI: processor: Move arch_init_invariance_cppc() call later

on top of commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230

 Linux 6.12-rc6

to receive an ACPI fix for 6.12-rc7.

This fixes the ACPI processor driver initialization ordering after
recent changes to avoid calling init_freq_invariance_cppc() too early
on AMD platforms (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: processor: Move arch_init_invariance_cppc() call later

---------------

 arch/arm64/include/asm/topology.h | 4 ----
 arch/x86/include/asm/topology.h   | 5 -----
 arch/x86/kernel/acpi/cppc.c       | 7 ++++++-
 drivers/acpi/cppc_acpi.c          | 6 ------
 drivers/acpi/processor_driver.c   | 9 +++++++++
 drivers/base/arch_topology.c      | 6 +++++-
 include/acpi/processor.h          | 2 ++
 include/linux/arch_topology.h     | 4 ----
 8 files changed, 22 insertions(+), 21 deletions(-)

