Return-Path: <linux-acpi+bounces-937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC07D5A9F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55068280E81
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D9273D7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuGJytx7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E23AC2B
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 17:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90501C433C7;
	Tue, 24 Oct 2023 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698168890;
	bh=WMFWKDGHXaFpHcCYCCZf9b2QWb84y9lvP49pgqjr4DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuGJytx7gaw9npJLowQanXT5gUgrsxBbSCR9f1kvWA44qQo6fmM83p7Dl8y09Lawj
	 +N4ELwu1+V+79Iy5h2ogs9CRzDISiVyDCpvRSklSapXKFDwk4GIdK56HNqS78fZJgY
	 XVukmFgUreCRab8UoB84tiTMaoBVOC0EUNCsfD56cMdvdBRrS2OqFoI4koRJFGN+L3
	 ptgbCWAQewjdlgAd1Yn95N9ViO0lopL/mXPSYoaHQINKVGJvuCeyEO17vmDp8YMt4E
	 MrTLnuRveBH4mMihr26ZHgRRtAm+mhRpRwAQZht/ij/VGB1bFCSSSyq53hJHDyGnGT
	 2D22Vg3L0+sUA==
Date: Tue, 24 Oct 2023 19:34:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: i801: Use new helper acpi_use_parent_companion
Message-ID: <20231024173447.yfgan6kxb6fbjncq@zenone.zhora.eu>
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
 <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>

Hi Heiner,

On Sun, Oct 15, 2023 at 11:36:17PM +0200, Heiner Kallweit wrote:
> Use new helper acpi_use_parent_companion to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index a41f5349a..ac223146c 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1620,7 +1620,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	priv->adapter.class = I2C_CLASS_HWMON;
>  	priv->adapter.algo = &smbus_algorithm;
>  	priv->adapter.dev.parent = &dev->dev;
> -	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
> +	acpi_use_parent_companion(&priv->adapter.dev);

I find this neater.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi

