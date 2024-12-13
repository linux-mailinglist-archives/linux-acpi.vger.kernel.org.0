Return-Path: <linux-acpi+bounces-10135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F49F17AA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 21:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C648016BD3B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 20:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428B9191F98;
	Fri, 13 Dec 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViBArYUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3818D649;
	Fri, 13 Dec 2024 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123586; cv=none; b=Nxp5CVNDNaxqzJkqTFjjSrareSXSJ76Qa6pBePqR/nbcszbMXI/qAJSU8xzCv0T+6pT20EZl1rP1IGbbWP0LhxENpwD/LqmPY3wiZrDW1LAM2to044YSpeaYony1+Oye97gFV6c0j8yYoiijnwF4VhWyidXSqu3NalKrkm0S8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123586; c=relaxed/simple;
	bh=3YeXNRuMlfVX6Hhet1HpVXgeP/aknrTTP+vGGNpXpjc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CW1KBimY+qAEo+1smQ3DOBUEHNPsyLTYroBs+UYK94VGMoe49+7j0npAAXpl7wqx/LK3MPNr6GknvMvTQ6Z93ExbgI+kDuhp09JiCVKDLut0tsbX7ZcIJb9T/3Gjqj+zEaDarFLPcCrE6ez8TZlQzSmDSo8Lga6FraiMf5kScuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViBArYUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC08C4CED0;
	Fri, 13 Dec 2024 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734123585;
	bh=3YeXNRuMlfVX6Hhet1HpVXgeP/aknrTTP+vGGNpXpjc=;
	h=From:Date:Subject:To:Cc:From;
	b=ViBArYUmb9BzzmdssN/eFLBwD7mumFs6DhJfSjAYclv/tyaVkOz+dywIyF9TNdksM
	 GZul+0ue60VwLSS0ZHEIsxjGD8B/6Imm8As1JBpgLck0HlpZlRo2Io/2h8qevSjjGi
	 G64MO3GmZ1mYrK5zNXWT5iKQgzgUeRb8Kh6GkazKGBwB1rYdeGUxxnI8q8Y9rwH+Cu
	 TRtMkOKpYnWoBsz8jypDRE4ZTezfQLYmfNRtUoY89lAOQrhCWzNdew6I4i3VG+EMt9
	 7oufkfEJYwbNUqDnQEqTAPvGyByIbStIs+ApQAD6c7x2xskwo+KtUoMmQitctqd+3W
	 kGz9f5fwOsxLQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71df1f45b0cso1540573a34.1;
        Fri, 13 Dec 2024 12:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCP3oFppDsuxwxS0EUXYHkAkJpQYlFlemJAgs/JqZ+NwuNLVoh77E4kjUhuGxw1RfFwgDXhjqPXPe4MIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd502++OPUYXWrCLSKCiVi33wZbmvliVlCVMr4LiNRdZ7T1XbC
	l2Hcxo96pejcHwZIhyASSTzuAbumiksgMmFf87eeYDSuCV19ENxRwKliF3QRzRI7u21uLrHe/Er
	lsKscA5Af9yGn7GwqRVwRoNxNwqs=
X-Google-Smtp-Source: AGHT+IGLAq/W/0zIYeNA1tor36qZBAEe1/RBhRZj2dipXb9QgpFBYnYJ7ax5Q4KU8c531JXayYOQ+01eseK2/Uma3IA=
X-Received: by 2002:a05:6808:1892:b0:3eb:47f9:a7fa with SMTP id
 5614622812f47-3eba6bfe393mr1944660b6e.21.1734123584856; Fri, 13 Dec 2024
 12:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 21:59:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jUChwwKBfcPrUJ+05ULOJ1dtng=f=7T8iHjBce3k5Bhg@mail.gmail.com>
Message-ID: <CAJZ5v0jUChwwKBfcPrUJ+05ULOJ1dtng=f=7T8iHjBce3k5Bhg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.13-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc3

with top-most commit e14d5ae28eb28c5edef53bd648037d2bb4fce1b3

 Merge branch 'acpica'

on top of commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

 Linux 6.13-rc2

to receive ACPI fixes for 6.13-rc3.

These fix two coding mistakes, one in the ACPI resources handling code
and one in ACPICA:

 - Relocate the addr->info.mem.caching check in acpi_decode_space() to
   only execute it if the resource is of the correct type (Ilpo J=C3=A4rvin=
en).

 - Don't release a context_mutex that was never acquired in
   acpi_remove_address_space_handler() (Daniil Tatianin).

Thanks!


---------------

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was
never acquired

Ilpo J=C3=A4rvinen (1):
      ACPI: resource: Fix memory resource type union access

---------------

 drivers/acpi/acpica/evxfregn.c | 2 --
 drivers/acpi/resource.c        | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

