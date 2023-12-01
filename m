Return-Path: <linux-acpi+bounces-2076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DE800D3F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF111C20971
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BF3E470
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 14:35:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB44E1A4;
	Fri,  1 Dec 2023 04:39:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A3E1007;
	Fri,  1 Dec 2023 04:40:03 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F14B53F5A1;
	Fri,  1 Dec 2023 04:39:14 -0800 (PST)
Date: Fri, 1 Dec 2023 12:37:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 7/7] coresight: debug: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <20231201123713.t4yv2unu4vzh5brp@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-8-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201062053.1268492-8-anshuman.khandual@arm.com>

On Fri, Dec 01, 2023 at 11:50:53AM +0530, Anshuman Khandual wrote:
> Add support for the cpu debug devices in a new platform driver, which can
> then be used on ACPI based platforms. This change would now allow runtime
> power management for ACPI based systems. The driver would try to enable
> the APB clock if available.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes

-- 
Regards,
Sudeep

