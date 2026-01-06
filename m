Return-Path: <linux-acpi+bounces-19978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67386CF8CA9
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60A8301DB81
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E003128AD;
	Tue,  6 Jan 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU5BRCWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A23126C3;
	Tue,  6 Jan 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709492; cv=none; b=d0oL/c5hqlGbNuNVmpu8bVOBzev+Ek/Hmbw2Ju6d9+g5bRrrwrm2d9umlcto//0ky5FFZM2rV6OAsFmEuEs+Z72ITZvYcQHqJlsJk+eLISEpHbla84NuT8SwVMaQmS150hQ05qsHiG9ONjt4AZJT6NDOmgsdqMs4qOmBI3RAHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709492; c=relaxed/simple;
	bh=Zncy1KkWYJnXMWV5PjCrHYfekTgxbBilVilf73f0cvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJDtOYdSG932vawyhQBNtb2A95gW7vh4X3tFul86ewimmokyY97jVdzNat57mvfFxYo/pZoywm0wGubM1MB6FKfo/F5dJCltB6aeHSr+amiIhJe9H9F81dhFBD5N2r6psk9aiIWhPihzmPjV9gtrD3Rbn5uyToWKcmo10QFmGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU5BRCWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AD4C116C6;
	Tue,  6 Jan 2026 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767709492;
	bh=Zncy1KkWYJnXMWV5PjCrHYfekTgxbBilVilf73f0cvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU5BRCWNSh+DnnO0iFU4Xx2OHYXg13Ydr6BdbHBuwmT5kOUsaqnKUwBty7wOu4oWS
	 u55Gc5oNWPpHPoIDAGig1lbyUGxxKyzb8JskixcQ3cPvfzdJmxOgafx/LaLtJoyg3y
	 TMOAIwTnHvMnIDklxg2wosJJfh/dF9ycotY02BFHUVASPK/s5U3bP3Q/4OIRkrEkGW
	 UUz7mUAsW7yd0cM7ZmtnZboETCvvqwf6czZs2aO6mc2yxlKOVE5wF7EckhJScfyi28
	 JozdqgWVwufOenAM5uuWLyHxgQFqUt25s8litSp+nPw7YxKzEr5FVdKF0J5K4gOXqu
	 zcE8+EUao5YXw==
Date: Tue, 6 Jan 2026 08:24:50 -0600
From: Lucas De Marchi <demarchi@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Gomez <da.gomez@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, linux-acpi@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
Message-ID: <4zatcu4izel7yijmkinxy6wq6owktwsyxkazb5ufc4vua54ojx@3vq4dgtydgia>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
 <2025122203-purely-huntsman-7987@gregkh>
 <7ff92075-df6a-45d8-9014-647ae45797ff@kernel.org>
 <2025122212-fiction-setback-ede5@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025122212-fiction-setback-ede5@gregkh>

On Mon, Dec 22, 2025 at 12:56:38PM +0100, Greg Kroah-Hartman wrote:
>On Mon, Dec 22, 2025 at 09:48:54AM +0100, Daniel Gomez wrote:
>> On 22/12/2025 09.19, Greg Kroah-Hartman wrote:
>> > On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
>> >> From: Daniel Gomez <da.gomez@samsung.com>
>> >>
>> >> The -EEXIST error code is reserved by the module loading infrastructure
>> >> to indicate that a module is already loaded. When a module's init
>> >> function returns -EEXIST, userspace tools like kmod interpret this as
>> >> "module already loaded" and treat the operation as successful, returning
>> >> 0 to the user even though the module initialization actually failed.
>> >>
>> >> This follows the precedent set by commit 54416fd76770 ("netfilter:
>> >> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
>> >> issue in nf_conntrack_helper_register().
>> >>
>> >> Affected modules:
>> >>   * meraki_mx100 pcengines_apuv2
>> >>
>> >> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> >> ---
>> >> The error code -EEXIST is reserved by the kernel module loader to
>> >> indicate that a module with the same name is already loaded. When a
>> >> module's init function returns -EEXIST, kmod interprets this as "module
>> >> already loaded" and reports success instead of failure [1].
>> >>
>> >> The kernel module loader will include a safety net that provides -EEXIST
>> >> to -EBUSY with a warning [2], and a documentation patch has been sent to
>> >> prevent future occurrences [3].
>> >>
>> >> These affected code paths were identified using a static analysis tool
>> >> [4] that traces -EEXIST returns to module_init(). The tool was developed
>> >> with AI assistance and all findings were manually validated.
>> >>
>> >> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
>> >> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
>> >> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
>> >> Link: https://gitlab.com/-/snippets/4913469 [4]
>> >> ---
>> >>  drivers/base/swnode.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> >> index 16a8301c25d6..083593d99a18 100644
>> >> --- a/drivers/base/swnode.c
>> >> +++ b/drivers/base/swnode.c
>> >> @@ -919,7 +919,7 @@ int software_node_register(const struct software_node *node)
>> >>  	struct swnode *parent = software_node_to_swnode(node->parent);
>> >>
>> >>  	if (software_node_to_swnode(node))
>> >> -		return -EEXIST;
>> >> +		return -EBUSY;
>> >
>> > While I understand the want for the module loader to be returning
>> > -EBUSY, that doesn't really make sense down here in this layer of the
>> > kernel.
>> >
>> > So why doesn't the module loader turn -EEXIST return values into -EBUSY
>> > if it wishes to pass that value on to userspace?  Otherwise you are
>>
>> Indeed, we are planning to do that as well with "[PATCH 0/2] module: Tweak
>> return and warning":
>>
>> https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/#t
>>
>> However, we don't consider that as the right fix.
>>
>> > going to be constantly playing "whack-a-mole" here and have really
>> > set things up so that NO api can ever return EEXIST as an error value in
>> > the future.
>>
>> 100%.
>>
>> For that reason, on top of the series from Lucas, we are documenting this to
>> make it clear:
>>
>> https://lore.kernel.org/linux-modules/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/T/#m2ed6fbffb3f78b9bff53840f6492a198c389cb50
>
>Wait, no, that's not what I mean at all :)
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
>Please no, let us keep using -EEXIST in the kernel source, and if your
>usage is going to map this to userspace somehow, do the translation
>there, in the module code, as your original patch above said.
>
>Otherwise, again, this is never going to work, let the subsystems use
>this error code how ever they feel they need to.

Ok. When I added the warning I was more following what the other error
handling was doing for positive values. Happy to change that to simply
map the error code before returning from do_init_module().

Daniel, do you want me to resend that with the warning removed?

Lucas De Marchi

>
>thanks,
>
>greg k-h

