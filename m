Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831752AC3CC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgKIS1Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:27:25 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:39155 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKIS1Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:27:24 -0500
Received: by mail-oo1-f67.google.com with SMTP id l10so976803oom.6;
        Mon, 09 Nov 2020 10:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88lH12aP72k/JqqtafP44DWoY/B1GwcPDfqd9vj7KR8=;
        b=GH32kG16r7XUnXnzLe0qgj+f1yrCTwMqXNHBz5KvFHWGYJytsH/79BAAbbmlPzWkYz
         G/t8mbrt3Yo7xOl+af8yuHJ+/KrNIaFZJjhy2YvdoAtJKrbBhdJkjWhqPJMxYQzeW8qW
         e1j4duwC1AffYweXGtF5HPkkYhbU9SeIv+Sd9dX45qRGPv0E2Ki3NJNY4URPXUn4gxSU
         h3MT2sgeG6Ig4G8q0Cj/xaCdE7VyfmQzUzY6Y8aBQquvnN9sTL8ONyAHxIktmHrGUlno
         P0dyOCRiNSEHeOEqi/OESAbpa9GiE5e8WMchLbjRdWi6vYeksGtL7ZO3IolBRWYIs3Kc
         pnoQ==
X-Gm-Message-State: AOAM5327eVnQfhsQj4uKWO6NNJ8ti+0JiG3D5BtUC8yEpx787urna1d5
        cfbgPCplPN0jg3MqQ4xK5TJdiUNgQQ9JqMHbRaM=
X-Google-Smtp-Source: ABdhPJxo5Gu9VTamOxr1DOm2plXMdvZ3n4HVqYLlNof+Z9kzeYY4S2nKqn5a8zlU6GgASeJ1F4wFPgIMyvvdzJiC1/I=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr10822224oob.1.1604946443729;
 Mon, 09 Nov 2020 10:27:23 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
 <20201107084939.3512560-1-ndesaulniers@google.com>
In-Reply-To: <20201107084939.3512560-1-ndesaulniers@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 19:27:12 +0100
Message-ID: <CAJZ5v0iMGZ5Kj=o7Lo_yZNp8qk5BnpiJZNy4_-zdRJh1tFOSgQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: GED: fix -Wformat
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 7, 2020 at 9:49 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Clang is more aggressive about -Wformat warnings when the format flag
> specifies a type smaller than the parameter. It turns out that gsi is an
> int. Fixes:
>
> drivers/acpi/evged.c:105:48: warning: format specifies type 'unsigned
> char' but the argument has type 'unsigned int' [-Wformat]
> trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
>                                             ^~~
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Fixes: ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/acpi/evged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index b1a7f8d6965e..fe6b6792c8bb 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -101,7 +101,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
>
>         switch (gsi) {
>         case 0 ... 255:
> -               sprintf(ev_name, "_%c%02hhX",
> +               sprintf(ev_name, "_%c%02X",
>                         trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
>
>                 if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
> --

Applied as 5.10-rc material, thanks!
