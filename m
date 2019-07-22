Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3276FB53
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGVIbY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 04:31:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35256 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGVIbY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jul 2019 04:31:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so906159otq.2;
        Mon, 22 Jul 2019 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH9X5iNUAvdfUeKpd2p6uIpK5xHWBxmzhoraupHL3oQ=;
        b=sMenGcp3OTQN/G7+T0j7duv8w8jRGa3Tzbw72xbmVz5KMxSYNxv5IMVATO0rP+7F1C
         bK9IQwtWZeaGOcXyReF3FSpk7ZLVQuGK1ffQzMX92dYAVpEH6MHwcWwN5NhRu3QJLKkS
         wrQIOxrlJ2E7bNC2sL8/aEF5HHt223MZqS6oLG4zxSF3eR+wrwJrXFQcWErB6eWzeX5l
         qY6PWhuPw+Oiqrrdfgrk+7XLmbnpmljzAGg/hKFk0BvkvLyqKwLXFHHI8FzrysK3G3dW
         l9+zaDndADHJXSlFbJcjsrhOzEmxiAhqTc2ZZSiADLeTIsVlKZHKEn8qNg/+KgRucgXs
         MRFw==
X-Gm-Message-State: APjAAAXpq/wQmLtl2WjomEAXZS5kglXRed+pooCtnnaxU7X26WUGK4mI
        0mltvOaDgTFjvgzLZNeFzd7g1HDWpebeWF5QLwI=
X-Google-Smtp-Source: APXvYqwVqSP5V8Tus+6+2dAP0uhrF6qtZQqEUYrU6BBe3c5Fb5++tjEKA8b6i/rttuFeFAwAF1qfTViUfKgP2vgQwfw=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr21838380oto.167.1563784283215;
 Mon, 22 Jul 2019 01:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com> <20190722023530.67676-2-skunberg.kelsey@gmail.com>
In-Reply-To: <20190722023530.67676-2-skunberg.kelsey@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jul 2019 10:31:11 +0200
Message-ID: <CAJZ5v0gRzu0bVL+7L9NhbWu5OxveEP8H8v5qpiW-FeOtoOepiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: Remove acpi_has_method() call from acpi_adxl.c
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 22, 2019 at 4:36 AM Kelsey Skunberg
<skunberg.kelsey@gmail.com> wrote:
>
> acpi_check_dsm() will already return an error if the DSM method does not
> exist. Checking if the DSM method exists before the acpi_check_dsm() call
> is not needed. Remove acpi_has_method() call to avoid additional work.
>
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/acpi/acpi_adxl.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> index 13c8f7b50c46..89aac15663fd 100644
> --- a/drivers/acpi/acpi_adxl.c
> +++ b/drivers/acpi/acpi_adxl.c
> @@ -148,11 +148,6 @@ static int __init adxl_init(void)
>                 return -ENODEV;
>         }
>
> -       if (!acpi_has_method(handle, "_DSM")) {
> -               pr_info("No DSM method\n");

And why is printing the message not useful?

> -               return -ENODEV;
> -       }
> -
>         if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
>                             ADXL_IDX_GET_ADDR_PARAMS |
>                             ADXL_IDX_FORWARD_TRANSLATE)) {
> --
> 2.20.1
>
