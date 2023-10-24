Return-Path: <linux-acpi+bounces-932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77617D5901
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ED41C20326
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1F3A28E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0VPiT0N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975F29424;
	Tue, 24 Oct 2023 16:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C019C433C7;
	Tue, 24 Oct 2023 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698163353;
	bh=F7gFThJKXxRz67KtPOHXZ1MPyn546aHaKsuQ7HB3hqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0VPiT0NaPFcpVExXTrkeNQPAO04ohPxAd37DPcoJLpOtXMCCjTbSvuBTvMKm6fKL
	 7+97TChy1Rw9XyE2D4xj290syTx4P7Q0qI+cUomEuI1s01Fdc+0+On0HONlKTWh43O
	 JYqW/Fa9n5BmP1kwOrdU1rcoFgbCPjndXNvWvCiA=
Date: Tue, 24 Oct 2023 18:02:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 38/39] cpumask: Add enabled cpumask for present CPUs that
 can be brought online
Message-ID: <2023102411-ascent-plot-04fd@gregkh>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBk-00AqSW-R8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qvJBk-00AqSW-R8@rmk-PC.armlinux.org.uk>

On Tue, Oct 24, 2023 at 04:19:24PM +0100, Russell King wrote:
> From: James Morse <james.morse@arm.com>
> 
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/base/cpu.c      | 10 ++++++++++
>  include/linux/cpumask.h | 25 +++++++++++++++++++++++++
>  kernel/cpu.c            |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 2b9cb2667654..f8bf1d4c7d71 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
>  {
>  	int logical_cpu = cpu->dev.id;
>  
> +	set_cpu_enabled(logical_cpu, false);
>  	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
>  
>  	device_unregister(&cpu->dev);
> @@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
>  }
>  static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
>  
> +static ssize_t print_cpus_enabled(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
> +}
> +static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);

This needs to be documented somewhere in Documentation/ABI/ did I miss
that patch?

thanks,

greg k-h

