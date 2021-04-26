Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41B336B37D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhDZMvZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 08:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhDZMvY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 08:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 887DE61263;
        Mon, 26 Apr 2021 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619441443;
        bh=+UIfj82Eja1iaPvUFhsFHLNdYK0D3biGGwRTghZsyp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1K9TR0r8XbPqxD5ER8f7KjbXX/krszkrTt3MFjHqoX6D1NRXw1rtJBw+vGiI88Xx
         Sv/pmrFaIbZw/OtP72As92Wih+VpuzjGmesriUA0J1EyY5ha+DHkA2BpdZOU5zD5rb
         nFUgAoBbovrDU2xvkzKSZttzUPKiw7tZhFRk+PBk/ZTxRSWKYaB3FQSfBhU9ZSEHnJ
         ynpy3Y2q7LYqg8LM1Yh3/AlERpxYGIEJT/MMZdoWaGUi1KXfttZo42z6wdBQhZR+hc
         CnNWjBEViDmyy0bGa5d5a7+j2Ln0zkg66UcYS7ncTkFePsrb+6Ib8Yat3C3m2S5xV/
         8k81I3mK1A+uw==
Date:   Mon, 26 Apr 2021 15:50:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
Message-ID: <YIa3H6kGFXiqWRtg@unreal>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
 <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
 <YIZIHR0ZQPXFkOH1@unreal>
 <CAJZ5v0gRv-1qYiN8EXx12iOiJvX7ORzqQfHvtWDnZLtpg6Aijg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gRv-1qYiN8EXx12iOiJvX7ORzqQfHvtWDnZLtpg6Aijg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 02:00:58PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 26, 2021 at 6:57 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Apr 23, 2021 at 03:08:03PM -0600, Shuah Khan wrote:
> > > On 4/22/21 12:03 PM, Anupama K Patil wrote:
> > > > de, e are two variables of the type 'struct proc_dir_entry'
> > > > which can be removed to save memory. This also fixes a coding style
> > > > issue reported by checkpatch where we are suggested to make assignment
> > > > outside the if statement.
> > > >
> > >
> > > Sounds like a reasonable change.
> >
> > It is unclear how much changes to ISA code are welcomed.
> 
> Real fixes and obvious cleanups are, not much more than that.

While first part is easy to determine, the second one is more blurry.

> 
> > According to the Wikipedia, even Windows Vista disabled ISA PnP by default.
> > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> 
> It is indeed unclear how many systems with this interface still run
> Linux, but as long as the code is in the tree, there's nothing wrong
> with attempting to improve it.  There's no assurance that all such
> patches will be applied, though.
> 
> Thanks!
