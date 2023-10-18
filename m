Return-Path: <linux-acpi+bounces-722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCE7CDBE4
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5531C20370
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E934CC8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5D18C10
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:13:36 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C4F10F;
	Wed, 18 Oct 2023 04:13:34 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57bf04841ccso1376125eaf.0;
        Wed, 18 Oct 2023 04:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627614; x=1698232414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9BSIDSxSdsjvE34XyGwJrHtCdQ+4sCjaON3ksE44JE=;
        b=gjVpQ+HIJnhRDsX72ZR37HfJEQL5hJA+Z5Mvokf0tKUd4rICNfVwQpmWfwnLVCVgkw
         zBj93RL/++M6DObn524bYhvwypzyobqO1fy2zWhAJWR9dOyIz3kdmPDNDSds6Z/Hzihp
         TyV4mY8RPpnpVz6LTw2mHVnSYJ5/rIiBokI3bx0z3JJomTjxHrj2uMWT0OKbyteQN9aF
         OQT/EoFLXP7YxInFJRcLBM1ImzpN71m/Y+lgDqVU71rYcdiiGPv86eKLMla9Q7vBfHp4
         IuPRy+Q1YWFQ8XjQFwB5JJ1aIj6s4pcVMbwxIG4BPxDyGdDa9InoLGl34822ncmALLpb
         JaQw==
X-Gm-Message-State: AOJu0YyClGiG22Qic8vxorc4ZZv8vFqpTSlKDy/j80oviyf/Jz2SWwxz
	Nbz5m5tABA5cGQTmyXeMgm3tpqQGOeEu/lqcx6Q=
X-Google-Smtp-Source: AGHT+IF8QIsqTfTZXraFJb6Yq4Gp3Xa7Nxdbi2xU1PMbhGxb2pZmh4LhMgw0IBQC9OaGI7xahIOryH2MiQMrlJJMvBw=
X-Received: by 2002:a4a:ee94:0:b0:581:5990:dbb8 with SMTP id
 dk20-20020a4aee94000000b005815990dbb8mr4901446oob.0.1697627614027; Wed, 18
 Oct 2023 04:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
In-Reply-To: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:13:23 +0200
Message-ID: <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Agustin Vega-Frias <agustinv@codeaurora.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 7:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> acpi_register_gsi() should return negative value in case of failure.
> Currently, it returns the return value from irq_create_fwspec_mapping().
> However, irq_create_fwspec_mapping() returns 0 for failure. Fix the issue
> by returning -EINVAL if irq_create_fwspec_mapping() returns zero.
>
> Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain map=
ping")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/irq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index c2c786eb95ab..403f33df66af 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int =
trigger,
>                       int polarity)
>  {
>         struct irq_fwspec fwspec;
> +       unsigned int rc;
>
>         fwspec.fwnode =3D acpi_get_gsi_domain_id(gsi);
>         if (WARN_ON(!fwspec.fwnode)) {
> @@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int=
 trigger,
>         fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polarity);
>         fwspec.param_count =3D 2;
>
> -       return irq_create_fwspec_mapping(&fwspec);
> +       rc =3D irq_create_fwspec_mapping(&fwspec);
> +       if (!rc)
> +               return -EINVAL;
> +
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(acpi_register_gsi);
>
> --

Good catch!

Applied as 6.7 material, but I renamed the new rc local variable to irq.

Thanks!

