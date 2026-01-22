Return-Path: <linux-acpi+bounces-20497-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIdpJdFqcWmaGgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20497-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 01:09:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D64B5FD52
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9B8B35A337
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386426ADC;
	Thu, 22 Jan 2026 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ECnOfTJe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A631DC985;
	Thu, 22 Jan 2026 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040585; cv=none; b=HsqG2RkkXHKoezsAFSjSW6HX+TsvR1xyQmwBKnrG9k3UN4M63t+gO2aE72ItkyfBeR0DX14r17EFXu/NvLw/A+h1fWm77fP3A9Q09LPgthfiAtBm8YIcbcdQTd4kpTzDF7rxG3UCiJFlmTDnnOxMCq92W0S/2SLZZevc9xT8T+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040585; c=relaxed/simple;
	bh=5RqDsW0qCpjzwSEnLGyVDIsyoW6Wb3AV8KToE85KTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNkHQKPVjX0FWkLenTOfF2om4+w+kdLRD/+qpzSsv2afgkSJFxVJAT9pHdB7ZL7Nro16BrFv4Te0Bc+OQX7jaJj8g7SzIVejKXLe/9QYQFwXI7BI6QwtiXLkm4Pm5WXHRxhr1ubLwkMazNKNcMObZ3ZLSqniHJVXJ7Qgz8DSVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ECnOfTJe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q/qIiQ2bC1/CGyOomzLgLTc8l17yWxJBYBwUc//RG4o=; b=ECnOfTJeOw7ag8Orj09w5Qp+Vt
	2vbaZvrPuXT0oRBxwgypNJ1ZGp4nJ+6PbeRqSaBJ3Fb8D45PYxUTmz2A2NtRWOgnjDfDjNBl0qpzX
	4VmpNhijYl9bMvaXaf0U/wd68Swnej69bzahqEPZ8Hi8mHNb77sQ/+Z4aiGQMN7hbdu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viiGG-003tHm-4A; Thu, 22 Jan 2026 01:09:20 +0100
Date: Thu, 22 Jan 2026 01:09:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Brown <broonie@kernel.org>,
	Jan Aleszczyk <jaleszcz@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
	linux-acpi@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-20497-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3D64B5FD52
X-Rspamd-Action: no action

> * While the physical signals on these wires are indeed clocks (10MHz,
>   etc.), from the OS driver perspective, this is not a "Clock Resource"
>   issue. The NIC driver does not need to gate, rate-set, or power-manage
>   these clocks (which is what _CRS/ClockInput implies).

Is this a peculiarity of the zl3073x? No gating, no rate-set, no power
management?

I had a quick look at the Renesas 8V89307 

https://www.renesas.com/en/document/dst/8v89307-final-data-sheet?r=177681

Two of the three inputs have an optional inverter. CCF has
clk_set_phase(), which when passed 180 would be a good model for this.
The inputs then have dividers which can be configured. I would
probably model them using CCF clk-divider.c for that. There is then a
mux, which clk-mux.c could model. After the DPLL there are more muxes
to optionally route the output through an APLL. The output block then
has yet more muxes and dividers.

All that could be described using a number of CCF parts chained
together in a clock tree.

And what about the TI LMK05028

https://www.ti.com/product/LMK05028

It also has inverters and muxes, but no dividers.

Analog Devices ad9546 also has lots of internal components which could
be described using CCF

https://www.analog.com/media/en/technical-documentation/data-sheets/ad9546.pdf

So i do wounder if we are being short sighted by using the clock
bindings but not Linux clocks.

	Andrew

