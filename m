Return-Path: <linux-acpi+bounces-17235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A11B96F78
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8CA165D59
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E92749C4;
	Tue, 23 Sep 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFiXw4HX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055725FA0A
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647536; cv=none; b=MTG4BIacTSDtn6CPwR1g5yjvO+gbH/QWEq0Km3h5e4/oXtqtv4SFjiwdP7Gn8AXV7ZNRK2tGZDmZ/5ZdVXNZslmgoZV2kpGzU9x4biLrb8UmqvP0slj15DNEcnCDQrTmbZMGTtLf0BzCdROw+F+o4F2pKqgcV5pY42mC+IGvS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647536; c=relaxed/simple;
	bh=zmjtE0Pg9ybScWl+KNxugj6NRHATWz4NuVjQRnO/EH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMbh8wwKIwL1ZJflkZrppVVOLDYEL5ZyGltkmPVLs8A6Sj2VV0/pF14fvkRbjTzZ1SSBBK8vgE6kuvxK4DU//gZk5lO3AD5WNN1Vntg0YSrAeYcxREvv/wh+g8TGx3PKvochXxCXzYysS+NEHBw066amY92qN4MbF0qF/C7wZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFiXw4HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD8C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647536;
	bh=zmjtE0Pg9ybScWl+KNxugj6NRHATWz4NuVjQRnO/EH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hFiXw4HXVUrg8mFx6KKpJWQ0zXf/ujKcPwAJVY8w9Pe8+GwDQlyEgjP9TPyHGRKqk
	 qwN1/gBzoghKyIGpb/IjHqxv0JvBW28w0gS6eJqRhRmGKDUjFUFxFr4VJ+XeHB0s6M
	 O3bxOkSoyHY4oX+YJ/tEaQkqEjJrHb78henzjV4qX/0hCUgcnJKvrimN/8Kohvyjth
	 bLjtL6mSaUR3z7xmgi2rNbGg7ZTOsMAYgVjFaoa7NbqFsKx8ia2i62iyIZ7j7fsjIY
	 V3RunUfoCb44Nw6xK6vFWE3HpdmzOi0DpW5oOqo1n7VOW0uXOv2hWw61lIpv+5Cmmw
	 pJsS3+AJSX/yg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43d2da52291so48900b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 10:12:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGBrtdn5RKanYU4obAZX09vEkJ6W4owarswOFGrw51yhW2SjJ3qzCRdimpQC+S9Ebo8zH2tyYLLyrt@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGdE6nnKoCQEh5pzZfW44m5tL+EW3ffr74LnbCDAbF8BjByNh
	jBDor7XMqTZ3EaG3BMlEzcM6m/BFrVNHYupoRiO2/Wd7mLzv3ITaDedPoqg/CLbG/RSpJgt/RJH
	Zo1aqFZdTyVpzmGXah6LcjLE03RXyvM8=
X-Google-Smtp-Source: AGHT+IHOSQyeOX2xQmbUmiEzFwBxhPqNMWpEZ/dCxFg/s6P9IdxrIKUnE1S3WMtRGifCWrHavSLPTmCtP0Eog9z2aqQ=
X-Received: by 2002:a05:6808:80a6:b0:43b:ea80:d169 with SMTP id
 5614622812f47-43f2d19768dmr1755849b6e.8.1758647535301; Tue, 23 Sep 2025
 10:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
 <20250923161354.1307251-1-luogf2025@163.com>
In-Reply-To: <20250923161354.1307251-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 19:12:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
X-Gm-Features: AS18NWD62UAzJRnQliopclNZf9FndoSJt3Hc02TH-qB6ft9kOc0CHGMVi2jrw98
Message-ID: <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, michal.wilczynski@intel.com, dan.carpenter@linaro.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:14=E2=80=AFPM GuangFei Luo <luogf2025@163.com> wr=
ote:
>
> The functions battery_hook_add_battery(), battery_hook_remove_battery(),
> and sysfs_remove_battery() already acquire locks, so their internal
> accesses are safe.

In fact, there are two locks in use, battery->sysfs_lock and
hook_mutex.  The latter is used for managing hooks and the former is
only used by sysfs_remove_battery(), so it only prevents that function
from racing with another instance of itself.

I would suggest using battery->sysfs_lock for protecting battery->bat
in general.

> acpi_battery_refresh() does check battery->bat, but its child
> functions (sysfs_add_battery() and sysfs_remove_battery()) already
> handle locking.

What locking?  Before the $subject patch, sysfs_add_battery() doesn't
do any locking at all AFAICS.

> In acpi_battery_notify(), battery->bat has no lock. However, the
> check of battery->bat is at the very end of the function. During
> earlier calls, battery->bat has already been protected by locks, so
> re-entry will not cause issues.

All of the battery->bat checks and the code depending on them need to
go under the same lock.  I'd use battery->sysfs_lock for this as
already mentioned above.

