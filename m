Return-Path: <linux-acpi+bounces-21356-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HoFKbeAqGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21356-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:57:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E0206B8F
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1543A3045279
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C43DA5A0;
	Wed,  4 Mar 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkkSdw8G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBA3DA5B0;
	Wed,  4 Mar 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650553; cv=none; b=LCWXDPgXvcrUpUtEpl9VQ4V4GNZsChw+mRvfeXaqcDRojLSbiP554rO8gzSjuUSW3w6ZufMOEUkarKLgEal+6/CAPG45/c9EaRfsPhp2vPeAs8fyfgJURRdkLqAP0aPJOk1CQQ0Nele79xQKAhk24cUCvE57Jp8TJMR7WfVr3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650553; c=relaxed/simple;
	bh=Al62TdymjzPb85apT20XaFb3FDGpi7ZZpgnUuu8131A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiZ5dG0xuprHwp1O6LyoNzkONJijBYnmzdKts7u8ixV8qgAzj80+jObNeFBuGaqHph4c15YMTn4DCUiWHUs+YfXv19geLQfMIFqIbbBh/xqCX0WyaPbBiqQfvsg+yYon5UqW5Pfl28/nCnfzlCVZz4Ql4g0SGRDN9UDbql/2Q2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkkSdw8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE30EC2BCB0;
	Wed,  4 Mar 2026 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650553;
	bh=Al62TdymjzPb85apT20XaFb3FDGpi7ZZpgnUuu8131A=;
	h=From:To:Cc:Subject:Date:From;
	b=pkkSdw8GRaRyPfAZihkn/e31NtlfyOFXZSEZ+WABTBEOAXNhW8OxEn/1qzmc+UWQJ
	 Wt1Hv/WRgqEPhRfS2SaVdZxIE/zcitB0xZALFkkno0Nu/PCLJlcq11N/MnIQQFWBHb
	 G2xQx3Wso21o823ricw+GTDsMoLvfnmBHMCe1iFfQKmy0CHTh7TI2qUiFfUgyXY8Jm
	 /PPG1Ywf1GeChRSGpvdCuSPfKAdPP2lTLhixy1LmloCkGi3OV6reYkd6yd87QpHmO9
	 WX/cFo3Z9Av6Uc+gqY+vMQhh/7Yn/hwEow7UnCtNMUdIPTqzDMu6SjcSI58AVYjWuW
	 qFIyi1KRaBqUg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 0/3] platform/surface: surfacepro3_button: Use platform device for
 driver binding
Date: Wed, 04 Mar 2026 19:53:24 +0100
Message-ID: <2909929.BEx9A2HvPv@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0E1E0206B8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21356-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi All,

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the Surface Pro3 button
driver.

Patch [1/3] Fixes a wakeup source leak on driver removal.

Patch [2/3] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [3/3] converts the driver to using struct platform_driver for device
binding.

Thanks!




