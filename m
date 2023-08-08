Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B5773CCA
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjHHQJu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHHQHy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 12:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048976A4;
        Tue,  8 Aug 2023 08:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 356A762557;
        Tue,  8 Aug 2023 13:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE47C433C8;
        Tue,  8 Aug 2023 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691500645;
        bh=bIdTKs+XJSSYo9nmEk8w4qlYxgAKUeHbpejGGCNfpP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=McPNo2lfEjaEdqKynfZ1K+aBmcZ4YYIeVte/2s2vh5nLPjsV4zK8sJIVfpxCc7crr
         sDBGoRIO5LJCHaR77v68/J53DyRLx71gtm3zc1q1VOESQqBciSKl4OeFOBQVSPMd0S
         +tBpc5vokh/WWYwp0KB/adwLXL4vh9T5H99097FN3ekyEWjRbxQlUhwtyYf+fLzfY+
         NItyKZlA8+itKJ2p2ERAxkbIINwuG4v63bcdxovstp+yn724if/OpATk3O8McX4G8m
         CB3X6UnRJxGyxAaSluC5CbBaGo5curysvokB2eW3Z97rh38FOsSdo5qHmeplImgc93
         W5ZpsOrULl9RA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qTMaR-0038Tj-Bu;
        Tue, 08 Aug 2023 14:17:23 +0100
Date:   Tue, 08 Aug 2023 14:17:22 +0100
Message-ID: <865y5phdwd.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [RFC PATCH v1 11/21] swnode: Add support to create early during boot
In-Reply-To: <ZMyymUdV63g4eGaT@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
        <20230803175916.3174453-12-sunilvl@ventanamicro.com>
        <ZMyWDDD6Lw8REd1r@smile.fi.intel.com>
        <ZMyymUdV63g4eGaT@sunil-laptop>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: sunilvl@ventanamicro.com, andriy.shevchenko@linux.intel.com, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, lenb@kernel.org, djrscally@gmail.com, heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, daniel.lezcano@linaro.org, tglx@linutronix.de, anup@brainfault.org, bhelgaas@google.com, robert.moore@intel.com, haibo1.xu@intel.com, ajones@ventanamicro.com, conor.dooley@microchip.com, atishp@rivosinc.com, apatel@ventanamicro.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 04 Aug 2023 09:11:05 +0100,
Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> Hi Andy,
> 
> On Fri, Aug 04, 2023 at 09:09:16AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 03, 2023 at 11:29:06PM +0530, Sunil V L wrote:
> > > From: Anup Patel <apatel@ventanamicro.com>
> > > 
> > > swnode framework can be used to create fwnode for interrupt
> > > controllers.
> > 
> > Why? What is this for?
> > Can you elaborate? This commit message is poorly written...
> > 
> > And why firmware node is not enough for ACPI case?
> > I assume the fwnode in DT case is already provided by OF.
> > 
> Thanks a lot for the review!.
> 
> You are right, OF provides the fwnode for irqchip drivers. However, for
> ACPI case, it is typically created using irq_domain_alloc_named_fwnode
> or irq_domain_alloc_fwnode since these are not ACPI devices in the
> namespace but from MADT. The fwnode created using
> irq_domain_alloc_fwnode() is a simple one which doesn't support properties
> similar to the one created by OF framework or software node framework.
> Hence, lot of data from the MADT structures need to be cached as
> separate structures in the drivers and also would need several ifdefs to
> check for ACPI and some amount of code duplication is also required due
> to the way DT driver gets the information vs ACPI.
> 
> The beauty of software node framework is, it supports adding properties
> and also is a supported fwnode type in __irq_domain_create().

There is no beauty here. Only some extra bloat that we do not need.

DT and ACPI exposes very different attributes. One describe the HW,
the other one describe an OS abstraction. Pretending that you can
summon both into the same infrastructure is a fallacy. You'll just end
up with the cross product of both infrastructure, and pollute the rest
of the kernel with pointless cruft.

> So, if we
> can create the fwnode for these irqchip using software node, we can
> attach the same properties and the actual irqchip driver which uses the
> fwnode doesn't need to have any ACPI vs DT checks. Same driver will work
> seamlessly on both DT and ACPI platforms.  But the challenge is,
> currently swnode expects to be created with sysfs which won't be
> available during early boot when irqchip drivers need to be probed. So,
> adding support to create without dependency on sysfs help us to reuse
> the same framework for irqchip use case also.

That's another fallacy.

Most irqchips *DO NOT* need to be probed early. Only the root
irqchip. Given that this series is about *secondary* interrupt
controllers, they absolutely don't need to be probed early.

To be clear: I do not intend to merge anything that:

- invents yet another way to "abstract" firmware interfaces

- adds more "early probe" hacks for non-primary interrupt controllers

I have already said that in response to Anup's AIA series, and this
equally applies to this series.

	M.

-- 
Without deviation from the norm, progress is not possible.
