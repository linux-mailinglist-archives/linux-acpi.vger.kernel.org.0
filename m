Return-Path: <linux-acpi+bounces-761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673677CFFBD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076ACB20F71
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9927475
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0903158B
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 15:43:39 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CEF198
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 08:43:25 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57b83ff7654so613728eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 08:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730205; x=1698335005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2ChnxZG/VgBeabcVh8eKWDyi6/8hg/NtlFoAWl5NY8=;
        b=e07lOzdpJF7AO5lAryZ7OWIrpnPZ4shjDxrRVlwrVmngvyrovQNiIJ5kcePWDqopwi
         m0px3ibjua95L7QGjr8Q0hXoC9dKvqfBxnP8hI6u5OKamd6Dsbpu5YLrZWwNZH1DYhAo
         /wDRoZJEZl3+o/Xdy/FuGptPDS0SXGB1rd3F2M5Ql0QyupwcqGBSK9Yz08AG9fbJLoyk
         8fxelziIB6UMFZB/jfZ/rpGI1gZH/UkV+sU6pkvwe1BW9b4UWXkqW99TjHE7MQjXiu58
         gEm26MFiIkwSoHVuDZOnHU1AEbZ9OS/inGDAgb+dhIncDSts66yUB+9yuqCQDWbB/5KP
         iipg==
X-Gm-Message-State: AOJu0YyPbL+jBVGPZ3+oJj7SCbHwURqCTlWqWnSlezUPjERDWnNuJJRF
	+VrCH2pF2X7BKuHSAK/1NEPkhX6y2VfaGAAXUVk=
X-Google-Smtp-Source: AGHT+IHscgUh+M184TsU2IarjQrdiDFUytd6te67vy59qauFVXU+O/axi9NPtceVXonSojnetCCJ9DT6jfrnLlzbh5w=
X-Received: by 2002:a4a:5297:0:b0:584:537:ffbd with SMTP id
 d145-20020a4a5297000000b005840537ffbdmr1261662oob.0.1697730204766; Thu, 19
 Oct 2023 08:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697720481-150095-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1697720481-150095-1-git-send-email-chenxiang66@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Oct 2023 17:43:13 +0200
Message-ID: <CAJZ5v0j0A4637V5OEtjP-HMGhH80T=1kPjO_QXbgbBSZHvJY=w@mail.gmail.com>
Subject: Re: [PATCH] Install Notify() handler before getting NFIT table
To: chenxiang <chenxiang66@hisilicon.com>, Dan Williams <dan.j.williams@intel.com>
Cc: michal.wilczynski@intel.com, rafael@kernel.org, linuxarm@huawei.com, 
	linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 2:57=E2=80=AFPM chenxiang <chenxiang66@hisilicon.co=
m> wrote:
>
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> If there is no NFIT at startup, it will return 0 immediately in function
> acpi_nfit_add() and will not install Notify() handler. If hotplugging
> a nvdimm device later, it will not be identified as there is no Notify()
> handler.

Yes, this is a change in behavior that shouldn't have been made.

> So move handler installing before getting NFI table in function
> acpi_nfit_add() to avoid above issue.

And the fix is correct if I'm not mistaken.

I can still queue it up for 6.6 if that's fine with everyone.  Dan?

> Fixes: dcca12ab62a2 ("ACPI: NFIT: Install Notify() handler directly")
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/acpi/nfit/core.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 3826f49..9923855 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3339,6 +3339,16 @@ static int acpi_nfit_add(struct acpi_device *adev)
>         acpi_size sz;
>         int rc =3D 0;
>
> +       rc =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> +                                            acpi_nfit_notify, adev);
> +       if (rc)
> +               return rc;
> +
> +       rc =3D devm_add_action_or_reset(dev, acpi_nfit_remove_notify_hand=
ler,
> +                                       adev);
> +       if (rc)
> +               return rc;
> +
>         status =3D acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
>         if (ACPI_FAILURE(status)) {
>                 /* The NVDIMM root device allows OS to trigger enumeratio=
n of
> @@ -3386,17 +3396,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>         if (rc)
>                 return rc;
>
> -       rc =3D devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_des=
c);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -                                            acpi_nfit_notify, adev);
> -       if (rc)
> -               return rc;
> -
> -       return devm_add_action_or_reset(dev, acpi_nfit_remove_notify_hand=
ler,
> -                                       adev);
> +       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_des=
c);
>  }
>
>  static void acpi_nfit_update_notify(struct device *dev, acpi_handle hand=
le)
> --

