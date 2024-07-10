Return-Path: <linux-acpi+bounces-6838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE592CFED
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 12:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055BE1C2353D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2918FA06;
	Wed, 10 Jul 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTYjcdw6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A884DEB;
	Wed, 10 Jul 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609143; cv=none; b=RuqgROnajAajoO2tkC90Dhd0YJGhzv6diXNtbctCZ5JNkP/Jn9w3KRGcKZv/RbOqYWQw8wEji1PXhqi/KfYgDjrQSBVgTGeywjyl53Z3XT8OiJlDJItA1tfcsP5XzvBeLtXVAYgF14tHl/yU5rAb1m9TxyN6sNgYQfIebxxiit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609143; c=relaxed/simple;
	bh=wtbumarMHL/KcUlc0xqRB/4mZTa+OunuouNJ4yUUSxo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OgNwZiwncxH5sv0tFv7RNjlDJU2H5Cn2l24lyvvx57v77DrJGcE31aW2K4GI0MJDAExmVOCRUzuTgCkmLAKC5TDDk1NDA/HOYNr+iUVn1+efKifvyezP7LpRbYIMX7KjvY+K7XkaMWNc8hAN86t8QyT6b6WBIecfczkNSc1Mo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTYjcdw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD42C32781;
	Wed, 10 Jul 2024 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720609142;
	bh=wtbumarMHL/KcUlc0xqRB/4mZTa+OunuouNJ4yUUSxo=;
	h=From:Date:Subject:To:Cc:From;
	b=nTYjcdw6DheuoWusFyUCUCJS3rWN3wyKi5QfM5is2bnoHb7Z3dul5scgKOth4N8Cl
	 qC5KwnTHNAdxD6knVUdzU/E4RonsYhao88kj5dXjJ2HUNWg7vwDq36tUfCCQG3UvX2
	 YoJvripMhmYt5HnaUHwV6T3Tkw5BUriK5T36PopM5vyX+doBKw9EzxI3mmzSMTBUPZ
	 vKoEcWeJevfFOp/ZdSSrAzLTLoRI6UYkoXwEc5SZJJogo7L6rCZrgWUBLCJshi2hRJ
	 3J1O1iUeobXxNITvIPUj5zwQywQ+0ibiBqOHJIxx8T+z9bznaOTLCSl5k6U75zYudV
	 lR6mk1Z0ySXGg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e55d0f551so430585fac.0;
        Wed, 10 Jul 2024 03:59:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfabiF+POVEMc5I7t4u+wn2KT2t4UdEjQ/pmuh22EGqodPuyB8UDgA5XWO44XseJliIVUub7F4pZPUPY8bNEaYqf3FOrbqzNbgI4A+C5qVtjmfJHZdi5HT+9qK85ow/1y1fDce19dfWA==
X-Gm-Message-State: AOJu0Ywf4M01tHN/sRgO1OVxGadHP6Elw+MjVnzQ1HZ8Uf8tgwlIzNuh
	Gek6yhujS0d+UT1+7/yh87TqQYKRVlUOvIpmzyHswVytH23wrfsdPtUZ5repnYzPkjVv962GZ/R
	59NTma/iB0METa1YO25if+fePaC0=
X-Google-Smtp-Source: AGHT+IFcQIBelGB/VdxKWUuj+48/X1QckGYiNSoDCeEqnYcbj/dXpTY03oOS5VCr2UxcGVQ1uhDg+2nMMGK60/A62go=
X-Received: by 2002:a4a:d02f:0:b0:5c6:67b7:41dd with SMTP id
 006d021491bc7-5c68df98c61mr5065636eaf.0.1720609142046; Wed, 10 Jul 2024
 03:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 12:58:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j01pmgnms9cPKeUn=5TNH_g3cwYB6Wd0kCuEic42PRgA@mail.gmail.com>
Message-ID: <CAJZ5v0j01pmgnms9cPKeUn=5TNH_g3cwYB6Wd0kCuEic42PRgA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.10-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc8

with top-most commit d92467ad9d9ee63a700934b9228a989ef671d511

 cpufreq: ACPI: Mark boost policy as enabled when setting boost

on top of commit 22a40d14b572deb80c0648557f4bd502d7e83826

 Linux 6.10-rc6

to receive power management fixes for final 6.10.

These fix two issues related to boost frequencies handling, one in the
cpufreq core and one in the ACPI cpufreq driver (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (2):
      cpufreq: Allow drivers to advertise boost enabled
      cpufreq: ACPI: Mark boost policy as enabled when setting boost

---------------

 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 drivers/cpufreq/cpufreq.c      | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

