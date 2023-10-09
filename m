Return-Path: <linux-acpi+bounces-541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6337BE336
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D534281079
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFE3419B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFD14F7A
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 13:05:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15A6A94
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 06:05:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679F71FB;
	Mon,  9 Oct 2023 06:06:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7A3A3F762;
	Mon,  9 Oct 2023 06:05:47 -0700 (PDT)
Date: Mon, 9 Oct 2023 14:05:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>,
	D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific
 initialisation into acpi_arm_init()
Message-ID: <20231009130545.kpebuas3optwt2ks@bogus>
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
 <867cnzqojo.fsf@scott-ph-mail.amperecomputing.com>
 <00dd9623-a131-53ed-5e73-1eccd626d2d7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dd9623-a131-53ed-5e73-1eccd626d2d7@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 08:29:49PM +0800, Hanjun Guo wrote:
> On 2023/10/7 8:11, D Scott Phillips wrote:
> > Sudeep Holla <sudeep.holla@arm.com> writes:
> > 
> > > Move all of the ARM-specific initialization into one function namely
> > > acpi_arm_init(), so it is not necessary to modify/update bus.c every
> > > time a new piece of it is added.
> > > 
> > > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > > Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > > Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >   drivers/acpi/arm64/Makefile |  2 +-
> > >   drivers/acpi/arm64/agdi.c   |  2 +-
> > >   drivers/acpi/arm64/apmt.c   |  2 +-
> > >   drivers/acpi/arm64/init.c   | 13 +++++++++++++
> > >   drivers/acpi/arm64/init.h   |  6 ++++++
> > >   drivers/acpi/arm64/iort.c   |  1 +
> > >   drivers/acpi/bus.c          |  7 +------
> > >   include/linux/acpi.h        |  6 ++++++
> > >   include/linux/acpi_agdi.h   | 13 -------------
> > >   include/linux/acpi_apmt.h   | 19 -------------------
> > >   include/linux/acpi_iort.h   |  2 --
> > >   11 files changed, 30 insertions(+), 43 deletions(-)
> > >   create mode 100644 drivers/acpi/arm64/init.c
> > >   create mode 100644 drivers/acpi/arm64/init.h
> > >   delete mode 100644 include/linux/acpi_agdi.h
> > >   delete mode 100644 include/linux/acpi_apmt.h

[...]

> > > @@ -1408,7 +1405,7 @@ static int __init acpi_init(void)
> > >   	acpi_init_ffh();
> > > 
> > >   	pci_mmcfg_late_init();
> > > -	acpi_iort_init();
> > > +	acpi_arm_init();
> > >   	acpi_viot_early_init();
> > >   	acpi_hest_init();
> > >   	acpi_ghes_init();
> > > @@ -1420,8 +1417,6 @@ static int __init acpi_init(void)
> > >   	acpi_debugger_init();
> > >   	acpi_setup_sb_notify_handler();
> > >   	acpi_viot_init();
> > > -	acpi_agdi_init();
> > > -	acpi_apmt_init();
> > 
> > Hi Sudeep, this moves acpi_agdi_init() before acpi_ghes_init().
> > sdei initialization currently happens from ghes_init, so agdi devices
> > using SDEI can no longer probe:
> > 
> > | [    0.515864] sdei: Failed to create event 1073741825: -5
> > | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
> > | [    0.515867] agdi: probe of agdi.0 failed with error -5
> > | ...
> > | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.
>

Sorry for that.

> How about just move acpi_arm_init() to the place of after
> acpi_ghes_init()?
>

Yes that could work but  I am not comfortable with such play around with
the ordering. I don't have better alternative as well :( so I am OK with
the proposal.

We had all sorts of issues with initcalls in the past but I understand
this one is not as bad as that, I am just cautious.

> I checked the functions in acpi_arm_init(), there are no other
> dependencies except sdei_init().
>

Fair enough.

Anyways, for now Hanjun's suggestion should work.

Can either one of you write a patch and post ? Or you use want me to do
that ?

--
Regards,
Sudeep

