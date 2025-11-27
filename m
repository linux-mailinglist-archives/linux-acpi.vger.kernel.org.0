Return-Path: <linux-acpi+bounces-19309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E1C8E5A2
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 821684E5BA1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEA32E723;
	Thu, 27 Nov 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkQiqe3/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F532E133
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248118; cv=none; b=sEijuIWVVgOHOC3aETCwyMVZpXwJ/+12m3G5IWq9H07PItpmTS99z7Puf9fGcMW15WSgLLqeqHEW6FswA44Gi7oF9RFbBU0tcthZQ6BuPpAXNv36USh9MQATgDYJ6Bc93obiDRiuQwrnC4h5nkrWjKUPSWZktPzgt03MLDYQ5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248118; c=relaxed/simple;
	bh=dUGRF8lF7tA2vX4lblMNqJH/DRQ4ErBqoNqHuVVWFjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETZ3FiWl9qAJ5ccmwLt0YQ8GVFWaHlr1y9zB3jsyhQPnEOEQP1t8oVxistl0VTrDQL08UGkU+67pGzpb/dh66/ujIsO8t0iKH43bgUb4spnpu8JVADmPQeMUrrlHwb+Y7XXbyVAkL2Hzt6LO92SyEEunQhImk9udjwCv8seF04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkQiqe3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E968EC16AAE
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764248117;
	bh=dUGRF8lF7tA2vX4lblMNqJH/DRQ4ErBqoNqHuVVWFjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lkQiqe3/7/IjSlWQrrnoWlLGnZM4QEcmKV904cYxvkGSk99x+sHNg5TRA511f5uoM
	 Up0iI/kLdWoqlPHT90IClejG07NbQxnb7Ie5Sp5qa90zE8Vl7e0/XEBETNBW2rxC5M
	 7iCV3HQHEqrSRigjPwgMDa/h3lFLV5yaYSJsFnJKZShNVaV8XCMonW8c5znjuDWdj9
	 QHr5fPcF2aBeK0FLZA+1joEXzYjGCYOYc1BQKsCa5LxDvVRDK6ylnAbw+dWOCtVo02
	 TEXnmNEuCPPJbLp+Gpc1euVcvvq0pQ05XRzrFsQgJbrAgnfyI0QwuRS8zKVJu8Kxwl
	 3p+qsKW4oKYNA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e80c483a13so193793fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 04:55:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwmTJkxaLzLrnvFiEiCsoNIJjJAV/M5gm53HZ6rQA7r/l8VDzxMoMneh4jyTrDqiu5UgR3W5k+r/MK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tBT5oy/cUOUP84q4LX4D2fzS/OKYgphTSS5it62H1+RIdAHk
	DW3wbqt7Ok06sViWOp2T0EGngnSiN9h5Q7f9EMdvDNgvGoa2WgvkTUuVlwEIQOk1nUXjDiKwmYM
	pQvimT8A0vK/Y7HtWBGz3/M+pMfqMcf4=
X-Google-Smtp-Source: AGHT+IG3VgM9jqMAEBJyhsAmlRpZEy6FWzjUKXMjEBIc+9i4rR5O3GLQNToVzvjSAtuUk9TbQ4bsXxBYMg0LYsRhTOg=
X-Received: by 2002:a05:6808:1491:b0:450:c9ad:491b with SMTP id
 5614622812f47-4511572eb09mr8622685b6e.8.1764248117257; Thu, 27 Nov 2025
 04:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
In-Reply-To: <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 13:55:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jHOZ2TerHXnG6ZoLO1QbyxO1ACGFAiJBxTsJmhSZsd8Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmMrP7Sjj6LjA54q4dLVLyqvv9yBuYGTyYemR-Oa3aAcWVdhI4p4CHqQqk
Message-ID: <CAJZ5v0jHOZ2TerHXnG6ZoLO1QbyxO1ACGFAiJBxTsJmhSZsd8Q@mail.gmail.com>
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 3:09=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
> Hello Rafael,
>
> =E5=9C=A8 2025/11/26 20:54, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > Hi Linus,
> >
> > Please pull from the tag
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >   acpi-6.18-rc8
> >
> > with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
> >
> >   Revert "ACPI: processor: idle: Optimize ACPI idle driver registration=
"
> >
> > on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> >
> >   Linux 6.18-rc7
> >
> > to receive an urgent ACPI support fix for 6.18.
> >
> > This reverts a commit that attempted to make the code in the ACPI
> > processor driver more straightforward, but it turned out to cause
> > the kernel to crash on at least one system, along with some further
> > cleanups on top of it.
> I just found that "ACPI: processor: idle: Optimize ACPI idle driver
> registration" depends on the change
> about cpuhp_setup_state in the commit [1]. Or many CPUs don't create
> cpuidle directory.
> What is the crash? Do you have releated trace?

Yes, please see

https://lore.kernel.org/lkml/20251124200019.GIaSS5U9HhsWBotrQZ@fat_crate.lo=
cal/

(from the Closes: tag in the revert commit).

Thanks!

