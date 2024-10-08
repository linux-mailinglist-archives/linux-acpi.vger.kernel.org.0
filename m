Return-Path: <linux-acpi+bounces-8609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0159995133
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AF11F2271A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD81DF994;
	Tue,  8 Oct 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mJUX75xA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92441DF990;
	Tue,  8 Oct 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396834; cv=none; b=Y+5c+q89Yja64KWwtOq8+jm3Yuz9wLEbJeFxHc3/y2jbRQhSLiIeHJKSqt+72RJYSHOHB4LMUF3tjlJDSN+H3MIYyGGiofT23oZ+DszziQp+/eIsQTCgAGg8OOWA1FL4h/ASBxTIfb5SKLJWsWQgMWnwVj7HK0GIPsKN03Bna6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396834; c=relaxed/simple;
	bh=obUSSrHg+qjtItpprV9oF08oTUaPUC4j6ZzFlRqtIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq3JzTE5ho6qsg0BebWUO4P5TW9xJvVRrBKVpSghvtAoUsKCyuCWsr00S7H4z4aZGS4t6Trp6dyaCGJfuDz/1r1OXen17ColAZrPQ4Clqh8DLQzASrqxtaR9U3gpvk/Xd+pTON2JwnkdfuUSDjXmR6DyVQ/X+JgK1WO2D359Kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mJUX75xA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728396822;
	bh=obUSSrHg+qjtItpprV9oF08oTUaPUC4j6ZzFlRqtIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJUX75xA23KtE0aabG0RNnvK4Axbl6UCcDzmj28c3j4iKcIug3EDQmOc6EoqHy6Id
	 w8MPUhDHovUma8OfFdF8DjJQZu7LkyDWZOA+6bI8aGMGCOm1XJ7s0ZvWXZ1oSMcsLG
	 RZlXfcb+Yq5fnffA+hfy+aMaHVEbToaF1Yxx2fTI=
Date: Tue, 8 Oct 2024 16:13:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 2/8] ACPI: battery: Register power supply with
 power_supply_register()
Message-ID: <806cc80d-4c60-40cb-8bf8-68ba29ca9399@t-8ch.de>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>
 <CAJZ5v0j=P9orUe9k0bsUfxE0YA8stsbAi=k+ge4_XBeuHVnyrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j=P9orUe9k0bsUfxE0YA8stsbAi=k+ge4_XBeuHVnyrw@mail.gmail.com>

On 2024-10-07 18:51:45+0200, Rafael J. Wysocki wrote:
> On Sat, Oct 5, 2024 at 12:05 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > power_supply_register_no_ws() is going to be removed.
> > Switch to the general registration API.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@inte;.com>

Thanks!

> and I'm assuming this to be handled along with the rest of the series.

Yes, this should go through the power supply tree.

