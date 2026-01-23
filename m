Return-Path: <linux-acpi+bounces-20579-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE2PENI0c2lItAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20579-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 09:44:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A772AAA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 09:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9421A300A634
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF433030F;
	Fri, 23 Jan 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOga/W/m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D5320A31;
	Fri, 23 Jan 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157755; cv=none; b=C5tCiEZSvorASv/CELjyGIqXVWkeAAKGRkOcvI/y+ENUw1uweXFvlvAXQeyVdizUYOq4ErzYLKgLt+8P+ZngLXkALUfPB7RrQZ7Wnu028SJixnGTftNWoNvrSyBPokgBSabxIBqKjWBcLzYEQRSxLPfZ3hyD1amddFE9GCh9a7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157755; c=relaxed/simple;
	bh=S/zXxDEYmCUkDscKgbWaYUEDm0jge4sk1pPwprWhnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmYzIlm4e6ae7XTWvXcJTE9wJiaWPU81l8RA1CXUWqPgHwoOMtAYA0IS4QhoDPZ/sTzh+rXUF0ikAuyohBMhG5iG/JJ6Ge70x2jmGALw0m/zGSc4Wj31cCb2mOof5DqWDJ3PYsqAYjuz59FZhy/9xfP1dXCEwIw2ANjyQwuQcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOga/W/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED97CC4CEF1;
	Fri, 23 Jan 2026 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157755;
	bh=S/zXxDEYmCUkDscKgbWaYUEDm0jge4sk1pPwprWhnbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOga/W/mDRkFC6X9CJ0Qbt/kQOExGTnEQQibfgW1GLSexg5OeqDhJML8FE0IKLTSX
	 6lvobBcB+PepvPcoVO9JQ9Y453OzTJpkEP0rHmtxKbO1HTva4fmV7SQAV4hsSr8Ld4
	 akRsQGML8xCDbnrGyFQ3T3RCop/s2ap29sHDD/BLyFjXridmr4q0Kg2W0OkNVN3xbq
	 ufF2jS9hnvZ2HmehQSk131jzS+sPzfhkeEKaYccwo6Srq6NoO45wiLaIVJ1GfzHb45
	 h97opOnbERX31UuZ3GeIAXoqV1/IoN7EB9GkP5fN/7IsIa6spdsTVv170XcaIKaBIt
	 gaLigMDagTDFw==
Date: Fri, 23 Jan 2026 09:42:29 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
Message-ID: <aXM0dVthp33yUqj8@lpieralisi>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi>
 <87sec30yhk.ffs@tglx>
 <aW3pALPxn4i9fiDO@lpieralisi>
 <87pl751zeh.ffs@tglx>
 <aW9V4A7lTGZWTO9e@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9V4A7lTGZWTO9e@lpieralisi>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20579-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lpieralisi@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 976A772AAA
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:16:00AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jan 19, 2026 at 02:54:14PM +0100, Thomas Gleixner wrote:
> > On Mon, Jan 19 2026 at 09:19, Lorenzo Pieralisi wrote:
> > > On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> > > I think the simplest way to sort this out is for this series to go via
> > > the ACPI tree if that's OK for Thomas, given that the ACPICA code will
> > > go via the ACPI tree anyway and there are other dependencies on it there
> > > I assume (this series is fairly self-contained).
> > 
> > I'm fine with that
> > 
> > Acked-by: Thomas Gleixner <tglx@kernel.org>
> 
> Thank you Thomas, Rafael I hope that works for you too, please let me know
> if there is anything I can/should do.

Hi Rafael,

forgive me for another ping, can you please let me know whether you can pull
this series on top of acpica changes for v7.0 or it needs to take a different
route ?

Thanks a lot,
Lorenzo

