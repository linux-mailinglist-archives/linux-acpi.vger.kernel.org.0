Return-Path: <linux-acpi+bounces-7240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FBA945FA7
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEC51C216F9
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C321019A;
	Fri,  2 Aug 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diBQ6K9g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF731C693;
	Fri,  2 Aug 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610361; cv=none; b=edgeJ3mQhoGefJztY/3m5QoHD/r473B1YZc17LlXadN7DXfYSL4rxLWJGXtLQ5oXWRmFvZE2p1PbiQoP8FQeKW+dSRN1ADYJ0sQDQXOM5vQ0waHLIsgMJhe/F8GVEZRa1cRbWTajoxKcGc+bhzV4rv7licvnLiW+EwMLEUUmPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610361; c=relaxed/simple;
	bh=7fW4SVY1AD5MyHTSqymQgAUot2hO/fMcw3Ygn74bn4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewKyVJy5gpeyJ8f+VMeiMDmcPZOQ/+NqzufVyR1WLo3p7VjzWc70leOI68X/R+O7qGgc2hsyMNJ487qgPyosiJx1Ux0Kefav4OxLwE3ijlqpg8MhRhcb5Hq1grpRAHDYtQr1o79sI3Xg+YqoYXq9Dx8YmzQIZNa2cSWmjAr8SGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diBQ6K9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCA3C4AF0A;
	Fri,  2 Aug 2024 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610361;
	bh=7fW4SVY1AD5MyHTSqymQgAUot2hO/fMcw3Ygn74bn4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=diBQ6K9gl9IzCkPjvuCK6NjgDdc+uTBSbcRInNQPutN3N3JVodBs0K1pODujq8oCh
	 QrCRVYLhU87B1IOwOFo9PpcLqTLfXwIouRUZUkCBwPqvjsa49IYyFwStxZcppprvHs
	 2ZoLlQKyONzKvPvOtCF8z/6oHAokYkWi3uq/ydNhCzEYvqg2nB/uatDEkLCZ+OJ/jM
	 +WUHQ0DOs2qBImNtGZkzhm3tnAG0L/G9qPwyYazWIqKpxzCVb4o9WO/7m/5gB+ZrXo
	 gcT6+1i2zrMIADvUu2m2hqLtdyykXpB3WeFZkWK38HaP4o8V8bDLoY3vAo0MPzri0V
	 EJb/dDEjy37AA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-26117c006c7so299260fac.1;
        Fri, 02 Aug 2024 07:52:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBUtEbw4b9yK5fNSaAbQdFykM5qDjkT4Knz/o2C1/CyTj0vt6l7++T/KF2W6b1xwxBcbthsD6pKYlLOCzwP644UbHKEG6IarkKLXpeZksr09PkMUhFQtkZBfpKh7ZeWq9n18GdnIOcRQ==
X-Gm-Message-State: AOJu0YwBGGm6reJ75QGQS8hpiuZ4L6nYKtDlpj37uFZDpFgcrjjLPnca
	if/EoC4BNguiO7+XGzpf88lQuGsM324eNRFt8YP/ugc43+nEJW22+282xzZi0xy6I6imbSfbPNS
	FSttGbQ5d+VVuoCb1vrzMgeRYYR0=
X-Google-Smtp-Source: AGHT+IFRwhlT5f1teywL2mMHVX2BhO378lznK7c5J3JEzN35Ix0lj/6e/en8VJKsWBhA9ktlFXeZl2ABL7W252HiR40=
X-Received: by 2002:a05:6870:ac10:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-26891a9437fmr2379024fac.2.1722610360309; Fri, 02 Aug 2024
 07:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_4A21A2865B8B0A0D12CAEBEB84708EDDB505@qq.com>
In-Reply-To: <tencent_4A21A2865B8B0A0D12CAEBEB84708EDDB505@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 16:52:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw6v+X_UM0QNzj0MC7hdvmoqUK2mt3caOn-4YbbQRkeg@mail.gmail.com>
Message-ID: <CAJZ5v0iw6v+X_UM0QNzj0MC7hdvmoqUK2mt3caOn-4YbbQRkeg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED
 in acpi_db_convert_to_package ACPICA commit 4d4547cf13cca820ff7e0f859ba83e1a610b9fd0
To: xiaopeitux@foxmail.com
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:12=E2=80=AFAM <xiaopeitux@foxmail.com> wrote:
>
> From: Pei Xiao <xiaopei01@kylinos.cn>
>
> ACPI_ALLOCATE_ZEROED may fails, elements might be null and will cause
> null pointer dereference later.
>
> Link: https://github.com/acpica/acpica/commit/4d4547cf
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/acpi/acpica/dbconvert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconv=
ert.c
> index 2b84ac093698..8dbab6932049 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>         elements =3D
>             ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>                                  sizeof(union acpi_object));
> +       if (!elements)
> +               return (AE_NO_MEMORY);
>
>         this =3D string;
>         for (i =3D 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> --

Applied (with edited subject and changelog) as 6.12 material, thanks!

