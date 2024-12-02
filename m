Return-Path: <linux-acpi+bounces-9871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2729E0187
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF362B2F2E7
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6131FC7D1;
	Mon,  2 Dec 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSk8gECf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA281FC0E8;
	Mon,  2 Dec 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139547; cv=none; b=Ja0zidTVIfdVg1KxZ6Uyj6E/hFOcziZ2P36DLSliKw6s1zkW/d/j4VxDTciPWv1It5emgfnPfuDe0D+qkvFU4xRhewvh5AYEu3CSXnfYUUnvw1NPRGqUWv7i7qjfZOczgj12pWDJuNh7x46iPrG2nwEdDfedcw5puIJPomeHpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139547; c=relaxed/simple;
	bh=MkxBK69WYUMHJR4OsCL7vBo90dufqF2DAt/LeOX9yKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2+nEBt22+0QTcRTfK514EjwqaIJqzEz4gPUOuVcT0085xksqvS/80x7j1tsmo+oabH1dAF43wJTAKw0NXNle9NDoUmp2uRp9FpynuDlvzBc2LudYQj5uq7OaElH/Wjsl/xcblousROExpAypmp7iJ7bSzHrieXCrNlG6JNjvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSk8gECf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xBKU0lZ6XWUzkh5GXz9FM4/iCaLNcAkNoFYzLRwUHkw=; b=lSk8gECfPy8vJB5kAkZkd++G4l
	C6DBtAch1GeEBCsfiGJxOarm8n6RES32JgK3pFtjfVnE9Eo3GLZ/pubYfmt1KMuVAFApp56NEkJ1w
	Rca1ctd7xpVLQL52bcYr2qyFtH/6gvcb2xKtMygRUkhO9arrUyXY4MeDHJc+fsWKdlhtnUsKkVIcg
	Yv9xgNnbljXSeOmVeFJ8vfmDvtuX6FNbwFD89k8emK31uGfX/B/fQ2mbya15tYAoyGAVfklYyMy+7
	q162JpidKM6nUNvYp62IZEA3CP7KRFezxx+p8ONY012UYs9US/LAZheDNfltBWJFvgYkIU6xC2k1K
	v0WObsFw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI4lV-00000007uox-2o2K;
	Mon, 02 Dec 2024 11:38:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8304E3006F1; Mon,  2 Dec 2024 12:38:58 +0100 (CET)
Date: Mon, 2 Dec 2024 12:38:58 +0100
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
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v7 07/12] platform/x86: hfi: add online and offline
 callback support
Message-ID: <20241202113858.GB8562@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-8-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140703.557-8-mario.limonciello@amd.com>

On Sat, Nov 30, 2024 at 08:06:58AM -0600, Mario Limonciello wrote:

> @@ -340,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +				amd_hfi_online, amd_hfi_offline);

By using online notifier, you will already have tasks running on this
CPU before you initialize the HFI bits, is that okay?

