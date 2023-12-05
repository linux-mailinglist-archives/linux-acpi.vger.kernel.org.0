Return-Path: <linux-acpi+bounces-2149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD980503F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C4EB20C07
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 10:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877B55791
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 10:35:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD52B186;
	Tue,  5 Dec 2023 01:35:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 139CEC15;
	Tue,  5 Dec 2023 01:35:59 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5E33F6C4;
	Tue,  5 Dec 2023 01:35:10 -0800 (PST)
Date: Tue, 5 Dec 2023 09:35:08 +0000
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
Subject: Re: [PATCH V2 6/7] coresight: stm: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <ZW7uzBS2diyEKldn@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-7-anshuman.khandual@arm.com>
 <0adc3a16-0fc4-2a25-cd48-4667881b9490@arm.com>
 <e53cec31-9452-4c2a-a3a1-b6ef33be8e22@arm.com>
 <7825dcd4-94e1-7a5f-b388-90e748dfc47f@arm.com>
 <81cad3a6-a080-424c-ad0b-0f08c4fe51a2@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81cad3a6-a080-424c-ad0b-0f08c4fe51a2@arm.com>

On Tue, Dec 05, 2023 at 10:50:19AM +0530, Anshuman Khandual wrote:
> Something like this works ?
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 3387ebc9d8ab..2b6834c4cac6 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -906,7 +906,7 @@ static int __stm_probe(struct device *dev, struct resource *res, void *dev_caps)
>         pm_runtime_put(dev);
>  
>         dev_info(&drvdata->csdev->dev, "%s initialized\n",
> -                (char *)dev_caps);
> +                dev_caps ? (char *)dev_caps: "STM");
>         return 0;
>  
>  cs_unregister:

Yes, looks good to me.

-- 
Regards,
Sudeep

