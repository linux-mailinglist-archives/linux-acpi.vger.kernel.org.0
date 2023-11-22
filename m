Return-Path: <linux-acpi+bounces-1740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2C7F4659
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 13:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A2E1C20754
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C54C606
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D6F1BB;
	Wed, 22 Nov 2023 04:10:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6391595;
	Wed, 22 Nov 2023 04:11:11 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC93E3F7A6;
	Wed, 22 Nov 2023 04:10:22 -0800 (PST)
Date: Wed, 22 Nov 2023 12:10:20 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Message-ID: <ZV3vrE6tCBWupwJM@bogus>
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
 <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
 <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>
 <ZV3kVhZYBHwSaPr9@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3kVhZYBHwSaPr9@bogus>

On Wed, Nov 22, 2023 at 11:21:58AM +0000, Sudeep Holla wrote:
> On Wed, Nov 22, 2023 at 12:32:33PM +0530, Anshuman Khandual wrote:
[..]

> > Although, AFAICT, have not seen these before - even on the defconfig.
> > Just to work around this problem, there can be a common module_init()
> > /module_exit() to register/unregister both AMBA and platform drivers,
> > similar to etm4x_init()/etm4x_exit() setup in coresight-etm4x-core.c.
> 
> Could this be the reason why I am seeing the below error why booting with
> ACPI ? I wanted to check the tables before I comment but this discussion
> made me think it could be the reason, hence posting this before I got time
> to analyse it.
> 
>   |  coresight-tmc-platform ARMHC97C:00: can't request region for resource [mem 0x20010000-0x20010fff]
>   |  coresight-tmc-platform: probe of ARMHC97C:00 failed with error -16
>   |  coresight-tmc-platform ARMHC501:00: can't request region for resource [mem 0x20070000-0x20070fff]
>   |  coresight-tmc-platform: probe of ARMHC501:00 failed with error -16
> 

Scratch that, it didn't help. This error I am seeing is not related to
the issue reported here. I tried a hack below, it didn't help.
 
Regards,
Sudeep

-->8
diff --git i/drivers/hwtracing/coresight/coresight-tpiu.c w/drivers/hwtracing/coresight/coresight-tpiu.c
index ea8827d289ca..f6ba350b3777 100644
--- i/drivers/hwtracing/coresight/coresight-tpiu.c
+++ w/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -254,8 +254,6 @@ static struct amba_driver tpiu_driver = {
        .id_table       = tpiu_ids,
 };

-module_amba_driver(tpiu_driver);
-
 static int tpiu_platform_probe(struct platform_device *pdev)
 {
        struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -297,7 +295,21 @@ static struct platform_driver tpiu_platform_driver = {
                .pm                     = &tpiu_dev_pm_ops,
        },
 };
-module_platform_driver(tpiu_platform_driver);
+
+static int __init tpiu_init(void)
+{
+       amba_driver_register(&tpiu_driver);
+       platform_driver_register(&tpiu_platform_driver);
+       return 0;
+}
+
+static void __exit tpiu_exit(void)
+{
+       amba_driver_unregister(&tpiu_driver);
+       platform_driver_unregister(&tpiu_platform_driver);
+}
+module_init(tpiu_init);
+module_exit(tpiu_exit);

 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");


