Return-Path: <linux-acpi+bounces-11083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9FA32042
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 08:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5561652C5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBA204584;
	Wed, 12 Feb 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3ExI9lE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C51E47B4;
	Wed, 12 Feb 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346586; cv=none; b=QwgML91EjDC0tyYP2cVENf2rGjK7jJwO/GVW/0R/mjc0OAFp2Kxr+oibu7LuA5cEpO5vFpTl7AsuntFAoHfJwm/ArufAiVmen8Q3dveJ6azFd7bz5AvBssclmFZ6jBBf7LM45BV8TihE9RyR6z6sDpMRL1IIxwC04Hl9rgIXhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346586; c=relaxed/simple;
	bh=8w9Hl06CLUYgviD29yBA21KUXubpdXVQiG1IHZKXkeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9a5ownmfuzfqTdGm9zBVKut1o1XGoPELdKY0zcuLyjpMkRzvnbNOGl4CVJzgeKttYz0o1F7AL8KKWHkwlge22tS+X0A7p2/TuBOLT/WeqxcaBTFyLwjGfP52zVsFN96CYEr5BBGsOgyxt3rpDWVGCGk2QxbGpBSk/1Kx70eKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3ExI9lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE33CC4CEDF;
	Wed, 12 Feb 2025 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739346585;
	bh=8w9Hl06CLUYgviD29yBA21KUXubpdXVQiG1IHZKXkeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3ExI9lEP6kCp7MpcbrMay2usPSFkRdmWF/MUCMp8sGF9f3fWOZnXOWGMhLG7Af0D
	 XJhz7PicapucY+881T6fDxdoL4ZPfITHzynpULuGGN5btzaVwT1fvAax4+yQPlOEtS
	 Jyo/nfqLV6EFHfklhlDcJvLylHlhg8IH70C8Y1Z4=
Date: Wed, 12 Feb 2025 08:48:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Message-ID: <2025021231-panhandle-stonewall-ba3e@gregkh>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
 <SJ1PR11MB6083BF8F07A18FEF581DAAF2FCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083BF8F07A18FEF581DAAF2FCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Feb 11, 2025 at 05:02:11PM +0000, Luck, Tony wrote:
> >> +	if (node)
> >> +		ret = sysfs_create_link(&entry->dev.kobj, &node->dev.kobj, "node");
> >
> > What is going to remove this symlink if the memory goes away?  Or do
> > these never get removed?
> 
> There's currently no method for runtime changes to these memory ranges. They
> are described by a static ACPI table.  I need to poke the folks that came up
> with this to ask how memory hotplug will be handled (since CXL seems to be
> making that fashionable again).

ACPI should be supporting memory hotplug today, at the very least
"memory add", so surely you have some old boxes to test this with?

> > symlinks in sysfs created like this always worry me.  What is going to
> > use it?
> 
> <hand waves>User space tools that want to understand what the "per-region"
> monitoring and control features are actually operating on.</hand waves>

If you don't have a real user today, please don't include it now.  Wait
until it is actually needed.

thanks,

greg k-h

