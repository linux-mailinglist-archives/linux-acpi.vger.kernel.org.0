Return-Path: <linux-acpi+bounces-15676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D511B26453
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F1A00ECB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C62F744B;
	Thu, 14 Aug 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf5JeiGD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBA2F5460;
	Thu, 14 Aug 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171171; cv=none; b=mnNKZVl6L5V0laCN0I2hbX/oTTYDBEg0vtzuUhQ3X19lEF59MtDsevcRZmEW1nfZhqeStpNNgW9yE0scx2FNlhiL/71CV9Ly8x5LqmJzkrqnAzA4ypP8qtEwpZL8iBH0yGZZS8xD+vySC1sl0r4lLq6B3H7fMDtjbjOtyCsthOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171171; c=relaxed/simple;
	bh=BbcGIYWpkOPjQ/or9OWJcZ+ls3hMh4nFjaciiElcR74=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=urfr5sZway/WmGzYoI6zYA3sFFdS96v1OfZTZ3Kahzz14E+i3LPuuzPoOoVX4fmzvZo5NMIFmv8ObEN/lme1nwoOj2x/B/6Cj3B8ywpfnUIfspM72se1KN5ITJp6zm6RlnKod8ezKORowYyFTiVHMA9gdvanKGZ7GB1V1W2/sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf5JeiGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F8C4CEF1;
	Thu, 14 Aug 2025 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755171170;
	bh=BbcGIYWpkOPjQ/or9OWJcZ+ls3hMh4nFjaciiElcR74=;
	h=From:Date:Subject:To:Cc:From;
	b=lf5JeiGDhaPCcehpddrdo9jS14kL4oKe4EsmYIZ2y9k2cOXx+W108Cuw4EXvNs1i5
	 bBrxfgFU41hQnF65g+WtFeD9USujNLc2HY2K2rJCVgK9NH7no/Y0fSDo2nXfzF8mFS
	 0cdCfDtM4sqq6pPDJwxUaUrMGS5M6IMVcVgzVj4eOyLHVI8NFYi4ujMkx9KVrYcj3T
	 6+bkcUD+J6Y7DYWtXeB0hvWP/saOqAUurKAHMRNCDVN1AQHqQz5Lrd7Z4UVatjRg45
	 77mUKRvQ6hhy4sGkbmDfArZRxQXH12DXIbe4A61t9cpCBxpJGNgCtI+oAReXOaU1z0
	 VvMNUVVHPaFdQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bd4c6de5cso358516eaf.1;
        Thu, 14 Aug 2025 04:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0/p2ETeE7o+ISlsdH0GdOd5BMox9FD2FBWHHWn4ksi5eNMVvefVwsMaER2qviy4hGdm01fCrvnuS6VBU5@vger.kernel.org, AJvYcCXrzrQox/VbMiV7MxEjOKBuVO3X5ja1L1MZLLdDUYTjXAlPySuCUlPii0fUmMDOSlKUV6Cm5zlO52ca@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeS9hYHDZSTFcrv4Sa5gu8Qq1W7Q3g94/bpUa33FCrQyUP+Qz
	Mx8UkiPIAQbqeUgW3pX+I8zFUYrEOaZKATrnoBgckfAuEjggMLOkcZ6T0rB6OQ4Nns8CZuUy+R1
	CAaO4Fo43dNMRt1Vkn+48nTyX5zBNbC0=
X-Google-Smtp-Source: AGHT+IETHsolYnN7P5gKi6reg0xorYNS/5249NrR5fQYEVIPoGljAyDgi14WEM1dITay9cIRU6Z+xKHshpckvdbGjr8=
X-Received: by 2002:a05:6820:813:b0:61b:76ee:f46 with SMTP id
 006d021491bc7-61bd5ba409dmr1527933eaf.4.1755171169932; Thu, 14 Aug 2025
 04:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Aug 2025 13:32:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joXWwzmEXh9EUgMERgdbCD32m2M8VMoFVrqVEGKmLXLg@mail.gmail.com>
X-Gm-Features: Ac12FXxubt_38x8aueZ1Qsb1wp64RIFXdHQ2L3-gUd8fd7yDhVDeVmHU4iCriu8
Message-ID: <CAJZ5v0joXWwzmEXh9EUgMERgdbCD32m2M8VMoFVrqVEGKmLXLg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.17-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc2

with top-most commit 5302e2a3886c830b803ae3390b9d41d35832f315

 Merge branches 'pm-cpuidle' and 'pm-cpufreq'

on top of commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585

 Linux 6.17-rc1

to receive power management updates for 6.17-rc2.

These remove an artificial limitation from the intel_idle driver,
update the menu cpuidle governor to restore its previous behavior
in a corner case and add one more supported platform configuration
to the intel_pstate driver:

 - Allow intel_idle to use _CST information from ACPI tables for
   idle states enumeration on any family of processors (Len Brown).

 - Restore corner case behavior of the menu cpuidle governor, related
   to the handling of systems where idle states selected by the governor
   are rejected by the cpuidle driver, inadvertently changed during the
   6.15 development cycle (Rafael Wysocki).

 - Add support for Clearwater Forest in the out-of-band (OOB) mode to
   the intel_pstate driver (Srinivas Pandruvada).

Thanks!


---------------

Len Brown (1):
      intel_idle: Allow loading ACPI tables for any family

Rafael J. Wysocki (1):
      cpuidle: governors: menu: Avoid using invalid recent intervals data

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Support Clearwater Forest OOB mode

---------------

 drivers/cpufreq/intel_pstate.c   |  1 +
 drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++----
 drivers/idle/intel_idle.c        |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

