Return-Path: <linux-acpi+bounces-377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C707B6BC8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0AD8D280C81
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B822EE2
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6E262AB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:49:17 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18064A6;
	Tue,  3 Oct 2023 06:49:16 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ae450158ffso44739b6e.0;
        Tue, 03 Oct 2023 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340955; x=1696945755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HaeYswf3/CGddqJhCBbnH7fsDO0Zj7YhkCJafH4Z5Q=;
        b=lrh14wsw4LF8hx4g81Ut4SsvmZ+Hayl4eUPM1MdhVjh+XYTNKXeXql3wvYz1gB0syk
         b76IZT/qznJt55/wRiI+zZ2TxpsUvvy1JydSVQMmNnW+ugLUs7wqx/WYexCXwrsBz17I
         5WjMF7Nvy5FS6hns29NzjBMj5Xr9JFVdZt0BePTfmry1W/0OoUS6u1PBThFAeCBBk35E
         AOmKSEeGTFToZ6QSk46lRVqRqswoPFY4bFn98sj4sEKTFZ9OKqN+TZZmqa0pTDbvegh+
         dBVxXXiRu7RutN442OM////nCYnCvLSGbGkvMEupV2f4rOplE9itWyt72V4AXqY9LXT9
         MjIw==
X-Gm-Message-State: AOJu0YxCF1wnsMBtbQSuivU67yQTMPFp5x30AX8WaoiAwdg5ZYfe7580
	enixfi6wU8jgd5Vbn0vZsDgJ8AFgE1ljOoIMdGk=
X-Google-Smtp-Source: AGHT+IEH85kmyJa9HAMrZrBhLb+hu6BEJBQsEQKkqQlycUOa14TnqczEsbO3YL2DskXZh/nfKcCZOU7E+aePI4/vrNM=
X-Received: by 2002:a05:6808:1a86:b0:3a9:efde:a022 with SMTP id
 bm6-20020a0568081a8600b003a9efdea022mr12874601oib.5.1696340955330; Tue, 03
 Oct 2023 06:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002135352.2603096-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002135352.2603096-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 15:49:04 +0200
Message-ID: <CAJZ5v0jrKP1wWJ=GO8OCkPsjYzn=4DwbP3xeqfdCJ25TmQkWGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: ACPI: Switch to use acpi_evaluate_dsm_typed()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 3:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pci-acpi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49c..cf108259aef6 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1215,12 +1215,12 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>         if (!pci_is_root_bus(bus))
>                 return;
>
> -       obj =3D acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm=
_guid, 3,
> -                               DSM_PCI_POWER_ON_RESET_DELAY, NULL);
> +       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_ac=
pi_dsm_guid, 3,
> +                                     DSM_PCI_POWER_ON_RESET_DELAY, NULL,=
 ACPI_TYPE_INTEGER);
>         if (!obj)
>                 return;
>
> -       if (obj->type =3D=3D ACPI_TYPE_INTEGER && obj->integer.value =3D=
=3D 1) {
> +       if (obj->integer.value =3D=3D 1) {
>                 bridge =3D pci_find_host_bridge(bus);
>                 bridge->ignore_reset_delay =3D 1;
>         }
> @@ -1376,12 +1376,13 @@ static void pci_acpi_optimize_delay(struct pci_de=
v *pdev,
>         if (bridge->ignore_reset_delay)
>                 pdev->d3cold_delay =3D 0;
>
> -       obj =3D acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
> -                               DSM_PCI_DEVICE_READINESS_DURATIONS, NULL)=
;
> +       obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
> +                                     DSM_PCI_DEVICE_READINESS_DURATIONS,=
 NULL,
> +                                     ACPI_TYPE_PACKAGE);
>         if (!obj)
>                 return;
>
> -       if (obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.count =3D=
=3D 5) {
> +       if (obj->package.count =3D=3D 5) {
>                 elements =3D obj->package.elements;
>                 if (elements[0].type =3D=3D ACPI_TYPE_INTEGER) {
>                         value =3D (int)elements[0].integer.value / 1000;
> --
> 2.40.0.1.gaa8946217a0b
>

