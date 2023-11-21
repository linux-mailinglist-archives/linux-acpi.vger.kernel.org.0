Return-Path: <linux-acpi+bounces-1714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8537F378B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 21:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D61C20849
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40DB54663
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3CA194
	for <linux-acpi@vger.kernel.org>; Tue, 21 Nov 2023 11:36:20 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d63e0412faso858275a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Nov 2023 11:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700595379; x=1701200179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1y4iq0UEh7njnisVm3gy3VUz0SR0PqnZUTitX3M1Uo=;
        b=WcCR/WR7LdwoneHtscjqBgWWwg67y4JB5y+zQH2K4E6DBqggbQ7U3GP+OfU/pdOM6q
         LDHgI78/387aQv9l9tMEf49RgLa42ZSRvwo1/KsC7BDK2Ot1/hOJli1S/4Dfy/mLcuFb
         AMkVmFtK0ze6g9FOdoPE0Jui6FL/NaknTBspFkE+2IqFnYGOE2BNuZonHVQfSTQRMSps
         O96tx6s/0lQx3uB4i46K8l3glRHiL/Mr/5ROTZbuAfdW3zONAu4NwDLz2a/ySWrczUJ7
         nsmDwJN683jQcNAE5wluPRwpVDqa+NF0f78j2JeKR9DRutfY2pGghd+yY7IJ6haagLKQ
         oKQg==
X-Gm-Message-State: AOJu0YxGVGrYfN+IDA9FqO86wPnZIQhlaYnJdxcnD51nTTgd0//mREY9
	q9iuME9ny85FEiQXxGqLNKz2N0gbBlcRAhrGTm1tH1BA
X-Google-Smtp-Source: AGHT+IEppqj6Ox1Cds61rFwTkkAaAqcOi3njuiIeKmCQqUSbMNJfV2hkUpDMIbc3+HF5v2ZtukLIwe37XFl4WqvP8R8=
X-Received: by 2002:a05:6871:d20c:b0:1f5:d3f5:2b92 with SMTP id
 pk12-20020a056871d20c00b001f5d3f52b92mr338176oac.2.1700595379364; Tue, 21 Nov
 2023 11:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com> <20231103083625.1229008-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20231103083625.1229008-2-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 20:36:08 +0100
Message-ID: <CAJZ5v0hB=6mLp3ZKOoF=_+wJ-crraXtMaZ7ZNhZ_Gfg2SU08Ww@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 9:36=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> fwnode_get_property_reference_args() may not be called with args argument
> NULL on ACPI, OF already supports this. Add the missing NULL checks and
> document this.
>
> The purpose is to be able to count the references.
>
> Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fwnode=
 reference args")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 413e4fcadcaf..93608714b652 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -851,6 +851,7 @@ static int acpi_get_ref_args(struct fwnode_reference_=
args *args,
>   * @index: Index of the reference to return
>   * @num_args: Maximum number of arguments after each reference
>   * @args: Location to store the returned reference with optional argumen=
ts
> + *       (may be NULL)
>   *
>   * Find property with @name, verifify that it is a package containing at=
 least
>   * one object reference and if so, store the ACPI device object pointer =
to the
> @@ -907,6 +908,9 @@ int __acpi_node_get_property_reference(const struct f=
wnode_handle *fwnode,
>                 if (!device)
>                         return -EINVAL;
>
> +               if (!args)
> +                       return 0;
> +
>                 args->fwnode =3D acpi_fwnode_handle(device);
>                 args->nargs =3D 0;
>                 return 0;
> --

Is this series waiting for me to pick it up or am I confused?

