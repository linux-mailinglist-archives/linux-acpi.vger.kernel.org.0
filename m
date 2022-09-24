Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B45E8ED8
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Sep 2022 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiIXRRr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Sep 2022 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIXRRp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Sep 2022 13:17:45 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B33123E;
        Sat, 24 Sep 2022 10:17:44 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id s9so1909441qkg.4;
        Sat, 24 Sep 2022 10:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5G4pzphYlSukF+ZK/fBSg947ivTG9vC1FGRNj8lZZrQ=;
        b=zSpzkdbQVMZ0E0Y3+cd0l/gEM65SuetZr+f4K4Ns6GtOT083G4QiFCeLC2uO7HNtTW
         WQ+H2s4e0I9pPpe27nvTRrpoCzaxbsIJ72NgBqU1gaa7EUeAFF5OP2EOatm10cxz/Z+u
         XnbT53zXWd4XZ5hIXZYHKo2Wr4UgoVTHkpzUySNM65l8GqvAFKbCqMjGl8uA/zP8riBC
         8ExgySk3tpUa4EVUYjsKcZTFpLWcXsrbTokwgADkiBi1mM4F3otb15qjbIlFatyQApq+
         jGwr5gcHosTO8xeBzewVU7IqpFy9ATT59WMakwbv5dVHiizvvtVtKDcE1HdWzhySdwZc
         qDxw==
X-Gm-Message-State: ACrzQf09z+UdKYNpToHgI4yzJXZUSh3Wsohu4AiEOpmrG4JvPEwyYzFW
        seLxXW/xoi+t/btufOkV5pEgi3BzirMGRAKwtz5nl3QQ
X-Google-Smtp-Source: AMsMyM7ixR4MRnz/Qestq924YMJEhlZIG3lbLoi3bmVar6KX4ZnZKZZYd4MJjDigsv9R5vC28XIktaNxvEordpvl5xI=
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id
 m13-20020a05620a290d00b006b61a92d88amr9517895qkp.58.1664039864081; Sat, 24
 Sep 2022 10:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220916050535.26625-1-xueshuai@linux.alibaba.com> <20220924074953.83064-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20220924074953.83064-1-xueshuai@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:17:33 +0200
Message-ID: <CAJZ5v0jAZC81Peowy0iKuq+cy68tyn0OK3a--nW=wWMbRojcxg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: do not add task_work to kernel thread to
 avoid memory leak
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, linmiaohe@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Stable <stable@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 24, 2022 at 9:50 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
> If an error is detected as a result of user-space process accessing a
> corrupt memory location, the CPU may take an abort. Then the platform
> firmware reports kernel via NMI like notifications, e.g. NOTIFY_SEA,
> NOTIFY_SOFTWARE_DELEGATED, etc.
>
> For NMI like notifications, commit 7f17b4a121d0 ("ACPI: APEI: Kick the
> memory_failure() queue for synchronous errors") keep track of whether
> memory_failure() work was queued, and make task_work pending to flush out
> the queue so that the work is processed before return to user-space.
>
> The code use init_mm to check whether the error occurs in user space:
>
>     if (current->mm != &init_mm)
>
> The condition is always true, becase _nobody_ ever has "init_mm" as a real
> VM any more.
>
> In addition to abort, errors can also be signaled as asynchronous
> exceptions, such as interrupt and SError. In such case, the interrupted
> current process could be any kind of thread. When a kernel thread is
> interrupted, the work ghes_kick_task_work deferred to task_work will never
> be processed because entry_handler returns to call ret_to_kernel() instead
> of ret_to_user(). Consequently, the estatus_node alloced from
> ghes_estatus_pool in ghes_in_nmi_queue_one_entry() will not be freed.
> After around 200 allocations in our platform, the ghes_estatus_pool will
> run of memory and ghes_in_nmi_queue_one_entry() returns ENOMEM. As a
> result, the event failed to be processed.
>
>     sdei: event 805 on CPU 113 failed with error: -2
>
> Finally, a lot of unhandled events may cause platform firmware to exceed
> some threshold and reboot.
>
> The condition should generally just do
>
>     if (current->mm)
>
> as described in active_mm.rst documentation.
>
> Then if an asynchronous error is detected when a kernel thread is running,
> (e.g. when detected by a background scrubber), do not add task_work to it
> as the original patch intends to do.
>
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

I need the APEI code reviewers to tell me that this is all OK.

> ---
> changes since v1:
> - add description the side effect and give more details
>
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..80ad530583c9 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -985,7 +985,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>                                 ghes_estatus_cache_add(generic, estatus);
>                 }
>
> -               if (task_work_pending && current->mm != &init_mm) {
> +               if (task_work_pending && current->mm) {
>                         estatus_node->task_work.func = ghes_kick_task_work;
>                         estatus_node->task_work_cpu = smp_processor_id();
>                         ret = task_work_add(current, &estatus_node->task_work,
> --
> 2.20.1.12.g72788fdb
>
