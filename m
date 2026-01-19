Return-Path: <linux-acpi+bounces-20427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91ECD3B4D2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F060D303F9A4
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C932BF24;
	Mon, 19 Jan 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pQ1BCoGN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481032D0E6
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844644; cv=none; b=VULLlzmHMjsPvDKE6Qv1R6YBY0YzkCdTOmyfP+nQhBDniQZYH3DQZquQrCayHxYcDDzM3+lly8dpbdeaIJr2TwTNzL8vurW8gP5MU1Wk0M8anYVccWrAmNzb8eWDXPAvozyjm5qGPGjN83+/ZV0soTaVscAWpd+/2/GZ4aGwSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844644; c=relaxed/simple;
	bh=4lsZm7fAh/OviDeCjpHYkOoKd977iVg1o8ZDmm/HMOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbEni3IoPdC1H5FmChmqA+/CmoejYJWEe9xEqzdjPou4cgxYUzis0WSbtdF8hoMN44t0iF4RvfI4bSOsl6V9CvzLQGVCTzM3k6b8lXHGNWrRiWCPsYW20ydrbKmfh4aBDfjFlklWgN7cr4a4f+8CADhz22Lz4EPeOn2RbRc4SLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pQ1BCoGN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=30wb2xhx0nhKazlpyImvuAz2CturomLS82HLgaszme4=; b=pQ1BCoGNoswIADq9H+S5OtR2F/
	GeHfH2DHT3yRuVwU9/+jJHf4VHXWencddJfR6ASubY+d0XuJ2hO/mdShGzk8+lsWKuMA16ZrvKSnt
	OL3XDop35rjPo55v/SJLH5q6j3PSUxJZoet5yyqZUzK6e7gOa+He7jcfTdejB3txv4WA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhtIB-003XaB-IN; Mon, 19 Jan 2026 18:43:55 +0100
Date: Mon, 19 Jan 2026 18:43:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5mn9pXYOU-3djd@smile.fi.intel.com>

> P.S. Currently I can consider this as Plan B if we found no other better designs.
> However it would be nice to see some review from network people, such as
> Andrew Lunn and Vladimir Oltean. They know much more about networking HW
> topologies and they have an expertise in ACPI.

I've been reviewing the DT parts. And the DT Maintainers are also
looking at the patches.

But the question being addressed here is, do we want an ACPI binding,
following ACPI guidelines etc. Or is it OK to just stuff the DT
binding as is into ACPI tables?  No native ACPI binding?

Putting DT into ACPI seems to be accepted when there is a long
established DT binding, but ACPI has nothing. Which is common for
networking with SoCs and Linux driving the hardware, not firmware. But
this is all new, its a new DT binding, should there also be a new ACPI
binding?

	Andrew

