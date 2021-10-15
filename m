Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6507642FEA0
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJOXWB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 19:22:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:49611 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhJOXWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 19:22:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="226777758"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="226777758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492747609"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:19:53 -0700
Date:   Fri, 15 Oct 2021 16:19:52 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 4/7] x86/sgx: Add SGX infrastructure to recover from
 poison
Message-ID: <YWoMmHXv+VDELa6T@agluck-desk2.amr.corp.intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
 <20211011185924.374213-1-tony.luck@intel.com>
 <20211011185924.374213-5-tony.luck@intel.com>
 <YWoKaDtA+EvMyw4v@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWoKaDtA+EvMyw4v@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 15, 2021 at 11:10:32PM +0000, Sean Christopherson wrote:
> On Mon, Oct 11, 2021, Tony Luck wrote:
> > +	section = &sgx_epc_sections[page->section];
> > +	node = section->node;
> > +
> > +	spin_lock(&node->lock);
> > +
> > +	/* Already poisoned? Nothing more to do */
> > +	if (page->poison)
> > +		goto out;
> > +
> > +	page->poison = 1;
> > +
> > +	/*
> > +	 * If flags is zero, then the page is on a free list.
> > +	 * Move it to the poison page list.
> > +	 */
> > +	if (!page->flags) {
> 
> If the flag is inverted, this becomes
> 
> 	if (page->flags & SGX_EPC_PAGE_FREE) {

I like the inversion. I'll switch to SGX_EPC_PAGE_FREE

> 
> > +		list_del(&page->list);
> > +		list_add(&page->list, &sgx_poison_page_list);
> 
> list_move(), and needs the same protection for sgx_poison_page_list.

Didn't know list_move() existed. Will change all the lis_del+list_add
into list_move.

Also change the sgx_poison_page_list from global to per-node. Then
the adds will be safe (accessed while holding the node->lock).


Thanks for the review.

-Tony
