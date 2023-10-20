Return-Path: <linux-acpi+bounces-813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608127D15D6
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE11C20AAB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003422319
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968E1EA64
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 16:41:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F5197;
	Fri, 20 Oct 2023 09:41:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBr1Q0Hr4z6K6c6;
	Sat, 21 Oct 2023 00:40:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 17:41:16 +0100
Date: Fri, 20 Oct 2023 17:41:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: James Morse <james.morse@arm.com>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 13/35] ACPI: Rename
 acpi_scan_device_not_present() to be about enumeration
Message-ID: <20231020174115.0000045a@Huawei.com>
In-Reply-To: <ZTKkWozjprMYLjay@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
	<20230913163823.7880-14-james.morse@arm.com>
	<ZTKkWozjprMYLjay@shell.armlinux.org.uk>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 20 Oct 2023 17:01:30 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Sep 13, 2023 at 04:38:01PM +0000, James Morse wrote:
> > acpi_scan_device_not_present() is called when a device in the
> > hierarchy is not available for enumeration. Historically enumeration
> > was only based on whether the device was present.
> > 
> > To add support for only enumerating devices that are both present
> > and enabled, this helper should be renamed. It was only ever about
> > enumeration, rename it acpi_scan_device_not_enumerated().
> > 
> > No change in behaviour is intended.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>  
> 
> Is this another patch which ought to be submitted without waiting
> for the rest of the series?
> 
> Thanks.
> 

Looks like a valid standalone change to me.

