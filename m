Return-Path: <linux-acpi+bounces-6702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE491E09F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C7B26E59
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242715E5DC;
	Mon,  1 Jul 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R01Ofstz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF415E5AB;
	Mon,  1 Jul 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840358; cv=none; b=mG7cdFvqC2NcOaaJ2o4TONx4sEuXbsmLR7rkTMyExiRcw77mpxUAVKPU8KGzf1wltpK+eOsQH3OrSpFPS6HgiQ8I4uLaOVuCvf13KkUjapUB0syOUaUpf91DOGtvjJ67yzRu5lr8D1UGTN33hCYkDpaT9+tJzXUEZwsmyrJr/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840358; c=relaxed/simple;
	bh=94oQe62UNNaxV4MzeVF0s6QJoleN8v1RFdpgrrP3NrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyYF1ibyid/cIRQLGvUpJIwRWafzsysRtYCPLoOgGwX6VWqQu81CQ2iRmmkD1MEA3vuO4oB/eAy74p/X8wsr9NX1bRbtEimgxY4OzB9+P16gxX05AwnSeVf+QC69O/wkLvxcOlScM1sSEAIr0CBb6BOaPO6o3PCW+ORd6r7uO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R01Ofstz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99DC32786;
	Mon,  1 Jul 2024 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840358;
	bh=94oQe62UNNaxV4MzeVF0s6QJoleN8v1RFdpgrrP3NrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R01OfstzuQjf4M+Z3m4Znz8UNIkF5wPKBc3EBaJ85D9SABPv80H2V/8SIEk0NQQFU
	 GMdXCh46H+MCBlfaoxWRF8u8w7u06xk3X9mpuWbKLDFN5hAyWBQifwj3psasF1QqVu
	 dBVeU6V0yONE6186yKbmHwptkV8J+w99uxvq16Un0rVt42OzzofkEzEyFnOZZQIgPe
	 fC6azefT8tu03Mx3BQqbrctxYiHQtFgVH7uucW8TMyAaj5vlJd4dqnTn4w4m8ByJbY
	 +G+wKxbLw3e8Ry9iH3wgUf/qon+xb0frHdyX7s7TvrJZhKddwsLytdOlz8dn9dXu3m
	 5WvLJD4KgWiew==
Date: Mon, 1 Jul 2024 21:25:51 +0800
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
	Matt Hartley <matt.hartley@gmail.com>,
	Kieran Levin <ktl@framework.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 0/5] ChromeOS Embedded Controller charge control driver
Message-ID: <ZoKuXy7r_j_9iWTC@tzungbi-laptop>
References: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>

On Sun, Jun 30, 2024 at 10:54:07PM +0200, Thomas Weißschuh wrote:
> Add a power supply driver that supports charge thresholds and behaviour
> configuration.
> 
> This is a complete rework of
> "platform/chrome: cros_ec_framework_laptop: new driver" [1], which used
> Framework specific EC commands.
> 
> The driver propsed in this series only uses upstream CrOS EC functionality.
> 
> Tested on a Framework 13 AMD, Firmware 3.05.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Thanks!

