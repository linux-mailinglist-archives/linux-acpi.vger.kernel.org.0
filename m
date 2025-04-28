Return-Path: <linux-acpi+bounces-13338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151AA9F91B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFE189CBAC
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E92973C6;
	Mon, 28 Apr 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kevOHOL0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F52973BB;
	Mon, 28 Apr 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866938; cv=none; b=n6OIpzh9kc+SV3Thq0JdmJUKBsFRBDBwFjial7SsBne6vcBNZYY72bF5DWWe9DoGxNskDHm2C9cMWDH0CcVp5AsSf1DRDTWzHEc8ON4JApRu+Mgvxjg+CvNaYMTWndrFJY6ATn3DDdGwg9qJ6gC1tEnXCYF9i39o5Yailkvin6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866938; c=relaxed/simple;
	bh=LKxsD25S1RJIfuOP84cut1U1IiJUdfmmJCtJq9tjz3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiobBujUlzXgUukSXY+uTku2LRObcNdYB5OhtzLPG9JIW85+bQjjs5OndzAIbLNhDIFh9WfueFUWAzXE/SfwoM2YKZNmM7BjRBJzHngyO7L5qlk0ucaZrAOXtiV1pc+CUi8QSqSomhszriS2JV0f/i3nPznlJAjw2qow8NB4qI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kevOHOL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7FC4CEED;
	Mon, 28 Apr 2025 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745866937;
	bh=LKxsD25S1RJIfuOP84cut1U1IiJUdfmmJCtJq9tjz3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kevOHOL05wuhU4XapdR7a5W8fdNeJBUdmX/SNAWukxCVNMECnef+Chj3YLMwhf/y8
	 Ym+3n0cXW7m4+SxIrNEH7iSJqX5Ad3FDIi5JcKM+06yKhyLqXbfhE9MzaiIqh+aAj/
	 +f12uwgUeMGDmj/WGrk3KJu0wV6PwTvNBAN2euhtq5HgqJOk8yxIL4zQpGh1ibYQsd
	 uK7Tk+4tP28DpklxwsKFImtcThnOYWjGFpBdytrKRQcRR9adr56ekV3TkAzO+69yJd
	 E5xFfHa1KYCFbhTiDX2WzcAypxPah5qmQ74LvpfT/1eUwyAVayJvii3GQxnQ3T3or1
	 c8bw06YEtmLjA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d9b61e02d1so680121fac.2;
        Mon, 28 Apr 2025 12:02:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3l6ODG10q5e0U4ypA5CnaYHeOhDeHtX5pRoWJPl2QlzoxLnOh8kh2yZXn10XvUGkgSTE/ZozhR1DZCwUPaANIxSOuoA==@vger.kernel.org, AJvYcCW6noUlhznrs0EAS7V9jZtuw1mYS74qOTjjcS2cachdfzDIdhy0b/k7hdn+u+jkcayBon2i6joByQ4P@vger.kernel.org, AJvYcCWARENICJE6zhakXPmnks+8cy/zr/kAnt3UcvFj0qo/nSvB3y7+nxuzcljAyWi7XHZ1q4otlR51mNQ6aQyp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZGn+khe1ftyc0KQAllIYY2aqzb/2Kh3REcSzR+zRCCsAF674
	qESGLJu7Gwvzj7tYsg++AEV0JomX2hnEMWAcxPoK6FPmy+65zkFP380cC4cw68i8wLoo4OhwOIy
	g7VoqmkMTiOXkh85Nv9CP1fQpqGc=
X-Google-Smtp-Source: AGHT+IEcCgkMxWE97j27UCN9qkmL5Lr4PXGLmDAQswD4XACT8Z/diUgye1oNcWXiZY+C3ItQ76vFotE5iqeDBguJjl0=
X-Received: by 2002:a05:6870:4790:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2d9be58d47dmr5756642fac.13.1745866937129; Mon, 28 Apr 2025
 12:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5dd019ad4506.2100bf0f83374@gmail.com> <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com> <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com> <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
 <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com> <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com>
In-Reply-To: <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 21:02:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
X-Gm-Features: ATxdqUHHBaekJ57BrjZ2a74PkNR6gV7ExWlFCialFGkGs0hqLBdaafSDn1dwxsM
Message-ID: <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Marcus Bergo <marcusbergo@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, mark.pearson@lenovo.com, 
	linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:23=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/28/2025 4:51 AM, Marcus Bergo wrote:
> > Yes, it does.
> >
>
> OK thanks for confirming.  Considering your finding with this patch
> you've shared and knowing there is a timing dependency that delaying the
> next s2idle cycle helps I do wonder if we should keep exploring.
>
> Rafael, do you have thoughts here?  Specifically do you think it's worth
> revisiting if b5539eb5ee70 was the correct move.

Well, it was done for a reason that is explained in its changelog.  I
think that the problem addressed by it is genuine, isn't it?

