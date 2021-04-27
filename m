Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AC36BE7E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 06:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhD0E1N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Apr 2021 00:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhD0E1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Apr 2021 00:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D102610FC;
        Tue, 27 Apr 2021 04:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619497591;
        bh=wHCRw8CK2beE0XTdU4DqF5r/0eO3m0TBvLp8G/39lrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsgLQA802lRgQG41+JTT7YNXDkeeVTjyUWUoiBHddmrFQK7OU1MM9TL1s+ah1Ssvq
         tdQUAKqojAuagZZTD/nKIByfgaDnfHgR1TS63rfZCkjYK7wDWB+6+L1M69iLsDLLpC
         3Ppw4036l+a6FFp4SQCnmqPoAso2SocCXh9t9EGM2+Ir/NN2wdR/0QMc9QLMKaBWqW
         Pbu6zhmwq//QnbF8xiONVZq8CoQgLjWAyF5ygz4ANAerARxXvDTc/6q9pZVfbprbAl
         8moIqQGd08X+Ib1ynjh2XPnIG3NRHm1I4ejmjCCbsbGMHEwi3Jdw8RDcRzcMjo54vb
         UB+BIiQe5FHPQ==
Date:   Tue, 27 Apr 2021 07:26:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     bkkarthik <bkkarthik@pesu.pes.edu>
Cc:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <YIeSc1qePhuQ1XRK@unreal>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210426175031.w26ovnffjiow346h@burgerking>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 11:20:32PM +0530, bkkarthik wrote:
> On 21/04/26 08:04AM, Leon Romanovsky wrote:
> > On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> > > isapnp_proc_init() does not look at the return value from
> > > isapnp_proc_attach_device(). Check for this return value in
> > > isapnp_proc_detach_device().
> > >=20
> > > Cleanup in isapnp_proc_detach_device and
> > > isapnp_proc_detach_bus() for cleanup.
> > >=20
> > > Changed sprintf() to the kernel-space function scnprintf() as it retu=
rns
> > > the actual number of bytes written.
> > >=20
> > > Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> > > save memory.

<...>

> > > +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> > > +{
> > > +	proc_remove(dev->procent);
> > > +	dev->procent =3D NULL;
> > > +	return 0;
> > > +}
> > > +
> > > +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> > > +{
> > > +	proc_remove(bus->procdir);
> > > +	return 0;
> > > +}
> >=20
> > Please don't add one line functions that are called only once and have
> > return value that no one care about it.
>=20
> These were only intended for a clean-up job, the idea of this function ca=
me from how PCI handles procfs.
> Maybe those should be changed?

Probably, the CONFIG_PROC_FS around pci_proc_*() is not needed too.

Thanks
