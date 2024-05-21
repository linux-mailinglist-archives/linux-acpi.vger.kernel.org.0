Return-Path: <linux-acpi+bounces-5907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED248CAAD8
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 11:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FB1F22922
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D357C8B;
	Tue, 21 May 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m93+2wjN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08351C30;
	Tue, 21 May 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284138; cv=none; b=U+JrVCOwYY4ikwgtbKIlOuiXs6FlDVvF/IWwl5wbdBJ1ixmgD1EdkD5qAzqxwWgqrnVFsJx84EAFuzgDtFSGpv0vpd5Y4BIZNTJ911rt8AwOeGZ+z38ZcUi4r8C7OjHm5FBOC8zhNSpsN0GursmE7iSw9cCHd/zp8o9HYHtA74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284138; c=relaxed/simple;
	bh=gaI1x49Mq0muVNOH2if68wn6RP6JS0LR/NutDzd73Ek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D/l7emXhfShN/j6QfFHWonb9EwyIqUvi9ZxK8RzYnp/mU+wC9wFUj7FGjWDfSSddSLyel6TJL53KSBeC0/KyDYPvtfWpuqd49oP6FkXNRfwcVc5OmPpUKCwyxV2pqN8JXck+D9/oNgje8vyfwl4U/0mayVdYgA49YE0/3UHIAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m93+2wjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E20C2BD11;
	Tue, 21 May 2024 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716284138;
	bh=gaI1x49Mq0muVNOH2if68wn6RP6JS0LR/NutDzd73Ek=;
	h=From:Date:Subject:To:Cc:From;
	b=m93+2wjNxvL9E1PmcKgGBJRMwaxLXoB1GzjadIaG/keOXw6S85IxzhP04cfbVPWQl
	 sB0grIBvMlh7/nxTN7EJfDRDLOYCyK9xRq40J96lNKgp7ToaMwiO6+/LEQYzXyGETT
	 UTuUqpHky/aylgHjlB/tUySW3h0XIdChJAh153q/7Xj19KxtrVLlM6+4+PvcFJJERi
	 n2co12NtwkICBOpcJIDqCE0+z1/s/AtH0zJCb87eybIt/nmlXIe+r4cj+nP6h5BqBf
	 9GAkLlClk6GpfIVq5Z34HG1+1UX+jdxjaG7LbWY5CZSWWpme9MiVS/mvB5ijxIR1Ek
	 Sgy1jYeDuMXCw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ac4470de3bso284129eaf.0;
        Tue, 21 May 2024 02:35:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfBYt0HvK784VRTGe1ha6FO+IZ6575aX651ADDb3UBBU1u8s2j38TRsnbSa32tWKPA/MnkBl0xOqhZq/Ifim4AUTfQYORMtLQgiweN
X-Gm-Message-State: AOJu0YwQU3ZHUo2Qjh0R3jRDk9ZW2aZWoJzboyXXTPoTcBWxRClq99T8
	wG2dPEVkZkO1TQS2dbknyH4kcTvpkFkEJbDqiTUFAtEU00rsSMl7s13GcHbfHWbMPOp2ExU3arB
	lRbTH0yfYt6+ElCwbq3Fjrh9H9Fg=
X-Google-Smtp-Source: AGHT+IGSrZgkMMfXBdxwsD336ftypoWzh8InmZNrBd+YLMY+qKWUXEU5HCcUvL3yE+V4vzbfLIEBXc4YrbtSKhj1rVM=
X-Received: by 2002:a4a:d692:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5b2815e3c4dmr35651663eaf.0.1716284137719; Tue, 21 May 2024
 02:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 May 2024 11:35:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPXNa+DjUbHpPYvBzt3Thdke9rvdbSXEcJ5qXPBQJtpQ@mail.gmail.com>
Message-ID: <CAJZ5v0gPXNa+DjUbHpPYvBzt3Thdke9rvdbSXEcJ5qXPBQJtpQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc1-2

with top-most commit 98a83da39b482c638954b111803906843a83a747

 platform/x86: wmi: Remove custom EC address space handler

on top of commit ea5f6ad9ad9645733b72ab53a98e719b460d36a6

 Merge tag 'platform-drivers-x86-v6.10-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86

to receive ACPI fixes for 6.10-rc1.

These make the ACPI EC driver always install the EC address space handler
at the root of the ACPI namespace which causes it to take care of all EC
operation regions everywhere, so in particular the custom EC address
space handler in the WMI driver is not needed any more and accordingly
it gets removed altogether.

Thanks!


---------------

Rafael J. Wysocki (2):
      ACPI: EC: Install address space handler at the namespace root
      platform/x86: wmi: Remove custom EC address space handler

---------------

 drivers/acpi/ec.c          | 25 ++++++++-----
 drivers/acpi/internal.h    |  1 -
 drivers/platform/x86/wmi.c | 92 ----------------------------------------------
 3 files changed, 16 insertions(+), 102 deletions(-)

