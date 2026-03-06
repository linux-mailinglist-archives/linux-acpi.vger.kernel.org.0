Return-Path: <linux-acpi+bounces-21465-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAGKJMAhqmmJLwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21465-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:37:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6C219DE9
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31FF7300D341
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0012D7814;
	Fri,  6 Mar 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4XY3rKd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8C2D6E5A;
	Fri,  6 Mar 2026 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757436; cv=none; b=n/OXa4CoX3alSOsoy9q0X5/YXXiHv/hWk0xa7R9OGlEXNOcwNNmutE6sxX1URps/qPuJdaIlV9ZTUKXFe6aw/8ol7L+2UG26JsNjqb5FC22CIIZB4lDykG+TDtiBqtOgq9ONeheHEWz1Rzs2mN04IvQkiqQF9RgTOGqSPSo11pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757436; c=relaxed/simple;
	bh=oC0WG6ItKUCSxYMHU2SvjasflD+xGQ+gzl/C4UFO9rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHVp8zAyYtiVBqgogwC4HKv1gtAJy9VOCVARPdKD8bNZFpZ++8kLlTjg4CJHenBtlJU9gMM5p+tiy+k35+bl1ii7gY7gbeyB9Vh8vBJGoOAvCw0l65MCTPlzn3GJ8iAyCkmx7oGuefLscDYBOi3zFeZw+zQYYQYdoikZ1kGiNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4XY3rKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62593C116C6;
	Fri,  6 Mar 2026 00:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772757435;
	bh=oC0WG6ItKUCSxYMHU2SvjasflD+xGQ+gzl/C4UFO9rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4XY3rKdpaWXGYVvXVy2J7kf45PK9Zk/WeZDdRFTqG0Ypi1WrzCsv396e28n6QAnR
	 szI2MH2+RO7ICkFUsmJwLsWJQQ4DW5UlluU44Adx0cfDMoo8Y5TnF35O1166ffFrGp
	 axw4VWvMDaZsttVeWUJYLZIWboclRv6Lu6XLm2EQIz8zViHtXqdZWo+kAwsqBHj7Ye
	 t/V+RPCy6GCfKVnWduwPSzzgs92RUiARceA3QUPrMFdB14L5gJ0Or9/GGXsA8iyRkU
	 25ZE9HRFuLsK+d1zSBztQ0hAMGIWNiNxKeBB1m0ga1wIBDaRA0RGzfMv5uTnA9GQz2
	 olcrQsw2oLANw==
Date: Thu, 5 Mar 2026 18:37:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	linux-kbuild@vger.kernel.org, linux-acpi@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <177275743363.863482.4907350402954584802.robh@kernel.org>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
X-Rspamd-Queue-Id: 23D6C219DE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,squebb.ca,bgdev.pl,oss.qualcomm.com,linux.dev,holtmann.org,linaro.org,gmail.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-21465-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]
X-Rspamd-Action: no action


On Tue, 24 Feb 2026 11:00:51 +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card,
> but that is not covered in this binding.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 184 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 185 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


