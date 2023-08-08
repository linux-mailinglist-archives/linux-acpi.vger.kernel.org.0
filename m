Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643AF774161
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjHHRTb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjHHRSq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 13:18:46 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF78C94
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 09:07:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76ad8892d49so501737585a.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Aug 2023 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691510857; x=1692115657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9zS30PvoHblPo8YN82wx1JKihZIxwLEMzYHF89G6sU=;
        b=SESKXX/j4tz5Pox4YUzGZQynpTHzJZfbFvd9mEMXbKEY/YDxmOE+Cua2tQU5nfuPB3
         2CPgeOSFOvubi0N+foVEEbY6du++rCAIN3oQnmIXDmYMwUDtwWT1ovaJydsX8dqvPBjr
         ycLiHobthJjFA+8yUeEapxEPhGhXzpe+VM/1kMmAP7zGkOZIh7C9tRIKgMpD5E9CKHWZ
         x2+iIJ+hoA3z2TafYLPu6qHjGonVcUlC9tyYMYW9AHN5y+mXnOgLsm9yJp79ZvRz04pm
         FmDOxjBhJEI6hHOnnmNJaoXYLRAheOqssxKT2HM6t2bVoLBEYTSWkEIThrgzN+FZxoTJ
         3ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510857; x=1692115657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9zS30PvoHblPo8YN82wx1JKihZIxwLEMzYHF89G6sU=;
        b=E+oKUSkl2FUrBW3j3QoKGHXciydcV2O9LNUmD7abMJX9lr1S5DX93KQ0kFNdQ1S7sm
         s9NYUG34u8Rg+pu2TcHIrB2OwEeOp/JfNS47P8qHLS5Qq2x5XsOnL+Mu3PNrewB3f8Ay
         YhRkttLbXZT6x0ARLl6MIJtEQ8D7GmuelK0sgF2tCh2VxWEcTQjpzVih4Nu7AI+wnf6Y
         N9KNKLPgR2NvYlUC1BYzLGi8he/wdPad55/huz+OIidgrYMqhBVGJy3MU6ElxDNSJwXM
         jSySX8M96iWgtxv9QPvqWGgay8rTEnzCJWuoAI+rJS0wRTdrh+V44wWJHjxxZQN0k1JR
         NWFA==
X-Gm-Message-State: AOJu0YyZm9BRvq8dadQUDsao4044IbIdaBS66jkqyjh+quL934q2hlYl
        L3eprSFlq0oisHaGg9xjhYu9Qu2oYjqMiDFUiDPCHeAS49abck1ZIr8=
X-Google-Smtp-Source: AGHT+IHwj3koprvncE8FX41F8VhQ9ofHcuhvfeQaw4c/xsViq681+NAYgINd4xXSKcG2d8KRUWa6MORkInxl0+tlgIk=
X-Received: by 2002:a17:90a:c583:b0:263:5c6a:1956 with SMTP id
 l3-20020a17090ac58300b002635c6a1956mr9160440pjt.25.1691492249057; Tue, 08 Aug
 2023 03:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-21-sunilvl@ventanamicro.com> <20230808-chalice-easing-1369c7386082@spud>
In-Reply-To: <20230808-chalice-easing-1369c7386082@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 8 Aug 2023 16:27:16 +0530
Message-ID: <CAK9=C2XZ7_tfSK6HNN1Em5fAHrknWBqGaD9gPL8yGs8AzE3vQg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 20/21] RISC-V: ACPI: Create PLIC platform device
To:     Conor Dooley <conor@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 8, 2023 at 2:12=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Aug 03, 2023 at 11:29:15PM +0530, Sunil V L wrote:
> > Since PLIC needs to be a platform device
>
> For the unwashed, why does the PLCI need to be a platform device?
> (And while you're at that, please try to make use of the extra ~20
> characters per line that you can use here.)

As suggested by Marc Z, only timers and IPIs need to be probed early.
Everything else needs to be a platform device. The devlink feature of
Linux DD framework ensures that platform devices are probed in the
right order based on the interdependency.

The PATCH5 of the v7 AIA series converts the PLIC driver into a
platform driver. This works perfectly fine.

>
> > probe the
> > MADT and create platform devices for each PLIC in the
> > system. Use software node framework for the fwnode
> > which allows to create properties and hence the
> > actual irqchip driver doesn't need to do anything
> > different for ACPI vs DT.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>
> > +static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_madt_=
plic *plic)
> > +{
> > +     struct fwnode_handle *fwnode, *parent_fwnode;
> > +     struct riscv_irqchip_list *plic_element;
> > +     struct software_node_ref_args *refs;
> > +     struct property_entry props[8] =3D {};
> > +     int nr_contexts;
> > +
> > +     props[0] =3D PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_base)=
;
> > +     props[1] =3D PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
> > +     props[2] =3D PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_prio)=
;
>
> My OCD wants to know why this gets an _ but the others have a -.
>
> > +     props[3] =3D PROPERTY_ENTRY_U8("riscv,plic-id", plic->id);
> > +     props[4] =3D PROPERTY_ENTRY_U64("riscv,plic-base", plic->base_add=
r);
> > +     props[5] =3D PROPERTY_ENTRY_U32("riscv,plic-size", plic->size);
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
