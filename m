Return-Path: <linux-acpi+bounces-13593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C22AAE4C8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977CF1C42C44
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72528BAAC;
	Wed,  7 May 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFeVQA/Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1828BAA6
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631568; cv=none; b=K8DNfOi6IZBWTz83vnSl3YFnwDIE22cv9eHjs09q7a5XnsJ0lWOpzuiy0ErLxFs2AppO7Ixl7RlHaj2J8HyLDQTX7mvLJXgmb3bwiJACXMimxXE5pD27M1rX2iYqNX1C6ROmSRS6cOPsygQMxBqF/ZU3VSCtCIoriUCfRw1eDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631568; c=relaxed/simple;
	bh=vRyKhU47b8HpR6WFd47LLGp3vmxif8gR0qLWyi7s+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1i9M67QXDhMm4lXLytmT0TMahAaNa8/K+/XPHE8SKzwHbnnv5ajP+yowqcpNhLPvU0eAY+ZPhmfGCncL4F1fU/WCijNdV1NhxxCgHJjsXhCHHuhR+yE0SYtt6JQ/LH76QjFLW9UcYZ8EIf7QnM35RV/wEWyUf+Bp0IVOaVTuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFeVQA/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A810C4CEE2
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746631568;
	bh=vRyKhU47b8HpR6WFd47LLGp3vmxif8gR0qLWyi7s+gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFeVQA/Ztxbk7b4KnED8SmQY1p+gRttRva812COjsGNzDEPWWtj72PdfJw/RvQQoW
	 idcy1z6PwrqNl7OBDgbGg3+0162rSUA6JP/uUtD4hDAvtJMW/Vl4qcpnaCsXO9hjAp
	 o2vBuBtbW2thX/qmJGRplXOlOLJy65WEjGPnpy7oI2LlR/zoULYnRlYEiyysbOqSJp
	 +k2AwwtQjYHsp9m+E3D8jsuTjrPXJ8I4J2q/bY5uQrnyJW0e+OPgcuv1S3gxqccs7V
	 FNrQg0qfcOhDM95/LvTC/zvz5YAhK2ilWC8ZgK2BKW/lQOJg7CnOWnHYj5P9fmrvtL
	 kWErnPb4y0ySg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d060c62b61so65376fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 08:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlkWjmOnjSdNhHRaE2v6dmuHN4yAfErmlZswuFsL5GNLNVRYJJ9a7wdewogXAhp/ly/KgIPVrzNR4W@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1c8ZRQ7d/dOcUdgFPcTl4C4Q+g+dUw6iAJxYE8DzHFd61mvX
	3Izl6hfow7rG6C4OT6BhWv/iIx3u5KLwUUZxXAH0DSCbRXqGFf5h3Rkn0E6CGg7L4Zchdz3QByM
	atJ0Xg9raxhhF1tLd6hGW3Rumuhw=
X-Google-Smtp-Source: AGHT+IEcgoxgjHJX1Wb+IhDm2x3k+dD1aIlf95MRUUDyAb0rSSkxXzv0na/rJhZcOkd1Q0uKowcALjj3jfE9sqPkdrI=
X-Received: by 2002:a05:6870:e993:b0:2c1:c821:c836 with SMTP id
 586e51a60fabf-2db5bec5cf4mr1995261fac.22.1746631567621; Wed, 07 May 2025
 08:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507152045.12266-1-goralbaris@gmail.com>
In-Reply-To: <20250507152045.12266-1-goralbaris@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 17:25:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3M3-xHU+Re-YjJvusA5-gdpmmt7MY9-u8Hr9YEGJRQw@mail.gmail.com>
X-Gm-Features: ATxdqUHImFlKAbVKzufj1nmpa1z_fmCg4IJMDNql2B50aexy0n_tlu6jFNXrYrc
Message-ID: <CAJZ5v0g3M3-xHU+Re-YjJvusA5-gdpmmt7MY9-u8Hr9YEGJRQw@mail.gmail.com>
Subject: Re: [PATCH] acpi: convert strncpy into strscpy
To: goralbaris <goralbaris@gmail.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:20=E2=80=AFPM goralbaris <goralbaris@gmail.com> wr=
ote:
>
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string, resulting in potential memory.

Does it do that in the code modified by this patch?

This is ACPICA code anyway, so changes to it need to be submitted to
the upstream ACPICA project on GitHub.  Only when merged into that
code base, can they be forward-ported to Linux.

> Link: https://github.com/KSPP/linux/issues/90
>
> Signed-off-by: goralbaris <goralbaris@gmail.com>
> ---
>  drivers/acpi/acpica/tbfind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..5536d1755188 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
>
>         memset(&header, 0, sizeof(struct acpi_table_header));
>         ACPI_COPY_NAMESEG(header.signature, signature);
> -       strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -       strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
> +       strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> +       strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
>
>         /* Search for the table */
>
> --

