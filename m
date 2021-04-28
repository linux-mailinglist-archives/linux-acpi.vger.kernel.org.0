Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7156C36D72D
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhD1MWr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhD1MWr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:22:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8375961413;
        Wed, 28 Apr 2021 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619612522;
        bh=0yfljeWZf/as7id/4Rzh3FTtgepJ+ZlD02AKERVNKqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVifndFDWJO/+GH5bcXQ7bxdkv+S5kJ0UicYordngtWO8yRrwI5QdlRCBukK9sZ2N
         OC4ggMRYH8P5ie9AhCiHcXA8UdgLcbXDd3q6O0HIfyoDSGYgg7LBcipPYo9DPjePr7
         0i+H4JblAAfSDDa9GHI/K35unnKX6mDtzZq5mXixEnCMqy/vT9FF83FxwOfwKc6i09
         hLQ/iewqS/9TZNYrQY0rjRya6nVhQ0IvncI6C3dHZ+eJka8vUx0I9IkosoYuPAmXkQ
         bZDGUbiSjiv/hBhnR4Uij06meZ4UnS9ta4hFLBCuQ5f8axNt+Mf59nl0a5edWMh2oh
         QoAZFs/DMnXSw==
Date:   Wed, 28 Apr 2021 15:21:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <YIlTY8p4kpkORPfl@unreal>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
 <59a5d631-6658-2034-06c4-467520b5b9f7@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a5d631-6658-2034-06c4-467520b5b9f7@perex.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 02:04:49PM +0200, Jaroslav Kysela wrote:
> Dne 26. 04. 21 v 19:50 bkkarthik napsal(a):
> > On 21/04/26 08:04AM, Leon Romanovsky wrote:
> >> On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> >>> isapnp_proc_init() does not look at the return value from
> >>> isapnp_proc_attach_device(). Check for this return value in
> >>> isapnp_proc_detach_device().
> >>>
> >>> Cleanup in isapnp_proc_detach_device and
> >>> isapnp_proc_detach_bus() for cleanup.
> >>>
> >>> Changed sprintf() to the kernel-space function scnprintf() as it returns
> >>> the actual number of bytes written.
> >>>
> >>> Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> >>> save memory.
> >>
> >> What exactly do you fix for such an old code?
> > 
> > I was not aware that this code is so old. This fix was made after checkpatch reported assignment inside an if-statement.
> > Please ignore this patch if th change is not necessary as the code is probably not being used anywhere :)
> > 
> > Maybe the code has to be marked as obsolete in the MAINTAINERS file to prevent patches being sent?
> > 
> >>
> >>>
> >>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> >>> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> >>> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> >>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> >>> ---
> >>>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
> >>>  1 file changed, 30 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> >>> index 785a796430fa..46ebc24175b7 100644
> >>> --- a/drivers/pnp/isapnp/proc.c
> >>> +++ b/drivers/pnp/isapnp/proc.c
> >>> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
> >>>  	.proc_read	= isapnp_proc_bus_read,
> >>>  };
> >>>  
> >>> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> >>> +{
> >>> +	proc_remove(dev->procent);
> >>> +	dev->procent = NULL;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> >>> +{
> >>> +	proc_remove(bus->procdir);
> >>> +	return 0;
> >>> +}
> >>
> >> Please don't add one line functions that are called only once and have
> >> return value that no one care about it.
> > 
> > These were only intended for a clean-up job, the idea of this function came from how PCI handles procfs.
> > Maybe those should be changed?
> 
> Which code you refer? I see:
> 
>        for_each_pci_dev(dev)
>                 pci_proc_attach_device(dev);

He talks about isapnp_proc_detach_*() functions.

> 
> 
> The error codes are ignored, too. It does not harm, if proc entries are not
> created (in this case - the system is unstable anyway). We should concentrate
> only to the wrong pointers usage.
> 
> 						Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
