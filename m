Return-Path: <linux-acpi+bounces-7735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A846F958DCD
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44414B21E38
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA91C0DF8;
	Tue, 20 Aug 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8k2MJlh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07201BDA8C;
	Tue, 20 Aug 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177395; cv=none; b=bnAWjmZqBJPKvCYmG2VpdKlRVa+xgZou8IfjsSXPVDvcfJ5OVggSbEIrk1KL07JjSPgFfqsJYjsjgLWpENBpA0OHU5rK8ACYn1tdqir4/SG29hKOhjGP2IenuyOaKW8NzvdEiFMT9Mq9cVq7pIWV6sBL14mEmbtUhqVUtt80KRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177395; c=relaxed/simple;
	bh=dsZSsTHCSmyV6T/HkBCcmiJ+V5vOuti6g8kY5++amGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kWV0takNxTnMzVIG1qJ3ZfQubQ/8XSm432GdVQvEE5b0rfjG1rK+uZF6E+jlqp/dHOvDBdlwWx7uyxIQ/l7VRsTDmKvu/Q1qYKAajPI1MgGYHcu9dUf8VEnMGJmxEhFHr5cr3A/zkhh99v6JB7pDQB+dq6i3FkL0yEJ2EeXLNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8k2MJlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E8C4AF0E;
	Tue, 20 Aug 2024 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724177395;
	bh=dsZSsTHCSmyV6T/HkBCcmiJ+V5vOuti6g8kY5++amGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N8k2MJlhET5rv+1jo4tv5ZBudM9YrFu2mVRe1/LgB+1ZvMGY7Tm1DKNSLR86DGiJI
	 OA9J8eSiF4/nNO9B0H6aHsFnB+Ce/UFCW8euHssufXCYACgvv5tBHVT8W/t32DRb5s
	 XD2yMMoXTj4Rgyyq1hd8WsnbkXQBSSsQm9TnPTwK5V4Phc31W/07qpC0bC2AkSKTFF
	 dRnboBz7W2gG4JjxazgocTmpEkRR1/aQvmKk2/FI7eie4JNNPNRS4CH8t+aN6cj03d
	 +Mkmh1IPiApyuZ/YRWny2G21MAfw21XaMb9ebvk299nyPknhYRYHid689O+LehIfWW
	 IJRU//hL1vIPA==
Date: Tue, 20 Aug 2024 13:09:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, Petr Valenta <petr@jevklidu.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI IRQ storm with 6.10
Message-ID: <20240820180952.GA217979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b7159-076a-4064-8333-69c454972b29@kernel.org>

[+to Petr, -cc Jesse, bouncing]

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

Not intentional.  Petr, do you have the ability to test the patch
below?  I'm not sure it's the correct fix, but it reverts the pieces
of b2c289415b2b that Jiri pointed out.

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..9db36ee71684 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -280,7 +280,8 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	if (hw->phy.ops.check_reset_block &&
 	    hw->phy.ops.check_reset_block(hw)) {
 		e_err("Cannot change link characteristics when SoL/IDER is active.\n");
-		return -EINVAL;
+		ret_val = -EINVAL;
+		goto out;
 	}
 
 	/* MDI setting is only allowed when autoneg enabled because
@@ -288,13 +289,16 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	 * duplex is forced.
 	 */
 	if (cmd->base.eth_tp_mdix_ctrl) {
-		if (hw->phy.media_type != e1000_media_type_copper)
-			return -EOPNOTSUPP;
+		if (hw->phy.media_type != e1000_media_type_copper) {
+			ret_val = -EOPNOTSUPP;
+			goto out;
+		}
 
 		if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
 		    (cmd->base.autoneg != AUTONEG_ENABLE)) {
 			e_err("forcing MDI/MDI-X state is not supported when link speed and/or duplex are forced\n");
-			return -EINVAL;
+			ret_val = -EINVAL;
+			goto out;
 		}
 	}
 

