Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42C3A6A2B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhFNP3A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:29:00 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39446 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhFNP2r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:28:47 -0400
Received: by mail-oi1-f175.google.com with SMTP id m137so14775404oig.6;
        Mon, 14 Jun 2021 08:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sSq9ybaXLzcEnLmrkiwounRgSaQeLjSaCKta1cywKc=;
        b=nhkROyZKIv46j5Hb7csZUn3JjBRYap22btsUFkO50IFH8tOK4rUVHDroE6XY43Vr7a
         pGQ+cPzItXDvw6COpxN1p0Lm7wRIWD9Dz/cLEyRsqhFGwj++YGsmFoPz1XMUmtPPIqN+
         ubVqZ1T9AajIgrDequosKwh81TanPGrU7Nk2qptFwRGYE0Txn3/b3yXJB477AAGo9doU
         tQyYtMAQqgOKDA0io+xhSADFLqw6IRcv+Y79Wgia6JhjnoJWdHE8Mt8j8ZW+QSC35lNJ
         90ffyfgTHhTOm6sooNURVBi84rIiNNiqCoku/6VaEx4fRGN/lkyNFGgF7MQ4IoA8D+1a
         JxOw==
X-Gm-Message-State: AOAM531+gzeclfxwiwdVKdYaeOGvgie2a57dyKzLk7bRadJ/Y3CfaqqI
        5VGyFksj/La0w7P7KnR2VnxJ3UJFQRjnSW7VZSo=
X-Google-Smtp-Source: ABdhPJxCnoxVRhoWU2aoXrjzOpuc+fuJ3e8PcK/gmRG4OYJmM75ITjAeaW9XnEKD15icAM7zVqV8jSW+n/ipruphUV0=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr8999247oia.157.1623684404808;
 Mon, 14 Jun 2021 08:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210610113501.3439670-1-libaokun1@huawei.com>
In-Reply-To: <20210610113501.3439670-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:26:33 +0200
Message-ID: <CAJZ5v0ivf6xN0pd4Ub6YuKCwDUpXLcEZywdT+JPKa=1qTOH-iA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: sysfs: fix doc warnings in device_sysfs.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 1:25 PM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/acpi/device_sysfs.c:278: warning: Function parameter or
>   member 'dev' not described in 'acpi_device_uevent_modalias'
>  drivers/acpi/device_sysfs.c:278: warning: Function parameter or
>   member 'env' not described in 'acpi_device_uevent_modalias'
>  drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>   member 'dev' not described in 'acpi_device_modalias'
>  drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>   member 'buf' not described in 'acpi_device_modalias'
>  drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>   member 'size' not described in 'acpi_device_modalias'
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/acpi/device_sysfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index fa2c1c93072c..3b08efa88ba5 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -268,7 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>
>  /**
>   * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
> - *
> + * @dev: Struct device.
> + * @env: Uevent kobject.

This doesn't appear to be accurate.

@env doesn't point to a kobject.

>   * Create the uevent modalias field for ACPI-enumerated devices.
>   *
>   * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
> @@ -313,7 +314,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
>
>  /**
>   * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
> - *
> + * @dev: Struct device.
> + * @buf: The buffer.
> + * @size: Size of the buffer.
>   * Create the modalias sysfs attribute for ACPI-enumerated devices.
>   *
>   * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
> --
> 2.31.1
>
