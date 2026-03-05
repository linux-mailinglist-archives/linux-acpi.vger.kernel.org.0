Return-Path: <linux-acpi+bounces-21385-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBeMM+DoqGmfygAAu9opvQ
	(envelope-from <linux-acpi+bounces-21385-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 03:22:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD520A297
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 03:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A686302BB93
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 02:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B82550D5;
	Thu,  5 Mar 2026 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gXXxoh4x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7A221FD4
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677340; cv=none; b=lTz0HZsQJ1pc+rAKgdpkOKeGwYwjxYxMpVXLjcb7heotzt8WUFCNUGe9J8uT/vZGaOQJsLirZXc8f55AML7js74KZ2eiOLEVrxMqjIfGI1d6jgr1BinxY+Ghx5VJKWXgR3Gq+FoRU1ZPOctoKSmRnaDnyStjItCeah6xRogfXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677340; c=relaxed/simple;
	bh=zqyUE8ffG9X8bHUnSyJPQ+Mf9wAHerQ/TkcQrDVQKQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACzm+6mmyP8NJnNde31s0EdH6LCeRCxCmQA/Ki4YDmfitngPBa0EIlCWN1iKZuZmePdoYVYee/B0FH1avXSu2vFOUAWU4XyQcBmPUcLT6+ba4f/tUMFNntIC2NeNxkOUIw5ElvtYfPPz/SV8q2+bYpQjg/0/nBnStuEubTEkM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gXXxoh4x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a1347051aso35929456d6.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772677338; x=1773282138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUN/Lua8rzSBEA2ypk126i9wj33RYRzjdqwwBQVrXg4=;
        b=gXXxoh4xhl0T7m+PXdpYmbAwLDYDjPR/mCYhbLkWeLdcBdH7ps/keWTC66xk6xxxaS
         TRZMc5drI7FmZzgtwiKJV5b7HO3c6u6+1Rl/kuTRdp/X67fyE5djT4uwgo5FWPoC1wW/
         lcudm9V9Ck9xX0M2YE2stNM13ii1dF0zt5YsmKvdaynGM3MPiK1vxkod02VekOBJNQCP
         R3amMos6kofztbs3MaOvFkF19DL3KHLGr3GsiqX8SqtdV44VDSXOvyhRMK1aTpmgGih9
         J68Fh8uh58fHpvrxoGy+Mqu5dtcSZ36G77qpXzIB2yIhGhW0b+UqD+TPbrNqeYMNK9aN
         LAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677338; x=1773282138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUN/Lua8rzSBEA2ypk126i9wj33RYRzjdqwwBQVrXg4=;
        b=xRsYhkrP04wJ5g99Glw1sKFgRgN5rEamxa7BexT8BkhEb/LO4NBmdc+9tieaS/7DsC
         nefCWpGXk7TCsLcjQ6TSLqzkLz2CVmx8ieYUqjj0gld7oIQZUkz4dp3ZW2+QOQC2Ghqg
         1bxJGt904gPrHaXuZ/vP+gYMfS3zQyAnMZ/EnR7rDAaEBE0WaQEzgiHkJjprW+UWtfiT
         xmFxWhPyPLy2OZJjWAWqznSeCsO+52mlmh/hOe0zzGeCIAyuVQ25HTXKVXkSYdZ/+/Kf
         g0QGGtYUTeieUH8uQ8DQYXF0TUY7wS3mb+a+41cq+xddzAeNelygrugdlFt77Mo1Pat/
         qCdg==
X-Forwarded-Encrypted: i=1; AJvYcCU5G/VSLgTTcw8pGZyMXMH1KlDJBCuwTgRXJ5QhYMvjr8iI0n5OkgQs8UioFqaowEkGoi8vas3cJZ4b@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUdUaVp41WY3neJB/yHH77bhLR3RpxEljEGqpHF6gOS3JzFL/
	ebAQN5XONqAKkJiy6B1Xq7YJG2RaelNOUHUyr4LXLgM6yIjk64wj/AhjbW4DZXhx/8w=
X-Gm-Gg: ATEYQzxpu3kjRBwnhATmZcVCH4Tpypw7355NZWojz3f5T0yFmue7ULez0HpMxGJQZCP
	LB6p6rmFos29fL/sxq3TBJqLT9l/CgtlA47zdGA8nn3IhqREJRrD+A0SOIHkECv8r95fAdN19UX
	KJB2ScrnL3XcY+Z9fDM7sGs9WSdaitTmseSONY7XS7tTgStTKc9RrcNJR1rcoBbERpF9dINOWpD
	+tMQNVtxCi5HBvcJ5mpoMl+OMceHtjFOp3N30wFvEwRjlApi7+JjtRyKlKWOxtS9DCLqCTno2/W
	Sl6OHN8M0DlczJbh7m9Sucej7zOyuYyM7E60FPtvtrOxx0Ol4rXb9+LeT1Q7KShcCFLPpKMwhfU
	1vhZUmMNq6alN6FzYgLFnmgA2gPSGjsPwRU2Zzqwg4us2oEtuTVkipFcVKltaq7ZfVZCJreP+Ds
	UywNvJWeuLnPBo8PMmuwzZ+ocy0E9AFEHRMa29X/Czhwc9w5jzIGOKLLKWaeHzk/+damqnNyLfD
	ci3jQSKCw==
X-Received: by 2002:ad4:5d6d:0:b0:89a:1441:b7fc with SMTP id 6a1803df08f44-89a19ac8b54mr60687086d6.2.1772677338156;
        Wed, 04 Mar 2026 18:22:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fc95502dsm82713976d6.25.2026.03.04.18.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 18:22:17 -0800 (PST)
Date: Wed, 4 Mar 2026 21:22:15 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: "Huang, Kai" <kai.huang@intel.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajo16gazmWSsXDh@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
 <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
 <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
X-Rspamd-Queue-Id: C8AD520A297
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21385-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gourry.net:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,gourry.net:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:08:36PM -0800, dan.j.williams@intel.com wrote:
> Huang, Kai wrote:
> 
> A small 2 line patch to save a few megabytes of memory, sure. A
> paragraph of context that almost nobody will ever care about on a go
> forward basis? No, thank you.

eh throw it in the changelog *shrug*, i think it's useful context.

~Gregory

