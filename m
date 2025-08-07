Return-Path: <linux-acpi+bounces-15563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE3B1D9AB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F8417F4EB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20485262FE9;
	Thu,  7 Aug 2025 14:08:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C81F4625;
	Thu,  7 Aug 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575724; cv=none; b=ISOeX71JPB5gVh35g+VFH5aR4U0NefqOVb/YcbegcLjjtYswDcp58XmhldxzAncNfDZB0xVPg/0wx3Ry667b9aDkmXnaaDv8Lg1K3HP3fsGLrP6BqDGn/V7XSWKdrLtOqBP7EasJLujnSOsFhR83mldsyhDTRpZwjJSn+QPpx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575724; c=relaxed/simple;
	bh=JOMXt7Dp00eXlXvY7ODv3ajXGYgyfV5NqudHZFP99tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRD9M4UBDJ1FHBkGrijKHKHe3XMdGi0HPZVaJVlXjIX/QpNfH61G7+MCJH/I6kvtA9fZENB/oU/VaRkQwX8rHBtFY9DvMKNCJF7+ChBw5j9GzOVa+ngBXXVBCmD7t2bWZgIC4J392C2LPrbPniW3jukuZ29do39ji1QG/b7dhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624CD1756;
	Thu,  7 Aug 2025 07:08:31 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3A373F738;
	Thu,  7 Aug 2025 07:08:37 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:08:35 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Zhen Ni <zhen.ni@easystack.cn>, <Markus.Elfring@web.de>,
	<jassisinghbrar@gmail.com>, <linux-acpi@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <stable@vger.kernel.org>,
	"Linux-Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
Message-ID: <20250807-rampant-otter-of-persistence-b4436d@sudeepholla>
References: <20250804121453.75525-1-zhen.ni@easystack.cn>
 <20250805034829.168187-1-zhen.ni@easystack.cn>
 <88a0618f-121f-4752-ad65-e9724403cc16@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a0618f-121f-4752-ad65-e9724403cc16@amd.com>

On Thu, Aug 07, 2025 at 07:10:35PM +0530, Aithal, Srikanth wrote:
> Hello,
> 
> This commit, now part of next-20250807[1], is causing kernel boot crash on
> AMD EPYC Milan platform.
> 
> commit c3f772c384c8ec0796a73c80f89a31ff862c1295 (HEAD)
> Author: Zhen Ni <zhen.ni@easystack.cn>
> Date:   Tue Aug 5 11:48:29 2025 +0800
> 
>     mailbox: pcc: Add missed acpi_put_table() to fix memory leak
> 
>     Fixes a permanent ACPI memory leak in the success path by adding
>     acpi_put_table().
>     Renaming generic 'err' label to 'put_table' for clarity.
> 
>     Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into
> pcc_mbox_probe")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
>     Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> 
> 
> Attaching both the dmesg and kernel config here.
> 
> If I go back 1 commit [i.e 75f1fbc9fd409a0c232dc78871ee7df186da9d57], things
> work fine.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20250807
> 
>

Thanks for the report. I analysed the report and concluded that we can't
drop the reference to the table unless we may a copy of some GAS registers
as we access them at runtime.

Zhen,

Sorry, I must withdraw my Reviewed-by.

-- 
Regards,
Sudeep

