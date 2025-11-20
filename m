Return-Path: <linux-acpi+bounces-19167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20411C75B39
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 18:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3CC4E50CC
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ABE375186;
	Thu, 20 Nov 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ4up3pu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC97375183
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659518; cv=none; b=bdkkemqRypEM9ha5YDkJPfPIreJ1w83aniCOo7oWzqSSM7C+3r3E7k7HH47if0wwfMHKejSeK4ekPSsD2uDcOh/ul+stGeSdLcYzDUOQ6zgPW3j6hWim30PtRIQ4st9GWdiAJp/9cJS0QKx0/tpdz4+x8x3mQnlGmBDx0wkLnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659518; c=relaxed/simple;
	bh=B9dqDVGpn9poHw7LutfxfXn3ISfiXHex6JcfVgVMl4o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H0Y6F7G3hjMKl9b5TAnwpBskVrPP/hdjbh4MKGtkbhmRjqKJhWEiHNZE17wy/OS+sIhrgw8flRcknQgoYmKOPyrg+beQHWyzQe7aCniVd1d7FKbZmdFe9azieGHLM6NkFHqDJyYRS2NEidqczFs9FKB3GCnac8dUebJXB8gm5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ4up3pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20208C116D0
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763659518;
	bh=B9dqDVGpn9poHw7LutfxfXn3ISfiXHex6JcfVgVMl4o=;
	h=From:Date:Subject:To:Cc:From;
	b=IJ4up3pugWiOgvX/cXk/C+r+jZRcN6MPP+8XwaX69C/l+/kAJITRhqd0A2jV68wsI
	 QDrBytfJg8KgftmQQtWsGAcxx6j9uPyu8A/0CSwP5XIoMIvQ5DrBxpASWe/63zEdit
	 sUnC4bSxrFge2TC4SJuRlbusGck1uTHQ2LGbEox5FkSETtvNoNtx5At/mk6ZXiRhhw
	 a6+PUyzf28h1f6Cu+nkQxKD7WdynQeJUN5OscfIhoJlQy590quNz5mpgLatZVLkFUn
	 VHVd2xtKcAb6K7+CNeD1M6nhUq3veFzjDuJ7p64RSghzH/jA2CeUG1NDXivdGSlp9+
	 k1r0//Ogjmz8g==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6dbdaced8so733891a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 09:25:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yxo4DNQn7NaylTm9+j+7mG7qSpGTcMt8ZMjkmtlhJWYFXrp3grm
	1xtz4/0PCwuMsZBPG89QGcVu9CmiVbFR9Dm4b1IDlucNNUWmK4CBxsv6GGAGx57p65nH1TXuJGO
	W/eiJ5u8CVwNjXzMQWq8W4TjFFx7NMb0=
X-Google-Smtp-Source: AGHT+IFZMg34iCUiAmO08vxtPmUbH+60GrJfSOlFwY0j0b5qlO1agNpOmK/cg2Gn0cxYBeMFZCdA80OScwRngRolMls=
X-Received: by 2002:a05:6808:1888:b0:44f:e61d:18ae with SMTP id
 5614622812f47-450ff050127mr1910508b6e.0.1763659517414; Thu, 20 Nov 2025
 09:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 18:25:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iVYQ43L_bvnzyZyO+ArhO9ePT91GetFfFfwDKguxVMSQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnYOXmtXiuOFvVsmYRmrNT2ldgox0ZgwiOLxnUZOUslrvTKDOtHh4c2D3Y
Message-ID: <CAJZ5v0iVYQ43L_bvnzyZyO+ArhO9ePT91GetFfFfwDKguxVMSQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for v6.18-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc7

with top-most commit d2932a59c2d4fb364396f21df58431c44918dd47

 ACPI: APEI: EINJ: Fix EINJV2 initialization and injection

on top of commit 6a23ae0a96a600d1d12557add110e0bb6e32730c

 Linux 6.18-rc6

to receive an ACPI support fix for 6.18-rc7.

This fixes EINJV2 support introduced during the 6.17 cycle by unbreaking
the initialization broken by a previous attempted fix, adding sanity
checks for data coming from the platform firmware, and updating the code
to handle injecting legacy error types on an EINJV2 capable systems
properly (Tony Luck).

Thanks!


---------------

Tony Luck (1):
      ACPI: APEI: EINJ: Fix EINJV2 initialization and injection

---------------

 drivers/acpi/apei/einj-core.c | 64 +++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

