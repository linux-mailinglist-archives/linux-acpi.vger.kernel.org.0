Return-Path: <linux-acpi+bounces-2115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFB8032DC
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 13:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EAA280F0E
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37AE241F5
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2395BD2;
	Mon,  4 Dec 2023 03:40:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE49152B;
	Mon,  4 Dec 2023 03:41:35 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DCBA3F6C4;
	Mon,  4 Dec 2023 03:40:46 -0800 (PST)
Date: Mon, 4 Dec 2023 11:40:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Clark <james.clark@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 5/7] coresight: tmc: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <ZW26u_2pHz9bNoTx@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-6-anshuman.khandual@arm.com>
 <fe5c82d1-8b7d-6701-4e19-9019f23d9c7b@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5c82d1-8b7d-6701-4e19-9019f23d9c7b@arm.com>

On Mon, Dec 04, 2023 at 10:54:15AM +0000, James Clark wrote:
>
>
> On 01/12/2023 06:20, Anshuman Khandual wrote:
> > Add support for the tmc devices in the platform driver, which can then be
> > used on ACPI based platforms. This change would now allow runtime power
> > management for ACPI based systems. The driver would try to enable the APB
> > clock if available.
> >
> [...]
> > -module_amba_driver(tmc_driver);
> > +static int tmc_platform_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	struct tmc_drvdata *drvdata;
> > +	int ret = 0;
> > +
> > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
> > +	if (IS_ERR(drvdata->pclk))
> > +		return -ENODEV;
> > +
> > +	dev_set_drvdata(&pdev->dev, drvdata);
> > +	pm_runtime_get_noresume(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	ret = __tmc_probe(&pdev->dev, res, NULL);
> > +	if (ret) {
> > +		pm_runtime_put_noidle(&pdev->dev);
> > +		pm_runtime_disable(&pdev->dev);
> > +	}
>
> I'm not sure if these pm_runtime()s are right because there is already a
> put inside of __tmc_probe() if it fails. If you unload and then reload
> all the coresight modules with these patches you get these errors which
> are new:
>

Ah good find. I have just tested with ACPI and these modules as built-in
to be more specific.

--
Regards,
Sudeep

