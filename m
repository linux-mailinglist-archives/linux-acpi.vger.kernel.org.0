Return-Path: <linux-acpi+bounces-944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2057D5C85
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230E21C20B34
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA33F4A4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3845CBE
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 19:54:40 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152B79F;
	Tue, 24 Oct 2023 12:54:39 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so749663fac.1;
        Tue, 24 Oct 2023 12:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177278; x=1698782078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P7wT8dPYf9bvLIbftJ6d8ATBxM0oX1gXkP2jSioPM4=;
        b=FZ9AXa0ikSTVZrd1vbh6BdeMFPTneSOX6f7AYnKtYtzA68bU7NoWmXyJWHPYHmq2b9
         QPwwtGJjuU0TDo1/zfg3gZ0UTBDjJ+qcAJ76H3lshagZB2GezVoE6JZTudIO3AFeYX2E
         6TsrfZRP2QuxqpNwOnF353KrBuyhiB5zVw757wN6BdpkPGpppXO1YMZ7zYlnggYKnsDD
         NTleHFlu/vROB6xcGPl0bJqIyqDkQDqCcXDMkHsBpvCjDFNjYRs3PXPyhx0Vil76Tm5E
         iwoHK7L0cU24myTV3XmcKllFb5Yt5XV7cSP38r/A8jaYsY833xCHTKSTXlkpgNczdAvj
         LcmQ==
X-Gm-Message-State: AOJu0YygDCZG3yPXeJ5wwCv2OebSbzmRGGEH21th9FepZ8cSNideotmn
	JkqDf+SgmEjejWZZJ6ZhAwpO17vz+Glntjvpeog=
X-Google-Smtp-Source: AGHT+IHCqHmceYE8XJ7PlWLF1hKBttKjqRKUza1U4LOA0OtKWg7zJxRbW4wjhJVNQzQXA++7Q99biKhGlswVPKpuHU4=
X-Received: by 2002:a05:6870:fb86:b0:1e9:e605:27a1 with SMTP id
 kv6-20020a056870fb8600b001e9e60527a1mr14651916oab.2.1698177278384; Tue, 24
 Oct 2023 12:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024091336.1.Ie25ddf26b761bf185b7152c6a9884977f0ce73f9@changeid>
In-Reply-To: <20231024091336.1.Ie25ddf26b761bf185b7152c6a9884977f0ce73f9@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 21:54:27 +0200
Message-ID: <CAJZ5v0gOmqK66NA_FAqEx59f0yd5PzdhH7jio3A0EN8=Tpp5nA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	Jonathan Denose <jdenose@google.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:14=E2=80=AFPM Jonathan Denose <jdenose@chromium.o=
rg> wrote:
>
> Added GPE quirk entry for HP 250 G7 Notebook PC. This change
> allows the lid switch to be identified as the lid switch and not
> a keyboard button. With the lid switch properly identified, the
> device triggers suspend correctly on lid close.
>
> Signed-off-by: Jonathan Denose <jdenose@google.com>
> ---
>
>  drivers/acpi/ec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c95d0edb0be9e..a59c11df73754 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1924,6 +1924,16 @@ static const struct dmi_system_id ec_dmi_table[] _=
_initconst =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming L=
aptop 15-dk1xxx"),
>                 },
>         },
> +       {
> +               /*
> +                * HP 250 G7 Notebook PC
> +                */
> +               .callback =3D ec_honor_dsdt_gpe,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook P=
C"),
> +               },
> +       },
>         {
>                 /*
>                  * Samsung hardware
> --

Applied as 6.7 material, thanks!

