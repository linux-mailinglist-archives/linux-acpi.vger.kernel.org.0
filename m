Return-Path: <linux-acpi+bounces-8700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B2999A84
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6763A2852E5
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA01F471F;
	Fri, 11 Oct 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXSx7q98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BA1F4702;
	Fri, 11 Oct 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614223; cv=none; b=YEm43zCgKCORgrB968cYXIhTJm0L16MVz2GiVOPeYe4NdmkMjUwUA1w9TqjH7VimabvvoJ9mTXo0N/VDcAjKQ0v3rVpl9RH9D/eLJrhun2rVpn18O9n/ffbF9tHNYtfzogPhnIjS+4LvVbZgwg6WNbeiVEZfkjB9dbXh8+PLvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614223; c=relaxed/simple;
	bh=YSowDF8qc0hxIkyr3wrQFsYQcV7GQrS7Tao+i9xpN2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJo/KtJxOButfJ90DX95RaTHDbJY6tXrWjnGwwRkonjJP9jlx3fhlc3Eq3edWePxmBKdnm0zdkWRKHObZoMpcZcFfq2t74Ed4MVMa/e1CJ908J2usD+oGaazRYiJEp2HA5enryPj1mENLMsEbv2SF1vmxikhRDYvOtJf6kugh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXSx7q98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F90C4CEC5;
	Fri, 11 Oct 2024 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614223;
	bh=YSowDF8qc0hxIkyr3wrQFsYQcV7GQrS7Tao+i9xpN2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXSx7q989NTyUegnzicwPQYsmUEsYPtHGKuVkuVNSvF27HwCx9NZ9eahHuN7DVUCr
	 znBh73+Ke69M5Ijr9c2IdGG2vEM0yjdW2mJqqe5Eh1EtM9XYCrH6ayxwHaFxJ0HZqY
	 Fl28fqpFIQBZUJaMTg4+Wgwgjy7uL+linIFAmVRnUmIFwMncVouHSptJqzrDu4iZHl
	 yer7u8TSB6F4doNpM6U4up7b5oPCCJJeHr7nB1AOu7iQwOoxj9W8nclqI6VOydZVP6
	 VhLCIT8wrJtZsi+ysTiIy84UKvKICQaQMsLZVrMHcOnC5f0YVDTv8uFnHqaLaf36WG
	 oJ91sHEH2VPhg==
Date: Fri, 11 Oct 2024 10:36:58 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 7/8] power: supply: max77976_charger: register power
 supply with devm_power_supply_register()
Message-ID: <ZwiPSlrl1jLQjyCM@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-7-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-7-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:09PM +0200, Thomas Weiﬂschuh wrote:
> devm_power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

