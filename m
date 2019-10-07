Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D27CE83D
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2019 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJGPs6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 11:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfJGPs5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Oct 2019 11:48:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7889CAFBE;
        Mon,  7 Oct 2019 15:48:56 +0000 (UTC)
Date:   Mon, 7 Oct 2019 17:48:52 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: Split vmalloc_sync_all()
Message-ID: <20191007154852.GE4636@suse.de>
References: <20191007151618.11785-1-joro@8bytes.org>
 <02e99987-10d2-203f-e6ba-e2568fa1af28@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e99987-10d2-203f-e6ba-e2568fa1af28@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dave,

thanks for your review!

On Mon, Oct 07, 2019 at 08:30:51AM -0700, Dave Hansen wrote:
> On 10/7/19 8:16 AM, Joerg Roedel wrote:
> > @@ -318,7 +328,7 @@ static void dump_pagetable(unsigned long address)
> >  
> >  #else /* CONFIG_X86_64: */
> >  
> > -void vmalloc_sync_all(void)
> > +void vmalloc_sync_mappings(void)
> >  {
> >  	sync_global_pgds(VMALLOC_START & PGDIR_MASK, VMALLOC_END);
> >  }
> 
> FWIW, I generally detest the use of __weak. :)

Yeah, I don't like it either, but in this case it is probably better
than empty stubs in all architectures besides x86 :)

> In this case, it ends up letting us gloss over the fact that we have a
> 32/64-bit asymmetry.  It would probably be nice to actually have a
> 64-bit implementation that comes along with a nice comment.  Maybe this
> in vmalloc_sync_mappings():
> 
> 	/*
> 	 * 64-bit mappings might allocate new p4d/pud pages
> 	 * that need to be propagated to all tasks' PGDs.
> 	 */
> 
> which would pair nicely with:
> 
> void vmalloc_sync_unmappings(void)
> {
> 	/*
> 	 * Unmappings never allocate or free p4d/pud pages.
> 	 * No work is required here.
> 	 */
> }

Yes, that makes, I will add these comments in V2.

Thanks,

	Joerg
