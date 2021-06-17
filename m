Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146843AB3A5
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFQMhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 08:37:03 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36656 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFQMhD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 08:37:03 -0400
Received: by mail-oi1-f178.google.com with SMTP id r16so6362230oiw.3;
        Thu, 17 Jun 2021 05:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdjslE2NTbvCF99t6OexeD1cWf6uCdtibYwpPkNsfxk=;
        b=M390srI7G1/3Sd0lah956f8qqkVZeZGfC/2MXHAn+jfk4oKYbMX0Ndr/2Q7KeoQfSl
         7rpONfJw+/jVStWI5BHF2TpV8pI1Y1RK45H0saU18wrmBJF5kpmYBhw9BRvSvmvnNsmb
         XJx/TfRGSRhqRPSlLueSltLOgVmnhFzuzA31R/jT9/AFth1dCJd4RRVUMe9igZKEfYbN
         EJ2Oh8BZL+5Y2YABRJGprMeDSlkkwGJuSN8ZqRDULG6Yz8mc1mdViVtM95QkYnbXdnvG
         /95k3wSlnef9OWI1brFZQMPyF0vhHGtyvQ02U+LmD3gDp1Iniz2nnEch7lFLeqcWzgqV
         Zl6g==
X-Gm-Message-State: AOAM531AKFqUBAwlir9V7GVsyBBgjqqz3nw6dTKj1gpPu/f9h7AvgBLJ
        KGTZaK2AW+ZPTszZio61pIwwKPT0bCpkVEAV+Fc=
X-Google-Smtp-Source: ABdhPJzMOw6isRiTU8VwxT5tqNP7G526EQXU+dYcmyeNv+ddzkbqAbOlMCnOHUe3ATpVGuaQ9lnC9IszsYsKvqJcbH4=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr10701974oia.157.1623933294840;
 Thu, 17 Jun 2021 05:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210615071914.3067407-1-libaokun1@huawei.com>
In-Reply-To: <20210615071914.3067407-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:34:43 +0200
Message-ID: <CAJZ5v0iMGTDAbY+JivBFRP6soTC5v_imqWZ9jSZoQVeYdgVoCw@mail.gmail.com>
Subject: Re: [PATCH -next v2] ACPI: sysfs: fix doc warnings in device_sysfs.c
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

On Tue, Jun 15, 2021 at 9:10 AM Baokun Li <libaokun1@huawei.com> wrote:
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
> V1->V2:
>         Make comments more appropriate
>
>  drivers/acpi/device_sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index a393e0e09381..d96e38b2a0d1 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -268,6 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>
>  /**
>   * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
> + * @dev: Struct device to get acpi device node.
> + * @env: Environment variables of the kobject uevent.
>   *
>   * Create the uevent modalias field for ACPI-enumerated devices.
>   *
> @@ -313,6 +315,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
>
>  /**
>   * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
> + * @dev: Struct device to get acpi device node.
> + * @buf: The buffer to save pnp_modalias and of_modalias.
> + * @size: Size of buffer.
>   *
>   * Create the modalias sysfs attribute for ACPI-enumerated devices.
>   *
> --

Applied as 5.14 material with fixed spelling ("acpi" -> "ACPI").

Please always spell ACPI in capitals in comments, patch changelogs,
subjects and similar.

Thanks!
