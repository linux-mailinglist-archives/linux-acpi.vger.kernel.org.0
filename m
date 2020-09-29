Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AC27D74B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgI2Tvo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 15:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgI2Tvo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2020 15:51:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9EC061755;
        Tue, 29 Sep 2020 12:51:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so3270326pjb.2;
        Tue, 29 Sep 2020 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B2tedPUDtg6ntFKI3C/vWBukV2Pf/aNZvJUFKVIBAvk=;
        b=YWsZggFLDJDw69LGfzr2iyd/yOwwPycGC9wz7mzB45/s1OrzfodhroaaS7iV07mEM0
         kEU74MEVomSocvono+ZOSyckgk/+72FZSJWWsphc29l1VfZPLh2sThJyKmiYm8fOvLPk
         68vvDxmj75i4/6pgf0HmUu2ty1pX7xJuXCaytsOCdatOGy/LLenmUXSTna1gwn1dDNrM
         zzWL8xnFGviczKOGFzS2xKnZrcLHqFy953HXBGofXCWB0s6GoYNKHQXpJ7b3PXn3ErMv
         7mJA+t1wYibgC5gxOYRDRdUfvP45jyNWhP6ZtpZLheSZKhKHPwRa+EI1C/x6vnMnQJfd
         G3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B2tedPUDtg6ntFKI3C/vWBukV2Pf/aNZvJUFKVIBAvk=;
        b=L798ALatGXnf+zg0VXSCmNyX2L7t7OmzgCWqmd3am6ZLnNIWesGbnoV5jXkUgAU/hF
         b3ZrNj3yKsvXDh5rcv6jnVxMcSOndV7kDDfHGMxoJ/AssTdeHs1SHCFAw4sYIf5wAj+W
         nQTWffcYsLPRlwjlQDcSdGlk9GlfFFCWXD1rIQ9QGcRCynxdCF6Y11D8eyB/sdjqBQYj
         /IjrfR1Uo1WOk+uznzYOKfC0fDZ5py9yPzkOu+pIrccF6nEhBhRF3XkAXvItayQhSR2e
         xrKR0mrpLhBhnfHtw6T2DAYSGZ+LY0AXUJh/TBiKgYfxHbQajm2XhsiJeDpUxGlyjSC+
         UHuA==
X-Gm-Message-State: AOAM5326y7TvnOqw80HJo4qU9i5/BxY0zpDKb9xeALKbaPo/vf4P+0XS
        k7tKp4xbEQcZdvnuVmXBu0aYUJo6L4E=
X-Google-Smtp-Source: ABdhPJz/m3sdH3kydcPyoaktgf/jyKIxAqkKkSGDgP3/bF4dYNkigpm3YGdLCoI/ivv/UbW+B1AYZQ==
X-Received: by 2002:a17:90a:5588:: with SMTP id c8mr5188840pji.224.1601409103610;
        Tue, 29 Sep 2020 12:51:43 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id nl10sm4632687pjb.11.2020.09.29.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:51:42 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:51:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: linux-next: Tree for Sep 29 (drivers/acpi/nfit/core.c)
Message-ID: <20200929195141.GA917771@ubuntu-m3-large-x86>
References: <20200929192941.3a93423c@canb.auug.org.au>
 <8b5a54fc-39bc-ae2b-9710-f2493400cdf6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b5a54fc-39bc-ae2b-9710-f2493400cdf6@infradead.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 29, 2020 at 12:47:42PM -0700, Randy Dunlap wrote:
> On 9/29/20 2:29 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200928:
> > 
> 
> on x86_64:
> when CONFIG_ACPI_NUMA is not set/enabled:
> 
> ../drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
>   CC      lib/ts_bm.o
> ../drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of function ‘pxm_to_node’; did you mean ‘xa_to_node’? [-Werror=implicit-function-declaration]
>    ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
>                            ^~~~~~~~~~~
>                            xa_to_node
> 
> Full randconfig file is attached.
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

I independently found this and sent a patch:

https://lore.kernel.org/lkml/20200928194554.3423466-1-natechancellor@gmail.com/

Feel free to reply with a tag if it works for you as well.

Cheers,
Nathan
