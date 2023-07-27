Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12A076558C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjG0OGT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jul 2023 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OGS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 10:06:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECE1419AF
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 07:06:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97B9D75;
        Thu, 27 Jul 2023 07:07:00 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FAE83F6C4;
        Thu, 27 Jul 2023 07:06:16 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:06:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: Move AMBA bus scan handling into arm64 specific
 directory
Message-ID: <20230727140614.v3zwsurps6x4hm5y@bogus>
References: <20230727133347.648102-1-sudeep.holla@arm.com>
 <CAJZ5v0heD9EG1Wi3ty17gsFJd1K7U1=BOCcPpicbN4L9BEzc5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0heD9EG1Wi3ty17gsFJd1K7U1=BOCcPpicbN4L9BEzc5g@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 27, 2023 at 03:50:20PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 27, 2023 at 3:33 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> > initialisation into acpi_arm_init()") moved all of the ARM-specific
> > initialization into acpi_arm_init(). However, acpi_amba.c being outside
> > of drivers/acpi/arm64 got ignored and hence acpi_amba_init() was not
> > moved into acpi_arm_init().
> >
> > Move the AMBA platform bus support into arm64 specific folder and make
> > acpi_amba_init() part of acpi_arm_init().
> >
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if you want me to take care of this.
>

Since all the change are in drivers/acpi, I prefer you take this.
But for next merge window, the only issue I see is the conflict with
the coresight change that triggered this work. But git should be able
to manage that or I can check with Greg, I am fine either way. Let me
know your opinion/preference.

-- 
Regards,
Sudeep
