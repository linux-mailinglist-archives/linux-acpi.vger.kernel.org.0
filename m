Return-Path: <linux-acpi+bounces-19677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BACCD764
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EF6B302BC42
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743F2BEFED;
	Thu, 18 Dec 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9PosWJj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A142BD036
	for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2025 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088303; cv=none; b=pqbi4n58/skzir4xXQVplqN9Vs4LXIRQy2PJRf/PlCHyJVOurLuV8Csj2H/1gy2o0P4sxOjOA51mM9eZ6sbstEmUxfMe432u0MFWfO9L22QXQwdaQq2PW+nNwiOePg0BFAllJg/tjEFJpNRohWzw6fkU3FWmts5FRFF1aHFPhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088303; c=relaxed/simple;
	bh=3ePV+3sRnR83TZIiS6AHywO8mupB/UBGmUQ1EodpoiQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F20MUjJ8jM8GHtcuiBfB+SIDX9WBwsvC5IxSU66a5c8tt7o++0JarI53paoivK1azIR+mqxe8BajBn6KpXF1HiEZG44PhMLJXQenNd7Utx+e61qq60jjopGW92kd/y2WQyUn0FhqdYnyJipI4kLtbXTOlwt2Uw61YrONE+llvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9PosWJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1F1C116D0
	for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2025 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088302;
	bh=3ePV+3sRnR83TZIiS6AHywO8mupB/UBGmUQ1EodpoiQ=;
	h=From:Date:Subject:To:Cc:From;
	b=t9PosWJjpRqp1maTyRSzJrr3sN8q7BGkfEFSjdOQF9WajNP+ZzqspMpenfrHYYoHB
	 C4YD7MbtYiORx+PD5b8RbmYFB5X8eW1vfk5hesVAInq4v1MLMzG1IUVohoPcU62a8m
	 voTvpiLwnqtn/M+GzJZ0/+kzbHlHS+dqaoxnfg3831t+O+JPac57ilD2/lgacv7HvU
	 hfuUuIzKtmJyEXKJfJh/yQDO+cByrp7MsdFhnppn7NE7p9e8+Bz3OQJRgRoSLquO16
	 x57RAyuhPknurEPBGcZYufF0YrAgAJotjyD6Xa6yjeAGCV8Sz1q4S5WR2ECuRcwwnF
	 CXiOh2hKYxK1g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-657a6028fbbso521551eaf.3
        for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2025 12:05:02 -0800 (PST)
X-Gm-Message-State: AOJu0YzQN6RlfUwa+rSoftApz0JzcEfWBtu80vZ3a/bh/nROoTGm8LHA
	Ti+BE03sKg1jxzohA4CiZmJElOx7vN1+zrAoB3mwVfk5pRJ5zNXkDREcenN+sZS7+uk0aOb4aRF
	/4cnZreNe2a0enqwvirlse51IGd+08NA=
X-Google-Smtp-Source: AGHT+IFEGfqpvQ5vmng7BzeGcanzt+hq+MaFF1zdaMsZ0INrxzwtPFGZhevcfzSbdpSUgkKyJ76HepPJajFdO8yHPCs=
X-Received: by 2002:a05:6820:2d8e:20b0:65c:f660:57be with SMTP id
 006d021491bc7-65d0eaa43abmr305944eaf.37.1766088301945; Thu, 18 Dec 2025
 12:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Dec 2025 21:04:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hDvMiDFZ1B_bcn1+bHBma0qtjw11rYJycV0JevK9DkbA@mail.gmail.com>
X-Gm-Features: AQt7F2qgOdenLuwl6JZ6wlGowjvdNioPA3KzIAWZ_XHUVhMnW6TOzd5YgG7ai7U
Message-ID: <CAJZ5v0hDvMiDFZ1B_bcn1+bHBma0qtjw11rYJycV0JevK9DkbA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.19-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.19-rc2

with top-most commit f103fa127c93016bcd89b05d8e11dc1a84f6990d

 ACPI: PCC: Fix race condition by removing static qualifier

on top of commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8

 Linux 6.19-rc1

to receive ACPI fixes for 6.19-rc2.

These add a missing PCC check for guaranteed_perf in the ACPI CPPC
library and fix a static local variable access race condition in
acpi_pcc_address_space_setup() (Pengjie Zhang).

Thanks!


---------------

Pengjie Zhang (2):
      ACPI: CPPC: Fix missing PCC check for guaranteed_perf
      ACPI: PCC: Fix race condition by removing static qualifier

---------------

 drivers/acpi/acpi_pcc.c  | 2 +-
 drivers/acpi/cppc_acpi.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

