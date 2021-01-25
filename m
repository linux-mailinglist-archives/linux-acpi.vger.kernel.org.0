Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA6302820
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbhAYQmb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 11:42:31 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42587 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbhAYQl4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 11:41:56 -0500
Received: by mail-ot1-f42.google.com with SMTP id f6so13324833ots.9;
        Mon, 25 Jan 2021 08:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPQEdHw8hmrHmwDn5ao/wteg7hwzILpj2TMQxof7Unc=;
        b=NT1Ja0pQiT70jVzfy1kvDWcxVrtXppnyywosLF7WSpdXxcCYZ37b2SXl2L4NP6yuw4
         XP0dn3vkjRyRylaQyRb0JQdxg1kDvIktJRKQm2F3gahPKzGi0LLKGLjSy7RMKMPLkAug
         rrrhNSQeFrpgf9A6xD8WBDAklXwA9lIpdo89vUqMNpTbzucyaLq5BmUZoy697qIBaaMP
         5+na0tr9p8foE0hgZ5hmJXQ5+NKiIcJUouu/M2d01xbZumJ8i4NdWRu0ZVIdJr3IwIGW
         d8iAxCX0/h6mUi3559sMmM71aCZp1oI49BWALXyvBry64soDpHEmoG4U/hDpqDz7AfzO
         ccXw==
X-Gm-Message-State: AOAM5316n+SBsM85a82BByKNmGOPsZCD9zQDKWoFrz03aOcz6FPDQN0m
        skfTLR5UxcoCQ1IvtqdBMG4EDZEPCo9ZAq+a0dM=
X-Google-Smtp-Source: ABdhPJxtGTUP8SkxRtLQOtsxRsiN88BmCuQswuTVjTlUXO8yndjrPHLe0LpNZoxh25TB8ll7LDnZc1vmFUvNZRq6c7Y=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr1073511otm.206.1611592875761;
 Mon, 25 Jan 2021 08:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20210122180322.1720413-1-terry.bowman@amd.com>
In-Reply-To: <20210122180322.1720413-1-terry.bowman@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 17:41:04 +0100
Message-ID: <CAJZ5v0hoMe=XbwD-oRGiRxAia94JB1CfBiqEXGwan+pN5_pzqw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / APEI: Add is_ghes_type() to identify GHES sources
To:     Terry Bowman <terry.bowman@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon.grimm@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 7:05 PM Terry Bowman <terry.bowman@amd.com> wrote:
>
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Refactor duplicated GHES identity logic into is_ghes_type().
>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

If Terry was a co-author of the patch, please add a Co-developed-by:
tag for him in addition to the s-o-b.  Otherwise the meaning of his
s-o-b is unclear.

Boris, James, any objections to the changes below?

> ---
>  drivers/acpi/apei/hest.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6e980fe16772..bd702e0ef339 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>         [ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
>  };
>
> +static inline bool is_ghes_type(struct acpi_hest_header *hest_hdr)
> +{
> +       return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> +              hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> +}
> +
>  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  {
>         u16 hest_type = hest_hdr->type;
> @@ -141,8 +147,7 @@ static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void
>  {
>         int *count = data;
>
> -       if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> -           hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +       if (is_ghes_type(hest_hdr))
>                 (*count)++;
>         return 0;
>  }
> @@ -153,8 +158,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
>         struct ghes_arr *ghes_arr = data;
>         int rc, i;
>
> -       if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> -           hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +       if (!is_ghes_type(hest_hdr))
>                 return 0;
>
>         if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
> --
> 2.27.0
>
