Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8293376FBDE
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Aug 2023 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHDIXp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Aug 2023 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjHDIXl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2023 04:23:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E0F2D4C
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2023 01:23:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so12846225ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Aug 2023 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691137419; x=1691742219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1iCEOYYU/TuYkpsVb8VVtB172iQ0uWVvB+JeREIxpo=;
        b=mNBCtcy+pGxfsWGwe4DsVuDy0NZiV99ZQ4y9rP1aAfOeel/kt5pokMEdhS81rp7emX
         4q6NJxqkNJzQZR5RnuPibbIx0v6AbybMa3VEwgggL6fAkUhefeZhI2/Gz4Q4xac1Hu6h
         8MjfYa3JyEeMVEGBK5ZP+wO1LM8UPpCmHNXVAQxffB8VxXFoW2uSKKYQk2m9NR7CScok
         jix7R8iUOQ9P18rXExjcm9a74uPR2ME3+6gSWvBwejujKQMYqjSyJTaUsKXd3tTT7Ktp
         Ua49YNuBvi/++1M98fkf1zd8ApIbK50kwdYoWSkV7oJpm/agaVJjM+EgS7/TxqGrsKvq
         deDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137419; x=1691742219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1iCEOYYU/TuYkpsVb8VVtB172iQ0uWVvB+JeREIxpo=;
        b=SDx5kYh3VFaUNehtcG+oi03tzB1RkxL4M/2+gDmJPhclRsE7/jntuCimI8R+fF4oYp
         FUP3Sc6+tKSyv7A7n5+4wNImrdNcZBOfQmTLW0O+mDwY7QuPp7OKpa+7lccXQZOHL3r6
         06ynF4X3TBvfd9GemH8c1wAV+0YdWrkGvoy3tJDtou0R77DG8EvfNke7kIfq778GfRhb
         Y9j6YjXTUbT0w/zie1uKoZvmsHcWopBKuMpCjsDgw+viUbG6aCOVfT12EtlCZmwWDe20
         ixWCQ9aezVnSvhRlL6nBcKt+12ruXzOa5NXGehK1id+I+4le0DgB8Vow57k7RGTn116b
         nHdg==
X-Gm-Message-State: AOJu0Yysa86/1DWiUIDpx6Vy/4z4LLJaEnI8EZ8IikYfgkeV2UawFrs7
        c13ICFXmIyADb0aaB11C4o1PCw==
X-Google-Smtp-Source: AGHT+IErTrIrbgFzVl3JfKafZGO1uGvh7W7gOxEf+8QZhTVoODvh18JAAUR9r8v3VTYouOFQkb7gqw==
X-Received: by 2002:a17:902:e5cb:b0:1bb:5b88:73da with SMTP id u11-20020a170902e5cb00b001bb5b8873damr906032plf.61.1691137419493;
        Fri, 04 Aug 2023 01:23:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b001ac6b926621sm1138810plr.292.2023.08.04.01.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:23:39 -0700 (PDT)
Date:   Fri, 4 Aug 2023 13:53:26 +0530
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
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [RFC PATCH v1 05/21] arm64: PCI: Migrate ACPI related functions
 to pci-acpi.c
Message-ID: <ZMy1fgzCSICftyWz@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-6-sunilvl@ventanamicro.com>
 <ZMySSmy0sNl7Q+rh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMySSmy0sNl7Q+rh@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 04, 2023 at 08:53:14AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:29:00PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, copy these functions
> > to common location.
> 
> ...
> 
> >  }
> > +
> 
> Stray change.
> 
Let me remove this in next version.

> >  arch_initcall(acpi_pci_init);
> > +
> > +#if defined(CONFIG_ARM64)
> 
> ...
> 
> > +	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> > +	if (IS_ERR(cfg)) {
> > +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> > +			PTR_ERR(cfg));
> > +		return NULL;
> > +	}
> > +
> > +	return cfg;
> 
> Can be
> 
> 	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> 	ret = PTR_ERR_OR_ZERO(cfg);
> 	if (ret) {
> 		dev_err(dev, "%04x:%pR error %d mapping ECAM\n", seg, bus_res, ret);
> 
> but as far as I understand this is in the original code like this, so consider
> as a suggestion for further cleanups.
>

Good suggestion!. Sure, we can cleanup as a follow on patch.

Thanks,
Sunil 
