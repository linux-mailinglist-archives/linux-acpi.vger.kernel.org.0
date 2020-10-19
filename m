Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4B2927A7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgJSMvO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgJSMvO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2020 08:51:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003CC0613CE;
        Mon, 19 Oct 2020 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aomoUyVnBvyj5obhZS/Wk0YiobaC718gthiEwUANM5I=; b=S9Crs6ZGX658DXgyVcT9pxWuI/
        LoRbf92LRk98//ddPjnln2zDGGDv75z3HcXVBIUWUFu5IwkoYice/ewqXOU3Xn+dqq7ywn+vGNQMd
        TypI199QJYqv9YHMiX2cTFO+XGfc3EhLz14XtwlwVckgVPSOcVG0WCu18/JzmE6F4OtByMMfDmFZv
        cVnmEopY8lC7k3fE4U4IToxbajG68udnqQdvuYH9G4JSuIz05kXKX8SvGo5+9ES67ibnMTS/JBZcD
        TQ+5fG/KMUqPvVFHiAvjQYfXvWA8zUg3G+9IL/Tm/OtQibMiNkKgbBNWCEPHUvmklEfRIVAkcAatD
        5BPV+ntw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUUcq-0004UF-0e; Mon, 19 Oct 2020 12:50:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 531B1302753;
        Mon, 19 Oct 2020 14:50:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 245FD2038FA18; Mon, 19 Oct 2020 14:50:53 +0200 (CEST)
Date:   Mon, 19 Oct 2020 14:50:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019125053.GM2628@hirez.programming.kicks-ass.net>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
 <20201019103522.GK2628@hirez.programming.kicks-ass.net>
 <20201019123226.00006705@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019123226.00006705@Huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 19, 2020 at 01:32:26PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2020 12:35:22 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > I'm confused by all of this. The core level is exactly what you seem to
> > want.
> 
> It's the level above the core, whether in an multi-threaded core
> or a single threaded core.   This may correspond to the level
> at which caches are shared (typically L3).  Cores are already well
> represented via thread_siblings and similar.  Extra confusion is that
> the current core_siblings (deprecated) sysfs interface, actually reflects
> the package level and ignores anything in between core and
> package (such as die on x86)

That seems wrong. core-mask should be whatever cores share L3. So on a
Intel Core2-Quad (just to pick an example) you should have 4 CPU in a
package, but only 2 CPUs for the core-mask.

It just so happens that L3 and package were the same for a long while in
x86 land, although recent chips started breaking that trend.

And I know nothing about the core-mask being depricated; it's what the
scheduler uses. It's not going anywhere.

So if your 'cluster' is a group of single cores (possibly with SMT) that
do not share cache but have a faster cache connection and you want them
to behave as-if they were a multi-core group that did share cache, then
core-mask it is.
