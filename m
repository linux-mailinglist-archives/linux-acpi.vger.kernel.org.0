Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563976FBD3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Aug 2023 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjHDITl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Aug 2023 04:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjHDITk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2023 04:19:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE4E43
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2023 01:19:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68706b39c4cso1288912b3a.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Aug 2023 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691137178; x=1691741978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6p8ZmyjWt9EkIhx2x7mQdHkPI32JR/rPIgt/KaUyrM=;
        b=Xy7UXj5rKhL+uu8tkHk9ALkF9uUbocA2LUGuUDTCT+UGGvvTrismPG1zBkJkoUphar
         GFIBh9B6MWwxSsxdU7gxlE57mN66vXeN52obzKwYx5CxoHQybxqezGy7NIg+855c764S
         XNF/oYMsJJ5Rt/2MYOeT2lTd6jXCIw8p1xhmuAbrL+ZL+sCs0RmmNBE1mk+AOBq6Eq9W
         F4pwgeCm+zv78ejFX6n1IKU186BdKmiIkBCc3ojk6wDZAKKAN2w8IQf6CZtDJd5Pa6Dq
         /f/CXnPRCEHLAkvvcZXchDfjlnHhtZnzkRvEjbeedsy/ciaI5ykfwG3vd5RKwNUEGKzl
         UCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137178; x=1691741978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6p8ZmyjWt9EkIhx2x7mQdHkPI32JR/rPIgt/KaUyrM=;
        b=CsWSyKwH6gY2YoT8IJF9JphOKep4PAFQNOLZQ+giVkAABjguu6C9liLfYe/MzuCHym
         +xRvrudOFhE193O2vFC8JRUXWMoSxn0pIQ/Few5fH0E/4q31OtXHc66s0yyZmVGAoB0M
         buZvBCb1CmqUFhDWLRSmoor/kzlpwO7ET2NV4EY6Fo64jHNQoEPRWYYATdpNFMoQ786O
         PVL703E1hXJ4o1F/007wzxyFhO/ZEMPN2st9gn9J9S4mkp02/+8bNMMqRLu1HQsPrSsM
         V3Hdee5CPxQ6Yk2+nF0mrUUw6IeauQ/inbu/kqOSL4/a9XPiycxQoqa7RytrlHt+8flK
         vABg==
X-Gm-Message-State: AOJu0YwozbVwRSInV5ddgqkgG4rEY0Hpt4AZeLjbEIiXg7T4VjD/A9Y0
        2FB4d12OC6y4qKP/7K0uRS0mTQ==
X-Google-Smtp-Source: AGHT+IFmU2okWiufqxbBgTJlqhXztctK8e0s9XMhsjLRvyxOqapi7NDJcuaofoqHVSzZkHv7M/zO9Q==
X-Received: by 2002:a05:6a20:938a:b0:13e:8ce5:cacd with SMTP id x10-20020a056a20938a00b0013e8ce5cacdmr944703pzh.26.1691137177799;
        Fri, 04 Aug 2023 01:19:37 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b0068620bee456sm1046915pfd.209.2023.08.04.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:19:37 -0700 (PDT)
Date:   Fri, 4 Aug 2023 13:49:24 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [RFC PATCH v1 04/21] RISC-V: ACPI: Enhance acpi_os_ioremap with
 MMIO remapping
Message-ID: <ZMy0jC55N0+nKEye@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-5-sunilvl@ventanamicro.com>
 <ZMyRCRRkTnR/sK0u@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMyRCRRkTnR/sK0u@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 04, 2023 at 08:47:53AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:28:59PM +0530, Sunil V L wrote:
> > Enhance the acpi_os_ioremap() to support opregions in MMIO
> > space. Also, have strict checks using EFI memory map
> > to allow remapping the RAM similar to arm64.
> > 
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> You may use --cc to the command line when forming patches.
> 
> Also we usually consider Cc: as a part of the tag block, meaning no blank line
> should be here.
> 
Thanks!, Andy. I specifically wanted Ard and Alex to look at this patch
and hence added Cc. I was not aware that no blank line should be there.
Thanks for letting me know.

> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> ...
> 
> >  #include <linux/io.h>
> >  #include <linux/pci.h>
> >  #include <linux/efi.h>
> > +#include <linux/memblock.h>
> 
> Can you squeeze it to have some order, like to be after io.h (taking into
> account given context)?
> 
Yeah, sure. Let me update in next version.

> ...
> 
> > +			if (memblock_is_map_memory(phys) ||
> > +			    !memblock_is_region_memory(phys, size)) {
> > +				pr_warn(FW_BUG "requested region covers kernel memory @ %p\n",
> > +					&phys);
> 
> How %p can be useful here (it's mangled), but also wouldn't this give a hint to
> an attacker about the kernel memory location and diminish the KASLR protection?
> (IIRC after boot we always have the same salt for the mangling the pointers when
>  printing, so at least theoretically it might be possible to bruteforce the
>  printing algo to give a clue about the kernel address.)
> 
Okay. This is copied from arm64 version. But I think this is a good
point. Let me just print the warning message without address in the next
version.

Thanks!
Sunil
