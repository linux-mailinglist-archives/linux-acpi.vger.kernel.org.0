Return-Path: <linux-acpi+bounces-7764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F495A0C6
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802721F23BF0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F21B251F;
	Wed, 21 Aug 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjP4IpRm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD41B2516;
	Wed, 21 Aug 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252401; cv=none; b=aArarHeZKUpDmo2MZYOfyn76UOE6eiZ/IAzlNUMXjqZ/xZz50/0SmwFeeV5qNtJtJHBaRSZ3737uciokwEMDZbsgBPEa1DwbiFzp1SrKAaLcqi0xy8iJWiOiOCoMY90PQV6dBEm91urdba1zkyuyC3sx9t+6inqHYsqbIvk3DGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252401; c=relaxed/simple;
	bh=IBN6ywL7mYkh82/j5VznfLF6ZiKDxwfMVwAbnqTvVlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hseRpfRA7BUUSQx8qf2fZ3mcXq+OxUoYqH7GmrhkfcJAz1QEqGacDr3RMdO+7FIBuAsCpmL9+n4J9nnOhjRDPl6NO26iJwJXiNe0dyIAT3AptZdJS5+zf2EY4VIFY7XZs1j0CjB3FMNBwLiMZd4Hrn3CfafVx4w7ESjKpfbu6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjP4IpRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E858FC32781;
	Wed, 21 Aug 2024 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252401;
	bh=IBN6ywL7mYkh82/j5VznfLF6ZiKDxwfMVwAbnqTvVlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TjP4IpRmrQyy63JtLyx5SlJeP/OGNKmXSdI6LYE+ayq6fxjrkIoDchMWUyvBTxbRo
	 NOzqYvLPKVT0oRHTjQbpsSwBeOH4ZmatOUNaTJXPIvRMzUn95AY4VBod0pT+3fJpfR
	 GXKsc1Ar2SQ+dp3rFdro1yeBZnlsCdVy6BqVMnGzti52CoFgHgxML388qpHmX68Hr+
	 va/fmNM9zrLWGJ7uZZForOWUpR1R8Bbi+aWRPTwWlqHB2YD3Dnmz5wiMLEbnE/Kac3
	 yCZYxMmgZdNoo8PuK9fcD5qzAmo6NwAYJY5uV/bgZCBrjJlpI0LMwXmcp10MfryWdI
	 1apXowugEdYgQ==
Date: Wed, 21 Aug 2024 09:59:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Petr Valenta <petr@jevklidu.cz>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Hui Wang <hui.wang@canonical.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI IRQ storm with 6.10
Message-ID: <20240821145959.GA248604@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b190e352-e11f-4795-941a-62c09ba5f602@jevklidu.cz>

[+to Dima, Vitaly, Hui; beginning of thread at
https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org]

On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
> > On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
> > > Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
> > > > On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
> > > > > On 19. 08. 24, 6:50, Jiri Slaby wrote:
> > > > > > CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)
> ...

> > I'm at a loss.  You could try reverting the entire b2c289415b2b commit
> > (patch for that is below).
> 
> This patch didn't help, so I reverted it back.
> 
> > If that doesn't help, I guess you could try reverting the other
> > commits Jiri mentioned:
> > 
> >    76a0a3f9cc2f e1000e: fix force smbus during suspend flow
> >    c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
> >    bfd546a552e1 e1000e: move force SMBUS near the end of enable_ulp function
> >    6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
> >    1eb2cded45b3 net: annotate writes on dev->mtu from ndo_change_mtu()
> >    b2c289415b2b e1000e: Remove redundant runtime resume for ethtool_ops
> >    75a3f93b5383 net: intel: implement modern PM ops declarations
> > 
> > If you do this, I would revert 76a0a3f9cc2f, test, then revert
> > c93a6f62cb1b in addition, test, then revert bfd546a552e1 in addition,
> > etc.
> 
> I have created revert patches like this:
> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
> /dev/null > revert_76a0a3f9cc2f.patch
> 
> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), then in
> addition revert_c93a6f62cb1b.patch and after applying
> revert_bfd546a552e1.patch irq storm didn't appear.
> 
> I have tested it with 3 subsequent reboots and in all those cases it was ok.

Thanks for all this testing.  It sounds like reverting all three of
76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
I'm not clear on the results of other situations.

It looks like c93a6f62cb1b could be reverted by itself because it's
unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
all three in case they have any insights.

Bjorn

