Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6436BE41
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 06:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhD0ETn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Apr 2021 00:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhD0ETm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Apr 2021 00:19:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F5376101B;
        Tue, 27 Apr 2021 04:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619497139;
        bh=phUkD5R4YFn2qjCnUc+u7gzmJYeDBiXnaqgZgTqXPYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0J2hDcxul1U/sSEqJyjFGSLmz4KOQbE8gfSaGI18Dsu+tWFV3A9oSKYQq/g08wwq
         0YEDnkRNRrdNfcSY0Py71mjqODV6OoaO/mjrbcjWGFZg4mYYGS/omLN1CNyKfKqkjv
         uGhbjeWIZ9s5mj0/wtDt6COtTQtlpztKZJQ/P3gHtPtoF0vJcZ0b7C+Th3M6eSAd0K
         TDqcQWC9bC54/gCPteSYDfGoOYU5ZJgaNHf4hUmRC/uHZhjv458JeS6jTdSu0vaQA2
         dAZf1Ms17hHhduEpVPV4CiuRF380KA44g3eEdRKH96J84x1jg2yK9fvZFNycnDgIDU
         NX/5cY3ofz1Kg==
Date:   Tue, 27 Apr 2021 07:18:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     bkkarthik <bkkarthik@pesu.pes.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam <developer@arusty.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
Message-ID: <YIeQrwnAYMh2SV3g@unreal>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
 <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
 <YIZIHR0ZQPXFkOH1@unreal>
 <CAJZ5v0gRv-1qYiN8EXx12iOiJvX7ORzqQfHvtWDnZLtpg6Aijg@mail.gmail.com>
 <YIa3H6kGFXiqWRtg@unreal>
 <20210426175254.g63l272o4hnagcs2@burgerking>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426175254.g63l272o4hnagcs2@burgerking>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 11:22:54PM +0530, bkkarthik wrote:
> On 21/04/26 03:50PM, Leon Romanovsky wrote:
> > On Mon, Apr 26, 2021 at 02:00:58PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Apr 26, 2021 at 6:57 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 23, 2021 at 03:08:03PM -0600, Shuah Khan wrote:
> > > > > On 4/22/21 12:03 PM, Anupama K Patil wrote:
> > > > > > de, e are two variables of the type 'struct proc_dir_entry'
> > > > > > which can be removed to save memory. This also fixes a coding style
> > > > > > issue reported by checkpatch where we are suggested to make assignment
> > > > > > outside the if statement.
> > > > > >
> > > > >
> > > > > Sounds like a reasonable change.
> > > >
> > > > It is unclear how much changes to ISA code are welcomed.
> 
> If changes to ISA code aren't welcomed, should these be marked obsolete in the MAINTIANERS file?

I think so, but think that "Odd Fixes" better describes that Rafael wrote.

Thanks
