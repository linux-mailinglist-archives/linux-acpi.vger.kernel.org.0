Return-Path: <linux-acpi+bounces-9870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2959E00B7
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4C0165219
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092D01FC7EE;
	Mon,  2 Dec 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OgLH+sLN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1C1FA245;
	Mon,  2 Dec 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139330; cv=none; b=k/Ia2yC2+//nMp+phcot/fO/PkzegFN5SK90M5Jp0hnBX+dmMXV6MIZ3RNsJ96obvqiUdsoDhahil3buP9aNIG9Bv9jo+khTuzPRzGBjnTSo0xpmhOFWIj+10cQaDp61cY3QAJ4d7r7IXRx6uFymJKr9wQYcKEmpmrLWyXIQ8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139330; c=relaxed/simple;
	bh=9tNZcpjj1t7vWcFXyssqY/2Oi977Kh2rWYxRFEsh0YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCsY9gKUzcpQ60wCSWbMxDdxQOL5xxpMG5FfEsVUfme6jk6jzLSjE5sEki4tUH8QAHTxaFaSgPW3T4YLlXnJkdTqoJmBhGdIuS3ScPozoEGrgCWkQNu8zl4JzHQnClcYwTa08g3ig2KMhe0WX/+uKnxThViIaCYpC79h2svOYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OgLH+sLN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wF2I4tT7MqbewWmtnwf7ZhQdUn1g7F7H02RXRJD34KA=; b=OgLH+sLN9eaY85gIL0HAmTyE7Z
	05Ait8dHXa/J9L7QzeZ9v1JpmM42U8OjeXXLSiYVFPIP2j7ShKg7SD+jwg2YgJ7d5gW4XELOtU1w4
	fYp1pD5ipdI3tQZqEPzedlWZzf+p21seOKT1q4oEUZgnK5S1Gc88H848vxvsdWTAeLsYWsl4/XqBk
	jMVdUyxWR0qxCNuBxcdh1TLn1A9/hvsATdE2q2bAMGEwWr1z/WSFCGkRxJWissjxsHqmrnjHrW4O4
	cljl36zNa7AoC73ChOkdG+rRWFZas3ZFDUyS+Q0MrN9E3U7o99UO2TJwpaLHTOJ1HcqymByy5GU48
	qFaKl6PQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI4hs-00000007uc1-3AzO;
	Mon, 02 Dec 2024 11:35:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07A4330050D; Mon,  2 Dec 2024 12:35:13 +0100 (CET)
Date: Mon, 2 Dec 2024 12:35:12 +0100
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
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <20241202113512.GA8562@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-5-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140703.557-5-mario.limonciello@amd.com>

On Sat, Nov 30, 2024 at 08:06:55AM -0600, Mario Limonciello wrote:

> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;

This appears unused.

> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_present_cpu(idx) {

This uses present, but does not have means of handling changes to
present. Does this want to be possible?


