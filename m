Return-Path: <linux-acpi+bounces-10511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE742A094A4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ACD164BD9
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A023211267;
	Fri, 10 Jan 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdAOMVR/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFF20FA9D;
	Fri, 10 Jan 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521555; cv=none; b=l6Z7iMe0Dl5YCELNMCfJOHyx6XKh/iVnbAw+RZaKOIK66P1q8Bdz2olgoXD8AHoYW0gpEVlOGpK1GwFHDoPbrRCnkTzSRq25/3ct0PJvAz25wvv1/JWKascWDIo+G/xH5Z+34DT/tlfko+P4ulEc2Au8HjeFRs4JHVaNPgWFGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521555; c=relaxed/simple;
	bh=udSGBrfoVu0Dwss9JAiz5zlg6IwgRRjWDW4Hs6hvbbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK2dxf55OobQ+sPqbzNOJDmCedcUXiE9XRHIGjRWPMQdXTaUUCXrwcP+IHj7Y5r03YtH7qZ8av/qu50zYM4IdmdE5NLOppv+XlUJaTdj2bVSL0emBd2Y1LO1GQhZ/dJIqU/os06YmFwkz6K4GHzBTuHaQkjEAuMHNbNBlsoBb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DdAOMVR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84840C4CEE1;
	Fri, 10 Jan 2025 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736521555;
	bh=udSGBrfoVu0Dwss9JAiz5zlg6IwgRRjWDW4Hs6hvbbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdAOMVR/OdBmq38TIZupU4QJHbQtq0+DsjbFS5sdMuR2OABpM/G3xMBWxmmQvFm7F
	 xnW/eUbIVjARwMzej4VyXIhGCFU25F1Pbot+UU/6vKi6WDsG1c2jhQpcFGtgjGu2Pn
	 ijniDq19wyDge7PodKdsvoDiCe7veypFN9yyOTPE=
Date: Fri, 10 Jan 2025 16:05:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: Split property reading bool and
 presence test ops
Message-ID: <2025011045-pleading-pacifism-c011@gregkh>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>

On Thu, Jan 09, 2025 at 01:42:05PM -0600, Rob Herring (Arm) wrote:
> The fwnode/device property API currently implement
> (fwnode|device)_property_read_bool() with (fwnode|device)_property_present().
> That does not allow having different behavior depending on the backend.
> 
> Specifically, the usage of (fwnode|device)_property_read_bool() on
> non-boolean properties is deprecated on DT. In order to add a warning
> on this deprecated use, these 2 APIs need separate ops for the backend.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

