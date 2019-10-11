Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAED3D8A
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJKKjC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 06:39:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37009 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKjB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 06:39:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id i16so7600364oie.4;
        Fri, 11 Oct 2019 03:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tb4OyPeBvddVVgZ3mAAcmtLcYtmURpW+oNgkhTLycc=;
        b=gNx6TnFWJfQv4bwHZ8QhYfn3NI44sWyxs+AlLC/iYVLn9kCof/sIpkbzLl2agu+OpV
         ikkc6zhLez+OYL/RMw0GLgJ2z3xKcxA39w8ZlUVM1v2+oodD+lTbCFhd49P3DEkiKDLv
         N45TqpTui2t7xJycakrao246LPqNVvJ4N/SxVKGK59tdheRWn7ZuSBBOa/hx3buJMs/B
         VU8QQ62Z/BkXQOs9oi4xuOQAhGwTVZfTwMlTQO+oZp/K8QUbU1RJXVaV72fORMxoGooI
         lDSp7UyqKtPMjvG6dEreS4o10As5HfKJPYWOmh/vkD5ee2uRv6IMRTGO+SD6TRV70YNN
         I4wg==
X-Gm-Message-State: APjAAAVPe1bOQnBvPPC8Y1eiTJX50/BhuuBXFrp7M+KAklvP38/pkp8d
        hekB1lltxsvwRarVFu2Od4IQcilBPqMe201UumzB8A==
X-Google-Smtp-Source: APXvYqxQJUnKRLLcrN7dm7Pyw1dBZn5rts9p263jE4FizkPGHP2kBVS1voppc6S+ATQ1vRGvdZx6uZtLUGnDOLoVDvY=
X-Received: by 2002:aca:5885:: with SMTP id m127mr11800131oib.110.1570790340768;
 Fri, 11 Oct 2019 03:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191009130433.29134-1-sameo@linux.intel.com> <20191009130433.29134-2-sameo@linux.intel.com>
In-Reply-To: <20191009130433.29134-2-sameo@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Oct 2019 12:38:49 +0200
Message-ID: <CAJZ5v0ioC6XnC+sFpRJmm40T+YCnqoaHhJ+_Pmk7rvvC8UPT9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: Fail GED probe when not on hardware-reduced
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 9, 2019 at 3:04 PM Samuel Ortiz <sameo@linux.intel.com> wrote:
>
> The Generic Event Device (GED) is a hardware-reduced platform device.

No, it is not AFAICS.

The spec doesn't say that GED cannot be used on platforms that aren't
HW-reduced and if evged.c is going to be built in unconditionally, the
kernel will be able to handle GED regardless.

> Probing this driver on fixed platforms should fail.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/acpi/evged.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index aba0d0027586..55de4b2d2fee 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -127,6 +127,9 @@ static int ged_probe(struct platform_device *pdev)
>         struct acpi_ged_device *geddev;
>         acpi_status acpi_ret;
>
> +       if (!acpi_gbl_reduced_hardware)
> +               return -ENODEV;
> +
>         geddev = devm_kzalloc(&pdev->dev, sizeof(*geddev), GFP_KERNEL);
>         if (!geddev)
>                 return -ENOMEM;
> --
> 2.21.0
>
