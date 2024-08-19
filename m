Return-Path: <linux-acpi+bounces-7673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED909570B1
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2228329B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628117557E;
	Mon, 19 Aug 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFx7RQGD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A81422D2;
	Mon, 19 Aug 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086062; cv=none; b=Cxm3fpg34nZBvYQU+fsaF8ecC5iVcW5TQikc3iMqqTzk9jKNiwlQ9m248BG/HBC3dnVLOv0o3idUDKcJ02x9GBIhLD4P7kUDLVMPa1uDnETnWcHqF0EAXKe26RgmtkiodWYq6axc25Us/1AOUWlxdQk9Z7RQ8Lw5aJp9r0rmVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086062; c=relaxed/simple;
	bh=AKwTNHLgA+6APIxNBMqNwEfniEaV2liiz8suz5WwnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sxGff6YyVDUqchnOsrIUhan/hjfFmnne7FOkCimzBLn0XL70tagKc/Trgg8Wj1/3y8Ca/TWeIUuqt954oJSOaG0OayKrkMV0umMN0RhX0mLstvzy/5QyJ/4qHTvpgh8TYqj7iW9VwRzbZYCvCNMQEcQVI/dNAyzV1L1j4HKess0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFx7RQGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2481AC32782;
	Mon, 19 Aug 2024 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724086062;
	bh=AKwTNHLgA+6APIxNBMqNwEfniEaV2liiz8suz5WwnOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tFx7RQGDu+Zz+KfB/IrBweL3kUJ2q2YhPRjG7fSZHNJ3623goj1a3Cfc2776b54lz
	 MGZwj1ZPBI13XK5Kwi81RG8lPEdnJMfos100gGtfSp8t0ktd9kxSnYa9/tzkF28yxY
	 hXzjwFWvual5Cu4kWDKv8JgzMNenIX3SaqtnxqpUqRrx5lFez06ZqCMNLZk8djrsr2
	 kA5uKCEaLfjXw+qzqD618LYzZ0MxiHLitm3MpmACVNjFmbn+a4I5WEsOUvmLwlPrEj
	 aNSIDClhbwtpQghtCT3SZoBwwZGwHHzMXCTNMWzDq0ViK4HfjmQ+uBnlSIzt3w7Jjo
	 Rd6JPMsYC2y9A==
Date: Mon, 19 Aug 2024 11:47:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Petr Valenta <petr@jevklidu.cz>
Subject: Re: ACPI IRQ storm with 6.10
Message-ID: <20240819164739.GA160626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b7159-076a-4064-8333-69c454972b29@kernel.org>

On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
> On 19. 08. 24, 6:50, Jiri Slaby wrote:
> > CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)
> 
> Bjorn,
> 
> I am confused by these changes:
> ==========================================
> @@ -291,16 +288,13 @@ static int e1000_set_link_ksettings(struct net_device
> *net
> dev,
>          * duplex is forced.
>          */
>         if (cmd->base.eth_tp_mdix_ctrl) {
> -               if (hw->phy.media_type != e1000_media_type_copper) {
> -                       ret_val = -EOPNOTSUPP;
> -                       goto out;
> -               }
> +               if (hw->phy.media_type != e1000_media_type_copper)
> +                       return -EOPNOTSUPP;
> 
>                 if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
>                     (cmd->base.autoneg != AUTONEG_ENABLE)) {
>                         e_err("forcing MDI/MDI-X state is not supported when
> lin
> k speed and/or duplex are forced\n");
> -                       ret_val = -EINVAL;
> -                       goto out;
> +                       return -EINVAL;
>                 }
>         }
> 
> @@ -347,7 +341,6 @@ static int e1000_set_link_ksettings(struct net_device
> *netde
> v,
>         }
> 
>  out:
> -       pm_runtime_put_sync(netdev->dev.parent);
>         clear_bit(__E1000_RESETTING, &adapter->state);
>         return ret_val;
>  }
> ==========================================
> 
> So no more clear_bit(__E1000_RESETTING in the above fail paths. Is that
> intentional?

No, not intentional, looks like I just blew it, sorry.  Will post a
fix soon.  Thanks a lot for debugging this.

Bjorn

