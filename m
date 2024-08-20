Return-Path: <linux-acpi+bounces-7741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86A1958FAF
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15181C21A8C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8471C57B4;
	Tue, 20 Aug 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhFyFhra"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF651C579D;
	Tue, 20 Aug 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189438; cv=none; b=I0I3nfVUVY6ioSRwbq+xaEPApsO3n7ktIfWS3isacffO/E3x4rsY8rJti4otyFy3WuN/1iieuH8NpqxhFB10pbA+AbixrA9Gf65ddJ5Jx9uPykcn8w+7ER+nuZ9/6nWw163tbFTNHZNBLneo6bfF1uSqlOOp1nZC1x8/AaKjo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189438; c=relaxed/simple;
	bh=0t79HOH2kYVclDTTF8FvHw6OfaaM4JS6jorC17zXI3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C8hsKAqbG2in38WeQ3b/1WlIc4SDwHjMbhGwRu5TOyD0H5+gHnPSVdeVZNt7fuVLc64S1xw0BZr+mDcnhUnFkkn2c4wctcIDRMNA5sRtYuk26srFc5d3xSJBEyw68lHFlg9QfhePkcX6e/r4DTqyJ86sfMlTN8EcRp8gHxYKWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhFyFhra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A00BC4AF09;
	Tue, 20 Aug 2024 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724189437;
	bh=0t79HOH2kYVclDTTF8FvHw6OfaaM4JS6jorC17zXI3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GhFyFhraHJm9t4ey15N3XxG5Bc8U2z1N5/4pJSFm4vNlndjUOQltzb39mj8r5tzdO
	 0Qrk2iUfn9usdQTfr3eHowUDbvxoFI6z/iFJUe0kPts5eaue6Z5J1ESezm6daA6gwZ
	 yJtcho1EXrvEH0dGBx7xhKIKBezS0BAXW2lbUFKuTB9YSHJvprlgy0VZjDNjg/G3WL
	 4nV3cEtNJ3EiMYMMNl9JNQtJDhvg/VIeHBFzQPJHHzBh+gZ4MmwNPJSkTNCDceZicW
	 OJIm3Vprxxg/osSezx/ysd0VAXqV7ywftKaXHshPID8u49v2SiJtBafOh/+7jMlh+U
	 CASP86+QHj9sA==
Date: Tue, 20 Aug 2024 16:30:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Petr Valenta <petr@jevklidu.cz>
Cc: Jiri Slaby <jirislaby@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI IRQ storm with 6.10
Message-ID: <20240820213035.GA226181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec28d20-c729-496a-b8bf-2bf88bbb4d70@jevklidu.cz>

