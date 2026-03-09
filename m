Return-Path: <linux-acpi+bounces-21563-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J3zOXr/rmkLLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21563-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:12:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC0523D704
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 757BB3020A47
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E363E95BA;
	Mon,  9 Mar 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUldo0Wj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2F3E715B;
	Mon,  9 Mar 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076306; cv=none; b=ivm25lRx4Mb6ld4WT8qCp1Teo0kycDZ9ZQDonQaY6ClsOzs8Eja+4deETCVWaMCVGM2byMWAdZvKHzptlMm/RLi516qFqVWW8+PBdxwurC0yjzpEwW8WC6S7F8tKQ6sWynF+ZifYTPEaaL8fzhuab98r8xiKKiu9ytftoI9ok0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076306; c=relaxed/simple;
	bh=TnPcjvTH4AeKC1qkyLrDhJZVgcEJNaHU3ank3Df4i2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hee0x8z2Ji/psYsmyD4yA/HeWwQLcCT48YA58sWeepqvfmrvZeduUWenSroS0CwtdRsWuFxhgacyBDZrqHhw7nDVx6283dV3EytkdabAbyzBNcscPOZAzRZxFA8n8FRnh7VhUpLCd8fbq6GKeKCjS84IELawXAGyCgUP0eD8S0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUldo0Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC12C19423;
	Mon,  9 Mar 2026 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076306;
	bh=TnPcjvTH4AeKC1qkyLrDhJZVgcEJNaHU3ank3Df4i2c=;
	h=From:To:Cc:Subject:Date:From;
	b=FUldo0WjTE0QMFB6haPEUjk33WuajK4Bum8A54KazblHjfFVA28+W5WDOLSg5ncVM
	 eeEQWh8mKG4wDhxhGpgoXz0jvRFjKNKsSQfMp6jPCepSZ0MLMrRKJ7oCaJtYju8xgt
	 P7cFvmhWOTVQ4Zr4m+fLDmEJg8cA85iHX6Zr0DZiZdkVAX0M0HjScT0UUbsGAhhjN9
	 QeZv1vp/H+X46O6YWuwXfizyocGo4A/gGhBymT9sUUvgvAWyHDZO+MsE3YMhz04m7O
	 L+HDIe8syXbDq69opDlx4/ldLeM4E55auMKqr12EFd5pGptwZv0RxWD/l42McQRrV1
	 W8aGvCXI4WW5w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 0/5] platform/x86: fujitsu: Bind drivers to platform devices
 instead of ACPI ones
Date: Mon, 09 Mar 2026 18:03:02 +0100
Message-ID: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8FC0523D704
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21563-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

Hi All,

This is an update of

https://lore.kernel.org/linux-acpi/1968442.tdWV9SEqCh@rafael.j.wysocki/

that fixes an error code path issue in patch [3/5].  That change also
requires patch [5/5] to be modified, but the other patches are the same
as in v1.

The patch series summary below still applies.

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversions of the platform x86 drivers
for Fujitsu platforms.

Patch [1/5] converts the fujitsu-tablet to a proper platform one based
on the struct platform_driver interface.

Patch [2/5] rearranges the code in the fujitsu-laptop driver to avoid
introducing forward declarations of some functions in the subsequent
patches.

Patch [3/5] updates the fujitsu-laptop driver to install ACPI notify
handlers by itself instead of using .notify() callbacks from struct
acpi_driver, which is requisite for the driver conversion.

Patches [4-5/5] replaces two instances of the struct acpi_driver
interface in the fujitsu-laptop driver with struct platform_driver.

Thanks!




