Return-Path: <linux-acpi+bounces-2117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A773D8032DE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4834DB209B7
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1824203
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FA4210E7;
	Mon,  4 Dec 2023 03:58:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3BD152B;
	Mon,  4 Dec 2023 03:58:57 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4533F5A1;
	Mon,  4 Dec 2023 03:58:08 -0800 (PST)
Date: Mon, 4 Dec 2023 11:58:06 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Clark <james.clark@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 6/7] coresight: stm: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <ZW2-zuTtV5GxaiFH@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-7-anshuman.khandual@arm.com>
 <0adc3a16-0fc4-2a25-cd48-4667881b9490@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adc3a16-0fc4-2a25-cd48-4667881b9490@arm.com>

On Mon, Dec 04, 2023 at 10:23:49AM +0000, James Clark wrote:
> 
> On 01/12/2023 06:20, Anshuman Khandual wrote:
> > Add support for the stm devices in the platform driver, which can then be
> > used on ACPI based platforms. This change would now allow runtime power
> > management for ACPI based systems. The driver would try to enable the APB
> > clock if available.
> > 
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: coresight@lists.linaro.org
> > Cc: linux-stm32@st-md-mailman.stormreply.com
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> [...]
> >  
> > -module_amba_driver(stm_driver);
> > +static int stm_platform_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	int ret = 0;
> > +
> > +	pm_runtime_get_noresume(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	ret = __stm_probe(&pdev->dev, res, NULL);
> 
> Very minor nit, but this used to print this:
> 
>   coresight stm0: STM500 initialized
> 
> And now it prints this:
> 
>   coresight stm0: (null) initialized
> 
> (null) kind of makes it look a little bit like something has gone wrong.
> Maybe we could just put "initialised" if you don't have a string from ACPI?

Ah right, I too noticed this and forgot to mention. Just add a generic
"STM" string for ACPI if we don't have a way to identify exact IP ?

--
Regards,
Sudeep

