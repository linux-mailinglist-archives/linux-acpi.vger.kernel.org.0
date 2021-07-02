Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE343BA1D4
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhGBOD2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 10:03:28 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46942 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhGBOD2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 10:03:28 -0400
Received: by mail-ot1-f49.google.com with SMTP id c12-20020a9d684c0000b029047762db628aso6124276oto.13;
        Fri, 02 Jul 2021 07:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP6Fzy8VQM5Rg2GQo10Vq+JQKpT72W1fweff72vBeB4=;
        b=VpD/DWwVdpk8M1nc5l8VvGfLMdDtjGvH6YsSELUYUY2zq28fI9/g2AUqPW2knnRBa2
         x0nDYJzlJFnuOxPFr1LG4xmHHNb/zVtK+8lrEAXZH9Ac3+Yxyrkigj/gZiWtwe0cJGNi
         fwmNR02A/PNya2lcn7/vJ8AkwUzljWlTNStA5/6bVP9dCvFphfQmu9tKw/TVsn5Bvzhi
         PB5egxGL3FZ1svNq4uOT85qNxzo7FqSkUfEjx1kEuZWLy5GuytMtqp8br3q8QBf/MI3N
         jFAr//MfnJMQb9BNZxThhKiU4kuZWVjdKQDWiTPA/kNEAOBGT++aa8AQlpyiXbIiIAc/
         9kyQ==
X-Gm-Message-State: AOAM5305rcRhZPRtDVB3u0GvFEOXdZkuPk12RBDLDVhazQQUjA67+Zz5
        fBqmawZV7mmi9On4R+ITIhh9QPSZYcL7aB6dTSI=
X-Google-Smtp-Source: ABdhPJzJ9FCgxXnqTiAl1d8719KNqcBH150mVsIr6nLkuiTcshiGPmrhmCV69QZ3c0A6UVjuKdMcyh28UHwe875eJUg=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr1814275otj.260.1625234454582;
 Fri, 02 Jul 2021 07:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 16:00:43 +0200
Message-ID: <CAJZ5v0hzhCAnD8KtRkq7BpBQPXOJ3X=hCvR+=usZ=tr9SpxW4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: Correct \_SB._OSC bit definition for PRM
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 9:03 AM Aubrey Li <aubrey.li@intel.com> wrote:
>
> Accord to Platform Runtime Mechanism Specification v1.0 [1],
> Page 42, _OSC bit (BIT 21) is used to indicate OS support of
> platform runtime mechanism..
>
> [1]: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b338613..4df6a81 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -551,8 +551,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_OSLPI_SUPPORT                   0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT                0x00001000
>  #define OSC_SB_GENERIC_INITIATOR_SUPPORT       0x00002000
> -#define OSC_SB_PRM_SUPPORT                     0x00020000
>  #define OSC_SB_NATIVE_USB4_SUPPORT             0x00040000
> +#define OSC_SB_PRM_SUPPORT                     0x00200000
>
>  extern bool osc_sb_apei_support_acked;
>  extern bool osc_pc_lpi_support_confirmed;
> --

Applied as 5.14-rc1 material, thanks!
