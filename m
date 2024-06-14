Return-Path: <linux-acpi+bounces-6427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E99908C77
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579D71C233F8
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBF63B;
	Fri, 14 Jun 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR1kFTle"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F36FB1;
	Fri, 14 Jun 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371845; cv=none; b=PsmFdYguVOSqhZlxUSDN6GYytYrwxpjhwSR2/XkcrnmAu+6pwx2n5uXdnAba8zE8D3IiCa/TpeWBDdiHMpy5Vtd7ia8XAzZvfKwgU54VQWDdLDFj7vUwaVPMqZE5sjnpj7S/oSasEvQb3Bjz19bGMDOmrHyacvd2UOaC/ya0Lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371845; c=relaxed/simple;
	bh=vL1psw2K7KdLQoefCcMZmZk94P9CsVo4pPmcu7NaZsM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DTDAHfSUHwPqTe2N1LWGkmcoy91OGyZhx3BLDm4fw3/G5PPgzceZ1Baj1f/lHLzPZnSDo81wzR5VL1WdoOf1Vk3kHDO10omBWuEBDx8wxVzXJc4nX/aUTG/UBgFy5A1fkjbxTQn6IkyvVmMJI0vK7TzHQuDGHIFGCEiNU/yhH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR1kFTle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6AEC3277B;
	Fri, 14 Jun 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718371845;
	bh=vL1psw2K7KdLQoefCcMZmZk94P9CsVo4pPmcu7NaZsM=;
	h=From:Date:Subject:To:Cc:From;
	b=eR1kFTleqEsD6L++fxYetDKgLK7pUf59TOWf7QZZSMFaTKiOeBsctgVQNlcM4LoKx
	 moZD17o+Id5R2v2vFHG72LhluQENVt36maJBQ4/wD/l0UBp4EHjOhF1ikDpAve+VUL
	 UHs9z0ykcT7nt5cDYx0ZTX8DAj2EW0NoUzVCTr3vQClRL7BG/iTqBvFR8H6rhc0VxT
	 li7QrLnuVAS6XLmRlUEwcbtOHUFoISJzKnNRBzTp+kLqfZL3S3zO+ExZDY0mE2QgDt
	 V3A0wtZhRzN7TIKPjxqnnK0xRxOZ1FEMfLn+BSUyVLebhV6T2fHYVagQhkNCXzeKGH
	 kMj3dKvetMVBA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-250aa23752dso258479fac.3;
        Fri, 14 Jun 2024 06:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/xrZ1M35XARbtQvSF2RuiYvb3r7h8jM0Oz8C0gjE6DKRhfnIVENyfwT+bUwrEAI703LF/ug0iraUDIJryYjUQyLPHVqO5E5uX6ZLPSUjO+rBvco123kiWKi+UrbFoYNcfSVYaCBg=
X-Gm-Message-State: AOJu0YzhjnkbYooDLPRjz3/219RptmnY9VIiYJXV5JgW/chC2FPuOnyg
	qge1R7Pv2FvVYIrh4UP4eZJ3sJ2fxJTN5oFUzFdzQomdbDC0ukoA5ZGfFXVOSyF8NwTIsh4xr3C
	1Yj8Yq55QAN6fSitlm94rfNj4cfk=
X-Google-Smtp-Source: AGHT+IFH1reZfTyhI8sy1nuFdZvL6mvMFfVHqzNOnLumcmjRb49O7YFIKA9cBFHgWKEc6XwXaHRJTikZmbDgQjar+I0=
X-Received: by 2002:a4a:d027:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5bdadc10d0amr2805968eaf.1.1718371844318; Fri, 14 Jun 2024
 06:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 15:30:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hki_YFWhBU8vZ9eubo0yVhDGRCx893Qd21UENaNXfaNA@mail.gmail.com>
Message-ID: <CAJZ5v0hki_YFWhBU8vZ9eubo0yVhDGRCx893Qd21UENaNXfaNA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.10-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc4

with top-most commit 04f82fbb8686995f17b51ccd23c10fee12f1a2fd

 Merge branch acpi-x86

on top of commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670

 Linux 6.10-rc3

to receive ACPI fixes for 6.10-rc4.

These fix a recent regression in the ACPI EC driver and make system
suspend work on multiple platforms where StorageD3Enable _DSD is
missing in the ACPI tables.

Specifics:

 - Make the ACPI EC driver directly evaluate an "orphan" _REG method
   under the EC device, if present, which stopped being evaluated after
   the driver had started to install its EC address space handler at the
   root of the ACPI namespace (Rafael Wysocki).

 - Make more devices put NVMe storage devices into D3 at suspend to work
   around missing StorageD3Enable _DSD in the BIOS (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: x86: Force StorageD3Enable on more products

Rafael J. Wysocki (1):
      ACPI: EC: Evaluate orphan _REG under EC device

---------------

 drivers/acpi/acpica/acevents.h |  4 ++++
 drivers/acpi/acpica/evregion.c |  6 +----
 drivers/acpi/acpica/evxfregn.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/ec.c              |  3 +++
 drivers/acpi/x86/utils.c       | 24 ++++++++-----------
 include/acpi/acpixf.h          |  4 ++++
 6 files changed, 76 insertions(+), 19 deletions(-)

