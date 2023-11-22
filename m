Return-Path: <linux-acpi+bounces-1738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3C7F4657
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 13:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC09BB2054E
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8714D10B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CE81B9;
	Wed, 22 Nov 2023 03:22:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8CC11595;
	Wed, 22 Nov 2023 03:22:49 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E01E3F7A6;
	Wed, 22 Nov 2023 03:22:01 -0800 (PST)
Date: Wed, 22 Nov 2023 11:21:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, suzuki.poulose@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Message-ID: <ZV3kVhZYBHwSaPr9@bogus>
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
 <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
 <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>

On Wed, Nov 22, 2023 at 12:32:33PM +0530, Anshuman Khandual wrote:
> On 11/15/23 19:23, James Clark wrote:
> > On 27/10/2023 08:29, Anshuman Khandual wrote:
> >> Add support for the tpiu device in the platform driver, which can then be
> >> used on ACPI based platforms. This change would now allow runtime power
> >> management for ACPI based systems. The driver would try to enable the APB
> >> clock if available.
> >>
> > [...]
> >> +#ifdef CONFIG_ACPI
> >> +static const struct acpi_device_id tpiu_acpi_ids[] = {
> >> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
> >> +#endif
> >> +
> >> +static struct platform_driver tpiu_platform_driver = {
> >> +	.probe	= tpiu_platform_probe,
> >> +	.remove	= tpiu_platform_remove,
> >> +	.driver = {
> >> +		.name			= "coresight-tpiu-platform",
> >> +		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
> >> +		.suppress_bind_attrs	= true,
> >> +		.pm			= &tpiu_dev_pm_ops,
> >> +	},
> >> +};
> >> +module_platform_driver(tpiu_platform_driver);
> >> +
> > 
> > Is there a special build config where this works? I get an error here
> 
> I have been testing this with a config known to work on RB5 board.
> 
> > because module_platform_driver() redefines things that are in
> > module_amba_driver() which is defined above:
> > 
> >   module_amba_driver(tpiu_driver);
> > 
> > This isn't a W=1 build or anything, just a normal one. And it applies to
> > most of the patches in this set.
> 
> You are right, I am able to recreate this problem with defconfig on
> 6.7-rc2 as well. The problem here seems to be caused by having both
> module_amba_driver() and module_platform_driver() in the same file.
> 
> #define module_amba_driver(__amba_drv) \
>         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
> 
> #define module_platform_driver(__platform_driver) \
>         module_driver(__platform_driver, platform_driver_register, \
>                         platform_driver_unregister)
> 
> Although, AFAICT, have not seen these before - even on the defconfig.
> Just to work around this problem, there can be a common module_init()
> /module_exit() to register/unregister both AMBA and platform drivers,
> similar to etm4x_init()/etm4x_exit() setup in coresight-etm4x-core.c.

Could this be the reason why I am seeing the below error why booting with
ACPI ? I wanted to check the tables before I comment but this discussion
made me think it could be the reason, hence posting this before I got time
to analyse it.

  |  coresight-tmc-platform ARMHC97C:00: can't request region for resource [mem 0x20010000-0x20010fff]
  |  coresight-tmc-platform: probe of ARMHC97C:00 failed with error -16
  |  coresight-tmc-platform ARMHC501:00: can't request region for resource [mem 0x20070000-0x20070fff]
  |  coresight-tmc-platform: probe of ARMHC501:00 failed with error -16

--
Regards,
Sudeep

