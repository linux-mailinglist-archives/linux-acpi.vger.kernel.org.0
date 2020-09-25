Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FD278570
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIYK4h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 06:56:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46361 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYK4h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 06:56:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id u126so2302988oif.13
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 03:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYf6g0WKDng/oYAsjthkdyDlXSojOCXHD37klSbL6XA=;
        b=EunZO+rTXv5IERpoEW00EKohz0mUfOB3QCXvaQDcFjU/EbTHGfMHGaj58iwsD7LiqJ
         LnmkJC5FvFMlmxTdsZhuudB6EMmPWQmz/u9audp1GZs2JOkkR7K70FKoB+aHGSnQy6wq
         lX19qmS0165J6D/jCd685kr5rJGiHOoOlngfl3Z6CD/leCCQreDUYoRmpeBkzTtgVI7+
         leCUlA+HM/La8TORRP9Hg10Otg7io+KI5TV6zcKmr6y01CsGceBcNd/+QVGPGrsCwz4K
         bEM7SLYTO12ONpknZnaTFgQfNB7npkpMow47LrJxZ/sKAzpXdqjmeZrX/PK5w0IQ0C90
         7MUg==
X-Gm-Message-State: AOAM531bQct4N0SEWUy6NTfjp7hH3uxrxn8Qg+YV0BDbDvnHgFwLBzcG
        5DirUA5r8Ub/KEA8y3zKj3f93YbWrk2hu2+6DolCLXz9
X-Google-Smtp-Source: ABdhPJyTbY0GVRjidy8Qu8N5aroKYGgD/lEh6Iuq5hjhq3XI1hCYMzUSo30oXDPdFJZgDnlGvRg8D2kbQIj3W7RHZ7g=
X-Received: by 2002:aca:df84:: with SMTP id w126mr1208317oig.103.1601031396299;
 Fri, 25 Sep 2020 03:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200912033851.143311-1-yanaijie@huawei.com>
In-Reply-To: <20200912033851.143311-1-yanaijie@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 12:56:25 +0200
Message-ID: <CAJZ5v0h=6xC-n=DGk76AKBrQK4f3j3dxoTFQRN_KZZ9RRZLMYQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI: make apei_resources_all static
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 12, 2020 at 5:39 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> This eliminates the following sparse warning:
>
> drivers/acpi/apei/apei-base.c:290:23: warning: symbol
> 'apei_resources_all' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/acpi/apei/apei-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index e358d0046494..d3fbac58d91a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -287,7 +287,7 @@ struct apei_res {
>  };
>
>  /* Collect all resources requested, to avoid conflict */
> -struct apei_resources apei_resources_all = {
> +static struct apei_resources apei_resources_all = {
>         .iomem = LIST_HEAD_INIT(apei_resources_all.iomem),
>         .ioport = LIST_HEAD_INIT(apei_resources_all.ioport),
>  };
> --

Applied as 5.10 material with the Boris' R-by, thanks!
