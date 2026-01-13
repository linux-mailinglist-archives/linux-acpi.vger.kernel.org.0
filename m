Return-Path: <linux-acpi+bounces-20270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF4D1B8A7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA58D302FBCF
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B521355056;
	Tue, 13 Jan 2026 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWq9wOrK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881A355048;
	Tue, 13 Jan 2026 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342003; cv=none; b=ZzbKX27I8hKQU+deWNtIfI4BKgEatYSUojJxwoj592jJqBpMJUC8Sl1Gyqao22WU4p3rWpc8fl9rteJ/e0xnd5DUD4qgr+S0BVLgiZmmjVWMqSYIyEQwJRFRPiKXKudouf+YNwpGX1IJstivwlkqYbZMKpEKTlhtNoy7YYeKTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342003; c=relaxed/simple;
	bh=3s9Z8A+u9eM7tKZuDpZUkL+w59/wgF9C7usUzKllfFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkISvUQNB1OeFmgeJpm2qma5SRAc57Lz/HjvwLeckRGcnMCpZmND2I7klPyjx6P9Kwe8WGih4fJWlE6GuhrhuARrpd5I9AAgTf5A98NRWvR2ycv9frVgZMTApC12+yBmLRuTXcID+gKUlt2vZjad85yXhmuS+/NMc1QckXilbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWq9wOrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5B9C19423;
	Tue, 13 Jan 2026 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768342003;
	bh=3s9Z8A+u9eM7tKZuDpZUkL+w59/wgF9C7usUzKllfFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mWq9wOrKGAgwslGTLpP49HwFVIIiUSIJDXts6I2TDYMLnVm+81/e3Q1SItsmUpKA0
	 B/ELv7qdwtTF1BpqU6SH2UlWOtGJCEUhBjX6/gnaoqf5yk8LgNb1mgS7kla927Sd8T
	 lGBoBA7hbunhUNFa44R0cTQGaevzfs9dxsrXe9PP4Ivvv1C9/jrfVyMgmpgrooWnQ3
	 aR9kOqF79HWnwHKabvHfd556MEH4SnoEJxdjBSoLU0JW7DsDybfw50y6Dx5y+H5h6N
	 OuvhmQc/S/wZIVK3rnrJuJFhOzkn/Lbza601n4ZjXL+TKuiGkHc2hzYyQQFy87T4tk
	 mBfOyGGe9V1bw==
Message-ID: <8c458422-9fa7-44fd-90a7-b66bb905bdc6@kernel.org>
Date: Tue, 13 Jan 2026 16:06:41 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0
 constraints checking
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2827214.mvXUDI8C0e@rafael.j.wysocki>
 <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
 <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com>
 <bd1c4616-d8ad-4fbc-bd90-2e56996d0f5a@amd.com>
 <CAJZ5v0gFmRVNEG_QL2+F7Dmvey4WrcHwt7Rhq2hizcxzGF2eWA@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gFmRVNEG_QL2+F7Dmvey4WrcHwt7Rhq2hizcxzGF2eWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/13/2026 4:05 PM, Rafael J. Wysocki wrote:
> On Tue, Jan 13, 2026 at 11:00 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On 1/13/2026 3:57 PM, Rafael J. Wysocki wrote:
>>> On Tue, Jan 13, 2026 at 10:48 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> On 1/13/2026 7:36 AM, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when
>>>>> needed") attempted to avoid useless evaluation of LPS0 _DSM Function 1
>>>>> in lps0_device_attach() because pm_debug_messages_on might never be set
>>>>> (and that is the case on production systems most of the time), but it
>>>>> turns out that LPS0 _DSM Function 1 is generally problematic on some
>>>>> platforms and causes suspend issues to occur when pm_debug_messages_on
>>>>> is set now.
>>>>
>>>> Any ideas why it's causing problems?  AML doing something it shouldn't?
>>>
>>> It's not a clear AML bug AFAICS.  Rather, it seems to have
>>> dependencies on something that is not ready when it is evaluated, so
>>> an ordering issue or similar.
>>
>> Ah I see.
>>
>>>
>>>>>
>>>>> In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and only
>>>>> in the cases when the system does not reach the deepest platform idle
>>>>> state during suspend-to-idle for some reason.  If such diagnostics is
>>>>> not necessary, evaluating it is a loss of time, so using it along with
>>>>> the other pm_debug_messages_on diagnostics is questionable because the
>>>>> latter is expected to be suitable for collecting debug information even
>>>>> during production use of system suspend.
>>>>>
>>>>> For this reason, add a module parameter called check_lps0_constraints
>>>>> to control whether or not the list of LPS0 constraints will be checked
>>>>> in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
>>>>> LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().
>>>>>
>>>>> Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>     drivers/acpi/x86/s2idle.c |    8 ++++++--
>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> --- a/drivers/acpi/x86/s2idle.c
>>>>> +++ b/drivers/acpi/x86/s2idle.c
>>>>> @@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
>>>>>     module_param(sleep_no_lps0, bool, 0644);
>>>>>     MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
>>>>>
>>>>> +static bool check_lps0_constraints __read_mostly;
>>>>> +module_param(check_lps0_constraints, bool, 0644);
>>>>> +MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraints");
>>>>
>>>> I'm personally not really a fan of another module parameter for
>>>> debugging.  I know some other subsystem maintainers are very anti-module
>>>> parameters too.
>>>>
>>>> I did like having /sys/power/pm_debug_messages able to be a one stop
>>>> shop for debugging messages at runtime.
>>>
>>> Well, this is not just debug messages, rather a whole debug facility
>>> enabled via pm_debug_messages, which is kind of confusing.
>>
>> Good point.
>>
>>>
>>>> So I had another idea I wanted to throw around.  What if instead we had
>>>> a file /sys/kernel/debug/x86/lps0_constraints?
>>>
>>> Then you cannot use this without debugfs.
>>
>> I mean; yeah.  But it really is debugging and most distros have debugfs
>> enabled by default these days don't they?
> 
> Some of them don't.
> 
> That's one of the reasons why tracing has its own pseudo-filesystem
> now, so it is a real obstacle.
> 
>>>
>>>> If the file is never accessed never evaluate constraints.  If you read
>>>> it once then you can get a dump of all the current constraints and any
>>>> future suspends during that boot will also include constraints in the
>>>> logs (IE call lpi_check_constraints()).
>>>
>>> So if it is not in debugfs, it would need to be in sysfs and then I
>>> don't see much difference between it and a module param, honestly.
>>>
>>> I actually prefer the latter because it uses an existing infra.
>>
>> I agree if debugfs is decided to be out sysfs and module parameter are
>> equal footing and then this patch makes sense.
> 
> I think that debugfs cannot be relied on to be always present.

OK, I think the patch is fine as is then.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

