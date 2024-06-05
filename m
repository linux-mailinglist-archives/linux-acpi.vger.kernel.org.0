Return-Path: <linux-acpi+bounces-6204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A18FD490
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE62628ABD2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD740194AF4;
	Wed,  5 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtOdNQ+E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765925777;
	Wed,  5 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610339; cv=none; b=X84H7kCMSbJAHz8aJK8aa7bDoB3yGl/17yYg/REFxpfker7T9nkAr5uipwT9jR+t/cGnpWY/i/EFRlh79xwitgqU80QnchOhtGZOQhz0Shn/WQhBieKlDK+ICaph1PtXi7mzOFEGhg7LDa/SlNQom6cclZTJvh/O8BUX8SR3ytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610339; c=relaxed/simple;
	bh=3NH2HJuvUCdE9YMGvSqj09aFeYgyrfQkF2cz9CFtgPY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r+m1cQJKS3Ep4z5Q6sl+24M1X4Oadqg6YkA4+fGLCbIJ/23hcuTn1xkZMqJtYfqZSOuypKF06BdrsgyaLYU3mbNsSprbhwkriEc6x2FCJLYbsJ64ftsHQybdR0tCuQI2wAD0sUeXAPhlLWZUYC+K5A0UwzSf6rwyvoLEgq24I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtOdNQ+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C93DC3277B;
	Wed,  5 Jun 2024 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610339;
	bh=3NH2HJuvUCdE9YMGvSqj09aFeYgyrfQkF2cz9CFtgPY=;
	h=From:Date:Subject:To:Cc:From;
	b=QtOdNQ+EKLG9mXQQaZ4+bGFRGnnq0q8MyR8G3Ai0NXcghnGXq8SEbf++tpG916XOS
	 Ycvn69YhVIy428v/PB5jjvle3RsXtyqt71gMKGQP8PwG34rqR7QnhMSxJh4/Lbv6HW
	 A6gfFFHhf3pGsqFVABiBccQzI8av5/OKhSyKMqooGfzK+aJ1/ge8ZcJ7SglNMcICkg
	 B074pGg9K+uItP8huK71a4NZAenVrj3yKNgV8a4s5zXlqMoFFTwWB8cYBE7EfGGdBH
	 rTdZkgL0VSPlPVsJVQwqbLbC/+CllK6kdaW6SkRIKxpNT/Jo+EmARgJO1Thm6oSXWm
	 0x8UmxlQ1/H0Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1ffa160b8so2315b6e.1;
        Wed, 05 Jun 2024 10:58:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrj+NyEhgBNW4I8UX28tcHP2wCOma9oE7QL3JkfTiHkSMxmQA3h6qpaImR137xR4f9IcLyEoBCzlNSwX6xuRvpVW2KgiW8lSH46t35
X-Gm-Message-State: AOJu0YzKBSkTXqebPkX6r9PgYPSdmC45cC9RaZPKts/aCbkKS2BZYt7U
	bKu8OHvAVLaut8DVsqccsMhnZEBvibdj1bKvMXZS5tsrPcEJk8D2E05/jbDhMZvMF+Jmcsuwgk2
	3j8jYrq230F9QNIuFfsTRUrIKBGQ=
X-Google-Smtp-Source: AGHT+IH7qilmvTPInPTiYZCSwdnE6tGs3+akv+ml1xwyM/VTcWoPFBz8lLOhsnhqtIRDAJ9KHdjCYydoxyqZc+KHEH0=
X-Received: by 2002:a05:6870:4d18:b0:24c:b092:fd38 with SMTP id
 586e51a60fabf-25121cf42eamr4029315fac.1.1717610338561; Wed, 05 Jun 2024
 10:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Jun 2024 19:58:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkHRB-obYEnYzVAy9u9wVUKwu=FTCn5rMKtAwf1HGMjA@mail.gmail.com>
Message-ID: <CAJZ5v0hkHRB-obYEnYzVAy9u9wVUKwu=FTCn5rMKtAwf1HGMjA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc3

with top-most commit 1bfc0835d40c8b4f19f8c1db8c42edddb265df5f

 Merge branches 'acpi-ec', 'acpi-apei' and 'pnp'

on top of commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

 Linux 6.10-rc1

to receive ACPI fixes for 6.10-rc3.

These fix the ACPI EC and AC drivers, the ACPI APEI error injection
driver and build issues related to the dev_is_pnp() macro referring
to pnp_bus_type that is not exported to modules.

Specifics:

 - Fix error handling during EC operation region accesses in the ACPI EC
   driver (Armin Wolf).

 - Fix a memory leak in the APEI error injection driver introduced
   during its conversion to a platform driver (Dan Williams).

 - Fix build failures related to the dev_is_pnp() macro by redefining it
   as a proper function and exporting it to modules as appropriate and
   unexport pnp_bus_type which need not be exported any more (Andy
   Shevchenko).

 - Update the ACPI AC driver to use power_supply_changed() to let the
   power supply core handle configuration changes properly (Thomas
   Wei=C3=9Fschuh).

Thanks!


---------------

Andy Shevchenko (2):
      PNP: Make dev_is_pnp() to be a function and export it for modules
      PNP: Hide pnp_bus_type from the non-PNP code

Armin Wolf (2):
      ACPI: EC: Abort address space access upon error
      ACPI: EC: Avoid returning AE_OK on errors in address space handler

Dan Williams (1):
      ACPI: APEI: EINJ: Fix einj_dev release leak

Thomas Wei=C3=9Fschuh (1):
      ACPI: AC: Properly notify powermanagement core about changes

---------------

 drivers/acpi/ac.c             | 4 ++--
 drivers/acpi/apei/einj-core.c | 2 +-
 drivers/acpi/ec.c             | 9 +++++++--
 drivers/acpi/sbs.c            | 4 ++--
 drivers/pnp/base.h            | 1 +
 drivers/pnp/driver.c          | 6 ++++++
 include/linux/pnp.h           | 6 ++----
 7 files changed, 21 insertions(+), 11 deletions(-)

