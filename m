Return-Path: <linux-acpi+bounces-11652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CDA4A453
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 21:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4593B5753
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4B14B092;
	Fri, 28 Feb 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYxLngYQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CF23F388;
	Fri, 28 Feb 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775110; cv=none; b=e/6tjKDwXRv0QDLaTxPjP+oOUsHFwBJZL2b6QmSWEwudf9UUAM7LkdDNQUDvu2oNmtFsT8RFupkdb3DIL143lGGemAFNmK1lZPrxOgAWCmh3dlSS7F00jFBJ1McznLZhCXNyfji6PiHMF8oMa1cw9ypY+T3P99V2BtvS4VhERsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775110; c=relaxed/simple;
	bh=EwFVnCQd6HinaOBLRVd+9/xUTRIjhFRsaMXEDl9fxDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciRhYu8HKtDv6fvwBXlzFvQh8Biw/1034kBQhdzZNPMoTdTty8CszvmDlD6JIuQXhAp35Kieawnb/obD3SbQQjKs5TtO12kRV+8Oa+GaWhPP31vmg8XoTmm+iRrJPC+qP+rtYWUqL4Xt5iDGz1DQxY+dA2ZuB9qLT+BPjsFhnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYxLngYQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46fcbb96ba9so31443321cf.0;
        Fri, 28 Feb 2025 12:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740775107; x=1741379907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtnGxj9EqjKJY0q4XFl30n9aa5bS88PcFq7XjOAFU4=;
        b=mYxLngYQmmqSfjoJzw59o77LfnbueE+xFKG5H0JResxTQF/PFKWWRqMpkORa2E3ylf
         sSLKcxso4sWXSiBq966BFJaISTop5oGc3MuMMC1xwlIUVg9PwpBPkNFMkW5Zm2S1TvEW
         IILaXE41BC7/mWkl4G3QzlnRZmtz+dgq1F8B22FSSPSwtL4FJQtNb7jdjuxS1jvbwpz0
         driqw+0gCenClA13PwkQTPnMU/ghUzVYWthdkuJuETWsDDIGHhPKBML+0KUXoJnJaaWh
         DAB2leDhznacNlvHceaveYXA4i9QMdZEU2ZU8/KTGvbV8zujBVl7pEdoMRhNqsXe9kVE
         Jr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775107; x=1741379907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQtnGxj9EqjKJY0q4XFl30n9aa5bS88PcFq7XjOAFU4=;
        b=qz7FlhGsNH9e+LVLOCL/GmIHUuECD7/g1qmgINhG12IYpPC18z2AX+ZZwQE8tqcUQA
         Tw8Pei+mVrDpIKdTAJP5luPgL8lwHrx91WYEEQuXvOgkkS+56ryDgtBTBAg/EbMUe47P
         cidE6MTUj8QZAlmu2g3COdDJ2h7PC1YigLcgPK5ex732I2UX3QkybgUAdTj85zTsuEeW
         mv3tjE4rc5Jt3MLx5lLJcc5v4opi0C9zn7iWaTXN3hOieDRk2E5C2xot9f+nl+4N0y2f
         U/bdXdYKv2Timqm1BkiY8QbyeqrV5HXN6y5Ucqj5Z7hwwjpFWDod4pDQMyNb9L3HzQdV
         Gllw==
X-Forwarded-Encrypted: i=1; AJvYcCVLq4PlslyNZSnKDyuM10L6Y8dnmxOb/1UlcCInklWn0FaJ1GiTSmZEwn5PkytUu5qS4Zxx6nh8srRAaN4z@vger.kernel.org, AJvYcCVknYRNOhUtKTqC8pFRPhnt48lGU5J34DwRrX/S7o3uSiUmVnSQs1qsYZ3PMDE54qdlA8UJrLImEc9W@vger.kernel.org, AJvYcCVucZ35/azJLAGf+E3YFldQ8hUTR68raqTL6cDb+JmUpFjgAEq2wdOduSzX7J4PgwnAk//3PWlWSRm8zrg2F6QejjyVSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xXvNcONYCMw2bugKTCZxUDA+j/PEmTrw1RKwNIdDwr6GuE/a
	8PluZDBD61gxo+B0XCA3iqdqQ8nRXO0ArBLW3OoRgEmPX52Te/RrFOvGB2vYRM4pUExdPh3///R
	U//a7RfMrSu+1trlJr3hoUVUW62U=
