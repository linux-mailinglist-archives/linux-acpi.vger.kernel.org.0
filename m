Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFFD116A6F
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLIKBy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 05:01:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38568 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfLIKBy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 05:01:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id b8so5795351oiy.5;
        Mon, 09 Dec 2019 02:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FtaHC/0W+/eC6v7DNQkqqYp4JgH05lJ8TyIqrizDhU=;
        b=NXhB4U1v2RcMbAr52Bglnu2G25EYrw/SUnwq0SjKtTGfl5r1fbl8H6mXKCSPHyM4ke
         rg9zfs+5WzN0t2e5g2YIKDQud8cCv8LrHvGyEIyMYDopW5j0V1x9oDkeqg6mD41EtQKJ
         /EUBPzNYeLxUfmKvqQsBFVhRkXn3GkvphX8FOSg0Wb59J+8fi4+Htv1qk0ct/WEdwNX1
         F5a9W6igHgRm01O0psme+kv+0+Q+AXGqGv7N0UubqcjnvBFfH+W6GJZNgStxVem/Td3A
         DFXqJSMtYd7D4e2vX7qNmvAN7LdvwLXduV3W5v0Dt+lgeRdEPEWIuzcze+vHQ2WOVBYX
         yuAQ==
X-Gm-Message-State: APjAAAXdtJTkRnW2CSV/z46k4JBqrSV+smQJUxp6AaGcDM/qGGuWLzbk
        cZovQuGcxpkVoCl5wk/Cl4Is2AJjwpWDXSUt8nY=
X-Google-Smtp-Source: APXvYqx/zqoTfacR4nFj7pWLFpqF9WOA4QsBoywpKgDTlpakrgxkJT6WBi296tGo6aqd8joGAParb+DeUWEQTCDS0lk=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr18479690oij.110.1575885713344;
 Mon, 09 Dec 2019 02:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20191202070348.32148-1-tao3.xu@intel.com>
In-Reply-To: <20191202070348.32148-1-tao3.xu@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 11:01:42 +0100
Message-ID: <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Tao Xu <tao3.xu@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
>
> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> 2 is "Write Through" for Write Policy.

Well, I'm not sure what the connection between the above statement,
which is correct AFAICS, and the changes made by the patch is.

Is that the *_OTHER symbol names are confusing or something deeper?

> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  drivers/acpi/numa/hmat.c | 4 ++--
>  include/linux/node.h     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..719d0279563d 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -383,7 +383,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>                 break;
>         case ACPI_HMAT_CA_NONE:
>         default:
> -               tcache->cache_attrs.indexing = NODE_CACHE_OTHER;
> +               tcache->cache_attrs.indexing = NODE_CACHE_NONE;
>                 break;
>         }
>
> @@ -396,7 +396,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>                 break;
>         case ACPI_HMAT_CP_NONE:
>         default:
> -               tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +               tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_NONE;
>                 break;
>         }
>         list_add_tail(&tcache->node, &target->caches);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 4866f32a02d8..6dbd764d09ce 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -36,15 +36,15 @@ struct node_hmem_attrs {
>  };
>
>  enum cache_indexing {
> +       NODE_CACHE_NONE,
>         NODE_CACHE_DIRECT_MAP,
>         NODE_CACHE_INDEXED,
> -       NODE_CACHE_OTHER,
>  };
>
>  enum cache_write_policy {
> +       NODE_CACHE_WRITE_NONE,
>         NODE_CACHE_WRITE_BACK,
>         NODE_CACHE_WRITE_THROUGH,
> -       NODE_CACHE_WRITE_OTHER,
>  };
>
>  /**