> > On Sun, Apr 27, 2025 at 11:06=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
> >
> >     On 4/27/2025 1:34 PM, M. Bergo wrote:
> >      > It does make it work fine for me, I saw the clock/timing
> >     interference
> >      > and this sane this problem for Lenovo as well.
> >
> >     Huh?  I think you have a typo; but I don't know what you actually m=
eant.
> >
> >     So you're saying the timing patch helps your system as well?
> >
> >     Thanks,
> >
> >      >
> >      > On 4/24/25 11:11 AM, Mario Limonciello wrote:
> >      >> On 4/19/2025 1:03 PM, Mario Limonciello wrote:
> >      >>> On 4/19/2025 4:28 AM, M. Bergo wrote:
> >      >>>>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17
> >     00:00:00 2001
> >      >>>> From: Marcus Bergo <marcusbergo@gmail.com
> >     <mailto:marcusbergo@gmail.com>>
> >      >>>> Date: Sat, 19 Apr 2025 05:19:05 -0300
> >      >>>> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AM=
D
> >      >>>> platforms after
> >      >>>>   suspend/resume
> >      >>>>
> >      >>>> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen
> >     1, HP
> >      >>>> EliteBook 845 G10)
> >      >>>> experience a CPU frequency limitation issue where the
> >     processor gets
> >      >>>> stuck at
> >      >>>> approximately 544MHz after resuming from suspend when the
> >     power cord
> >      >>>> is unplugged
> >      >>>> during sleep. This issue makes the systems practically unusab=
le
> >      >>>> until a full
> >      >>>> power cycle is performed.
> >      >>>>
> >      >>>> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: =
Fix
> >      >>>> acpi_ec_dispatch_gpe()") which restored the behavior of
> >     clearing the
> >      >>>> GPE
> >      >>>> in acpi_ec_dispatch_gpe() function to prevent GPE storms.
> >     While this
> >      >>>> fix is
> >      >>>> necessary for most platforms to prevent excessive power
> >     consumption
> >      >>>> during
> >      >>>> suspend-to-idle, it causes problems on certain AMD platforms =
by
> >      >>>> interfering
> >      >>>> with the EC's ability to properly restore power management
> >     settings
> >      >>>> after resume.
> >      >>>>
> >      >>>> This patch implements a targeted workaround that:
> >      >>>> 1. Adds DMI-based detection for affected AMD platforms
> >      >>>> 2. Adds a function to check if we're in suspend-to-idle mode
> >      >>>> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD
> >      >>>> platforms specially:
> >      >>>>     - For affected AMD platforms during suspend-to-idle, it
> >     advances
> >      >>>> the
> >      >>>>       transaction without clearing the GPE status bit
> >      >>>>     - For all other platforms, it maintains the existing
> >     behavior of
> >      >>>> clearing
> >      >>>>       the GPE status bit
> >      >>>>
> >      >>>> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7=
 PRO
> >      >>>> 7840HS and
> >      >>>> confirmed that:
> >      >>>> 1. Without the patch, the CPU frequency is limited to 544MHz
> >     after the
> >      >>>>   suspend/unplug/resume sequence
> >      >>>> 2. With the patch applied, the CPU properly scales up to its
> >     maximum
> >      >>>> frequency
> >      >>>>     (5.1GHz) after the same sequence
> >      >>>> 3. No regressions were observed in other EC functionality
> >     (battery
> >      >>>> status,
> >      >>>>     keyboard backlight, etc.)
> >      >>>> 4. Multiple suspend/resume cycles with different power states
> >     were
> >      >>>> tested
> >      >>>>     without issues
> >      >>>>
> >      >>>> The patch was also verified not to affect the behavior on Int=
el-
> >      >>>> based systems,
> >      >>>> ensuring that the GPE storm prevention remains effective wher=
e
> >     needed.
> >      >>>>
> >      >>>> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
> >      >>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D21855=
7
> >     <https://bugzilla.kernel.org/show_bug.cgi?id=3D218557>
> >      >>>> Reported-by: Mark Pearson <mark.pearson@lenovo.com
> >     <mailto:mark.pearson@lenovo.com>>
> >      >>>> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com
> >     <mailto:marcusbergo@gmail.com>>
> >      >>>
> >      >>> Great finding with this being a potential root cause of this
> >     behavior
> >      >>> (at least from a Linux perspective).
> >      >>>
> >      >>> Although this helps, I'm not really a fan of the tech debt
> >      >>> accumulated by needing to quirk this on a system by system
> >     basis as a
> >      >>> bandage.
> >      >>>
> >      >>> At least for HP someone said that this commit happens to help =
them
> >      >>> for the same issue you're describing:
> >      >>>
> >      >>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform=
-
> >     <https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform->
> >      >>> drivers- x86.git/commit/?
> >      >>> h=3Dfixes&id=3D9f5595d5f03fd4dc640607a71e89a1daa68fd19d
> >      >>>
> >      >>> That was surprising to me, but it must be changing the timing
> >     of some
> >      >>> of the code running in HP's EC.  Since you happen to have a Le=
novo
> >      >>> system does it happen to help the Lenovo EC too?
> >      >>>
> >      >>> Mark, comments please?
> >      >>>
> >      >> Someone just reported that the timing delay patch helped their
> >     Lenovo
> >      >> system as well.  Can you see if it helps you too?
> >
> >
> >
> > --
> >
> >
> > *
> > *
> > *
> > Marcus Bergo*
>
>

