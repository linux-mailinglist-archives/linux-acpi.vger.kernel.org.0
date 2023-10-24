Return-Path: <linux-acpi+bounces-882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AB7D4FE6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913BA280D40
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B424273C1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B19266D0
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 12:02:19 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31E120;
	Tue, 24 Oct 2023 05:02:17 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2d9a9c824so1006841b6e.0;
        Tue, 24 Oct 2023 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148937; x=1698753737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2pHDhFBV3p+9e1mZi2uGJDDYekveY6SeTMBwmaYx/4=;
        b=SzR3QQEYyvhYRcAV2mt9thqEo+GgfpLYPwXexHxaEJ8URGnqceLxSYECZzWRCJkKx0
         rZ2QGxui+UFef4QKs9ZbZ45IEqIU4mSud3D0mKPeZe0F3PZWmONM8i3tu9n+iESja9tP
         RkCV0l7UwYXx8zBZP4Ubdivsxj0YFr4MuEmtuJ6izvEU/Re8WQx9H+As1Sr/pHsGfSpX
         qjYpgkoJZs32R7TDoasiTfEdfogF59ApFtrRbvDIILONyAKudftuwdQj4m68+fqRIth7
         +nhPUHwfHQF++EJNw3bEUg+zac3MaCxcqioi26tXrteZKXIpjVQQxXYc6L3PFGEAnffp
         bmlw==
X-Gm-Message-State: AOJu0Yys0jeFsrf8FGpN2jdKNA6LLUavTE2B2MxGPzULME9GMfwm40ZN
	4p6yDIcocdahMT87J7v55JLqG99qPAk6YcQ9gmU=
X-Google-Smtp-Source: AGHT+IGIETBiiFD1D2fRVRb8FftiTW+n7MOvkpWXai2dprUcsPzAq6Nyi8wxC+U5gNTBl00FSuUydUoDBwyRfxz40/M=
X-Received: by 2002:a05:6808:1513:b0:3ae:5e6a:5693 with SMTP id
 u19-20020a056808151300b003ae5e6a5693mr13497868oiw.0.1698148937006; Tue, 24
 Oct 2023 05:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 14:02:05 +0200
Message-ID: <CAJZ5v0hEXaYSgre=F=hZ0XTRqupaBR5Grnck=tQtfj4inDkOKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about enumeration
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:47=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> acpi_scan_device_not_present() is called when a device in the
> hierarchy is not available for enumeration. Historically enumeration
> was only based on whether the device was present.
>
> To add support for only enumerating devices that are both present
> and enabled, this helper should be renamed. It was only ever about
> enumeration, rename it acpi_scan_device_not_enumerated().
>
> No change in behaviour is intended.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This is another patch from James' aarch64 hotplug vcpu series.
>
> I asked:
> > Is this another patch which ought to be submitted without waiting
> > for the rest of the series?
> to which Jonathan Cameron replied:
> > Looks like a valid standalone change to me.
>
> So let's get this queued up.
>
>  drivers/acpi/scan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ed01e19514ef..17ab875a7d4e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -289,10 +289,10 @@ static int acpi_scan_hot_remove(struct acpi_device =
*device)
>         return 0;
>  }
>
> -static int acpi_scan_device_not_present(struct acpi_device *adev)
> +static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
>  {
>         if (!acpi_device_enumerated(adev)) {
> -               dev_warn(&adev->dev, "Still not present\n");
> +               dev_warn(&adev->dev, "Still not enumerated\n");
>                 return -EALREADY;
>         }
>         acpi_bus_trim(adev);
> @@ -327,7 +327,7 @@ static int acpi_scan_device_check(struct acpi_device =
*adev)
>                         error =3D -ENODEV;
>                 }
>         } else {
> -               error =3D acpi_scan_device_not_present(adev);
> +               error =3D acpi_scan_device_not_enumerated(adev);
>         }
>         return error;
>  }
> @@ -339,7 +339,7 @@ static int acpi_scan_bus_check(struct acpi_device *ad=
ev, void *not_used)
>
>         acpi_bus_get_status(adev);
>         if (!acpi_device_is_present(adev)) {
> -               acpi_scan_device_not_present(adev);
> +               acpi_scan_device_not_enumerated(adev);
>                 return 0;
>         }
>         if (handler && handler->hotplug.scan_dependent)
> --

Applied as 6.7 material, thanks!

