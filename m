Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D941830B963
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 09:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhBBIPn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 03:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhBBIPR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 03:15:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C20C061573
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 00:14:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c127so1431597wmf.5
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V9OYiORsRMdWxR7osHjENqg1fnGThuRA0XqX/4BX+1c=;
        b=hEjTSeELyWKPp0CnG3NhEUXGWqHKYf4FGwe42X4txoQqMYdN/l4GEsSWhpryg4cdr2
         mLsbhB3My1be7fS3MUpSzG86Cu25HOLVj4xBtJwoJxvToTcO80tPG9WprKlOFXmaYj2V
         DxgK0KjdyjKXHoASZ1QOLIHkyyRXhuX5iJeGoPV+mIf6XDHXOfkIeb0+QlXC7S35rj9Z
         As/d/yiCIxOt7ghX7xJK2eTO0hQeWt0mIuQB641+PEgDtDz4qwLyvty+BQx/fO4DR9v0
         LrIl8FFsdMFqrIO0l5JW53vwNphVfmVzAdhsBSbcy52Au6eT+JO097BcO+k2yS64KV3P
         AZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V9OYiORsRMdWxR7osHjENqg1fnGThuRA0XqX/4BX+1c=;
        b=K64hItgvI5Eqd2uGv8lRPgPPiDUOtXBUTEhTZ8Vf8/ZdNak11YXQO34VgQzNrXI9Kh
         RcFVPKPSQww5Rv9VeokvZ4bKFyjuXGzU8pEFiCoPPOg4IrKB4ZPeBOSaheY7xRSyVJE2
         +cGERrWH8pMaYi5Liho3/TAl54ljMVuTq4xzHaNU4Ibo9GkJfzM65kIyKwftmFA2gr5q
         kSa9j+a6/ce05cMgK6kV2oo8Qc5BCwnNevj3Tnw5c65yTlFWYgPjlXa7NBGAnFmDw4TH
         7Dd67GI/4exI6aWwe1xxf+ZgYmEWMyOhdNGpcyMdWoRdy2kJ7+DjiAGIy+Jb1u7drXS9
         42aQ==
X-Gm-Message-State: AOAM5309AqKTr7MEPUZET8iDhyg57pKBTQQEHFN3XiT/kLYr3MY6eTKE
        ZRWQmSJsGu2JIqowOIpvHnTnaA==
X-Google-Smtp-Source: ABdhPJz7x1HW6afm8E3SZwUYCuRD8nwdukBQBuMeDo46SISBs/cF7jfaDGXCswTgBC8EtkPPNPrOJg==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr2376244wmb.62.1612253675132;
        Tue, 02 Feb 2021 00:14:35 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id z8sm31399154wrh.83.2021.02.02.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:14:34 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:14:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 10/10] mfd: intel_msic: Remove driver for deprecated
 platform
Message-ID: <20210202081432.GX4774@dell>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210125193948.56760-11-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125193948.56760-11-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 25 Jan 2021, Andy Shevchenko wrote:

> Intel Moorestown and Medfield are quite old Intel Atom based
> 32-bit platforms, which were in limited use in some Android phones,
> tablets and consumer electronics more than eight years ago.
> 
> There are no bugs or problems ever reported outside from Intel
> for breaking any of that platforms for years. It seems no real
> users exists who run more or less fresh kernel on it. The commit
> 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> with this theory.
> 
> Due to above and to reduce a burden of supporting outdated drivers
> we remove the support of outdated platforms completely.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  MAINTAINERS                                 |   2 -
>  arch/x86/include/asm/intel_scu_ipc_legacy.h |  12 -
>  drivers/mfd/Kconfig                         |   9 -
>  drivers/mfd/Makefile                        |   1 -
>  drivers/mfd/intel_msic.c                    | 425 ------------------
>  include/linux/mfd/intel_msic.h              | 453 --------------------
>  6 files changed, 902 deletions(-)
>  delete mode 100644 drivers/mfd/intel_msic.c
>  delete mode 100644 include/linux/mfd/intel_msic.h

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
