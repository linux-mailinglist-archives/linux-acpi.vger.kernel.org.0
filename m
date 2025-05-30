Return-Path: <linux-acpi+bounces-14029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D0AC95D2
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D4E1C203C4
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41C2367D6;
	Fri, 30 May 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMV+huY7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553831D8A10;
	Fri, 30 May 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631102; cv=none; b=PLStmXv9WE+mUnhUZvAHBybIYrLMyxqoxwh1RfpUH0jHenCIqiaE/0kL7SFOV7/Whr7y6nX9A3gEEIs/YG3i/KvO3gRwQQ1WoDISnuH8VaRcHqjlAb/BsXg8NUrELz64/bp4BtOsNz85cpwvxmkmopFwpSJJl16G8qbv4I/1m4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631102; c=relaxed/simple;
	bh=OGWupad3mxhudfRyUECpcU7Gtb3pu/gBN114jYicv8Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QnjVvejl23gHruGePz71vxw5wdFtFixHuroxqnkoxKLE954ecJKfseazIcDHLHA4UzjLOcoKf2efGlAyV9I5n14TO5yGhXKF1/1dJ5b5FM93bZGNOahK+QQcUIB3fgFQdZtKgntZA3QpY//ligaV9YlBlY/e8y41YI1coNFN0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMV+huY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CAC4CEED;
	Fri, 30 May 2025 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748631101;
	bh=OGWupad3mxhudfRyUECpcU7Gtb3pu/gBN114jYicv8Q=;
	h=From:Date:Subject:To:Cc:From;
	b=WMV+huY7HRMOPt/q/zgjM9I+Rwo/pYbPN8wfrK5Xa/LSnzt6g0WTaPAqyqUn3b2YM
	 W+MuZrNKGOYTUXAPeQyW47gF+PopXV1IDH7fyGt5PXbT0iUkr4kgZYDp5Tl/3MXB//
	 NENkIm0JttvadyOAmQFvi9dTVzEV/65OA6D0r3zqJB3OEHBgZdHudH7ZPLjdSoyId+
	 ROjvJbG/7Q/lI7Ji3ub9B/dW5pHvSpMKkfye5VhzrVmehA6shmVb/Rn/o8SJNP/4UV
	 jdq0uH7x03gUaqO5j7wBDB8xvsKA7Twi403gTRzfKt7Ud4keTNo4NoKfdtRnVAEkqd
	 WZx1LfI42NHXQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d09d495c6cso594931fac.3;
        Fri, 30 May 2025 11:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAv+r6F+N0KKykDMcp2Uq3XX9FWxnN8CZCSFOcyD6ucUTlTklLIlIvCssHlu4hOLYgiVwErFNvv2RJ8qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9BxmB78LB6uMdQyMe3auJIn5Igfi7iK+zlxsa9vIOZ0gnP0H
	+xCCKx+uc2iIBmnpYN8DzEWnWK5j23ETg55+C2oKMOmSLoKPGDjBnumc+lBgXqoJLqeRSKJ4sT1
	c6LI2pXmFtHQCYnNpm9a3GFU/pX/C8sE=
X-Google-Smtp-Source: AGHT+IGjz3+bC2xHbnZw1cEeyAzaN6Vyk43XA6bFvU9xZf+GRG2XAZuKZSPTTROim601u8ljt0L4DtL9fYG/UvK8HOQ=
X-Received: by 2002:a05:6870:46a4:b0:2e9:365:d0d3 with SMTP id
 586e51a60fabf-2e92a422551mr1653148fac.21.1748631101019; Fri, 30 May 2025
 11:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 20:51:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDrmG44NHPtDThtYkk-v3YOX-4yxJWC7SvU0Hjq-vWGA@mail.gmail.com>
X-Gm-Features: AX0GCFv3A9tkuZZjvO1ZqvqZWHyDI1e8Unf6uIwtMO0lJhiJPEYx3F-ibtZbddY
Message-ID: <CAJZ5v0iDrmG44NHPtDThtYkk-v3YOX-4yxJWC7SvU0Hjq-vWGA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc1-2

with top-most commit f4c606df263b6de746412dee707bc4b590adf45a

 Merge branches 'acpica', 'acpi-tables' and 'acpi-apei'

on top of commit 3702a515edec515fcc7e085053da636fefac88d6

 Merge tag 'acpi-6.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 6.16-rc1.

These address issues introduced by recent ACPI changes merged
previously:

 - Unbreak acpi_ut_safe_strncpy() by restoring its previous behavior
   changed incorrectly by a recent update (Ahmed Salem).

 - Make a new static checker warning in the recently introduced ACPI
   MRRM table parser go away (Dan Carpenter).

 - Fix ACPI table reference leak in error path of einj_probe() (Dan
   Carpenter).

Thanks!


---------------

Ahmed Salem (1):
      ACPICA: Switch back to using strncpy() in acpi_ut_safe_strncpy()

Dan Carpenter (2):
      ACPI: APEI: EINJ: Clean up on error in einj_probe()
      ACPI: MRRM: Silence error code static checker warning

---------------

 drivers/acpi/acpi_mrrm.c        | 4 +++-
 drivers/acpi/acpica/utnonansi.c | 2 +-
 drivers/acpi/apei/einj-core.c   | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

