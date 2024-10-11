Return-Path: <linux-acpi+bounces-8698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4D999A7E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2225228541F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA751F131F;
	Fri, 11 Oct 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbRfxKWo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BD17BA9;
	Fri, 11 Oct 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614199; cv=none; b=QE7gJ9Wldn5JGyk1h6XxwTk0abGRyoFpSAd9vuAHAGazt769YLFhkY/0QBifZDP5YVt+CdEGbULwsoPP+734cdwMC7xiB3TCcILmJi4Hz+DHmYr+uMZJgMICNkKzj39FfxJKVk5CeIeRz1TlLZSi9aOu/mz/mDSXrXG1s73sv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614199; c=relaxed/simple;
	bh=BD3Hf71Rueb5u3SQnFx1sRO5c6qgBU8XWfnjRKmbsRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1p79CLSdMxZ0erPcDHxX3+prrDSiSGcEQihzGD8jpgUq53BKuyy3IU03p7LoimTiEModQ8Q4SCGf54g2+4CDIzH8EHfrGKGwdMO6ZUuweKYBDCKlNkLxW6tRTOuU6jNiY81poAPi1x4FpIwU8kqUIehVEphk7C+Z505aGGTRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbRfxKWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F05C4CEC5;
	Fri, 11 Oct 2024 02:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614198;
	bh=BD3Hf71Rueb5u3SQnFx1sRO5c6qgBU8XWfnjRKmbsRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbRfxKWohYpA1A/JbOQXosuN7PM+j5wQV9WmljphSfKiCUzuwEDKSJU7ZZoin2cnk
	 X91uZLEoH4DlTdW//IKntnQ62oCIAwT7XP18jtYaXSIc122QnQsKKXMQ1QWkJCbLx9
	 ansIy28Gvc1asjYVVLxH+pT8QRqrgBJonEPfZMPkYF8nRNrfQ9uFgIyetcalakf8AL
	 eFN/Tv8JHeG1FEbPIf7++h724i65Rq4XEqzHSvOpPzXwcva83muLA1CrlTCmj4oDAK
	 Slv1E/U7+ibU4RPUUvAEogn6Fq9PVMF/DftvCTjjuz2rI3aw9UbuREvbeYlkS4k0JY
	 jLgEEJcYHnnVw==
Date: Fri, 11 Oct 2024 10:36:33 +0800
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
Subject: Re: [PATCH 5/8] power: supply: cros_usbpd-charger: register power
 supply with devm_power_supply_register()
Message-ID: <ZwiPMRS_ZftN9989@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-5-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-5-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:07PM +0200, Thomas Weiﬂschuh wrote:
> devm_power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

