Return-Path: <linux-acpi+bounces-16015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A78B34405
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 16:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8627B1562
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0A2FA0FA;
	Mon, 25 Aug 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH19RBEo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEA35965;
	Mon, 25 Aug 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132320; cv=none; b=b1gT4/GZEUA7RKCLLePmHDlhEWAaQDKMs9HcmqeXXiJ00D6HgEQYSRNMFkXKBkvhu0/7JZ7nix3lP31h0uEVXD01N2f1hP3FEkyEzQpCT3Kd4Q13pMpXkKclY3iQwNZe1/xIt1pLccvXWIttFxl2BXUXy+NemYtLTsYHEq5ai5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132320; c=relaxed/simple;
	bh=2OF/Gy259q5baVCJQBimapXVyZlp7tYq25pZxltFsL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+cRwY2y8Ta9msv4Xr3NZd3zojZJAGp4d+grHpZP8/ZdBoJaMT5jIlvu1OzjJKBi34Jwqj8VXo5jtis2wPRNbAKhPCURoC0hKV7/oPgKrzuLuGX85USyXLC6jsjAfxgTFH2p8tfxRmZYczvOKOeqS7P+E7IYy0eGGLN3CuDmGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH19RBEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDADC4CEED;
	Mon, 25 Aug 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132320;
	bh=2OF/Gy259q5baVCJQBimapXVyZlp7tYq25pZxltFsL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CH19RBEomT4k+JTv8Bk2FGfHQbJnoVaRNu1RbJld8L74mMqpH2kGUednHq6p4rvCl
	 fdjQfPlUpAKdaxm+V1+jyGmlv46aMTBuMZCeUb+AD7LjXSClAPXDIv5t61Cjse7T/2
	 PohvYWz52+pv/ZYFzszJHj3+HSxwwvyPiW+YbN+cp7frbTzmuhem+dBFRzgTQWmELy
	 bJDZiU3DIXrGklZIEKa6Y7l3IlKLr67jfhPb3YynnGMPvvHvgFcHpuVwC4mTR+YOZt
	 6JLvJ+SgZOUPVFKxD7ItupHeL2Liku5CIymgp/iFHi8bXjvX+ag0lQ3KGkZVQDAHgJ
	 UNY56xnESAwxw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce86052cso2375809fac.1;
        Mon, 25 Aug 2025 07:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbyXCm1WoGOjS/lN2sypj1dbSY34CgVgKgPo+TgJ0BY/emNmAA1xOrg7wzvaeVI8VMPRcjtc33bE3Q@vger.kernel.org, AJvYcCXbnJzHtPsF4/1ZbjaGoAeQfdWHA+8FVCMkv+Dl1IuxbOFBtieCWhkdbxV8HEU1i2xt+qA7Qkhi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3V0q3JW56v6mKpR0mvOP97/TgBLgJ8jWYNgOleePBWidIQ2Kn
	PmdPkquEbgtxftV+TGYLSlmVs8G0CzndDtq5sTSF1OHTE32S1AjRDkmOmXfS5dmVmpBURj1MLKU
	XWNIhka5biGEMBZapR8k26LNHMfkeSf4=
X-Google-Smtp-Source: AGHT+IE1WFZ+ZQIUNy5sWMYBFgOefmYwx9eYfycgbeECs/djD2iEwuxEOhVvko11bGlUKKE7YWdsQveHS5Z82YLZLjM=
X-Received: by 2002:a05:6871:4009:b0:2ff:abf6:d269 with SMTP id
 586e51a60fabf-314dcad05f3mr5316721fac.9.1756132319649; Mon, 25 Aug 2025
 07:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807031229.449657-1-zhen.ni@easystack.cn>
In-Reply-To: <20250807031229.449657-1-zhen.ni@easystack.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 16:31:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hFsmmUxjpbVRTCiR+O7ccD8QEV15OeY67nk9=UsBuQTw@mail.gmail.com>
X-Gm-Features: Ac12FXzjJD0VzthfwqV5KyF1KW8JjJUJMAg5mKtpv_ghSNu193kinkRDPjs-PTs
Message-ID: <CAJZ5v0hFsmmUxjpbVRTCiR+O7ccD8QEV15OeY67nk9=UsBuQTw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: FPDT: Fix memory leak in acpi_init_fpdt()
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:18=E2=80=AFAM Zhen Ni <zhen.ni@easystack.cn> wrote=
:
>
> acpi_put_table() is only called when kobject_create_and_add() or
> fpdt_process_subtable() fails, but not on the success path. This causes
> a memory leak if initialization succeeds.

No, it doesn't, or at least not in the usual sense.

Memory occupied by ACPI tables is mapped in place, so even if you call
acpi_put_table(), the table is still there except that the memory
occupied by it is not mapped.

> Ensure acpi_put_table() is called in all cases by adding a put_table
> label and routing both success and failure paths through it. Drop the
> err_subtable label since kobject_put() is only needed when
> fpdt_process_subtable() fails.

So this can be done so long as the table is never used going forward,
but it is not strictly necessary as per the above.

> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
> Cc: stable@vger.kernel.org

Not really.

> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  drivers/acpi/acpi_fpdt.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index 271092f2700a..c8aea5bb187c 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -275,7 +275,7 @@ static int __init acpi_init_fpdt(void)
>         struct acpi_table_header *header;
>         struct fpdt_subtable_entry *subtable;
>         u32 offset =3D sizeof(*header);
> -       int result;
> +       int result =3D 0;
>
>         status =3D acpi_get_table(ACPI_SIG_FPDT, 0, &header);
>
> @@ -285,7 +285,7 @@ static int __init acpi_init_fpdt(void)
>         fpdt_kobj =3D kobject_create_and_add("fpdt", acpi_kobj);
>         if (!fpdt_kobj) {
>                 result =3D -ENOMEM;
> -               goto err_nomem;
> +               goto put_table;
>         }
>
>         while (offset < header->length) {
> @@ -295,8 +295,10 @@ static int __init acpi_init_fpdt(void)
>                 case SUBTABLE_S3PT:
>                         result =3D fpdt_process_subtable(subtable->addres=
s,
>                                               subtable->type);
> -                       if (result)
> -                               goto err_subtable;
> +                       if (result) {
> +                               kobject_put(fpdt_kobj);
> +                               goto put_table;
> +                       }
>                         break;
>                 default:
>                         /* Other types are reserved in ACPI 6.4 spec. */
> @@ -304,11 +306,8 @@ static int __init acpi_init_fpdt(void)
>                 }
>                 offset +=3D sizeof(*subtable);
>         }
> -       return 0;
> -err_subtable:
> -       kobject_put(fpdt_kobj);
>
> -err_nomem:
> +put_table:
>         acpi_put_table(header);
>         return result;
>  }
> --

