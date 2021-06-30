Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1C3B89B0
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhF3U3p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 16:29:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56754 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234208AbhF3U3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Jun 2021 16:29:45 -0400
Received: from zn.tnic (p200300ec2f12c300341904cf3ce6da03.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:3419:4cf:3ce6:da03])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9468B1EC052A;
        Wed, 30 Jun 2021 22:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625084834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=86yXg3hLUA1nTjtkdrF8ezRaEgM4FbW0oMD3BQItYJ4=;
        b=U9QqFhZE8zeta3O6rwSTpio3PZepEPd6hMTZZlMZKI3j5AviK6zI4HnHVp4eBgXlPt2TP7
        yDC5EOErSIrTFJFqMhIFFb3ScTHtjKVpqp2EgD1XJumGLQfoJjgqyYyJM/AHUwOTT6FsxJ
        0PCd12rXShZCeUsZt9LtS4ce6RFn7OU=
Date:   Wed, 30 Jun 2021 22:27:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ACPI updates for v5.14-rc1
Message-ID: <YNzTmmru8JK++Abo@zn.tnic>
References: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
 <YNxLvhBBE7Ff6Q5u@zn.tnic>
 <CAJZ5v0g_+xDVYRiVR4aDFKsNqLg9DeGAMKU1+CPCorpf=Ceb7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_+xDVYRiVR4aDFKsNqLg9DeGAMKU1+CPCorpf=Ceb7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2021 at 07:19:05PM +0200, Rafael J. Wysocki wrote:
> What about the following help text (white space damage by gmail)?
> 
> ---
>  drivers/acpi/Kconfig |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-pm/drivers/acpi/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/acpi/Kconfig
> +++ linux-pm/drivers/acpi/Kconfig
> @@ -548,3 +548,13 @@ config ACPI_PRMT
>      bool "Platform Runtime Mechanism Support"
>      depends on EFI && X86_64
>      default y
> +    help
> +      Platform Runtime Mechanism (PRM) is a firmware interface exposing a
> +      set of binary executables that can be called from the AML interpreter
> +      or directly from device drivers.
> +
> +      Say Y to enable the AML interpreter to execute the PRM code.
> +
> +      While this feature is optional in principle, leaving it out may
> +      substantially increase computational overhead related to the
> +      initialization of some server systems.

Thanks, much better!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
