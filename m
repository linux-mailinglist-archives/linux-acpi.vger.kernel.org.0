Return-Path: <linux-acpi+bounces-818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7A7D15E0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048312825EA
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951B22318
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160E200B8
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 17:18:55 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649451A3;
	Fri, 20 Oct 2023 10:18:54 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-582a82e6d10so186377eaf.0;
        Fri, 20 Oct 2023 10:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822333; x=1698427133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n25ZsIjVgwdoWfh3XSdHmKLoMT8TMmQ/tKnMBeP8l4=;
        b=hEy99NOaBsqoDKNsVa54kId7XTthfGeGwu3Ci3xqfJb6OiQPAvjCiGTNGsub2C9fwA
         rak3XdfAiDr7pAHyuTRrY63ZsM47O6j7tFuuv5WVsuKNoqWNoUxKqXHMYMssVcKqvBcB
         gHk2RUHndkN8w7uNNd963dIT2e0jtSD2zaL2YzD4Ytfpm9O67K5PxragTzqCKz3LoCco
         4E1plQQUvbeA/Sa7wZ+PaOrkk3NyvIRo2iasVNOqZo2/stEqDeG0rZiU9nVahkK/XYP8
         HTJ/82q56b5Fa3tkP6E+kVnNtLtUnd89ePlPMgDNmN/Dw1m4qJuy5RD0QuDsnbbpURMo
         sFVQ==
X-Gm-Message-State: AOJu0Yy4RkECe5W1nMObrUhefgqEmA43V3iUKkSVIqC+bcbAojLNz/LG
	gLnzM8x3CgykGtzu+P0u2HP8Nmjvd9Jd8mqEPSg=
X-Google-Smtp-Source: AGHT+IGXlNj0odD0nbHMJX66MfvABuHCkxjXMfHbLUcotDNtggdQwyBnqZ31JPNvUMc/D/6nj/vPqdrSaHKGUvOr/XU=
X-Received: by 2002:a4a:bb0f:0:b0:583:fc94:c3fd with SMTP id
 f15-20020a4abb0f000000b00583fc94c3fdmr2933669oop.0.1697822333648; Fri, 20 Oct
 2023 10:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-4-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-4-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:18:42 +0200
Message-ID: <CAJZ5v0ibBZ0e4_7=2h9rEjrBXGgsmYxZBO91_VfSxhgD9xJ=tQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] ACPI: sysfs: use acpi_device_uid() for fetching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> Convert manual _UID references to use standard ACPI helpers.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/acpi/device_sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index b9bbf0746199..9d8e90744cb5 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -410,7 +410,7 @@ static ssize_t uid_show(struct device *dev,
>  {
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>
> -       return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
> +       return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
>  }
>  static DEVICE_ATTR_RO(uid);
>
> @@ -554,7 +554,7 @@ int acpi_device_setup_files(struct acpi_device *dev)
>
>         if (dev->pnp.type.bus_address)
>                 result =3D device_create_file(&dev->dev, &dev_attr_adr);
> -       if (dev->pnp.unique_id)
> +       if (acpi_device_uid(dev))
>                 result =3D device_create_file(&dev->dev, &dev_attr_uid);
>
>         if (acpi_has_method(dev->handle, "_SUN")) {
> @@ -635,7 +635,7 @@ void acpi_device_remove_files(struct acpi_device *dev=
)
>         if (acpi_has_method(dev->handle, "_HRV"))
>                 device_remove_file(&dev->dev, &dev_attr_hrv);
>
> -       if (dev->pnp.unique_id)
> +       if (acpi_device_uid(dev))
>                 device_remove_file(&dev->dev, &dev_attr_uid);
>         if (dev->pnp.type.bus_address)
>                 device_remove_file(&dev->dev, &dev_attr_adr);
> --

Applied as 6.7 material, thanks!

