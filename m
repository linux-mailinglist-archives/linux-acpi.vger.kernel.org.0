Return-Path: <linux-acpi+bounces-20635-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBkoOFvSd2mFlwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20635-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:45:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434868D3B4
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6FA3014966
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 20:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6D2D7D47;
	Mon, 26 Jan 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od98iYzi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24E2D77E5
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460188; cv=none; b=KSZybnEoat+fwJnE96+o5/8d370jS4bRbssp9kzS3FkIm0UKnH3tbv3WNAC1wv7CjsWuGP79ohE5VM+5aPN4wiKs4rKGH0jTk/hC1T3bNcbdNh3a4Qm6vhgogENj30L3vaTwG+QidAyFa2R3UBGVMOC1wu6Tk6y0/q7uTynQbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460188; c=relaxed/simple;
	bh=qkLYQ+xttW3yQLEX/26eoBKkIwpMcw+WYxW9ZXrxbR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXcMtKKnzNlyKdTlygo2W8lYGlj8C8QW4MSOm7VeHKkMT0Z01zG0GaPCYHLA7xG8eukwbkFSacj4fbwQQNMgS4CuMUIrQn0u6/KMZ7YOvr/zTVjNzs3NJhPFGV/M4Ve2UHTbH8qAeHUrGBDzVfQYhDlF6S5sqeq6ZeylhdSgvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od98iYzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD90C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460188;
	bh=qkLYQ+xttW3yQLEX/26eoBKkIwpMcw+WYxW9ZXrxbR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=od98iYziNKyiPtw8ldGa9AyuAo/5IjH4LBM762m+6AteHKURno1rOT9HT2tPLdM0M
	 CKo8bWbdU0wMVUWUZQgzTt0YIAXyxe+cdbigJKeDVTqKXXtqQG7sUubHaDVRWTVFkw
	 HoCDuEH92ptJ2VJoJ6e88NLVR8wgfmwk5xfwxTvPoAXwfm+xZgVFzvpk2Xjb4JjtNw
	 HfafeejKzSRGX0sIKoJd2t5qr4YQJa46eaZrslKGq472pKZgqd9T1tDnwjhDtgpe3H
	 YCGJGxVLjyE/0II9IMo89i42MoUc9jHWH0/8cXRqOdEkJ9VzOKi/Tl+vlgN6ZY0Ala
	 GM9wTYG9h2KHg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40438380b88so1253833fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 12:43:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4Dc3PULozyEhv19A0yZID70WCaISJYCapAAMUjqxBYDpN5VnQcYy74C+pMiPCUcFYUFK+W62nlaV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRFBKT2eO9XgmmcyqqtGYMmaYCUcgd7l+yxS2OXyqPHd5s/Yt
	jBs3YhXkd1brY20L1xM0SRbSGcbghgmDWQck/9elIGpg/ipYQ3hPyZkFUaXagPbYeV8jfXyyjkJ
	51y7e3l4kSB3amyj1GOcnkmFDfa3HjVU=
X-Received: by 2002:a05:6820:4dcb:b0:662:c114:b29e with SMTP id
 006d021491bc7-662e02de9ccmr2478764eaf.24.1769460187481; Mon, 26 Jan 2026
 12:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi> <87sec30yhk.ffs@tglx> <aW3pALPxn4i9fiDO@lpieralisi>
 <87pl751zeh.ffs@tglx> <aW9V4A7lTGZWTO9e@lpieralisi> <aXM0dVthp33yUqj8@lpieralisi>
In-Reply-To: <aXM0dVthp33yUqj8@lpieralisi>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Jan 2026 21:42:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOVO7N77nnyWsh_vhGcm-TzavrGBgci=a+o_-LKhkuXg@mail.gmail.com>
X-Gm-Features: AZwV_QgIu0Sq3ZvSpiujHJcegyl-N4Pxcc67Z0kbWXZrvS3aL-fZTGN44hcX9YU
Message-ID: <CAJZ5v0hOVO7N77nnyWsh_vhGcm-TzavrGBgci=a+o_-LKhkuXg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20635-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 434868D3B4
X-Rspamd-Action: no action

Hi Lorenzo,

On Fri, Jan 23, 2026 at 9:42=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Tue, Jan 20, 2026 at 11:16:00AM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Jan 19, 2026 at 02:54:14PM +0100, Thomas Gleixner wrote:
> > > On Mon, Jan 19 2026 at 09:19, Lorenzo Pieralisi wrote:
> > > > On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> > > > I think the simplest way to sort this out is for this series to go =
via
> > > > the ACPI tree if that's OK for Thomas, given that the ACPICA code w=
ill
> > > > go via the ACPI tree anyway and there are other dependencies on it =
there
> > > > I assume (this series is fairly self-contained).
> > >
> > > I'm fine with that
> > >
> > > Acked-by: Thomas Gleixner <tglx@kernel.org>
> >
> > Thank you Thomas, Rafael I hope that works for you too, please let me k=
now
> > if there is anything I can/should do.
>
> Hi Rafael,
>
> forgive me for another ping, can you please let me know whether you can p=
ull
> this series on top of acpica changes for v7.0 or it needs to take a diffe=
rent
> route ?

Sure, I can queue it up.

Thanks!

