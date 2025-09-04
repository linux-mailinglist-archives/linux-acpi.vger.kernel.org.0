Return-Path: <linux-acpi+bounces-16376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F137B4455D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1633417BB60
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F26342CAD;
	Thu,  4 Sep 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aicl2QwS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06092405FD
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010498; cv=none; b=GMNzsLH4K7d+UYLbtzINLJ7yUVF2FK0PDVHpxa3+jjFxCWqKaFvYQBKJNYFccknkG274dvjBwnWLV0s5ex7GYXMkpF9k95kzceA6TuN+gBsWA9LR5yqyC4o7IW3fnq/6GGdS7zaaBC7Ao0DvHqEDE3DY+ZvK7s+wwy0twI/Dd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010498; c=relaxed/simple;
	bh=CJqgVDJvwkn9vfe6h0jAYKqtK3KcjKuGhEAdU7ur+Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoC25x4Vw0V7mWq5dmmnoTtu8f2T2X8p21HTBvo4YsbslKvLiAxup7hitFZO5I+5Fq9R+jmdxOqyNrVcMxIk1vt0cL2QWoPJH1r3a8G4DYgEiRjzcgbx8eruZZ25zAEDG/SS4khjdmnp48vv4HbV7G94OQMdNID0zOB+RjZebs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aicl2QwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66524C4CEF0
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757010493;
	bh=CJqgVDJvwkn9vfe6h0jAYKqtK3KcjKuGhEAdU7ur+Fw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aicl2QwSRB6C892xPudkLghYeAQeCljt0IYAKJLhSU+cWTkhADvre6jICvNMHvJw2
	 aILcOYnO+UZe+rWGjUodkJKl7Yt3f1njwVsiL4iild/JMWuCoJMw7zv9hjm0zeBTdx
	 BqnYjFkgpILX8axZzbrLS7Ij04GNCIdT8Dg+4z6KOll7rqp0xB7TQO5/JipMLzVs/9
	 rVZxtDQPfKM++cJm9mNkGJBSL+ofDUtmiz+KsNsOVCds8hipkT09WKq58zjqWN4vhK
	 ERioM2HzRB2+A2IKgoSbWwt/ODqpPomYZf9Q6XvDQ3Y0kVSjGr1uG9XcICTQeTKtjl
	 TNVoSYHQHJojg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61e74d053cfso315467eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2025 11:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUhe9EOFRwayc9tOAUgJstObI5Gd8IX1K1dh7K48MmBsEVnnsO0id6O2/PzGUf+k+UV99+jZvKb/TU@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxUR55Cb1DZdG5Myd+czEYwy0a8JTP+7mJp8zvk+iVZQemJLY
	FtkCZn7W9sON6E/EFWOyAj2wPvkc6rRKb1oHjDmTXE58EA5a/0ZT1twykDrofEltY6e4mfACtol
	yI0Jx/8oa3f0ummVUbekLmNU46woYk6Q=
X-Google-Smtp-Source: AGHT+IGxljUAQZzf/XD+NYZ618TB6RgO0/DRyF6fYg1wU+TeqF0oqTJojui0Dnwcr5m7A4qvsmYs0b2TLvuzscZwr6E=
X-Received: by 2002:a05:6820:4883:b0:61e:76d7:f1f1 with SMTP id
 006d021491bc7-61e76d7f7d7mr1678953eaf.2.1757010492544; Thu, 04 Sep 2025
 11:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829142748.21089-1-hansg@kernel.org>
In-Reply-To: <20250829142748.21089-1-hansg@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 20:28:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0in0N-29MJ81bFFQWz=pJvnsC-+D+noraWD7E1q5q18aA@mail.gmail.com>
X-Gm-Features: Ac12FXxQbWSvtFVdBs6bVnpqQREc93gJHQqM1G8bKCfSqMAeN3a5TCGnbgDRkqY
Message-ID: <CAJZ5v0in0N-29MJ81bFFQWz=pJvnsC-+D+noraWD7E1q5q18aA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
To: Hans de Goede <hansg@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:27=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Some x86/ACPI laptops with MIPI cameras have a INTC10DE or INTC10E0 ACPI
> device in the _DEP dependency list of the ACPI devices for the camera-
> sensors (which have flags.honor_deps set).
>
> These devices are for an Intel Vision CVS chip for which an out of tree
> driver is available (1).
>
> The camera sensor works fine without a driver being loaded for this
> ACPI device on the 2 laptops this was tested on:
>
> ThinkPad X1 Carbon Gen 12 (Meteor Lake)
> ThinkPad X1 2-in-1 Gen 10 (Arrow Lake)
>
> For now add these HIDs to acpi_ignore_dep_ids[] so that
> acpi_dev_ready_for_enumeration() will return true once the other _DEP
> dependencies are met and an i2c_client for the camera sensor will get
> instantiated.
>
> Link: https://github.com/intel/vision-drivers/ #1
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
>  drivers/acpi/scan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..9865faa996b0 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -845,6 +845,8 @@ static bool acpi_info_matches_ids(struct acpi_device_=
info *info,
>  static const char * const acpi_ignore_dep_ids[] =3D {
>         "PNP0D80", /* Windows-compatible System Power Management Controll=
er */
>         "INT33BD", /* Intel Baytrail Mailbox Device */
> +       "INTC10DE", /* Intel CVS LNL */
> +       "INTC10E0", /* Intel CVS ARL */
>         "LATT2021", /* Lattice FW Update Client Driver */
>         NULL
>  };
> --

Applied as 6.18 material, thanks!

