Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918929C78A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763739AbgJ0Sgn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:36:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46691 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763668AbgJ0Sgn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:36:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id x1so2289224oic.13
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2020 11:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWdnhay9ksmoARjhatTo1pVZzo/6EFH15ny3nNorPU8=;
        b=WRaIiwa5hU34xcRKSoRLFsR5DzmNZb++fMFjO9khH605yHl38l1CgBI9bkx1pFN058
         +rzN+kw+ZokkwuCKhpe1KeQC06GD0YFRIQFHtfnXv99vAgy8tRJcuSy5PxGnzw9YUHSq
         CRkuWqGWC7Ky4OXCPgI0/amc2zEEW8mZXEIeC/FYpBHyOvW2bhBivoBVBgR9e1VgCFAD
         WoE/IGwbFCPSNlDMz1RjSBhMzfPRtYzLHcjOksZRZAdUxkS+Lpwf9gDtY0W72zRiNgFX
         UDzEALqn+8e44TSPAMcLIFpq+0s/7cHxD/58pBElpwR3PK99V60T1n3Q0tdjIQbYyV0V
         D98g==
X-Gm-Message-State: AOAM532qdQrLLhsGLbEJqNms/KsFXS/ZYFwCkHzXR9m/tIG6+GE9wtu6
        NL1VEbuIwDePGAxnvkPGzCL6Y+cU+Rzu65FuX9Q=
X-Google-Smtp-Source: ABdhPJxMshyIWwUFtCfpHhd0rCICdS32Siqi1C1V11Yq4I6sSvbYKxzM8LKTPfweSPljLTEYrlA5UEbMvMd0aFCpA48=
X-Received: by 2002:aca:4c86:: with SMTP id z128mr2484538oia.71.1603823801932;
 Tue, 27 Oct 2020 11:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134901.65045-1-zhangqilong3@huawei.com>
In-Reply-To: <20201027134901.65045-1-zhangqilong3@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:36:30 +0100
Message-ID: <CAJZ5v0iNTV5p3UF+wXL8bTpb0C+hV4iQ1XiM_p_R+C=c6dKcYw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 27, 2020 at 2:38 PM Zhang Qilong <zhangqilong3@huawei.com> wrote:
>
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
> --

Applied as 5.10-rc material with a subject edit, thanks!
