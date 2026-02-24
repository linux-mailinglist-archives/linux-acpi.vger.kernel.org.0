Return-Path: <linux-acpi+bounces-21110-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP/pA85OnWkROgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21110-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:10:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1BB182C64
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584FE3072649
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 07:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76030BBB9;
	Tue, 24 Feb 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOZlD083"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D711494C3;
	Tue, 24 Feb 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916902; cv=none; b=JyxmjNEpei/49sntIhQhGOFnDm5JkxEwawjgFJmzzJ3U0Bgtt+THWh+XT79DfkLQrQIdiX3vP3tJK/rOQx7M5IGsSycHe9YJxL1aExMxgKoy791ywyu4MFsCM/CEMDnJ21VKjGTO2qRDW360eID/9ppOkvxhkwf2HL3NNfiB67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916902; c=relaxed/simple;
	bh=siLJw2A0f62cJlgh+YOYFnZcJEatTZTiHAV7JLbKcWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caet5Idv9zVC9L2Q58v7VW9rFYCDe2pbf/6Mybq8rFgho2RYoDOKr/chdsLbV0yvWArGK89XkxWoYiF3+oaxpyXlgyTYrI1/eAB5TI8HClEt4SId5jJlxjRKMMwgywiqQA39n7QtA4adNvqb5WmTbBwLCwczlFcG73mnWR2TUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOZlD083; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FF9C116D0;
	Tue, 24 Feb 2026 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771916902;
	bh=siLJw2A0f62cJlgh+YOYFnZcJEatTZTiHAV7JLbKcWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOZlD083B/DGOpAprjcHeUB65aH90SMO89jFdeFYasoxgqZ4vd42DgnnJccFivv7r
	 QOQp2JBzvjBjvi3lLzOGgOQwjwsIkVOF2ijRmBhuPyduOIGl/o+gKevb7Jyln96CYD
	 bZDnRoEYjgHP6/jIxkp0AVc1f4IFOvJ7EY1S4dNOmvWwweyD9P7P5AFE9FpoMttzm7
	 7XHW6yVEXqYUrGh6dcOQ5EUXpwvFKQbULLmPlUbLixxaZ+0OAQZGUyjixjQdEfOXWI
	 1OdcBK0aGbEW6a5jdobGaHGvdMIEbyqLvUMCtMEj8ZWsao+AqoVWjjy371bTj8e00Y
	 e+lNzjZoqCsdA==
Date: Tue, 24 Feb 2026 08:08:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <20260224-bold-dalmatian-of-weather-d86259@quoll>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-6-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224-pci-m2-e-v5-6-dd9b9501d33c@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21110-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl,vger.kernel.org,linaro.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9F1BB182C64
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:00:52AM +0530, Manivannan Sadhasivam wrote:
> Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> spec, it looks very similar to the M.2 Key E connector. So add the
> "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> to reuse the Key E binding.
> 
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)

Please drop. You cannot test a binding. It's IMPOSSIBLE.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Best regards,
Krzysztof


