Return-Path: <linux-acpi+bounces-21165-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKSMF/9Rn2k7aAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21165-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:48:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2A19CEA3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B421303CB15
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE1392822;
	Wed, 25 Feb 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="Allp3uG/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3638F949;
	Wed, 25 Feb 2026 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048887; cv=none; b=I9iramyAVVgFLr+Y+WQQnpeh41kWQnc209v5JzDNvRx61bdmmAdDssWgQoe2ofrhn77xfSsjXuDaAcGD0qPoUYqCVSuFc9bw4HxrcyYB7G9SVhESnlj/XveUs8Yd/pHCO0h4RAhBtpTbTLw5QxilHsUTBljE+kmL9N3c+/ukK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048887; c=relaxed/simple;
	bh=AdBM9t0BFOooUgmfgLTPvzDWan30xVZMvg3PhkgL5CQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=u18tFi8OVwnj3SPTkn15ISCQqRYVWnnT8Ea7uONL3YClIsprArHbsZItsjjFECjpDKAJAfswMsktfJdDDAWU3ixDgnSNlcucnl15f/K8tL20Er4PKyzTRWoC+7EwzwqA3aX8MMC+zeuiBBbumJCKsJ36qSLeT9s+4mQHVK6hcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=Allp3uG/; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772048884; bh=jRWLzYUbPEVN6Hsz2E0zUJwwOaJh/FCzKxXYLAtKWwI=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=Allp3uG/XOYdd/Bf3Wjm9FVncyGWDkg+nq66Kf2Ws5vLFxre1MNm0+qIVkw+BdqII
	 CVl4VUZHSfs3kw0061Sx7BaZN0ftcsPszgwvV7RI3vcE8LRGWY5Fsik6eeDu5AZGrD
	 IcHrcnd5+mjuYQwdaNV+koh2jRE0r3q8cZ4zPAMjQlLHZ7GLKPG+1eYT8GM3z
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
Author: Mike Isely <isely@isely.net>
Original-cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts4-dock4.isely.net (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0003.00000000699F51F4.0000718B; Wed, 25 Feb 2026 13:48:04 -0600
Date: Wed, 25 Feb 2026 13:48:04 -0600 (CST)
From: Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
In-Reply-To: <aZ9K56Q_NHmAYmeu@smile.fi.intel.com>
Message-ID: <80ccd17f-9265-f304-fae0-1250c2caedba@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com> <04eebe7b-0f88-2122-eeef-568117bb8235@isely.net> <aZ9K56Q_NHmAYmeu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[isely.net,none];
	R_DKIM_ALLOW(-0.20)[isely.net:s=deb];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cobaltdigital.com,gmail.com,linux.intel.com,vger.kernel.org,pobox.com];
	TAGGED_FROM(0.00)[bounces-21165-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[isely.net:+];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[isely@isely.net,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[isely@pobox.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:replyto,pobox.com:email,cobaltdigital.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,isely.net:mid,isely.net:dkim]
X-Rspamd-Queue-Id: F2E2A19CEA3
X-Rspamd-Action: no action

On Wed, 25 Feb 2026, Andy Shevchenko wrote:

> On Wed, Feb 25, 2026 at 12:59:56PM -0600, Mike Isely wrote:
> > On Wed, 25 Feb 2026, Andy Shevchenko wrote:
> > > On Tue, Feb 24, 2026 at 01:19:21PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> ...
> 
> > > > This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
> > > > inspection in 6.19.3 source (the latest as of right now) shows the
> > > 
> > > The latest is v7.0-rc1 as of time of the topic message.
> > 
> > I actually meant the latest release.  Guess I should have checked the 
> > latest release candidate on the off-chance that it might have been 
> > addressed.
> 
> It is probably not, but the idea to check against latest tag in the vanilla
> repository. v6.19.3 is not even vanilla, it's stable kernel.

I tend to stick with the latest kernel that is NOT a release candidate 
when building random things here regardless of the term used and that's 
still 6.19.3.  But for verifying a patch, yes I should have at least 
taken a closer look at 7.0-rc1.


> 
> > > > same issue.  The nearly trivial fix was verified in 6.12.  While this
> > > > patches against 6.19.3, IMHO this is a candidate for all LTS kernels.
> > > 
> > > Thanks for the contribution, usually for a single patch there is no need
> > > in cover letter. The comment block can handle this (the place after cutter
> > > '---' line in the message with a patch).
> > 
> > Yeah, a separate cover letter is overkill, but I was just following a 
> > process here.
> 
> What process? I think we have that somewhere in the documentation that cover
> letter for a single patch is not needed...

Documentation/process/submitting-patches.rst in the kernel sources, or
https://docs.kernel.org/process/submitting-patches.html

  -Mike
   isely@pobox.com