On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
> > On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
> > > On 19. 08. 24, 6:50, Jiri Slaby wrote:
> > > > CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)
> > > 
> > > Bjorn,
> > > 
> > > I am confused by these changes:
> > > ==========================================
> > > @@ -291,16 +288,13 @@ static int e1000_set_link_ksettings(struct net_device
> > > *net
> > > dev,
> > >           * duplex is forced.
> > >           */
> > >          if (cmd->base.eth_tp_mdix_ctrl) {
> > > -               if (hw->phy.media_type != e1000_media_type_copper) {
> > > -                       ret_val = -EOPNOTSUPP;
> > > -                       goto out;
> > > -               }
> > > +               if (hw->phy.media_type != e1000_media_type_copper)
> > > +                       return -EOPNOTSUPP;
> > > 
> > >                  if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
> > >                      (cmd->base.autoneg != AUTONEG_ENABLE)) {
> > >                          e_err("forcing MDI/MDI-X state is not supported when
> > > lin
> > > k speed and/or duplex are forced\n");
> > > -                       ret_val = -EINVAL;
> > > -                       goto out;
> > > +                       return -EINVAL;
> > >                  }
> > >          }
> > > 
> > > @@ -347,7 +341,6 @@ static int e1000_set_link_ksettings(struct net_device
> > > *netde
> > > v,
> > >          }
> > > 
> > >   out:
> > > -       pm_runtime_put_sync(netdev->dev.parent);
> > >          clear_bit(__E1000_RESETTING, &adapter->state);
> > >          return ret_val;
> > >   }
> > > ==========================================
> > > 
> > > So no more clear_bit(__E1000_RESETTING in the above fail paths. Is that
> > > intentional?
> > 
> > Not intentional.  Petr, do you have the ability to test the patch
> > below?  I'm not sure it's the correct fix, but it reverts the pieces
> > of b2c289415b2b that Jiri pointed out.
> 
> I tested the patch below but it didn't help. After the first boot with new
> kernel it looked promising as the irq storm only appeared for a few seconds,
> but with subsequent reboots it was the same as without the patch.

Thank you very much for testing that!

> To be sure, I also send the md5sum of ethtool.c after applying the patch:
> 
> a25c003257538f16994b4d7c4260e894 ethtool.c

Thanks, that matches what I get when applying the patch on v6.10.

I'm at a loss.  You could try reverting the entire b2c289415b2b commit
(patch for that is below).

If that doesn't help, I guess you could try reverting the other
commits Jiri mentioned:

  76a0a3f9cc2f e1000e: fix force smbus during suspend flow
  c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
  bfd546a552e1 e1000e: move force SMBUS near the end of enable_ulp function
  6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
  1eb2cded45b3 net: annotate writes on dev->mtu from ndo_change_mtu()
  b2c289415b2b e1000e: Remove redundant runtime resume for ethtool_ops
  75a3f93b5383 net: intel: implement modern PM ops declarations

If you do this, I would revert 76a0a3f9cc2f, test, then revert
c93a6f62cb1b in addition, test, then revert bfd546a552e1 in addition,
etc.

commit 5e92945ffe5c ("Revert "e1000e: Remove redundant runtime resume for ethtool_ops"")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Aug 20 16:18:32 2024 -0500

    Revert "e1000e: Remove redundant runtime resume for ethtool_ops"
    
    This reverts commit b2c289415b2b2ef112b78d5e73b4acecf5db409e.


diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..61fa2f6b3708 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -156,7 +156,7 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 			speed = adapter->link_speed;
 			cmd->base.duplex = adapter->link_duplex - 1;
 		}
