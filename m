Return-Path: <linux-acpi+bounces-14494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C059CAE28CC
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A493A751A
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C1195B1A;
	Sat, 21 Jun 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWBssDVI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50EA95C;
	Sat, 21 Jun 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505512; cv=none; b=uXATQouWrwb3igNB5kVm1xslg2g6WrKUWjkPjlM2YS3YkDHTIEBZ7eVnLQcFih1RTr9wmJtO0S75gKpUYqtT1PmRFjnKseIPWQ+AojgXMnpHmTeaR/obAMaVXmaIa4AiIif8JuQbMVs9TJicYORgLYyjBhMrWNiSM3fHf+plI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505512; c=relaxed/simple;
	bh=fMeNHwlvdxhVpulaFu75Rk3QBuy7carLB9qer/sIg78=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PtumY/BnfK57I/UWLHwhVPeTve1SGeTrcQGVjTPBwhOXwTXpuVSiKK81KaJinjeMhzu0bvV5NP1AtitvW1dEIHIQ7+RF8/N4ihdKDBRB34zi0oZvFkxvGR79FEN2jfsJmZWKKtG4CHIFRYh3orthXK16l716cTsCnzVKG7MEng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWBssDVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF6C4CEEF;
	Sat, 21 Jun 2025 11:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750505512;
	bh=fMeNHwlvdxhVpulaFu75Rk3QBuy7carLB9qer/sIg78=;
	h=From:Date:Subject:To:Cc:From;
	b=rWBssDVIxN+heJAm5e8YCmpldEd1eH8gFArkMiaSt8gi15lqMH9wmudwKChiKyfmt
	 vVKjwVVOK+1URHQ5eyi0sMjZkEX4XkFJWbhi4f/8WseOyCHJDeVVnGgl88A/FA4YUd
	 HpdUeBY1Dvu/sGIr8hJVgjQqFkGfSz5xpS4107tsXPY9yh9dvzTQ4Lce6+f9BDcBHK
	 mxuk8s5P94Howle3SM+CF6yaaDH8mIqMjpgjWUwLx9xnQRq+WBayeIsogE+y+xRmIn
	 I/ijXokhyBajJVjQUxXmvG77lM7RtLHVsT8biuvebI1HDwW4TVwit6DrirF2q7JtmI
	 dqceAIMthxFSA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-606477d77easo1666438eaf.1;
        Sat, 21 Jun 2025 04:31:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTXlu6XUlWU1S5p7nhs20kdU140SRNLHOXjESwlVkEVxiO3gPVXCdWBYKNWJkr4pgEpcG44+qRSG1mFAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJD2ExguazNaY/phDhjUfeTzgwTM7MH5lQQz636Vz5u9v5VQ7
	izAixG8B7jrBTDK41HMobhbHgepZZOSjXK2TM9U0n7iUzV1jaM2QRbg5r9XG/MiAuJiR5ywXAzw
	/K2JWSFupmqlYNjoM+a975MmQ31Wq20Y=
X-Google-Smtp-Source: AGHT+IE5n394XM+7zHcgyPrTHWVFOTviAqX3t2Z6skAUnNv3LIEPZutFXJKATyqljUcH6zXQJn4KIzwJGUFjlx85eA0=
X-Received: by 2002:a05:6820:6ac3:b0:611:6cb6:46bf with SMTP id
 006d021491bc7-6116cb647f2mr1044516eaf.4.1750505511421; Sat, 21 Jun 2025
 04:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 21 Jun 2025 13:31:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
X-Gm-Features: AX0GCFsZ4VbA-qN3-aLKoEtFFt1821bPf6EqEI0cFHzu1w7RgboPt-kPW8xdR6I
Message-ID: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.16-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc3

with top-most commit 6fcab2791543924d438e7fa49276d0998b0a069f

 ACPICA: Refuse to evaluate a method if arguments are missing

on top of commit e04c78d86a9699d136910cfc0bdcf01087e3267e

 Linux 6.16-rc2

to receive an ACPI fix for 6.16-rc3.

This fixes a crash in ACPICA while attempting to evaluate a control
method that expects more arguments than are being passed to it, which
was exposed by a defective firmware update from a prominent OEM on
multiple systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPICA: Refuse to evaluate a method if arguments are missing

---------------

 drivers/acpi/acpica/dsmethod.c | 7 +++++++
 1 file changed, 7 insertions(+)

