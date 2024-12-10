Return-Path: <linux-acpi+bounces-10037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2379EB980
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC96283700
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177E214203;
	Tue, 10 Dec 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGtFg/bG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB443C17
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856162; cv=none; b=atEw52fyA5XZXUiDY39ZpcfUlPoHOTWA2TRrQUsPHOTEwC69IJCtKh72j+vfuKv9Ejbr/XpuQxj382h4cL25iy7fdmRcwGcpsI9MvMeNP5oDirnt4teT/mEPT7iSFnvxwv04q6s2REvBx87GQkPvCZigkQENJFg6p93EPmuFaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856162; c=relaxed/simple;
	bh=TaenTo/D5lpfw/+dfYWqC7VX0153OxLSOdagLTK7e5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdJGQIzHuWR9e8mz7OVRgyVju1V9d5jcA1v3c0czu2xSy0gGtwMYJPPouAfZOUN6PG9mDN2W+uEks2j8HMRaeQcU9EXhBo5p4AjmnYuU4kmGE0tL2H5JDh7ArkE1jf0qZ3IxPjRGIYqC4jFc5d6eSX6mg1Y/QMJlbeku1D8MDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGtFg/bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561FC4CED6
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856162;
	bh=TaenTo/D5lpfw/+dfYWqC7VX0153OxLSOdagLTK7e5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YGtFg/bGR/iRyD29tBwfpfrLR3m1kn0xXqHLaRknft2jWQeZHK+ZC+Vs2N3cpKcXT
	 3FmbfeKJoL4mSvwj8JdTXSgeye3xwltTIXw1fN7bb3BSWODCjbCEAjHFx3kzAZxr1u
	 /a1G6/eswG+lxjTUp22XRYvBnY52Z6Gfj4CYSPhEF1t/qHw984rwbMxD8Pbu4Zx8Sv
	 90k+iivJCOyYA1lQa5q/rgfSQJizF9fa3Vz9htAp6R9z7umigkNSsAGBQNX6qM9X7g
	 w85lS8up5He+LTkKKrwjm00aSL41a509IXBWL2wifomQybNBLEYPU1ch1fZALyTTK2
	 kTeBsh80x7b9Q==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e17ab806bso68553a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 10:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1w8EnPQmAG7DJelDaXg8coQIiHPW2LjZGvI34o+cG57Jz28Aaj8f9VXOiOUA2nXJoE5eSpqRPM1Qf@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLrO9Efc/vpZfI5Y65qWd+GU5UK8UEF8Xdvnu2IGoXdzy7wPQ
	Gvn3m+PAAF5DqxawFVI8D9nQNKmMVYDC6J2s+xNovAkm00k6Ac9kv0Y0ruXzhWJt+76BYezPxJt
	2oBio5hyKiEjrmoJs2PpYgjFXCjs=
X-Google-Smtp-Source: AGHT+IHQGG06qzgmTAlYu5HdSB7gtdF/uZivBXYDqxiedRS6suk9Oj9q9IQMMcopjYuKxzs9ywwCzSavpIPWn+BrCDg=
X-Received: by 2002:a05:6830:3107:b0:71d:4086:6072 with SMTP id
 46e09a7af769-71e021bae5cmr4465801a34.7.1733856161530; Tue, 10 Dec 2024
 10:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203033018.1023827-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241203033018.1023827-1-joe@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:42:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jywmZg3wEdtF5i7s4nDNi5XCh3=toH+dNOjGvt4ozFGg@mail.gmail.com>
Message-ID: <CAJZ5v0jywmZg3wEdtF5i7s4nDNi5XCh3=toH+dNOjGvt4ozFGg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: cleanup resources in the error path of .probe()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:30=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac.=
jp> wrote:
>
> Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
> error path of acpi_fan_probe() to fix possible memory leak.
>
> Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling =
device")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/acpi/fan_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 3ea9cfcff46e..8e3f62a3745e 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -379,11 +379,14 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
>                                    "device");
>         if (result) {
>                 dev_err(&pdev->dev, "Failed to create sysfs link 'device'=
\n");
> -               goto err_end;
> +               goto err_unregister;
>         }
>
>         return 0;
>
> +err_unregister:
> +       sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
> +       thermal_cooling_device_unregister(cdev);
>  err_end:
>         if (fan->acpi4)
>                 acpi_fan_delete_attributes(device);
> --

What if the creation of the "thermal_cooling" symlink fails?

