Return-Path: <linux-acpi+bounces-21132-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ++HQC3nWmQRQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21132-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:34:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 591401886D9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93DCE3050CD0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5339B4AF;
	Tue, 24 Feb 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3QnLlmB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5537D11B;
	Tue, 24 Feb 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943650; cv=none; b=Rgp1jukLq36tCUBQj2VyWvl1RfcwC58U1hz4n9YsPa9Pqls0cuvu3YBB7rUg+hDb34bZ73u/AVGHNu8yjj622vCBa0s3W40S4+f/zw4H5zDrcS7jZngg8c/bq/sX7R685Z9R9xbd0hJX7EWjnGkBTrtz4AWp5B+jePmCDEQhaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943650; c=relaxed/simple;
	bh=5F+vnZ1VuD84J+7VSx1ZY8xK3RKCBrptOXXP0CN9TWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYxieVPnTMycec8yRtnYTWI9JZnrpO7HNKSMfpHOGkNDjqhUxCai8S4oudk8gVq2Pm3TV55XtTq1YuRGkQir6NGeGvxMGG06SuZT5TcjpumnJId3I4Jt9zjGDZwus1lLQN8BLjsX5uU8AF4XwlkJx1EuaiLzAdtiphscC/UHVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3QnLlmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B8C116D0;
	Tue, 24 Feb 2026 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771943649;
	bh=5F+vnZ1VuD84J+7VSx1ZY8xK3RKCBrptOXXP0CN9TWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3QnLlmBsmChL4tZVWU92z2BRSwWYinYvF14ObFwR1L6ODEHWAqeQnokAP0GZpJbQ
	 610Sho/QoWZRCqEayrnuPD95WlRhkTEjtD1qDvXwq+8LCGffo9ueHHIeoN4PSiU5kv
	 wBP5DpT8qhp9+p+wtfY6yBR+vzwCoi41MjRBj/yY=
Date: Tue, 24 Feb 2026 06:34:05 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Message-ID: <2026022414-splashy-reburial-fae6@gregkh>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
 <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
 <aZ2vQm3cQtBrmqMO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ2vQm3cQtBrmqMO@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21132-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.linux.dev,gmail.com,linux.intel.com];
	SURBL_MULTI_FAIL(0.00)[linuxfoundation.org:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591401886D9
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:01:38PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 24, 2026 at 10:05 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Feb 23, 2026 at 9:44 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > device.h is a huge header which is hard to follow and easy to miss
> > > > > something. Improve that by splitting device data types to device/types.h.
> > > > >
> > > > > In particular this helps to speedup the build of the code that includes
> > > > > device.h solely for a device data types.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > But why do you want to move the struct device definition out of device.h?
> > >
> > > Because it's a data type, and we have many drivers that may require it
> > > (embed the struct device), but no device.h API is called directly —
> > > only via a certain framework).
> > >
> > > device.h also includes many unrelated headers in such a case.
> > 
> > Why is this a problem?
> > 
> > Could those headers be moved to different header files instead?
> > 
> > device.h is mostly about the struct device definition and the other
> > stuff in it is more or less additional.  Why do you want to make it
> > the other way around?
> 
> It's a common trend in the kernel to split out _types.h and _api.h
> (among possibly others). I follow this trend with a correction on
> the folder versus prefix. That's why device/types.h.
> 
> $ git diff $A..$B --diff-filter=A --name-only -- include/ | grep _types.h
> 
> In v6.19:
> include/linux/fs/super_types.h
> include/linux/irq_work_types.h
> include/linux/ns/ns_common_types.h
> include/linux/ns/nstree_types.h
> include/linux/rseq_types.h

Please no, let's keep things simple.  I only split up device.h because
it made sense for the class/bus stuff to be out of it.  Let's not just
try to make things even more fine-grained for no good reason (speed of
builds, size, etc.), which I do not see justified here at all.

thanks,

greg k-h

