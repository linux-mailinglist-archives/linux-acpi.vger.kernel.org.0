Return-Path: <linux-acpi+bounces-2190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8080796D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15D71C20E5F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE404B147
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9618D;
	Wed,  6 Dec 2023 12:08:06 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fb2b83986cso37931fac.0;
        Wed, 06 Dec 2023 12:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893285; x=1702498085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOU+dMGimpnkd9aD0uyRbkl6NBIKgBfPHss6q3A/RKc=;
        b=hv5tTc8n6ucb6RG4DB2/frEaAJ1cwMRJMgcP3EehSlg42X1N3nFWw2RHC+3D2zzLsh
         W5rrTuBWabs+LBAnL7fH8TVBcuztZFF3Be3wCCyyk5Y8rv6N9Mcv5IDT6vZTEZMn9Kw8
         q3GhpuAJNW+v28BWxPYdXXt2EpJ0J7W5L8o40K8ks34GF3f2IKXBzZ0MBc9s0cKVlJAx
         21hvDBhB+YGJyuImsfNtJwnOlTyOTqKVoUXJhKaLM0gdisOJh7gbFMPmoOCs1UGLRHxA
         +P1wdaN1J1IEqfxHiwOgQvzEVuRvQXrbatkSIktglg5ZGdir1hiHPKolhQP2oT9Vxfgz
         8UHw==
X-Gm-Message-State: AOJu0Yw3lOXP/5qII0L39CXJtkovoDoJEhOMIB80ubgjl3ORNot7/sgh
	46kGo0t8NZGMC8ZgzHDsSIxP7ZnzeyEwGiVDK7A=
X-Google-Smtp-Source: AGHT+IHpuR7c+DdGHDSzgiRkNb8ETV+06EtkYa3tgv53h1rm7QnyhmlcCPKUIrI2YiFz3Oge8UaTAjhdeZj35DrMoQo=
X-Received: by 2002:a05:6870:2112:b0:1fb:25fb:fabc with SMTP id
 f18-20020a056870211200b001fb25fbfabcmr2701649oae.5.1701893285575; Wed, 06 Dec
 2023 12:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129081355.32317-1-liuhaoran14@163.com>
In-Reply-To: <20231129081355.32317-1-liuhaoran14@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:07:54 +0100
Message-ID: <CAJZ5v0jbhiGgw-vyGyQCTJe0bL67-c1d_qggkZC-vqnA8UsrbA@mail.gmail.com>
Subject: Re: [PATCH] [ACPI] fan_core: Add error handling for acpi_driver_data
To: Haoran Liu <liuhaoran14@163.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 9:14=E2=80=AFAM Haoran Liu <liuhaoran14@163.com> wr=
ote:
>
> This patch introduces error handling for the acpi_driver_data call
> in function acpi_fan_get_fif and acpi_fan_get_fps, within
> drivers/acpi/fan_core.c. Previously, there was no check for a null
> return from acpi_driver_data, which could lead to potential
> instability in scenarios where acpi_driver_data fails.

This needs to explain why/how it is possible for acpi_driver_data() to
return NULL in the 2 places modified by the patch.

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/acpi/fan_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 9dccbae9e8ea..f3228fb9c90f 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -215,6 +215,13 @@ static int acpi_fan_get_fif(struct acpi_device *devi=
ce)
>  {
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>         struct acpi_fan *fan =3D acpi_driver_data(device);
> +
> +       if (!fan) {
> +               dev_err(&device->dev, "No ACPI fan data associated "
> +                       "with the device\n");
> +               return -EINVAL;
> +       }
> +
>         struct acpi_buffer format =3D { sizeof("NNNN"), "NNNN" };
>         u64 fields[4];
>         struct acpi_buffer fif =3D { sizeof(fields), fields };
> @@ -265,6 +272,12 @@ static int acpi_fan_speed_cmp(const void *a, const v=
oid *b)
>  static int acpi_fan_get_fps(struct acpi_device *device)
>  {
>         struct acpi_fan *fan =3D acpi_driver_data(device);
> +
> +       if (!fan) {
> +               dev_err(&device->dev, "Failed to retrieve ACPI fan data\n=
");
> +               return -ENODEV;
> +       }
> +
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>         union acpi_object *obj;
>         acpi_status status;
> --
> 2.17.1
>

