Return-Path: <linux-acpi+bounces-14952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB660AF60A2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612F3481CBF
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297F30B987;
	Wed,  2 Jul 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYhANU1g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF22E03E5;
	Wed,  2 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479151; cv=none; b=ZrMp8TXDjIg7YnPHDBK93uNMaBXrDqbtjziodKHNnM+0LitxGqOaX+k4crDCU5gXbT3X+mbLeDhox+KtAnx2sAqe02iUqYkjykSJz09x1pNVaydnxi/tZJvxGQRLgM0uMVhRvtMwO06IiKdcb+syQQF17giG9IlHpvuCdtnbJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479151; c=relaxed/simple;
	bh=ejLSgC1uoMdgciKFUaDzwmfUYCcPV5mhhLjNesM4X8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0dpTbsvQkjpJnO3QWuwpLqB4jPfpHmmD9g1ZDbm/lUjLqrRaRGcMpz2kP5P5IQPkjMoIh26uGXudpP1EonVvtnZ/H1KpZLSCtRvkupHS5uik6X8bb6tlSJtqPaHr1v3NkFyg5SloEsilZ7J7duMP4AzrW7PHlKBQrMOdeVObLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYhANU1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719F5C4CEF1;
	Wed,  2 Jul 2025 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479150;
	bh=ejLSgC1uoMdgciKFUaDzwmfUYCcPV5mhhLjNesM4X8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QYhANU1gkMsyNf2QTxORspLV1YQi+KUwNxR4CTrNOoaSlrEsEojioEx4TUGNslaNN
	 PJx8OOzSjUSU9aaEX7c4oGtNypZIoC2QTNeqJjm6HGjgGeKzJ3+R0mVAXHmmHxlFkS
	 sd0Bjq3XN+xcfW1/GmOVHaDViDwpWCw+VBy414fVXW9x09Z2+JEI+9WH/z2gXJkL/D
	 9n+MR/ibfEGUMJfoDuHYNkavhACCVbbEdyW29cz2ChB5oWPznX56V+ODZddeB0NyIq
	 T3Sd7TRtTc3qAMgoR2fVp3NtH3TSux5PCbZapJANAI/3XwxuiJXS0NMUiMQWTSJS3h
	 tykd2akEL5dNg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60402c94319so4137426eaf.1;
        Wed, 02 Jul 2025 10:59:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcQabF4G5frarYTrLk+KkQLrfiyQEloMHgLjNwoy7uZhz8MM3jeTiIceVq+K444f0hhwC7BkdKqrii@vger.kernel.org, AJvYcCXjwpzTtDPANLF/VV18waFLO21XgEhoz3PrQHLcqNtyokde/j7uGmzA1P1Wn+SITalgqkEI/2rO4SyDxmLt@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVrdrpBYe9XrS0DCN2dhVRZBAqchipcqJ7azqPLOY4fPsnPka
	buEzaJtEKfNxXugXVkoJMGm4SfjsnACgj5VPXVk9Y7JfVM2KFKBThAyYN/vic9ORBfpIfNTDPTl
	jMrDUDfIumDq2usmtfG4qe7pd3Q2VjCk=
X-Google-Smtp-Source: AGHT+IFtwxOfuU+hTN8l7xbxS21k5gWHtIuZhX36TQSUQWxipsCo4HX2rihGRkG3+sE19pPMEJ1wSBinwkY4UI8wLzw=
X-Received: by 2002:a05:6820:2915:b0:612:1:fec with SMTP id
 006d021491bc7-6120112db80mr2850651eaf.2.1751479149498; Wed, 02 Jul 2025
 10:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621055200.166361-1-abdelrahmanfekry375@gmail.com>
In-Reply-To: <20250621055200.166361-1-abdelrahmanfekry375@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 19:58:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hKLpD87YtPQfNJwNKyEDrQBKSdZLEKnUxTqj=tZ7DOeA@mail.gmail.com>
X-Gm-Features: Ac12FXyufNfEIcOtZX2dLmjnXJaaxREr56De8YNUVLJikqXysHxRXClR8YrVPe8
Message-ID: <CAJZ5v0hKLpD87YtPQfNJwNKyEDrQBKSdZLEKnUxTqj=tZ7DOeA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Replace sprintf/scnprintf with sysfs_emit in
 show functions
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, skhan@linuxfoundation.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 7:52=E2=80=AFAM Abdelrahman Fekry
<abdelrahmanfekry375@gmail.com> wrote:
>
> Update two sysfs show() functions in the ACPI fan driver to use sysfs_emi=
t()
> and sysfs_emit_at() instead of sprintf() and scnprintf().
>
> - show_fan_speed(): replaced sprintf() with sysfs_emit().
> - show_state(): replaced scnprintf() with sysfs_emit() for the first writ=
e,
>   and retained sysfs_emit_at() for incremental writes.
>
> This change is in accordance with Documentation/filesystems/sysfs.rst,
> which recommends using sysfs_emit/sysfs_emit_at in all sysfs show()
> callbacks for buffer safety, clarity, and consistency.
>
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
>  drivers/acpi/fan_attr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index 22d29ac2447c..6a53da3d6d82 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -22,9 +22,9 @@ static ssize_t show_state(struct device *dev, struct de=
vice_attribute *attr, cha
>         int count;
>
>         if (fps->control =3D=3D 0xFFFFFFFF || fps->control > 100)
> -               count =3D scnprintf(buf, PAGE_SIZE, "not-defined:");
> +               count =3D sysfs_emit(buf, "not-defined:");
>         else
> -               count =3D scnprintf(buf, PAGE_SIZE, "%lld:", fps->control=
);
> +               count =3D sysfs_emit(buf, "%lld:", fps->control);
>
>         if (fps->trip_point =3D=3D 0xFFFFFFFF || fps->trip_point > 9)
>                 count +=3D sysfs_emit_at(buf, count, "not-defined:");
> @@ -59,7 +59,7 @@ static ssize_t show_fan_speed(struct device *dev, struc=
t device_attribute *attr,
>         if (status)
>                 return status;
>
> -       return sprintf(buf, "%lld\n", fst.speed);
> +       return sysfs_emit(buf, "%lld\n", fst.speed);
>  }
>
>  static ssize_t show_fine_grain_control(struct device *dev, struct device=
_attribute *attr, char *buf)
> --

Applied as 6.17 material, thanks!

