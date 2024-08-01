Return-Path: <linux-acpi+bounces-7204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53761944B85
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859C71C255F4
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866871A01DB;
	Thu,  1 Aug 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCn4DhID"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D615252D;
	Thu,  1 Aug 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515949; cv=none; b=bA3NowNrJ9b/LPZQKN+Pp7s2EI/QXSW5WucG/hRrp1LpcAVhuDxcDMou4oM8h6Sm3DHyT68l/QhPKJJ2r+DRrIM47hsfUU4arUxCWrrkPueiHEbLLKZqb4/a6ib0QJigIwjHIiNXiz6CQg95XpnCagRWsKziQmDNhfUDgBuHVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515949; c=relaxed/simple;
	bh=HBLGXJAA56+z2j8DW+eYMm1UK33BW0xzkvU79F0+rlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M35jFUluXIC0RCnT5mfEvBWAX2jeCZRVGNI/VLUkEXMRF/vKCyAzaUtcMBg94KuvxseuVcRHRZolzNW8UXvroB11rr/DLA46e4L38FC4/+lG5plRBJc9P+CfCiBWGVTfLAXRW4fK6gLXlJFMRZE2PBWXcU35a/ugRPAXSWJA5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCn4DhID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B04C32786;
	Thu,  1 Aug 2024 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515948;
	bh=HBLGXJAA56+z2j8DW+eYMm1UK33BW0xzkvU79F0+rlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCn4DhIDkkEjOtwKn+8KB/FH9Bq93/RvdjSoKKVEk2sTX0poiVs6zed4NrpceWj3B
	 ud97PfOJ3obUOkUfrmF4sIsCEYQ4fxL6Ep04la58Eoi9XhIf/YvI0EVFzNx7oEf/xu
	 JHD3wnLR877SRn2kRzwZ7KSIeM0c2r/j/IGEIDRHHJhTCNfebXj12JTs6rR3zKL5Q5
	 dRKOPRr5nPzlLNVk1RRgQvfPkVrdcBr0Ua5ilKSmuFshMUCgZUwZJ978c5nvFWKlrG
	 JZKLc3E2cxqUBFEV8FxYQoDg3YhR40H6n3eJc8z1jKQ0iup/V+7T52xPKLkhhshkwK
	 /iLdAEM5iLwHA==
Date: Thu, 1 Aug 2024 13:39:01 +0100
From: Lee Jones <lee@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
Message-ID: <20240801123901.GC6756@google.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
 <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>

On Mon, 29 Jul 2024, Javier Carrasco wrote:

> On 25/07/2024 18:28, Lee Jones wrote:
> > On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
> >> This series aims to clarify the use cases of:
> >>
> >> - device_for_each_child_node[_scoped]()
> >> - fwnode_for_each_available_child_node[_scoped]()
> >>
> >> to access firmware nodes.
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
> >       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
> > [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
> >       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
> > [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
> >       (no commit info)
> > 
> > --
> > Lee Jones [李琼斯]
> > 
> 
> Hi Lee,
> 
> could you please tell me where you applied them? I rebased onto
> linux-next to prepare for v3, and these patches are still added on top
> of it. Can I find them in some leds/ branch? Thank you.

Sorry, I was side-tracked before pushing.

Pushed now.  They should be in -next tomorrow.

-- 
Lee Jones [李琼斯]

