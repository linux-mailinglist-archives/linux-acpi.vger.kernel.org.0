Return-Path: <linux-acpi+bounces-8151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63A96C4F5
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05AB1C251E4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76791DA312;
	Wed,  4 Sep 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E4JsxPd4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1131773D;
	Wed,  4 Sep 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469837; cv=none; b=K8xuaO/yLjxRGBt1xWo65BPFKxDHfrkmxcu56M7Eq5teH2HYQe6ilUraXsF6r3yo8QgCDI+qcGDE10b8u3ABQnh3dAoNzrWt33ch+bGndAn/c7Hc3bP2678HDHgSQNE4y0poucHO8Dq3Jby9u3TwBjfEuk0Z7Jcg8PC6lcIRMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469837; c=relaxed/simple;
	bh=+iw6SJbuQLqMyA/j28gVyW1sD9jwgRXSs01S/unl9ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmC+/ocoarDiP17AXsgAIzKlpLw4ozk5GnUspJiwDVPwvRj5r+zHtlNJ0ilA1DzsB0gaSbs7j0i13eK32rVhfdlaopniDzvmKsqxAZiwOTG8VR93Gn0TuZ7bRbHkjPZ2+TmifrR/a4yact3VzGfyTKUI1OyffsIYAwrUu2Xu0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E4JsxPd4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725469829;
	bh=+iw6SJbuQLqMyA/j28gVyW1sD9jwgRXSs01S/unl9ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4JsxPd4Aj4R1zLrMME0gtNt/7+mThhmTmqhXfKluk0He/QDcws7ia61MKhLa+lJA
	 g1DCMvXQDi5+vTZiKAQr1yA6gMDLZ+PJ/JmxNCgVM/XgCWq9akA09UTUziuFvoH9pR
	 GX3L/fuqx94l14xMCNa/ga3oE+qUvETknSpUxPwg=
Date: Wed, 4 Sep 2024 19:10:28 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ACPI: battery: various cleanups
Message-ID: <f37e0a41-6045-471b-a902-7546f2fa5d1c@t-8ch.de>
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

On 2024-09-04 14:44:33+0000, Rafael J. Wysocki wrote:
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

Absolutely, it's not urgent in any way.
(The same for "ACPI: battery: use driver core managed async probing")

