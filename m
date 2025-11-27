Return-Path: <linux-acpi+bounces-19317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810FC8EE14
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E496234B8C0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2C728CF42;
	Thu, 27 Nov 2025 14:51:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C2286416;
	Thu, 27 Nov 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255111; cv=none; b=mZMukEdGkwtIq2pze8gaXBsVvvCEAgSXEwE7WdrO0Eg/WDh5ovwWLS0ZpfWaeV5d4c3eGmUwLLs5IAZEU+kRyJ8ojq72aKMZFSbfvm+koQNnzCpB1CXY52exDQ33dCNptr3/9JJX7iBg/RrQPgKqEcKg5+WKWy1a3lq2AKscjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255111; c=relaxed/simple;
	bh=b2FHpQHRlzrDZkTs2QVC4PwEW0VewoVnzmhGb1Z4+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCPRb7cMDpTwu+mumC+yOvUt2qo0E6homfR2uyoRNyblSnGwvfil2gdBcfIbJouEUm+djqHnfo4nRBLJDh6tG0sKbc/Xhkp41VHQXQGsv8NXmhUFE0Y+sTkvc1pUsWfkLfL1yMiXUXEwS0Bd9vsc3nsgDrsCt+DDgHpKCddzQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9C5D1063;
	Thu, 27 Nov 2025 06:51:40 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384633F66E;
	Thu, 27 Nov 2025 06:51:46 -0800 (PST)
Date: Thu, 27 Nov 2025 14:51:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
Cc: <lkp@intel.com>, <jassisinghbrar@gmail.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: Re: [PATCH v2] mailbox: pcc: support polling mode when there is no
 platform IRQ
Message-ID: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
References: <202511120729.R3XQNSnx-lkp@intel.com>
 <20251119090118.2445303-1-andrea.tomassetti@sipearl.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119090118.2445303-1-andrea.tomassetti@sipearl.com>

On Wed, Nov 19, 2025 at 10:01:18AM +0100, Andrea Tomassetti wrote:
> The goal is to allow clients to submit a message in both irq and polling
> mode of the pcc mailbox. The ACPI specification does not require a
> platform irq for pcc channels. Let's implement the case where it is not
> available.
> 
> peek_data is mapped to pcc_mbox_error_check_and_clear, so that it
> returns true if no error occurred while the platform processed last
> message, and therefore clients can fetch response data provided by the
> platform.
> 
> Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
> Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/
> ---
> v2: Fix issues reported by the kernel test robot
>   - sparse: incorrect type in argument 2 (different address spaces)
>   - acpi_pcc.c:(.text+0x69): undefined reference to `__udivdi3'
> 
>  drivers/acpi/acpi_pcc.c | 78 ++++++++++++++++++++++++++++-------------
>  drivers/mailbox/pcc.c   | 12 ++++++-

Please separate the changes to the PCC OpRegion handler and the PCC mailbox
driver into individual patches. I’ve also done some cleanup work [1], which
has been tested and resolves part of the polling vs. IRQ flag initialization
issue.

I’d appreciate it if you could rebase your changes on top of those updates to
make the review process smoother and help us move forward more quickly.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com/

