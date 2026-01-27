Return-Path: <linux-acpi+bounces-20670-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIcTAcjoeGmHtwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20670-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:33:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB597CD2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D7E930C15BF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D535B63C;
	Tue, 27 Jan 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+NmGJWw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791813043DD;
	Tue, 27 Jan 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529643; cv=none; b=VKcLhP+BT0WrsvqzHoDiCLw0fkoXtBNMqsVi45uAW5CWAS/mGjucwaDTmSLRvEmuoJ7pD83wrGulWZpUX4bK92xDSmo9OffMWAsyLXYJu9BNNb4S1pXV65v64RLf2NUAbhD1Jq8Ts+MG9PpgUqcLWZA8IyNQMDs+CjuyFHC4nLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529643; c=relaxed/simple;
	bh=GL3r4IUch63E1Hws6G4NyZXWNGB0D5+RIlS/11RY3wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwdrWGzhgE/g7gJJNKdO3ZPEgVjtjrFPwK1rPfcy8bcd2VKhFBfTv3kod4wqVDeTyWHhq8Tk75oThc/SJkuAlmu65sjvOVhIEkWun+KWws5fGPFNRbj0is3kqWL3yeb9s1FOpAJtU3xJII9fLALepl0n8RtJrAqy1e9VKaK5z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+NmGJWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E7C16AAE;
	Tue, 27 Jan 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769529643;
	bh=GL3r4IUch63E1Hws6G4NyZXWNGB0D5+RIlS/11RY3wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+NmGJWwoJZyOaNEy/B4GduCpN1U1HaNnZnmac9IdYSuotNZsWMxqH9Md0e7oR0Ot
	 pL0DM0p4zyI8DzGoF0LC/iUB2OWPfoLu1UaxUjVgmA+2/sHXqqUjvxCix/YIvr+JPh
	 zq9ulEST1QOwE9H4wdq45x+fD3DBXCcVM2HU6P8x5jXCp3RpfThiyBKVtTxQedSeF7
	 JbShNuba7/mDH4AmJ25mTbwUV1tZCuUqiGmhtT+hRgvgHw1d6PJ1ho3rRIkvKtQ5pY
	 lZksbsfHPkRkruYYLmYMqwiwTqpFsSlQR1tmGafJ9jmyOZB/aP0Z3+zN5R6vm5U1II
	 mM8KWcTH9g4HQ==
Date: Tue, 27 Jan 2026 16:00:39 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>,
	Yuntao Dai <d1581209858@live.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"mailbox@lists.linux.dev" <mailbox@lists.linux.dev>
Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Message-ID: <aXjhJzfHvxrP-zc7@bogus>
References: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
 <aXieA6vpJEUvEKRe@bogus>
 <PAXPR04MB8459042676EF3E77D71C19428890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84597C134FA912B4C929E11D8890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB84597C134FA912B4C929E11D8890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20670-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oss.nxp.com,kernel.org,gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 23FB597CD2
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:47:33PM +0000, Peng Fan wrote:
> > Subject: RE: [PATCH] mailbox: Clean up the usage of mailbox_client.h
> > 
> > Hi Sudeep,
> > 
> > > Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
> > >
> > > On Tue, Jan 27, 2026 at 07:02:53AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > mailbox_client.h is should be used by consumer drivers, not
> > mailbox
> > > > provider.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
> > > >  drivers/mailbox/cv1800-mailbox.c     | 1 -
> > > >  drivers/mailbox/omap-mailbox.c       | 1 -
> > > >  drivers/mailbox/pcc.c                | 1 -
> > > >  4 files changed, 4 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > >
> > > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c index
> > > >
> > >
> > 22e70af1ae5d14e6e8c684fe032c2864f6ae4d6c..6ca84596e7637114f6
> > > 6d32a95d12
> > > > c863e942b756 100644
> > > > --- a/drivers/mailbox/pcc.c
> > > > +++ b/drivers/mailbox/pcc.c
> > > > @@ -55,7 +55,6 @@
> > > >  #include <linux/log2.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/mailbox_controller.h> -#include
> > > > <linux/mailbox_client.h>  #include <linux/io-64-nonatomic-lo-hi.h>
> > > > #include <acpi/pcc.h>
> > > >
> > >
> > > There is a call to mbox_bind_client() in pcc.c that is declared in
> > > linux/mailbox_client.h
> > 
> > Thanks for raising this.
> 
> Check again.
> 
> include/acpi/pcc.h includes mailbox_client.h
> 

I see, I missed that. I’m fine with removing it, but the commit message
doesn’t really apply here since it’s getting included anyway. I don’t see
much point in removing it, but I’m fine either way.
-- 
Regards,
Sudeep

