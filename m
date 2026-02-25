Return-Path: <linux-acpi+bounces-21153-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIxAEZ7bnmkTXgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21153-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:23:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EC196626
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2844F3040FBE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049E394468;
	Wed, 25 Feb 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaRacXYw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65E393DD3
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018574; cv=none; b=llSxDP2z8K2YkI4A73ORqNB8sJf2r4jnG3Yg5RU+ZYYGQPVib9ifGf2RUdvtYsFUWn+/nMvBz8uuXpQATNhOTKWIjLGsA7gF40agWPswmbGp7oTDw7ZKEAup2ggBRFPj0nPnsr+20h8ELJwuR2TeQNLp6TY5yZmVXqLtwcYyK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018574; c=relaxed/simple;
	bh=6gev5tZqUw00NLGRGzGj1w6G1r7M37S8MzU31Ep9P3c=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhxEb6Bo4l60Cp1UEfuJ61MAbHD4RyEKXzd/48EkyNsWs0i0TwmmAL62gZRqqPB4SNw0bBIKAOFksimBJiimULO1lYfeLV+D3/cqIIv+qaDVge8431dRiE6Og+3DmzXR8QIzeWbQvkfUp1xwVUM/IORZHuiZRnTB8bhod6G+aR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaRacXYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A86C2BCB3
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018574;
	bh=6gev5tZqUw00NLGRGzGj1w6G1r7M37S8MzU31Ep9P3c=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=WaRacXYwBEbkSqFnb09HqJI8/90YgW1HTGqdQiaAlv2yd7eCoDinW+Oj4IwkPKsDY
	 LFfX1TX5a5CAuN+cu2tJ1G7N6aMRD7dnUqxgvpksCBQ7R6cEWKyTOO9YIbUTQEpDRB
	 D7TFtEJNAMVvKTGgZ7H2rUC0dPf6Zap+wJMUrzPe9h2ZjhriDOAJJ3o7r7JMe3a1Fe
	 BEFzbAAUmwV+HgmiEpS/K/733VIZwgEMNacF9T+xAGLjQdlF2WVt43F9FJt0eisMpd
	 Y5ZBh+uA0ro6birUuESD8EclhzzWezKSAydu/YQWH0bbWU5hgp7svPLI2TZlpjn5VP
	 c23oiYayZRYfg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e607a3824so7249792e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 03:22:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4de5zhWM9gnvGIyTmly0OFPrJlFRQt3xg9qi897L/q54K+UNTynBr0owSFY7YRfxTj68yKPV+3yeF@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXvmyBAvndofdBaMu8xggddwko28GagpQ2IZMOKR9ih6mRGUT
	q9F3vpXQe9X2uAFiN3c5vCF7d1m4ymy/X7xRXKTaRYfW8JJhIYpWoJwP4Il0ZZjygLJMZsvdvZM
	SKQ8N1r4x8unR5pHPb8K85WqUYdW90r2tqmjYLv0suw==
X-Received: by 2002:ac2:4e13:0:b0:59f:7a22:fae with SMTP id
 2adb3069b0e04-5a0ed9bc6demr5028853e87.43.1772018572919; Wed, 25 Feb 2026
 03:22:52 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 03:22:51 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 03:22:50 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260224-pci-m2-e-v5-9-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com> <20260224-pci-m2-e-v5-9-dd9b9501d33c@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 03:22:50 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeJP-BLf3_zM9b+nz1nMOGVzyUhXemejHkV+AJREGPz_w@mail.gmail.com>
X-Gm-Features: AaiRm52oa36SxdO2esRz0tZiEY1x2dCziUGws1cBwrcfkRk5CfGY9pNkO3m4CZg
Message-ID: <CAMRc=MeJP-BLf3_zM9b+nz1nMOGVzyUhXemejHkV+AJREGPz_w@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21153-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,oss.qualcomm.com,kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,manivannan.sadhasivam.oss.qualcomm.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 053EC196626
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 06:30:55 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> For supporting bluetooth over the non-discoverable UART interface of
> WCN7850, create the serdev device after enumerating the PCIe interface.
> This is mandatory since the device ID is only known after the PCIe
> enumeration and the ID is used for creating the serdev device.
>
> Since by default there is no OF or ACPI node for the created serdev,
> create a dynamic OF 'bluetooth' node with the 'compatible' property and
> attach it to the serdev device. This will allow the serdev device to bind
> to the existing bluetooth driver.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>

[snip]

> -static void pwrseq_pcie_m2_free_regulators(void *data)
> +static void pwrseq_pcie_m2_free_resources(void *data)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = data;
>
> +	serdev_device_remove(ctx->serdev);
> +	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
> +	of_changeset_revert(ctx->ocs);
> +	of_changeset_destroy(ctx->ocs);
>  	regulator_bulk_free(ctx->num_vregs, ctx->regs);
>  }
>
> +static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
> +					struct device_node *parent)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ctx->ocs = devm_kzalloc(dev, sizeof(*ctx->ocs), GFP_KERNEL);
> +	if (!ctx->ocs)
> +		return -ENOMEM;
> +
> +	of_changeset_init(ctx->ocs);
> +
> +	np = of_changeset_create_node(ctx->ocs, parent, "bluetooth");
> +	if (!np) {
> +		dev_err(dev, "Failed to create bluetooth node\n");
> +		ret = -ENODEV;
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_add_prop_string(ctx->ocs, np, "compatible", "qcom,wcn7850-bt");
> +	if (ret) {
> +		dev_err(dev, "Failed to add bluetooth compatible: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_apply(ctx->ocs);
> +	if (ret) {
> +		dev_err(dev, "Failed to apply changeset: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = device_add_of_node(&ctx->serdev->dev, np);
> +	if (ret) {
> +		dev_err(dev, "Failed to add OF node: %d\n", ret);
> +		goto err_revert_changeset;
> +	}
> +
> +	return 0;
> +
> +err_revert_changeset:
> +	of_changeset_revert(ctx->ocs);
> +err_destroy_changeset:
> +	of_changeset_destroy(ctx->ocs);
> +

I would prefer pwrseq_pcie_m2_free_resources() to be split into separate
devm actions, otherwise it's not much different from simply having the
.remove() callback. With a split like that you'd avoid having these labels
here.

Otherwise looks good.

Bart

