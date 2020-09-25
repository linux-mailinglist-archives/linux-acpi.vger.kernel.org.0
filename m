Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F6278542
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIYKh4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 06:37:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39352 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYKh4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 06:37:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id c13so2296406oiy.6;
        Fri, 25 Sep 2020 03:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVoxEx1EbqL4xt1KK0Ah1vPumlmjzmQY5kdS/wGJ/Ak=;
        b=MkenEJnFsQfuuo8ueB/4kwNRGlli50BOC3pg7l1wY3sNkx1BVZ2VeMItyCY0bhUm0l
         KbKxREYBx99ipxRd3ntgrX8sjv6VhCHDm/IbDaCnQu3F8JJazcxvMPInEEpo/FEVAdnT
         Mf5tEft5vZ16THLUhHdaJe2lwzloEhMxPFWgMsE082hvp9GHs6Q2MGl0hRWeiXOxxp5y
         kgfoIOWevf8AS75tiiXUUQ29oIUQWJrVzYkSBJO41IgnL85LdUq651ei50i7Y/d+mayj
         7C2ivpALfYiJq8Nhu7e+OhihTPfSgDIdFpCHU7cntZLJYT8O5oTbG5pcVi5CMXPwqVkq
         2JKw==
X-Gm-Message-State: AOAM533kkICMUAiBdi0OG+8vQP4CRsVXVxHGs7Er4D9JJc6UKem71hkk
        /N+OqSiqcB8HLNBmA2awL1B2sqR6xW6bVTQfO/Y=
X-Google-Smtp-Source: ABdhPJzoywEJnt0LASaB7YzzT9iowIuEHe3U2mgnxB4MRDxUJxOkNw085o1XQ1itDrMQHaiSg9OsuF4Qcl3jYm0Fjo8=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr1097334oib.68.1601030275389;
 Fri, 25 Sep 2020 03:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200901064716.2444-1-yuehaibing@huawei.com>
In-Reply-To: <20200901064716.2444-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 12:37:44 +0200
Message-ID: <CAJZ5v0gtKCjPHKdK3bogM=suoU+bVk3RKHGeM-JWESma5dXUQA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: Remove unused inline functions
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 1, 2020 at 8:47 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There is no callers in tree.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied as 5.10 material with a minor edit in the subject, thanks!

> ---
>  include/linux/acpi.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 17e80e182802..dd9b961628eb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -979,8 +979,6 @@ int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
>  #else
> -static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
> -static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
>  static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
> @@ -1218,13 +1216,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
>         return -ENXIO;
>  }
>
> -static inline int acpi_dev_prop_get(const struct acpi_device *adev,
> -                                   const char *propname,
> -                                   void **valptr)
> -{
> -       return -ENXIO;
> -}
> -
>  static inline int acpi_dev_prop_read_single(const struct acpi_device *adev,
>                                             const char *propname,
>                                             enum dev_prop_type proptype,
> --
> 2.17.1
>
>
