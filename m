Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC342FEEC
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhJOXel (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 19:34:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:28702 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239208AbhJOXef (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 19:34:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225468211"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="225468211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:32:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="627967293"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:32:26 -0700
Date:   Fri, 15 Oct 2021 16:32:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 3/7] x86/sgx: Initial poison handling for dirty and
 free pages
Message-ID: <YWoPie7gGQK2OEjm@agluck-desk2.amr.corp.intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
 <20211011185924.374213-1-tony.luck@intel.com>
 <20211011185924.374213-4-tony.luck@intel.com>
 <YWoJxJCHxMN4ABVS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWoJxJCHxMN4ABVS@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 15, 2021 at 11:07:48PM +0000, Sean Christopherson wrote:
> On Mon, Oct 11, 2021, Tony Luck wrote:
> > A memory controller patrol scrubber can report poison in a page
> > that isn't currently being used.
> > 
> > Add "poison" field in the sgx_epc_page that can be set for an
> > sgx_epc_page. Check for it:
> > 1) When sanitizing dirty pages
> > 2) When freeing epc pages
> > 
> > Poison is a new field separated from flags to avoid having to make
> > all updates to flags atomic, or integrate poison state changes into
> > some other locking scheme to protect flags.
> 
> Explain why atomic would be needed.  I lived in this code for a few years and
> still had to look at the source to remember that the reclaimer can set flags
> without taking node->lock.

Will add explanation.

> 
> > In both cases place the poisoned page on a list of poisoned epc pages
> > to make sure it will not be reallocated.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/main.c | 14 +++++++++++++-
> >  arch/x86/kernel/cpu/sgx/sgx.h  |  3 ++-
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 09fa42690ff2..653bace26100 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -43,6 +43,7 @@ static nodemask_t sgx_numa_mask;
> >  static struct sgx_numa_node *sgx_numa_nodes;
> >  
> >  static LIST_HEAD(sgx_dirty_page_list);
> > +static LIST_HEAD(sgx_poison_page_list);
> >  
> >  /*
> >   * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
> > @@ -62,6 +63,12 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> >  
> >  		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
> >  
> > +		if (page->poison) {
> 
> Does this need READ_ONCE (and WRITE_ONCE in the writer) to prevent reloading
> page->poison since the sanitizer doesn't hold node->lock, i.e. page->poison can
> be set any time?  Honest question, I'm terrible with memory ordering rules...
> 

I think it's safe. I set page->poison in arch_memory_failure() while
holding node->lock in kthread context.  So not "at any time".

This particular read is done without holding the lock ... and is thus
racy. But there are a zillion other races early in boot before the EPC
pages get sanitized and moved to the free list. E.g. if an error is
reported before they are added to the sgx_epc_address_space xarray,
then all this code will just ignore the error as "not in Linux
controlled memory".

-Tony
