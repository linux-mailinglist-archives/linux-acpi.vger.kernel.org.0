Return-Path: <linux-acpi+bounces-8564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C73991512
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820EC1F235FC
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB67130E58;
	Sat,  5 Oct 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cUJLzkw7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC938FA3;
	Sat,  5 Oct 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728113267; cv=none; b=Xf6wqd9Z2COYhBKv0y2g75NC2QJ3QWkgYSJ799X7EYBY2TdMEmV6OGOU24jxTdnE9Ll2baRa86IWY9UUOF9k0NMEBVBLJvRSc/Y0+APVx6pPSt3PRDRsaaiLJsxnCPa8PHJf4o5ZqjHkhObGZNbhAU5TFgtSPPWNag9E0eOpsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728113267; c=relaxed/simple;
	bh=u6y4rqMNtM7ovI8kHlo2HcxRrkKbSyB6NS2RSkw3T0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0tZcLgmo5pXq9QrZ/PsuP7mwrhFBddC6+L/83J5Qsi7S9lXDM1QNsF/1Em8tJVIXoqR80i96ycfWILA9b1OAt8Hu3Qyct2FtNaOBCXmwwFccf+FQHiMQltuDL7PyZoFJ7ks17wJ7DgsAJpi0fxoHYrcHfdtUO53bxCT5r2r8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cUJLzkw7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728113256;
	bh=u6y4rqMNtM7ovI8kHlo2HcxRrkKbSyB6NS2RSkw3T0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUJLzkw7M6adu+mXRkAHxxctWVXQmn6vQnqKnoDhcXuhe/gStlgoGzyDFDJsPuPY4
	 tPp/0jrJ+AoUm06agogpvvR+NqyKv6EyAdikHCWD/FQgdtcmLppXUHe1HJcqNi5Ofs
	 ZBCCjVWcqNGQR/MEXDD0buHpOakea2k7MYN2dM44=
Date: Sat, 5 Oct 2024 09:27:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ACPI: battery: various cleanups
Message-ID: <8291a067-cd9c-4fcf-b32d-0064f3225836@t-8ch.de>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
 <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com>

Hi Rafael,

On 2024-09-04 14:44:33+0200, Rafael J. Wysocki wrote:
> On Wed, Sep 4, 2024 at 9:13 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Thomas Weißschuh (5):
> >       ACPI: battery: check result of register_pm_notifier()
> >       ACPI: battery: allocate driver data through devm_ APIs
> >       ACPI: battery: initialize mutexes through devm_ APIs
> >       ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
> >       ACPI: battery: install notify handler through ACPI core
> >
> >  drivers/acpi/battery.c | 41 +++++++++++------------------------------
> >  1 file changed, 11 insertions(+), 30 deletions(-)
> > ---
> 
> Since it is a bit late in the cycle and this material does not appear
> to be urgent, I'd prefer to defer it until 6.12-rc1 is out.

6.12-rc1 is out and other patches have been queued.
Did this one fall through the cracks?


Thanks,
Thomas

