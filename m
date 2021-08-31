Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3C3FC739
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhHaMVK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 08:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhHaMVK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 08:21:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630412414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLfh9JxjVsFJMEqDqI1wU0uUhzFLM1C98XY5fxI0HAw=;
        b=N/yy/WYoEI448fGxe26ycko7XHo8uM42egNOoWIezev23wyINJWmYtAVKi+VzAPBwRhpZq
        lRRvXh6/dat9ehKjyoNebNPQpoUJbcXMhVF+ByQMVpHnAPXZ+hzmqhvq5/9P9e1M8saU68
        IaYlINVn9+0GFKBtM4Iz+J911FmVlwyx36z2l0U2RmXyYHqYsPXsJ1HZJ9eLtWgLVgdwhG
        bnrzJtYaAZZw5kYawLThJ8kEUbsBVK/8iZZ/NhEIrYSIWd05o7fiLA9nINWLqB+dh33c8f
        i34xLIxKf7U5vdabeUcoYnTAOZJ+LiJDsnM+ovtXDXT6jR2ssVsoy3rYEEti3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630412414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLfh9JxjVsFJMEqDqI1wU0uUhzFLM1C98XY5fxI0HAw=;
        b=CNwUL1jjmzQ4Uf5vibymfJlFzgyn7labFozYoYdfH4pg2kpyJt1VQn4smAE3m1tkmxlAZ1
        V5qY0WImK8d45NAA==
To:     Hanjun Guo <guohanjun@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, wangle6@huawei.com, xiaoqian9@huawei.com,
        shaolexi@huawei.com, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
In-Reply-To: <9471f03d-942d-2143-5d87-8ec98bc38ec3@huawei.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
 <9471f03d-942d-2143-5d87-8ec98bc38ec3@huawei.com>
Date:   Tue, 31 Aug 2021 14:20:13 +0200
Message-ID: <87y28hdcw2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31 2021 at 19:39, Hanjun Guo wrote:
> On 2021/8/31 19:13, Guenter Roeck wrote:
>> This patch results in the following traceback on all arm64 boots with
>> EFI BIOS.
>> 
>> The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.
>
> I Cced Xiongfeng, he sent a patch to fix this issue over a month ago:
>
> https://lore.kernel.org/linux-arm-kernel/20210720112635.38565-1-wangxiongfeng2@huawei.com/T/

OMG. None of this is necessary.
