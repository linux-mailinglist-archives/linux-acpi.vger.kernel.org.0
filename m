Return-Path: <linux-acpi+bounces-2070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A672C800D38
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 15:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60401281AEB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A523E470
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 14:34:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9283513E;
	Fri,  1 Dec 2023 04:37:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B9A1007;
	Fri,  1 Dec 2023 04:38:05 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C17D3F5A1;
	Fri,  1 Dec 2023 04:37:16 -0800 (PST)
Date: Fri, 1 Dec 2023 12:35:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 1/7] coresight: replicator: Move ACPI support from
 AMBA driver to platform driver
Message-ID: <20231201123515.gntwvhsxd5nzojn7@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201062053.1268492-2-anshuman.khandual@arm.com>

On Fri, Dec 01, 2023 at 11:50:47AM +0530, Anshuman Khandual wrote:
> Add support for the dynamic replicator device in the platform driver, which
> can then be used on ACPI based platforms. This change would now allow
> runtime power management for repliacator devices on ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> replicators.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Except the minor nit below which may apply also for few other patches
in the series

Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only

[...]

> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b6be73034996..64de0bee02ec 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -38,6 +38,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>  struct replicator_drvdata {
>  	void __iomem		*base;
>  	struct clk		*atclk;
> +	struct clk		*pclk;

[minor nit] Perhaps can be documented as well ?

-- 
Regards,
Sudeep

