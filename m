Return-Path: <linux-acpi+bounces-9247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374249B97A5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 19:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C1D1F216E0
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E41CDFBD;
	Fri,  1 Nov 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp5N510p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FB1AB523;
	Fri,  1 Nov 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486125; cv=none; b=jl0sUpmPVKLOS3kXN+2GV94TXCJI+eyI8Sl9AL0CJ/yR6PxHNalBEjKGAc8dElaHoXqOuhN6YakaWwy81L6BjJmo/K94mkPDM3C1xRN9qe8etQP2IvyGWxe0k9wNh+o26yvcYl4iS165q9mqFaj/XjN3P9XhsQSVka/M2UIeqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486125; c=relaxed/simple;
	bh=Y3saQugEtHxlZ99FsJFD/ZNel2QdI2zPllmiplYSsFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E5O0jNOlKS06oifrC4iEADc6NPsyFja4hHK6g7TYSXDYpS4kBKEQQXpDTTjKR6J+g8QQqppSW6vAmTOBTidSXrenaHGSuEbOWbUVP9x2FFxci7tujJBVsSd0t/Tb0+61GDvFthvOfvgg+to9q+0qsn6cNU/D+m9o4yJ+xoKUItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp5N510p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340BCC4CECD;
	Fri,  1 Nov 2024 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730486125;
	bh=Y3saQugEtHxlZ99FsJFD/ZNel2QdI2zPllmiplYSsFo=;
	h=From:Date:Subject:To:Cc:From;
	b=qp5N510psK6rElKAQmr3AEvb9hZIjtIDVBcrxIjdZA6CsEKSdxQ7znGIHu9ATdJP7
	 E1kSgZUTNkl9tXg09kv5eXw92xWR66EVMP+TPR7yC/tW0KC5CkR4NdqqUmLVY8TdDj
	 dv7ODBhioKNnl5BQZqksoB87C7A3I7E7k0G2kFO71TQkXwxdS3+0jiyd2RIFTLSf4c
	 JegP2z9sMdzbIfWxO5USCPn5qMwTYeH9J78SHZ+vVLUDplGsSSHJTkkRjeadoC0Odl
	 3WLdNZhhkbUuK9d2YDEolk2kkFh2/oCQ32APQZ7zJJVwKSuxGC4ePZLZ/GgOHtKNJu
	 OFsqF4VwyMYtA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5f86e59f1so1172510b6e.1;
        Fri, 01 Nov 2024 11:35:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1wCSYOVADj+PPemIvA+o8E10DBbXXqbmy5grOmuYQ31pMhW8xWBICZn/rcPDzKGhuRLQlC2fIM4o=@vger.kernel.org, AJvYcCXcapRcvqM4J+7F00Il3d5UIBpOpALLr+lfjCdoQZNAqAqU3GK/Mu/7wXLBqZI0A6iD7u9QzVYC9A5TRDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2etSJzkPKS6Rq8xlqWz2pNNS9/Kf+qj0Ov32YPE00OZ8fEhd
	r26eWv6eZF65G2pdqa9cto9374pc0xepVo7oVwlBmannwGLNgRUUdJIBIWr+ft/Xy9V2IqUYWQ/
	wXz2lJO8KyOhAGcqKSKxxVHc68No=
X-Google-Smtp-Source: AGHT+IE3LWKfl/jtwEs/EJ7UTCMroim2eqpdpHD56WFCA0NjSRrpWdvV85kXGB1yYsyOuuobCJ2vKqGgGtvjGOGtOLA=
X-Received: by 2002:a05:6870:d24b:b0:288:666b:9c5e with SMTP id
 586e51a60fabf-2948449c37cmr7826160fac.17.1730486124473; Fri, 01 Nov 2024
 11:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Nov 2024 19:35:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jFxoRAoUkEGmUCg3-H4qhhNd1g4-w05bPnpgJndfDDWA@mail.gmail.com>
Message-ID: <CAJZ5v0jFxoRAoUkEGmUCg3-H4qhhNd1g4-w05bPnpgJndfDDWA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.12-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc6

with top-most commit 1c10941e34c5fdc0357e46a25bd130d9cf40b925

 ACPI: CPPC: Make rmw_lock a raw_spin_lock

on top of commit 81983758430957d9a5cb3333fe324fd70cf63e7e

 Linux 6.12-rc5

to receive an ACPI fix for 6.12-rc6.

This makes the ACPI CPPC library use a raw spinlock for operations
carried out in scheduler context via the schedutil governor and the
ACPI CPPC cpufreq driver (Pierre Gondois).

Thanks!


---------------

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

---------------

 drivers/acpi/cppc_acpi.c | 9 +++++----
 include/acpi/cppc_acpi.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

