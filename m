Return-Path: <linux-acpi+bounces-6240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13A8FF487
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35405B2295B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318B199381;
	Thu,  6 Jun 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XHRm6rwC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B922110E;
	Thu,  6 Jun 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697955; cv=none; b=sL7B0xlDx0Wq5c4ftyC25fwVP3boFWb0w6trKqPF7xHwvaCgtqipcrLSWjC4TuQ8AR4QYmONfRudgilXCn8ATZfVPaI5NZuHK3ILNbcVEqHBeQr/3q59AdMlGaIaAbcOxse/MBTagkTzrcI1vUdpPAU22ypeDT5LDMjv5R/WkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697955; c=relaxed/simple;
	bh=7l/9m2A69mnEewixzR4lQaoYU6S2P+mVA/9ddRZfgF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O64DOpVdBwZJAzIJUpgvdpyslDA9ZMFrIuHAQadiyj0vlNVqVfsZi9djnHflQIRUnTROyIp88zWu1id1b3uRwtNNIT1mJTloOBWcntcI78tiqS21YmErxpmirxy5DpkdL+ldxcdE2EfbibiSQJ2fVilGXht1KLVdjEsMmPfJBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XHRm6rwC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 665309e4c6a46bd9; Thu, 6 Jun 2024 20:19:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 851116A65D3;
	Thu,  6 Jun 2024 20:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1717697949;
	bh=7l/9m2A69mnEewixzR4lQaoYU6S2P+mVA/9ddRZfgF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHRm6rwCYQzUSYHD33mtzMe/s+iwXg/3mJvahkvc467O8uTfnUUWEAVj1Cf2p1eRP
	 AUCzrIa1vtMbUPeJyUIGQFgBk+ZVeMK+gaof3GKv6WOH87XkHChNqgsivq80j0vqbi
	 03biuv84PC2EllChhnSdROzIzkz0ZcfvRAoycYSZSdYx3t5DSxqoZXcJzqDkAeHcoT
	 tTqb7fCCO579PbRLzFYilqCFW4tsPr5mWjFEYe8qOhEy2QBdCZq/HfkBMsBe4v0dpF
	 DXxUQ1XfNTVY8RLEJONqO2MeZsjSjkIF9CTS0jFDmyaxMqU3VCOa17yxDzHmeoIadS
	 dCR0SKXtHmt0A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 Re: [PATCH v2] thermal: core: Do not fail cdev registration because of
 invalid initial state
Date: Thu, 06 Jun 2024 20:19:08 +0200
Message-ID: <4931647.31r3eYUQgx@kreacher>
In-Reply-To: <a5476bdb-da6f-40d5-baa9-fa2caea72e3d@linaro.org>
References:
 <6056838.lOV4Wx5bFT@kreacher>
 <a5476bdb-da6f-40d5-baa9-fa2caea72e3d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghurhgrrdhnrghosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

On Thursday, June 6, 2024 6:39:02 PM CEST Daniel Lezcano wrote:
> On 06/06/2024 18:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> > device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> > to fail probing on some systems which turns out to be due to the _FST
> > control method returning an invalid value until _FSL is first evaluated
> > for the given fan.  If this happens, the .get_cur_state() cooling device
> > callback returns an error and __thermal_cooling_device_register() fails
> > as uses that callback after commit 31a0fa0019b0.
> > 
> > Arguably, _FST should not return an invalid value even if it is
> > evaluated before _FSL, so this may be regarded as a platform firmware
> > issue, but at the same time it is not a good enough reason for failing
> > the cooling device registration where the initial cooling device state
> > is only needed to initialize a thermal debug facility.
> > 
> > Accordingly, modify __thermal_cooling_device_register() to avoid calling
> > thermal_debug_cdev_add() instead of returning an error if the initial
> > .get_cur_state() callback invocation fails.
> > 
> > Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> > Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> > Reported-by: Laura Nao <laura.nao@collabora.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > v1 -> v2:
> >     * Instead of making the thermal debug code effectively ignore the invalid
> >       initial cooling device state, simply don't register thermal debugfs for
> >       a cooling device if its initial state returned by the driver's
> >       .get_cur_state() is invalid (Daniel).
> > 
> > Laura, please test this one even though I don't see why it wouldn't work for
> > you if the v1 did.
> > 
> > ---
> >   drivers/thermal/thermal_core.c |    5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1001,7 +1001,7 @@ __thermal_cooling_device_register(struct
> >   
> >   	ret = cdev->ops->get_cur_state(cdev, &current_state);
> >   	if (ret)
> > -		goto out_cdev_type;
> > +		current_state = ULONG_MAX;
> 
> Why not move the section ? So we end up below.

Because it's fewer changes in this patch and it doesn't matter.

> >   
> >   	thermal_cooling_device_setup_sysfs(cdev);
> >   
> > @@ -1016,7 +1016,8 @@ __thermal_cooling_device_register(struct
> >   		return ERR_PTR(ret);
> >   	}
> >   
> > -	thermal_debug_cdev_add(cdev, current_state);
> > +	if (current_state <= cdev->max_state)
> > +		thermal_debug_cdev_add(cdev, current_state);
> 
> 	ret = cdev->ops->get_cur_state(cdev, &current_state);
> 	if (!ret)
> 		thermal_debug_cdev_add(cdev, current_state);

So the current_state <= cdev->max_state is actually useful regardless and
consistent with the analogous check in thermal_cooling_device_update().

> Additionally a comment here to explain why get_cur_state can fail and 
> telling it is up to the driver to fix its routine?

I've added a comment in v3.

> 
> >   	/* Add 'this' new cdev to the global cdev list */
> >   	mutex_lock(&thermal_list_lock);
> > 
> > 
> > 
> 
> 





