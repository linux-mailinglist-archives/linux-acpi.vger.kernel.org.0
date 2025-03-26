Return-Path: <linux-acpi+bounces-12436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01AA719EA
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C371887C37
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3DA1DD539;
	Wed, 26 Mar 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMalqNjj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545319A298;
	Wed, 26 Mar 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001599; cv=none; b=e+UH5fUtj/F69trpOwsXBxj5rekcRy4EP5ZBa/pmv6rXY3S4LrfNh/xpr+stzINJBqBlACtGcDT9Yd76sflJ2s0GJoV1whYwE8qwE4E06eOG3fvLeqvyD1zpdBt8Ua3SOy7uldLHHTa4fllN14ucTHep8RLDJ9TKBM/ufb81EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001599; c=relaxed/simple;
	bh=eG/T134t1BpVKjLV2gOl1Ja0VVIdhzM/6dZvtfLmW3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrgDnEiHcGcsVW1KMryKhm/QhNjYYHpVqMsi4YQL5wOe+vlv6H9wmfkAfcXmlbnVdj0g2PH6ma1WDwgQ2BCnTMSMPiwGXaxkLhLi9EE9wfMMfkb5FuZ3uw2JAOKP/tEW4ypwI/+yMNeAqkvPYANxWLes2fJNKG1nY9zZ47gtsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMalqNjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8018BC4CEED;
	Wed, 26 Mar 2025 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001598;
	bh=eG/T134t1BpVKjLV2gOl1Ja0VVIdhzM/6dZvtfLmW3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vMalqNjjmzCWyfP20tx+ST2Eb6rLDX+av+6+yIL5PG3j5Uw7VqyVXF8Y/xWtySGS6
	 J4b81Bl0BmsJBXDSbGU4zf2woSVdci6ZCKyz24TXrddByi+VqXQOjUorT1POIJklVk
	 MtrRV4nTZkhAYvAgVi6BxtFhAbBIBP5WbF+JIrdw6uzDiykMAviPToKF6ZiThu+1s9
	 wZ0+JkK3LILuymLZOnylG5pJNOvYpTs8kLVBSTWFWfxbEYm31dGSSgnyxwpst9XGPU
	 IqkSaCj73OJ9kFUzZecERWOGXVTQn92xpZ2QZ2jgB0/Y4Y4gmkeu37V2RVFFdDl9Xg
	 o6eaR42w9ICcg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c818343646so969849fac.3;
        Wed, 26 Mar 2025 08:06:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5E4NibGTN7BpU2wtzYHyzba0V7/lU/z5p2aRfEhsuTGc/JEtWgVe7rb0sTQZMrs4LE5mvSDNvolCeJz+z@vger.kernel.org, AJvYcCUrM58REN+HzuVtEyOGaij/3DmiK0PChPl+r580ti1Qesx6tP/ADxEXY/k12kM4naRDTW0CUIjTTJP4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+eeOxf1JAE5pvjykdzRAgnWxBLKTKc/kdFC0n7FK0N78B5h8
	qvw+2srdo9FZwBuqTg4CrJZnvhig0U1BDxcdKCd63c2SgAPBWTS0sMtpn9sr4/ysusXMYv0UJhS
	cXXThvqlsT0XxKVJYq6Cnff2A1H8=
X-Google-Smtp-Source: AGHT+IGkvPIhAdIe2uCHkUV7jdqJrG0IDNtgByDus5UItrR41CYXQI0TX/ZBHOpWTPlZ2WX0WUbSZSJjAndGBhaskI0=
X-Received: by 2002:a05:6870:2b1b:b0:29e:2d18:2718 with SMTP id
 586e51a60fabf-2c78048a3d2mr14302920fac.28.1743001597790; Wed, 26 Mar 2025
 08:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317143806244wrGxYdlssPbWp7T7W5Gbr@zte.com.cn>
In-Reply-To: <20250317143806244wrGxYdlssPbWp7T7W5Gbr@zte.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 16:06:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLweZL_v68aEFOvYYs2zHwT2HzGjf0b7ZD-qmTw6cd=A@mail.gmail.com>
X-Gm-Features: AQ5f1JphAlHj-vnQbNXz4EBhTHajNte1OOhPJKLEs-XNLulzBlPDIu2IUzU_H8k
Message-ID: <CAJZ5v0gLweZL_v68aEFOvYYs2zHwT2HzGjf0b7ZD-qmTw6cd=A@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace deprecated strncpy() with strscpy()
To: feng.wei8@zte.com.cn
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:38=E2=80=AFAM <feng.wei8@zte.com.cn> wrote:
>
> From: FengWei <feng.wei8@zte.com.cn>
>
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
>
> Signed-off-by: FengWei <feng.wei8@zte.com.cn>

In order to modify ACPICA code in the Linux kernel, please first
submit the change in question to the upstream ACPICA project on GitHub
as a pull request.  Once that pull request has been merged, you can
send a corresponding Linux patch with a Link: tag pointing to it, but
in principle it is not necessary to do so because ACPICA changes are
automatically integrated into the Linux code base on a more-or-less
regular basis.

Thanks!

> ---
>  drivers/acpi/acpica/utnonansi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnona=
nsi.c
> index ff0802ace19b..1da9b8246011 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, a=
cpi_size dest_size)
>  {
>         /* Always terminate destination string */
>
> -       strncpy(dest, source, dest_size);
> -       dest[dest_size - 1] =3D 0;
> +       strscpy(dest, source, dest_size);
>  }
>
>  #endif
> --
> 2.25.1
>

