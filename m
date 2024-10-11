Return-Path: <linux-acpi+bounces-8695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1F999A73
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A64B2278F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64D1E909F;
	Fri, 11 Oct 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUGTnha1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AC23BB;
	Fri, 11 Oct 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614145; cv=none; b=jkuZlHHFthb0cFZxYRaLRlUJy1BwMvPUcJ2xGmx3tDFoYNQXuQ77CiFdKpGgIXqfxHwxvOi/nqb8gbpTnvQMcB9Hd0UNQ0BCqPZSq7u4SaSOOc1lIXFGKMco7Mg7uHA8zCTCc+sR/1kvLrPsahR+sEe4w0EHATSlZ/QoT2uSZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614145; c=relaxed/simple;
	bh=rShLXfFIjHn1c9cjO/f4Yh906mHA/WX5/cOB1uCMIr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVQ6BiTdAWcB/Kr5fNexyk5VKa+3kqU4vfTGqmE92M6hPXHslzkUbAtvLrePvshYYuVRThKzC4GIrbRk2QmAz0BvBo1+Ithp3wENJw9gbWNuw8MFO9cmRCISLq2N7ZidBmbFbY8RxeGRBnGMDcjcAoHMwkPtA7QrfbINnbkLnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUGTnha1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B99C4CEC5;
	Fri, 11 Oct 2024 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614145;
	bh=rShLXfFIjHn1c9cjO/f4Yh906mHA/WX5/cOB1uCMIr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUGTnha1/a09VelDQxvikJiIKwGI0nfzhP84Re7cZt/glWuYtchIdfvolNMW+AC88
	 B5ehNQfS4fy94CEW7D30nKhvSGf/xL2POmH/avgJxeybsiZy1utjPiR1v5pkN+En/A
	 ShVRjvYx2PD6fzF8ibd1qFLtJuUp5i1YAWtvnTL0ZROIajQJ5ZYUg562ZU6OO6tBoq
	 g8DT4u26JpphUUG1RMrphMRYI0hb+NV5xwEGmv/rHTZKoDBR88CN39dGRMdYt0yNPq
	 WNtQoakknxjFj74QbK3oyQM2R9Lk9RTnJ2XufvfCqVcSu5hHC5rhkYnidQzFUQ1p75
	 KlkpQmRmZucDQ==
Date: Fri, 11 Oct 2024 10:35:39 +0800
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
Subject: Re: [PATCH 2/8] ACPI: battery: Register power supply with
 power_supply_register()
Message-ID: <ZwiO-wYlHPnxDl6S@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:04PM +0200, Thomas Weiﬂschuh wrote:
> power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

