Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE7507189
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353745AbiDSPWX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349921AbiDSPWX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 11:22:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC7B29CA6
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 08:19:39 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23JFJDVv001514;
        Wed, 20 Apr 2022 00:19:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 20 Apr 2022 00:19:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23JFJDXS001508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Apr 2022 00:19:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <eb670558-2168-d8db-23fd-f50ab1ad74d3@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Apr 2022 00:19:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ACPI: Avoid flush_scheduled_work() usage
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
 <CAJZ5v0h1K4g8VKV2n_WUeV2RYovcFHRM1BVZY3Wu0TcXUaQVWA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAJZ5v0h1K4g8VKV2n_WUeV2RYovcFHRM1BVZY3Wu0TcXUaQVWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/04/19 23:48, Rafael J. Wysocki wrote:
> On Tue, Apr 19, 2022 at 3:57 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Flushing system-wide workqueues is dangerous and will be forbidden.
>> Replace system_wq with local acpi_wq.
>>
>> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> This patch blindly converts schedule_{,rcu_}work() into queue_{,rcu_}work()
>> within drivers/acpi/ directory, based on an assumption that none of work items
>> outside of drivers/acpi/ directory needs to be handled by acpi_wq.
>> Also, I kept sharing acpi_wq between acpi/ and acpi/apei, based on assumption
>> that sharing is safe and correct behavior. Did I convert correctly?
> 
> Please don't do it this way.
> 
> There is not much sense in sharing a dedicated workqueue between the
> different pieces of code below.
> 
> I guess that there is a need to switch over to dedicated workqueues in
> all cases when the workqueue needs to be flushed directly.  If so,
> please let me look at what can be done.
> 

Since system_wq is shared throughout the kernel, calling flush_scheduled_work()
might cause deadlock. In order to avoid possibility of deadlock, there is a need to
use a dedicated workqueue in all cases when some work is subjected to flush_workqueue().
This is one of patches for avoiding flush_scheduled_work() usage, but I'm not familiar
with ACPI code. Thus, please introduce a dedicated workqueue in a way you think makes
sense.
