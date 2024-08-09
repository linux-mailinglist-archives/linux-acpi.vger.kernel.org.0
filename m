Return-Path: <linux-acpi+bounces-7455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A829794CB26
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5331F23838
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95BF170A02;
	Fri,  9 Aug 2024 07:22:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F217BA2
	for <linux-acpi@vger.kernel.org>; Fri,  9 Aug 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188122; cv=none; b=oJ8Fl5z4yARwK/00AwjDscd15DLofpdtQ0Fa1zK14h1JD5wIjHP5H7G9gEIj4By4SEybfZrdZaDVhtB8hPTHqkWLpxW2IUcpMyIpSuuP+JZ2N8WqswXBLjhQqOlxF/AaFrILGu9P4wOGc3BLwIFPZMTry/9SP0IK+95lQafSw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188122; c=relaxed/simple;
	bh=rMaA2cTSJVvxnDnK0pd4mj9V8JeVk92jFDeA0UZik6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPMdiJeD1bvulepjV99ldT2fBYzwywqcjYDi9FwHW//UfvovQCUVr6ZCg2SwW2COC9l11qHUGWfA8OVgu/9C+8jYXmSgbxVE9BFYMyzUOmfcgLfOpCNIUq4oSTlokUfWu8A+VTYUR9Wt5blHQMk5vT6pHzKugMM0Zwvksu/8fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE1CFEC;
	Fri,  9 Aug 2024 00:22:23 -0700 (PDT)
Received: from bogus (unknown [10.57.81.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 816F93F766;
	Fri,  9 Aug 2024 00:21:56 -0700 (PDT)
Date: Fri, 9 Aug 2024 08:21:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM64: ACPI: Move the NUMA code to
 drivers/acpi/arm64/
Message-ID: <20240809072153.5uoci2kfqvr7qfmr@bogus>
References: <20240808131522.1032431-1-guohanjun@huawei.com>
 <20240808131522.1032431-4-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808131522.1032431-4-guohanjun@huawei.com>

On Thu, Aug 08, 2024 at 09:15:22PM +0800, Hanjun Guo wrote:
> The ARM64 ACPI NUMA code can be moved out of arm64 arch code
> as it just related to ACPI NUMA table parsing, mappings for
> ACPI NUMA and cpu, move the ACPI NUMA code to drivers/acpi/arm64/.
> 
> Since arm64 selects ACPI_NUMA by default, so just move the function
> definitions under CONFIG_ARM64 in linux/acpi.h.

I was about to ask to take a look at riscv implementation to avoid any
issues with this move, kbuild has already reported a build failure.

--
Regards,
Sudeep

