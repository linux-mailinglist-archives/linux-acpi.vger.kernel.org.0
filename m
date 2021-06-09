Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418133A2043
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFIWlW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 18:41:22 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35633 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhFIWlV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 18:41:21 -0400
Received: by mail-ot1-f54.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so25610069otg.2;
        Wed, 09 Jun 2021 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEWuD8KXuieZNHBEBcl8+ntcsvKKDdZFLRqcg/Uf4wc=;
        b=LC7r8Vi5ior1sFSrmmZ6W06JrVOPSy1zZ9oo3gOqS5RwBMOo2g9UBRPSVi49zw0NNj
         6E6bUVc5r7fY27aRN8vt+5nVcSEcoJvAg+CXS6uwzm4sB7HBcuEt7nr91rERIZmh985v
         3ny9L6vOdHrlVa+U2T94zEDUTWX/q7B3NvgSq5CmrijQDvzRXgjkX13/O/oluT6RCeEw
         IlCQPguE1v71Y5Vb4HJP9fC/MOjcHd2TBU/nys0mfQ/DuPjP1yKOcDyHqcBc7dcjVR2a
         HARSayC0diheUyWwn6V/Dt+9Idc3dDeeRm2YFLQR4q8JZKH2Rq2CcOMeKJut1bGrx4jX
         lO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEWuD8KXuieZNHBEBcl8+ntcsvKKDdZFLRqcg/Uf4wc=;
        b=DNb2uNaQYOtpBe/C5C9miZHN/RnujQHGIaU6i5Ld7NUxwP76LXMWat+U8Oi/isnHrI
         jyqW2Cc6ps+U6dJCt2tbyxIkIly2VNlSql9A9ZH/ZnopiEbTAUUlDaGE7sFk78h/qMkZ
         VMCzC7UguN4pdwo1GUwl39Jjir8CnjK0Gh4WktrGMyLoDC2kYjUKejC8YqXna4mU1TAD
         eR6jFg2M0SPRlGCiR78CVSE3tGuRgLTjrMH8thoLR4weV5gN1069wdeFw62DKzD7lS8w
         7P42/NYvMAHo0BFAx0BDBYUs2DSKckA8bAJJayOn8dqmb+sxYzWI2R6bsyUeLzISGPdB
         zzHw==
X-Gm-Message-State: AOAM530zBQ7j6vyjGolveVUUPcQohq/DZwejdQTGvcEXnz2KYfaaUfDE
        udtF4iKLYA+p5u8U+T66nRz9OmjGrpDSpSuPjCQ=
X-Google-Smtp-Source: ABdhPJyrYomschLlY7NnQiYeA+IcoOJnYUDbrD9PXecbJXbM9PpdrvFT9tbv7POCa6Xtfnekz8x42ExeQTc74yt7uho=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr1476662ota.116.1623278290263;
 Wed, 09 Jun 2021 15:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210609173312.298414-1-colin.king@canonical.com>
In-Reply-To: <20210609173312.298414-1-colin.king@canonical.com>
From:   Daniel Scally <djrscally@gmail.com>
Date:   Wed, 9 Jun 2021 22:38:04 +0100
Message-ID: <CAFLoDVE03-Eqmrji66P-b79ezgD0PayWqO5u3L7nyjMX1+LBtg@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: scan: ensure ret is initialized to avoid
 garbage being returned
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Colin

On Wed, Jun 9, 2021 at 6:33 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the unlikely event that there are no callback calls made then ret
> will be returned as an uninitialized value. Clean up static analysis
> warnings by ensuring ret is initialized.

Ah, thanks - good spot.

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a9e10e587304 ("ACPI: scan: Extend acpi_walk_dep_device_list()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Scally <djrscally@gmail.com>

I'm still bad at Git; will the commit hash here be right, since the
patch that this fixes isn't upstream yet?

(hope the gmail web client doesn't maul this too badly...)
> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index c3067e8bfc47..0945d952f0fc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2151,7 +2151,7 @@ int acpi_walk_dep_device_list(acpi_handle handle,
>                               void *data)
>  {
>         struct acpi_dep_data *dep, *tmp;
> -       int ret;
> +       int ret = 0;
>
>         mutex_lock(&acpi_dep_list_lock);
>         list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> --
> 2.31.1
>
