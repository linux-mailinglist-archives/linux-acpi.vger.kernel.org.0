Return-Path: <linux-acpi+bounces-18877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2AC59EB7
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1703A9F57
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2B630DD2E;
	Thu, 13 Nov 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHrQS+sz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974327B348
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064860; cv=none; b=qgfyTTA1B4hTCDezs9WHpjPdCSNd2kIcVFmbcc3UT8RLeNDXTOrA5Qzkk18KaRg7Mwkq34G7eQcDQZAzZf/3CXXjnWST7VX6Td8PP1SQ2PUFCfumnP4YWViqAF5IWr9kz+5eOj1rVa3DWUNgkYHgbE7hwLIhmwrBmvLumXGkx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064860; c=relaxed/simple;
	bh=76EvaeQI5XEPFQQiNAA3g7E01+m/sCelT9LslmIdgDM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EfEuIUz8ERopqYd10y7EV/GUq5es/GnykfbyMxkC96nzuHWbdeEJ6muYIz1nePoszqeJyRGgQRztDD8pr0PNYOW0+2lAxMJLrtbTlffTJaTXrZwG8hSJ+LUEQNDP4hKTct4tBdndnKwX1CuUXJT3vljZmqM8hKZ2mzMtE01Fsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHrQS+sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F9EC19422
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 20:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064860;
	bh=76EvaeQI5XEPFQQiNAA3g7E01+m/sCelT9LslmIdgDM=;
	h=From:Date:Subject:To:Cc:From;
	b=pHrQS+szacBGnfLizjPD2mmqMXSTenGwugENXteV/+vAKPGnOZ/e5g7hs8zuiK5sy
	 rK9bFF4DNRypFFyYIgnhITPEdDZBUU1Zby1Uor2EPjwHfgAOXenMKC2PNLmsIEVHWT
	 sMN+0ndKBmvCBmCdABsz7mh+9ZFka+Lek6ZdjL3gbcxhf9ypgBzslgSUBf5mijkvUq
	 WCZ6QFnr8nzpiInwWp1iSTYbbG23odklR9w4DgoHj4+2fSRd6Q8tp6Ax7vYz2d091r
	 o2PZWpvSGfx7IqVM5VzoLozm00YOWRY9RjymHLXOd1ASmzzK31Pfz8nAkMIy4Q8CNx
	 ooTBVAyqmxjwg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c52fa75cd3so983055a34.3
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 12:14:20 -0800 (PST)
X-Gm-Message-State: AOJu0YxPSvNECiIEck0dlgVeSlo7So7Z4217/V40GMV/JH5gIYHH0zpk
	JROWOkbVTUZNOKxm5J5qGSKdkxGw4xYCUnBK7BQesiOyD2JU5J02xE85sC/cNMYiNorf9IA/TID
	yWwsNAUKM7QVoDzb06uWEzVAgboOshS8=
X-Google-Smtp-Source: AGHT+IEvaZ/Fzxot95Xje9kKzOAn5s6+MtCfOUZZiY70GMKlnN8bqrGa9rIlMPbfLcOldZIt6K5U+eAyUyHMBRBwajM=
X-Received: by 2002:a05:6830:7185:b0:7c7:526:b1fd with SMTP id
 46e09a7af769-7c7443682b3mr696808a34.11.1763064859588; Thu, 13 Nov 2025
 12:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 21:14:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gTrsccUOjqAM4tRoYiFdpemWzsZ6kY=P+r+yDJ38Hw1g@mail.gmail.com>
X-Gm-Features: AWmQ_bn8RSmNGuJCe_vafx9jt8ekKS39bneJpicsQp8WdOOdXGBHNrG6hGK4H54
Message-ID: <CAJZ5v0gTrsccUOjqAM4tRoYiFdpemWzsZ6kY=P+r+yDJ38Hw1g@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v6.18-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc6

with top-most commit 7564f3543cf19b1232553ab10399c9fbf514b5f3

 Merge branches 'acpi-cppc' and 'acpi-tables'

on top of commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c

 Linux 6.18-rc5

to receive ACPI support fixes for 6.18-rc6.

These fix issues in the ACPI CPPC library and in the recently added
parser for the ACPI MRRM table:

 - Limit some checks in the ACPI CPPC library to online CPUs to avoid
   accessing uninitialized per-CPU variables when some CPUs are offline
   to start with, like during boot with "nosmt=force" (Gautham Shenoy)

 - Rework add_boot_memory_ranges() in the ACPI MRRM table parser to fix
   memory leaks and improve error handling (Kaushlendra Kumar)

Thanks!


---------------

Gautham R. Shenoy (4):
      ACPI: CPPC: Detect preferred core availability on online CPUs
      ACPI: CPPC: Check _CPC validity for only the online CPUs
      ACPI: CPPC: Perform fast check switch only for online CPUs
      ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

Kaushlendra Kumar (1):
      ACPI: MRRM: Fix memory leaks and improve error handling

---------------

 arch/x86/kernel/acpi/cppc.c |  2 +-
 drivers/acpi/acpi_mrrm.c    | 43 +++++++++++++++++++++++++++++++++----------
 drivers/acpi/cppc_acpi.c    |  6 +++---
 3 files changed, 37 insertions(+), 14 deletions(-)

