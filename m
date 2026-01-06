Return-Path: <linux-acpi+bounces-19981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A6CF949C
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 17:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02E6300421A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD08217723;
	Tue,  6 Jan 2026 16:07:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83914F9D6;
	Tue,  6 Jan 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715658; cv=none; b=bkSQINnvZxN0KU2TGwTgS9s0bxk/DEVYPtY8SJrU3RpHAIjuGUmUYmlbUff/3P+Y8sk0sqNL1KDyJvG5pYz21ALw8qSpF/nUgTiv3tS4+Bd1VhSFUsqZVznTmo1vr7+FdjEgy8U4nOBYNBhLPbpjQdqIDRZdbs8TL6I9klXGS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715658; c=relaxed/simple;
	bh=WTpzdeiFNVXvAzFsbvaPBt369RX2EnQG6/AfwdTdeNw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAhIV6YaTcxXNBLaCvWlQRPcllKf2uUZY5rwgKJLXj6yRhpCh4zrxF9Z9as5+dD58tM2ROxyOLOq2aUUPeO+Aj/wZJ985cLpa4KIt6Fqixo0hTXw/gEhOcbj4D6MaNP02NSjOAGJlZOhbcP5/9DIiUqNoLrMAuxSG57SMY3WU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwzh16K8zHnHGP;
	Wed,  7 Jan 2026 00:07:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9718940565;
	Wed,  7 Jan 2026 00:07:32 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 16:07:31 +0000
Date: Tue, 6 Jan 2026 16:07:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
	<robert.moore@intel.com>, Ankit Agrawal <ankita@nvidia.com>, "Borislav
 Petkov" <bp@alien8.de>, Breno Leitao <leitao@debian.org>, Hanjun Guo
	<guohanjun@huawei.com>, Jason Tian <jason@os.amperecomputing.com>, "Len
 Brown" <lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
	<acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] apei/ghes: ensure that won't go past CPER
 allocated record
Message-ID: <20260106160727.00005ee2@huawei.com>
In-Reply-To: <8731f124c82a48850648695530a5442d60034de1.1767693532.git.mchehab+huawei@kernel.org>
References: <cover.1767693532.git.mchehab+huawei@kernel.org>
	<8731f124c82a48850648695530a5442d60034de1.1767693532.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  6 Jan 2026 11:01:37 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The logic at ghes_new() prevents allocating too large records, by
