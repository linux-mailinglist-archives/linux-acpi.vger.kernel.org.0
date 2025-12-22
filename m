Return-Path: <linux-acpi+bounces-19745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311DCD4B1C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 05:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097993006F5B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08069237A4F;
	Mon, 22 Dec 2025 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEFoCh10"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0892155326;
	Mon, 22 Dec 2025 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766378415; cv=none; b=nblPTFgZ+S8yMRess3Bwdin/czoI+QKoCnWuZYvqJmKwob+fhUUEWC0RgQ9ZHlobt0BnUvwUcvNpHKaPCZzDYsyZoxPOPu0XIeQFlm8mNSu71IhtqVozoU8T1/B4dUl3N6snJwhma7hSeq17o86OdQZzGk0k61Avs2Q2qLdrwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766378415; c=relaxed/simple;
	bh=59RINjXBROtdfqnPC4dtWKuiuAB2h20wNTa080CYBZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQe3g5YOjbMTPItjDdpGLTRqjk1Z/TnLzel68jR1kFeYpeGteSxLiJCdlKH+JcaahxSHCyVmAAh1s1dpBxMcLKc0aZXwnynoCKQen51FFTFNS8s/29uYkxW7elhqljQwG9lWWjV52Y2YivrROGcaTilYTl+1ArGLyikwda+w7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEFoCh10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D98C4CEF1;
	Mon, 22 Dec 2025 04:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766378415;
	bh=59RINjXBROtdfqnPC4dtWKuiuAB2h20wNTa080CYBZw=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EEFoCh10HKBznipcniS9TErcGHUjR/HWpi2BVyG2coQkvipR5IDSYJUqXr7KTxXLA
	 iZV3Yx8682Kht0cPq1usDVI/Fb7O1or2+pXl0dQqtSyIYVmMabUYU4QrlOFarxddCk
	 Fpl+7YUNS3Xp96QAFDINeU/vyPzFdsTMmyPPX+XBVGqenuZx9LO9mdowgv4DGucppm
	 rfjcCphqd6EymNeyogvW6u2pM4vfaqy9tjLpeUJ0cSpZVntQxYbcQ/nXUgyX4coHwG
	 PKIEITTVnBkTzqFG/bp9QgtxWBVEoyb5Pyq2Q+CbOvY7y3DnZN+Wl9o0QAHFK2Dul2
	 Ws6Z1C/mGj6Vg==
Message-ID: <8a43a502-af65-41d9-9ae0-81f9a27ff45e@kernel.org>
Date: Mon, 22 Dec 2025 05:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <demarchi@kernel.org>, linux-acpi@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
 <aUht13bTn-lEnNM-@kekkonen.localdomain>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <aUht13bTn-lEnNM-@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2025 22.59, Sakari Ailus wrote:
> Hi Daniel,
> 
> Thanks for the patch.
> 
> On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
>> From: Daniel Gomez <da.gomez@samsung.com>
>>
>> The -EEXIST error code is reserved by the module loading infrastructure
>> to indicate that a module is already loaded. When a module's init
>> function returns -EEXIST, userspace tools like kmod interpret this as
>> "module already loaded" and treat the operation as successful, returning
>> 0 to the user even though the module initialization actually failed.
>>
>> This follows the precedent set by commit 54416fd76770 ("netfilter:
>> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
>> issue in nf_conntrack_helper_register().
>>
>> Affected modules:
>>   * meraki_mx100 pcengines_apuv2
>>
>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> ---
>> The error code -EEXIST is reserved by the kernel module loader to
>> indicate that a module with the same name is already loaded. When a
>> module's init function returns -EEXIST, kmod interprets this as "module
>> already loaded" and reports success instead of failure [1].
>>
>> The kernel module loader will include a safety net that provides -EEXIST
>> to -EBUSY with a warning [2], and a documentation patch has been sent to
>> prevent future occurrences [3].
>>
>> These affected code paths were identified using a static analysis tool
>> [4] that traces -EEXIST returns to module_init(). The tool was developed
>> with AI assistance and all findings were manually validated.
> 
> This might not be the only case where -EEXIST may be returned by loading a
> module.

That is correct. There are 40+ places detected and around 20+ more where
the error is returned but at some point ignored and not propagated back to
userspace. I have all the series ready for the first case, but I've only sent
the first 6.

> The patch is fine IMO but I'd just change -EEXIST to -EBUSY in e.g.
> do_init_module() to avoid this being an actual bug elsewhere.

We are planning to merge that too. Link [2] refers to Lucas's "[PATCH 0/2]
module: Tweak return and warning" series, which replaces -EEXIST with -EBUSY at
runtime and warns. However, we do not consider that to be the actual fix. I am
starting to send these fixes out to avoid "spamming" unnecessarily the kernel
log in cases we can already detect.

> 
> I wonder what others think.

Please, find the rest of the series sent:
https://lore.kernel.org/all/20251220-dev-module-init-eexists-linux-scsi-v1-0-5379db749d54@samsung.com
https://lore.kernel.org/all/20251219-dev-module-init-eexists-netfilter-v1-1-efd3f62412dc@samsung.com
https://lore.kernel.org/all/20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com
https://lore.kernel.org/all/20251220-dev-module-init-eexists-keyring-v1-1-a2f23248c300@samsung.com
https://lore.kernel.org/all/20251220-dev-module-init-eexists-dm-devel-v1-1-90ed00444ea0@samsung.com

FYI, these docs go on top of Lucas' changes with the hope this is clear in the
docs.

https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com

> 
>>
>> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
>> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
>> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
>> Link: https://gitlab.com/-/snippets/4913469 [4]

