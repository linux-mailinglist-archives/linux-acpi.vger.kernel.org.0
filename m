Return-Path: <linux-acpi+bounces-21500-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO3/HrMEq2nDZQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21500-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 17:45:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C42254FA
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0936B3009B35
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068133ECBDA;
	Fri,  6 Mar 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUnks1Ze"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F52BEC27
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815219; cv=none; b=rT+QLaV3RH2HklsU+DI1LqT8+q2aujwSqiJtHfegLvQGMaw9goZhOwdsN5943OzWC39ZeX8N/ecNtwplaoHcHuuOtgsHZSYxDT3+hZkd5uHuVe09cbp0SiL1laU8mN4H0Uu9ggEkfqBAWlOEQZr2A6FcC95pldGMggERiOgoaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815219; c=relaxed/simple;
	bh=RU95RNdDOAf5TJ6YGt0G7xFdwtFU4agv19bQzXaGAWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSPpeYgpMt4wjjjhAdRP7wJGNQ/uBTHCLXKuvedOFI+eWeBHg5vqtQTzvO2XKkal7+p4FZ6lhpLtbXPIJIHA7qpA/bghbW1Rn+3nrpm4n1fWRRA9fOftPIjR0jpxxftTrQ1/3kNeaVSLgf3sqhsske8qRUolTz2eQbq2ajTkCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUnks1Ze; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be3bdfda8eso2557491eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772815218; x=1773420018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTEKjkr+py4vbKoL17aEQA2Z7Rzut4TnqzUYs6TIXhM=;
        b=iUnks1ZeYLeqyMgpEu0nqRN9hCwcM0jl97l55thW/AMslUwm1VvZ7x1W+Idrx5fYqu
         +84fB2y/S/7fFJa53nFI43HZ/dqUm2J0pZtSBoRCLpF/X9RMOoH2BhUEQ5gAFthwT3XV
         CqjsAkPu7HU8EbsYkRJ29uqz+ZMyfU9lc35GkhMOyKZrHgIeh3wX70OEAf8eurfFtW2k
         4khoUbQZZQ0iH47nm8sFGYzrJf7OKpspkajonNTmW6dL5IA5V06c+hyPxIE+f0UNxEJ3
         4VAhM49vhm0pTJs/wN79tBjsqVoDodFP+/QeZRzAZrKeWkel+2N+JI8ps1xZOrTL2fEa
         JMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772815218; x=1773420018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTEKjkr+py4vbKoL17aEQA2Z7Rzut4TnqzUYs6TIXhM=;
        b=MKlMAhUiVBnGBajjLnN65SkQ8vLPz3X5uvGSd8XXX0l0jSiYWRjAY/XidfRyI5pEn7
         ArIHgIp1WgpDjhUyGuLeLjt5C9DRNonSqx2HJhcwZr10PElbOMTBciqgujqBvAiRaV3O
         5NBEpIs3ZAviDj+tysqwvFW34g+ZrjCXCauTemu6KoDiGxj0r0d5I89o+bRwxYylwycM
         HrclNLUl281slzfUjeZXMsE2sYL0yEHbyZz3CvaFdfPGYKMc8SWrvishZnCJ1smDkZmn
         VkviQQfPzm3KwCBPoHegkduItUtNRhUzIjIP+IuYGSAYe+GS+hWivV12zkDWMNGruxjg
         okeg==
X-Forwarded-Encrypted: i=1; AJvYcCUFBZ+Q33xwcTGpBwzUZLrhJJTguVzswE3MajwanJVDNK229yLs0JJEuIO/wi0+NWXGY6L9omxwJ6JM@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRgDFTFJH1lI/tZnTTOrU/3ocUcLuMV75xqKEBD3uayUwSUvb
	+gn5azDj2D/kJvjOZ2m5xyxItZzhMwsAAXQzzSvYwOwuUj5139GSRSKh
X-Gm-Gg: ATEYQzwmssARuBiYEBOE7cefQkHrfBssbM1IYuZkG2S1D66i3Vod8Zqi3sewR0yBzRN
	jQY59PsD6uOIblJVAqEqkxNMJ9YdB/XnczJnoBcynB5uXhtvHuSVz8hxkKoS+sx8Jcd7MAXYMTE
	BW/GkVG+cgx99PHBBt6j463XHHDuC5e3Ix4lPKBBrWq/5xODqQFKbQfU8+GyaVpM7viQBzYVCzY
	GnvGG8/Me7/pcG4wSHEmmuxL4aGNBXaVIk+aaV2oMct6evcF/NYVnYa6ScgbUyBGoVqHkqUM9vt
	OjRE2LIJBd+fOvv/0yUQuS5kTkemcxSAZlo/kWwEWavQE6UbZ3qWQFWIAepBK5m2W4IPZPFOA9c
	d/+gCaqBAIFKYcLMD8JE3THonqXWMxBDnqljObZ/7Rf6ppgotp0xEBRY0LR140G0bRd4R9UL8fl
	pDVJBaicCrhqkXMrQ0F97zYKGJEPD/m0oFsYLT
X-Received: by 2002:a05:693c:6099:b0:2be:2b8d:3992 with SMTP id 5a478bee46e88-2be4de65221mr814876eec.4.1772815217782;
        Fri, 06 Mar 2026 08:40:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80d72esm1728236eec.4.2026.03.06.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:40:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 08:40:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-hwmon@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: (asus_atk0110) Convert ACPI driver to a
 platform one
Message-ID: <7ff14a0d-ffb9-4258-9b1a-1fff0021d19e@roeck-us.net>
References: <3691136.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3691136.iIbC2pHGDl@rafael.j.wysocki>
X-Rspamd-Queue-Id: BA0C42254FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21500-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:26:52PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the asus_atk0110 ACPI driver to a platform
> one.
> 
> After this change, the subordinate hwmon device will be registered under
> the platform device used for driver binding and messages will be printed
> relative to that device instead of its ACPI companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter

