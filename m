Return-Path: <linux-acpi+bounces-8694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195EB999A70
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7757E284B10
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1831E909F;
	Fri, 11 Oct 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3u8u76s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FD23BB;
	Fri, 11 Oct 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614062; cv=none; b=RDNtjkThFlG0Jvz5UPCcy6aLLZeEWirdqiu5ZSOSG3NtP3hPgJh94cgj2K9Qz/nni9Cg154zDWtJAfknliYEmm9WU2RW0ewxezNRjpI0s3iIdhhdYggJD5XSFDGf43j6N5QJnydLMY9EMoYXOwf3OXgYAv2nfTBkN2hwSZL1S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614062; c=relaxed/simple;
	bh=WkFJfKCl99ICgir8IODzpgVlQZ05agzTkbWuL14bckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbUiEdgqD0bx2kn524DI1FPw0nHoipnJwgG/YUb/YS7L9RG37y7JjdIcKFk18kOba31yRm5fWhqJx50zNnTIT/9etjoMYMHF7DIIwmJZfV/9WDrdK+1llL1BtszeV0sowJfunzumt93oOKy0okdPc/QqiTmfil243SoO8ay/nzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3u8u76s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF30C4CEC5;
	Fri, 11 Oct 2024 02:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614062;
	bh=WkFJfKCl99ICgir8IODzpgVlQZ05agzTkbWuL14bckA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3u8u76sxWvLzmxXTPVcljUTpxyALiKg2BSiyVLuRqXUse3ImIw7yw1PQA4TmlTwZ
	 JjMAU6Sg5nQ258LpTfF6YngcrgQxw2eYlSO7dv+Yce670m5yL5r/QPFKc4bg5NQjOc
	 WxA+uTytINFjY8DwJOAOANbXJSXWbYzRkYAApwePde3kWLsIfW2h783nD2FW0Ykglo
	 3+iKoPQ7aU+TF02EtOxTcgDzbOkJAdZk/DlcDc3uMIlDIANQDAdfUlxP3J7tYUCaFl
	 a04GG4O1tkkyT8o5E2S5/xt+yJF4XmOh+KbKQWiWLQt5QJebeRUG5KPeu1I5dD+VIm
	 9nt7ulI2JwCiQ==
Date: Fri, 11 Oct 2024 10:34:16 +0800
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
Subject: Re: [PATCH 1/8] power: supply: core: add wakeup source inhibit by
 power_supply_config
Message-ID: <ZwiOqHvWascVUSYo@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-1-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-1-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:03PM +0200, Thomas Weiﬂschuh wrote:
> To inhibit wakeup users currently have to use dedicated functions to
> register the power supply: {,devm_}power_supply_register_no_ws().
> This is inconsistent to other runtime settings which can be configured
> through struct power_supply_config.
> It's also not obvious what _no_ws() is meant to mean.
> 
> Extend power_supply_config to also be able to inhibit the wakeup source.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

