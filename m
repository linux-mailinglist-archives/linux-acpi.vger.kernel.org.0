Return-Path: <linux-acpi+bounces-20571-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCdhIFaBcmlElgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20571-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:58:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D76D4C5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870ED301874E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093583783B2;
	Thu, 22 Jan 2026 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MTl2Orj/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B5341660;
	Thu, 22 Jan 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111891; cv=none; b=p2F7Esdul+Ue88z1zmUX9H/UaiDqVlRHaYrswiEqhiB28wFkkBsVf9lk5cvxVVrODbYFR8ufz9A36IDcm9TYC1lO8RvNWiJew+WXujDdrIvg6jZ56KdLu1eRo4hWdXb6hr9zwGXKMy1EmRIrGMWb+iyThCmofKnqi+xZwjELQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111891; c=relaxed/simple;
	bh=BVTG8JfAmnaECDC2EjI4+pDJDmmFZ+9mtQ5SGor7aMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRBR0bfP+zaLiZuj/azhxP3Qu0cR2vUQreSIvGCGdHM1n1rjp61FVXHb2/lHgqLrjfTvLqGLnwhFylwOz6FCWD1cjzH56y4oDEanlAWC8+EncembTWHdGJsy3qQh2qTyVZHnqvZ0rBaHSWDNTd8y2V93I//n1DXR08u+6mq0ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MTl2Orj/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=okreXUis4+2vM6EbZDf6o0+K7XbnLcSv+WVh+KAdL/g=; b=MTl2Orj/FOnvtV67OuT+WVtE0q
	DCvUDZyFv5Kz4OGNpVLjcn1dvQJtfTmELtJGy7RrnjV6EkYk4bJhsWmtj717iWVN1tryihdmBRpFx
	eM7pfMpmyj4MMNrZrQx3lbBUrZWHmDU/N0qGAcsooP+7iiwkR1LbAHtnQ97vBC6+FpzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj0oV-0041Z5-5d; Thu, 22 Jan 2026 20:57:55 +0100
Date: Thu, 22 Jan 2026 20:57:55 +0100
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
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <24e081fd-1b59-4951-96fc-f87ef7f3172f@lunn.ch>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
 <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
 <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>
 <11ebf2de-bbd4-4aec-befa-cf0877cfa960@lunn.ch>
 <c0de7c8b-8fea-4e76-bec4-6337153fc7a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0de7c8b-8fea-4e76-bec4-6337153fc7a1@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20571-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: D32D76D4C5
X-Rspamd-Action: no action

> No, absolutely not. The drivers for these devices reside entirely in the
> kernel. They handle all the low-level register access, mux config, and
> hardware abstraction.
> 
> The userspace (e.g. synce4l daemon) is purely a Policy Engine. It uses
> a  generic, hardware-agnostic Netlink API to send high-level commands
> like "Lock to Pin 0" or "Set Priority 1". The in-kernel driver
> translates these generic commands into the specific register writes
> required for that chip (ZL3073x, etc.).

Great. But i've not seen the needed board configuration to allow
this. Where do you describe if the ingress inverter is needed? The
egress inverter? The clock divider on ingress, the clock divider on
egress. The frequency of the clock feeding the package, etc.

> But I don't use CCF bindings in this design, this design is about
> representing an opaque wire between two devices.

Is it really opaque? Don't you need to know its frequency, so you can
set the ingress divider? You can either ask it what it is, or you can
have a board property. Don't you want to know its phase? So you can
enable/disable the ingress inverter?

> This design is not a classic consumer/producer. The DPLL driver doesn't
> care where its inputs and outputs are connected, it doesn't need to
> know.

I really doubt that. Given how configurable these devices are, there
must be a need to know what is around them, in order for all this
configuration to make sense.

	Andrew

