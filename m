Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85E43D0DE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhJ0Sj5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 14:39:57 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38757 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhJ0Sj4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 14:39:56 -0400
Received: by mail-oi1-f181.google.com with SMTP id t4so4707545oie.5;
        Wed, 27 Oct 2021 11:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVPuTQqP6aEFqO2fyoc1su/oe5Az3LSwCS4uRf5/p08=;
        b=sVhUQg/eXrcpXfdBOGFDK2xbtpeqz9aty74kKqmAkYFRx8B5LPd+MkGOhXG7Gd+tNw
         IEuOKB2KaAWbYJpwEV29VYnoqSFIXTPJziq47l9GE+UnrZneAsMnGiHHCMmw8xc8jpYD
         xialbxW16djho7NNe6umvtwMkQScIdUsSZALdJ0xIZMgbyf2fflbfqsHFGAOXy7PTgUH
         UBJtMd6Tmol65RQGzhowMQCyfIRboeUiwgNtl5lalPgD4AYum0mTAHS38JfLwSVOoHwA
         nCJekGOeXydHQhbBxGAQqFi7TUGURkjk7StCt7jBMdqlmsNptx691zDsz31f6m1cX7Do
         jNXw==
X-Gm-Message-State: AOAM530a03+t8RUZ7KPBJ2QF9m3kiPJ7hSxx+1UHZY5Cqio+Y4TxmIBN
        tFMvK2RgMYSRD086KGWa7YmYAsy3DVgLxsmlmNw=
X-Google-Smtp-Source: ABdhPJzutzJ7/Yj893mdq8no4/lj/5r4vF4oW8JGvIk2VWf04ta96JHBQadGGsCMKVkQFFaoWhZrYdUCMLWXmITeCQE=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr4840138oif.154.1635359850793;
 Wed, 27 Oct 2021 11:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211027065438.1742175-1-hch@lst.de>
In-Reply-To: <20211027065438.1742175-1-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 20:37:20 +0200
Message-ID: <CAJZ5v0jYmrV7bMV0b9wB8L-bX6PU+yCDrK8s+jCJh1x3xCi_Rg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: mark apei_hest_parse
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 8:54 AM Christoph Hellwig <hch@lst.de> wrote:
>
> apei_hest_parse is only used in hest.c, so mark it static.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/acpi/apei/hest.c | 5 +++--
>  include/acpi/apei.h      | 3 ---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 277f00b288d14..0edc1ed476737 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -86,7 +86,9 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>         return len;
>  };
>
> -int apei_hest_parse(apei_hest_func_t func, void *data)
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +
> +static int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>         struct acpi_hest_header *hest_hdr;
>         int i, rc, len;
> @@ -121,7 +123,6 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(apei_hest_parse);
>
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 680f80960c3dc..ece0a8af2bae7 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -37,9 +37,6 @@ void __init acpi_hest_init(void);
>  static inline void acpi_hest_init(void) { return; }
>  #endif
>
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> -int apei_hest_parse(apei_hest_func_t func, void *data);
> -
>  int erst_write(const struct cper_record_header *record);
>  ssize_t erst_get_record_count(void);
>  int erst_get_record_id_begin(int *pos);
> --

Applied as 5.16 material, thanks!