X-Gm-Gg: ASbGncs8OoE9yaY99EkT6zzW6WWE7DXll6FdxPvg2n6owcpfYM1zq6/axRAsiWGlFMP
	MJoKB9xvEeazJpw5gCts8sLVbI1ue6+g6IgHJOhabQ5BnP3XTyJO4ONZOxKwfo2m5aO8OqX+xYP
	DPz0kKpbA2qi4jxqpGzE56YPcHLpM=
X-Google-Smtp-Source: AGHT+IEwxnMnsI1dGRYfaUNIGoNCheiqoTjMdjaY9C+voUgNVf4dIq2zzfq/+sshxFmZa32Dj0+elYtwkLDTEeak4cg=
X-Received: by 2002:ad4:5f0a:0:b0:6e4:4331:aadf with SMTP id
 6a1803df08f44-6e8a0d05614mr78554026d6.23.1740775107310; Fri, 28 Feb 2025
 12:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Fri, 28 Feb 2025 12:38:16 -0800
X-Gm-Features: AQ5f1JrcbmmOjX6pqOEaG08stYfdXyf_n3rLygue2VU1W-R76oeG0lTCtBN3peg
Message-ID: <CAFqHKTkCnSxUMoR76vibC394wkgdU1hQLrt0TAAyya95QOxJWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch, 
	Denis Benato <benato.denis96@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:02=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers provide platform profile handlers but use different
> strings to mean (essentially) the same thing the legacy interface won't
> export them because it only shows profiles common to multiple drivers.
>
> This causes an unexpected behavior to people who have upgraded from an
> earlier kernel because if multiple drivers have bound platform profile
> handlers they might not be able to access profiles they were expecting.
>
> Introduce a concept of a "hidden choice" that drivers can register and
> the platform profile handler code will utilize when using the legacy
> interface.
>
> There have been some other attempts at solving this issue in other ways.
> This serves as an alternative to those attempts.
>
> Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257=
-5b8fc6c24ac9@gmx.de/T/#t
> Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUa=
Xf=3DBVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738=
170dad45232fd18
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Cc: "Luke D. Jones" <luke@ljones.dev>
>
> Mario Limonciello (3):
>   ACPI: platform_profile: Add support for hidden choices
>   platform/x86/amd: pmf: Add 'quiet' to hidden choices
>   platform/x86/amd: pmf: Add balanced-performance to hidden choices
>
>  drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>  drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>  include/linux/platform_profile.h   |  3 +
>  3 files changed, 87 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>

Everything seems to be working as intended. I applied these patches on
top of my lenovo-wmi series modified to always show
balanced-performance and with quiet as the lowest profile. Testing was
done on the Legion Go.
Results:

$ cat /sys/firmware/acpi/platform_profile_choices
quiet balanced balanced-performance performance
$ for f in *; do cat $f/name; cat $f/choices; done;
lenovo-wmi-gamezone
quiet balanced balanced-performance performance custom
amd-pmf
low-power balanced performance
$ echo quiet | sudo tee /sys/firmware/acpi/platform_profile
quiet
$ for f in *; do cat $f/name; cat $f/profile; done;
lenovo-wmi-gamezone
quiet
amd-pmf
quiet
$ echo balanced-performance | sudo tee /sys/firmware/acpi/platform_profile
balanced-performance
$ for f in *; do cat $f/name; cat $f/profile; done;
lenovo-wmi-gamezone
balanced-performance
amd-pmf
balanced-performance
$ echo low-power | sudo tee /sys/firmware/acpi/platform_profile
low-power
tee: /sys/firmware/acpi/platform_profile: Operation not supported
$ for f in *; do cat $f/name; cat $f/profile; done;
lenovo-wmi-gamezone
balanced-performance
amd-pmf
balanced-performance

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

