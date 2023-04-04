Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1C6D58FA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjDDGyn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjDDGym (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 02:54:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C12695
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 23:54:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so32957222pjl.4
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2023 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680591280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8KDVnrh1hTXgmg9cUX613HBU/NpNhOGn+tvPjKzddU=;
        b=mXZSLWXYtv4n06LIlK6QFnQlklY/sKxaWTQU/vvO7qcfsgXLGGlGcwuCO19fKY6qQy
         efdh/b+0BcOjkIB2FxAoBZJ+N4ssU99ayNpww5SqKt7jOFgp5lClD7Ls81ZUiB3b5/Io
         s1QdUxXGmLS90t3QGktGbGlny60/DldtJ2R9m5GEfPJdo5b1RtLvsnDMEuI+bmuta/qW
         NjubZGOwRTbD/l4rfxV/adLRRcaGNHhIFZOKtewu25VMxkayhdNFMa32IxzRQ+d3k7AQ
         6lI26mcYjTEuZBZnichASEWZZ4Riyn9b6mh0dOzRN51KiyLfvoPGA0q3sr5Jlq2YiUrt
         oC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8KDVnrh1hTXgmg9cUX613HBU/NpNhOGn+tvPjKzddU=;
        b=EljI52SKayaZH8MxmQKnjpUR7nlQ2Qnf3h4KPMbF8XAu1uaUkEcZ5WaN5TcqONpurZ
         4MjMXRTrHjZa9YCMc9bRqawFsWA7kXo13yzE6FyC+GS85MfNiKOWGS17vkxXGWGgEhXj
         PwYyP5fcRMoRN0y3uYqsJtYi/aF8ebX25qHEK2gOrZOYVZAd9z6Qinq/5R3fahOjGhsF
         LM0uwQLYHefEj3avl4N18umj7GQiOfNE2zIbwH83QiFhqTprf9JwNKozkOEfDffc21j1
         29p46qhaRO2RLqFEzmVQpGzbPZBSBj+c5iVPgcbv7C02OM/IJv99lapJ5BRlzOFOji+g
         E3uQ==
X-Gm-Message-State: AAQBX9eDNHUv+FD+mcwoQcheQqDfCvja+j0AkPc3iQkBRjDd42gE5D1J
        vXhFZ/9SdserQzg163cpX8PUPFGyfiOP8X1rU9s=
X-Google-Smtp-Source: AKy350YUeMS566kGavT5Mb5UZSOA1ZJfQBdGmEvc/mlk3U8V7ucrzM0EIRt/rKThA++zZN9GdXImaQ==
X-Received: by 2002:a17:902:e494:b0:1a2:952b:27e0 with SMTP id i20-20020a170902e49400b001a2952b27e0mr1572818ple.8.1680591280254;
        Mon, 03 Apr 2023 23:54:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b0019f0ef910f7sm7626350pll.123.2023.04.03.23.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 23:54:39 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:24:30 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ley Foon Tan <lftan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>, llvm@lists.linux.dev
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
Message-ID: <ZCvJpnNZYzrIcfPe@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud>
 <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org>
 <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop>
 <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 04, 2023 at 02:35:19PM +0800, Ley Foon Tan wrote:
> On Wed, Mar 8, 2023 at 9:08 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 06:44:35PM +0000, Conor Dooley wrote:
> > > On Tue, Mar 07, 2023 at 06:13:22AM +0000, Conor Dooley wrote:
> > > >
> > > >
> > > > On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
> > > > >> Hey Sunil,
> > > > >>
> > > > >> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> > > > >> > This patch series enables the basic ACPI infrastructure for RISC-V.
> > > > >> > Supporting external interrupt controllers is in progress and hence it is
> > > > >> > tested using poll based HVC SBI console and RAM disk.
> > > > >> >
> > > > >> > The first patch in this series is one of the patch from Jisheng's
> > > > >> > series [1] which is not merged yet. This patch is required to support
> > > > >> > ACPI since efi_init() which gets called before sbi_init() can enable
> > > > >> > static branches and hits a panic.
> > > > >> >
> > > > >> > Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
> > > > >> > but a PR is raised already.
> > > > >> >
> > > > >> > Below are two ECRs approved by ASWG.
> > > > >> > RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
> > > > >> > RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
> > > > >> >
> > > > >> > The series depends on Anup's IPI improvement series [2].
> > > > >> >
> > > > >> > [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
> > > > >> > [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@ventanamicro.com/T/
> > > > >>
> > > > >> Building a clang-15 allmodconfig (I didn't try gcc) with this series, and
> > > > >> Anup's IPI bits, results in a broken build, due to failings in cmpxchg:
> > > > >>
> > > > >> /stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error: call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BUG failed
> > > > >>         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> > > > >>                                ^
> > >
> > > > > I am able to build without any of these issues using clang-15. I am
> > > > > wondering whether the base is proper. I had rebased on top of the master
> > > > > and couple of patches from IPI series were already merged in the master.
> > > > >
> > > > > Do you mind verifying with my branch
> > > > > https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3?
> > > >
> > > > I can check that later I suppose.
> > >
> > > That's broken too.
> > >
> > > > > Or if you could provide me your branch details, I can look further.
> > > >
> > > > 6.3-rc1, with both series applied, sans Anups applied patches.
> > >
> > > I've pushed my stuff here, but unlikely that it makes any odds since
> > > your branch experiences the same build issue.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ borked-acpi-surface
> > >
> > > My build commands are wrapped in a script, but it's an LLVM=1
> > > allmodconfig run w/ clang-15(.0.7) etc.
> > >
> > Ahh allmodconfig. Thank you very much!. I can reproduce the failure. Let
> > me look further and fix in next revision.
> >
> > Thanks!
> > Sunil
> 
> Hi Sunil
> 
> One question regarding PMU in ACPI flow.
> 
> We use DT to decode the supported HPM counters/events for the
> different platforms now.
> How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI method?
> Note, this might be in separate patch series.
> 
Hi Lay Foon,

This driver uses SBI calls and hence should work in case of ACPI also.

There is one minor change required in this driver for overflow
interrupt. I have a patch for that in future series.

Thanks,
Sunil
