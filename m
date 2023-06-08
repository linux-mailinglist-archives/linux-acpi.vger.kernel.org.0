Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3972782A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jun 2023 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjFHHHY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jun 2023 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjFHHHX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2023 03:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CE269A
        for <linux-acpi@vger.kernel.org>; Thu,  8 Jun 2023 00:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5960661FD1
        for <linux-acpi@vger.kernel.org>; Thu,  8 Jun 2023 07:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EECC433EF;
        Thu,  8 Jun 2023 07:07:19 +0000 (UTC)
Date:   Thu, 8 Jun 2023 08:07:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, will@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific
 initialisation into acpi_arm_init()
Message-ID: <ZIF+JBcEsgjEzPf4@arm.com>
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
 <ZICQIqdbYJlJkI5E@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICQIqdbYJlJkI5E@lpieralisi>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 07, 2023 at 04:11:46PM +0200, Lorenzo Pieralisi wrote:
> [+Catalin, Will]
> 
> On Tue, Jun 06, 2023 at 10:35:31AM +0100, Sudeep Holla wrote:
> > Move all of the ARM-specific initialization into one function namely
> > acpi_arm_init(), so it is not necessary to modify/update bus.c every
> > time a new piece of it is added.
> > 
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/acpi/arm64/Makefile |  2 +-
> >  drivers/acpi/arm64/agdi.c   |  2 +-
> >  drivers/acpi/arm64/apmt.c   |  2 +-
> >  drivers/acpi/arm64/init.c   | 13 +++++++++++++
> >  drivers/acpi/arm64/init.h   |  6 ++++++
> >  drivers/acpi/arm64/iort.c   |  1 +
> >  drivers/acpi/bus.c          |  7 +------
> >  include/linux/acpi.h        |  6 ++++++
> >  include/linux/acpi_agdi.h   | 13 -------------
> >  include/linux/acpi_apmt.h   | 19 -------------------
> >  include/linux/acpi_iort.h   |  2 --
> >  11 files changed, 30 insertions(+), 43 deletions(-)
> >  create mode 100644 drivers/acpi/arm64/init.c
> >  create mode 100644 drivers/acpi/arm64/init.h
> >  delete mode 100644 include/linux/acpi_agdi.h
> >  delete mode 100644 include/linux/acpi_apmt.h
> 
> Hi Catalin/Will,
> 
> this patch has got all tags required and it is best to send
> arm64 ACPI changes upstream through the arm64 tree for
> consistency, can you pick it up for v6.5 please ?

Happy to pick it up. Thanks Lorenzo.

-- 
Catalin
