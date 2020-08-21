Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3324DF88
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHUS2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 14:28:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45979 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgHUS2x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 14:28:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id o21so2298607oie.12;
        Fri, 21 Aug 2020 11:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zXZIgCAakjsdNMqDTQ9OdhUqc8aoLFT/Ev7IhMzMsk=;
        b=CqNS/nixEAmTficKp/RL0Ks0o5uUl3ztZ6hnmvp4yxJUGCef9wr/LLJ7OcJdfZe9C0
         nJUKLbK7oyHhM2RhLbQIuFPgpQDwKD23fvZ7anngUeV4NpbbMTq6I5mhpYUWWkqCOI7u
         i5NKsp4CostSKgSmwqV0jaypGEaRtJmq3a4Er15ESYf5DFGP9EjRr4VQroPjF8XU9ro3
         X42r/Yi4NhOE3i0T7XE3DD+o9jWKxcP1vHw6ndW5mEM0yo87O1Q8PEMMotqUosK0VxG8
         F98WiHAKCUY2rruvcmJylcICBVWxUpG0j+jUcYImUyDSjo/jO6bZepi4iVgOEn9Mvqbu
         +jBA==
X-Gm-Message-State: AOAM530YgAUvem2Y55E0VASeDYYjGfd0q32GWGsRqFqSEe+T9+cl63a+
        aMpmvQZqoVV23mcDpCLyX1esX3ixSmf953o0vGk=
X-Google-Smtp-Source: ABdhPJwo4v+bahA41e9ZWtLtpBPogqz1x0/57tZqP3kKMwFe5aYH3e0vzQOOukfdhIBJZscikxIZrUISkTbm5IZp4AQ=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr2692389oie.110.1598034532187;
 Fri, 21 Aug 2020 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200819171656.2650926-1-furquan@google.com>
In-Reply-To: <20200819171656.2650926-1-furquan@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Aug 2020 20:28:41 +0200
Message-ID: <CAJZ5v0h3vFLyY9AXYFvcJD3agYk7RFCyzkWefDk_9bvCE09RNg@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: apd: Check return value of acpi_dev_get_property
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Aaron Durbin <adurbin@google.com>,
        "Agrawal, Akshu" <akshu.agrawal@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 19, 2020 at 7:17 PM Furquan Shaikh <furquan@google.com> wrote:
>
> `fch_misc_setup()` uses `acpi_dev_get_property()` to read the value of
> "is-rv" passed in by BIOS in ACPI tables. However, not all BIOSes
> might pass in this property and hence it is important to first check
> the return value of `acpi_dev_get_property()` before referencing the
> object filled by it.
>
> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
>  drivers/acpi/acpi_apd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 4c348377a39d..806b8ce05624 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -99,8 +99,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
>         if (ret < 0)
>                 return -ENOENT;
>
> -       acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj);
> -       clk_data->is_rv = obj->integer.value;
> +       if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
> +               clk_data->is_rv = obj->integer.value;
>
>         list_for_each_entry(rentry, &resource_list, node) {
>                 clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
> --

Applied (with minor subject edits) as 5.9-rc material, thanks!
