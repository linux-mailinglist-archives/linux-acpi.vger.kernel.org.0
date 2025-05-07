Return-Path: <linux-acpi+bounces-13580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4FAAE081
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23B57B1D6A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157B25D91E;
	Wed,  7 May 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6TMtmkJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0120C00D;
	Wed,  7 May 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623887; cv=none; b=cOWBAAzpsPV7jRrot/3lONajqz8w1r06mBthd8FBaizfZgqRk+aT7vNNdjg+fYyUBvCFWMmFXpwVtRo4jLIuqbiBvo1NMalOh942eYekDRNdT/b+lmYos63Knw1gHs73h4mju09btMJGY3KHJYS+vlSaF1BoC/i8ovaaVRD/8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623887; c=relaxed/simple;
	bh=/4l54gB51JEiLKfzvbIFcqCBo1N+fvqPwDNQAGVYOdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9CunA+P9Bq5xKG6zRrPG8jK5ggLHA2q0AnhNlW8r2s4XE/0RwR5qh7TofWlxX+RTqcns0AnhF1OJ05f+Cxs9GDWhSDUsMFcsMExmhHkEmZvs6GQV/jBb2YYFQDzGjXvov/RaSxKTKomeKMsfaCa/JNhE/dg/vxxizOj5WACRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6TMtmkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A9C4CEF0;
	Wed,  7 May 2025 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623886;
	bh=/4l54gB51JEiLKfzvbIFcqCBo1N+fvqPwDNQAGVYOdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I6TMtmkJ9wONHD2Ptd5Lq1z0HFKIn+wm3W5+OhhKao+mTow1VHAKAe99bVuhBg40P
	 d9cEg3XWUxrzS8msuGZO/ILnlRm4vycdlNQSuNlBzRMKXtC2SurQODlSEZNKUI8f1a
	 DPfvxcJ3v/1veZYEFgxSELMS2UNNvQz9bunNqpAy3Ge/gx2LrkrqapPb1mOJbEJ/OW
	 bIPL4JR1JNog7t4jlbjtBNWyO2VjEaeCpb+qZjJrvad9b7n+FmWgXotnqKqJ7l5vfP
	 xxETuj5muBcSV5jTGv1vBhP5g/9QkRrVD/K3fhlikwQCHPpz5FaMx1PVZ9Aapp+ya/
	 rdR3sgNsfxd8g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d522f699bcso3341113fac.2;
        Wed, 07 May 2025 06:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF1InDHZd6Py+n8aCJ6VSA/Tqi5RI/7sJDDzTWGTGCqiqe6ANKISOtIetqDYp/qdqqVYUAbjRb392e@vger.kernel.org, AJvYcCXWNyUibxBjgTyE2eQ05IhfyIcPKz02jZPQRBBmmxnUjMcHilF+wId0VGQKcG3ywe4cvJYEFrGw1lwcoY4h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O+bew86MoAub2V6T1co2P5D7qOai2aay23zJGYtoatAZVNR8
	I3WoKIz94v8TucfdXeZZV9LR6YEwj3WeS1NLU6Jk5rQ5rsVBjH2E+BYmLDZYTa3GJh567+2q6dm
	Mvs0mOa43P++Ztbp7iWFn5guoHYI=
X-Google-Smtp-Source: AGHT+IGPxxvCaybWIAoO2Nga9MEP69VTlaFKPWEWg85ZVQgC8uwxe7rwkJLQ8fk0/O4Gc2ddjZITaMLhIJ6aGrZKMyE=
X-Received: by 2002:a05:6871:2b19:b0:2d4:ea06:b11 with SMTP id
 586e51a60fabf-2db5bd765abmr1754110fac.7.1746623885951; Wed, 07 May 2025
 06:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505173819.419271-1-tony.luck@intel.com>
In-Reply-To: <20250505173819.419271-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 15:17:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5RsZ-QcX1HsVifxKuKXxqF50nrqSf38i=qyBZQSM2fQ@mail.gmail.com>
X-Gm-Features: ATxdqUH0Kcfwa4e0V3gYVu1BrqxvO8sWNsBYoTMaJIfVI97f5zHx1NUUoeMLKA4
Message-ID: <CAJZ5v0j5RsZ-QcX1HsVifxKuKXxqF50nrqSf38i=qyBZQSM2fQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add interfaces for ACPI MRRM table
To: Tony Luck <tony.luck@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, 
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 7:38=E2=80=AFPM Tony Luck <tony.luck@intel.com> wrot=
e:
>
> This series based on:
>         https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git/log/?h=3Dtesting
>
> Memory used to be homogeneous. Then NUMA came along. Later different
> types of memory (persistent memory, on-package high bandwidth memory,
> CXL attached memory).
>
> Each type of memory has its own performance characteristics, and users
> will need to monitor and control access by type.
>
> The MRRM solution is to tag physical address ranges with "region IDs"
> so that platform firmware[1] can indicate the type of memory for each
> range (with separate tags available for local vs. remote access to
> each range). Note that these ranges can include addresses reserved
> for future hotplugged memory.
>
> The region IDs will be used to provide separate event counts for each
> region for "perf" and for the "resctrl" file system to monitor and
> control memory bandwidth in each region.
>
> Users will need to know the address range(s) that are part of each
> region. This patch series adds
>         /sys/firmware/acpi/memory_ranges/rangeX
> directories to provide user space accessible enumeration.
>
> -Tony
>
> [1] MRRM definition allow for future expansion for the OS to assign
> these region IDs.
>
> Changes since version 4 here:
> https://lore.kernel.org/all/20250429202412.380637-1-tony.luck@intel.com/
>
> *) Dropped patch 1. ACPICA changes have been merged into the linux-pm
>    tree.
> *) Removed spurious blank file from mrrm_init() (Thanks, Fenghua).
>
> Tony Luck (3):
>   ACPI/MRRM: Minimal parse of ACPI MRRM table
>   ACPI/MRRM: Add /sys files to describe memory ranges
>   ACPI: Add documentation for exposing MRRM data
>
>  include/linux/acpi.h                          |   9 +
>  drivers/acpi/acpi_mrrm.c                      | 182 ++++++++++++++++++
>  Documentation/ABI/testing/sysfs-firmware-acpi |  21 ++
>  arch/x86/Kconfig                              |   1 +
>  drivers/acpi/Kconfig                          |   3 +
>  drivers/acpi/Makefile                         |   1 +
>  6 files changed, 217 insertions(+)
>  create mode 100644 drivers/acpi/acpi_mrrm.c
>

All patches applied as 6.16 material, thanks!