-	} else {
+	} else if (!pm_runtime_suspended(netdev->dev.parent)) {
 		u32 status = er32(STATUS);
 
 		if (status & E1000_STATUS_LU) {
@@ -274,13 +274,16 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	ethtool_convert_link_mode_to_legacy_u32(&advertising,
 						cmd->link_modes.advertising);
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	/* When SoL/IDER sessions are active, autoneg/speed/duplex
 	 * cannot be changed
 	 */
 	if (hw->phy.ops.check_reset_block &&
 	    hw->phy.ops.check_reset_block(hw)) {
 		e_err("Cannot change link characteristics when SoL/IDER is active.\n");
-		return -EINVAL;
+		ret_val = -EINVAL;
+		goto out;
 	}
 
 	/* MDI setting is only allowed when autoneg enabled because
@@ -288,13 +291,16 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
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
 
@@ -341,6 +347,7 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	}
 
 out:
+	pm_runtime_put_sync(netdev->dev.parent);
 	clear_bit(__E1000_RESETTING, &adapter->state);
 	return ret_val;
 }
@@ -376,6 +383,8 @@ static int e1000_set_pauseparam(struct net_device *netdev,
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	if (adapter->fc_autoneg == AUTONEG_ENABLE) {
 		hw->fc.requested_mode = e1000_fc_default;
 		if (netif_running(adapter->netdev)) {
@@ -408,6 +417,7 @@ static int e1000_set_pauseparam(struct net_device *netdev,
 	}
 
 out:
+	pm_runtime_put_sync(netdev->dev.parent);
 	clear_bit(__E1000_RESETTING, &adapter->state);
 	return retval;
 }
@@ -438,6 +448,8 @@ static void e1000_get_regs(struct net_device *netdev,
 	u32 *regs_buff = p;
 	u16 phy_data;
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
 
 	regs->version = (1u << 24) |
@@ -483,6 +495,8 @@ static void e1000_get_regs(struct net_device *netdev,
 	e1e_rphy(hw, MII_STAT1000, &phy_data);
 	regs_buff[24] = (u32)phy_data;	/* phy local receiver status */
 	regs_buff[25] = regs_buff[24];	/* phy remote receiver status */
+
+	pm_runtime_put_sync(netdev->dev.parent);
 }
 
 static int e1000_get_eeprom_len(struct net_device *netdev)
@@ -515,6 +529,8 @@ static int e1000_get_eeprom(struct net_device *netdev,
 	if (!eeprom_buff)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	if (hw->nvm.type == e1000_nvm_eeprom_spi) {
 		ret_val = e1000_read_nvm(hw, first_word,
 					 last_word - first_word + 1,
@@ -528,6 +544,8 @@ static int e1000_get_eeprom(struct net_device *netdev,
 		}
 	}
 
+	pm_runtime_put_sync(netdev->dev.parent);
+
 	if (ret_val) {
 		/* a read error occurred, throw away the result */
 		memset(eeprom_buff, 0xff, sizeof(u16) *
@@ -577,6 +595,8 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	ptr = (void *)eeprom_buff;
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	if (eeprom->offset & 1) {
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
@@ -617,6 +637,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		ret_val = e1000e_update_nvm_checksum(hw);
 
 out:
+	pm_runtime_put_sync(netdev->dev.parent);
 	kfree(eeprom_buff);
 	return ret_val;
 }
@@ -712,6 +733,8 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		}
 	}
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	e1000e_down(adapter, true);
 
 	/* We can't just free everything and then setup again, because the
@@ -750,6 +773,7 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		e1000e_free_tx_resources(temp_tx);
 err_setup:
 	e1000e_up(adapter);
+	pm_runtime_put_sync(netdev->dev.parent);
 free_temp:
 	vfree(temp_tx);
 	vfree(temp_rx);
@@ -1792,6 +1816,8 @@ static void e1000_diag_test(struct net_device *netdev,
 	u8 autoneg;
 	bool if_running = netif_running(netdev);
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	set_bit(__E1000_TESTING, &adapter->state);
 
 	if (!if_running) {
@@ -1877,6 +1903,8 @@ static void e1000_diag_test(struct net_device *netdev,
 	}
 
 	msleep_interruptible(4 * 1000);
+
+	pm_runtime_put_sync(netdev->dev.parent);
 }
 
 static void e1000_get_wol(struct net_device *netdev,
@@ -2018,11 +2046,15 @@ static int e1000_set_coalesce(struct net_device *netdev,
 		adapter->itr_setting = adapter->itr & ~3;
 	}
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	if (adapter->itr_setting != 0)
 		e1000e_write_itr(adapter, adapter->itr);
 	else
 		e1000e_write_itr(adapter, 0);
 
+	pm_runtime_put_sync(netdev->dev.parent);
+
 	return 0;
 }
 
@@ -2036,7 +2068,9 @@ static int e1000_nway_reset(struct net_device *netdev)
 	if (!adapter->hw.mac.autoneg)
 		return -EINVAL;
 
+	pm_runtime_get_sync(netdev->dev.parent);
 	e1000e_reinit_locked(adapter);
+	pm_runtime_put_sync(netdev->dev.parent);
 
 	return 0;
 }
@@ -2050,8 +2084,12 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 	int i;
 	char *p = NULL;
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	dev_get_stats(netdev, &net_stats);
 
+	pm_runtime_put_sync(netdev->dev.parent);
+
 	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
 		switch (e1000_gstrings_stats[i].type) {
 		case NETDEV_STATS:
@@ -2108,7 +2146,9 @@ static int e1000_get_rxnfc(struct net_device *netdev,
 		struct e1000_hw *hw = &adapter->hw;
 		u32 mrqc;
 
+		pm_runtime_get_sync(netdev->dev.parent);
 		mrqc = er32(MRQC);
+		pm_runtime_put_sync(netdev->dev.parent);
 
 		if (!(mrqc & E1000_MRQC_RSS_FIELD_MASK))
 			return 0;
@@ -2171,9 +2211,13 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
+	if (ret_val) {
+		pm_runtime_put_sync(netdev->dev.parent);
 		return -EBUSY;
+	}
 
 	/* EEE Capability */
 	ret_val = e1000_read_emi_reg_locked(hw, cap_addr, &phy_data);
@@ -2213,6 +2257,8 @@ static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	if (ret_val)
 		ret_val = -ENODATA;
 
+	pm_runtime_put_sync(netdev->dev.parent);
+
 	return ret_val;
 }
 
@@ -2253,12 +2299,16 @@ static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 
 	hw->dev_spec.ich8lan.eee_disable = !edata->eee_enabled;
 
+	pm_runtime_get_sync(netdev->dev.parent);
+
 	/* reset the link */
 	if (netif_running(netdev))
 		e1000e_reinit_locked(adapter);
 	else
 		e1000e_reset(adapter);
 
+	pm_runtime_put_sync(netdev->dev.parent);
+
 	return 0;
 }
 