> checking if they're bigger than GHES_ESTATUS_MAX_SIZE (currently, 64KB).
> Yet, the allocation is done with the actual number of pages from the
> CPER bios table location, which can be smaller.
> 
> Yet, a bad firmware could send data with a different size, which might
> be bigger than the allocated memory, causing an OOPS:
> 
> [13095.899926] Unable to handle kernel paging request at virtual address fff00000f9b40000
> [13095.899961] Mem abort info:
> [13095.900017]   ESR = 0x0000000096000007
> [13095.900088]   EC = 0x25: DABT (current EL), IL = 32 bits
> [13095.900156]   SET = 0, FnV = 0
> [13095.900181]   EA = 0, S1PTW = 0
> [13095.900211]   FSC = 0x07: level 3 translation fault
> [13095.900255] Data abort info:
> [13095.900421]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [13095.900486]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [13095.900525]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [13095.900713] swapper pgtable: 4k pages, 52-bit VAs, pgdp=000000008ba16000
> [13095.900752] [fff00000f9b40000] pgd=180000013ffff403, p4d=180000013fffe403, pud=180000013f85b403, pmd=180000013f68d403, pte=0000000000000000
> [13095.901312] Internal error: Oops: 0000000096000007 [#1]  SMP
> [13095.901659] Modules linked in:
> [13095.902201] CPU: 0 UID: 0 PID: 303 Comm: kworker/0:1 Not tainted 6.19.0-rc1-00002-gda407d200220 #34 PREEMPT
> [13095.902461] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> [13095.902719] Workqueue: kacpi_notify acpi_os_execute_deferred
> [13095.903778] pstate: 214020c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [13095.903892] pc : hex_dump_to_buffer+0x30c/0x4a0
> [13095.904146] lr : hex_dump_to_buffer+0x328/0x4a0
> [13095.904204] sp : ffff800080e13880
> [13095.904291] x29: ffff800080e13880 x28: ffffac9aba86f6a8 x27: 0000000000000083
> [13095.904704] x26: fff00000f9b3fffc x25: 0000000000000004 x24: 0000000000000004
> [13095.905335] x23: ffff800080e13905 x22: 0000000000000010 x21: 0000000000000083
> [13095.905483] x20: 0000000000000001 x19: 0000000000000008 x18: 0000000000000010
> [13095.905617] x17: 0000000000000001 x16: 00000007c7f20fec x15: 0000000000000020
> [13095.905850] x14: 0000000000000008 x13: 0000000000081020 x12: 0000000000000008
> [13095.906175] x11: ffff800080e13905 x10: ffff800080e13988 x9 : 0000000000000000
> [13095.906733] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000020
> [13095.907197] x5 : 0000000000000030 x4 : 00000000fffffffe x3 : 0000000000000000
> [13095.907623] x2 : ffffac9aba78c1c8 x1 : ffffac9aba76d0a8 x0 : 0000000000000008
> [13095.908284] Call trace:
> [13095.908866]  hex_dump_to_buffer+0x30c/0x4a0 (P)
> [13095.909135]  print_hex_dump+0xac/0x170
> [13095.909179]  cper_estatus_print_section+0x90c/0x968
> [13095.909336]  cper_estatus_print+0xf0/0x158
> [13095.909348]  __ghes_print_estatus+0xa0/0x148
> [13095.909656]  ghes_proc+0x1bc/0x220
> [13095.909883]  ghes_notify_hed+0x5c/0xb8
> [13095.909957]  notifier_call_chain+0x78/0x148
> [13095.910180]  blocking_notifier_call_chain+0x4c/0x80
> [13095.910246]  acpi_hed_notify+0x28/0x40
> [13095.910558]  acpi_ev_notify_dispatch+0x50/0x80
> [13095.910576]  acpi_os_execute_deferred+0x24/0x48
> [13095.911161]  process_one_work+0x15c/0x3b0
> [13095.911326]  worker_thread+0x2d0/0x400
> [13095.911775]  kthread+0x148/0x228
> [13095.912082]  ret_from_fork+0x10/0x20
> [13095.912687] Code: 6b14033f 540001ad a94707e2 f100029f (b8747b44)
> [13095.914085] ---[ end trace 0000000000000000 ]---
> 
> Prevent that by taking the actual allocated are into account when
> checking for CPER length.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

A naming comment inline.   The bikeshed must be blue!

Might have been better to +CC these to linux-edac like earlier
ones. If nothing else that wouldn't have broken my filtering and
I'd have gotten patch 4 (didn't as don't subscribe to efi or lkml
lists). FWIW patch 4 looks fine to me.

> ---
>  drivers/acpi/apei/ghes.c | 6 +++++-
>  include/acpi/ghes.h      | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fc3f8aed99d5..350f666b7783 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -29,6 +29,7 @@
>  #include <linux/cper.h>
>  #include <linux/cleanup.h>
>  #include <linux/platform_device.h>
> +#include <linux/minmax.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
>  #include <linux/vmalloc.h>
> @@ -294,6 +295,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
>  		error_block_length = GHES_ESTATUS_MAX_SIZE;
>  	}
>  	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
> +	ghes->error_block_length = error_block_length;
Maybe it would be clearer to call it after what we care about which
is the length of estatus.  So
	ghes->estatus_length 
or something like that.  The reason I raise this is it feels a bit random
stashed in the ghes struct and there is no documentation to say what it
is the length of wrt to other elements of that structure.

>  	if (!ghes->estatus) {
>  		rc = -ENOMEM;
>  		goto err_unmap_status_addr;
> @@ -365,13 +367,15 @@ static int __ghes_check_estatus(struct ghes *ghes,
>  				struct acpi_hest_generic_status *estatus)
>  {
>  	u32 len = cper_estatus_len(estatus);
> +	u32 max_len = min(ghes->generic->error_block_length,
> +			  ghes->error_block_length);
>  
>  	if (len < sizeof(*estatus)) {
>  		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
>  		return -EIO;
>  	}
>  
> -	if (len > ghes->generic->error_block_length) {
> +	if (!len || len > max_len) {
>  		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
>  		return -EIO;
>  	}
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index ebd21b05fe6e..5866f50bac0c 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -27,6 +27,7 @@ struct ghes {
>  		struct timer_list timer;
>  		unsigned int irq;
>  	};
> +	unsigned int error_block_length;
Would it cause a big hole if this moved up near estatus?
If not I would be tempted to do that given it's effectively the length of that.

>  	struct device *dev;
>  	struct list_head elist;
>  };


