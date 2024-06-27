Return-Path: <linux-acpi+bounces-6656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35D91AF86
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 21:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75F71F21C71
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E219B591;
	Thu, 27 Jun 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddBuc9pN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CF19B3DE;
	Thu, 27 Jun 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515661; cv=none; b=XNc35mQgOjg9J5gRFgelaxRrdDl/TyCuvJCWkWg246HcBNaVCQ4JkucdFD4/u+AcrmvRXYLvy28t7Bc2DJFL4SMlfsUnF++WY4X5MNE6M0FmnNsaq4mTCbaDEvwUtk1pFHZ/G708dpncyPIjK/QA9ecye9IdAeflPRgnMD0Vofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515661; c=relaxed/simple;
	bh=R0xuV5RV93yH+47j5L0V08wT5cLauH8CSTa3esKh4ec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A8E6MmzrYa85CmHGtf5eSSDz0p9jbGjTc1jZBocaTl6aam9/TNcVM0CnS+iqw24ybe0zZqrY6ZgM8RtQUPIE/AdYTztHl/Zi3WDXNsEG8s4xWNMlc5JuvjIt0Xnhv8Qlqg+sYX/x2cv/sdDrWtXCxTF+Y010qnREjp0ipWTBg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddBuc9pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA7DC4AF07;
	Thu, 27 Jun 2024 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515660;
	bh=R0xuV5RV93yH+47j5L0V08wT5cLauH8CSTa3esKh4ec=;
	h=From:Date:Subject:To:Cc:From;
	b=ddBuc9pNoGdYg97CYtrBAU4ZEWVKyiue7C/Szjp9UbXa6R7TWPm7b4yW6RnTugt3w
	 rPWerCtMRdc5Au/LDEQrL/M5r770MhavbQYZwwOBXrgNo+NEIlWng3ZsMgdfWoi35z
	 pOmmN3qRHifl8lypEy2jcijRLl1BVi7Y20j9u105W/HdRicwChpmJNUqqpYBewnQsR
	 qyfXvT4wlJiylhSwfLP75+b86qGIJ3OLDjSs//cVaBaCaSoc7ByusdHFNLBQgawfSS
	 U9wWLdsApqefM/qE8cgrmuPgJ/TeM+Zw2ZR411al/n1GHDhAU6R2M5uCA7/jheYEUv
	 M/nl0t4nLo6pw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d561131a3cso301933b6e.3;
        Thu, 27 Jun 2024 12:14:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXB83hobAwLUB4USCfb1iX7LAGdiMOQTbL/MxroymKHIiDD0CwMAlB6DBDH9GI61nzTN1RPd247OaePl6Sv6qr037lXVf4Yt0ifWcK2JYW1d9VjLl2beLkD6LJUBgCSugXVN5eAhOx+sQ==
X-Gm-Message-State: AOJu0Yz1mcl8EBx9QzyJuAhLAzk4g3MCMaF2aB/zF/xKJFeNvd+RXRH7
	8N/2Jr7pzH+gQETh4FT9Ibocg2g00aFnZdnyoVuNdmZ4/rIF+GZ0O+D2bPLKQIkCVr4KfCoi+XM
	9YoHz5p0N7K4XxUlXSfje8WASAVo=
X-Google-Smtp-Source: AGHT+IEuHZCSesfxQmP4KLYddVcc/ZQecVBz8Gqvgr2bdImhYy8lWyI0GcfcrytqIlEkOXtBb/Qk0cdfi4qhSBPRhpg=
X-Received: by 2002:a4a:3c4d:0:b0:5c2:23ee:c85e with SMTP id
 006d021491bc7-5c223eed359mr4888990eaf.1.1719515659809; Thu, 27 Jun 2024
 12:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 21:14:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h__X99p9mZLT29_pY3_4Z0wz=EDmaGmo1HntF5SO7HfQ@mail.gmail.com>
Message-ID: <CAJZ5v0h__X99p9mZLT29_pY3_4Z0wz=EDmaGmo1HntF5SO7HfQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.10-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc6

with top-most commit a1ff59784b277795a613beaa5d3dd9c5595c69a7

 cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is missing

on top of commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454

 Linux 6.10-rc5

to receive a power management fix for 6.10-rc6.

This modifies the intel_pstate driver to use HWP to initialize the ITMT
scheduler extension if ACPI CPPC cannot be used for that, which is the
case on some hybrid x86 systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is missing

---------------

 drivers/cpufreq/intel_pstate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

