Return-Path: <linux-acpi+bounces-9873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035E9E00DB
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E8D280638
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128E1FCFE3;
	Mon,  2 Dec 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ssxj7YIm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB31F9AA3;
	Mon,  2 Dec 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139925; cv=none; b=AnDfwho6IMM4nYXATlX+R490LibCMNZ11Vdz6G/3p7Ev2vhOR1S7Q22cEYCMw2Mxoaobzdx4VmANP5sCN7iAMbTEX0fFz6Yq5DrkFsqJj19vSNm+7zKoOSJ8I3XRunAg6+CYbnBznBjIirB0h6T94B+yJOIgQXn28m9USp0HDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139925; c=relaxed/simple;
	bh=N+sClg3ilSLnEtoUkH25HtnlbLoe1AkL59NyPFckCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxLZqFxO0YbCtFz2tRE3t2EiNKE9L/qZrzyQ1AvMOc0mw6GjQy7FkclDxyefgDElTV9mRd0YxFA6qeWcKt/BmTrr/xw+xg4H7iB3BvhFHsKiILxD3vRM7jbhc4ZUzRkSmVrOqnPYuczGqYzNBZK0zAd5uYn+GMGCKwDm1TkV9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ssxj7YIm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sMZNZfSNhg0JQ1t8EgkyjvljKSryh5az9Gw54oU2VPY=; b=Ssxj7YImM6kWpuepXpygDSWQGp
	Z9vY56MTiELdqujAQ3MARSNtZRabZvY4ADxoLMXXo7M1beZAjxSRiZBkZzxXxfln4GDvJRLKtBon5
	jkYbrtynnLTklndknWk69hgh45pgEOSooWlVzLNsVFS3VFz6FvbYAopNy7d5/F/AGIMXRgQib2zda
	1F8GuU2BrJtQrxGOihmuo//eg4AePaZRKcJG8vUVI5JPKZRNPYMi4LHZ+/bNqzYOm65JiPUb6Ojo7
	ihZlnJZyzqyktgLhUIHVxP03uC3X+y4XJwXUiCGF3fty3CpDQ6/8Db8x4uJEDG1ojhzvzmr7V+vRG
	a1JbRvKw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI4ra-00000002AI0-25S3;
	Mon, 02 Dec 2024 11:45:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17622300402; Mon,  2 Dec 2024 12:45:14 +0100 (CET)
Date: Mon, 2 Dec 2024 12:45:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v7 01/12] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
Message-ID: <20241202114513.GD8562@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140703.557-2-mario.limonciello@amd.com>

On Sat, Nov 30, 2024 at 08:06:52AM -0600, Mario Limonciello wrote:

> +Thread Classification and Ranking Table Interaction
> +----------------------------------------------------
> +
> +The thread classification is used to select into a ranking table that describes
> +an efficiency and performance ranking for each classification.
> +
> +Threads are classified during runtime into enumerated classes. The classes represent
> +thread performance/power characteristics that may benefit from special scheduling behaviors.
> +The below table depicts an example of thread classification and a preference where a given thread
> +should be scheduled based on its thread class. The real time thread classification is consumed
> +by the operating system and is used to inform the scheduler of where the thread should be placed.
> +
> +Thread Classification Example Table
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 0        | Default        | Performant                    | Highest             |         |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +
> +Thread classification is performed by the hardware each time that the thread is switched out.
> +Threads that don't meet any hardware specified criteria will be classified as "default".

I'm not seeing this part in the patches, am I needing to read more
careful?

