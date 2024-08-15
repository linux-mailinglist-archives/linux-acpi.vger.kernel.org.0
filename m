Return-Path: <linux-acpi+bounces-7596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07697952BFE
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616F6B23693
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8119B3DD;
	Thu, 15 Aug 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ber7Jhzn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC15762D2;
	Thu, 15 Aug 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713322; cv=none; b=IB4GhD83ZGNuM8FtxQm4lv7ufEag/QWIsbLVSRXaI5OdLQANpSyJur0PN7XkR3Vc70ecBwuXM3bgWNgdK3irTNlUpSz1MN+cwomHcASYusescthtQNQKzTOeFJiObRCx/lvXHScDDi1O4KI+4PeimPTqChIttqK3tlnmSlZbRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713322; c=relaxed/simple;
	bh=UfEXHlzZQsk8l12u4I9X0Umo/RqjKKUaZjTPiP5cdGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/n7uECG1eXtJdTKFACchjH8Z/V3mTT88oz1Y4Gir6OglM3i/SVgQb+XQgY3EVDQhlN1U2jo44vpAdt2+ZqcKirQRdN/9fe6jv1s/XJ8+OA+ARoqb97IeCqPl3TBocQtwp92GB2xV+sdKBBtppIFpsbwL70K4fvfrCyk0iGgyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ber7Jhzn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723713321; x=1755249321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfEXHlzZQsk8l12u4I9X0Umo/RqjKKUaZjTPiP5cdGE=;
  b=Ber7Jhzn6voLDh2XlI0WG0qGcJ9ozNKA5XFYhwhKTLl3S8mOLvHvQdSI
   Xjfc6LuiACyQKhqPP7p3jCWS4aylrEr+TuDlmZb9YMD5rO8zTr9w2OEcH
   Q2F53XV0YOnFjDkP9GBF1aPy7ysjcbOXKWsAg6PF4tC8Vc92Gc6id5tSA
   xXhvoe9O+SUqm1EyHpt+5PFTOsQ1Cqjuj3dxWG5ludrRIaA9TsKuPKHNP
   r+HgUy9mw2uI+LIEGXnNYGe4DGrow5vRnWUlAaRQKzYD/thBdntndXIAU
   bw3lq/XaQQDa9qrUe5InZX1SCw51mqDOH4leu2JzDHOF+s/eUDVvVuC6H
   A==;
X-CSE-ConnectionGUID: f0Yi4TAXTTKps4g8njUGqg==
X-CSE-MsgGUID: 6BUJQHsWT1Wkd/ZENW9+LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32536934"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32536934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:15:19 -0700
X-CSE-ConnectionGUID: QBisctmWQieMfAMXXUVPew==
X-CSE-MsgGUID: v4YNdVhJShmO/O2c7MAEOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="58962580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 15 Aug 2024 02:15:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 252F939D; Thu, 15 Aug 2024 12:15:14 +0300 (EEST)
Date: Thu, 15 Aug 2024 12:15:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Message-ID: <5iijyqzxd3ccranzvmfgvf3mvkesfbjsuggtuppa5wf6z444dd@ft5h2m6u2ggw>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
 <87cymaoqj4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cymaoqj4.ffs@tglx>

On Wed, Aug 14, 2024 at 09:25:35PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 14 2024 at 15:46, Kirill A. Shutemov wrote:
> > Calculation of 'next' virtual address doesn't protect against wrapping
> > to zero. It can result in page table corruption and hang. The
> > problematic case is possible if user sets high x86_mapping_info::offset.
> 
> So this should have a Fixes tag, right?

Well, I guess we can add

Fixes: e4630fdd4763 ("x86/power/64: Always create temporary identity mapping correctly")

but the bug is not triggirable with current upstream code.

It only wraps to zero if you touch top PGD entry. There's no such users in
upstream. Only hibernate_64.c uses x86_mapping_info::offset and it works
on direct mapping range which is not top PGD entry.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

