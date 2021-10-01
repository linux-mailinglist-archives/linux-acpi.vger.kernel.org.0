Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6569241F82E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Oct 2021 01:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJAXYg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 19:24:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:64062 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhJAXYe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Oct 2021 19:24:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="222408556"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="222408556"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 16:22:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="480787586"
Received: from schen9-mobl.amr.corp.intel.com ([10.134.109.23])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 16:22:47 -0700
Message-ID: <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Cc: Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Date:   Fri, 01 Oct 2021 16:22:46 -0700
In-Reply-To: <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
         <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
         <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
         <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2021-10-01 at 16:57 +0200, Peter Zijlstra wrote:
> On Fri, Oct 01, 2021 at 12:39:56PM +0200, Vincent Guittot wrote:
> > Hi Barry,
> > 
> > On Fri, 1 Oct 2021 at 12:32, Barry Song <21cnbao@gmail.com> wrote:
> > > Hi Vincent, Dietmar, Peter, Ingo,
> > > Do you have any comment on this first series which exposes
> > > cluster topology
> > > of ARM64 kunpeng 920 & x86 Jacobsville and supports load balance
> > > only for
> > > the 1st stage?
> > > I will be very grateful for your comments so that things can move
> > > forward in the
> > > right direction. I think Tim also looks forward to bringing up
> > > cluster
> > > support in
> > > Jacobsville.
> > 
> > This patchset makes sense to me and the addition of a new
> > scheduling
> > level to better reflect the HW topology goes in the right
> > direction.
> 
> So I had a look, dreading the selecti-idle-sibling changes, and was
> pleasantly surprised they're gone :-)
> 
> As is, this does indeed look like something mergable without too much
> hassle.
> 
> The one questino I have is, do we want default y?

I also agree that default y is preferable.

> 
> The one nit I have is the Kconfig text, I'm not really sure that's
> clarifying what a cluster is.

Do you have a preference of a different name other than cluster?
Or simply better documentation on what a cluster is for ARM64
and x86 in Kconfig?

Thanks.

Tim

