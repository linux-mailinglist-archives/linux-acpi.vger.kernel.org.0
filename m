Return-Path: <linux-acpi+bounces-21299-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBrBBByXpWmPEQYAu9opvQ
	(envelope-from <linux-acpi+bounces-21299-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 14:56:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7801DA36F
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2970305018C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2026 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BD3CC9EC;
	Mon,  2 Mar 2026 13:54:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE02267714;
	Mon,  2 Mar 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459668; cv=none; b=mPYgt60yj8zLT3CUyIceQXkL18XPzQti1qsiXCWosiRZqHAJv83YvZSKjvVIVH6qhP1svVkLshvykEFJ5G4JVCz1hlpYGEdy3ygQKhpf7Dx5o2tK02RMrdG/zrQZRnI6MnU3HOskjd+/d1+e3kYhH3WLbZ2rstElezUU48rW8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459668; c=relaxed/simple;
	bh=nxoRpTYYzUPLegGVagNHODUnxFoBxuiOigsD0RQ/cLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8xA8EqA57HvWWxxnDc/R+qfYp95ub8lpCeYBFokkfQXB5aRhikXM2genD7l9Ap7b1OeXzfC8A1mtoLhEOF+ZkiRs2sbFyUaWbfpZP3RAXfWnxYA/no1BnucYrX8O1YhJa8pNnpt0jtzFtD9STvnpqn+/gzw+aU1tbM02VL951Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 622Dd7pm022192
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 3 Mar 2026 00:09:08 +1030
Date: Tue, 3 Mar 2026 00:09:07 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 0/5] platform/x86: fujitsu: Bind drivers to platform
 devices instead of ACPI ones
Message-ID: <aaWS+4jXPfec5fTG@marvin.atrad.com.au>
References: <1968442.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1968442.tdWV9SEqCh@rafael.j.wysocki>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21299-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[just42.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jwoithe@just42.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.001];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE7801DA36F
X-Rspamd-Action: no action

Hi Rafael

On Wed, Feb 25, 2026 at 09:41:09PM +0100, Rafael J. Wysocki wrote:
> This series is part of a larger effort to switch over all drivers using
> the struct acpi_driver interface to the more common struct platform_driver
> interface and eliminate the former.  The background is explained in
> Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
> the patch that introduced the above document:
> 
> https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/
> 
> The bottom line is that the kernel would be better off without struct
> acpi_driver and so it is better to get rid of it.
> 
> This series carries out driver conversions of the platform x86 drivers
> for Fujitsu platforms.
> 
> Patch [1/5] converts the fujitsu-tablet to a proper platform one based
> on the struct platform_driver interface.
> 
> Patch [2/5] rearranges the code in the fujitsu-laptop driver to avoid
> introducing forward declarations of some functions in the subsequent
> patches.
> 
> Patch [3/5] updates the fujitsu-laptop driver to install ACPI notify
> handlers by itself instead of using .notify() callbacks from struct
> acpi_driver, which is requisite for the driver conversion.
> 
> Patches [4-5/5] replaces two instances of the struct acpi_driver
> interface in the fujitsu-laptop driver with struct platform_driver.

Thanks for preparing this patch series.  It looks reasonable to me.  At this
point I have nothing to add.

Acked-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan

