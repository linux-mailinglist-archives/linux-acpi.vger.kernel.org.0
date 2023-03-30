Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0186D0039
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC3JxX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 30 Mar 2023 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjC3JxJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Mar 2023 05:53:09 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EBB7D98;
        Thu, 30 Mar 2023 02:53:08 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id y4so74239474edo.2;
        Thu, 30 Mar 2023 02:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqe5ft05YTqZZrlrtJn4uLGU7lFwiC2JxhR5rWQ+Q8g=;
        b=tF7/WsW+aGq0NjgkAFrgSAXrObS6EXqIsMvoWVyYkuRiSqR8uH2I/8s4ecO8VUQ1wJ
         XHfJjD0z4yN5H8ncqZAz8qH7l5wc+8X3HgjQRYtrzJ71YS2sGCO8+tZO/mSIBDdYSsI7
         oHFPXo5VXHIVgLjJDn5qrgpxHcdEY5JesfXRq7OTNNBH6vl02EmzwpQmJMnFszrDDk7F
         c38c+mepgbaijNse5IS0u34/TXU9Y+iDRrDp89JJnzN0PfHK6jyeR5O+g527gSbOYvrF
         IeUmATONG86WhR1XU87aaaahafO9Z024chAsO4b2+Ug3SHYf39ZkzOePR4LmJ3HwLGuv
         LOGg==
X-Gm-Message-State: AAQBX9fzPMBOjZxrLTMjb7OmoJEWCkIHLqfr22BXBLfURu724IhhrSB8
        HMYgagxTR5NreCPLcFy8449i/z5JARIziY8WU98=
X-Google-Smtp-Source: AKy350Z45/pRbKJkp18uUEnf+mk/6tbUDffgMY0DkTOBryHmnIlDDouxUDdqMGt09ydRaqVsp5gW3mAezBlV94dAcwk=
X-Received: by 2002:a17:907:a0cd:b0:947:4b15:51e5 with SMTP id
 hw13-20020a170907a0cd00b009474b1551e5mr1049320ejc.2.1680169986727; Thu, 30
 Mar 2023 02:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230317072443.3189-1-xueshuai@linux.alibaba.com> <CAJZ5v0gXTbxP5VkNWY+UiXM9oiGmtQbnCsMrCW8n40TvQehcWA@mail.gmail.com>
 <0133c209-b098-e822-58d7-27568888c282@linux.alibaba.com>
In-Reply-To: <0133c209-b098-e822-58d7-27568888c282@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 11:52:55 +0200
Message-ID: <CAJZ5v0jTjvCOZ_HikgopbDeqv1xWGbbOkNrktTZEPNDtZWXskg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ACPI: APEI: handle synchronous exceptions with
 proper si_code
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, tony.luck@intel.com,
        james.morse@arm.com, bp@alien8.de,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, cuibixuan@linux.alibaba.com,
        dave.hansen@linux.intel.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 30, 2023 at 8:11 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
>
> On 2023/3/21 AM2:03, Rafael J. Wysocki wrote:
> > On Fri, Mar 17, 2023 at 8:25 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >>
> >> changes since v2 by addressing comments from Naoya:
> >> - rename mce_task_work to sync_task_work
> >> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
> >> - add steps to reproduce this problem in cover letter
> >> - Link: https://lore.kernel.org/lkml/1aa0ca90-d44c-aa99-1e2d-bd2ae610b088@linux.alibaba.com/T/#mb3dede6b7a6d189dc8de3cf9310071e38a192f8e
> >>
> >> changes since v1:
> >> - synchronous events by notify type
> >> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> >>
> >> Currently, both synchronous and asynchronous error are queued and handled
> >> by a dedicated kthread in workqueue. And Memory failure for synchronous
> >> error is synced by a cancel_work_sync trick which ensures that the
> >> corrupted page is unmapped and poisoned. And after returning to user-space,
> >> the task starts at current instruction which triggering a page fault in
> >> which kernel will send SIGBUS to current process due to VM_FAULT_HWPOISON.
> >>
> >> However, the memory failure recovery for hwpoison-aware mechanisms does not
> >> work as expected. For example, hwpoison-aware user-space processes like
> >> QEMU register their customized SIGBUS handler and enable early kill mode by
> >> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
> >> the process by sending a SIGBUS signal in memory failure with wrong
> >> si_code: BUS_MCEERR_AO si_code to the actual user-space process instead of
> >> BUS_MCEERR_AR.
> >>
> >> To address this problem:
> >>
> >> - PATCH 1 sets mf_flags as MF_ACTION_REQUIRED on synchronous events which
> >>   indicates error happened in current execution context
> >> - PATCH 2 separates synchronous error handling into task work so that the
> >>   current context in memory failure is exactly belongs to the task
> >>   consuming poison data.
> >>
> >> Then, kernel will send SIGBUS with proper si_code in kill_proc().
> >>
> >> Lv Ying and XiuQi also proposed to address similar problem and we discussed
> >> about new solution to add a new flag(acpi_hest_generic_data::flags bit 8) to
> >> distinguish synchronous event. [2][3] The UEFI community still has no response.
> >> After a deep dive into the SDEI TRM, the SDEI notification should be used for
> >> asynchronous error. As SDEI TRM[1] describes "the dispatcher can simulate an
> >> exception-like entry into the client, **with the client providing an additional
> >> asynchronous entry point similar to an interrupt entry point**". The client
> >> (kernel) lacks complete synchronous context, e.g. systeam register (ELR, ESR,
> >> etc). So notify type is enough to distinguish synchronous event.
> >>
> >> To reproduce this problem:
> >>
> >>         # STEP1: enable early kill mode
> >>         #sysctl -w vm.memory_failure_early_kill=1
> >>         vm.memory_failure_early_kill = 1
> >>
> >>         # STEP2: inject an UCE error and consume it to trigger a synchronous error
> >>         #einj_mem_uc single
> >>         0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> >>         injecting ...
> >>         triggering ...
> >>         signal 7 code 5 addr 0xffffb0d75000
> >>         page not present
> >>         Test passed
> >>
> >> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
> >> and it is not fact.
> >>
> >> After this patch set:
> >>
> >>         # STEP1: enable early kill mode
> >>         #sysctl -w vm.memory_failure_early_kill=1
> >>         vm.memory_failure_early_kill = 1
> >>
> >>         # STEP2: inject an UCE error and consume it to trigger a synchronous error
> >>         #einj_mem_uc single
> >>         0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> >>         injecting ...
> >>         triggering ...
> >>         signal 7 code 4 addr 0xffffb0d75000
> >>         page not present
> >>         Test passed
> >>
> >> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
> >> as we expected.
> >>
> >> [1] https://developer.arm.com/documentation/den0054/latest/
> >> [2] https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
> >> [3] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
> >>
> >> Shuai Xue (2):
> >>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
> >>     synchronous events
> >>   ACPI: APEI: handle synchronous exceptions in task work
> >>
> >>  drivers/acpi/apei/ghes.c | 135 ++++++++++++++++++++++++---------------
> >>  include/acpi/ghes.h      |   3 -
> >>  mm/memory-failure.c      |  13 ----
> >>  3 files changed, 83 insertions(+), 68 deletions(-)
> >>
> >> --
> >
> > I really need the designated APEI reviewers to give their feedback on this.
>
> Gentle ping.

As already stated in this thread, this series requires reviews from
the designated APEI reviewers (Tony, Boris, James).

Thanks!
