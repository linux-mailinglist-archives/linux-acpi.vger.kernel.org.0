Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBED204279
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFVVPc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 17:15:32 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:57761 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgFVVPc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jun 2020 17:15:32 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2d5b4e65
        for <linux-acpi@vger.kernel.org>;
        Mon, 22 Jun 2020 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=qJEjU6sSA8TwPUhGDGMTJ91dblc=; b=wqjJcp
        HXZ+y1UgqElZcA7MQRjMcFkjd7T/ZqohO46BzCF3H9udmaUy/h32uQXV2zCqP/NV
        CKtJw3a7SqaNMqlK19btgS9BS76JrcILlBjV9b7LrL8s4gdhShTsaWiRtal2fOcI
        TAyY4C/CqNjlHkWeFm8e2BMC4cbySgWKwNBnjfRk9wGd+3OcT+YWb227sRscwqY5
        H2+yBTKAlIW4QgUYWJKOL76HKzAs7/bkGcgjA/a0GeiKoajkSFYp5Cw8qsoc+opE
        xJ2ZCqMepiBLrZ+FnMAJ5tPSs6+ue0H8Tb6V6fYVmaNBW7jg7IC27ntMwb7X9ont
        KQXAKVH0Bw4czi4Q==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ab3b745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-acpi@vger.kernel.org>;
        Mon, 22 Jun 2020 20:56:42 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id y2so3449207ioy.3
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2020 14:15:30 -0700 (PDT)
X-Gm-Message-State: AOAM531BRiUe5SWn81STVIIzY3rLK2diuaJEGjwHfYCudNMpfAu0phN2
        gGDXFcb1YR4WQ/7h0nMxIkwu44vjCr+O7rubeuc=
X-Google-Smtp-Source: ABdhPJw9l4k7FiN3KlgAVAg9pwp3ioQxt5pSftSo2y6SOouQKY3EDhaqEjWZqHhSRlX+x5j18axy9ie87hbyDWXfTPY=
X-Received: by 2002:a05:6602:2fc5:: with SMTP id v5mr19371449iow.79.1592860529463;
 Mon, 22 Jun 2020 14:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200622092719.1380968-1-ardb@kernel.org> <CAHmME9oNwDra2Vi+jsy4YZ81HVygyyRXTJeni58CaJqOmfmepA@mail.gmail.com>
In-Reply-To: <CAHmME9oNwDra2Vi+jsy4YZ81HVygyyRXTJeni58CaJqOmfmepA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 22 Jun 2020 15:15:18 -0600
X-Gmail-Original-Message-ID: <CAHmME9q=dYdf1sn_Kvo5Fu0cUUOGQAMDerb+8g2_-AKhvMukew@mail.gmail.com>
Message-ID: <CAHmME9q=dYdf1sn_Kvo5Fu0cUUOGQAMDerb+8g2_-AKhvMukew@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64/acpi: disallow AML memory opregions to access
 kernel memory
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hmm, actually...

> >         if (memblock_is_map_memory(phys))
> > -               return (void __iomem *)__phys_to_virt(phys);
> > +               return NULL;

It might be prudent to have this check take into account the size of
the region being mapped. I realize ACPI considers it to be undefined
if you cross borders, but I could imagine actual system behavior being
somewhat complicated, and a clever bypass being possible.
Hypothetically: KASLR starts kernel at phys_base+offset, [phys_base,
rounddownpage(offset)) doesn't get mapped, malicious acpi then maps
phys_base+rounddownpage(offset)-1, and then this check doesn't get
hit.
