Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76D29AE5D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbgJ0N7a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 09:59:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40852 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbgJ0N73 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 09:59:29 -0400
Received: by mail-io1-f66.google.com with SMTP id r9so1603685ioo.7
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2020 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQvdV6dqtQ5KmyvpgQ9zrxsf+gQ42UJEg73X+t/RUns=;
        b=V2nPzQCQtpkA9wOxgf/mwbKpmzwcQgn85DuZQ9ksWuP5pAEB7y5C+cmobCh0JiAzWf
         ubeMixFZLY/L7OZ/oEXZAQ4CQ0Ja0WN/LRcDOap/i4briyPp2X+2jvDHLU0LKclgolkO
         dkGWd7Hh5a8dUOm56Lk1qRWuvivXeQNpzUkEaynNto7LBWtREMu9BmqT1V1RdcmpkSD1
         Jz724SdaGncbonb7V4fpkd9et8n9a8+PhAbo50ZcdaxcZLwnc0zoeUTP3Nzph/ft3ESO
         jUaPz0agSckDO6joUhngkr+WApUOe3s5LdZCSKAApGue19P9uTYaGY1HVHiZY0cid+b9
         pXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQvdV6dqtQ5KmyvpgQ9zrxsf+gQ42UJEg73X+t/RUns=;
        b=sMoQa+7u7bgnZShHqEmBLGTm2oFwzG31OYgdfmyau6YqTxL97ARZjdI22OIdtVwv3c
         Wq3QNOf9AmwbPnCa5VKjhRfdaJNnxf9F2HZKQGrB2p2YdrhFt5WRLMHvL7t9By+eEVAP
         mWUwx784/t7NUgIqqwMFqaTwhuydTWR5AdCY97cmqEX7KzfFprWPLnfQPfuaKb7iWMQY
         ts5tloOvLQQCiD7z0cjXIa4kdXYQJ7q8DJ5lMZQtv+/LU56jWcrvH4c2ZEuP/coxXgRa
         hfOyPYD7DFQHjbCXGWS7P2wep7zeMeUkn4i5kbDyQ0cZKAmQv8bu1bvUoOxz6o/hgv3h
         xSLg==
X-Gm-Message-State: AOAM533Mysxi6RTHypi3RROalFXvtzsJ8XejyOyjvVekiOhTKdBEOquU
        wOps4dcZyci0rxeStUfzCsvL/IPqW5F2agm9JDo=
X-Google-Smtp-Source: ABdhPJxXit5ThAbX46aMmTtpkKVQCxA0v43tUImtevHEb32GiSq/9K4/FohM0td4C5lyMX97BjWbsA2p8eg7N6v8eK4=
X-Received: by 2002:a5d:87c7:: with SMTP id q7mr2170461ios.162.1603807168629;
 Tue, 27 Oct 2020 06:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134901.65045-1-zhangqilong3@huawei.com>
In-Reply-To: <20201027134901.65045-1-zhangqilong3@huawei.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 27 Oct 2020 14:59:17 +0100
Message-ID: <CAM9Jb+i5ZYCVktvbmdupbM5w8J27oTEFejKL5La1sOV4iWouEA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Initial value of rc is '-ENXIO', and we should
> use the initial value to check it.
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 756227837b3b..3a3c209ed3d3 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
>                                         le16_to_cpu(nfit_dcr->dcr->code));
>                         break;
>                 }
> -               if (rc != ENXIO)
> +               if (rc != -ENXIO)
>                         break;
>         }
>         mutex_unlock(&acpi_desc->init_mutex);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
