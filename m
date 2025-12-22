Return-Path: <linux-acpi+bounces-19748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CCCD53B2
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3AB303212F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A431328B;
	Mon, 22 Dec 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4NjSzd+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BA28690;
	Mon, 22 Dec 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391585; cv=none; b=PReYO5Qkb4Cy8ByYYR8fBc3xHWs9D8GQMtG8y5BMPk0lP655wrZAMgeJaE0OwZFHeV3egULCoc2oEuZ77nuReCPy2VClJM3RHxlbmwgXYFt9Zeugmgmp4odq7+Hmi31UZg2k4nPiS1RpeStooYA9lTei734yhf/1sUxkv3SP5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391585; c=relaxed/simple;
	bh=E1A7PNNWRR+k5MTnKO7m1Fvt91vOM0psW3gAF0DO/y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki+NknWwG2rBPfwkZnoiGWb0EkolYRlvU7ifm49nmaDdOFK9VufGI/JI4EqDjwVq4ecRFhUnD2pLeiqW7dIFOfGFWf0cpDIOb07VbCN5VSSJ2hTzoGFoqxq/XtbNGKzzCCu5ILresYnKG7WPFrnS6h9wB8pRNGNXDDtBkNuQDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4NjSzd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB840C4CEF1;
	Mon, 22 Dec 2025 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766391585;
	bh=E1A7PNNWRR+k5MTnKO7m1Fvt91vOM0psW3gAF0DO/y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4NjSzd+BLW6sliXM63tt7Ns5GoMuzm7PazLMEuCaPzp7To3T1bGJC9Q6hS/DRmcO
	 i4LwnKjZSerz/bRoOU2KzJjSgu+tQuFLWYJatsCenJpd/cSE4y5EnkhEEMsFRvSgOI
	 Ba6PIhCQ+2DmR2L45Y8BVqX+LfTaXGcLMlKeNSGA=
Date: Mon, 22 Dec 2025 09:19:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Lucas De Marchi <demarchi@kernel.org>, linux-acpi@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
Message-ID: <2025122203-purely-huntsman-7987@gregkh>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>

On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> The -EEXIST error code is reserved by the module loading infrastructure
> to indicate that a module is already loaded. When a module's init
> function returns -EEXIST, userspace tools like kmod interpret this as
> "module already loaded" and treat the operation as successful, returning
> 0 to the user even though the module initialization actually failed.
> 
> This follows the precedent set by commit 54416fd76770 ("netfilter:
> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> issue in nf_conntrack_helper_register().
> 
> Affected modules:
>   * meraki_mx100 pcengines_apuv2
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> The error code -EEXIST is reserved by the kernel module loader to
> indicate that a module with the same name is already loaded. When a
> module's init function returns -EEXIST, kmod interprets this as "module
> already loaded" and reports success instead of failure [1].
> 
> The kernel module loader will include a safety net that provides -EEXIST
> to -EBUSY with a warning [2], and a documentation patch has been sent to
> prevent future occurrences [3].
> 
> These affected code paths were identified using a static analysis tool
> [4] that traces -EEXIST returns to module_init(). The tool was developed
> with AI assistance and all findings were manually validated.
> 
> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
> Link: https://gitlab.com/-/snippets/4913469 [4]
> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 16a8301c25d6..083593d99a18 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -919,7 +919,7 @@ int software_node_register(const struct software_node *node)
>  	struct swnode *parent = software_node_to_swnode(node->parent);
>  
>  	if (software_node_to_swnode(node))
> -		return -EEXIST;
> +		return -EBUSY;

While I understand the want for the module loader to be returning
-EBUSY, that doesn't really make sense down here in this layer of the
kernel.

So why doesn't the module loader turn -EEXIST return values into -EBUSY
if it wishes to pass that value on to userspace?  Otherwise you are
going to be constantly playing "whack-a-mole" here and have really
set things up so that NO api can ever return EEXIST as an error value in
the future.

thanks,

greg k-h

