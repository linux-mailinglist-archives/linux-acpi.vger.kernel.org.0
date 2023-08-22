Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADA7837B5
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Aug 2023 03:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjHVB7A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Aug 2023 21:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHVB65 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 21:58:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E11AA;
        Mon, 21 Aug 2023 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692669528; x=1724205528;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NK9kd6wC9ffXoCXM1lqOHcUXbiZpoYG3jvzlyF/Ak8c=;
  b=PZ9KpSS79kHcPT8SZNGYWiFQC/HFcXVS5o6yASZ5KnIgZnEwneqoesYQ
   nYMU8y/aM0u5a4diOAhBK4K4bjAr1TdFC+erfoq+v+qW6FbHmnEw+FavP
   2oWgWYaalPdIYyUfFD7d+xbgHZ6jwxVJKVDa1sXJnaXCe123vkuOYShzG
   nftRXZ2IHr36VYP03LjJxRdlxso9FALevFPvC2WN+gwPYoRw/J06MZ0I3
   2NQxHjCmKApvWX8iycJNC56gne3Z1vYuxA4rtUFOeSAZDexbxDKXQ2J2V
   NzCWsh4OqjEQNKjnZWxR1+Ac74tWcXtR7jjIqGBJoRnqpHuw3Vl/TIvsw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371179222"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="371179222"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685870987"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="685870987"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:58:43 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Joern Engel <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
