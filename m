Return-Path: <linux-acpi+bounces-1844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D736F7FBCD1
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8FB214A9
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2F4C3AB
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE909B5;
	Tue, 28 Nov 2023 05:55:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfkVd4WZ8z6JB96;
	Tue, 28 Nov 2023 21:55:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 774E61400C9;
	Tue, 28 Nov 2023 21:55:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 13:55:37 +0000
Date: Tue, 28 Nov 2023 13:55:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Gavin Shan <gshan@redhat.com>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 10/22] drivers: base: Move cpu_dev_init() after
 node_dev_init()
Message-ID: <20231128135536.00002ab9@Huawei.com>
In-Reply-To: <ZVywLPwhILp083Jk@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
	<E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
	<095c2d24-735b-4ce2-ba2e-9ec2164f2237@redhat.com>
	<ZVHXk9JG7gUjtERt@shell.armlinux.org.uk>
	<ZVywLPwhILp083Jk@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 21 Nov 2023 13:27:08 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Nov 13, 2023 at 08:00:19AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 13, 2023 at 10:58:46AM +1000, Gavin Shan wrote:  
> > > 
> > > 
> > > On 11/7/23 20:30, Russell King (Oracle) wrote:  
> > > > From: James Morse <james.morse@arm.com>
> > > > 
> > > > NUMA systems require the node descriptions to be ready before CPUs are
> > > > registered. This is so that the node symlinks can be created in sysfs.
> > > > 
> > > > Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> > > > are registered by arch code, instead of cpu_dev_init().
> > > > 
> > > > Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> > > > can use GENERIC_CPU_DEVICES.
> > > > 
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > > Note: Jonathan's comment still needs addressing - see
> > > >    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> > > > ---
> > > >   drivers/base/init.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >   
> > > 
> > > With Jonathan's comments addressed:  
> > 
> > That needs James' input, which is why I made the note on the patch.  
> 
> I'm going to be posting the series without RFC soon, and it will be
> with Jonathan's comment unaddressed - because as I've said several
> times it needs James' input and we have sadly not yet received that.
> 
> Short of waiting until James can respond, I don't think there are
> any other alternatives.

In the interests of expediency I'm fine with that.  (To be honest I'd
forgotten I even made that comment ;)

Jonathan

> 
> I do hope we can get this queued up for v6.8 though.
> 


