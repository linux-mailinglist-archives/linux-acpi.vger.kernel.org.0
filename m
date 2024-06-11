Return-Path: <linux-acpi+bounces-6297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783890388E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC311C229EE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048917B403;
	Tue, 11 Jun 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC2oyTXJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD317A92F;
	Tue, 11 Jun 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100886; cv=none; b=nr+jM4/FhmmFO6KSYixKvbany9mz/fb1y/ga26xNX3RSoIpvGI8O9Zba8N1c/wIWqDH3y/JO7pWWf5cUVttCM5yZCgvKlBYucVn7g7hBmZvdgQXvATTdIV7+JuGi1UD6VIZOBC/NwPjzM8zflilbSvRuvh3zwW54eBLJR8zC0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100886; c=relaxed/simple;
	bh=rFt4XS/CgSsXIcBXqKf+lWLQ7TFyTsJ3RIR+fC805gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztr/z7z4+EvKPga3AffgxOtJMnpRbVFL8n1NfWXCLSH/6t61KRYkrYZCnvm8oe45lxVg8Hm/57BUrLsJiZo50DGWtCZi4jdygnEn3pOhPsDB7oJTyY7Sil24xbCYDL438ev5Bu5WSFqYLKr94SrUPpfHTo2a6O4w6EYDkb+Lgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC2oyTXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124C2C32786;
	Tue, 11 Jun 2024 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718100885;
	bh=rFt4XS/CgSsXIcBXqKf+lWLQ7TFyTsJ3RIR+fC805gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gC2oyTXJJ93PfMa4I6COS1Yg9NWgvNdR2czNkZbCtykuuMziuG35k2lRQXsZ03s08
	 KfIQQnswFEWvclKyGbEcLrzrEegkQC1BP5X/rsgCfh0aPrky0aCfZAPqBwj/vZBn+u
	 0sXR4TwnyFy+c7pxsj6q0kaK7bD9Dq2m4f+C1nuBIkQDyDMxbrzwu8PnjYjYerRTMB
	 jKX+myIF1qEgVrm5tO98eN+1f8g71nRoCz6TlDHkD05ySyflbHtT7Hv7HB5vohdD5a
	 rYDqp6qB2JpPzxO4rj3wX1OIJSUa3+1hthCCqNWGiGHzM7mezIewYzWoKSnmBPzC+u
	 EJAhgg5ScR99g==
Date: Tue, 11 Jun 2024 10:14:41 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dustin Howett <dustin@howett.net>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v3 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Message-ID: <ZmgjkVXZEe6BkZzq@google.com>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
 <ZmfvhvcjTbjOSp4f@google.com>
 <f2a361aa-a256-41a5-8100-703e40df975d@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2a361aa-a256-41a5-8100-703e40df975d@t-8ch.de>

On Tue, Jun 11, 2024 at 09:23:24AM +0200, Thomas Weißschuh wrote:
> On 2024-06-11 06:32:38+0000, Tzung-Bi Shih wrote:
> > On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> > > If the command is not supported at all the EC returns
> > > -EINVAL/EC_RES_INVALID_PARAMS.
> > > 
> > > This error is translated into an empty version mask as that is easier to
> > > handle for callers and they don't need to know about the error details.
> > 
> > I'm not sure whether the behavior is what we want or not as existing
> > EC_CMD_GET_CMD_VERSIONS usages don't have it.
> 
> At least the caller of cros_ec_get_host_command_version_mask() expects
> it:
> 
> ret = cros_ec_get_host_command_version_mask(..., &ver_mask);
> if (ret < 0 || ver_mask == 0)
> ...
> 
> ver_mask == 0 will never happen as in that case -EINVAL would have been
> returned.
> 
> Others, like cros_ec_cec_get_write_cmd_version(), expect the current
> semantic of ver_mask != 0 but log spurious errors in case of -EINVAL.
> cros_pchg_cmd_ver_check(), works with both semantics, but currently also
> logs a spurious error message.
> 
> To me the new semantic looks more obvious and much easier to handle.
> For each command version a bit is set. no command versions -> no bits.

Ack.

