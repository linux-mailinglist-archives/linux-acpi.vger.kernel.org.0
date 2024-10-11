Return-Path: <linux-acpi+bounces-8696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C80999A77
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333191C212B1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3661F1305;
	Fri, 11 Oct 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPlVVJ5Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12823BB;
	Fri, 11 Oct 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614159; cv=none; b=pRdxV8XblMIIbSVEM5ddoCdlLVwNqunE4+Lw1vbvANJ6kXf5dAOeLCVOtg1cyXNLVK30d0gIIM1O0CNA2xByVfSj+wim7tu+kRBwZF/VZabs3we4xjc+VvAjzaNqTTP1End73Xk8at2jgVmLxWfWPFQhUj8P5wnQN4b08H56Mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614159; c=relaxed/simple;
	bh=0FOW5wlNkoo6KucvHtdMUZ3kZTu6ZdFo9/npsWktHBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN8XLabPNrtt+RpKae4OOI99ZgzKQ3eT0Tzy1XR3DqTl73ZfFk7OWboLnMe3nOTWYwky8KMrEH76aWq3mFbsD4Ap4XPyC9BDMzV5elqUO/6OyNrIolhPUa+Q0BDVmGdAIDfOv4E4QcecQ2jQ7NrHhA/EudE6qN2gnNdxhcqeZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPlVVJ5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B525C4CEC5;
	Fri, 11 Oct 2024 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614158;
	bh=0FOW5wlNkoo6KucvHtdMUZ3kZTu6ZdFo9/npsWktHBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPlVVJ5YvebQVzmB7cmE6PmeHLdg/JgAN/1tSOUr7lcbvZa1qo2cppzRUL6MFosW7
	 6TfOX/sf7Y4aQAGrLPiN0I+J8psGQvQMKVELLVTrEFdD2mlMgQPLWVl0dwjil3rxbz
	 DZcZHThWYC/flNoqsMGbFFCwCeSL2AhcTBN1wYmiwMb3WuGrHrIr7GcLmYSZw7eyT+
	 PhY9zyWqpdD06vtbL1eUItmjF3jNOsqaV9CHQad1mKpX/eGHhIds2F9kQPOF3wrfjk
	 o6ieAlbG7TY3ZZIttQtrU2W+xwbRxTilbfoaBbB6WogPmTKBcWIdgJdj4tugSOYLSo
	 1cWD49/dtAE7g==
Date: Fri, 11 Oct 2024 10:35:53 +0800
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
Subject: Re: [PATCH 3/8] power: supply: acer_a500_battery: register power
 supply with devm_power_supply_register()
Message-ID: <ZwiPCaMORfmJsoFh@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-3-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-3-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:05PM +0200, Thomas Weiﬂschuh wrote:
> devm_power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

