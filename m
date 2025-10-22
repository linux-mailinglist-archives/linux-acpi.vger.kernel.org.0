Return-Path: <linux-acpi+bounces-18123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D539BFE0BC
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C585418C64AE
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E72571DE;
	Wed, 22 Oct 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3S/QH5T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59062212551
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161502; cv=none; b=dmhpPbnBLpbCI4yD/mYlCyzmpDupCW60LH2vra5On9Knt8Qcksh0Y8g86VUJNQGQ+6k5JMLvtpSW/xEdGRKjgy5KKYSwhj5XUfPyCHlkbTpISamONGQvk0xQjg6iLF6IEFKh8jMojDB8WocVp9WPesSy+WZPCA1ZENDVEskBYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161502; c=relaxed/simple;
	bh=SfsKun3GG0AS8OkQHKa1dZWAEiCYN+vunGOsvXAIV1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcNVq1XZV05b9l0AYkKxashi3tiNFvR2Zw4UUfpulNwLR5+u2xN6Z02OSVqmbQDbO8ZpA/8T7rzkylDpJHgHUIHLXIs9AsFNfhZSna0bPNIHNAVWlazaSLPXHEbprvPYpbeCKeGjwika6q28yxtjqylYRAoiZzag60TfIvTJcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3S/QH5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1583C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761161501;
	bh=SfsKun3GG0AS8OkQHKa1dZWAEiCYN+vunGOsvXAIV1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N3S/QH5TBCPe3Q5fwF72Tgh96Co504No+kw3BdPhYFoLkC3IKYyzOcsciw0KfbysU
	 AOvmEiuyI3W1J3LqvIj2SIC+y4/ylERqr8TLYcdjLMWCDqhNcJpaZqY4AJY/TmpoqY
	 ueJpgXyEE19URfWSRkTXO+eo86qGZhrywCo3ZHF3Avl6Dt3wDJpQIeNifEHtxfdW6Z
	 BMQyKHqG6xa0E4r2xhDQOjRWfgJjEgWZKy0RxuCxw8rz/yL0qT5UZ7BKvdxJ/7AqQZ
	 81ww9OhWtW9plolkz9mC8zFHP5qfxttV0SiEILZglFzzy4uDGEwjyDIo9A8ovquaqC
	 Zz/GYmO/eWy8Q==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f802f8571so1959757b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 12:31:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOObubccGc1UY+TK5u3PRyZ0rqre8ffcGoBIer8wdR5NPy6WFB9KM5waUpyjxsZj0uhfSoQwGwQaMV@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDIhMwJND2dzz9qqMD3fxd43T/DUHknQEpR0w/3ODCzjyPZhU
	JWY0aT60ramKAFn0KoglDY+ZBO3VGV7jFCNBRCQW1VnrKxXqgrA04TicK1mGwuXHT9Mp5RlMaay
	3ckWlXy6L7Jz/u5JPTAgHvDNTWUA7PIM=
X-Google-Smtp-Source: AGHT+IFYvVqndW+o65G9Wy272DlrPc74gYc8LYHFDF7S1T5IiuceUNf+fkeYbT5p0r/q38n7w2AU0txsI45qW5up47U=
X-Received: by 2002:a05:6808:1910:b0:43f:5410:c5e3 with SMTP id
 5614622812f47-443a2eef1b5mr9888729b6e.21.1761161501136; Wed, 22 Oct 2025
 12:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 21:31:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
X-Gm-Features: AS18NWA8WtJTQNvjakhdEHy9VxBzKwFYGGesjyVAWIraJRfBNEbewEB0Nccr4u4
Message-ID: <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, Tony Luck <tony.luck@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 12:24=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add proper error handling and resource cleanup to prevent memory leaks
> in add_boot_memory_ranges(). The function now checks for NULL return
> from kobject_create_and_add(), frees allocated names after use, and
> implements a cleanup path that removes previously created sysfs groups
> and kobjects on failure.
>
> This prevents resource leaks when kobject creation or sysfs group
> creation fails during boot memory range initialization.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/acpi/acpi_mrrm.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 47ea3ccc2142..6ec42eb48783 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -152,23 +152,48 @@ static __init int add_boot_memory_ranges(void)
>         struct kobject *pkobj, *kobj;
>         int ret =3D -EINVAL;
>         char *name;
> +       int i;
>
>         pkobj =3D kobject_create_and_add("memory_ranges", acpi_kobj);
> +       if (!pkobj)
> +               return -ENOMEM;
>
> -       for (int i =3D 0; i < mrrm_mem_entry_num; i++) {

Yes, i should be declared in the preamble.

> +       for (i =3D 0; i < mrrm_mem_entry_num; i++) {
>                 name =3D kasprintf(GFP_KERNEL, "range%d", i);
>                 if (!name) {
>                         ret =3D -ENOMEM;
> -                       break;
> +                       goto cleanup;
>                 }
>
>                 kobj =3D kobject_create_and_add(name, pkobj);
> +               kfree(name);

OK, this fixes a memory leak.

> +               if (!kobj) {
> +                       ret =3D -ENOMEM;
> +                       goto cleanup;

Why terminate this?  Why not continue?

> +               }
>
>                 ret =3D sysfs_create_groups(kobj, memory_range_groups);
> -               if (ret)
> -                       return ret;

Well, this returns already, but I'm not sure why.  Tony, wouldn't it
be better to continue?

> +               if (ret) {
> +                       kobject_put(kobj);
> +                       goto cleanup;

I would do a "continue" instead.

> +               }
>         }
>
> +       return 0;
> +
> +cleanup:
> +       for (int j =3D 0; j < i; j++) {
> +               char cleanup_name[32];
> +               struct kobject *cleanup_kobj;
> +
> +               snprintf(cleanup_name, sizeof(cleanup_name), "range%d", j=
);
> +               cleanup_kobj =3D kobject_get(pkobj);
> +               if (cleanup_kobj) {
> +                       sysfs_remove_groups(cleanup_kobj, memory_range_gr=
oups);
> +                       kobject_put(cleanup_kobj);
> +               }
> +       }
> +       kobject_put(pkobj);
>         return ret;
>  }
>
> --

