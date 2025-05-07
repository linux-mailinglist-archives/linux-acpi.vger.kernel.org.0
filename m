Return-Path: <linux-acpi+bounces-13562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08EAADD8D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BB717636F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AB233155;
	Wed,  7 May 2025 11:40:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522921CC45
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618043; cv=none; b=ZuBdGSBsPsaQRT244b8Pl/dVOK5PpLFhiShPLlJckq6ACTgnOEG0LxC1Tt+RO4nS2SWmmdPTcv1E56HZVXpKHbsCvnFYI2E+beyHXdF/E8OuPuKF6syLDSEpKuCWHbC2bS5+7pd2WCq6AmzYjEr6z096sNySJV6gd4xTiMBJheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618043; c=relaxed/simple;
	bh=8cPLxZTU4Y0O/GBkBKneSg8EqbVra4sAvsbX+8aWKCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBDKuXp+br+L2M8H1Wpzg/4ptnv5J/6PqPYuqyYLYeHeVX92yxrR8HTNGhs0rn/J9Zy7elQgO87H+GaUP+yD36DU6T/v7wgeMczNQJnzpRRyBD8p9+rL7qNrv9KR7+EiA92XAmxA3BLg3uuHp7DnfgS7vxDmUe/d+Yw8COnY2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85686339;
	Wed,  7 May 2025 04:40:30 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B263A3F58B;
	Wed,  7 May 2025 04:40:38 -0700 (PDT)
Date: Wed, 7 May 2025 12:40:35 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<jmeurin@google.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing
 processor nodes
Message-ID: <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
References: <20250507035124.28071-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507035124.28071-1-yangyicong@huawei.com>

On Wed, May 07, 2025 at 11:51:24AM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Below error is met on my board and QEMU VM on SMT or non-SMT machine:
>   ACPI PPTT: PPTT table found, but unable to locate core 31 (31)
> 
> This is because the processor node is found by iterating the PPTT
> table under condition (for both acpi_find_processor_node() and
> acpi_pptt_leaf_node()):
>   while (entry + proc_sz < table_end)
>     [parse the processor node]
> 
> If the last processor node is happened to be the last node in the
> PPTT table, above condition will always be false since
> entry + proc_sz == table_end. Thus the last CPU is not parsed.
> Fix the loop condition to resolve the issue.
> 
> This issue is exposed by [1] but the root cause is explained above.
> Before [1] entry + proc_sz is always smaller than table_end.
>

Another thread [1]  with similar patch.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250506-draco-taped-15f475cd@mheyne-amazon

