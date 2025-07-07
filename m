Return-Path: <linux-acpi+bounces-15044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8DAFB89E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE303ADA53
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40621A436;
	Mon,  7 Jul 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKoqafyS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5E202963
	for <linux-acpi@vger.kernel.org>; Mon,  7 Jul 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905769; cv=none; b=l5KAjzUP+/NtWRwTpkdhFezVMJGUw1EcelVt8H+YGeI/CObeYin6Kmpom+NJkjSTQuy4Rk6MGg/9WJ5JBTsoVa6H2vqulVr9BVFFoYtERmUAAfXME/b1or45zcCd9SC1PW8Fqr6ZF8MR5uBK6SmU0sbQz1CBVaY/bTDXD3m+h2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905769; c=relaxed/simple;
	bh=bhko6ECDeL8zvrhIQnBJPKWmddk3EbHXKIqWlf+o7K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC8c7Vyf2HI8xQADh3S0kfSeT8/44BEuhXM6EuQpmxqgOswgrWESme+BIoj6CqM0teGZ+QyKAa0UpDKoZIO1Fu5RJmCD38C4n9DCpSvsZLnwrGjAuBA/rcQ8jKqe5iDSi4783U2UqRvAf65HX9G41uQa0ih05LVHrwcfoK6DDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKoqafyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3A6C4CEF5
	for <linux-acpi@vger.kernel.org>; Mon,  7 Jul 2025 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751905768;
	bh=bhko6ECDeL8zvrhIQnBJPKWmddk3EbHXKIqWlf+o7K8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LKoqafySk9DoE+iHH2O1/9jD0tEGn4l/rQtQP+31JVkHfacsAsxetdnIGisHiUQqZ
	 qoftbwlbwr8Jh/ggWivj7QhXLfZKmF2MhFnEgrSKeLoMBfuiPd8lQmlsPBSs2LvBvz
	 yXALicunxn4UewKbB/AbKBh9sEk63JYxhnzr3cJu4a5cmYp15GZvoOX1nl7Tg51KAO
	 4ROT6J7H2CuXKE9c/jnVkCDstpvzxw/UUOrGgpRpyln5loj9wl/C0eK5wylppW1H5B
	 XLkfjoun0GeNmBENgDw6DornT3AP9+0rdgkN0semgUSxe9HlDi45N7M1yQUqWm5gO/
	 OEFOfZgqOxuLA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60d6303a11eso1897436eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jul 2025 09:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnEqfHKkwusiadsHR+yASofBIEXdE9ZJf7wmRc6usA7QyXUgTw6V44b00WUrVEhMp2X37C9FBpMkUu@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBDpfTUf2hL6RLF1AfLhxgzSCz16jalQVy2nadq5Q4DE3IJa3
	GjS+yqqeTfzGLK1YugXG+A3EOCO8JADF4mCLgzkUCqy41IAzg8GCxgDXn4zapFIEhjtd2CuiMHe
	gwrP9F3EBcS4HyEJeKN3A8Oyf4rihtsk=
X-Google-Smtp-Source: AGHT+IG5grd1A+to6hhRQF6BX0Hlm4wQTq7H4ft64Bm9QNbc/uDb7wG9GvFnWwvXobQ9V9pGcT82VX22AWCtCsmJu64=
X-Received: by 2002:a05:6820:4b89:b0:611:a1e4:59ad with SMTP id
 006d021491bc7-613c0265fb3mr116849eaf.4.1751905767711; Mon, 07 Jul 2025
 09:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704004002.70839-1-eslam.medhat1993@gmail.com>
In-Reply-To: <20250704004002.70839-1-eslam.medhat1993@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:29:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hp0fFVjr=b6jSuUcqDE7+DdC=mmSh2X0kgkSB4ReG=uA@mail.gmail.com>
X-Gm-Features: Ac12FXzbi4d87zgowOzx8TiekuiaOnZsqGSQv6EbiZnXoxenIsyM-OmpFPxkQHY
Message-ID: <CAJZ5v0hp0fFVjr=b6jSuUcqDE7+DdC=mmSh2X0kgkSB4ReG=uA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan_attr: Replace sprintf with sysfs_emit
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	skhan@linuxfoundation.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:40=E2=80=AFAM Eslam Khafagy <eslam.medhat1993@gmai=
l.com> wrote:
>
> Replace sprintf with sysfs_emit in function show_fine_grain_control in
> according to Documentation/filesystems/sysfs.rst.
>
> This patch builds on the fix proposed in patch:
> Message-ID 20250621055200.166361-1-abdelrahmanfekry375@gmail.com
>
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>  drivers/acpi/fan_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index 22d29ac2447c..f4e7f2351616 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -67,7 +67,7 @@ static ssize_t show_fine_grain_control(struct device *d=
ev, struct device_attribu
>         struct acpi_device *acpi_dev =3D container_of(dev, struct acpi_de=
vice, dev);
>         struct acpi_fan *fan =3D acpi_driver_data(acpi_dev);
>
> -       return sprintf(buf, "%d\n", fan->fif.fine_grain_ctrl);
> +       return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
>  }
>
>  int acpi_fan_create_attributes(struct acpi_device *device)
> --

Applied as 6.17 material, thanks!

