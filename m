Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C929EDD8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ2OGA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 10:06:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34621 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJ2OF7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 10:05:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id z23so3315736oic.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 07:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYUAUwptz6g87Fmj2XZQ6mYpg6IzkbfMGRnHpyP92vw=;
        b=uOzjcGUlPrfz/AD4qInI0cr3DeUGYgvwEg03iBbLV4FchgNremvKVTQfY9Q6wfHaHG
         KS0OYPLZ5SuiZeSf/nKwmhMx1gEyzo0d3TwYnWjd1fid4BxnO8tGh8x3yBACyBltYjuX
         t6L4GuUNlNxMMj6bQECI3jDcr0g6S7jYnrKRFgPt0Ju8sNDFkVTAQUy3/f803DnKZCI1
         1P7AgrxNjZ3PVdwp1vnH4QhhGbS3hZfcZ1BdbtMvfX46+UoS8t6MbAmC3yldCo4PVPoM
         TID62n+tM4RSB2cEt9nlDZFa5K1oO3q/LYf2/J2vHIM98Fzg7xond19YaSFX7kt9tldj
         NxTA==
X-Gm-Message-State: AOAM532sBeydrh+zroCJ1sAMvEh3SIth9vdzFdfJCRZarsVx1qIfEIqw
        LhFiBTQvIDLRw6r3rH2t4aGO5YKo30E+EX90d1Y=
X-Google-Smtp-Source: ABdhPJy5xB6eXqdClJ5njBzhr1nb3AjwfDoTn5oYChEpj8uisJv2Ms5EZa1I3M3tQeNJY10WMmmvcOaDNphTkp9jsAU=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr3070803oiw.69.1603980358435;
 Thu, 29 Oct 2020 07:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201028200523.111028-1-mark.asselstine@windriver.com>
In-Reply-To: <20201028200523.111028-1-mark.asselstine@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 15:05:46 +0100
Message-ID: <CAJZ5v0hr4xFA9bGJM+0e4i-QpESPnwy5ZT4KPwfJgby5Sz3UBw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: avoid double free when object already has a zero
 reference count
To:     Mark Asselstine <mark.asselstine@windriver.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Erik and Bob

On Thu, Oct 29, 2020 at 3:05 AM Mark Asselstine
<mark.asselstine@windriver.com> wrote:
>
> The first trip into acpi_ut_update_ref_count() for an object where
> 'object->common.reference_count' is 1 and we are performing a
> REF_DECREMENT will result in 'new_count' being 0 and thus the object
> is deleted via acpi_ut_delete_internal_obj().
>
> If for some reason we make a subsequent trip into
> acpi_ut_update_ref_count() with the same object,
> object->common.reference_count' will be 0 and performing a
> REF_DECREMENT will produce a warning msg "Reference Count is already
> zero, cannot decrement", 'new_count' will again be 0 and the already
> deleted object will be attempted to be deleted again via
> acpi_ut_delete_internal_obj().
>
> Since the object deletion doesn't NULL the object the calls to
> acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
> acpi_os_release_object(), kmem_cache_free() will operate on the object
> as if it hasn't been deleted. In many cases this can result in no
> issues, but if you are using the slab and a new object has been
> created with the same address this can be the cause slab corruption.
>
> Adding a check if we are decrementing to 0 for the first time and only
> calling acpi_ut_delete_internal_obj() in this case will prevent
> another attempt at deleting the object.
>
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> ---
>  drivers/acpi/acpica/utdelete.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index 4c0d4e434196..c6b860fd9eb5 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
>                                       ACPI_GET_FUNCTION_NAME, object,
>                                       object->common.type, new_count));
>
> -               /* Actually delete the object on a reference count of zero */
> +               /* If we haven't already, actually delete the object on a reference count of zero */
>
> -               if (new_count == 0) {
> +               if (new_count == 0 && original_count != 0) {
>                         acpi_ut_delete_internal_obj(object);
>                 }
>                 message = "Decrement";
> --
> 2.17.1
>
