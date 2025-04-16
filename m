Return-Path: <linux-acpi+bounces-13074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FAA8B214
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000A3AE48D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12022CBE6;
	Wed, 16 Apr 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4UYwmfX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25822C322;
	Wed, 16 Apr 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788420; cv=none; b=KVFhwZuvliTbyH22VRSpI3a5frUqrs5V6iIj5HmggBD5Fr+iOwWKF7RIclE2HnVr4GKrTNw9oGdcC8koI4R6nXQuiJBiWdbbkA4DHPfrCIvQFNmH5PueW1rb1Z/xBI8wAAJsbl1sZpksH/nPjTO0HgD50O8jpQw+Yz2huC3V2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788420; c=relaxed/simple;
	bh=WHqiBZi04W6j6zlbSJBrICb04K/vv9APlXrF5vaOqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRMdrH7NlBSAtXm0ZWQp+trGDOZBn44/td8hOVervOMIM1jCx2TxNzNGnD57eJGNpspRNEi1S4wqbAoSzZyPtVQqx5Kj4UiqEgvu+AdAxQm7ct08cIVdBuLiGk0Cc3nOfLEhWuW4ugMt67QTc0tkqq1V5gqsmDW2mjA6RU++vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4UYwmfX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744788419; x=1776324419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WHqiBZi04W6j6zlbSJBrICb04K/vv9APlXrF5vaOqVw=;
  b=b4UYwmfXVBJ5B2Xsn9U9U+BUBmfNVswDzOe0MUJrTZeRgYAkIw42G7fy
   s6MJIDoSMQhtNEbjRSPzxUrvQweuCy5djD2w3L2X79SHu93FsdTPyzApi
   HLOv9nNmMpekUVuax5S7BYEot5j1raBnPpns5tK0AlAVLWsWjvKS95axV
   sv4BCRjEZ9DhffGSpVLBpDUjDKj2OMcPETwNp3LhFdM/NLDzWUSQTTJDx
   QHEc8ksYmGh9VbGqz10IZK1ZvKoRwFG7om9qF7PDszSVsPP78Lev5K8c4
   VqffDVHd6aImnKZ/zFcxA38Ljt9Uq+ayh9Z2e8lclS9DT/vWNW4IQI16q
   w==;
X-CSE-ConnectionGUID: EBwfnQH6QPCEZ4yhykBp2Q==
X-CSE-MsgGUID: n8jR3PrMSFWuu5gGjm660Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57711289"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="57711289"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:26:58 -0700
X-CSE-ConnectionGUID: gCYpnm+lR3e/2ZdvcyvmUQ==
X-CSE-MsgGUID: cMticInwS/qUFu/+xiHg+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130325329"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2025 00:26:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6C79BF4; Wed, 16 Apr 2025 10:26:53 +0300 (EEST)
Date: Wed, 16 Apr 2025 10:26:53 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, lenb@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bhe@redhat.com, kai.huang@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: fix potential NULL deref in acpi_wakeup_cpu()
Message-ID: <yie5ice3gl47ayfbty2oxppu6sp76ho6k5qt4g7jqy3qw5rrx6@s4cc4kyp3dun>
References: <20250411194820.3976363-1-chenyuan0y@gmail.com>
 <CAJZ5v0hBfq7rQvNFJevqD3s_cASFT2eBqC0zoDWBT1gAsfqkCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hBfq7rQvNFJevqD3s_cASFT2eBqC0zoDWBT1gAsfqkCg@mail.gmail.com>

On Tue, Apr 15, 2025 at 03:39:24PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 11, 2025 at 9:48 PM Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> >
> > The result of memremap() may be NULL on failure, leading to a NULL
> > dereference. Add explicit checks after memremap() call: if the
> > MADT mailbox fails to map, return immediately.
> >
> > This is similar to the commit 966d47e1f27c
> > ("efi: fix potential NULL deref in efi_mem_reserve_persistent").
> >
> > This is found by our static analysis tool KNighter.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: 2b5e22afae07 ("x86/acpi: Extract ACPI MADT wakeup code into a separate file")
> 
> Well, it's good to add the author of the commit you're trying to fix
> to the CC list.
> 
> Kirill, what do you think about this?

Looks reasonable to me.

We fail to remap a single page. It is likely to be fatally broken system
if we get there. But okay, let's handle it.

Maybe use pr_err_once(). No need to spam an error for every CPU.

> > ---
> >  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index f36f28405dcc..b386ec4b87c2 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -143,6 +143,10 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> >                 acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> >                                                 sizeof(*acpi_mp_wake_mailbox),
> >                                                 MEMREMAP_WB);
> > +               if (!acpi_mp_wake_mailbox) {
> > +                       pr_err("Failed to remap MADT mailbox\n");
> > +                       return -ENOMEM;
> > +               }
> >         }
> >
> >         /*
> > --
> > 2.34.1
> >

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

