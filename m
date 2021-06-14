Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8814B3A69F3
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFNPWn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:22:43 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39450 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhFNPWm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:22:42 -0400
Received: by mail-oi1-f178.google.com with SMTP id m137so14755205oig.6;
        Mon, 14 Jun 2021 08:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbBfsd6QEJyPQsk1CFsyqjVRFq1U4IMEejVMTtFMNhw=;
        b=Mr8g5S0U4PyApU8CUmzu9GiKe2D9uks/omGEQQvYc9pdGyDGFN6odg8ohEJQJNexXk
         NFCVmr0E4tLfmqb0DhJN535AXcE2qgfpZQo/oJXuW6ndR6HSASZ3HWMgZVv0yQ/5gJHa
         CJ7DJZGX5dPPLLjskwZEMd5bo4uEWwe9X0l0l3tfseNwwJu678gXFYFWBb7SuZNBf85i
         bs48otkvrabsrPUnneStE+2D9R/zZUMmPOB0Um6yFkFi9rrd5gWklIz1dOMfBJidMyzb
         zffwwF5SvZitTH2AU0UBsb4ep/aouNPzWYR0NscwkGpdjk9r+wj+cwqFugY2jcCwFrE2
         TX6A==
X-Gm-Message-State: AOAM531d4QMUOuIqulqPrka8hVRJ8xSONWiChlIglyGEJMw2yre1R0TQ
        N2AM70vA6rBPkVqgz82WNX1Jy03MoDuoT2EPNMo=
X-Google-Smtp-Source: ABdhPJxo1NPLcjNmblnmCOGnKctiYGjLLtuut1juPQ/9q+mVa97ENZvUcN6GtP/HnlSjlrGRK3NgsaPhFfIxPSBMDNA=
X-Received: by 2002:aca:b406:: with SMTP id d6mr10830977oif.71.1623684039411;
 Mon, 14 Jun 2021 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:20:28 +0200
Message-ID: <CAJZ5v0gjjS=f5jmA4+SL=K2D1073y3oa5J1yaeFqwkC9tUv2yQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] ACPI: processor_throttling: Remove redundant
 initialization of 'obj'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 11:40 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> 'obj' is being initialized, however this value is never read as
> 'obj' is assigned an updated value later. Remove the redundant
> initialization.
>
> Clean up clang warning:
> drivers/acpi/processor_throttling.c:409:20: warning: Value stored to
> 'obj' during its initialization is never read
> [clang-analyzer-deadcode.DeadStores]
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/acpi/processor_throttling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index 0086afe..017fd02 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -406,7 +406,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
>         acpi_status status = 0;
>         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>         union acpi_object *ptc = NULL;
> -       union acpi_object obj = { 0 };
> +       union acpi_object obj;
>         struct acpi_processor_throttling *throttling;
>
>         status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
> --

Applied as 5.14 material, thanks!
