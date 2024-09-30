Return-Path: <linux-acpi+bounces-8504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4F98AC7C
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53F41C21B87
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FB198E93;
	Mon, 30 Sep 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDTpP8m+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5974153BD9;
	Mon, 30 Sep 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723045; cv=none; b=QEPax+sq7wjBxrG2Ma8cHn/+urehtyvug41u6J7BwW4sxLywTWOifrEOg1Vge2EkfKB+EVRlc/GZiYkxB+V/hLhSiuwKOmW7Svkgf+DSB6qXSgesDLMAM38DwnFTfe90x2XAR+9+Bb+X1vkE0c6V/39v02BTqtz2/L8b+gZ1SkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723045; c=relaxed/simple;
	bh=e6/lb4h3dcPvUj2TD9KX5+dXrCl8l2K+qw6RADogTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnxtoCXoxKE4FyCWbnhk4CdGw15vdR+khoM0kfvVO2xi8mvcBJA3chUFiB+b7Lft8qPIjq/vuSfpmxcHA96M67rCndsuFhha6h3qizC7qkhKyyAKU5E3b15ikhef1CRs+3pqak8nYFytbmBrHQjDbYzAFoxcM8kYflqr6q6PEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDTpP8m+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542D0C4CECE;
	Mon, 30 Sep 2024 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727723045;
	bh=e6/lb4h3dcPvUj2TD9KX5+dXrCl8l2K+qw6RADogTTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KDTpP8m+mA4pqkFNJVRsWbh/d1FO/Djln9npkcRgdiXjzhZmltRPl7kTJ85iNWmKW
	 u7mqTPsPK9N96rPk8k5yR35MSYQIjx0iGi2hXoTHWEHrHVkx0I8KpgrH1vSl+ZymKZ
	 sXWs9DMfS7Ed2vkAXD9XgVGjqjQcKWqzgnJok06U1Q+SDHb04KnXyjtDZmU/YEbpN1
	 eK0vGwxPqCjcHgsOXfSZgfon1ri5E2M1zIagbZncRqNZVQM1rUn9FEtgvoKFR6Uzex
	 puXzpzpIOIdVNxly4pKht5bSFexcehP16k5jnSFbYM8w5eJ3Qgb9zzicKvLEfT5333
	 FdGNmeR3aqpmg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710e910dd7dso3404849a34.2;
        Mon, 30 Sep 2024 12:04:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQiDycU3FBw6Hw0D0Sv5ovrIkVHEY3WCIj7WV+QcHIaE9febvqCnWfO2oPNvF67/l+tZaqa1ELseHI@vger.kernel.org, AJvYcCUzYEyZRHL7QI0sHEf76/k9vqEWwqAyhJq4epUf5Nl/A0aimDbe2ehK8ficOjfLg/MolLAiwuRMRVidl1OU@vger.kernel.org, AJvYcCWxNnVoD+cP3w0RbYWnTCjg/LWIyqrCeEtdY4GAGRcBhQhfL3KlJnX6lH5Gs31a2b/5KGGRMSrjVcfvHMCxHFxPbbcyTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/8aRKFFZrUC8fP5b96VUNqVQYofIZY0xI3BD77s6G/lAemxU
	nDzHZSgItKi5xVXk123zmDw/NXkps3To94OFzgiRDI6Z77q4mdOHRSRNx1fWeg2soUxm6/yk054
	HnTygY2DN3xP5qEevoEjMOf2cBLA=
X-Google-Smtp-Source: AGHT+IEkvKq00Zd5Xgo+FpHgEmSOlof2ytB9S1tad7MI4lv5aIHonYRW5LWKLkZGKbmqOACBcBEhA3x2ysZ6GW4cdQE=
X-Received: by 2002:a05:6830:6282:b0:713:7e24:6151 with SMTP id
 46e09a7af769-714fbf0ba08mr9676408a34.25.1727723044676; Mon, 30 Sep 2024
 12:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922064026.496422-1-W_Armin@gmx.de> <92b62046-d225-4dd8-a894-30f051267f29@gmx.de>
In-Reply-To: <92b62046-d225-4dd8-a894-30f051267f29@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Sep 2024 21:03:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcJOVU-B3f34OJqHDQ1=2vKHifmqmTqH=Qi+c+Uaboww@mail.gmail.com>
Message-ID: <CAJZ5v0gcJOVU-B3f34OJqHDQ1=2vKHifmqmTqH=Qi+c+Uaboww@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
To: Armin Wolf <W_Armin@gmx.de>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, dilinger@queued.net, 
	rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:53=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 22.09.24 um 08:40 schrieb Armin Wolf:
>
> > This patch series fixes some issues around the battery hook handling
> > inside the ACPI battery driver and the dell-laptop driver.
> >
> > The first patch simplifies the locking during battery hook removal as
> > a preparation for the second patch which fixes a possible crash when
> > unregistering a battery hook.
> >
> > The third patch allows the dell-laptop driver to handle systems with
> > multiple batteries.
> >
> > All patches where tested on a Dell Inspiron 3505 and appear to work.
>
> Any thoughts from the ACPI maintainers?

The first patch looks good to me, but I have a comment regarding the second=
 one.

I'll get to this tomorrow.

> > Changes since v1:
> > - fix the underlying issue inside the ACPI battery driver
> > - reword patch for dell-laptop
> >
> > Armin Wolf (3):
> >    ACPI: battery: Simplify battery hook locking
> >    ACPI: battery: Fix possible crash when unregistering a battery hook
> >    platform/x86: dell-laptop: Do not fail when encountering unsupported
> >      batteries
> >
> >   drivers/acpi/battery.c                  | 27 ++++++++++++++++--------=
-
> >   drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
> >   include/acpi/battery.h                  |  1 +
> >   3 files changed, 31 insertions(+), 12 deletions(-)
> >
> > --

