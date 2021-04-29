Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443A36E589
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhD2HGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Apr 2021 03:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239591AbhD2HGD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Apr 2021 03:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D0036141E;
        Thu, 29 Apr 2021 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619679917;
        bh=GCQlMJMfukGtOitamxhM95nYZIGfkCAILI+JTYjvq54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hq9y3u89XB8wff9zbfx+aYL0qQ3C1HiyviyZwZnh158O+ObPtXCcwUTso3/eI/av5
         LJ3Nd+yRNy0UMHqKLJdcKJ9oTPIT5Y54nXVC8JQDhpAQlKxS/neJf3Sca5Xjr2YIw5
         r0q/TSv2ijoUQEPEvc3Q9pnbWx7bWvd4CUNOSpCoYyAosVTSDJOAlPO4Mp+IF+3BOM
         Eph42q03aTR/iDP9vuC9CewSSsBgMV6UMyy+Gxdjo/2qX/QrnVuQ4kLd+Z3NJl1HGB
         icHODrlhj/LZY2k1QY5c0miDpqHDbeAHzj87jUMVYKG697waBg+RgUQec2bD3Rae/v
         Xoi4mtHXTqz0Q==
Date:   Thu, 29 Apr 2021 10:05:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <YIpaqTHV/zYHrV1z@unreal>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
 <YIeSc1qePhuQ1XRK@unreal>
 <210271.1619670673@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <210271.1619670673@turing-police>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 29, 2021 at 12:31:13AM -0400, Valdis Kl=C4=93tnieks wrote:
> On Tue, 27 Apr 2021 07:26:27 +0300, Leon Romanovsky said:
> > On Mon, Apr 26, 2021 at 11:20:32PM +0530, bkkarthik wrote:
> > > These were only intended for a clean-up job, the idea of this functio=
n came from how PCI handles procfs.
> > > Maybe those should be changed?
> >
> > Probably, the CONFIG_PROC_FS around pci_proc_*() is not needed too.
>=20
> Will that actually build correctly if it's an embedded system or somethin=
g build with
> CONFIG_PROC_FS=3Dn?  I'd expect that to die a horrid death while linking =
vmlinx due
> to stuff inside that #ifdef calling symbols only present with PROC_FS=3Dm=
/y.

We are talking about pci_proc_detach_device() and pci_proc_detach_bus() her=
e.
They will build perfectly without CONFIG_PROC_FS.

Thanks
