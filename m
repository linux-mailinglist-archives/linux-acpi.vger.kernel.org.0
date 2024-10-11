Return-Path: <linux-acpi+bounces-8697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA6999A7C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3165284B15
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE61F1307;
	Fri, 11 Oct 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4r/Tcl4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035341F1301;
	Fri, 11 Oct 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614171; cv=none; b=UogYaTquKjSjNtmQ5hIT1aFVPAo4gp/G7FEXB1Hp5CkXRdO44CBpJRC1x5ZcLJRdaNAwM6xvV39OHaqufj/vZWpFyodwj1QHoqm4KgZIc/ipDt/zI60U348N0U61MEWDQzQ8fwU/scQyF9RjEyxCUgAoLuoB963fyY4Umr/K2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614171; c=relaxed/simple;
	bh=O3Sanwk+rSdENzx5D5HZ7wVj6CMjI54HGefU4Ts7COg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmxtyqYTHgSqqKiUV2En1Zwe1IulG5Th9fyXB1G8iYBMvQJntCaKhOZyRnWyW7ovYJo1Nmvo3Agmp8YAQWCqljacE7eOuvuwxFMQ2OzQJPVjUI1LTY6DFIMvl5f4kHD9+XaXwgyBR0lIFPjaI2Ty9q6dc9eBNtFd1aoY+kburjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4r/Tcl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900BCC4CEC5;
	Fri, 11 Oct 2024 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614170;
	bh=O3Sanwk+rSdENzx5D5HZ7wVj6CMjI54HGefU4Ts7COg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4r/Tcl4f63MtVLLLLbGXvS9lWPVYNwp4QHOKtJPc8AK5UysXK2OQm4rJ4w9P4z2Z
	 XYcq+KJjQEjFtaE7qV+/uHfF+9TL81qkeuHuXSxThe+YG6AsPTITU7G83WbxxwEgMS
	 HUK1VvQ3aDCeWfYFZvz43tr9mm07dlOGK+/rpeyPYBEq+3Ij73c7A0E+YHSPlZ5aok
	 m2KalBAPAHvlGhstXLHgROIGdbUnT1YSHucj4VfJoGb0kmuZ/9q4U7W3yNXIPr2pte
	 jZcdl4utTYDw1KM1WaRapmiSnNjw0+mItqVyLg1JOqlvbB+c5/LzLc8H4EF4s0wQqY
	 PQCoZ6CDdC/2A==
Date: Fri, 11 Oct 2024 10:36:06 +0800
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
Subject: Re: [PATCH 4/8] power: supply: bq27xxx_battery: register power
 supply with power_supply_register()
Message-ID: <ZwiPFvO-7nZ0eTPB@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-4-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-4-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:06PM +0200, Thomas Weiﬂschuh wrote:
> devm_power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

