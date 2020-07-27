Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5522ED27
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgG0NYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 09:24:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43802 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0NYQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 09:24:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id l84so1751593oig.10;
        Mon, 27 Jul 2020 06:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPijsWsA86ncuQ4YsaqIM+LvW4eENySIZkL8qr7mFnI=;
        b=ui8f+KUTdFarHw/52QqxxNiqpgJdfqXJPxZfP95AoXINyirlI7aroyaPg7OE1OthuO
         zs5LwuOZuJb1rk1016pERxHMmuP7yHwBNpcoH+yH8FimzhJOqKP+XVPQqOK+vyLlv1kT
         1s180zaY1YQiQpFa//RwpgKmq/XUJx4LfpKcEjPFbdBsBIRu3ne+WvdOr9taY3UqCej4
         h2ZXRioNPNzOP5hRQakte/Y+OzU5eSF/7+xl2hqxVXZ/HzZDpxu3MSVETuU0jCsqk3DN
         3Dxf2BYMlNcm+sarer0muwIkPGdXxrdHrDQq4EyF/ODIk2vvghnh5Uu3Qp/i5eopj7bE
         4kqA==
X-Gm-Message-State: AOAM533hiMKsdDxHuzIQ+WXHTAC8cw+u0CpoXo3mnlnGvR7RONk1rMt6
        C+KWH3Y8C2hNF/fUVaT7DBgIg9uNis27Fj96AkeI+Q==
X-Google-Smtp-Source: ABdhPJwxgeTfu25/fNqV/Yp7m4UiuLztNmLGBCv6sgMQ/dSVqrERZH1ePjwzvqq5MtdHN4jGfHFnB4USsnISOTsaoQw=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr18906467oia.103.1595856255175;
 Mon, 27 Jul 2020 06:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200722170608.960983-1-colin.king@canonical.com>
In-Reply-To: <20200722170608.960983-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:24:04 +0200
Message-ID: <CAJZ5v0gPLp2FdP15-g6G=RksmcqyF4v1a01=2jhoXj0P9ii0Tg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: remove redundant assignment to variable rc
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 22, 2020 at 7:06 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable rc is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/apei/hest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 953a2fae8b15..6e980fe16772 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -227,7 +227,7 @@ __setup("hest_disable", setup_hest_disable);
>  void __init acpi_hest_init(void)
>  {
>         acpi_status status;
> -       int rc = -ENODEV;
> +       int rc;
>         unsigned int ghes_count = 0;
>
>         if (hest_disable) {
> --

Applied as 5.9 material, thanks!
