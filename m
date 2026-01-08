Return-Path: <linux-acpi+bounces-20053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC97D0294D
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E57103012EB5
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552DD364051;
	Thu,  8 Jan 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEzPHWO0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A82E7BD2;
	Thu,  8 Jan 2026 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873112; cv=none; b=cVBZZsA8yufv2fxJZ5lj/vTJj4C+xf9WcUQFm69/oaeNJTX4aqIhE5rFOSctnzLarDT2vUm9d6AbYrEBP2ZSTMyGxYZE4+hw9Jw4rs+ynEOu0qdOqiYJNcG3k6l/3XuK0IZFkbGhAWsw0rJj9pB1qKFOLATNtQdDKqrTzQZ2Uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873112; c=relaxed/simple;
	bh=kuYScPihUDFM/UOL8pjeMfHuMVNK+MkGnF6BLyrx/gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOA8XSjCRwTMheEl6qyqzVsAcWYmsCUN/TgzObX2MsUwPA2XJyzOIiHNLzaP7+uf6ubIv9U3GcsTQW6ZU6AZ8DlCz9zP3F6CGxTHCOutPEWaRTMLBzO2HNj5E5DS/JEIzBcDGXbCL0oW1IkQLo15h7i0fabzJo08mL9fvS1P5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEzPHWO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55964C19421;
	Thu,  8 Jan 2026 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767873111;
	bh=kuYScPihUDFM/UOL8pjeMfHuMVNK+MkGnF6BLyrx/gA=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YEzPHWO0qTh7ZvRYX4XE7aHjwhgpfFbdLzMdhywbWCXKqPhFTVZrm+wUcxRcVdUdy
	 SIVjZxAyssYvMJt7IwJ3EBA4ODQpbZcrgimLX8H7NL3/9q5zbBDbOY8qgp7qn4irEx
	 mDhQrgqGaeL/K2ZaodiTqqgtxWbx5uZ4D8b60U/SkWXZP3D04kpuwWmjsx9QYgGlxB
	 5Kpom0F0eHCg8gBZukQuS8esTTAltJ0grLDM+YmEDOCB4sXBNTlArLT937SaUAQ7eN
	 nNrPo9T2htzQNz8Q4yuTYL7DXvqCACv68erlMInLS0rxiJeuuFOEhHOagYKT3m4h6N
	 OU76hRICnEJGw==
Message-ID: <320328d3-6714-4c28-a19c-c9113b25c2af@kernel.org>
Date: Thu, 8 Jan 2026 12:51:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <demarchi@kernel.org>, linux-acpi@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
 <2025122203-purely-huntsman-7987@gregkh>
 <7ff92075-df6a-45d8-9014-647ae45797ff@kernel.org>
 <2025122212-fiction-setback-ede5@gregkh>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <2025122212-fiction-setback-ede5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/12/2025 12.56, Greg Kroah-Hartman wrote:
> On Mon, Dec 22, 2025 at 09:48:54AM +0100, Daniel Gomez wrote:
>> On 22/12/2025 09.19, Greg Kroah-Hartman wrote:
>>> On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
>>>> From: Daniel Gomez <da.gomez@samsung.com>
>>>>
>>>> The -EEXIST error code is reserved by the module loading infrastructure
>>>> to indicate that a module is already loaded. When a module's init
>>>> function returns -EEXIST, userspace tools like kmod interpret this as
>>>> "module already loaded" and treat the operation as successful, returning
>>>> 0 to the user even though the module initialization actually failed.
>>>>
>>>> This follows the precedent set by commit 54416fd76770 ("netfilter:
>>>> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
>>>> issue in nf_conntrack_helper_register().
>>>>
>>>> Affected modules:
>>>>   * meraki_mx100 pcengines_apuv2
>>>>
>>>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>>>> ---
>>>> The error code -EEXIST is reserved by the kernel module loader to
>>>> indicate that a module with the same name is already loaded. When a
>>>> module's init function returns -EEXIST, kmod interprets this as "module
>>>> already loaded" and reports success instead of failure [1].
>>>>
>>>> The kernel module loader will include a safety net that provides -EEXIST
>>>> to -EBUSY with a warning [2], and a documentation patch has been sent to
>>>> prevent future occurrences [3].
>>>>
>>>> These affected code paths were identified using a static analysis tool
>>>> [4] that traces -EEXIST returns to module_init(). The tool was developed
>>>> with AI assistance and all findings were manually validated.
>>>>
>>>> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
>>>> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
>>>> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
>>>> Link: https://gitlab.com/-/snippets/4913469 [4]
>>>> ---
>>>>  drivers/base/swnode.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>>>> index 16a8301c25d6..083593d99a18 100644
>>>> --- a/drivers/base/swnode.c
>>>> +++ b/drivers/base/swnode.c
>>>> @@ -919,7 +919,7 @@ int software_node_register(const struct software_node *node)
>>>>  	struct swnode *parent = software_node_to_swnode(node->parent);
>>>>  
>>>>  	if (software_node_to_swnode(node))
>>>> -		return -EEXIST;
>>>> +		return -EBUSY;
>>>
>>> While I understand the want for the module loader to be returning
>>> -EBUSY, that doesn't really make sense down here in this layer of the
>>> kernel.
>>>
>>> So why doesn't the module loader turn -EEXIST return values into -EBUSY
>>> if it wishes to pass that value on to userspace?  Otherwise you are
>>
>> Indeed, we are planning to do that as well with "[PATCH 0/2] module: Tweak
>> return and warning":
>>
>> https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/#t
>>
>> However, we don't consider that as the right fix.
>>
>>> going to be constantly playing "whack-a-mole" here and have really
>>> set things up so that NO api can ever return EEXIST as an error value in
>>> the future.
>>
>> 100%.
>>
>> For that reason, on top of the series from Lucas, we are documenting this to
>> make it clear:
>>
>> https://lore.kernel.org/linux-modules/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/T/#m2ed6fbffb3f78b9bff53840f6492a198c389cb50
> 
> Wait, no, that's not what I mean at all :)
> 
>> And sending patches where we see modules need fixing. I have already sent 6 out
>> of 20-ish series (that include a total of 40+ fixes):
>>
>> https://lore.kernel.org/all/20251220-dev-module-init-eexists-linux-scsi-v1-0-5379db749d54@samsung.com
>> https://lore.kernel.org/all/20251219-dev-module-init-eexists-netfilter-v1-1-efd3f62412dc@samsung.com
>> https://lore.kernel.org/all/20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com
>> https://lore.kernel.org/all/20251220-dev-module-init-eexists-keyring-v1-1-a2f23248c300@samsung.com
>> https://lore.kernel.org/all/20251220-dev-module-init-eexists-dm-devel-v1-1-90ed00444ea0@samsung.com
> 
> Please no, let us keep using -EEXIST in the kernel source, and if your

This is not just random places in the kernel. It's only errors in the module
initialization path.

> usage is going to map this to userspace somehow, do the translation
> there, in the module code, as your original patch above said.
> > Otherwise, again, this is never going to work, let the subsystems use
> this error code how ever they feel they need to.

I considered module_init() (somehow) to be part of the module code, and
replacing the error at the module loading layer felt like a hack to me. My
concern is that a module_init() user expecting -EEXIST to propagate to userspace
won't get it as it will be silently replaced. But without a concrete use case
where that matters, I'll go with the consensus. Note that I'm hinting at we
should remove the warning from Lucas' original patch [1] before merging it.

Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com/ [1]