References: <20230822010933.2247671-1-ushankar@purestorage.com>
Date:   Tue, 22 Aug 2023 09:56:38 +0800
In-Reply-To: <20230822010933.2247671-1-ushankar@purestorage.com> (Uday
        Shankar's message of "Mon, 21 Aug 2023 19:09:34 -0600")
Message-ID: <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Uday,

Uday Shankar <ushankar@purestorage.com> writes:

> The commit
>
> commit 3b38bb5f7f06356a89bb2cbf92ad346025e95192
> Author: Huang Ying <ying.huang@intel.com>
> Date:   Thu Dec 2 10:40:53 2010 +0800
>
>     ACPI, APEI, use raw spinlock in ERST
>
>     ERST writing may be used in NMI or Machine Check Exception handler. So
>     it need to use raw spinlock instead of normal spinlock.  This patch
>     fixes it.
>
>     Signed-off-by: Huang Ying <ying.huang@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
>
> turns erst_lock from a regular spinlock into a raw spinlock. This change
> does not help address the fundamental problem of locking in NMI handlers
> - NMIs can interrupt anything, including the critical section of the
> lock the handler wants to acquire.

The original commit cannot resolve the nested erst_lock issue, but
that's not the intention of the commit too.  Let me provide some
background.

ERST is mainly used to log the hardware error.  While, hardware error
may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
ERST functions in NMI handlers.  Where normal spinlock cannot be used
because they will be converted to sleepable rt_mutex in RT kernel.

Yes.  This isn't a perfect solution.  But it works in most cases in
practice.  Or, do you have some better solution?

--
Best Regards,
Huang, Ying

> The change does, however, introduce
> an illegal lock nesting pattern - while holding the erst_lock, there is
> a code path which calls printk, which may acquire a regular spinlock.
> This issue was caught by lockdep, and the report follows. Revert
> 3b38bb5f7f06 to address the issue.
>
> [ BUG: Invalid wait context ]
> 6.5.0-iopolicies+ #4 Not tainted
> -----------------------------
> systemd/1 is trying to lock:
> ffffffff9ec053b8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x325/0x440
> other info that might help us debug this:
> context-{5:5}
> 7 locks held by systemd/1:
> stack backtrace:
> CPU: 2 PID: 1 Comm: systemd Not tainted 6.5.0-iopolicies+ #4
> Hardware name:  /0JP31P, BIOS 2.7.0 05/23/2018
> Call Trace:
> <TASK>
> dump_stack_lvl+0x63/0xb0
> __lock_acquire+0x434/0xd30
> lock_acquire+0xcd/0x2b0
> ? serial8250_console_write+0x325/0x440
> ? __lock_acquire+0xab0/0xd30
> _raw_spin_lock_irqsave+0x39/0x60
> ? serial8250_console_write+0x325/0x440
> serial8250_console_write+0x325/0x440
> ? console_flush_all+0x1b5/0x590
> console_flush_all+0x1ec/0x590
> ? console_flush_all+0x184/0x590
> console_unlock+0x7c/0xd0
> vprintk_emit+0x261/0x380
> _printk+0x5c/0x80
> erst_read+0x1f8/0x210
> ? erst_get_record_id_next+0x26f/0x340
> erst_read_record+0x29/0xa0
> erst_reader+0xad/0x2e0
> ? __pfx_read_tsc+0x10/0x10
> ? ktime_get_real_fast_ns+0x47/0xa0
> ? __pfx_pstore_fill_super+0x10/0x10
> pstore_get_backend_records+0xc6/0x2d0
> ? __pfx_pstore_fill_super+0x10/0x10
> pstore_get_records+0x2b/0x50
> pstore_fill_super+0xb7/0xd0
> mount_single+0x90/0xc0
> ? security_capable+0x3c/0x60
> legacy_get_tree+0x34/0x60
> vfs_get_tree+0x2c/0xe0
> path_mount+0x703/0xa90
> do_mount+0x7d/0xa0
> __x64_sys_mount+0xdc/0x100
> do_syscall_64+0x3e/0x90
> entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7f3fdafa42be
> Code: 48 8b 0d cd 4b 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a 4b 38 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffdf2b2be08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 000055b567f49e78 RCX: 00007f3fdafa42be
> RDX: 000055b567d0294a RSI: 000055b567d02942 RDI: 000055b567d0294a
> RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000002
> R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdf2b2c050
> </TASK>
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Joern Engel <joern@purestorage.com>
> ---
>  drivers/acpi/apei/erst.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 247989060e29..b2c806840a11 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -78,7 +78,7 @@ static struct erst_erange {
>   * It is used to provide exclusive accessing for ERST Error Log
>   * Address Range too.
>   */
> -static DEFINE_RAW_SPINLOCK(erst_lock);
> +static DEFINE_SPINLOCK(erst_lock);
>  
>  static inline int erst_errno(int command_status)
>  {
> @@ -413,9 +413,9 @@ ssize_t erst_get_record_count(void)
>  	if (erst_disable)
>  		return -ENODEV;
>  
> -	raw_spin_lock_irqsave(&erst_lock, flags);
> +	spin_lock_irqsave(&erst_lock, flags);
>  	count = __erst_get_record_count();
> -	raw_spin_unlock_irqrestore(&erst_lock, flags);
> +	spin_unlock_irqrestore(&erst_lock, flags);
>  
>  	return count;
>  }
> @@ -480,9 +480,9 @@ static int __erst_record_id_cache_add_one(void)
>  
>  	id = prev_id = first_id = APEI_ERST_INVALID_RECORD_ID;
>  retry:
> -	raw_spin_lock_irqsave(&erst_lock, flags);
> +	spin_lock_irqsave(&erst_lock, flags);
>  	rc = __erst_get_next_record_id(&id);
> -	raw_spin_unlock_irqrestore(&erst_lock, flags);
> +	spin_unlock_irqrestore(&erst_lock, flags);
>  	if (rc == -ENOENT)
>  		return 0;
>  	if (rc)
> @@ -777,17 +777,17 @@ int erst_write(const struct cper_record_header *record)
>  		return -EINVAL;
>  
>  	if (erst_erange.attr & ERST_RANGE_NVRAM) {
> -		if (!raw_spin_trylock_irqsave(&erst_lock, flags))
> +		if (!spin_trylock_irqsave(&erst_lock, flags))
>  			return -EBUSY;
>  		rc = __erst_write_to_nvram(record);
> -		raw_spin_unlock_irqrestore(&erst_lock, flags);
> +		spin_unlock_irqrestore(&erst_lock, flags);
>  		return rc;
>  	}
>  
>  	if (record->record_length > erst_erange.size)
>  		return -EINVAL;
>  
> -	if (!raw_spin_trylock_irqsave(&erst_lock, flags))
> +	if (!spin_trylock_irqsave(&erst_lock, flags))
>  		return -EBUSY;
>  	memcpy(erst_erange.vaddr, record, record->record_length);
>  	rcd_erange = erst_erange.vaddr;
> @@ -795,7 +795,7 @@ int erst_write(const struct cper_record_header *record)
>  	memcpy(&rcd_erange->persistence_information, "ER", 2);
>  
>  	rc = __erst_write_to_storage(0);
> -	raw_spin_unlock_irqrestore(&erst_lock, flags);
> +	spin_unlock_irqrestore(&erst_lock, flags);
>  
>  	return rc;
>  }
> @@ -849,9 +849,9 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
>  	if (erst_disable)
>  		return -ENODEV;
>  
> -	raw_spin_lock_irqsave(&erst_lock, flags);
> +	spin_lock_irqsave(&erst_lock, flags);
>  	len = __erst_read(record_id, record, buflen);
> -	raw_spin_unlock_irqrestore(&erst_lock, flags);
> +	spin_unlock_irqrestore(&erst_lock, flags);
>  	return len;
>  }
>  EXPORT_SYMBOL_GPL(erst_read);
> @@ -936,12 +936,12 @@ int erst_clear(u64 record_id)
>  	rc = mutex_lock_interruptible(&erst_record_id_cache.lock);
>  	if (rc)
>  		return rc;
> -	raw_spin_lock_irqsave(&erst_lock, flags);
> +	spin_lock_irqsave(&erst_lock, flags);
>  	if (erst_erange.attr & ERST_RANGE_NVRAM)
>  		rc = __erst_clear_from_nvram(record_id);
>  	else
>  		rc = __erst_clear_from_storage(record_id);
> -	raw_spin_unlock_irqrestore(&erst_lock, flags);
> +	spin_unlock_irqrestore(&erst_lock, flags);
>  	if (rc)
>  		goto out;
>  	entries = erst_record_id_cache.entries;
