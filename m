Return-Path: <linux-acpi+bounces-6190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85818FC83D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB5B23DC2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD3191466;
	Wed,  5 Jun 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HKztHKAy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com [220.197.32.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECE190045;
	Wed,  5 Jun 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580514; cv=none; b=s7KzfjteOZnFIrGjGWGJ/4cJaStNS7ci+ih2E8q3/QQeHfMixYC1ECpuks5oh611VsV7/zeO0bknwzifQLjITZbOlmb/TNeH+jjW3gDa/ebnIjEsz3asf+EXkSj/kCodBSW4oXT9EeTHd2HcLKtg8CYHbnpKp6u2Wcxxchnpfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580514; c=relaxed/simple;
	bh=aBy7vIst2FBAPwGPshMP9IQOR/ZWBTluJmQmKcqLFng=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B1Wuc9HdBAEh1qrWOZTOhpUIVL3yX6YpnYFtiVbsn0lFEH+xavNs83nOIynYdacxyu/7Lw5salveSfAxH85Af9V71ZyPqAsa1Ekptc/glfJAr3yXjkop41hI8vzJGo5trqs8b0nJlVe9TMdPlCRt+VNXi+TxsH3oWCiG+JJCDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HKztHKAy; arc=none smtp.client-ip=220.197.32.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=HKztHKAyn248J+U2sZbJUYIvNPzdyC8CP+mQ2KjqyTNYmiJhDfssPyipAMYZ5xPA/cLDR1afFNhE7W70ylj2c66NwNIfS49E1VD7eFCIEdzXNhd637fXZ8HBO+Qj2sjnt6VlG3sN7uImQPVEaJE6vZZ1JrqPCtudIeKdzg6gBO0=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=DQv58ir20XJLj4kjCZ4hNT8DMmOKn/UVGcDrVAwYVW0=;
	h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.56] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 2C7771A0423;
	Wed,  5 Jun 2024 11:06:01 +0800 (CST)
Message-ID: <10f48a9b-d66a-439e-80d3-54f8e01f015e@rock-chips.com>
Date: Wed, 5 Jun 2024 11:05:59 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bjorn.andersson@linaro.org
Cc: andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
 djrscally@gmail.com, gregkh@linuxfoundation.org, hdegoede@redhat.com,
 heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, rafael@kernel.org, robh+dt@kernel.org,
 sakari.ailus@linux.intel.com, =?UTF-8?B?5ZC06Imv5bOw?=
 <william.wu@rock-chips.com>, yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20220422222351.1297276-6-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 5/7] usb: typec: mux: Allow multiple mux_devs per mux
Content-Language: en-US
Reply-To: 20220422222351.1297276-1-bjorn.andersson@linaro.org
From: Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20220422222351.1297276-6-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUtIVksaSkpLTUIZShgfGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8fe65c587c03abkunm2c7771a0423
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Djo*EjNMQzJDEQ8SNxAx
	PywaCRNVSlVKTEpMTk5NTE1ISEtDVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9KTUI3Bg++

Hi Bjorn,

> In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
> switching of the SuperSpeed lines, but the SBU lines needs to be
> connected and switched by external (to the SoC) hardware.
>
> It's therefor necessary to be able to have the TypeC controller operate
> multiple TypeC muxes and switches. Use the newly introduced indirection
> object to handle this, to avoid having to taint the TypeC controllers
> with knowledge about the downstream hardware configuration.
>
> The max number of devs per indirection is set to 3, which account for
> being able to mux/switch the USB HS, SS and SBU lines, as per defined
> defined in the usb-c-connector binding. This number could be grown if
> need arrises at a later point in time.
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - None
>
>   drivers/usb/typec/mux.c  <https://lore.kernel.org/all/20220422222351.1297276-6-bjorn.andersson@linaro.org/#Z31drivers:usb:typec:mux.c>  | 128 ++++++++++++++++++++++++++++++++--------
>   1 filechanged  <https://lore.kernel.org/all/20220422222351.1297276-6-bjorn.andersson@linaro.org/#related>, 102 insertions(+), 26 deletions(-)

With this commit, TCPC device shall match *two* endpoint port both for switch device and mux device
if they have the same parent node like the following DT. It causes the callback funtion is invoked
twice both for switch and mux in tcpm_mux_set() process.

arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts

&usbdp_phy0 {
         mode-switch;
         orientation-switch;
         [...]
         port {
                 #address-cells = <1>;
                 #size-cells = <0>;

                 usbdp_phy0_orientation_switch: endpoint@0 {
                         reg = <0>;
                         remote-endpoint = <&usbc0_orien_sw>;
                 };

                 usbdp_phy0_dp_altmode_mux: endpoint@1 {
                         reg = <1>;
                         remote-endpoint = <&dp_altmode_mux>;
                 };
         };
};

BR.
Frank


