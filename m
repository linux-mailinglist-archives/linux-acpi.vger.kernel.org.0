Return-Path: <linux-acpi+bounces-21121-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLA7Lx57nWmAQAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21121-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:19:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA121853AE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B5131AA9D5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FA4378805;
	Tue, 24 Feb 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2i13CEQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85706377560
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928180; cv=none; b=BrO4DLgiBMGhqx2zRR1UMwJZATdzS3UZm688QKrH+DDLt4na21+OHv4npe60qr/3qMF1a7sTzq9sZJFxJBbH4u9LiyMBWv2GJVEsM5Pvn1IGdchvaB/rQdTPf6n2CDRvPWE+7EDACfusH7NfViiPR/3ZGqnHHIIEDRBeOoGfzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928180; c=relaxed/simple;
	bh=p7Hur+ZLTgSQNp7dSnaF30I5DS+Sq/MFqFTWXOZW21k=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUD7EFM6S9hbJ3eMKgh8LeWv8siBnH7i7X58SJrACA5oIsgXDLTWbn83wpQky3qUM/Bqd1vkORM5cnqGYd1IW/6woW5BRfuEQ9KOapZoTgL5syJUtorkHCumFkgZP2AaGUfQHb+ie6uN3hayJUVymd/cTsZJYgtm+RrUJpp3eNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2i13CEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D7C2BC87
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771928180;
	bh=p7Hur+ZLTgSQNp7dSnaF30I5DS+Sq/MFqFTWXOZW21k=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=J2i13CEQ+Em64sZc2ce5aHPCYCMLB9EOZonejhWsu2QqJh+kDGoBGljLLKSK1Z3ig
	 vwV6LVUIZt5VuKDPzg2cKsZPNldl9vImMw3+54HH0jbtnZavg5iMDyC70H70AlUq16
	 bZNCY9/zIE9upPytFggL4FxUjVmlTGS9tf9uvFRkNwLo2Gab6SYVpTBOxN4N92jv5A
	 F9pGHslex/NI8vSXtozdZJfNAmPDobMUSKAmz013q8P1ptJqmOF1S09HcBdRzqrdYP
	 JlZlTxSx/rSASoMvCkc54z3qgesNroo7b56hbKd3ilvdJX8DIfFtzCKREsYOn4acX+
	 F3kdl3dnyGevA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e4a04f059so6608573e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 02:16:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV73ZmT+Cj+BiN9gtNgEmGzLb4tHgwwCe5YLdAkPcE1VU5Vk+O3C+ftF3Tp4HtZwQCLGuemNbYlYJto@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfcvo9Vku07OJgsSVsmzC0g+inItWlD/lhBScTjCwLEWDhpuw/
	ELp8ZPBFUo5XHYrKRXbUrAyqjpcY/Ro680UeHFa6TR7sPopSB1HykNPpPDDE7xbukzgRlYO74LX
	FTsBGscxLoM0FXvIAZxAX6R0Xeq5aLUlc2llufYf9xQ==
X-Received: by 2002:a05:6512:3f16:b0:59e:44fd:8047 with SMTP id
 2adb3069b0e04-5a0ed8a5360mr3968763e87.28.1771928178627; Tue, 24 Feb 2026
 02:16:18 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 02:16:17 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 02:16:17 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260224-pci-m2-e-v5-2-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com> <20260224-pci-m2-e-v5-2-dd9b9501d33c@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 02:16:17 -0800
X-Gmail-Original-Message-ID: <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
X-Gm-Features: AaiRm52E9GG7sUX8QY-OJorqLhZbSTriYRV39ykZ2pMd-1A19dZUhSz2lCghp98
Message-ID: <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21121-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linaro.org,oss.qualcomm.com,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,manivannan.sadhasivam.oss.qualcomm.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2AA121853AE
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 06:30:48 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add of_find_serdev_controller_by_node() API to find the serdev controller
> device associated with the devicetree node.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/tty/serdev/core.c | 19 +++++++++++++++++++
>  include/linux/serdev.h    |  9 +++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 8f25510f89b6..bf88b95f7458 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -514,6 +514,25 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
>  }
>  EXPORT_SYMBOL_GPL(serdev_controller_alloc);
>
> +#ifdef CONFIG_OF
> +/**
> + * of_find_serdev_controller_by_node() - Find the serdev controller associated
> + *					 with the devicetree node
> + * @node:	Devicetree node
> + *
> + * Return: Pointer to the serdev controller associated with the node. NULL if
> + * the controller is not found. Caller is responsible for calling
> + * serdev_controller_put() to drop the reference.
> + */
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> +
> +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);

I'm not sure if I commented on it before but there's no reason for this to be
OF-centric. It would work equally well as (I think the same should keep the
"serdev" prefix too for correct namespacing):

struct serdev_controller *serdev_find_controller_by_fwnode(struct
fwnode_handle *fwnode)
{
	struct device *dev = bus_find_device_by_fwnode();

	...
}

It would be more flexible and users can always use to_of_node().

Bart

> +#endif
> +
>  static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  {
>  	struct device_node *node;
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 0c7d3c27d1f8..188c0ba62d50 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -334,4 +334,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
>  }
>  #endif /* CONFIG_ACPI */
>
> +#ifdef CONFIG_OF
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
> +#else
> +static inline struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  #endif /*_LINUX_SERDEV_H */
>
> --
> 2.51.0
>
>
>

