Return-Path: <linux-acpi+bounces-21113-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQ7FuhRnWkoOgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21113-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:23:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038A182F5A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7075303FAAD
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275B364049;
	Tue, 24 Feb 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g76zi9AW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809124E4A8;
	Tue, 24 Feb 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917628; cv=none; b=MDIXz+BRQJiwo3HozFhmAHq00XWeitH5uXV18+Q7nr8X+njpiO15CTvuFuCzGPLCUpv/MxICKEmu/kXPPE1/LY9NMPwoq8yUEC/mmgE0JS1Jy27HQcqt2G+jBXi3kUKVIWRXEY6YScIpTA7zQUvjSqdYbTTmYzZCeyBwcGy8XGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917628; c=relaxed/simple;
	bh=kBzq8KMP7val1p5xI4CESezdEo4yOCLfz3X2Wfw1N4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCz28axzIQaMk22xEgBPAr6SMlZYHfzA8P9RK9DRJLVaT2vjMyvPX5bT2q15IPVoR4RgLn1Tx67Eibu8SLiilvPFXB45+7jfIAFD1Lv4YaquzttATKUv8FhKbivZyp7Y1+P2LAtsntV0qYm8//6/3dNdEPmuh8nRuBK4OJrbADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g76zi9AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83940C116D0;
	Tue, 24 Feb 2026 07:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771917627;
	bh=kBzq8KMP7val1p5xI4CESezdEo4yOCLfz3X2Wfw1N4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g76zi9AWaRL22GcB1ov0eE6v8L3z27l5KSQVxeYxuwnYTUnNyZV+r8nQ18i5UNkQT
	 WtzSVuqWUfwQ6Sn9ss27TRukoIpX9ej9mbrynGIO5gZ0IXxlejfFHQHonGz8HmjFan
	 wXdIAkhfDzAQbjgQdE0Rn6PPfsPn4CCHnnycTLzfenzeO2V/7S76/WxZTppa6FIMra
	 g8Lx9hcvEnaJtjnw1GCPhMWDs4CmEdci7audwJ/s/d/ckb2jnSWuTR0c6jmF/cwJb+
	 cmCsSRMlw/Aj1kPVs8RU5HY3IibTQPJVedU5E7yFeNkSQIbaWfOghfZbD8ScVv64Y1
	 hG5Kvo5fmiQXg==
Date: Tue, 24 Feb 2026 12:50:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/9] dt-bindings: serial: Document the graph port
Message-ID: <z42xyou35nuyt2f3rxxzzndleir66w3nxeidjmgxg6l4uem6st@fj473jdiau3p>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-4-dd9b9501d33c@oss.qualcomm.com>
 <20260224-peacock-of-improbable-poetry-b4cfdc@quoll>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224-peacock-of-improbable-poetry-b4cfdc@quoll>
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
	TAGGED_FROM(0.00)[bounces-21113-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl,vger.kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 0038A182F5A
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:09:17AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Feb 24, 2026 at 11:00:50AM +0530, Manivannan Sadhasivam wrote:
> > A serial controller could be connected to an external connector like PCIe
> > M.2 for controlling the serial interface of the card. Hence, document the
> > OF graph port.
> > 
> > Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
> 
> Please drop. The binding is not being sent to the device during testing,
> thus it is impossible to test it.
> 

b4 picked it up since the tag was given in the cover letter and I forgot to
remove it while sending.

If I happen to send next version, I will drop it from all bindings patches.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

