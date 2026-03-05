Return-Path: <linux-acpi+bounces-21391-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIMCNPYiqWkL2gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21391-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 07:30:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082F20B9AF
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 07:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB6A303CEBF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0892EBBAF;
	Thu,  5 Mar 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Qlh2SUmX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A22EBBA4
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692209; cv=none; b=oDLGAKsPHOukKS4EwMAOns01z4NuEgwI0WqtHaRn0NALoadmrFfX3wYc1iHCqDxd2daY4sn5qNeSG85tvfKoMDJpgKruhHzT8Z9MKSDaDpEpv646uO3BnpAPJTaO6Wki0J9nmDb3eQ6LSesVyGAxlDb2hY4vMKwh5Au/czrmxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692209; c=relaxed/simple;
	bh=RSYeVVB5gM+WAo2d3lVU4OBg2ZhjPkwL6PcMWE5Z8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyQKgh274fNR9C1hzRNdJo472B8NfV0HsiGYAMGsgwwS6sYMITIyq7jNvNghDdlOjDKuA17ecreTAUF+0hQzH7e1W0tduLArSxQ6BqE88utxmiEJCR95P942lvW9IJVvQvTlm4hKlBQx3qFtwXhGct+MW4aIUJlSx/phCxeReDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Qlh2SUmX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb5138df1aso744306685a.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 22:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772692207; x=1773297007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc+lawyKza1Txu1nyRU7GMN4VIjut5I8Whyb42/urzU=;
        b=Qlh2SUmX3TjK+3kt62gUpaa6Syl3n+TI80xjXeZxQscfizvUAwsJEveZs0gCxjKtZr
         N3vy4eVgp476tFdCBlkD3QnsJ7bkBHU0hYPX+48cKqTRzV7xi/8woaaMfCtifAeK4qIV
         cz+Bx6fexk1//5qW1TYiwZi7Pwlwjp9FwHW3fSc72IEdLJrpHXzmBvS8et4TnzDQGqPI
         eTgWd3N3DCRHjuJb53U6xhI1CSQoa1JvUSG/TjlECkQ5PGZ8ebVXMQ7ge7JiWcADoEAv
         huBqbOYA+LrN3pRWtUZXpihMaBROEikQ3/0x6OB9GJKOtiKaZI9qDxF3MVDG4a2BHBtI
         o/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692207; x=1773297007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc+lawyKza1Txu1nyRU7GMN4VIjut5I8Whyb42/urzU=;
        b=awBN8Ks30NMQ5nMXQEdwhWUtAN8rhdjpBQgh1I3A2A4uVNLOuy13H5hcqzAYe/ofXv
         K95QgN1iBMAaVwAqySMwAYp1yPbDwZbSusGH/TMphilZETcoz69L3Fw/iYPGIYPuYKrU
         RyfVRna4i+JEcbCQA0BtSzNnc9pMCeP2PZ0NR0pj5j/TgRI8+O79UYY8KJSnH9IU5B/E
         2lyq+Mx09nCatxSkkHp96xNzpa69Ql2NFSbvWEgTSNequzm+2BqI24S5Lah4e3aVk8dW
         Zm/Nifm9LwJ7ben0KbZvxGASXB1Ra8glkYWsnJ1F5+ug4nHUy795BPWenoU3KiqoXePM
         fjJw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DBDu+aM4qDU3aNCoYLFieGrJJ07IESig0hRU7i4va0y3UplW72LmOOW9vyqyQAAR6b6nXzQg43xW@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpD+9UIJye8qp0jROXEmxps8r90qopU2dXZuvrgEWKCd8/HNr
	cUyutVtYT1+zbhcsFsQ+r1kLySO1XqofwJJhCXMRDlITTmzq1YZr+6E6UWvxKKpBB4g=
X-Gm-Gg: ATEYQzwTxbANyX2eFGTwTaxEGUImOQVhTORWxynJiIUh05ziuf6q5MwaZzQglc6WYqT
	ap4XNUhAQRyQNm/pxPkPA3M+7jGwE0dSK2Q/jG0b/few028ctBJE2t/XVxpAEdIaEDTVDwdUp28
	Zb+dXpglj1XAQPyKe7CBaEEB7ROV0+mW4xhrspaX3BbEmtuTlWMfuw97bWsQwLEXYVrKDq4GzR1
	WnUzmIZHPsoyiRQ8UHZyh7y9FR63/g5zCI0BzoJi9wS4WXlxhtLe0Wh+gB1M7hh5YVe64be38o7
	vKbfBNTkEjnJMSwNWFf920dhuItxWDibYVASjZgPHzpxGnqUeqUXNBEDezkoPOs5qFyZ+YucZT8
	fLEKgTCwgBHhBOrjQ4VejFBKUDpR5UyW6VP1utQJG6FRlMk8wH+LrHf9tSF1WAgNdPj2ZwKH/w6
	K2f0mxeEQwRDV9ZE2ItDj073g163IpPcrWGfou/D1VJs0c1FCY3hXsjfvMTvBkoI8Ton8Bcs3oD
	u6NitAwgA==
X-Received: by 2002:a05:620a:2681:b0:8c6:a26b:7e92 with SMTP id af79cd13be357-8cd5aec6952mr599870185a.15.1772692207123;
        Wed, 04 Mar 2026 22:30:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm1949118285a.4.2026.03.04.22.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:30:06 -0800 (PST)
Date: Thu, 5 Mar 2026 01:30:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
 <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
 <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
X-Rspamd-Queue-Id: 4082F20B9AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21391-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:18:05PM +0800, Haifeng Xu wrote:
> On 2026/3/5 01:16, Gregory Price wrote:
> > On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
> 
> Every memcg records shrinker info for each possible node. If we use online node
> instead of possible node，then during memory hotplug, we must tarverse all memcgs
> and shrinkers to check whether corresponding node has allocated the shrinker_info.
> This way introduces more complexity.
>

Right, but some systems might actually WANT this many nodes, and this
does not scale well at all as-is.  I also don't think it's as complex as
you think, most of the infrastructure is already there.

> > If you're not actually using CXL, can't you just disable CXL in the
> > BIOS?  Then you shouldn't even emit CFMWS at all.
> 
> I have asked our Intel Support Engineer, he saied that cxl can't be disabled
> in BIOS.
> 

Huh, this is surprising.

If this is the case then see Dan's patch here:
https://lore.kernel.org/linux-cxl/1f5074979a58803ec875dd10c9234c7b1a17192d.camel@intel.com/T/#m0d64b723a63ca7faf44311c52c1ebd5f280ae626

That should deal with your issue more cleanly.

Otherwise, the problem you're describing here really should really be
fixed with either better lock scoping or lazy-allocation.

(Already poking at the issue a bit)

~Gregory

