Return-Path: <linux-acpi+bounces-7740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03C958F8A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AFE1C21472
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B91C579D;
	Tue, 20 Aug 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b="gfjM65wv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300101C57A7;
	Tue, 20 Aug 2024 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188457; cv=pass; b=AHtkVMOLm202ow3KyWL/c5s6XOZK1MsGAAvUh7WqW5HvyLJMPx/8A591hQk+MXdLmAde55s0ZFOAefYecCRkBRtcHdUxhJZ3eE+6Y8Q0C3+KyUJtKITI+gmpUztcgNeCuiityeajPtXym3M6xZ6bJ8HHsdxAAKeXn8tAfY7o1k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188457; c=relaxed/simple;
	bh=iQcZCIQuE7z+MWtObJKVOdi8N46uoOEHZoUaAeS2o5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9UKhHiXxbHK3LdcImSq2w65AtRNWuwP0AI/vE/1W9SR8zA4LWNh9uRH/S6fiYwMLGbymPGMBDgaoms/TOmFpyERHyTYVx17nO5bjCyJbcEWPZKy7B7J8zKhKdw5/8LgpLPJM+HcwyihbL2RMv2Vvn9hBs/Sijfm43Ij2YzcWcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz; spf=pass smtp.mailfrom=jevklidu.cz; dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b=gfjM65wv; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jevklidu.cz
ARC-Seal: i=1; a=rsa-sha256; t=1724188442; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XgwUiGPDQfkbe7/DE86c/wlUPudOjaYrTgsQwmHvJP8W1kX0j+BfuXJB9uCSkH7dLgN9KUjbhgnhn1S0mcIIakKDG7n3lqNFYzMKpWNWoegoJKgsum4c4I4PaXJJ4OqP2qmSySDAu3/Bg48kWE5NJAKwpnJc3b0+F5YeQWDbaQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724188442; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ELfzGSU85Ube/i21ISp5VK7kSe9amSr2lKEG2/Vg88Q=; 
	b=AvaVi8ioUWKvYFBKSzbvBEiIRFIUzlMWTDRqdbB8RXtplHbcPMt0ZCBkyThQ3nBx0L98qra81TXMltVqKypAUXXewupbyZRpBPdIHEaI9jf1HtPxJB5Cf98YKcYgcGB7P1oxY27qdbrblyUnQF+/mpscHqRazKkc6KHnQvNnQAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=jevklidu.cz;
	spf=pass  smtp.mailfrom=petr@jevklidu.cz;
	dmarc=pass header.from=<petr@jevklidu.cz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724188442;
	s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ELfzGSU85Ube/i21ISp5VK7kSe9amSr2lKEG2/Vg88Q=;
	b=gfjM65wvvqAxR8k4L1ciKz1ZZUbT1MRfaVvxZcdd2EloJ8lm8nPTY+6K4HryPGw6
	3FLGI/Bl/vxcVE8llS785UAggco7b+kQyWtdSW4vfH2u6jdVCtr+Lwgjh4Qrezy5tio
	TDQ5UxZACk4zfL0IJ4jy8tBm3XXh/LF7Nw93+Aew=
Received: by mx.zohomail.com with SMTPS id 1724188440687689.5836446683727;
	Tue, 20 Aug 2024 14:14:00 -0700 (PDT)
Message-ID: <7ec28d20-c729-496a-b8bf-2bf88bbb4d70@jevklidu.cz>
Date: Tue, 20 Aug 2024 23:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
To: Bjorn Helgaas <helgaas@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240820180952.GA217979@bhelgaas>
Content-Language: cs-CZ
From: Petr Valenta <petr@jevklidu.cz>
In-Reply-To: <20240820180952.GA217979@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
> [+to Petr, -cc Jesse, bouncing]
> 
> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)
>>
>> Bjorn,
>>
>> I am confused by these changes:
>> ==========================================
>> @@ -291,16 +288,13 @@ static int e1000_set_link_ksettings(struct net_device
>> *net
>> dev,
>>           * duplex is forced.
>>           */
>>          if (cmd->base.eth_tp_mdix_ctrl) {
>> -               if (hw->phy.media_type != e1000_media_type_copper) {
>> -                       ret_val = -EOPNOTSUPP;
>> -                       goto out;
>> -               }
>> +               if (hw->phy.media_type != e1000_media_type_copper)
>> +                       return -EOPNOTSUPP;
>>
>>                  if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
>>                      (cmd->base.autoneg != AUTONEG_ENABLE)) {
>>                          e_err("forcing MDI/MDI-X state is not supported when
>> lin
>> k speed and/or duplex are forced\n");
>> -                       ret_val = -EINVAL;
>> -                       goto out;
>> +                       return -EINVAL;
>>                  }
>>          }
>>
>> @@ -347,7 +341,6 @@ static int e1000_set_link_ksettings(struct net_device
>> *netde
>> v,
>>          }
>>
>>   out:
>> -       pm_runtime_put_sync(netdev->dev.parent);
>>          clear_bit(__E1000_RESETTING, &adapter->state);
>>          return ret_val;
>>   }
>> ==========================================
>>
>> So no more clear_bit(__E1000_RESETTING in the above fail paths. Is that
>> intentional?
> 
> Not intentional.  Petr, do you have the ability to test the patch
> below?  I'm not sure it's the correct fix, but it reverts the pieces
> of b2c289415b2b that Jiri pointed out.
> 

I tested the patch below but it didn't help. After the first boot with 
new kernel it looked promising as the irq storm only appeared for a few 
seconds, but with subsequent reboots it was the same as without the patch.

To be sure, I also send the md5sum of ethtool.c after applying the patch:

a25c003257538f16994b4d7c4260e894 ethtool.c

> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 9364bc2b4eb1..9db36ee71684 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -280,7 +280,8 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
>   	if (hw->phy.ops.check_reset_block &&
>   	    hw->phy.ops.check_reset_block(hw)) {
>   		e_err("Cannot change link characteristics when SoL/IDER is active.\n");
> -		return -EINVAL;
> +		ret_val = -EINVAL;
> +		goto out;
>   	}
>   
>   	/* MDI setting is only allowed when autoneg enabled because
> @@ -288,13 +289,16 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
>   	 * duplex is forced.
>   	 */
>   	if (cmd->base.eth_tp_mdix_ctrl) {
> -		if (hw->phy.media_type != e1000_media_type_copper)
> -			return -EOPNOTSUPP;
> +		if (hw->phy.media_type != e1000_media_type_copper) {
> +			ret_val = -EOPNOTSUPP;
> +			goto out;
> +		}
>   
>   		if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
>   		    (cmd->base.autoneg != AUTONEG_ENABLE)) {
>   			e_err("forcing MDI/MDI-X state is not supported when link speed and/or duplex are forced\n");
> -			return -EINVAL;
> +			ret_val = -EINVAL;
> +			goto out;
>   		}
>   	}
>   

