Return-Path: <linux-acpi+bounces-14455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60359ADF6A2
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5717A19C6
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BE20C469;
	Wed, 18 Jun 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjGjfSj6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184E20AF98
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273831; cv=none; b=ZsWOOWhAxEEtyyrdAEV9OL34tuOYK7Gm7y/OH9WGVtDNlwBpqRuOCQB52xblDi4oDMwcXLts3ibjBd7QQ52zS1ut5J13hznK1B9DnxJi5+RR8yT/qIrPNL40DlL7IHB/GRYRFu5t91LaKyteKUgvjpOM7ypo8bLQpfLh9Zm/v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273831; c=relaxed/simple;
	bh=LNtjbqES+viExkrHH9IG6aTeSRQ5e9S7wWwi6C0gcq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuY+3PZ2TVmWC15HOi4S7bgrI2brR1QZ4VGTGf/CtlaJl3iQRKtMPG5ryNerpOzn+yCNaWQm2o/oPLB+0bx/R5GR3bgppTMCOTWho9I8OuWoiBAAJMoA3RDJxUhHk/0axUQXIlzvQoM39jxNrd4LgT1c2o1fxIgj8rCQigWLlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjGjfSj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9C0C4CEED
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750273831;
	bh=LNtjbqES+viExkrHH9IG6aTeSRQ5e9S7wWwi6C0gcq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MjGjfSj6fxLO3bzimQu826YuhL8TBxygryOCnP+jOuDr5SoDRQ7CXoiz9JZobztDE
	 +LHqiJC6azI3/fQ7S1Z89Ep3IhiKbzggzW6hh7cgR54tnB1tdJpjFF82wrM7n3ErWb
	 QXWbRTSmXk5qFEYe076hsc0zMvaTEsugZ6bcggq3Ole4NCNIN3sRAbKtQMSMa5pg2q
	 ueqSsQSkeoMClvA3fhJ5Q2s7dPi2k9AINeVcgU0nxs7uJfS127WRmjK/yezpMayZDQ
	 qfR0dIUoJu87pMcVBRmjWclDu/xdRvKOAiye9xes3I4L4nFAWzVQn9jhImHOg/c3d6
	 1sR3o0lRDoKDQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-739dcdb012fso13522a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 12:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOztGKJ48kMJdzZBcWPK6534jeX8EEa9OUrUQJmPfv/qmLKB9+ZVZXPY1If4y3Z2zGjkdj6KmLELQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+VixJtsel8JoYoTEG74uoVNti6YFFWzZt3JHoxmcJkbQ+2WR
	1QRZa2xTUUOfGyNXKSZzNRvom74v3uXtE2XeGiPSH0qdaHxXdHku6Dc4Bh0thahdEisFpvbG1Oi
	IG7GgPvnvufnjntp2FJyKnouuV16dHzk=
X-Google-Smtp-Source: AGHT+IF0QOwQ+T00QX63R9TzvT+Jx52NHSC6gUxtASuwfvCK8/jYGmmp2e8pvLDJsPrEUA62mgVt/3EU7XI6Ts4UPAk=
X-Received: by 2002:a05:6830:3812:b0:72b:9387:84b2 with SMTP id
 46e09a7af769-73a363940b3mr13667932a34.27.1750273830542; Wed, 18 Jun 2025
 12:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609030706.465202-1-superm1@kernel.org>
In-Reply-To: <20250609030706.465202-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 21:10:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwn9tXAB7SOSHutjEm2We8v2Dg78CR6OP8nU=v_nU6zQ@mail.gmail.com>
X-Gm-Features: AX0GCFvVtyeONWa4O7z-3hA7kgK1rd_kxS-d1fjXovv_aKgY3S3KCif_Cy-kdS8
Message-ID: <CAJZ5v0iwn9tXAB7SOSHutjEm2We8v2Dg78CR6OP8nU=v_nU6zQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:07=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
> systems to identify a BIOS bug.  It's a relatively small size increase
> to turn it on by default (50kb) and that saves asking people to enable
> it when an issue comes up because it wasn't in defconfig.
>
> Enable it by default.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1: https://lore.kernel.org/linux-acpi/20250415212740.2371758-1-superm1@k=
ernel.org/
> v2:
>   * rebase on 6.16-rc1
>   * Fedora, Ubuntu, and CachyOS are all doing this in their distro kernel=
s
>     and haven't had any complaints about it.
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7bc40c2735ac0..b594780a57d71 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -394,6 +394,7 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>
>  config ACPI_DEBUG
>         bool "Debug Statements"
> +       default y
>         help
>           The ACPI subsystem can produce debug output.  Saying Y enables =
this
>           output and increases the kernel size by around 50K.
> --

Applied as 6.17 material, thanks!

