Return-Path: <linux-acpi+bounces-376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA97B6BC7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 130DF2816FF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA731A96
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91362770F
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:47:57 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22CAB;
	Tue,  3 Oct 2023 06:47:53 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3af59a017a5so148830b6e.1;
        Tue, 03 Oct 2023 06:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340873; x=1696945673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myp4tnblzv3PfnS2aDkMaapac9MMwIlElDTi3Va90BQ=;
        b=oh+c9O+XNLTpZzHu/OesPwxsgZL/nb1slM3l1jBRWQf5NCZEB4gLl6DLrffacaO49Y
         Dl5DDRskGSz1HaALyflJNwHonkzzXa3kmIqUzFjSNIJN+00/Aut0eihlqYwUvug1RSGv
         0Stlosm4mQ1YOqNxQOZf1kacn2Zbfjo8/yBD2MI+GGYJ5+0DwbKDuYp0LXFkFduOkFk1
         KnhJ5Y7bPgKf9nvNPRSBhTuz0VDvr8pxplWze0Hid647Vft9Ro4bI5X1GbZ0QeyxtRtm
         GCV6rv77YGrgzbQ09JDZdbSEUmXt1ODqKKDJ+TpUTGQ8I0P+2YcuKV1s1wrPD42uDffw
         Hzww==
X-Gm-Message-State: AOJu0YxnAVqxeEBM+nB4K34aLR+m56P65IgrIvIJ2wMcfa5u37exqQK1
	tb6/f0atAUpclqq42VikNn0okua7UdEormP9BVKVR2qZ
X-Google-Smtp-Source: AGHT+IEuaILjXXU0kpwejivoSEIVhcAXYh06/0XVX9DF7k7llkENmAe8xUBUeXoUql/5xKB5wz6ZvdahVeOjn6Qf2b8=
X-Received: by 2002:a05:6808:212a:b0:3ae:b06:2140 with SMTP id
 r42-20020a056808212a00b003ae0b062140mr17361563oiw.4.1696340873087; Tue, 03
 Oct 2023 06:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002135424.2603191-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002135424.2603191-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 15:47:42 +0200
Message-ID: <CAJZ5v0h25-y32LVbYTtGaNFPWgTafvQZJP4VupBYuqXptY0maA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: PCI: Switch to use acpi_evaluate_dsm_typed()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 4:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 84030804a763..58b89b8d950e 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1055,9 +1055,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pc=
i_root *root,
>          * exists and returns 0, we must preserve any PCI resource
>          * assignments made by firmware for this host bridge.
>          */
> -       obj =3D acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm=
_guid, 1,
> -                               DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
> -       if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER && obj->integer.val=
ue =3D=3D 0)
> +       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_ac=
pi_dsm_guid, 1,
> +                                     DSM_PCI_PRESERVE_BOOT_CONFIG, NULL,=
 ACPI_TYPE_INTEGER);
> +       if (obj && obj->integer.value =3D=3D 0)
>                 host_bridge->preserve_config =3D 1;
>         ACPI_FREE(obj);
>
> --

Applied as 6.7 material, thanks!

