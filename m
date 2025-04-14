Return-Path: <linux-acpi+bounces-13024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB1A8861F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD856282D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764927FD46;
	Mon, 14 Apr 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5xnaIoI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC727F759;
	Mon, 14 Apr 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640729; cv=none; b=odm31Z+gLPN0NmovErYrCfmJlnP2CCymMbzTRcgP9dhWzp6JFrH0EbDoWLNQvRkPlkx9+twiB4axOpJ84f/iLg+p2J/Jx9Yg46aulcI8kS6wmlgIklAc9R/1hXdSV+dW9FYcvl/161NYxyewcLE4+pkNjSO0KwDIEPOQixrKBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640729; c=relaxed/simple;
	bh=yg6EWMxUISCyYSYPYDJV3F2CpXW7on+QB5igo/9U3WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQlc8LZQjc7j9GrDU3yMQ7zcOPlQa3e96bK/uvenpiDDsuxHYwxbiLVYma8LPcsAFJWEWHDikkLjsMwW1I1qEinc8F7hcDouksd3ACqL5OqG9kYrMjbzp/4QFIrIYVg+M0hjt08KYUHhObXZareS+Focs7kddOb0zdxGprMTkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5xnaIoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7006C4CEE9;
	Mon, 14 Apr 2025 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640728;
	bh=yg6EWMxUISCyYSYPYDJV3F2CpXW7on+QB5igo/9U3WM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b5xnaIoIi/nu5s7HP6IU9n3N9sIZC6rCnMlcUAUDLYrdTKJFF+k0jOSMdO+MVL4r4
	 Xg90kiLPLvJVsrCi3tqZ5tv4uJVVW9VOh7OV45dvPJRy8lvRizgyjLZeM0KHNAbNQU
	 vumektwdm3FBJglsE+0AT8f55TuPusym+ubQFinR0xVW96zcCQ0Vxr/f6ngUztO+Y/
	 2VCmMDYNNXYeyLqkVd+94p1vxAp8dPd0FQtPTgcDlOWX9NiL7C51F978BDKn8e9GGI
	 akLwF0Vq1YigNjzIzImElNNl9BW5SX/jvDucuVsNKMTVvd3gulrwnDQZZBfaSli+vJ
	 7p5/8j6qt/bsA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60288fd4169so1875672eaf.3;
        Mon, 14 Apr 2025 07:25:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXCrC3jlN+G8ynRLpVkUkkyMetdXWGPgGXc+cJUPZ6iec7fD4AzLCpdMd/7ysN+T9GNfoXFpqJuCkGcQ4U@vger.kernel.org, AJvYcCXdqEGtzoY1XT+ooHlX/owRYS6fxuGi2bbfD0V/WocVUZOBLtzX7wkXtSb54xxjcTUyGdVQRupGqo4N@vger.kernel.org
X-Gm-Message-State: AOJu0YyumCAmP/L+o1pnFZlhb167mTGzgdDVviBS9u4ndQErVKGH3Nuv
	vzRpri0NsUWeJSYrs9yEaK3dCtp+RBZB979pBahZhjpkG1qsZVSaObhFZ5m2j0jE0i+5c5ITZuT
	bT031EGAobM/XhHFOK3TVQD41mQE=
X-Google-Smtp-Source: AGHT+IGpQ8Gu6BowkMYFfcY+1nthKg0wd1cz3rjIdC8dPfkokVglpT5SfkZnRdy5kH2Kp1RRisWLKcbiXxBnKB2lNME=
X-Received: by 2002:a05:6871:6216:b0:2c1:6bbc:70f4 with SMTP id
 586e51a60fabf-2d0d5f74b56mr7444602fac.38.1744640728206; Mon, 14 Apr 2025
 07:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414073517.57745-1-kevinpaul468@gmail.com>
In-Reply-To: <20250414073517.57745-1-kevinpaul468@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Apr 2025 16:25:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTXstnnFWi87ihxLx7u1HcNaKeUdBpE+2HyJ+40wLCbQ@mail.gmail.com>
X-Gm-Features: ATxdqUHoCYUB-YbsecjuItR83jefDARX0oJSWSXyKosTFhnQ3zOAQZ8DOaF_SUQ
Message-ID: <CAJZ5v0gTXstnnFWi87ihxLx7u1HcNaKeUdBpE+2HyJ+40wLCbQ@mail.gmail.com>
Subject: Re: [PATCH] acpica: Removing deprecated strncpy()
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 9:35=E2=80=AFAM Kevin Paul Reddy Janagari
<kevinpaul468@gmail.com> wrote:
>
> This patch suggests the replacement of strncpy with strscpy
> as per Documentation/process/deprecated.
> The strncpy() fails to guarantee NULL termination,
> The function adds zero pads which isn't really convenient for short strin=
gs
> as it may cause performance issues.
>
> strscpy() is a preferred replacement because
> it overcomes the limitations of strncpy mentioned above.
>
> Compile Tested

ACPICA material is primarily handled by the upstream ACPICA project on
GitHub, so  ACPICA changes should first be submitted to upstream ACPICA as
indicated on this list for many times, see for instance:

https://lore.kernel.org/linux-acpi/CAJZ5v0gUDxrAn4W+Rf3ifjrg8Z9ZzTTOZjPFSSN=
5488mPqzXeA@mail.gmail.com/

> Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
> ---
>  drivers/acpi/acpica/exconvrt.c | 2 +-
>  drivers/acpi/acpica/tbfind.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvr=
t.c
> index bb1be42daee1..648e68a31e1f 100644
> --- a/drivers/acpi/acpica/exconvrt.c
> +++ b/drivers/acpi/acpica/exconvrt.c
> @@ -226,7 +226,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *=
obj_desc,
>                 /* Copy the string to the buffer */
>
>                 new_buf =3D return_desc->buffer.pointer;
> -               strncpy((char *)new_buf, (char *)obj_desc->string.pointer=
,
> +               strscpy((char *)new_buf, (char *)obj_desc->string.pointer=
,
>                         obj_desc->string.length);
>                 break;
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
> 2.39.5
>
>

