Return-Path: <linux-acpi+bounces-9061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBC9B3F39
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 01:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B6B220EA
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E748F5E;
	Tue, 29 Oct 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fWOv+Xz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD24A28;
	Tue, 29 Oct 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161980; cv=none; b=alxGSK1M36U0UWEXlpbIcGj0syzWyb1pdQc0IzE8hMsKB+h4Tfc9KTUm/hB64Xqo+397sr6NUl1tOaGASbQ0l9BXgC1JKGPZyPhqCbkeBG1jjr3jKkaKjVCuHjRUZ3FtX+LVWvhTzb8rPvk27fHEsYdsOEkEqi4b9zWRq3Me+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161980; c=relaxed/simple;
	bh=h6uTVq+hv9WhN1djveiVDbjzfvV7PyEB+OO+feAAn98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeNLh9I3t89pukiwjNJcvVAL2lUpSzCQXk/rSaf+A4r+hF7idxPvKH6nqOjKYAdb78jhQlWRxlZoGvFXyo0FU+FK5L4G8QLNfJ6MDdRVQP3kO7dHhjIG1Y5ZohOoLDNL/TiZl9Z19yLaIRGpa0O49fjKiGMFNVRilDLy2XGTyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fWOv+Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FD9C4CEC3;
	Tue, 29 Oct 2024 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730161980;
	bh=h6uTVq+hv9WhN1djveiVDbjzfvV7PyEB+OO+feAAn98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1fWOv+Xz4YoVnyfxnShxDcmk+XGg2cxeGv/lJbGGmZOc9bq79BG9xUrfeHzwcoLFZ
	 Rv5MyOoqKTRjEE47xrnZDVU5/Iqkuyel1uikjJooEeWSjZ7dLpwoDnpOJtTA1MD5yS
	 vy8b8S696klE0nThRykPJYyXlZUiSbepqDCCk4tk=
Date: Tue, 29 Oct 2024 01:32:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Steffen Persvold <spersvold@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Yury Norov <yury.norov@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ACPI: CPPC: Make rmw_lock a raw_spin_lock
Message-ID: <2024102934-bankroll-strongbox-8074@gregkh>
References: <20241028105200.1205509-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028105200.1205509-1-pierre.gondois@arm.com>

On Mon, Oct 28, 2024 at 11:51:49AM +0100, Pierre Gondois wrote:
> The following BUG was triggered. sugov_update_shared() locks a
> raw_spinlock while cpc_write() locks a spinlock. To have a correct
> wait-type order, update rmw_lock to a raw_spinlock.
> 
> Also save irq state.
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.12.0-rc2-XXX #406 Not tainted
> -----------------------------
> kworker/1:1/62 is trying to lock:
> ffffff8801593030 (&cpc_ptr->rmw_lock){+.+.}-{3:3}, at: cpc_write+0xcc/0x370
> other info that might help us debug this:
> context-{5:5}
> 2 locks held by kworker/1:1/62:
>   #0: ffffff897ef5ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x50
>   #1: ffffff880154e238 (&sg_policy->update_lock){....}-{2:2}, at: sugov_update_shared+0x3c/0x280
> stack backtrace:
> CPU: 1 UID: 0 PID: 62 Comm: kworker/1:1 Not tainted 6.12.0-rc2-g9654bd3e8806 #406
> Workqueue:  0x0 (events)
> Call trace:
>   dump_backtrace+0xa4/0x130
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x28
>   __lock_acquire+0x480/0x1ad8
>   lock_acquire+0x114/0x310
>   _raw_spin_lock+0x50/0x70
>   cpc_write+0xcc/0x370
>   cppc_set_perf+0xa0/0x3a8
>   cppc_cpufreq_fast_switch+0x40/0xc0
>   cpufreq_driver_fast_switch+0x4c/0x218
>   sugov_update_shared+0x234/0x280
>   update_load_avg+0x6ec/0x7b8
>   dequeue_entities+0x108/0x830
>   dequeue_task_fair+0x58/0x408
>   __schedule+0x4f0/0x1070
>   schedule+0x54/0x130
>   worker_thread+0xc0/0x2e8
>   kthread+0x130/0x148
>   ret_from_fork+0x10/0x20
> 
> Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

