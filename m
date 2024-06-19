Return-Path: <linux-acpi+bounces-6513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B48990E1D3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 05:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE051F23354
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227A5381A;
	Wed, 19 Jun 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt+p6Nqg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833894F605;
	Wed, 19 Jun 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766475; cv=none; b=ASl6I5otEYFjPfKthL7aIyKvFeaoUr2fuOhn8kXBT27NXyKbIK0wFOl3CJ1x15OhX74rxF64fq3+mjvQwUOhOQx+0gUHdcB1Pejlr5RaWlAYgUkZ264HOMzU6yMiWqYBxc05Yss1RZdLdAHEBw0rSvSWlbJSFyyV+aKQs2RCjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766475; c=relaxed/simple;
	bh=FYTj5zAq9+raq/s0q+bM7+Uld8MuTvLyhTG8RSdv2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWCivtNPiwAR18gSvISBK+ZHNlLEkeGgMitu3xrHAzR4RpuSHefp8HPUivB/vsXzPl4q3S1LwX/qBtWX7rWPcRgBPCypIfsnZmAliUZZNmt7qMA5QD+oVZkCV0Wtpe7kxDlDoZisVJoVb0zqUvuec2VmRb4i8iWhzDZp6uqpAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt+p6Nqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FD7C4AF1D;
	Wed, 19 Jun 2024 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718766475;
	bh=FYTj5zAq9+raq/s0q+bM7+Uld8MuTvLyhTG8RSdv2PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lt+p6Nqg0wRheAVUdY7iQukaWVdfx/VCEM6X1CPHdseJIL6tVNGhiGxDPMZfKM+/+
	 vUINKaGFCruohgSklELCmTrIqaNXKwb4QM9d3yhyowi93fGNy1CEzjD7ETpOJXGXdZ
	 BlWDG3oGBxuWeHskiOmczMl4WFjZI5/fZhpdLWYPQ5EuwjKKo2QV/C3u9wPg1RfS3M
	 E3bKRMP5+20Ewu2Xg2GQ3baqz1molTMPilfuLi4knOfYmyQZb1YtpLy5+zpUU9VpCV
	 9gTwmm0EvnldnfQDZBa45njEIxUmlz/5Pu76IMoG2m2aZ1c0ZMrn19CZrpWCe8k+JS
	 DPK41moYiHY/g==
Date: Wed, 19 Jun 2024 03:07:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
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
Subject: Re: [PATCH v4 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_get_cmd_versions()
Message-ID: <ZnJLhj4tO8ZLxNYM@google.com>
References: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
 <20240616-cros_ec-charge-control-v4-3-74d649a9117d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240616-cros_ec-charge-control-v4-3-74d649a9117d@weissschuh.net>

On Sun, Jun 16, 2024 at 09:03:31PM +0200, Thomas Weiﬂschuh wrote:
> Retrieving the supported versions of a command is a fairly common
> operation. Provide a helper for it.
> 
> If the command is not supported at all the EC returns
> -EINVAL/EC_RES_INVALID_PARAMS.
> 
> This error is translated into an empty version mask as that is easier to
> handle for callers and they don't need to know about the error details.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

In case of the series wouldn't go through chrome-platform tree:
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

