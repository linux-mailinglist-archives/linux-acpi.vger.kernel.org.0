Return-Path: <linux-acpi+bounces-7736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22D958E31
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5341F237C5
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E414A09E;
	Tue, 20 Aug 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rliiBxSj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B004210EE;
	Tue, 20 Aug 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179467; cv=none; b=dsm3eJjXfA6kvY8QVnt9J2a+g9tI8N70Bdo7ZUz4QPZrQ7c9gQM3qsQt6R8c8lXDDROLNGaxkuVPnio6WygcCYYQ+bAEIltZ7kFC7GwmIdctmj+cWb5O3/VfQgKLMLcowb/IUaej0QpmrAVzabDqtXUsb3Vo46WcpIZnM8ho7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179467; c=relaxed/simple;
	bh=R/txcs1DZkukly3Qa0Vt3JIrM10BbblB1vJcIw6/Yq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lr79x7LvOFGo+d/GZwwpkyTL89Uim6IHuiYF2ynmTCBYLEdGPnuQq0tN/Ad9kz1sWkb2qSTOLH1cMoPjPVchsI3YlOxTIX1RahiOwCLIBYQJEL+q+s2sj0qtImJKsO0gxNfjg4ggGTvOLiI+x27dJJItD491mY4p1ms+9fH+jTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rliiBxSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A5C4AF17;
	Tue, 20 Aug 2024 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724179466;
	bh=R/txcs1DZkukly3Qa0Vt3JIrM10BbblB1vJcIw6/Yq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rliiBxSjFnjRgV0xG3x/qTaAvHoVWNLmRb0wKuTy2oPrAmwnkwsP22UkvwhsXTIL3
	 F4dxD5FiaDReJIUlHPyTU2loYJXasYBu20Q2ibWG07aJtW81dvqdfL7NfmUCBCWe2A
	 9hGNH2HZ+fJnjNWIYGotEr8FUouWMqGFPWocX60/G7eGkr5CY4dql0KmXCXpjHKjEj
	 BeslEFR6tpTI59xZLd7vuRD8/gYfmGPtgUvDWxE1AEOVwghPbQIdiHkeXQtDheq0Wm
	 bA1IXutwpO9Ztp+5LVZdKJtKlKqDO5iAJkAWOOTpKkazVmrgiAdLg+iiqwqNNnP32h
	 RwwsvQ9IRG8/w==
Date: Tue, 20 Aug 2024 13:44:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Petr Valenta <petr@jevklidu.cz>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: ACPI IRQ storm with 6.10
Message-ID: <20240820184424.GA216935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b7159-076a-4064-8333-69c454972b29@kernel.org>

[+to Tony, Przemek for e1000e questions; -cc Jesse]

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

I don't remember if it was intentional, but the use of
__E1000_RESETTING is a bit subtle and I don't know what is correct.

Here's how it was used before I changed it with b2c289415b2b, i.e., in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/e1000e/ethtool.c?id=39f59c72ad3a:

  e1000_set_link_ksettings(...)
  {
    if (hw->phy.ops.check_reset_block(hw)) {
      ret_val = -EINVAL;
      goto out;
    }
    while (test_and_set_bit(__E1000_RESETTING, &adapter->state))
      usleep_range(1000, 2000);
    if (err) {
      ret_val = -EINVAL;
      goto out;
    }
    ...
  out:
    clear_bit(__E1000_RESETTING, &adapter->state);
  }

In this case, we *always* clear __E1000_RESETTING, even if we bail out
before the test_and_set_bit(__E1000_RESETTING).

It makes sense to me that we clear __E1000_RESETTING after we've set
it via test_and_set_bit() because we know it was set *here*.

But it seems wrong to me that we clear __E1000_RESETTING even when we
haven't done the test_and_set_bit() because it may have been set by a
concurrent thread executing a different operation.

  e1000_set_ringparam(...)
  {
    if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
      return -EINVAL;
    while (test_and_set_bit(__E1000_RESETTING, &adapter->state))
      usleep_range(1000, 2000);
    err = e1000e_setup_tx_resources(...);
    if (err)
      goto out;
    ...
  out:
    clear_bit(__E1000_RESETTING, &adapter->state);
  }

But here, we *don't* clear __E1000_RESETTING if we bail out before the
test_and_set_bit(__E1000_RESETTING).  This seems like the correct
behavior.

In the e1000 driver (not the e1000e driver),
e1000_set_link_ksettings() does *not* clear __E1000_RESETTING unless
it has already done the test_and_set_bit().

b2c289415b2b changed e1000e to work that way, too.

FWIW, 3ef672ab1862 ("e1000e: ethtool unnecessarily takes device out of
RPM suspend") changed e1000e e1000_set_link_ksettings() to clear
__E1000_RESETTING even when bailing out before the test_and_set_bit().
That part of 3ef672ab1862 looks possibly buggy to me.

Bjorn

