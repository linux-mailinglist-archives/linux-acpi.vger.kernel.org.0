Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA087674D6
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGLSA3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 14:00:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGLSA3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2019 14:00:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so10782952wre.12;
        Fri, 12 Jul 2019 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSLflZiZITnN+LWl1xVscHlJHNXtKI7cPwZYoo7JveE=;
        b=WGLyidCEeOzK+/lZEInF9f5d4dS2hTMttPJ3PdxHiqizfszjheSaWM5sarrGicoCQx
         S/JEbVsLwK6DjB6bxOyVsH+FopUgT9zP5JW9r+h/t8ONPcjpFIfkp2y4tFAelWjunYso
         bVc4vokhkEQIB7T6HnfRGCi17kFI1Zh2qosBccXw17acpzm07srUVnQyrUILeMm0jmEf
         KUKac6MPFCJTV2KmyYDYLvXFV3YCNTGHCmpu0yR1LxSIMxr4OAKJPrGtuFnyHJ9Wrrdq
         hBTLD7o1YI99Ig6bAy4/GKhdUn4qEeawrRCYDek7I+MQp5JkpVUl5wWeuBM5tn63KaWa
         cQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSLflZiZITnN+LWl1xVscHlJHNXtKI7cPwZYoo7JveE=;
        b=p/IvhcYeEiniMgcq261fMTuJbrxKvnul473JzqBrrcXG+dywAnQtBFHOZsNJtHBsH1
         oAbD9+O6dc+QGGPQ77S1ZLflq4KnEPqPwXaeba3qLkTUKIa9r9TMQJFOi6I96vBQ6b9S
         LxeLvs966Sqdvn4JEf9kUTvwpM6ZVs9ZuEbwyH1sRMW2C8Np54OdZSP7ZqWxIzl5GoyJ
         5+ZR2q1whKbGZc++VUzxPRs7KOrSa+MZORrMmMrRXb1butuGCj4iGzctv+2HyLlgOIIz
         hzv3Vfr98DXcothvq+jA6LoLxRF2v3ylroznjDEkkilwOB5Jewg9HlivRU5JYt3stB0r
         ufzQ==
X-Gm-Message-State: APjAAAUrWSUjrCCGMtjEzgmpg+XoQoKf0vLqXkCfguydxejhpzv0sJYH
        YJO+HOj1j2BgM4KmL/TyDN4=
X-Google-Smtp-Source: APXvYqyYSBDpfiNbvOCc3Tq1Cngt99gUJ9KSnwXK1+CWFQ2tu4DN5ubh8tUfH2eiItrpYFlFhWsBxA==
X-Received: by 2002:adf:f591:: with SMTP id f17mr3250076wro.119.1562954426638;
        Fri, 12 Jul 2019 11:00:26 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a6sm6755054wmj.15.2019.07.12.11.00.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:00:26 -0700 (PDT)
Date:   Fri, 12 Jul 2019 11:00:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <keith.busch@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] acpi: fix false-positive -Wuninitialized warning
Message-ID: <20190712180024.GA21382@archlinux-threadripper>
References: <20190712090148.36582-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712090148.36582-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 12, 2019 at 11:01:21AM +0200, Arnd Bergmann wrote:
> clang gets confused by an uninitialized variable in what looks
> to it like a never executed code path:
> 
> arch/x86/kernel/acpi/boot.c:618:13: error: variable 'polarity' is uninitialized when used here [-Werror,-Wuninitialized]
>         polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>                    ^~~~~~~~
> arch/x86/kernel/acpi/boot.c:606:32: note: initialize the variable 'polarity' to silence this warning
>         int rc, irq, trigger, polarity;
>                                       ^
>                                        = 0
> arch/x86/kernel/acpi/boot.c:617:12: error: variable 'trigger' is uninitialized when used here [-Werror,-Wuninitialized]
>         trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                   ^~~~~~~
> arch/x86/kernel/acpi/boot.c:606:22: note: initialize the variable 'trigger' to silence this warning
>         int rc, irq, trigger, polarity;
>                             ^
>                              = 0
> 
> This is unfortunately a design decision in clang and won't be fixed.
> 
> Changing the acpi_get_override_irq() macro to an inline function
> reliably avoids the issue.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
